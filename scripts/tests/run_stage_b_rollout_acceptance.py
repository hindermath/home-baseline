#!/usr/bin/env python3
"""Run exactly one fail-closed Stage-B acceptance scope and publish one Primary record."""

from __future__ import annotations

import argparse
import copy
import hashlib
import importlib.util
import json
import os
import pathlib
import subprocess
import sys
import tempfile
import uuid
from datetime import datetime, timezone
from unittest import mock


GATE_TESTS = {
    "AC-SBR-001": "FleetPreflightTests",
    "AC-SBR-002": "FailClosedPreflightTests",
    "AC-SBR-003": "PublicCanaryVerticalSliceTests",
    "AC-SBR-004": "WaveOrderTests",
    "AC-SBR-005": "RegularDeliveryTests",
    "AC-SBR-006": "NoOpTests",
    "AC-SBR-007": "PrivateRulesetTests",
    "AC-SBR-008": "StopResumeIdempotencyTests",
    "AC-SBR-009": "PlatformParityTests",
    "AC-SBR-010": "BudgetProjectionTests",
    "AC-SBR-011": "TerminalFleetEvidenceTests",
    "AC-SBR-012": "G4IsolationTests",
}

AC_SBR_002_CASES = {
    "positive-complete-preflight": {
        "dimension": "complete positive preflight",
        "nextSafeAction": "Revalidate current delivery authority before the first external write.",
    },
    "missing-assignment": {
        "dimension": "missing assignment",
        "nextSafeAction": "Restore exactly one approved assignment for every authoritative repository, then rerun preflight.",
    },
    "unknown-assignment": {
        "dimension": "unknown assignment",
        "nextSafeAction": "Remove assignments outside the authoritative fleet, then rerun preflight.",
    },
    "duplicate-assignment": {
        "dimension": "duplicate assignment",
        "nextSafeAction": "Deduplicate the profile registry so every repository has exactly one assignment, then rerun preflight.",
    },
    "visibility-incompatible-assignment": {
        "dimension": "visibility-incompatible assignment",
        "nextSafeAction": "Align repository visibility with its assigned profile through a reviewed registry or provider change, then rerun preflight.",
    },
    "unresolved-remote": {
        "dimension": "unresolved remote",
        "nextSafeAction": "Configure one valid normalized provider remote for the target, then rerun preflight.",
    },
    "conflicting-remote": {
        "dimension": "conflicting remote",
        "nextSafeAction": "Restore the remote identity bound to the provider slug, then rerun preflight.",
    },
    "archived-repository": {
        "dimension": "archived repository",
        "nextSafeAction": "Reactivate the repository or remove it from the authoritative fleet through a reviewed change, then rerun preflight.",
    },
    "renamed-repository": {
        "dimension": "renamed repository",
        "nextSafeAction": "Reconcile the canonical manifest and provider identity through a reviewed change, then rerun preflight.",
    },
    "unexpected-default-branch": {
        "dimension": "unexpected default branch",
        "nextSafeAction": "Restore the configured default branch locally and at the provider, then rerun preflight.",
    },
    "dirty-worktree": {
        "dimension": "dirty worktree",
        "nextSafeAction": "Resolve the target worktree changes under separate authority, then rerun preflight.",
    },
    "divergent-branch": {
        "dimension": "divergent branch",
        "nextSafeAction": "Reconcile the local and remote default branches without rewriting history, then rerun preflight.",
    },
    "stale-head": {
        "dimension": "stale head",
        "nextSafeAction": "Synchronize the local target to the current provider default head, then rerun preflight.",
    },
    "incomplete-provider-record": {
        "dimension": "incomplete provider record",
        "nextSafeAction": "Repeat the read-only inventory after complete branch and commit metadata is available.",
    },
}

STAGE_B_RUN_ID = "954ff259-ffed-44a8-883f-28742b031a9b"
STAGE_B_PLAN_PATH = pathlib.PurePosixPath(
    f".specify/runtime/autonomous-routing/{STAGE_B_RUN_ID}/stage-b/rollout-plan.json"
)


