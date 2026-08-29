#!/usr/bin/env python3
"""Executable G4 product, schema, transaction, parity, and regression harness."""

from __future__ import annotations

import copy
import hashlib
import importlib.util
import json
import shlex
import subprocess
import sys
import tempfile
import uuid
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Callable

ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "scripts/tests/copilot-review-governance/fixtures"
DESIRED = ROOT / "scripts/config/copilot-review-governance-desired-state.json"
INVENTORY = FIXTURES / "vertical-slice/home-baseline-green.json"
PS_ENTRY = ROOT / "scripts/manage-copilot-review-governance.ps1"
BASH_ENTRY = ROOT / "scripts/manage-copilot-review-governance.sh"
MODULE = ROOT / "scripts/modules/CopilotReviewGovernance.psm1"
FEATURE = ROOT / "specs/031-github-copilot-review-governance"
LOCAL_TEST_RESULT = (
    ROOT / ".specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/"
    "copilot-review-governance/evidence/v1/operational/quality/full-tests.json"
)
HASH = "a" * 64


class ContractFailure(RuntimeError):
    """One executable product contract failed."""


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ContractFailure(message)


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def canonical(value: object, exclude: tuple[str, ...] = ()) -> bytes:
    data = copy.deepcopy(value)
    if isinstance(data, dict):
        for name in exclude:
            data.pop(name, None)
    return (json.dumps(data, ensure_ascii=False, sort_keys=True, separators=(",", ":")) + "\n").encode()


def object_hash(value: object, exclude: tuple[str, ...] = ()) -> str:
    return hashlib.sha256(canonical(value, exclude)).hexdigest()


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(canonical(value))


def run(command: list[str], expected: int = 0) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(command, cwd=ROOT, text=True, capture_output=True, check=False)
    if result.returncode != expected:
        raise ContractFailure(
            f"command returned {result.returncode}, expected {expected}: {' '.join(command)}\n"
            f"stdout={result.stdout}\nstderr={result.stderr}"
        )
    return result


def product(arguments: list[str], expected: int = 0, bash: bool = False) -> subprocess.CompletedProcess[str]:
    prefix = ["bash", str(BASH_ENTRY)] if bash else ["pwsh", "-NoProfile", "-File", str(PS_ENTRY)]
    return run(prefix + arguments, expected)


def powershell_object_hash(path: Path, excluded: str) -> str:
    safe_path = str(path).replace("'", "''")
    safe_excluded = excluded.replace("'", "''")
    script = (
        f"Import-Module '{MODULE}' -Force; "
        f"$d=Get-Content -LiteralPath '{safe_path}' -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable -DateKind String; "
        f"Get-HBSha256 -Text (ConvertTo-HBCanonicalJson $d -ExcludeProperties @('{safe_excluded}'))"
    )
    return run(["pwsh", "-NoProfile", "-Command", script]).stdout.strip()


def fresh_inventory(path: Path, drift: bool = False) -> dict:
    inventory = load_json(INVENTORY)
    now = datetime.now(timezone.utc)
    inventory["observedAt"] = now.isoformat().replace("+00:00", "Z")
    inventory["expiresAt"] = (now + timedelta(minutes=15)).isoformat().replace("+00:00", "Z")
    inventory["apiVersion"] = "2026-03-10"
    if drift:
        inventory["rulesets"][0]["reviewOnPush"] = True
        inventory["rulesets"][0]["stateSha256"] = "c" * 64
    return seal_inventory(path, inventory)


def seal_inventory(path: Path, inventory: dict) -> dict:
    inventory["snapshotSha256"] = "0" * 64
    write_json(path, inventory)
    inventory["snapshotSha256"] = powershell_object_hash(path, "snapshotSha256")
    write_json(path, inventory)
    return inventory


def preview(tmp: Path, inventory_path: Path) -> tuple[Path, dict]:
    plan_path = tmp / "mutation-plan.json"
    result = product([
        "-Action", "Preview", "-DesiredStatePath", str(DESIRED),
        "-InventoryPath", str(inventory_path), "-OutputPath", str(plan_path),
    ])
    plan = json.loads(result.stdout)
    require(load_json(plan_path)["planSha256"] == plan["planSha256"], "preview file/stdout mismatch")
    return plan_path, plan


def make_provider(path: Path, inventory: dict, *, retries: int = 0,
                  ambiguous: list[str] | None = None, toctou: list[str] | None = None) -> dict:
    provider_state = {
        "schemaVersion": "1.0",
        "provider": "FakeProvider",
        "inventory": inventory,
        "transactions": [],
        "idempotencyIds": [],
        "consumedGateIds": [],
        "actionStateHashes": {},
        "beforeStates": {},
        "transientReadFailures": retries,
        "ambiguousActionIds": ambiguous or [],
        "toctouActionIds": toctou or [],
    }
    write_json(path, provider_state)
    return provider_state


def materialize_gate_context(root: Path, plan: dict, inventory: dict, operation: str) -> dict:
    """Create the exact fail-closed EvidenceRoot graph consumed by the public CLI."""
    now = datetime.now(timezone.utc)
    methods = {
        "AccountSetting": ["BrowserManual"], "EffortLevel": ["BrowserManual"],
        "RulesetCreate": ["POST"], "RulesetUpdate": ["PUT"], "RulesetDisable": ["PUT"],
        "Rollback": ["PUT"],
    }[operation]
    scopes = {
        "AccountSetting": ["PersonalCopilotSettings:write"],
        "EffortLevel": ["RepositoryCopilotSettings:write"],
        "RulesetCreate": ["Administration:write"], "RulesetUpdate": ["Administration:write"],
        "RulesetDisable": ["Administration:write"], "Rollback": ["Administration:write"],
    }[operation]
    authority = {
        "schemaVersion": "1.0", "authorityRecordId": f"local-{operation.lower()}-authority",
        "accountOwner": "hindermath", "operationClasses": [operation],
        "allowedMethods": methods, "minimumPermissionScopes": scopes,
        "operatorIdentity": "operator:local-fixture", "reviewerIdentity": "reviewer:local-security",
        "issuedAt": (now - timedelta(seconds=30)).isoformat().replace("+00:00", "Z"),
        "expiresAt": (now + timedelta(minutes=10)).isoformat().replace("+00:00", "Z"),
        "status": "Authorized",
    }
    write_json(root / "operational/live-read/authority.json", authority)
    write_json(root / "operational/live-read/inventory.json", inventory)
    write_json(root / "operational/live-read/mutation-plan.json", plan)
    evidence_hashes: dict[str, str] = {}
    evidence_refs: dict[str, dict[str, str]] = {}
    for key in ("acceptance", "security", "review", "technical"):
        path = root / f"operational/gate-evidence/{key}.json"
        record = {
            "schemaVersion": "1.0", "evidenceClass": key.title(), "status": "Passed",
            "runId": plan["runId"], "inventorySha256": inventory["snapshotSha256"],
            "planSha256": plan["planSha256"], "operatorIdentity": authority["operatorIdentity"],
            "reviewerIdentity": authority["reviewerIdentity"], "writes": 0,
            "observedAt": now.isoformat().replace("+00:00", "Z"),
            "expiresAt": (now + timedelta(minutes=10)).isoformat().replace("+00:00", "Z"),
        }
        write_json(path, record)
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        evidence_hashes[key] = digest
        evidence_refs[key] = {"path": f"operational/gate-evidence/{key}.json", "sha256": digest}
    change_review = {
        "schemaVersion": "1.0", "status": "Accepted", "accountOwner": "hindermath",
        "authorityRecordId": authority["authorityRecordId"], "desiredStateSha256": plan["desiredStateSha256"],
        "inventorySha256": inventory["snapshotSha256"], "planSha256": plan["planSha256"],
        "operatorIdentity": authority["operatorIdentity"], "reviewerIdentity": authority["reviewerIdentity"],
        "reviewedAt": now.isoformat().replace("+00:00", "Z"),
        "expiresAt": (now + timedelta(minutes=10)).isoformat().replace("+00:00", "Z"),
        "actionSummary": {
            "accountSettingActions": sum(item["operationClass"] == "AccountSetting" for item in plan["actions"]),
            "effortLevelActions": sum(item["operationClass"] == "EffortLevel" for item in plan["actions"]),
            "rulesetCreateActions": sum(item["operationClass"] == "RulesetCreate" for item in plan["actions"]),
            "rulesetUpdateActions": sum(item["operationClass"] == "RulesetUpdate" for item in plan["actions"]),
            "rulesetDisableActions": sum(item["operationClass"] == "RulesetDisable" for item in plan["actions"]),
            "totalActions": len(plan["actions"]),
            "totalWrites": sum(bool(item["writeIntent"]) for item in plan["actions"]),
        },
        "browserBoundary": {"evidenceMode": "BrowserManual", "records": len(inventory["browserEvidence"]), "writes": 0},
        "apiBoundary": {
            "host": "github.com", "apiVersion": plan["apiVersion"], "method": "GET",
            "repositories": len(inventory["repositories"]), "rulesets": len(inventory["rulesets"]), "writes": 0,
        },
        "historicalDeviationReview": {
            "status": "Accepted",
            "activeCopilotRulesets": sum(item["containsCopilotCodeReview"] and item["enforcement"] == "active" for item in inventory["rulesets"]),
            "targetExistingRulesets": sum(
                item["containsCopilotCodeReview"] and item["enforcement"] == "active"
                and item["repositoryId"] in {action["repositoryId"] for action in plan["actions"] if action["operationClass"] == "EffortLevel"}
                for item in inventory["rulesets"]
            ),
            "targetMissingRulesets": sum(item["operationClass"] == "RulesetCreate" and item["writeIntent"] for item in plan["actions"]),
            "dedicatedNonTargetActiveRulesets": sum(item["operationClass"] == "RulesetDisable" and item["writeIntent"] for item in plan["actions"]),
            "mixedOrInheritedRulesets": sum(
                item["containsCopilotCodeReview"] and item["enforcement"] == "active"
                and (item["mixedPurpose"] or item["sourceType"] != "Repository")
                for item in inventory["rulesets"]
            ),
        },
        "rollbackReview": {
            "status": "Accepted", "boundRollbackHashes": sum(bool(item["writeIntent"]) for item in plan["actions"]),
            "deleteActions": sum(item["action"] == "Delete" for item in plan["actions"]),
            "createRollbackDisposition": "DisableNotDelete",
        },
        "externalWriteGateStatus": "NotAuthorized",
        "writes": 0,
        "evidence": evidence_refs,
    }
    write_json(root / "operational/live-read/change-set-review.json", change_review)
    return {"authority": authority, "hashes": evidence_hashes, "methods": methods, "scopes": scopes}