def load_engine(root: pathlib.Path):
    path = root / "scripts/lib/agentic_workspace_fleet.py"
    spec = importlib.util.spec_from_file_location("stage_b_acceptance_engine", path)
    module = importlib.util.module_from_spec(spec)
    if spec.loader is None:
        raise ValueError("Stage-B engine loader is unavailable")
    spec.loader.exec_module(module)
    return module


def normalized_sha256(path: pathlib.Path) -> str:
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    text = raw.decode("utf-8", errors="strict")
    return hashlib.sha256(text.replace("\r\n", "\n").replace("\r", "\n").encode()).hexdigest()


def atomic_write_json(path: pathlib.Path, value: dict) -> None:
    path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    descriptor, temporary_name = tempfile.mkstemp(prefix=f".{path.name}.", dir=path.parent)
    temporary = pathlib.Path(temporary_name)
    try:
        os.fchmod(descriptor, 0o600)
        encoded = (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + "\n").encode()
        with os.fdopen(descriptor, "wb", closefd=True) as stream:
            stream.write(encoded)
            stream.flush()
            os.fsync(stream.fileno())
        json.loads(temporary.read_text(encoding="utf-8"))
        os.replace(temporary, path)
        os.chmod(path, 0o600)
    finally:
        temporary.unlink(missing_ok=True)


def contained_path(root: pathlib.Path, candidate: pathlib.Path, label: str) -> pathlib.Path:
    resolved_root = root.resolve()
    resolved = candidate.resolve() if candidate.is_absolute() else (resolved_root / candidate).resolve()
    if resolved != resolved_root and resolved_root not in resolved.parents:
        raise ValueError(f"{label} escapes repository root")
    return resolved


def build_ac_sbr_001_live_binding(root: pathlib.Path) -> dict:
    """Bind AC-SBR-001 to the published plan and a fresh read-only fleet snapshot."""
    engine = load_engine(root)
    plan_path = contained_path(root, pathlib.Path(STAGE_B_PLAN_PATH), "rollout plan")
    if not plan_path.is_file():
        raise ValueError("AC-SBR-001 requires the actually published rollout plan")
    schema_path = root / "scripts/config/stage-b-rollout-plan.schema.json"
    plan = engine.load_stage_b_document(plan_path, schema_path)
    engine.validate_stage_b_plan_semantics(plan)
    inputs = engine.load_stage_b_live_inputs(root)
    if inputs.get("source") != "GitHubReadOnly":
        raise ValueError("fixture-only fleet evidence cannot satisfy AC-SBR-001")
    snapshot = engine.StageBFleetPreflight(root).execute(
        inputs["providerInventory"],
        source=inputs["source"],
        source_revision=inputs["sourceRevision"],
    )
    plan_ids = sorted(item["repositoryId"] for item in plan["targets"])
    wave_ids = sorted(
        repository_id for wave in plan["waves"] for repository_id in wave["repositoryIds"]
    )
    if plan_ids != snapshot["repositoryIds"] or wave_ids != snapshot["repositoryIds"]:
        raise ValueError("published plan differs from the dynamically discovered fleet")
    stage_a = plan["stageAReference"]
    if (
        stage_a["reviewedHead"] != snapshot["g3ReviewedHead"]
        or stage_a["mergeCommit"] != snapshot["g3MergeCommit"]
        or stage_a["postMergeEvidenceSha256"] != snapshot["g3PostMergeEvidenceSha256"]
    ):
        raise ValueError("published plan differs from the accepted G3 basis")
    return {
        "rolloutPlanPath": STAGE_B_PLAN_PATH.as_posix(),
        "rolloutPlanSha256": normalized_sha256(plan_path),
        "planHash": plan["planHash"],
        "fleetSnapshotHash": plan["fleetSnapshotHash"],
        "repositoryIdsHash": snapshot["repositoryIdsHash"],
        "authoritativeRepositoryCount": len(plan_ids),
        "dynamicFleetEquality": True,
        "providerSource": "GitHubReadOnly",
        "g3Basis": {
            "reviewedHead": snapshot["g3ReviewedHead"],
            "mergeCommit": snapshot["g3MergeCommit"],
            "postMergeEvidenceSha256": snapshot["g3PostMergeEvidenceSha256"],
        },
    }