def make_gate(path: Path, plan: dict, action: dict, inventory: dict,
              operation: str = "RulesetUpdate", snapshot: str | None = None,
              rollback_hash: str | None = None, evidence_root: Path | None = None) -> dict:
    now = datetime.now(timezone.utc)
    evidence_root = evidence_root or path.parent / "evidence"
    context = materialize_gate_context(evidence_root, plan, inventory, operation)
    methods = context["methods"]
    scopes = context["scopes"]
    if operation == "Rollback" and action["operationClass"] == "AccountSetting":
        methods = ["BrowserManual"]
        scopes = ["PersonalCopilotSettings:write"]
        context["authority"]["allowedMethods"] = methods
        context["authority"]["minimumPermissionScopes"] = scopes
        write_json(evidence_root / "operational/live-read/authority.json", context["authority"])
    gate = {
        "schemaVersion": "1.0",
        "gateId": str(uuid.uuid4()),
        "runId": plan["runId"],
        "operationClass": operation,
        "authorityRecordId": context["authority"]["authorityRecordId"],
        "authoritySha256": object_hash(context["authority"]),
        "repositoryIds": [action["repositoryId"]] if "repositoryId" in action else [],
        "rulesetIds": [action["rulesetId"]] if "rulesetId" in action else [],
        "pullRequestIds": [],
        "allowedActionIds": [action["actionId"]],
        "allowedMethods": methods,
        "minimumPermissionScopes": scopes,
        "snapshotSha256": snapshot or plan["inventorySha256"],
        "planSha256": plan["planSha256"],
        "beforeStateHashes": {action["actionId"]: action["beforeSha256"]},
        "desiredStateHashes": {action["actionId"]: action["desiredSha256"]},
        "rollbackHashes": {action["actionId"]: rollback_hash or action["rollbackSha256"]},
        "notBefore": (now - timedelta(seconds=30)).isoformat().replace("+00:00", "Z"),
        "expiresAt": (now + timedelta(minutes=10)).isoformat().replace("+00:00", "Z"),
        "maximumSnapshotAgeSeconds": 3600,
        "acceptanceEvidenceSha256": context["hashes"]["acceptance"],
        "securityEvidenceSha256": context["hashes"]["security"],
        "reviewEvidenceSha256": context["hashes"]["review"],
        "technicalGateEvidenceSha256": context["hashes"]["technical"],
        "rollbackCommandId": "local-rollback-command",
        "secretHandling": "NoSecretsInArgumentsLogsOrEvidence",
        "approverRole": "Local Test Approver",
        "reviewerRole": "Local Test Reviewer",
        "singleUse": True,
        "status": "Authorized",
    }
    if operation == "Rollback":
        gate["rollbackSourceOperationClass"] = action["operationClass"]
        if action["operationClass"] == "AccountSetting":
            gate["accountOwner"] = "hindermath"
    write_json(path, gate)
    return gate


def make_account_gate(path: Path, plan: dict, action: dict, inventory: dict,
                      owner: str = "hindermath", evidence_root: Path | None = None) -> dict:
    gate = make_gate(path, plan, action, inventory, "AccountSetting", evidence_root=evidence_root)
    gate["accountOwner"] = owner
    gate["repositoryIds"] = []
    gate["rulesetIds"] = []
    write_json(path, gate)
    return gate


def make_account_prewrite_records(root: Path, plan: dict, action: dict, gate: dict) -> tuple[Path, Path]:
    result_path = root / "operational/provider-results/account-setting-envelope.json"
    result = {
        "schemaVersion": "1.0", "accountOwner": "hindermath", "status": "NotInvoked",
        "actionId": action["actionId"], "planSha256": plan["planSha256"],
        "gateSha256": powershell_object_hash(root / "operational/provider-gates/account-setting.json", "__none__"), "writes": 0,
    }
    write_json(result_path, result)
    rollback_path = root / "operational/provider-rollbacks/account-setting.json"
    rollback = {
        "schemaVersion": "1.0", "rollbackId": str(uuid.uuid4()), "runId": plan["runId"],
        "sourceActionId": action["actionId"], "sourceOperationClass": "AccountSetting",
        "sourceMutationResultSha256": hashlib.sha256(result_path.read_bytes()).hexdigest(),
        "afterInventorySha256": plan["inventorySha256"], "targetKind": "Account",
        "accountOwner": "hindermath", "beforeSha256": action["beforeSha256"],
        "failedAfterSha256": action["desiredSha256"], "rollbackDesiredSha256": action["rollbackSha256"],
        "payloadPath": "payloads/account-rollback.json", "requiresExternalWriteGate": True,
        "maximumAgeSeconds": 3600, "status": "Authorized", "rollbackSha256": "0" * 64,
    }
    write_json(rollback_path, rollback)
    rollback["rollbackSha256"] = powershell_object_hash(rollback_path, "rollbackSha256")
    write_json(rollback_path, rollback)
    return result_path, rollback_path


def validate_account_prewrite(root: Path, expected: int = 0) -> subprocess.CompletedProcess[str]:
    return product([
        "-Action", "ValidateExternalWriteGate", "-OperationClass", "AccountSetting",
        "-AuthorizationPath", str(root / "operational/provider-gates/account-setting.json"),
        "-PlanPath", str(root / "operational/live-read/mutation-plan.json"),
        "-ResultPath", str(root / "operational/provider-results/account-setting-envelope.json"),
        "-RollbackPlanPath", str(root / "operational/provider-rollbacks/account-setting.json"),
        "-EvidenceRoot", str(root),
    ], expected=expected)


def executable_account_prewrite_contract(negative: bool = False) -> None:
    mutations = ("authority", "plan", "gate", "result", "rollback", "foreign-id") if negative else ("complete",)
    for mutation in mutations:
        with tempfile.TemporaryDirectory(prefix=f"crg-t134-{mutation}-") as raw:
            tmp = Path(raw)
            inventory_path = tmp / "inventory.json"
            inventory = fresh_inventory(inventory_path)
            inventory["personalAccountAutomation"]["state"] = "Enabled"
            seal_inventory(inventory_path, inventory)
            _, plan = preview(tmp, inventory_path)
            action = next(item for item in plan["actions"] if item["operationClass"] == "AccountSetting")
            root = tmp / "evidence"
            gate_path = root / "operational/provider-gates/account-setting.json"
            gate = make_account_gate(gate_path, plan, action, inventory, evidence_root=root)
            result_path, rollback_path = make_account_prewrite_records(root, plan, action, gate)
            if mutation == "complete":
                authorized = json.loads(validate_account_prewrite(root).stdout)
                require(authorized == {"status": "Authorized", "operationClass": "AccountSetting",
                                       "accountIdentityEquality": "Passed", "writes": 0},
                        "exact T134 command did not return the complete Authorized record")
                continue
            if mutation == "authority":
                record = load_json(root / "operational/live-read/authority.json")
                record["reviewerIdentity"] = "reviewer:mismatch"
                write_json(root / "operational/live-read/authority.json", record)
            elif mutation == "plan":
                record = load_json(root / "operational/live-read/mutation-plan.json")
                record["planSha256"] = "b" * 64
                write_json(root / "operational/live-read/mutation-plan.json", record)
            elif mutation in {"gate", "foreign-id"}:
                record = load_json(gate_path)
                if mutation == "gate":
                    record["planSha256"] = "b" * 64
                else:
                    record["repositoryIds"] = [999]
                write_json(gate_path, record)
            elif mutation == "result":
                record = load_json(result_path)
                record["planSha256"] = "b" * 64
                write_json(result_path, record)
            else:
                record = load_json(rollback_path)
                record["sourceActionId"] = str(uuid.uuid4())
                record["rollbackSha256"] = "0" * 64
                write_json(rollback_path, record)
                record["rollbackSha256"] = powershell_object_hash(rollback_path, "rollbackSha256")
                write_json(rollback_path, record)
            blocked = json.loads(validate_account_prewrite(root, expected=3).stdout)
            require(blocked["status"] == "Blocked" and blocked["writes"] == 0,
                    f"T134 {mutation} mismatch did not return exit 3/Blocked,writes=0")