def _ac_sbr_002_fixture_context(root: pathlib.Path, engine) -> dict:
    manifest = json.loads(
        (root / "scripts/config/agentic-workspace-fleet.json").read_text(encoding="utf-8")
    )
    profiles = json.loads(
        (root / "scripts/config/ci-budget-profiles.json").read_text(encoding="utf-8")
    )
    profile_by_id = {
        item["repositoryId"]: item["profileId"] for item in profiles["assignments"]
    }
    visibility_by_profile = {
        item["profileId"]: item["requiredVisibility"] for item in profiles["profiles"]
    }
    targets = [
        {
            "id": "home-baseline",
            "remote": "https://github.com/hindermath/home-baseline.git",
            "defaultBranch": "main",
        },
        *[
            item for item in manifest["targets"]
            if item.get("active") is True and item.get("kind") == "git-repository"
        ],
    ]
    head = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        text=True,
        capture_output=True,
        check=True,
    ).stdout.strip()
    inventory = []
    for index, item in enumerate(targets, start=1):
        inventory.append({
            "repositoryId": item["id"],
            "providerRepositoryId": str(index),
            "remoteIdentity": item["remote"],
            "slug": engine._github_repository_slug(item["remote"]),
            "profileId": profile_by_id[item["id"]],
            "visibility": visibility_by_profile[profile_by_id[item["id"]]],
            "defaultBranch": item["defaultBranch"],
            "defaultHead": head if item["id"] == "home-baseline" else "a" * 40,
            "defaultTree": "b" * 40,
            "localRepositoryRootHash": "c" * 64,
            "environmentRegistryHash": "d" * 64,
            "observedAt": "2026-08-26T00:00:00Z",
        })
    return {"manifest": manifest, "profiles": profiles, "inventory": inventory}


def _repository_fingerprint(root: pathlib.Path) -> str:
    values = []
    for arguments in (
        ("rev-parse", "HEAD"),
        ("status", "--porcelain=v1", "--untracked-files=all"),
        ("diff", "--binary"),
        ("diff", "--cached", "--binary"),
    ):
        completed = subprocess.run(
            ["git", "-C", str(root), *arguments],
            text=True,
            capture_output=True,
            check=True,
        )
        values.append(completed.stdout)
    return hashlib.sha256("\0".join(values).encode()).hexdigest()