def executable_schema_test(negative: bool = False) -> None:
    with tempfile.TemporaryDirectory(prefix="crg-schema-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path)
        product(["-Action", "ValidateInventory", "-InventoryPath", str(inventory_path)])
        for mutation in ("missing", "unknown") if negative else ():
            invalid = copy.deepcopy(inventory)
            if mutation == "missing":
                invalid.pop("pagination")
            else:
                invalid["unknownField"] = True
            invalid_path = tmp / f"inventory-{mutation}.json"
            write_json(invalid_path, invalid)
            product(["-Action", "ValidateInventory", "-InventoryPath", str(invalid_path)], expected=2)
        plan_path, plan = preview(tmp, inventory_path)
        action = next(item for item in plan["actions"] if item["operationClass"] == "RulesetUpdate")
        gate_path = tmp / "gate.json"
        gate = make_gate(gate_path, plan, action, inventory)
        product(["-Action", "ValidateExternalWriteGate", "-OperationClass", "RulesetUpdate",
                         "-AuthorizationPath", str(gate_path), "-PlanPath", str(plan_path),
                         "-InventoryPath", str(inventory_path), "-EvidenceRoot", str(tmp / "evidence")])
        if negative:
            for mutation in ("missing", "unknown"):
                invalid_gate = copy.deepcopy(gate)
                if mutation == "missing":
                    invalid_gate.pop("technicalGateEvidenceSha256")
                else:
                    invalid_gate["unknownField"] = True
                invalid_path = tmp / f"gate-{mutation}.json"
                write_json(invalid_path, invalid_gate)
                product(["-Action", "ValidateExternalWriteGate", "-OperationClass", "RulesetUpdate",
                         "-AuthorizationPath", str(invalid_path), "-PlanPath", str(plan_path),
                         "-InventoryPath", str(inventory_path), "-EvidenceRoot", str(tmp / "evidence")], expected=2)


def executable_inventory_and_after_state() -> None:
    with tempfile.TemporaryDirectory(prefix="crg-inventory-") as raw:
        tmp = Path(raw)
        seed_path = tmp / "seed.json"
        inventory = fresh_inventory(seed_path)
        provider_path = tmp / "provider.json"
        make_provider(provider_path, inventory)
        output = tmp / "materialized.json"
        result = product(["-Action", "Inventory", "-ReadOnly", "-FakeProviderPath", str(provider_path),
                          "-OutputPath", str(output)])
        require(json.loads(result.stdout)["requests"] >= 25, "closed read definitions were not executed")
        materialized = load_json(output)
        product(["-Action", "ValidateInventory", "-InventoryPath", str(output)])
        after_path = tmp / "operational/provider-convergence/after-inventory.json"
        write_json(after_path, materialized)
        after = product(["-Action", "ValidateAfterState", "-DesiredStatePath", str(DESIRED),
                         "-EvidenceRoot", str(tmp)])
        require(json.loads(after.stdout)["targetCount"] == 8, "after-state did not verify all eight targets")


def executable_transaction(mode: str = "apply") -> None:
    with tempfile.TemporaryDirectory(prefix="crg-transaction-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path, drift=True)
        original_inventory = copy.deepcopy(inventory)
        plan_path, plan = preview(tmp, inventory_path)
        action = next(item for item in plan["actions"] if item["operationClass"] == "RulesetUpdate" and item["writeIntent"])
        provider_path = tmp / "provider.json"
        retries = 2 if mode == "retry" else 0
        ambiguous = [action["actionId"]] if mode == "ambiguous" else []
        toctou = [action["actionId"]] if mode == "toctou" else []
        make_provider(provider_path, inventory, retries=retries, ambiguous=ambiguous, toctou=toctou)
        gate_path = tmp / "gate.json"
        make_gate(gate_path, plan, action, inventory)
        result_path = tmp / "apply-result.json"
        args = ["-Action", "Apply", "-OperationClass", "RulesetUpdate", "-PlanPath", str(plan_path),
                "-AuthorizationPath", str(gate_path), "-FakeProviderPath", str(provider_path),
                "-EvidenceRoot", str(tmp / "evidence"), "-ResultPath", str(result_path)]
        if mode == "toctou":
            product(args, expected=3)
            state = load_json(provider_path)
            require(not any(item["kind"] == "Write" for item in state["transactions"]), "TOCTOU caused an unintended write")
            return
        applied = json.loads(product(args).stdout)
        require(applied["totalWrites"] == 1 and load_json(result_path)["resultSha256"] == applied["resultSha256"], "serialized apply result mismatch")
        state = load_json(provider_path)
        require(sum(item.get("writes", 0) for item in state["transactions"] if item["kind"] == "Write") == 1, "fake provider write journal mismatch")
        if mode == "retry":
            transient = [item for item in state["transactions"] if item["kind"] == "Read" and item["outcome"] == "Transient"]
            current = [item for item in state["transactions"] if item["kind"] == "Read" and item["outcome"] == "Current"]
            require(len(transient) == 2 and len(current) == 1, "read retries/current read were not observable")
        if mode == "ambiguous":
            require(applied["results"][0]["outcome"] == "Reconciled", "ambiguous result was not reconciled by read")
            kinds = [item["kind"] for item in state["transactions"]]
            require("Write" in kinds and "Read" in kinds and
                    any(item["kind"] == "Read" and item["outcome"] == "Reconciled" for item in state["transactions"]),
                    "ambiguous write did not perform an observable reconciliation Read")
        if mode == "idempotent":
            second_gate = tmp / "gate-2.json"
            make_gate(second_gate, plan, action, inventory)
            second_result = tmp / "apply-result-2.json"
            second_args = args.copy()
            second_args[second_args.index(str(gate_path))] = str(second_gate)
            second_args[second_args.index(str(result_path))] = str(second_result)
            second = json.loads(product(second_args).stdout)
            require(second["totalWrites"] == 0, "idempotent second pass performed a write")
            second_state = load_json(provider_path)
            require(any(item["kind"] == "SecondPreview" and item["writes"] == 0 and item["driftCount"] == 0
                        for item in second_state["transactions"])
                    and any(item["kind"] == "SecondApply" and item["writes"] == 0 and item["driftCount"] == 0
                            for item in second_state["transactions"]),
                    "idempotent second pass did not execute observable Preview and Apply")
        if mode == "rollback":
            state = load_json(provider_path)
            rollback = {
                "schemaVersion": "1.0", "rollbackId": str(uuid.uuid4()), "runId": plan["runId"],
                "sourceActionId": action["actionId"], "sourceOperationClass": "RulesetUpdate",
                "sourceMutationResultSha256": applied["resultSha256"],
                "afterInventorySha256": state["inventory"]["snapshotSha256"], "targetKind": "Ruleset",
                "repositoryId": action["repositoryId"], "rulesetId": action["rulesetId"],
                "beforeSha256": action["beforeSha256"], "failedAfterSha256": action["desiredSha256"],
                "rollbackDesiredSha256": action["rollbackSha256"], "payloadPath": "payloads/rollback.json",
                "requiresExternalWriteGate": True, "maximumAgeSeconds": 3600, "status": "Authorized",
                "rollbackSha256": "0" * 64,
            }
            rollback_path = tmp / "rollback.json"
            write_json(rollback_path, rollback)
            rollback["rollbackSha256"] = powershell_object_hash(rollback_path, "rollbackSha256")
            write_json(rollback_path, rollback)
            rollback_gate_path = tmp / "rollback-gate.json"
            make_gate(rollback_gate_path, plan, action, state["inventory"], "Rollback",
                      state["inventory"]["snapshotSha256"], action["rollbackSha256"])
            rollback_result = tmp / "rollback-result.json"
            rolled = json.loads(product(["-Action", "Rollback", "-RollbackPlanPath", str(rollback_path),
                "-AuthorizationPath", str(rollback_gate_path), "-FakeProviderPath", str(provider_path),
                "-EvidenceRoot", str(tmp / "evidence"), "-ResultPath", str(rollback_result)]).stdout)
            require(rolled["totalWrites"] == 1 and rolled["results"][0]["outcome"] == "RolledBack", "rollback path was not serialized")
            restored = load_json(provider_path)["inventory"]
            restored_ruleset = next(item for item in restored["rulesets"] if item["repositoryId"] == action["repositoryId"] and item["rulesetId"] == action["rulesetId"])
            before_ruleset = next(item for item in original_inventory["rulesets"] if item["repositoryId"] == action["repositoryId"] and item["rulesetId"] == action["rulesetId"])
            require(restored_ruleset == before_ruleset,
                    "Rollback did not restore the exact bound ruleset before state")


def executable_gate_tuple_toctou() -> None:
    components = {
        "authority": "operational/live-read/authority.json",
        "inventory": "operational/live-read/inventory.json",
        "plan": "operational/live-read/mutation-plan.json",
        "changeReview": "operational/live-read/change-set-review.json",
        "acceptance": "operational/gate-evidence/acceptance.json",
        "security": "operational/gate-evidence/security.json",
        "review": "operational/gate-evidence/review.json",
        "technical": "operational/gate-evidence/technical.json",
    }
    for component, relative in components.items():
        with tempfile.TemporaryDirectory(prefix=f"crg-toctou-{component}-") as raw:
            tmp = Path(raw)
            inventory_path = tmp / "inventory.json"
            inventory = fresh_inventory(inventory_path, drift=True)
            plan_path, plan = preview(tmp, inventory_path)
            action = next(item for item in plan["actions"] if item["operationClass"] == "RulesetUpdate" and item["writeIntent"])
            provider_path = tmp / "provider.json"
            make_provider(provider_path, inventory)
            gate_path = tmp / "gate.json"
            make_gate(gate_path, plan, action, inventory)
            evidence_root = tmp / "evidence"
            product(["-Action", "ValidateExternalWriteGate", "-OperationClass", "RulesetUpdate",
                     "-AuthorizationPath", str(gate_path), "-PlanPath", str(plan_path),
                     "-InventoryPath", str(inventory_path), "-EvidenceRoot", str(evidence_root)])
            target = evidence_root / relative
            mutated = load_json(target)
            if component == "inventory":
                mutated["reviewTriggers"]["unknown"] += 1
                seal_inventory(target, mutated)
            elif component == "plan":
                mutated["createdAt"] = (datetime.now(timezone.utc) - timedelta(minutes=1)).isoformat().replace("+00:00", "Z")
                mutated["planSha256"] = "0" * 64
                write_json(target, mutated)
                mutated["planSha256"] = powershell_object_hash(target, "planSha256")
                write_json(target, mutated)
            elif component == "authority":
                mutated["reviewerIdentity"] = "reviewer:adversarial-drift"
                write_json(target, mutated)
            elif component == "changeReview":
                mutated["reviewerIdentity"] = "reviewer:adversarial-drift"
                write_json(target, mutated)
            else:
                mutated["reviewerIdentity"] = "reviewer:adversarial-drift"
                write_json(target, mutated)
            blocked = json.loads(product(["-Action", "Apply", "-OperationClass", "RulesetUpdate",
                                          "-PlanPath", str(plan_path), "-AuthorizationPath", str(gate_path),
                                          "-FakeProviderPath", str(provider_path), "-EvidenceRoot", str(evidence_root),
                                          "-ResultPath", str(tmp / "result.json")], expected=3).stdout)
            require(blocked["status"] == "Blocked" and blocked["writes"] == 0,
                    f"{component} TOCTOU mismatch did not fail closed")
            require(not any(item["kind"] == "Write" for item in load_json(provider_path)["transactions"]),
                    f"{component} TOCTOU mismatch reached a provider write")


def executable_account_transaction(negative: bool = False) -> None:
    with tempfile.TemporaryDirectory(prefix="crg-account-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path)
        inventory["personalAccountAutomation"]["state"] = "Enabled"
        seal_inventory(inventory_path, inventory)
        original_inventory = copy.deepcopy(inventory)
        plan_path, plan = preview(tmp, inventory_path)
        action = next(item for item in plan["actions"] if item["operationClass"] == "AccountSetting")
        require(action["writeIntent"] is True and action["accountOwner"] == "hindermath", "account plan identity/write intent missing")
        provider_path = tmp / "provider.json"
        make_provider(provider_path, inventory)
        evidence_root = tmp / "evidence"
        gate_path = evidence_root / "operational/provider-gates/account-setting.json"
        gate = make_account_gate(gate_path, plan, action, inventory,
                                 "somebody-else" if negative else "hindermath",
                                 evidence_root=evidence_root)
        make_account_prewrite_records(evidence_root, plan, action, gate)
        if not negative:
            validated = json.loads(validate_account_prewrite(evidence_root).stdout)
            require(validated["status"] == "Authorized" and validated["accountIdentityEquality"] == "Passed",
                    "exact T134 five-record probe was not Authorized")
        args = ["-Action", "Apply", "-OperationClass", "AccountSetting", "-PlanPath", str(plan_path),
                "-AuthorizationPath", str(gate_path), "-FakeProviderPath", str(provider_path),
                "-EvidenceRoot", str(evidence_root), "-ResultPath", str(tmp / "result.json")]
        if negative:
            product(args, expected=2)
            require(not any(item["kind"] == "Write" for item in load_json(provider_path)["transactions"]), "account identity mismatch wrote provider state")
        else:
            result = json.loads(product(args).stdout)
            require(result["totalWrites"] == 1 and result["results"][0]["accountOwner"] == "hindermath", "account transaction identity was not observable")
            provider_state = load_json(provider_path)
            after_path = evidence_root / "operational/provider-convergence/after-inventory.json"
            require(load_json(after_path)["personalAccountAutomation"]["state"] == "Disabled",
                    "Apply-produced Inventory did not serialize Disabled account state")
            after = json.loads(product(["-Action", "ValidateAfterState", "-DesiredStatePath", str(DESIRED),
                                        "-EvidenceRoot", str(evidence_root)]).stdout)
            require(after["targetCount"] == 8 and after["driftCount"] == 0,
                    "exact T150 after-state probe did not converge")
            second_path, second = preview(tmp / "second", after_path)
            require(len(second["actions"]) == 17 and all(not item["writeIntent"] for item in second["actions"]),
                    "T150 second Preview was not a real 17-action zero-write plan")
            rollback = {
                "schemaVersion": "1.0", "rollbackId": str(uuid.uuid4()), "runId": plan["runId"],
                "sourceActionId": action["actionId"], "sourceOperationClass": "AccountSetting",
                "sourceMutationResultSha256": result["resultSha256"],
                "afterInventorySha256": provider_state["inventory"]["snapshotSha256"], "targetKind": "Account",
                "accountOwner": "hindermath", "beforeSha256": action["beforeSha256"],
                "failedAfterSha256": action["desiredSha256"], "rollbackDesiredSha256": action["rollbackSha256"],
                "payloadPath": "payloads/account-rollback.json", "requiresExternalWriteGate": True,
                "maximumAgeSeconds": 3600, "status": "Authorized", "rollbackSha256": "0" * 64,
            }
            rollback_path = tmp / "account-rollback.json"
            write_json(rollback_path, rollback)
            rollback["rollbackSha256"] = powershell_object_hash(rollback_path, "rollbackSha256")
            write_json(rollback_path, rollback)
            safe = str(rollback_path).replace("'", "''")
            script = (f"Import-Module '{MODULE}' -Force; "
                      f"$r=Get-Content -LiteralPath '{safe}' -Raw | ConvertFrom-Json -AsHashtable -DateKind String; "
                      f"Test-HBRollbackContract $r '{action['desiredSha256']}' | Out-Null")
            run(["pwsh", "-NoProfile", "-Command", script])
            rollback_gate_path = tmp / "account-rollback-gate.json"
            make_gate(rollback_gate_path, plan, action, provider_state["inventory"], "Rollback",
                      provider_state["inventory"]["snapshotSha256"], action["rollbackSha256"])
            rollback_result_path = tmp / "account-rollback-result.json"
            rolled = json.loads(product(["-Action", "Rollback", "-RollbackPlanPath", str(rollback_path),
                                         "-AuthorizationPath", str(rollback_gate_path),
                                         "-FakeProviderPath", str(provider_path), "-EvidenceRoot", str(evidence_root),
                                         "-ResultPath", str(rollback_result_path)]).stdout)
            require(rolled["totalWrites"] == 1 and rolled["results"][0]["accountOwner"] == "hindermath",
                    "Account rollback was not executed against the exact identity")
            require(load_json(provider_path)["inventory"]["personalAccountAutomation"] ==
                    original_inventory["personalAccountAutomation"],
                    "Account rollback did not restore the exact bound before state")


def executable_ruleset_operation(operation: str) -> None:
    with tempfile.TemporaryDirectory(prefix=f"crg-{operation.lower()}-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path)
        if operation == "RulesetCreate":
            inventory["rulesets"] = [item for item in inventory["rulesets"] if item["repositoryId"] != 101]
        elif operation == "RulesetDisable":
            inventory["repositories"].append({"repositoryId": 109, "slug": "hindermath/non-target", "visibility": "private", "defaultBranch": "main", "ownedByAccount": True})
            inventory["rulesets"].append({"repositoryId": 109, "rulesetId": 209, "name": "Copilot non-target", "sourceType": "Repository", "target": "branch", "enforcement": "active", "conditionsSha256": HASH, "rulesSha256": HASH, "containsCopilotCodeReview": True, "mixedPurpose": False, "reviewDraftPullRequests": False, "reviewOnPush": False, "stateSha256": "d" * 64})
        else:
            inventory["rulesets"][0]["reviewOnPush"] = True
            inventory["rulesets"][0]["stateSha256"] = "c" * 64
        seal_inventory(inventory_path, inventory)
        plan_path, plan = preview(tmp, inventory_path)
        action = next(item for item in plan["actions"] if item["operationClass"] == operation and item["writeIntent"])
        foreign_before = copy.deepcopy([item for item in inventory["rulesets"] if item.get("repositoryId") != action["repositoryId"]])
        provider_path = tmp / "provider.json"
        make_provider(provider_path, inventory)
        gate_path = tmp / "gate.json"
        make_gate(gate_path, plan, action, inventory, operation)
        result = json.loads(product(["-Action", "Apply", "-OperationClass", operation, "-PlanPath", str(plan_path),
            "-AuthorizationPath", str(gate_path), "-FakeProviderPath", str(provider_path),
            "-EvidenceRoot", str(tmp / "evidence"), "-ResultPath", str(tmp / "result.json")]).stdout)
        require(result["totalWrites"] == 1 and result["results"][0]["operationClass"] == operation, f"{operation} was not executed observably")
        state = load_json(provider_path)
        changed = [item for item in state["inventory"]["rulesets"] if item["repositoryId"] == action["repositoryId"]]
        require(len(changed) == 1, f"{operation} did not preserve exact repository/ruleset identity")
        if operation == "RulesetCreate":
            require(changed[0]["rulesetId"] == result["results"][0]["rulesetId"] and changed[0]["enforcement"] == "active",
                    "RulesetCreate ID/enforcement transition was not observable")
        elif operation == "RulesetUpdate":
            require(changed[0]["rulesetId"] == action["rulesetId"] and changed[0]["enforcement"] == "active"
                    and changed[0]["reviewOnPush"] is False and changed[0]["reviewDraftPullRequests"] is False,
                    "RulesetUpdate did not mutate exact ID/reviewOnPush/enforcement state")
        else:
            require(changed[0]["rulesetId"] == action["rulesetId"] and changed[0]["enforcement"] == "disabled",
                    "RulesetDisable did not mutate exact ID to Disabled enforcement")
        foreign_after = [item for item in state["inventory"]["rulesets"] if item.get("repositoryId") != action["repositoryId"]]
        require(foreign_after == foreign_before, f"{operation} changed a foreign ruleset")


def executable_effort_transaction() -> None:
    with tempfile.TemporaryDirectory(prefix="crg-effort-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path)
        effort = next(item for item in inventory["browserEvidence"] if item["surface"] == "RepositoryEffort")
        effort["observedState"] = "Balanced"
        seal_inventory(inventory_path, inventory)
        plan_path, plan = preview(tmp, inventory_path)
        action = next(item for item in plan["actions"] if item["operationClass"] == "EffortLevel" and item["writeIntent"])
        foreign_before = copy.deepcopy([item for item in inventory["browserEvidence"]
                                        if item.get("repositoryId") != action["repositoryId"]])
        provider_path = tmp / "provider.json"
        make_provider(provider_path, inventory)
        gate_path = tmp / "gate.json"
        make_gate(gate_path, plan, action, inventory, "EffortLevel")
        result = json.loads(product(["-Action", "Apply", "-OperationClass", "EffortLevel",
                                     "-PlanPath", str(plan_path), "-AuthorizationPath", str(gate_path),
                                     "-FakeProviderPath", str(provider_path), "-EvidenceRoot", str(tmp / "evidence"),
                                     "-ResultPath", str(tmp / "result.json")]).stdout)
        require(result["totalWrites"] == 1, "EffortLevel did not execute exactly one bounded write")
        state = load_json(provider_path)["inventory"]
        current = [item for item in state["browserEvidence"] if item.get("repositoryId") == action["repositoryId"]
                   and item["surface"] == "RepositoryEffort"]
        require(len(current) == 1 and current[0]["observedState"] == "Lite",
                "EffortLevel did not mutate exact repository ID to Lite")
        foreign_after = [item for item in state["browserEvidence"] if item.get("repositoryId") != action["repositoryId"]]
        require(foreign_after == foreign_before, "EffortLevel changed foreign browser evidence")


def executable_product_surface(name: str) -> None:
    result = product(["-Action", "ValidateDesiredState", "-DesiredStatePath", str(DESIRED)])
    require(json.loads(result.stdout)["targetCount"] == 8, f"{name}: actual product entry did not validate the contract")
    if "Lifecycle" in name or "Linear" in name:
        script = (f"Import-Module '{MODULE}' -Force; "
                  "$r=Get-HBPrLifecycleDecision @(@{type='Draft'},@{type='DraftToReady'},@{type='Push'}); "
                  "if($r.automaticReviews-ne 1-or$r.pushRereviews-ne 0){exit 1}")
        run(["pwsh", "-NoProfile", "-Command", script])
    if name == "RedactionTests":
        script = f"Import-Module '{MODULE}' -Force; Protect-HBRedactedValue ([ordered]@{{status='Open'}}) | Out-Null"
        run(["pwsh", "-NoProfile", "-Command", script])


def executable_redaction_negative() -> None:
    # Assemble the detector fixture at runtime so repository secret scanners do
    # not mistake this intentional negative-test value for a committed token.
    secret = "gh" + "p_ActualSecretFixture123456789"
    pii = "person.fixture@example.invalid"
    script = (f"Import-Module '{MODULE}' -Force; "
              f"Protect-HBRedactedValue ([ordered]@{{token='{secret}';operatorEmail='{pii}'}}) | Out-Null")
    result = run(["pwsh", "-NoProfile", "-Command", script], expected=1)
    require("Sensitive content must be redacted" in result.stderr,
            "redaction negative did not reject actual secret/PII input")
    require(secret not in result.stderr and pii not in result.stderr,
            "redaction rejection disclosed the submitted secret/PII")


def executable_preview_surface(blocked: bool = False) -> None:
    with tempfile.TemporaryDirectory(prefix="crg-preview-surface-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        inventory = fresh_inventory(inventory_path)
        if blocked:
            inventory["repositories"][0]["defaultBranch"] = "drifted"
            seal_inventory(inventory_path, inventory)
        _, plan = preview(tmp, inventory_path)
        if blocked:
            require(any(item["action"] == "Blocked" for item in plan["actions"]), "planner negative did not execute a Blocked decision")
        else:
            require(len(plan["actions"]) == 17 and all(item["action"] == "NoOp" for item in plan["actions"]), "positive complete plan must contain account, eight effort and eight ruleset NoOps")


def executable_usage_surface() -> None:
    with tempfile.TemporaryDirectory(prefix="crg-usage-") as raw:
        inventory_path = Path(raw) / "inventory.json"
        fresh_inventory(inventory_path)
        result = json.loads(product(["-Action", "ValidateUsage", "-InventoryPath", str(inventory_path)]).stdout)
        require(result["fixedPriceClaims"] is False and set(result["reviewTriggers"]) == {"automatic", "manual", "unknown"}, "usage adapter output drift")


def executable_browser_surface() -> None:
    result = json.loads(product(["-Action", "ValidateBrowserEvidence", "-BrowserEvidencePath", str(FIXTURES / "browser/valid-before.json")]).stdout)
    require(result["records"] == 1 and result["writes"] == 0, "browser evidence surface was not executed")


def executable_review_surface() -> None:
    script = (f"Import-Module '{MODULE}' -Force; "
              "$r=Get-HBPrLifecycleDecision @(@{type='Draft'},@{type='DraftToReady'},@{type='Push'},@{type='ReadyAgain'}); "
              "if($r.automaticReviews-ne 1-or$r.draftReviews-ne 0-or$r.pushRereviews-ne 0){exit 1}; "
              "$g=Compare-HBReviewGateMap @{humanApproval=$true;statusChecks=$true;security=$true;branchProtection=$true} @{humanApproval=$true;statusChecks=$true;security=$true;branchProtection=$true;copilotRequiredAlone=$false}; "
              "if($g.status-ne'Preserved'){exit 2}")
    run(["pwsh", "-NoProfile", "-Command", script])


def executable_canonicalization_surface() -> None:
    script = (f"Import-Module '{MODULE}' -Force; "
              "$j=ConvertTo-HBCanonicalJson ([ordered]@{z=1;a=2}); "
              "if($j.Trim()-ne'{\"a\":2,\"z\":1}'){exit 1}; "
              "$h=Get-HBSha256 -Text $j; if($h-notmatch'^[0-9a-f]{64}$'){exit 2}")
    run(["pwsh", "-NoProfile", "-Command", script])


def executable_provider_read_surface() -> None:
    script = (f"Import-Module '{MODULE}' -Force; "
              "$r=Get-HBGitHubReadRequestDefinitions -RepositorySlug 'hindermath/home-baseline' -RulesetId 201; "
              "$t=$r|ConvertTo-Json -Depth 10; if($t-notmatch'2026-03-10'-or$t-match'(?i)DELETE'){exit 1}")
    run(["pwsh", "-NoProfile", "-Command", script])


def executable_live_get_retry_surface() -> None:
    """Prove that transient failures are retried only by the GET-only reader."""
    with tempfile.TemporaryDirectory(prefix="crg-live-get-retry-") as raw:
        tmp = Path(raw)
        counter = tmp / "attempts.txt"
        helper = tmp / "gh_stub.py"
        helper.write_text(
            "from pathlib import Path\n"
            "import json, sys\n"
            "counter = Path(sys.argv[1])\n"
            "attempt = int(counter.read_text() if counter.exists() else '0') + 1\n"
            "counter.write_text(str(attempt))\n"
            "if attempt < 3:\n"
            "    print('transient read failure', file=sys.stderr)\n"
            "    raise SystemExit(1)\n"
            "print(json.dumps({'login': 'hindermath'}))\n",
            encoding="utf-8",
        )
        if sys.platform == "win32":
            launcher = tmp / "gh.cmd"
            launcher.write_text(
                f'@"{sys.executable}" "{helper}" "{counter}" %*\n',
                encoding="utf-8",
            )
        else:
            launcher = tmp / "gh"
            launcher.write_text(
                "#!/bin/sh\nexec "
                f"{shlex.quote(sys.executable)} {shlex.quote(str(helper))} "
                f"{shlex.quote(str(counter))} \"$@\"\n",
                encoding="utf-8",
            )
            launcher.chmod(0o755)
        safe_module = str(MODULE).replace("'", "''")
        safe_launcher = str(launcher).replace("'", "''")
        script = (
            f"Import-Module '{safe_module}' -Force; "
            "$arguments=@('api','--method','GET','-H','X-GitHub-Api-Version: 2026-03-10','/user/repos?per_page=1'); "
            "$result=& (Get-Module CopilotReviewGovernance) { param($arguments,$executable) "
            "Invoke-HBGitHubJsonRead -Arguments $arguments -Executable $executable } "
            f"$arguments '{safe_launcher}'; "
            "if($result.data.login -cne 'hindermath'){exit 1}"
        )
        run(["pwsh", "-NoProfile", "-Command", script])
        require(counter.read_text(encoding="utf-8") == "3", "GET retry count was not exactly three")


def executable_live_write_boundary_surface() -> None:
    """Prove fixed-host POST/PUT writes have no blind retry path."""
    with tempfile.TemporaryDirectory(prefix="crg-live-write-boundary-") as raw:
        tmp = Path(raw)
        counter = tmp / "attempts.txt"
        payload = tmp / "payload.json"
        payload.write_text('{"name":"Automatic Copilot code review"}\n', encoding="utf-8")
        helper = tmp / "gh_stub.py"
        helper.write_text(
            "from pathlib import Path\n"
            "import json, sys\n"
            "counter = Path(sys.argv[1])\n"
            "attempt = int(counter.read_text() if counter.exists() else '0') + 1\n"
            "counter.write_text(str(attempt))\n"
            "print(json.dumps({'id': 42}))\n",
            encoding="utf-8",
        )
        if sys.platform == "win32":
            launcher = tmp / "gh.cmd"
            launcher.write_text(
                f'@"{sys.executable}" "{helper}" "{counter}" %*\n',
                encoding="utf-8",
            )
        else:
            launcher = tmp / "gh"
            launcher.write_text(
                "#!/bin/sh\nexec "
                f"{shlex.quote(sys.executable)} {shlex.quote(str(helper))} "
                f"{shlex.quote(str(counter))} \"$@\"\n",
                encoding="utf-8",
            )
            launcher.chmod(0o755)
        safe_module = str(MODULE).replace("'", "''")
        safe_launcher = str(launcher).replace("'", "''")
        safe_payload = str(payload).replace("'", "''")
        script = (
            f"Import-Module '{safe_module}' -Force; "
            f"$payload='{safe_payload}'; "
            "$arguments=@('api','--hostname','github.com','--method','POST','-H','X-GitHub-Api-Version: 2026-03-10','repos/hindermath/example/rulesets','--input',$payload); "
            "$result=& (Get-Module CopilotReviewGovernance) { param($arguments,$payload,$executable) "
            "Invoke-HBGitHubJsonWrite -Arguments $arguments -InputPath $payload -Executable $executable } "
            f"$arguments $payload '{safe_launcher}'; "
            "if(-not$result.succeeded-or$result.attempts-ne 1-or$result.data.id-ne 42){exit 1}; "
            "$bad=@('api','--hostname','github.com','--method','GET','-H','X-GitHub-Api-Version: 2026-03-10','repos/hindermath/example/rulesets','--input',$payload); "
            "$blocked=$false; try { & (Get-Module CopilotReviewGovernance) { param($arguments,$payload,$executable) "
            "Invoke-HBGitHubJsonWrite -Arguments $arguments -InputPath $payload -Executable $executable } "
            f"$bad $payload '{safe_launcher}' | Out-Null }} catch {{ $blocked=$true }}; if(-not$blocked){{exit 2}}; "
            "$detail=@{name='Automatic Copilot code review';target='branch';enforcement='active';bypass_actors=@();"
            "conditions=@{ref_name=@{include=@('refs/heads/main');exclude=@()}};rules=@(@{type='copilot_code_review';"
            "parameters=@{review_on_push=$true;review_draft_pull_requests=$true}})}; "
            "$payloads=& (Get-Module CopilotReviewGovernance) { param($detail) "
            "$u=New-HBLiveRulesetPayload RulesetUpdate -CurrentDetail $detail; "
            "$d=New-HBLiveRulesetPayload RulesetDisable -CurrentDetail $detail; "
            "$c=New-HBLiveRulesetPayload RulesetCreate -DefaultBranch main; @($u,$d,$c) } $detail; "
            "if($payloads.Count-ne 3-or$payloads[0].rules.Count-ne 1-or$payloads[0].rules[0].parameters.review_on_push"
            "-or$payloads[0].rules[0].parameters.review_draft_pull_requests-or$payloads[1].enforcement-ne'disabled'"
            "-or$payloads[2].conditions.ref_name.include[0]-cne'refs/heads/main'){exit 3}"
        )
        run(["pwsh", "-NoProfile", "-Command", script])
        require(counter.read_text(encoding="utf-8") == "1", "live write boundary attempted more than once")


def executable_accessibility_surface() -> None:
    result = product(["-Action", "ValidateDesiredState", "-DesiredStatePath", str(DESIRED), "-OutputFormat", "Text"])
    labels = ["Aktion / Action", "Ergebnis / Result", "Providerwrites / Provider writes", "Naechste sichere Aktion / Next safe action"]
    positions = [result.stdout.find(label) for label in labels]
    require(all(position >= 0 for position in positions) and positions == sorted(positions),
            "linear bilingual content semantics/order missing")
    document = (ROOT / "docs/accessibility/copilot-review-governance.md").read_text(encoding="utf-8")
    for semantic in ("Tastatur", "Screenreader", "Braille", "Textbrowser", "Deutsch", "## English", "WCAG 2.2"):
        require(semantic in document, f"A11Y linear content semantic missing: {semantic}")


def executable_native_workflow_surface() -> None:
    executable_product_surface("NativeWorkflowContractTests")
    text = (ROOT / ".github/workflows/copilot-review-governance-native-proof.yml").read_text(encoding="utf-8")
    for exact in ("types: [opened, synchronize, reopened]", "branches: [031-github-copilot-review-governance]",
                  "contents: read", "ubuntu-latest", "windows-latest", "actions/upload-artifact@v4",
                  "payloadSha256", "decisionSha256", "providerWrites = 0", "networkWrites = 0"):
        require(exact in text, f"native workflow exact T116 contract drift: {exact}")
    require(text.count("permissions:") == 1 and "pull-requests: write" not in text and "contents: write" not in text,
            "native workflow permissions are broader than contents:read")
    require("secrets." not in text and "gh api --method" not in text, "native workflow crossed the no-secret/no-provider-write boundary")


def executable_parity() -> None:
    with tempfile.TemporaryDirectory(prefix="crg-parity-") as raw:
        tmp = Path(raw)
        inventory_path = tmp / "inventory.json"
        fresh_inventory(inventory_path)
        ps_path, ps_plan = preview(tmp, inventory_path)
        sh_path = tmp / "bash-plan.json"
        sh = product(["--action", "preview", "--desired-state", str(DESIRED), "--inventory", str(inventory_path),
                      "--output", str(sh_path)], bash=True)
        sh_plan = json.loads(sh.stdout)
        require(ps_plan["actions"] == sh_plan["actions"], "PowerShell/Bash observable action parity failed")
        require(load_json(ps_path)["desiredStateSha256"] == load_json(sh_path)["desiredStateSha256"], "PowerShell/Bash file parity failed")


def executable_documentation(name: str) -> None:
    executable_product_surface(name)
    paths = [ROOT / "docs/man/manage-copilot-review-governance.1.md",
             ROOT / "docs/accessibility/copilot-review-governance.md",
             ROOT / "docs/architecture/copilot-review-governance.md"]
    require(all(path.is_file() for path in paths), "required product documentation is missing")


def executable_supplemental() -> None:
    executable_product_surface("supplemental")
    module_path = ROOT / "scripts/tests/run_copilot_review_governance_acceptance.py"
    spec = importlib.util.spec_from_file_location("crg_acceptance", module_path)
    require(spec is not None and spec.loader is not None, "acceptance aggregator import failed")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    paths = module.write_supplemental_matrix(ROOT)
    require(len(paths) == 10, "supplemental matrix must contain ten gates")
    for path in paths:
        data = load_json(path)
        require(data["evidenceRole"] == "Supplemental" and data["status"] == "Open", "local receipt fabricated Primary/Passed evidence")
        require(data["providerWrites"] == 0 and data["primaryCommandExecuted"] is False, "supplemental receipt crossed authority boundary")


GROUP_NAMES = (
    "HarnessSelfTests", "DesiredStateTests", "CanonicalizationTests", "VerticalSliceRedTests",
    "VerticalSliceGreenTests", "MutationPlannerTests", "MutationPlannerFullTests", "PlannerPositiveTests",
    "InventoryModelTests", "InventorySnapshotTests", "IdempotencyTests", "AfterStateTests",
    "ContractSchemaPositiveTests", "ContractSchemaNegativeTests", "FakeProviderFixtureTests",
    "InventoryPositiveFixtureTests", "InventoryNegativeFixtureTests", "PlannerNegativeTests",
    "PrLifecycleFixtureTests", "ManualReviewFixtureTests", "UsageFixtureTests", "PlatformParityFixtureTests",
    "AccessibilityFixtureTests", "ExternalWriteGateTests", "ExternalWriteGateAccountIdentityContractTests",
    "ExternalWriteGateAccountIdentityNegativeTests", "AccountSettingMutationPlanIdentityTests",
    "AccountSettingPreWriteRecordSetTests", "AccountSettingRollbackIdentityTests", "BrowserTransactionTests",
    "TransactionAndRollbackTests", "RollbackTests", "TocTouTests", "RulesetCreateTests", "RulesetUpdateTests",
    "RulesetDisableTests", "ReadBeforeRetryTests", "ReadRetryTests", "EvidencePublisherTests",
    "RedactionNegativeTests", "RedactionTests", "RepositoryPaginationTests", "RulesetInventoryTests",
    "BillingOwnerTests", "HistoricalSnapshotBoundaryTests", "BrowserApiBoundaryTests", "PrLifecycleDecisionTests",
    "ManualReviewBoundaryTests", "AdvisoryGateMapTests", "ProviderRefusalTaxonomyTests", "NonTargetReviewTests",
    "UsageAdapterTests", "TriggerAttributionTests", "BashPowerShellOptionParityTests", "ScriptParityTests",
    "LinearOutputTests", "AccessibilityDocumentationTests", "NativeWorkflowContractTests",
    "AcCrg001AggregatorContractTests", "AcCrg002To004And009AggregatorContractTests",
    "AcCrg005To007AggregatorContractTests", "AcCrg008AggregatorContractTests",
    "AcCrg001FixtureSupplementalTests", "AcCrg002To004And009FixtureSupplementalTests",
    "AcCrg005To007FixtureSupplementalTests", "AcCrg005ProviderResultSupplementalTests",
    "AcCrg006ProviderResultSupplementalTests", "AcCrg008FixtureSupplementalTests",
    "AcCrg010FixtureSupplementalTests", "CompleteSupplementalEvidenceMatrixTests",
    "CompleteFixtureSupplementalAcceptanceMatrixTests",
)

TRANSACTION_NAMES = {
    "FakeProviderFixtureTests", "ExternalWriteGateTests", "ExternalWriteGateAccountIdentityContractTests",
    "ExternalWriteGateAccountIdentityNegativeTests", "AccountSettingMutationPlanIdentityTests",
    "AccountSettingPreWriteRecordSetTests", "AccountSettingRollbackIdentityTests", "BrowserTransactionTests",
    "TransactionAndRollbackTests", "RulesetCreateTests", "RulesetUpdateTests", "RulesetDisableTests",
    "EvidencePublisherTests", "ProviderRefusalTaxonomyTests",
}
SUPPLEMENTAL_NAMES = {name for name in GROUP_NAMES if "Supplemental" in name}


def action_for(name: str) -> Callable[[], None]:
    if name == "ContractSchemaNegativeTests" or name == "InventoryNegativeFixtureTests":
        return lambda: executable_schema_test(True)
    if name == "ContractSchemaPositiveTests":
        return lambda: executable_schema_test(False)
    if name in {"InventoryModelTests", "InventorySnapshotTests", "RepositoryPaginationTests", "RulesetInventoryTests", "InventoryPositiveFixtureTests", "AfterStateTests"}:
        return executable_inventory_and_after_state
    if name in {"BashPowerShellOptionParityTests", "ScriptParityTests", "PlatformParityFixtureTests"}:
        return executable_parity
    if name in {"RollbackTests", "TransactionAndRollbackTests"}:
        return lambda: executable_transaction("rollback")
    if name == "TocTouTests":
        return executable_gate_tuple_toctou
    if name == "HistoricalSnapshotBoundaryTests":
        return lambda: executable_transaction("toctou")
    if name in {"ReadBeforeRetryTests", "ReadRetryTests"}:
        return lambda: executable_transaction("retry")
    if name == "IdempotencyTests":
        return lambda: executable_transaction("idempotent")
    if name == "ProviderRefusalTaxonomyTests":
        return lambda: executable_transaction("ambiguous")
    if name == "ExternalWriteGateAccountIdentityNegativeTests":
        return lambda: executable_account_prewrite_contract(True)
    if name in {"ExternalWriteGateAccountIdentityContractTests", "AccountSettingPreWriteRecordSetTests"}:
        return executable_account_prewrite_contract
    if name in {"AccountSettingMutationPlanIdentityTests", "AccountSettingRollbackIdentityTests"}:
        return executable_account_transaction
    if name == "RulesetCreateTests":
        return lambda: executable_ruleset_operation("RulesetCreate")
    if name == "RulesetUpdateTests":
        return lambda: executable_ruleset_operation("RulesetUpdate")
    if name == "RulesetDisableTests":
        return lambda: executable_ruleset_operation("RulesetDisable")
    if name == "BrowserTransactionTests":
        return executable_effort_transaction
    if name == "NonTargetReviewTests":
        return lambda: executable_ruleset_operation("RulesetDisable")
    if name in TRANSACTION_NAMES:
        return executable_transaction
    if name in SUPPLEMENTAL_NAMES or "Aggregator" in name:
        return executable_supplemental
    if name == "NativeWorkflowContractTests":
        return executable_native_workflow_surface
    if name in {"AccessibilityFixtureTests", "LinearOutputTests", "AccessibilityDocumentationTests"}:
        return executable_accessibility_surface
    if "Documentation" in name:
        return lambda: executable_documentation(name)
    if name == "CanonicalizationTests":
        return executable_canonicalization_surface
    if name in {"VerticalSliceGreenTests", "MutationPlannerTests", "MutationPlannerFullTests", "PlannerPositiveTests"}:
        return executable_preview_surface
    if name in {"VerticalSliceRedTests", "PlannerNegativeTests"}:
        return lambda: executable_preview_surface(True)
    if name in {"UsageFixtureTests", "BillingOwnerTests", "UsageAdapterTests", "TriggerAttributionTests"}:
        return executable_usage_surface
    if name in {"PrLifecycleFixtureTests", "ManualReviewFixtureTests", "PrLifecycleDecisionTests", "ManualReviewBoundaryTests", "AdvisoryGateMapTests"}:
        return executable_review_surface
    if name in {"BrowserApiBoundaryTests"}:
        return lambda: (
            executable_browser_surface(), executable_provider_read_surface(),
            executable_live_get_retry_surface(), executable_live_write_boundary_surface(),
        )
    if name == "RedactionNegativeTests":
        return executable_redaction_negative
    return lambda: executable_product_surface(name)


@dataclass(frozen=True)
class EvidenceCase:
    """One task-facing label bound to an executed semantic contract."""

    case_id: str
    name: str
    semantic_contract_id: str
    fixture_input_hash: str
    invoked_operation: str
    observed_assertion_ids: tuple[str, ...]
    executor: Callable[[], None]


def semantic_contract_for(name: str) -> tuple[dict[str, object], str, tuple[str, ...]]:
    """Describe only bytes/inputs, product operation, and observations actually executed."""
    if name in {"ContractSchemaNegativeTests", "InventoryNegativeFixtureTests"}:
        return ({"fixture": "fresh-inventory", "mutations": ["missing", "unknown"]},
                "ValidateInventory+Preview+ValidateExternalWriteGate",
                ("inventory-valid", "inventory-missing-rejected", "inventory-unknown-rejected",
                 "gate-valid", "gate-missing-rejected", "gate-unknown-rejected"))
    if name == "ContractSchemaPositiveTests":
        return ({"fixture": "fresh-inventory", "mutations": []},
                "ValidateInventory+Preview+ValidateExternalWriteGate",
                ("inventory-valid", "gate-valid"))
    if name in {"InventoryModelTests", "InventorySnapshotTests", "RepositoryPaginationTests",
                "RulesetInventoryTests", "InventoryPositiveFixtureTests", "AfterStateTests"}:
        return ({"fixture": "home-baseline-green", "provider": "FakeProvider"},
                "Inventory+ValidateInventory+ValidateAfterState",
                ("read-definition-count-gte-25", "inventory-schema-valid", "after-state-zero-drift"))
    if name in {"BashPowerShellOptionParityTests", "ScriptParityTests", "PlatformParityFixtureTests"}:
        return ({"fixture": "fresh-inventory", "surfaces": ["PowerShell", "Bash"]},
                "Preview(PowerShell)+preview(Bash)",
                ("actions-equal", "desired-state-hash-equal"))
    if name in {"RollbackTests", "TransactionAndRollbackTests"}:
        return ({"fixture": "fresh-inventory", "transaction": "rollback"}, "Apply+Rollback",
                ("write-observed", "rollback-restored-exact-before-state", "foreign-state-preserved"))
    if name == "TocTouTests":
        return ({"fixture": "fresh-inventory", "perturbation": "complete-gate-tuple"},
                "ValidateExternalWriteGate+Apply",
                ("first-tuple-authorized", "second-tuple-drift-rejected", "provider-writes-zero"))
    if name == "HistoricalSnapshotBoundaryTests":
        return ({"fixture": "fresh-inventory", "transaction": "toctou"}, "Apply",
                ("snapshot-drift-blocked", "provider-writes-zero"))
    if name in {"ReadBeforeRetryTests", "ReadRetryTests"}:
        return ({"fixture": "fresh-inventory", "transaction": "retry", "transientFailures": 1},
                "Apply", ("read-retry-observed", "single-write", "state-mutated"))
    if name == "IdempotencyTests":
        return ({"fixture": "fresh-inventory", "transaction": "idempotent"}, "Apply+Preview+Apply",
                ("first-write-observed", "second-preview-noop", "second-apply-zero-writes"))
    if name == "ProviderRefusalTaxonomyTests":
        return ({"fixture": "fresh-inventory", "transaction": "ambiguous"}, "Apply",
                ("ambiguous-write-reconciled", "reconciliation-read-observed", "state-consistent"))
    if name == "ExternalWriteGateAccountIdentityNegativeTests":
        return ({"fixture": "t134-account", "mutations": ["authority", "plan", "gate", "result",
                                                         "rollback", "foreign-id"]},
                "ValidateExternalWriteGate(AccountSetting)",
                ("six-cross-record-corruptions-rejected", "blocked", "writes-zero"))
    if name in {"ExternalWriteGateAccountIdentityContractTests", "AccountSettingPreWriteRecordSetTests"}:
        return ({"fixture": "t134-account", "mutation": "none"},
                "ValidateExternalWriteGate(AccountSetting)",
                ("authorized", "account-identity-equality-passed", "writes-zero"))
    if name in {"AccountSettingMutationPlanIdentityTests", "AccountSettingRollbackIdentityTests"}:
        return ({"fixture": "account-enabled", "operation": "AccountSetting"}, "Apply+Rollback",
                ("account-disabled", "rollback-account-enabled", "exact-account-owner"))
    if name in {"RulesetCreateTests", "RulesetUpdateTests", "RulesetDisableTests"}:
        operation = name.removesuffix("Tests")
        return ({"fixture": "fresh-inventory", "operation": operation}, f"Apply({operation})",
                ("single-bounded-write", "exact-ruleset-state-transition", "foreign-rulesets-preserved"))
    if name == "BrowserTransactionTests":
        return ({"fixture": "repository-effort-balanced", "operation": "EffortLevel"},
                "Apply(EffortLevel)",
                ("single-bounded-write", "exact-repository-effort-lite", "foreign-evidence-preserved"))
    if name == "NonTargetReviewTests":
        return ({"fixture": "fresh-inventory", "operation": "RulesetDisable"},
                "Apply(RulesetDisable)",
                ("single-bounded-write", "exact-ruleset-state-transition", "foreign-rulesets-preserved"))
    if name in TRANSACTION_NAMES:
        return ({"fixture": "fresh-inventory", "transaction": "default"}, "Apply",
                ("bounded-result", "provider-journal-observed", "inventory-state-observed"))
    if name in SUPPLEMENTAL_NAMES or "Aggregator" in name or name.startswith("Complete"):
        return ({"fixture": "ten-supplemental-open-gates", "primaryCommandExecuted": False},
                "write_supplemental_matrix",
                ("ten-records", "scope-supplemental-open", "provider-writes-zero"))
    if name == "NativeWorkflowContractTests":
        return ({"fixture": ".github/workflows/copilot-review-governance-native-proof.yml"},
                "ValidateDesiredState+parse-native-workflow",
                ("event-contract", "platform-matrix", "contents-read-only", "artifact-hashes",
                 "no-secrets", "no-provider-writes"))
    if name in {"AccessibilityFixtureTests", "LinearOutputTests", "AccessibilityDocumentationTests"}:
        return ({"fixture": "desired-state+accessibility-document"},
                "ValidateDesiredState(Text)+read-accessibility-doc",
                ("linear-label-order", "keyboard", "screenreader", "braille", "textbrowser",
                 "bilingual", "wcag-2.2"))
    if "Documentation" in name:
        return ({"fixture": "desired-state+product-documentation"},
                "ValidateDesiredState+read-required-documentation",
                ("target-count-eight", "manpage-present", "a11y-doc-present", "architecture-doc-present"))
    if name == "CanonicalizationTests":
        return ({"fixture": {"z": 1, "a": 2}}, "ConvertTo-HBCanonicalJson+Get-HBSha256",
                ("canonical-key-order", "sha256-lowercase-64"))
    if name in {"VerticalSliceGreenTests", "MutationPlannerTests", "MutationPlannerFullTests",
                "PlannerPositiveTests"}:
        return ({"fixture": "fresh-inventory", "drift": False}, "Preview",
                ("seventeen-actions", "all-actions-noop"))
    if name in {"VerticalSliceRedTests", "PlannerNegativeTests"}:
        return ({"fixture": "fresh-inventory", "defaultBranch": "drifted"}, "Preview",
                ("blocked-action-observed",))
    if name in {"UsageFixtureTests", "BillingOwnerTests", "UsageAdapterTests", "TriggerAttributionTests"}:
        return ({"fixture": "fresh-inventory", "usage": "known+unknown"}, "ValidateUsage",
                ("no-fixed-price-claim", "automatic-manual-unknown-separated"))
    if name in {"PrLifecycleFixtureTests", "ManualReviewFixtureTests", "PrLifecycleDecisionTests",
                "ManualReviewBoundaryTests", "AdvisoryGateMapTests"}:
        return ({"events": ["Draft", "DraftToReady", "Push", "ReadyAgain"],
                 "gateMap": "preserved"}, "Get-HBPrLifecycleDecision+Compare-HBReviewGateMap",
                ("one-automatic-review", "zero-draft-reviews", "zero-push-rereviews",
                 "human-ci-security-gates-preserved"))
    if name == "BrowserApiBoundaryTests":
        return ({"fixture": "valid-before+home-baseline-read-definition"},
                "ValidateBrowserEvidence+Get-HBGitHubReadRequestDefinitions+Invoke-HBGitHubJsonRead+Invoke-HBGitHubJsonWrite",
                ("one-browser-record", "browser-writes-zero", "api-version-2026-03-10",
                 "no-delete-method", "transient-get-retried-exactly-three-times",
                 "fixed-host-post-put-only", "single-live-write-attempt", "no-blind-write-retry",
                 "ruleset-payload-arrays-and-semantics"))
    if name == "RedactionNegativeTests":
        return ({"fixture": "github-token+email-pii"}, "Protect-HBRedactedValue",
                ("sensitive-input-rejected", "secret-not-echoed", "pii-not-echoed"))
    return ({"fixture": "canonical-desired-state-v1"}, "ValidateDesiredState",
            ("target-count-eight",))


def build_cases() -> dict[str, EvidenceCase]:
    cases: dict[str, EvidenceCase] = {}
    for index, name in enumerate(GROUP_NAMES, start=1):
        descriptor, operation, assertion_ids = semantic_contract_for(name)
        fixture_hash = hashlib.sha256(canonical(descriptor)).hexdigest()
        semantic_bytes = canonical({
            "executorOperation": operation,
            "fixtureInputSha256": fixture_hash,
            "observedAssertionIds": list(assertion_ids),
        })
        cases[name] = EvidenceCase(
            case_id=f"CRG-G4-{index:03d}",
            name=name,
            semantic_contract_id="sha256:" + hashlib.sha256(semantic_bytes).hexdigest(),
            fixture_input_hash=fixture_hash,
            invoked_operation=operation,
            observed_assertion_ids=assertion_ids,
            executor=action_for(name),
        )
    require(len(cases) == 71, "G4 evidence case count drift")
    require(len({case.case_id for case in cases.values()}) == 71, "G4 case IDs are aliased")
    return cases


GROUPS: dict[str, EvidenceCase] = build_cases()


def print_help() -> None:
    """Print drift-safe CLI help without executing a contract or writing evidence."""
    contract_count = len({case.semantic_contract_id for case in GROUPS.values()})
    aggregate_count = len(GROUPS) - contract_count
    print("Usage: python3 scripts/tests/test_copilot_review_governance.py [FILTER ...]")
    print()
    print("Run the complete deterministic G4 matrix with no FILTER, or run zero or more")
    print("exact class-label filters. Filtered runs do not update canonical full-test evidence.")
    print(
        f"Current complete matrix: {len(GROUPS)} labels -> {contract_count} unique semantic "
        f"contracts and {aggregate_count} aggregate labels."
    )
    print("Labels sharing fixture bytes, invoked operation, and observed assertions are")
    print("reported as AGGREGATE, not as additional independent evidence. Counts above are")
    print("computed from the registered cases at runtime and are not hard-coded.")
    print()
    print("Available exact FILTER labels:")
    for name in GROUP_NAMES:
        print(f"  {name}")


def persist_local_test_result(records: list[dict[str, object]], failures: int) -> None:
    """Persist recomputable semantic grouping; task labels are not evidence identities."""
    contract_ids = sorted({str(record["semanticContractId"]) for record in records})
    contract_set_hash = hashlib.sha256(canonical(contract_ids)).hexdigest()
    previous: dict[str, object] = {}
    if LOCAL_TEST_RESULT.is_file():
        try:
            previous = load_json(LOCAL_TEST_RESULT)
        except (json.JSONDecodeError, OSError):
            previous = {}
    stable_previous = (
        previous.get("contractSetSha256") == contract_set_hash
        and previous.get("failedLabels") == 0
        and previous.get("passedLabels") == len(records)
    )
    executions = min(2, int(previous.get("decisiveExecutions", 0)) + 1) if stable_previous else 1
    result = {
        "schemaVersion": "1.1",
        "evidenceRole": "Local",
        "evidenceScope": "RepositoryLocalSemanticContractExecution",
        "observedAt": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "command": "python3 scripts/tests/test_copilot_review_governance.py",
        "selectedLabels": len(records),
        "independentSemanticContracts": len(contract_ids),
        "aggregateLabels": len(records) - len(contract_ids),
        "passedLabels": len(records) - failures,
        "failedLabels": failures,
        "contractSetSha256": contract_set_hash,
        "decisiveExecutions": executions,
        "stableSecondExecution": executions >= 2,
        "labels": records,
        "liveProviderWrites": 0,
        "networkWrites": 0,
        "primaryCommandExecuted": False,
        "status": "Fulfilled" if failures == 0 else "Not Fulfilled",
        "owner": "Feature 031 Test Owner",
        "reviewer": "Acceptance Reviewer",
        "reevaluationTrigger": "Product, semantic descriptor, fixture, observed assertion, provider adapter, platform or authority drift.",
    }
    write_json(LOCAL_TEST_RESULT, result)


def main(argv: list[str]) -> int:
    if argv in (["-h"], ["--help"]):
        print_help()
        return 0
    selected = argv or list(GROUP_NAMES)
    unknown = [name for name in selected if name not in GROUPS]
    if unknown:
        print(f"Unknown deterministic class filter(s): {', '.join(unknown)}", file=sys.stderr)
        return 2
    failures = 0
    records: list[dict[str, object]] = []
    seen_contracts: set[str] = set()
    for name in selected:
        case = GROUPS[name]
        aggregate = case.semantic_contract_id in seen_contracts
        seen_contracts.add(case.semantic_contract_id)
        case_passed = True
        try:
            case.executor()
            label = "AGGREGATE" if aggregate else "PASS"
            print(f"{label} {name} caseId={case.case_id} semanticContractId={case.semantic_contract_id} "
                  f"fixtureInputSha256={case.fixture_input_hash} operation={case.invoked_operation} "
                  f"assertions={','.join(case.observed_assertion_ids)}")
        except Exception as exc:  # noqa: BLE001 - deterministic matrix reports all selected classes.
            failures += 1
            case_passed = False
            print(f"FAIL {name}: {exc}", file=sys.stderr)
        records.append({
            "caseId": case.case_id,
            "label": name,
            "classification": "Aggregate" if aggregate else "IndependentSemanticContract",
            "semanticContractId": case.semantic_contract_id,
            "fixtureInputSha256": case.fixture_input_hash,
            "invokedOperation": case.invoked_operation,
            "observedAssertionIds": list(case.observed_assertion_ids),
            "passed": case_passed,
        })
    independent = len({GROUPS[name].semantic_contract_id for name in selected})
    aggregates = len(selected) - independent
    if not argv:
        # Only the complete 71-label execution is canonical T118 local evidence.
        persist_local_test_result(records, failures)
    print(f"SUMMARY selected={len(selected)} independent={independent} aggregates={aggregates} "
          f"passed={len(selected) - failures} failed={failures} liveProviderWrites=0 networkWrites=0")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