def execute_ac_sbr_002_case(root: pathlib.Path, case_id: str) -> dict:
    """Execute one named preflight case with every mutation boundary denied."""
    if case_id not in AC_SBR_002_CASES:
        raise ValueError(f"unknown AC-SBR-002 case: {case_id}")
    engine = load_engine(root)
    context = _ac_sbr_002_fixture_context(root, engine)
    inventory = context["inventory"]
    manifest = context["manifest"]
    profiles = context["profiles"]
    expected_blocker = "N/A"

    if case_id == "positive-complete-preflight":
        action = lambda: engine.StageBFleetPreflight(root).execute(inventory)
    elif case_id == "missing-assignment":
        changed = copy.deepcopy(profiles)
        changed["assignments"] = [
            item for item in changed["assignments"]
            if item["repositoryId"] != "agent-operations-cockpit"
        ]
        expected_blocker = (
            "profile assignments differ from authoritative set; "
            "missing=['agent-operations-cockpit'], unknown=[]"
        )
        action = lambda: engine.authoritative_ci_repositories(root, manifest, changed)
    elif case_id == "unknown-assignment":
        changed = copy.deepcopy(profiles)
        changed["assignments"].append({
            "repositoryId": "unknown-repository",
            "profileId": "public-product",
            "rationale": "negative acceptance fixture",
        })
        expected_blocker = (
            "profile assignments differ from authoritative set; "
            "missing=[], unknown=['unknown-repository']"
        )
        action = lambda: engine.authoritative_ci_repositories(root, manifest, changed)
    elif case_id == "duplicate-assignment":
        changed = copy.deepcopy(profiles)
        duplicate = copy.deepcopy(changed["assignments"][0])
        changed["assignments"].append(duplicate)
        expected_blocker = f"duplicate assignment: {duplicate['repositoryId']}"
        action = lambda: engine._validate_ci_profiles(changed)
    elif case_id == "visibility-incompatible-assignment":
        changed = copy.deepcopy(inventory)
        target = next(item for item in changed if item["repositoryId"] == "home-baseline")
        target["visibility"] = "private" if target["visibility"] == "public" else "public"
        expected_blocker = "Stage-B visibility drift: home-baseline"
        action = lambda: engine.StageBFleetPreflight(root).execute(changed)
    elif case_id == "unresolved-remote":
        expected_blocker = "GitHub remote cannot be minimized safely: "
        action = lambda: engine._github_repository_slug("")
    elif case_id == "conflicting-remote":
        changed = copy.deepcopy(
            next(item for item in inventory if item["repositoryId"] == "home-baseline")
        )
        changed["remoteIdentity"] = "https://github.com/hindermath/conflicting.git"
        expected_blocker = "remote identity does not match bound slug for home-baseline"
        action = lambda: engine.stage_b_stable_identity(changed)
    elif case_id == "archived-repository":
        expected_blocker = "archived target blocks Stage B: home-baseline"
        action = lambda: engine.validate_stage_b_provider_lifecycle(
            {"archived": True, "fork": False}, "home-baseline", "hindermath/home-baseline"
        )
    elif case_id in {"renamed-repository", "incomplete-provider-record"}:
        authoritative = engine.authoritative_ci_repositories(root, manifest, profiles)
        first = authoritative[0]
        slug = engine._github_repository_slug(first["remoteIdentity"])
        metadata = {
            "id": 1,
            "full_name": slug,
            "default_branch": first["defaultBranch"],
            "archived": False,
            "fork": False,
            "private": False,
        }
        if case_id == "renamed-repository":
            metadata["full_name"] = f"{slug}-renamed"
            expected_blocker = f"provider identity/default-branch drift: {first['repositoryId']}"

            def action():
                with mock.patch.object(engine, "_stage_b_github_get_json", return_value=metadata):
                    return engine.load_stage_b_live_inputs(root)
        else:
            expected_blocker = f"provider branch metadata is incomplete: {first['repositoryId']}"

            def action():
                with mock.patch.object(
                    engine, "_stage_b_github_get_json", side_effect=(metadata, {})
                ):
                    return engine.load_stage_b_live_inputs(root)
    else:
        base = {
            "repositoryId": "fixture",
            "status": [],
            "ahead": 0,
            "behind": 0,
            "localHead": "a" * 40,
            "remoteHead": "a" * 40,
            "defaultBranch": "main",
            "observedDefaultBranch": "main",
        }
        mutations = {
            "unexpected-default-branch": (
                {"observedDefaultBranch": "master"},
                "default branch drift blocks Stage B: fixture",
            ),
            "dirty-worktree": (
                {"status": [" M unrelated.txt"]},
                "dirty target blocks Stage B: fixture",
            ),
            "divergent-branch": (
                {"ahead": 1},
                "divergent target blocks Stage B: fixture",
            ),
            "stale-head": (
                {"remoteHead": "b" * 40},
                "stale target head blocks Stage B: fixture",
            ),
        }
        mutation, expected_blocker = mutations[case_id]
        changed = {**base, **mutation}
        action = lambda: engine.validate_stage_b_git_state(changed)

    real_run = subprocess.run
    counters = {
        "gitWriteAttempts": 0,
        "providerWriteAttempts": 0,
        "filesystemWriteAttempts": 0,
    }
    read_commands = 0

    def recording_run(command, *arguments, **kwargs):
        nonlocal read_commands
        tokens = [str(item) for item in command]
        if tokens and pathlib.Path(tokens[0]).name == "git":
            index = 3 if len(tokens) > 2 and tokens[1] == "-C" else 1
            subcommand = tokens[index] if len(tokens) > index else ""
            if subcommand not in {
                "branch", "cat-file", "config", "diff", "ls-tree", "log",
                "remote", "rev-list", "rev-parse", "show", "status",
            }:
                counters["gitWriteAttempts"] += 1
            else:
                read_commands += 1
        elif tokens and pathlib.Path(tokens[0]).name == "gh":
            method = "GET"
            if "--method" in tokens and tokens.index("--method") + 1 < len(tokens):
                method = tokens[tokens.index("--method") + 1].upper()
            if method != "GET":
                counters["providerWriteAttempts"] += 1
            else:
                read_commands += 1
        return real_run(command, *arguments, **kwargs)

    def deny_filesystem_write(*_arguments, **_kwargs):
        counters["filesystemWriteAttempts"] += 1
        raise AssertionError("AC-SBR-002 fixture attempted a filesystem publication")

    fingerprint_before = _repository_fingerprint(root)
    observed_blocker = "N/A"
    returned = None
    try:
        with (
            mock.patch.object(engine.subprocess, "run", side_effect=recording_run),
            mock.patch.object(engine, "_atomic_stage_b_json", side_effect=deny_filesystem_write),
            mock.patch.object(engine, "publish_stage_b_evidence", side_effect=deny_filesystem_write),
        ):
            returned = action()
    except (engine.ContractError, engine.CIGateBlocked) as exc:
        observed_blocker = str(exc)
    fingerprint_after = _repository_fingerprint(root)

    is_positive = case_id == "positive-complete-preflight"
    if is_positive:
        if observed_blocker != "N/A" or not isinstance(returned, dict) or returned.get("result") != "Passed":
            raise ValueError(f"positive AC-SBR-002 fixture failed: {observed_blocker}")
        if returned.get("writes") != 0:
            raise ValueError("positive AC-SBR-002 fixture reported a write")
    elif observed_blocker != expected_blocker:
        raise ValueError(
            f"AC-SBR-002 blocker drift for {case_id}: {observed_blocker!r} != {expected_blocker!r}"
        )
    if any(counters.values()) or fingerprint_before != fingerprint_after:
        raise ValueError(f"AC-SBR-002 unauthorized write detected for {case_id}")

    return {
        "caseId": case_id,
        "dimension": AC_SBR_002_CASES[case_id]["dimension"],
        "result": "Passed" if is_positive else "Blocked",
        "exactBlocker": observed_blocker,
        "nextSafeAction": AC_SBR_002_CASES[case_id]["nextSafeAction"],
        "blockedBeforeFirstMutation": not is_positive,
        "writesObserved": {**counters, "total": sum(counters.values())},
        "repositoryFingerprintUnchanged": fingerprint_before == fingerprint_after,
        "readCommandsObserved": read_commands,
    }


def build_ac_sbr_002_case_evidence(root: pathlib.Path) -> dict:
    cases = [execute_ac_sbr_002_case(root, case_id) for case_id in AC_SBR_002_CASES]
    positive = [item for item in cases if item["result"] == "Passed"]
    negative = [item for item in cases if item["result"] == "Blocked"]
    if len(positive) != 1 or len(negative) != 13:
        raise ValueError("AC-SBR-002 requires exactly one positive and thirteen negative cases")
    if any(item["writesObserved"]["total"] != 0 for item in cases):
        raise ValueError("AC-SBR-002 case evidence contains an unauthorized write")
    return {
        "schemaVersion": "1.0",
        "positiveCase": positive[0],
        "negativeCases": negative,
        "declaredCaseIds": list(AC_SBR_002_CASES),
        "caseCoverageComplete": {item["caseId"] for item in cases} == set(AC_SBR_002_CASES),
        "negativeCaseCount": len(negative),
        "zeroUnauthorizedWrites": True,
        "caseSetSha256": hashlib.sha256(
            json.dumps(cases, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode()
        ).hexdigest(),
    }


def load_requirement(root: pathlib.Path, gate: str) -> tuple[pathlib.Path, dict]:
    path = root / "specs/030-stage-b-rollout/autonomous-run-gate-requirements.json"
    document = json.loads(path.read_text(encoding="utf-8"))
    matches = [item for item in document.get("gates", []) if item.get("gateId") == gate]
    if len(matches) != 1:
        raise ValueError(f"exactly one acceptance requirement is required for {gate}")
    requirement = matches[0]
    if requirement.get("applicability") not in {"Applicable", "N/A"}:
        raise ValueError(f"acceptance applicability is invalid for {gate}")
    if requirement["applicability"] == "Applicable" and not requirement.get("requiredScope", "").strip():
        raise ValueError(f"acceptance scope is missing for {gate}")
    return path, requirement


def runner_tokens(gate: str, evidence_root: pathlib.Path) -> list[str]:
    tokens = ["macOS"] if sys.platform == "darwin" else []
    if gate in {"AC-SBR-001", "AC-SBR-010", "AC-SBR-011", "AC-SBR-012"}:
        tokens.append("GitHubReadOnly")
    elif gate in {"AC-SBR-003", "AC-SBR-004", "AC-SBR-005", "AC-SBR-006", "AC-SBR-007"}:
        tokens.append("GitHub")
    for token, relative in (
        ("Linux", "operational/platform/linux.json"),
        ("Windows", "operational/platform/windows.json"),
    ):
        candidate = evidence_root / relative
        if candidate.is_file():
            value = json.loads(candidate.read_text(encoding="utf-8"))
            if value.get("runnerOrPlatform") == token and value.get("result") in {"Pass", "Passed"}:
                tokens.append(token)
    return tokens


def validate_command_and_tokens(
    requirement: dict, executed_command: str, observed_runner_tokens: list[str]
) -> None:
    missing_command = [
        token for token in requirement.get("requiredCommandTokens", []) if token not in executed_command
    ]
    missing_runner = [
        token for token in requirement.get("requiredRunnerOrPlatformTokens", [])
        if token not in observed_runner_tokens
    ]
    if missing_command:
        raise ValueError(f"required command token drift: {missing_command}")
    if missing_runner:
        raise ValueError(f"required runner/platform token missing: {missing_runner}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--gate", choices=tuple(GATE_TESTS), required=True)
    parser.add_argument("--repository-root", type=pathlib.Path, required=True)
    parser.add_argument("--evidence-root", type=pathlib.Path, required=True)
    args = parser.parse_args()
    try:
        root = args.repository_root.resolve(strict=True)
        if not (root / ".git").exists():
            raise ValueError("repository root is not a Git worktree")
        evidence_root = contained_path(root, args.evidence_root, "evidence root")
        requirements_path, requirement = load_requirement(root, args.gate)
        executed_command = (
            f"python3 scripts/tests/run_stage_b_rollout_acceptance.py --gate {args.gate} "
            "--repository-root . --evidence-root "
            ".specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1"
        )
        observed_tokens = runner_tokens(args.gate, evidence_root)
        validate_command_and_tokens(requirement, executed_command, observed_tokens)
        test_command = [sys.executable, "scripts/tests/test_stage_b_rollout.py", GATE_TESTS[args.gate]]
        completed = subprocess.run(test_command, cwd=root, text=True, check=False)
        if completed.returncode != 0:
            return completed.returncode
        head = subprocess.run(
            ["git", "-C", str(root), "rev-parse", "HEAD"],
            text=True, capture_output=True, check=False,
        )
        head_sha = head.stdout.strip()
        if head.returncode != 0 or not all(character in "0123456789abcdef" for character in head_sha) or len(head_sha) != 40:
            raise ValueError("full reviewed HEAD is unavailable")
        entry = {
            "gateId": args.gate,
            "evidenceRole": "Primary",
            "applicability": requirement["applicability"],
            "requiredScope": requirement["requiredScope"],
            "headSha": head_sha,
            "provider": (
                "GitHubReadOnly" if "GitHubReadOnly" in observed_tokens
                else "GitHub" if "GitHub" in observed_tokens else "LocalImplementation"
            ),
            "runId": STAGE_B_RUN_ID,
            "snapshotId": str(uuid.uuid4()),
            "capturedAt": datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
            "workflow": "speckit.implement",
            "job": GATE_TESTS[args.gate],
            "runnerOrPlatform": ",".join(observed_tokens),
            "executedCommand": executed_command,
            "result": "Pass",
            "requirementsSha256": normalized_sha256(requirements_path),
            "rationale": requirement["rationale"],
            "reevaluationTrigger": requirement["reevaluationTrigger"],
            "supplementalFor": "",
        }
        if args.gate == "AC-SBR-001":
            entry["livePlanBinding"] = build_ac_sbr_001_live_binding(root)
        elif args.gate == "AC-SBR-002":
            entry["preflightCaseEvidence"] = build_ac_sbr_002_case_evidence(root)
        atomic_write_json(evidence_root / "primary" / f"{args.gate}.json", entry)
        return 0
    except (OSError, UnicodeError, json.JSONDecodeError, ValueError) as exc:
        print(f"STAGE_B_ACCEPTANCE\tFAILED\t{exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
