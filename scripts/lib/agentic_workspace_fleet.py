#!/usr/bin/env python3
"""Validate and maintain the declared workspace fleet without provider writes."""

from __future__ import annotations

import argparse
import ctypes
import fnmatch
import hashlib
import json
import os
import pathlib
import random
import re
import shutil
import subprocess
import sys
import tempfile
import time
import uuid
from datetime import datetime, timezone
from decimal import Decimal, InvalidOperation
from urllib.parse import urlsplit


VALID_KINDS = {"git-repository", "collection"}
VALID_CLASSES = {"canonical-fleet", "preset"}
VALID_FORGES = {"github", "gitlab", "codeberg", "forgejo", "generic-git"}
KNOWN_MSL_LANGUAGES = {
    "ada", "c#", "csharp", "dart", "elixir", "erlang", "f#", "fsharp",
    "go", "haskell", "java", "javascript", "kotlin", "ocaml", "python",
    "ruby", "rust", "scala", "spark", "swift", "typescript",
}
KNOWN_NON_MSL_LANGUAGES = {
    "assembly", "c", "c++", "c89", "cc65", "d", "nim", "objective-c", "zig",
}
BLOCKING_STATES = {
    "AHEAD",
    "DIVERGED",
    "DIRTY",
    "DETACHED",
    "PATH_CONFLICT",
    "REMOTE_MISMATCH",
    "BRANCH_MISMATCH",
    "MISSING_UPSTREAM",
    "UNAVAILABLE",
}


class ContractError(ValueError):
    """Raised when the desired-state contract is unsafe or inconsistent."""


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def run_git(repository: pathlib.Path | None, *arguments: str, check: bool = True) -> subprocess.CompletedProcess[str]:
    command = ["git"]
    if repository is not None:
        command.extend(["-C", str(repository)])
    command.extend(arguments)
    result = subprocess.run(command, text=True, capture_output=True, check=False)
    if check and result.returncode != 0:
        detail = (result.stderr or result.stdout).strip().splitlines()
        raise RuntimeError(detail[-1] if detail else f"git exited {result.returncode}")
    return result


def is_transient_git_failure(detail: str) -> bool:
    """Retry network failures, never auth or repository-state failures."""
    if re.search(
        r"auth(?:entication|orization)?|permission|forbidden|not found|dirty|ahead|diverged",
        detail,
        re.IGNORECASE,
    ):
        return False
    return bool(
        re.search(
            r"timed?\s*out|timeout|connection\s+(?:was\s+)?(?:reset|closed|aborted)|temporary failure|"
            r"could not resolve host|name resolution|http\s+50[234]",
            detail,
            re.IGNORECASE,
        )
    )


def run_git_network(
    repository: pathlib.Path | None, *arguments: str
) -> tuple[subprocess.CompletedProcess[str], int, int]:
    attempts = max(1, min(10, int(os.environ.get("HB_GIT_RETRY_ATTEMPTS", "3"))))
    timeout = max(5, min(3600, int(os.environ.get("HB_GIT_TIMEOUT_SECONDS", "300"))))
    command = ["git"]
    if repository is not None:
        command.extend(["-C", str(repository)])
    command.extend(arguments)
    result: subprocess.CompletedProcess[str] | None = None
    started = time.monotonic()
    for attempt in range(1, attempts + 1):
        try:
            result = subprocess.run(
                command,
                text=True,
                capture_output=True,
                check=False,
                timeout=timeout,
            )
        except subprocess.TimeoutExpired:
            result = subprocess.CompletedProcess(
                command, 124, stdout="", stderr=f"operation timed out after {timeout}s"
            )
        detail = (result.stderr or result.stdout).strip()
        if result.returncode == 0 or attempt == attempts or not is_transient_git_failure(detail):
            return result, attempt, int((time.monotonic() - started) * 1000)
        delay = min(3.0, 0.25 * (2 ** (attempt - 1)))
        time.sleep(delay + random.uniform(0, delay / 4))
    assert result is not None
    return result, attempts, int((time.monotonic() - started) * 1000)


def network_attempt(
    operation: str,
    result: subprocess.CompletedProcess[str],
    attempts: int,
    duration_ms: int,
) -> dict:
    detail = (result.stderr or result.stdout).strip().splitlines()
    evidence = detail[-1][:512] if detail and result.returncode != 0 else "N/A"
    if evidence != "N/A":
        evidence = evidence.replace(str(pathlib.Path.home()), "<home>")
        evidence = re.sub(
            r"(?i)\b(https?://)[^/@\s]+:[^@\s]+@",
            r"\1<redacted>@",
            evidence,
        )
        evidence = re.sub(
            r"(?i)\b(token|password|secret)=([^\s&]+)",
            r"\1=<redacted>",
            evidence,
        )
    status = (
        "Succeeded"
        if result.returncode == 0
        else "TimedOut"
        if result.returncode == 124
        else "Failed"
    )
    return {
        "operation": operation,
        "attemptCount": attempts,
        "durationMs": duration_ms,
        "exitCode": result.returncode,
        "status": status,
        "sanitizedEvidence": evidence,
        "nextAction": (
            "N/A"
            if result.returncode == 0
            else "Remote-Zugriff prüfen und den Lauf erneut ausführen / review remote access and rerun."
        ),
    }


def normalize_remote(remote: str) -> str:
    value = remote.strip().replace("\\", "/")
    parsed = urlsplit(value)
    if parsed.scheme in {"http", "https"}:
        if parsed.username or parsed.password:
            raise ContractError("remote URLs with embedded credentials are forbidden")
        value = f"{parsed.scheme.lower()}://{parsed.netloc.lower()}{parsed.path}"
    return value.rstrip("/").removesuffix(".git").lower()


def validate_relative_path(raw: object) -> pathlib.PurePosixPath:
    if not isinstance(raw, str) or not raw or "\\" in raw or raw.startswith("/"):
        raise ContractError(f"unsafe HOME-relative path: {raw!r}")
    value = pathlib.PurePosixPath(raw)
    if any(part in {"", ".", ".."} for part in value.parts):
        raise ContractError(f"unsafe HOME-relative path: {raw!r}")
    return value


# CI budget governance deliberately uses a small, dependency-free validator.
# JSON Schema remains the review contract; these checks enforce the security-
# relevant closed-world boundaries at runtime without adding a package.
CI_PROFILE_ORDER = (
    "public-canary",
    "public-product",
    "private-product",
    "private-governance-scaffold",
    "public-preset",
)
CI_PATH_CATEGORIES = {
    "build", "security", "governance", "dependency", "product", "documentation"
}


def canonical_json_hash(value: object) -> str:
    encoded = json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def validate_ci_input_component(value: object) -> str:
    if (
        not isinstance(value, str)
        or not value
        or not re.fullmatch(r"[a-z0-9][a-z0-9-]*", value)
        or value.startswith(("-", "/"))
        or "\\" in value
        or any(character in value for character in ("\r", "\n", "\0"))
        or ".." in pathlib.PurePosixPath(value).parts
    ):
        raise ContractError(f"unsafe CI input component: {value!r}")
    return value


def resolve_ci_contained_path(
    root: pathlib.Path, relative: pathlib.PurePosixPath
) -> pathlib.Path:
    if relative.is_absolute() or any(part in {"", ".", ".."} for part in relative.parts):
        raise ContractError(f"unsafe repository-relative path: {relative}")
    resolved_root = root.resolve()
    candidate = resolved_root.joinpath(*relative.parts).resolve(strict=False)
    try:
        candidate.relative_to(resolved_root)
    except ValueError as exc:
        raise ContractError(f"path escapes repository boundary: {relative}") from exc
    return candidate


def require_matching_profile_ids(
    repository_id: str, assignment_profile_id: str, observed_profile_id: str
) -> None:
    if assignment_profile_id != observed_profile_id:
        raise ContractError(
            f"denormalized profileId drift for {repository_id}: "
            f"{assignment_profile_id!r} != {observed_profile_id!r}"
        )


def _read_ci_json(path: pathlib.Path, label: str) -> dict:
    try:
        value = json.loads(path.read_text(encoding="utf-8-sig"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ContractError(f"{label} cannot be read as UTF-8 JSON: {exc}") from exc
    if not isinstance(value, dict):
        raise ContractError(f"{label} root must be an object")
    return value


def _require_exact_keys(value: dict, expected: set[str], label: str) -> None:
    unknown = set(value) - expected
    missing = expected - set(value)
    if unknown or missing:
        raise ContractError(
            f"{label} fields differ; missing={sorted(missing)}, unknown={sorted(unknown)}"
        )


def _validate_ci_profiles(value: dict) -> tuple[set[str], set[str]]:
    _require_exact_keys(
        value,
        {
            "schemaVersion", "registryVersion", "level0Self", "fleetManifestPath",
            "profiles", "assignments", "gateSets", "budgetAssumptions",
        },
        "profile registry",
    )
    if value["schemaVersion"] != "1.0" or not re.fullmatch(
        r"\d+\.\d+\.\d+", str(value["registryVersion"])
    ):
        raise ContractError("profile registry version is invalid")
    if value["level0Self"] != {
        "repositoryId": "home-baseline",
        "remoteResolution": "executing-level0-configured-origin",
    }:
        raise ContractError("level0Self is invalid")
    if value["fleetManifestPath"] != "scripts/config/agentic-workspace-fleet.json":
        raise ContractError("fleetManifestPath is invalid")
    profiles = value["profiles"]
    if not isinstance(profiles, list) or [item.get("profileId") for item in profiles if isinstance(item, dict)] != list(CI_PROFILE_ORDER):
        raise ContractError("exactly five profiles in canonical order are required")
    profile_fields = {
        "profileId", "displayName", "requiredVisibility", "gateSetId",
        "workflowPolicyId", "budgetClass",
    }
    for index, profile in enumerate(profiles):
        if not isinstance(profile, dict):
            raise ContractError(f"profiles[{index}] must be an object")
        _require_exact_keys(profile, profile_fields, f"profiles[{index}]")
        if profile["requiredVisibility"] not in {"public", "private"}:
            raise ContractError(f"profiles[{index}].requiredVisibility is invalid")
    assignments = value["assignments"]
    if not isinstance(assignments, list) or not assignments:
        raise ContractError("assignments must be a non-empty array")
    assignment_ids: set[str] = set()
    for index, assignment in enumerate(assignments):
        if not isinstance(assignment, dict):
            raise ContractError(f"assignments[{index}] must be an object")
        _require_exact_keys(
            assignment, {"repositoryId", "profileId", "rationale"}, f"assignments[{index}]"
        )
        repository_id = validate_ci_input_component(assignment["repositoryId"])
        if repository_id in assignment_ids:
            raise ContractError(f"duplicate assignment: {repository_id}")
        assignment_ids.add(repository_id)
        if assignment["profileId"] not in CI_PROFILE_ORDER or not assignment["rationale"]:
            raise ContractError(f"invalid assignment: {repository_id}")
    gate_sets = value["gateSets"]
    if not isinstance(gate_sets, list) or not gate_sets:
        raise ContractError("gateSets must be a non-empty array")
    gate_ids: set[str] = set()
    for set_index, gate_set in enumerate(gate_sets):
        _require_exact_keys(gate_set, {"gateSetId", "version", "gates"}, f"gateSets[{set_index}]")
        validate_ci_input_component(gate_set["gateSetId"])
        if not re.fullmatch(r"\d+\.\d+\.\d+", str(gate_set["version"])):
            raise ContractError("gate-set version is invalid")
        gates = gate_set["gates"]
        if not isinstance(gates, list) or not gates:
            raise ContractError("gate-set gates must be non-empty")
        expected_order = 1
        for gate_index, gate in enumerate(gates):
            _require_exact_keys(
                gate,
                {"order", "gateId", "executable", "arguments", "workingDirectory", "timeoutSeconds"},
                f"gateSets[{set_index}].gates[{gate_index}]",
            )
            if gate["order"] != expected_order:
                raise ContractError("gate orders must be contiguous and start at one")
            expected_order += 1
            gate_id = validate_ci_input_component(gate["gateId"])
            if gate_id in gate_ids:
                raise ContractError(f"duplicate gateId: {gate_id}")
            gate_ids.add(gate_id)
            executable = gate["executable"]
            if not isinstance(executable, str) or not executable or re.search(r"[\r\n\0]", executable):
                raise ContractError(f"unsafe executable for {gate_id}")
            arguments = gate["arguments"]
            if not isinstance(arguments, list) or any(
                not isinstance(argument, str) or re.search(r"[\r\n\0]", argument)
                for argument in arguments
            ):
                raise ContractError(f"unsafe argument array for {gate_id}")
            working = gate["workingDirectory"]
            if working != ".":
                resolve_ci_contained_path(pathlib.Path.cwd(), pathlib.PurePosixPath(working))
            if not isinstance(gate["timeoutSeconds"], int) or not 1 <= gate["timeoutSeconds"] <= 3600:
                raise ContractError(f"invalid timeout for {gate_id}")
    assumptions = value["budgetAssumptions"]
    _require_exact_keys(
        assumptions,
        {
            "weeksPerMonthNumerator", "weeksPerMonthDenominator",
            "privateMonthlyBudgetMinutes", "privateMonthlyTargetExclusiveMinutes",
            "recurringPrivateJobsPerWeekReference",
        },
        "budgetAssumptions",
    )
    if assumptions != {
        "weeksPerMonthNumerator": 52,
        "weeksPerMonthDenominator": 12,
        "privateMonthlyBudgetMinutes": 3000,
        "privateMonthlyTargetExclusiveMinutes": 500,
        "recurringPrivateJobsPerWeekReference": 22,
    }:
        raise ContractError("budget assumptions differ from the accepted contract")
    return assignment_ids, gate_ids


def _validate_ci_paths(value: dict, gate_ids: set[str], product_job_ids: set[str]) -> None:
    _require_exact_keys(value, {"schemaVersion", "registryVersion", "pathContracts"}, "path registry")
    if value["schemaVersion"] != "1.0" or not re.fullmatch(
        r"\d+\.\d+\.\d+", str(value["registryVersion"])
    ):
        raise ContractError("path registry version is invalid")
    contracts = value["pathContracts"]
    if not isinstance(contracts, list) or not contracts:
        raise ContractError("pathContracts must be a non-empty array")
    categories: set[str] = set()
    contract_ids: set[str] = set()
    for index, contract in enumerate(contracts):
        if not isinstance(contract, dict):
            raise ContractError(f"pathContracts[{index}] must be an object")
        expected = {"pathContractId", "category", "includePatterns", "excludePatterns", "gateIds"}
        if contract.get("category") == "product":
            expected.add("productJobId")
        _require_exact_keys(contract, expected, f"pathContracts[{index}]")
        contract_id = validate_ci_input_component(contract["pathContractId"])
        if contract_id in contract_ids:
            raise ContractError(f"duplicate pathContractId: {contract_id}")
        contract_ids.add(contract_id)
        category = contract["category"]
        if category not in CI_PATH_CATEGORIES:
            raise ContractError(f"invalid path category: {category}")
        categories.add(category)
        for field in ("includePatterns", "excludePatterns"):
            patterns = contract[field]
            if not isinstance(patterns, list) or (field == "includePatterns" and not patterns):
                raise ContractError(f"{contract_id}.{field} is invalid")
            if len(patterns) != len(set(patterns)):
                raise ContractError(f"{contract_id}.{field} contains duplicates")
            for pattern in patterns:
                if (
                    not isinstance(pattern, str)
                    or not pattern
                    or pattern.startswith(("/", "-"))
                    or "\\" in pattern
                    or any(character in pattern for character in ("\r", "\n", "\0"))
                    or ".." in pathlib.PurePosixPath(pattern).parts
                ):
                    raise ContractError(f"unsafe path pattern: {pattern!r}")
        references = contract["gateIds"]
        if not isinstance(references, list) or not references or len(references) != len(set(references)):
            raise ContractError(f"invalid gate references for {contract_id}")
        unknown_gates = set(references) - gate_ids
        if unknown_gates:
            raise ContractError(f"unknown gate references: {sorted(unknown_gates)}")
        if category == "product" and contract["productJobId"] not in product_job_ids:
            raise ContractError(f"unknown product job reference: {contract['productJobId']}")
    if categories != CI_PATH_CATEGORIES:
        raise ContractError(f"all six path categories are required, found {sorted(categories)}")


def load_ci_budget_contracts(
    profiles_path: pathlib.Path,
    paths_path: pathlib.Path,
    workflow_template_path: pathlib.Path,
) -> dict:
    profiles = _read_ci_json(profiles_path, "profile registry")
    paths = _read_ci_json(paths_path, "path registry")
    _, gate_ids = _validate_ci_profiles(profiles)
    try:
        workflow_text = workflow_template_path.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as exc:
        raise ContractError(f"workflow template cannot be read: {exc}") from exc
    product_job_ids = set(re.findall(r"^\s*-\s+jobId:\s+([a-z0-9][a-z0-9-]*)\s*$", workflow_text, re.MULTILINE))
    if not product_job_ids:
        raise ContractError("workflow template declares no stable product job IDs")
    _validate_ci_paths(paths, gate_ids, product_job_ids)
    return {
        "profiles": profiles,
        "paths": paths,
        "profileRegistryHash": canonical_json_hash(profiles),
        "pathContractHash": canonical_json_hash(paths),
        "loadCounts": {"profiles": 1, "paths": 1},
    }


def load_manifest(path: pathlib.Path) -> dict:
    try:
        data = json.loads(path.read_text(encoding="utf-8-sig"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ContractError(f"manifest cannot be read: {exc}") from exc
    if not isinstance(data, dict) or data.get("schemaVersion") != "1.0":
        raise ContractError("unsupported manifest schemaVersion")
    targets = data.get("targets")
    if not isinstance(targets, list) or not targets:
        raise ContractError("targets must be a non-empty array")

    ids: set[str] = set()
    paths: dict[str, dict] = {}
    remotes: set[str] = set()
    for index, target in enumerate(targets):
        if not isinstance(target, dict):
            raise ContractError(f"targets[{index}] must be an object")
        allowed = {
            "id", "kind", "level", "path", "active", "maintenanceClass",
            "remote", "forge", "defaultBranch", "memberDiscovery",
        }
        unknown = set(target) - allowed
        if unknown:
            raise ContractError(f"unknown target fields at targets[{index}]: {sorted(unknown)}")
        required = {"id", "kind", "level", "path", "active", "maintenanceClass"}
        if not required.issubset(target):
            raise ContractError(f"missing target fields at targets[{index}]")
        target_id = target.get("id")
        if not isinstance(target_id, str) or not re.fullmatch(r"[a-z0-9][a-z0-9-]*", target_id):
            raise ContractError(f"targets[{index}].id is invalid")
        if target_id in ids:
            raise ContractError(f"duplicate target id: {target_id}")
        ids.add(target_id)
        kind = target.get("kind")
        level = target.get("level")
        maintenance_class = target.get("maintenanceClass")
        if kind not in VALID_KINDS or level not in {1, 2} or maintenance_class not in VALID_CLASSES:
            raise ContractError(f"invalid target classification: {target_id}")
        if not isinstance(target.get("active"), bool):
            raise ContractError(f"active must be boolean: {target_id}")
        relative = validate_relative_path(target.get("path"))
        path_key = relative.as_posix().casefold()
        if path_key in paths:
            raise ContractError(f"duplicate target path: {relative}")
        paths[path_key] = target
        if kind == "collection":
            forbidden = {"remote", "forge", "defaultBranch"} & target.keys()
            if forbidden or target.get("memberDiscovery") != "declared-targets":
                raise ContractError(f"invalid collection fields: {target_id}")
        else:
            branch = target.get("defaultBranch")
            if target.get("forge") not in VALID_FORGES or not isinstance(branch, str) or not branch.strip():
                raise ContractError(f"invalid Git target fields: {target_id}")
            remote = target.get("remote")
            if not isinstance(remote, str) or not remote:
                raise ContractError(f"missing remote: {target_id}")
            normalized = normalize_remote(remote)
            if normalized in remotes and target.get("active"):
                raise ContractError(f"duplicate active remote: {remote}")
            if target.get("active"):
                remotes.add(normalized)

    # Eltern werden exakt deklariert, damit Discovery keine unbekannten Ziele legitimiert.
    # Parents are explicit so discovery cannot legitimize unknown targets.
    for target in targets:
        if target["level"] != 2:
            continue
        parent = pathlib.PurePosixPath(target["path"]).parent
        parent_target = paths.get(parent.as_posix().casefold())
        if not parent_target or parent_target["level"] != 1 or not parent_target.get("active"):
            raise ContractError(f"orphan Level-2 target: {target['id']}")
    return data


def target_result(target: dict, **values: object) -> dict:
    result = {
        "targetId": target["id"],
        "path": target["path"],
        "kind": target["kind"],
        "maintenanceClass": target["maintenanceClass"],
        "status": "CURRENT",
        "action": "NONE",
        "result": "Pass",
        "branch": target.get("defaultBranch", "N/A"),
        "upstream": "N/A",
        "ahead": 0,
        "behind": 0,
        "findingCode": "N/A",
        "nextAction": "N/A",
        "retryAttempts": 0,
        "resumeAccepted": False,
        "freshnessAttempt": None,
        "defaultBranchEvidence": None,
        "mutationAllowed": target.get("kind") != "git-repository",
    }
    result.update(values)
    return result


def resolve_default_branch_evidence(
    target: dict,
    path: pathlib.Path,
    local_symbolic_ref: str,
) -> tuple[dict | None, dict | None, str | None]:
    if local_symbolic_ref:
        prefix = "refs/remotes/origin/"
        if not local_symbolic_ref.startswith(prefix):
            return None, None, "RemoteHeadInvalid"
        branch_name = local_symbolic_ref.removeprefix(prefix)
        if target.get("defaultBranch") and target["defaultBranch"] != branch_name:
            return None, None, "RemoteHeadMismatch"
        tracking = run_git(
            path, "rev-parse", "--verify", local_symbolic_ref, check=False
        )
        if tracking.returncode != 0:
            return None, None, "RemoteTrackingRefMissing"
        tracking_commit = tracking.stdout.strip().lower()
        return {
            "source": "LocalSymbolicHead",
            "symbolicRef": f"refs/heads/{branch_name}",
            "trackingRef": local_symbolic_ref,
            "remoteCommit": tracking_commit,
            "trackingCommit": tracking_commit,
            "validatedAt": utc_now(),
            "remoteHeadAttempt": None,
        }, None, None

    remote, attempts, duration_ms = run_git_network(
        path, "ls-remote", "--symref", "origin", "HEAD"
    )
    attempt = network_attempt("ls-remote", remote, attempts, duration_ms)
    if remote.returncode != 0:
        return None, attempt, "RemoteHeadUnavailable"

    symbolic_refs = []
    remote_commits = []
    for line in remote.stdout.splitlines():
        fields = line.split()
        if len(fields) >= 3 and fields[0] == "ref:" and fields[2] == "HEAD":
            symbolic_refs.append(fields[1])
        elif len(fields) >= 2 and fields[1] == "HEAD" and re.fullmatch(
            r"[0-9a-fA-F]{40,64}", fields[0]
        ):
            remote_commits.append(fields[0].lower())
    if len(set(symbolic_refs)) != 1 or len(set(remote_commits)) != 1:
        return None, attempt, "RemoteHeadAmbiguous"

    symbolic_ref = symbolic_refs[0]
    if not symbolic_ref.startswith("refs/heads/"):
        return None, attempt, "RemoteHeadInvalid"
    branch_name = symbolic_ref.removeprefix("refs/heads/")
    tracking_ref = f"refs/remotes/origin/{branch_name}"
    if target.get("defaultBranch") and target["defaultBranch"] != branch_name:
        return None, attempt, "RemoteHeadMismatch"

    tracking = run_git(path, "rev-parse", "--verify", tracking_ref, check=False)
    if tracking.returncode != 0:
        return None, attempt, "RemoteTrackingRefMissing"
    tracking_commit = tracking.stdout.strip().lower()
    remote_commit = remote_commits[0]
    if tracking_commit != remote_commit:
        return None, attempt, "RemoteCommitMismatch"
    return {
        "source": "RemoteSymbolicHead",
        "symbolicRef": symbolic_ref,
        "trackingRef": tracking_ref,
        "remoteCommit": remote_commit,
        "trackingCommit": tracking_commit,
        "validatedAt": utc_now(),
        "remoteHeadAttempt": attempt,
    }, attempt, None


def classify_repository(
    target: dict, path: pathlib.Path, mode: str, allowed_dirty_paths: set[str] | None = None
) -> dict:
    if path.is_symlink() or (path.exists() and not path.is_dir()):
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Konfliktpfad nach manueller Prüfung entfernen oder verschieben / remove or relocate it after review.")
    if not path.exists():
        if mode == "check-only":
            return target_result(target, status="MISSING", action="CLONE_REQUIRED", result="Blocked",
                                 findingCode="MissingTarget", nextAction="Nach Remote-Prüfung im Update-Modus ausführen / run update after reviewing the remote.")
        if mode == "dry-run":
            return target_result(target, status="MISSING", action="WOULD_CLONE", result="Warning",
                                 findingCode="MissingTarget", nextAction="Update-Modus zum Klonen ausführen / run update to clone this target.")
        return clone_repository(target, path)
    if not (path / ".git").exists():
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Nicht-Git-Verzeichnis prüfen; es wird nie automatisch entfernt / review the directory; it is never removed.")

    origin = run_git(path, "remote", "get-url", "origin", check=False)
    if origin.returncode != 0 or normalize_remote(origin.stdout) != normalize_remote(target["remote"]):
        return target_result(target, status="REMOTE_MISMATCH", result="Blocked",
                             findingCode="RemoteMismatch", nextAction="origin nur nach manueller Prüfung korrigieren / correct origin only after review.")

    local_symbolic = run_git(
        path, "symbolic-ref", "--quiet", "refs/remotes/origin/HEAD", check=False
    )
    local_symbolic_ref = local_symbolic.stdout.strip() if local_symbolic.returncode == 0 else ""
    fetch, fetch_attempts, fetch_duration = run_git_network(path, "fetch", "--prune")
    freshness = network_attempt("fetch", fetch, fetch_attempts, fetch_duration)
    if fetch.returncode != 0:
        finding = "FetchTimedOut" if fetch.returncode == 124 else "FetchFailed"
        return target_result(
            target,
            status="UNAVAILABLE",
            result="Blocked",
            findingCode=finding,
            retryAttempts=fetch_attempts,
            freshnessAttempt=freshness,
            nextAction="Remote-Zugriff wiederherstellen und erneut ausführen / restore access and retry.",
        )

    default_evidence, _, default_error = resolve_default_branch_evidence(
        target, path, local_symbolic_ref
    )
    if default_error:
        return target_result(
            target,
            status="REMOTE_HEAD_INVALID",
            result="Blocked",
            findingCode=default_error,
            retryAttempts=fetch_attempts,
            freshnessAttempt=freshness,
            nextAction="Symbolischen origin-HEAD und Tracking-Ref prüfen / review the symbolic origin HEAD and tracking ref.",
        )

    branch = run_git(path, "symbolic-ref", "--quiet", "--short", "HEAD", check=False)
    if branch.returncode != 0:
        return target_result(
            target,
            status="DETACHED",
            result="Blocked",
            findingCode="DetachedHead",
            freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence,
            nextAction="Deklarierten Branch manuell auswählen / select the declared branch manually.",
        )
    branch_name = branch.stdout.strip()
    canonical_branch = default_evidence["symbolicRef"].removeprefix("refs/heads/")
    if branch_name != canonical_branch:
        return target_result(
            target,
            status="BRANCH_MISMATCH",
            result="Blocked",
            branch=branch_name,
            findingCode="BranchMismatch",
            freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence,
            nextAction="Nach Prüfung zum kanonischen Branch wechseln / switch to the canonical branch after review.",
        )

    dirty = run_git(path, "-c", "core.quotePath=false", "status", "--porcelain=v1", "--untracked-files=all").stdout
    resume_accepted = False
    if dirty:
        dirty_paths = {
            f"{target['path']}/{line[3:].split(' -> ')[-1]}".replace("\\", "/")
            for line in dirty.splitlines()
            if len(line) >= 4
        }
        resume_accepted = bool(allowed_dirty_paths) and dirty_paths.issubset(allowed_dirty_paths)
    if dirty and not resume_accepted:
        return target_result(
            target,
            status="DIRTY",
            result="Blocked",
            branch=branch_name,
            findingCode="DirtyWorktree",
            retryAttempts=fetch_attempts,
            freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence,
            nextAction="Lokale Arbeit ausdrücklich committen, stashen oder verwerfen / handle local work explicitly.",
        )
    upstream = run_git(path, "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{upstream}", check=False)
    if upstream.returncode != 0:
        return target_result(
            target,
            status="MISSING_UPSTREAM",
            result="Blocked",
            branch=branch_name,
            findingCode="MissingUpstream",
            freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence,
            nextAction="Deklarierten origin-Branch als Upstream setzen / set the declared origin branch as upstream.",
        )
    upstream_name = upstream.stdout.strip()
    if upstream_name != f"origin/{canonical_branch}":
        return target_result(
            target,
            status="MISSING_UPSTREAM",
            result="Blocked",
            branch=branch_name,
            upstream=upstream_name,
            findingCode="UpstreamMismatch",
            freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence,
            nextAction="Upstream auf den kanonischen origin-Branch ausrichten / align upstream with the canonical origin branch.",
        )
    counts = run_git(path, "rev-list", "--left-right", "--count", f"HEAD...{upstream_name}").stdout.split()
    ahead, behind = map(int, counts)
    if ahead and behind:
        return target_result(
            target, status="DIVERGED", result="Blocked", branch=branch_name,
            upstream=upstream_name, ahead=ahead, behind=behind, findingCode="Diverged",
            freshnessAttempt=freshness, defaultBranchEvidence=default_evidence,
            nextAction="Divergenz manuell lösen; kein Reset oder Force-Push / resolve manually; no reset or force push."
        )
    if ahead:
        return target_result(
            target, status="AHEAD", result="Blocked", branch=branch_name,
            upstream=upstream_name, ahead=ahead, findingCode="Ahead",
            freshnessAttempt=freshness, defaultBranchEvidence=default_evidence,
            nextAction="Lokale Commits separat prüfen und pushen / review and push separately."
        )
    if behind:
        if dirty:
            return target_result(
                target, status="DIRTY", result="Blocked", branch=branch_name,
                upstream=upstream_name, behind=behind, findingCode="DirtyWorktree",
                retryAttempts=fetch_attempts, resumeAccepted=resume_accepted,
                freshnessAttempt=freshness, defaultBranchEvidence=default_evidence,
                nextAction="Dirty-Zustand vor einem Fast-forward ausdrücklich auflösen / resolve dirty state before fast-forward."
            )
        if mode == "check-only":
            return target_result(
                target, status="BEHIND", action="PULL_REQUIRED", result="Blocked",
                branch=branch_name, upstream=upstream_name, behind=behind,
                findingCode="Behind", freshnessAttempt=freshness,
                defaultBranchEvidence=default_evidence,
                nextAction="Update-Modus für Fast-forward ausführen / run update for fast-forward."
            )
        if mode == "dry-run":
            return target_result(
                target, status="BEHIND", action="WOULD_PULL", result="Warning",
                branch=branch_name, upstream=upstream_name, behind=behind,
                findingCode="Behind", freshnessAttempt=freshness,
                defaultBranchEvidence=default_evidence,
                nextAction="Update-Modus zum Fast-forward ausführen / run update to fast-forward."
            )
        pull, pull_attempts, pull_duration = run_git_network(path, "pull", "--ff-only")
        pull_evidence = network_attempt("pull", pull, pull_attempts, pull_duration)
        if pull.returncode != 0:
            return target_result(
                target, status="UNAVAILABLE", action="PULL", result="Failed",
                branch=branch_name, upstream=upstream_name, behind=behind,
                retryAttempts=pull_attempts, resumeAccepted=resume_accepted,
                findingCode="PullFailed", freshnessAttempt=freshness,
                defaultBranchEvidence=default_evidence, pullAttempt=pull_evidence,
                nextAction="Log prüfen, manuell reparieren und erneut ausführen / inspect, repair and retry."
            )
        return target_result(
            target, status="UPDATED", action="PULL", branch=branch_name,
            upstream=upstream_name, retryAttempts=pull_attempts,
            resumeAccepted=resume_accepted, freshnessAttempt=freshness,
            defaultBranchEvidence=default_evidence, pullAttempt=pull_evidence,
            mutationAllowed=not dirty or resume_accepted
        )
    return target_result(
        target, branch=branch_name, upstream=upstream_name,
        retryAttempts=fetch_attempts, resumeAccepted=resume_accepted,
        freshnessAttempt=freshness, defaultBranchEvidence=default_evidence,
        mutationAllowed=not dirty or resume_accepted
    )


def clone_repository(target: dict, path: pathlib.Path) -> dict:
    path.parent.mkdir(parents=True, exist_ok=True)
    # Erst der geprüfte Geschwisterklon wird atomar sichtbar; Teilklone bleiben nie Sollzustand.
    # Only a verified sibling becomes visible; partial clones never become desired state.
    temporary = pathlib.Path(tempfile.mkdtemp(prefix=f".{path.name}.clone-", dir=path.parent))
    try:
        shutil.rmtree(temporary)
        clone, clone_attempts, clone_duration = run_git_network(
            None, "clone", "--origin", "origin", "--branch", target["defaultBranch"],
            "--single-branch", "--", target["remote"], str(temporary)
        )
        if clone.returncode != 0:
            return target_result(target, status="UNAVAILABLE", action="CLONE", result="Failed",
                                 retryAttempts=clone_attempts,
                                 freshnessAttempt=network_attempt(
                                     "clone", clone, clone_attempts, clone_duration
                                 ),
                                 findingCode="CloneFailed", nextAction="Remote prüfen und erneut ausführen; Ziel nicht akzeptiert / inspect and retry; target not accepted.")
        origin = run_git(temporary, "remote", "get-url", "origin").stdout
        branch = run_git(temporary, "branch", "--show-current").stdout.strip()
        dirty = run_git(temporary, "status", "--porcelain=v1", "--untracked-files=all").stdout
        if normalize_remote(origin) != normalize_remote(target["remote"]) or branch != target["defaultBranch"] or dirty:
            return target_result(target, status="UNAVAILABLE", action="CLONE", result="Failed",
                                 findingCode="CloneVerificationFailed",
                                 nextAction="Temporäre Clone-Evidence prüfen; Ziel nicht akzeptiert / inspect clone evidence; target not accepted.")
        os.replace(temporary, path)
        return target_result(
            target, status="CREATED", action="CLONE", branch=branch,
            upstream=f"origin/{branch}", retryAttempts=clone_attempts,
            freshnessAttempt=network_attempt("clone", clone, clone_attempts, clone_duration),
            mutationAllowed=True
        )
    finally:
        if temporary.exists():
            shutil.rmtree(temporary, ignore_errors=True)


def collection_result(target: dict, path: pathlib.Path, mode: str) -> dict:
    if path.is_symlink() or (path.exists() and not path.is_dir()):
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Konfliktpfad nach manueller Prüfung entfernen oder verschieben / remove or relocate it after review.")
    if path.exists():
        return target_result(target)
    if mode == "check-only":
        return target_result(target, status="MISSING", action="CREATE_REQUIRED", result="Blocked",
                             findingCode="MissingCollection", nextAction="Update-Modus zum Erstellen der Collection ausführen / run update to create it.")
    if mode == "dry-run":
        return target_result(target, status="MISSING", action="WOULD_CREATE", result="Warning",
                             findingCode="MissingCollection", nextAction="Update-Modus zum Erstellen der Collection ausführen / run update to create it.")
    path.mkdir(parents=True)
    return target_result(target, status="CREATED", action="CREATE")


def derive_status(results: list[dict], mode: str) -> tuple[str, int]:
    if any(item["result"] == "Failed" for item in results):
        return "PARTIAL", 1
    if any(item["result"] == "Blocked" for item in results):
        return "DRIFT", 1
    if any(item["result"] == "Warning" for item in results):
        return "DRIFT", 1
    return "SUCCESS", 0


def write_report(path: pathlib.Path, report: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    # Der atomare Austausch erhält die letzte vollständige Evidence bei Schreibfehlern.
    # Atomic replacement preserves the last complete evidence on write failure.
    temporary = path.with_name(f".{path.name}.{uuid.uuid4().hex}.tmp")
    temporary.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def process_identity(pid: int) -> str | None:
    if pid <= 0:
        return None
    if os.name == "nt":
        kernel32 = ctypes.windll.kernel32
        process = kernel32.OpenProcess(0x1000, False, pid)
        if not process:
            return None
        try:
            creation = ctypes.c_ulonglong()
            exit_time = ctypes.c_ulonglong()
            kernel = ctypes.c_ulonglong()
            user = ctypes.c_ulonglong()
            if not kernel32.GetProcessTimes(
                process,
                ctypes.byref(creation),
                ctypes.byref(exit_time),
                ctypes.byref(kernel),
                ctypes.byref(user),
            ):
                return None
            return f"windows-filetime:{creation.value}"
        finally:
            kernel32.CloseHandle(process)
    proc_stat = pathlib.Path(f"/proc/{pid}/stat")
    if proc_stat.is_file():
        try:
            fields = proc_stat.read_text(encoding="utf-8").split()
            return f"proc-start-ticks:{fields[21]}"
        except (OSError, UnicodeError, IndexError):
            return None
    result = subprocess.run(
        ["ps", "-o", "lstart=", "-p", str(pid)],
        text=True,
        capture_output=True,
        check=False,
    )
    value = result.stdout.strip()
    return f"ps-lstart:{value}" if result.returncode == 0 and value else None


def contained_path(raw: pathlib.Path, root: pathlib.Path, label: str) -> pathlib.Path:
    resolved = raw.resolve()
    try:
        resolved.relative_to(root.resolve())
    except ValueError as exc:
        raise ContractError(f"{label} escapes the reserved state directory") from exc
    return resolved


def load_worktree_lease(path: pathlib.Path, state_root: pathlib.Path) -> dict:
    lease_path = contained_path(path, state_root, "lease path")
    try:
        data = json.loads(lease_path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ContractError(f"lease cannot be read: {exc}") from exc
    required = {
        "schemaVersion",
        "runId",
        "ownerPid",
        "ownerProcessStartedAt",
        "repository",
        "remoteRef",
        "commit",
        "worktreePath",
        "leasePath",
        "createdAt",
    }
    if not isinstance(data, dict) or set(data) != required:
        raise ContractError("lease fields are incomplete or unknown")
    if data["schemaVersion"] != "1.0" or not isinstance(data["ownerPid"], int):
        raise ContractError("lease schema or owner PID is invalid")
    if pathlib.Path(data["leasePath"]).resolve() != lease_path:
        raise ContractError("lease path does not match its evidence")
    repository = pathlib.Path(data["repository"]).resolve()
    if not (repository / ".git").exists():
        raise ContractError("lease repository is not a Git checkout")
    worktree = contained_path(
        pathlib.Path(data["worktreePath"]), state_root, "worktree path"
    )
    if worktree == state_root.resolve():
        raise ContractError("worktree path cannot be the state root")
    if not re.fullmatch(r"[0-9a-fA-F]{40}|[0-9a-fA-F]{64}", str(data["commit"])):
        raise ContractError("lease commit is invalid")
    if not re.fullmatch(r"refs/remotes/origin/[A-Za-z0-9._/-]+", str(data["remoteRef"])):
        raise ContractError("lease remote ref is invalid")
    commit = run_git(repository, "cat-file", "-e", f"{data['commit']}^{{commit}}", check=False)
    if commit.returncode != 0:
        raise ContractError("lease commit is not present in its repository")
    data["_leasePath"] = lease_path
    data["_repository"] = repository
    data["_worktreePath"] = worktree
    return data


def worktree_registered(repository: pathlib.Path, worktree: pathlib.Path) -> bool:
    result = run_git(repository, "worktree", "list", "--porcelain", check=False)
    if result.returncode != 0:
        return False
    registered = {
        pathlib.Path(line.removeprefix("worktree ")).resolve()
        for line in result.stdout.splitlines()
        if line.startswith("worktree ")
    }
    return worktree.resolve() in registered


def remove_owned_worktree(lease: dict) -> None:
    repository = lease["_repository"]
    worktree = lease["_worktreePath"]
    lease_path = lease["_leasePath"]
    registered = worktree_registered(repository, worktree)
    if registered:
        worktree_head = run_git(worktree, "rev-parse", "HEAD", check=False)
        if (
            worktree_head.returncode != 0
            or worktree_head.stdout.strip().lower() != lease["commit"].lower()
        ):
            raise ContractError("registered worktree no longer matches its leased commit")
        status = run_git(worktree, "status", "--porcelain=v1", "-uall", check=False)
        if status.returncode != 0 or status.stdout:
            raise ContractError("registered worktree changed after cleanup authorization")
        removed = run_git(
            repository, "worktree", "remove", "--force", str(worktree), check=False
        )
        if removed.returncode != 0:
            raise ContractError("owned worktree could not be removed")
    elif worktree.exists():
        raise ContractError("unregistered worktree path is not safe to remove")
    # Die Kandidatenmenge wird nach Git erneut bestimmt; nur der nun leere,
    # leasegebundene Elternpfad darf entfernt werden.
    # Re-inventory after Git; only the now-empty lease-owned parent may be removed.
    parent = worktree.parent
    if parent.is_dir() and not any(parent.iterdir()):
        parent.rmdir()
    lease_path.unlink(missing_ok=True)


def create_worktree_lease(args: argparse.Namespace) -> int:
    try:
        state_root = args.state_root.resolve()
        state_root.mkdir(parents=True, exist_ok=True)
        lease_path = contained_path(args.lease, state_root, "lease path")
        worktree = contained_path(args.worktree, state_root, "worktree path")
        if lease_path.exists() or worktree.exists():
            raise ContractError("lease or worktree path already exists")
        if not args.run_id.strip():
            raise ContractError("lease run ID is empty")
        repository = args.repository.resolve()
        if not (repository / ".git").exists():
            raise ContractError("lease repository is not a Git checkout")
        identity = args.owner_process_identity or process_identity(args.owner_pid)
        if not identity:
            raise ContractError("owner process identity is unavailable")
        payload = {
            "schemaVersion": "1.0",
            "runId": args.run_id,
            "ownerPid": args.owner_pid,
            "ownerProcessStartedAt": identity,
            "repository": str(repository),
            "remoteRef": args.remote_ref,
            "commit": args.commit.lower(),
            "worktreePath": str(worktree),
            "leasePath": str(lease_path),
            "createdAt": utc_now(),
        }
        if not re.fullmatch(r"[0-9a-fA-F]{40}|[0-9a-fA-F]{64}", payload["commit"]):
            raise ContractError("lease commit is invalid")
        lease_path.parent.mkdir(parents=True, exist_ok=True)
        temporary = lease_path.with_name(f".{lease_path.name}.{uuid.uuid4().hex}.tmp")
        temporary.write_text(
            json.dumps(payload, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        os.replace(temporary, lease_path)
        print(f"LEASE\tCREATED\t{lease_path}")
        return 0
    except ContractError as exc:
        print(f"LEASE\tFAILED\t{exc}", file=sys.stderr)
        return 2


def release_worktree_lease(args: argparse.Namespace) -> int:
    try:
        lease_path = contained_path(args.lease, args.state_root.resolve(), "lease path")
        if not lease_path.exists():
            print(f"LEASE\tALREADY_RELEASED\t{lease_path}")
            return 0
        lease = load_worktree_lease(args.lease, args.state_root)
        if lease["runId"] != args.run_id:
            raise ContractError("lease run ID does not match release authority")
        remove_owned_worktree(lease)
        print(f"LEASE\tRELEASED\t{args.lease}")
        return 0
    except ContractError as exc:
        print(f"LEASE\tAMBIGUOUS\t{exc}", file=sys.stderr)
        return 1


def recover_worktree_leases(args: argparse.Namespace) -> int:
    state_root = args.state_root.resolve()
    lease_dir = contained_path(args.lease_dir, state_root, "lease directory")
    if not lease_dir.exists():
        print("LEASE_RECOVERY\tCURRENT\t0")
        return 0
    blocked = 0
    recovered = 0
    for lease_path in sorted(lease_dir.glob("*.json")):
        try:
            lease = load_worktree_lease(lease_path, state_root)
            current_identity = process_identity(lease["ownerPid"])
            if current_identity == lease["ownerProcessStartedAt"]:
                print(f"LEASE_RECOVERY\tACTIVE\t{lease_path.name}")
                continue
            if current_identity is not None:
                blocked += 1
                print(
                    f"LEASE_RECOVERY\tAMBIGUOUS_PID_REUSE\t{lease_path.name}",
                    file=sys.stderr,
                )
                continue
            remove_owned_worktree(lease)
            recovered += 1
            print(f"LEASE_RECOVERY\tRECOVERED\t{lease_path.name}")
        except ContractError as exc:
            blocked += 1
            print(
                f"LEASE_RECOVERY\tAMBIGUOUS\t{lease_path.name}\t{exc}",
                file=sys.stderr,
            )
    print(f"LEASE_RECOVERY\tSUMMARY\trecovered={recovered}\tblocked={blocked}")
    return 1 if blocked else 0


def execute_fleet(args: argparse.Namespace) -> int:
    started = time.monotonic()
    started_at = utc_now()
    run_id = args.run_id or str(uuid.uuid4())
    try:
        manifest = load_manifest(args.manifest)
    except ContractError as exc:
        report = {
            "schemaVersion": "1.0", "runId": run_id, "platform": sys.platform, "mode": args.mode,
            "startedAt": started_at, "completedAt": utc_now(), "overallStatus": "FAILED", "exitCode": 2,
            "stages": [{"stageId": "fleet", "status": "Failed", "exitCode": 2, "durationMs": 0,
                        "summary": str(exc), "nextAction": "Manifest korrigieren und erneut ausführen / correct the manifest and retry."}],
            "targets": [], "toolchain": [], "findings": [{"code": "ManifestInvalid", "severity": "Fatal",
            "summary": str(exc), "nextAction": "Manifest korrigieren und erneut ausführen / correct the manifest and retry."}],
            "artifacts": {"logPath": str(args.log), "reportPath": str(args.report)}
        }
        write_report(args.report, report)
        print(f"ERROR\tmanifest\tFAILED\t{exc}")
        return 2

    home = args.home_dir.resolve()
    allowed_dirty_paths = {item.replace("\\", "/") for item in args.allowed_dirty_path}
    results: list[dict] = []
    if args.level0_dir is not None:
        level0 = args.level0_dir.resolve()
        origin = run_git(level0, "remote", "get-url", "origin", check=False)
        branch = run_git(level0, "branch", "--show-current", check=False)
        if origin.returncode == 0 and branch.returncode == 0 and branch.stdout.strip():
            level0_target = {
                "id": "level0",
                "path": ".",
                "kind": "git-repository",
                "maintenanceClass": "canonical-fleet",
                "remote": origin.stdout.strip(),
                "defaultBranch": branch.stdout.strip(),
            }
            level0_result = classify_repository(
                level0_target, level0, args.mode, allowed_dirty_paths
            )
            results.append(level0_result)
            print(
                f"TARGET\tlevel0\t{level0_result['status']}\t"
                f"{level0_result['action']}\t{level0_result['nextAction']}"
            )
        else:
            results.append(
                target_result(
                    {
                        "id": "level0",
                        "path": ".",
                        "kind": "git-repository",
                        "maintenanceClass": "canonical-fleet",
                    },
                    status="REMOTE_MISMATCH",
                    result="Blocked",
                    findingCode="Level0OriginMissing",
                    nextAction="Level-0 origin und Branch prüfen / review Level 0 origin and branch.",
                )
            )
    for target in manifest["targets"]:
        if not target["active"]:
            continue
        relative = validate_relative_path(target["path"])
        target_path = home.joinpath(*relative.parts)
        result = (collection_result(target, target_path, args.mode)
                  if target["kind"] == "collection"
                  else classify_repository(target, target_path, args.mode, allowed_dirty_paths))
        results.append(result)
        print(f"TARGET\t{target['id']}\t{result['status']}\t{result['action']}\t{result['nextAction']}")

    overall, exit_code = derive_status(results, args.mode)
    findings = [
        {"targetId": item["targetId"], "code": item["findingCode"],
         "severity": "Blocking" if item["result"] in {"Blocked", "Failed"} else "Warning",
         "summary": item["status"], "nextAction": item["nextAction"]}
        for item in results if item["findingCode"] != "N/A"
    ]
    git_results = [item for item in results if item["kind"] == "git-repository"]
    collection_results = [item for item in results if item["kind"] == "collection"]
    completed_freshness = sum(
        isinstance(item.get("freshnessAttempt"), dict)
        and item["freshnessAttempt"].get("status") == "Succeeded"
        for item in git_results
    )
    fleet_ready = (
        len(git_results) == completed_freshness
        and all(item["result"] == "Pass" and item.get("mutationAllowed") for item in git_results)
    )
    operations = []
    for sequence, item in enumerate(results, start=1):
        attempt = item.get("freshnessAttempt")
        operations.append(
            {
                "sequence": sequence,
                "kind": (
                    attempt.get("operation", "inventory")
                    if isinstance(attempt, dict)
                    else "inventory"
                ),
                "targetId": item["targetId"],
                "status": (
                    attempt.get("status", item["status"])
                    if isinstance(attempt, dict)
                    else item["status"]
                ),
            }
        )
    operations.append(
        {
            "sequence": len(operations) + 1,
            "kind": "mutation-barrier",
            "targetId": "fleet",
            "status": "Open" if fleet_ready else "Blocked",
        }
    )
    report = {
        "schemaVersion": "1.0", "runId": run_id, "platform": sys.platform, "mode": args.mode,
        "startedAt": started_at, "completedAt": utc_now(), "overallStatus": overall, "exitCode": exit_code,
        "stages": [{"stageId": "fleet", "status": "Passed" if exit_code == 0 else "Blocked",
                    "exitCode": exit_code, "durationMs": int((time.monotonic() - started) * 1000),
                    "summary": f"{len(results)} active targets evaluated.",
                    "nextAction": "N/A" if exit_code == 0 else "Blockierende Zielbefunde beheben / resolve blocking target findings."}],
        "targets": results, "toolchain": [], "findings": findings,
        "operations": operations,
        "mutationBarrier": {
            "expectedGitTargets": len(git_results),
            "completedGitTargets": completed_freshness,
            "collectionTargets": len(collection_results),
            "allFetchAttemptsCompleted": completed_freshness == len(git_results),
            "fleetReady": fleet_ready,
            "domainMutationAllowed": fleet_ready and args.mode == "update",
            "decidedAt": utc_now(),
            "nextAction": (
                "N/A"
                if fleet_ready
                else "Alle blockierenden Flottenbefunde beheben / resolve all blocking fleet findings."
            ),
        },
        "counts": {
            "targets": len(results),
            "passed": sum(item["result"] == "Pass" for item in results),
            "warnings": sum(item["result"] == "Warning" for item in results),
            "blocked": sum(item["result"] == "Blocked" for item in results),
            "failed": sum(item["result"] == "Failed" for item in results)
        },
        "artifacts": {"logPath": str(args.log), "reportPath": str(args.report)}
    }
    write_report(args.report, report)
    print(f"SUMMARY\tfleet\t{overall}\t{exit_code}\t{args.report}")
    return exit_code


def read_toolchain_result(path: pathlib.Path) -> tuple[dict | None, str | None]:
    if not path.exists():
        return None, "ResultMissing"
    if not path.is_file():
        return None, "ResultNotFile"
    try:
        payload = path.read_bytes()
    except OSError:
        return None, "ResultUnreadable"
    if not payload.strip():
        return None, "ResultEmpty"
    try:
        text = payload.decode("utf-8-sig")
    except UnicodeDecodeError:
        return None, "ResultInvalidUtf8"
    try:
        result = json.loads(text)
    except json.JSONDecodeError:
        failure = "ResultTruncated" if not text.rstrip().endswith("}") else "ResultMalformed"
        return None, failure
    if not isinstance(result, dict):
        return None, "ResultSchemaMismatch"
    required_types = {
        "schemaVersion": str,
        "platform": str,
        "mode": str,
        "overallStatus": str,
        "exitCode": int,
        "items": list,
        "remainingRequired": list,
        "optionalDrift": list,
        "nextAction": str,
    }
    if any(not isinstance(result.get(key), expected) for key, expected in required_types.items()):
        return None, "ResultSchemaMismatch"
    expected_exit = 2 if result["overallStatus"] == "FAILED" else 1 if result["overallStatus"] == "PARTIAL" else 0
    if (
        result["schemaVersion"] != "1.0"
        or result["platform"] not in {"Darwin", "Linux"}
        or result["mode"] not in {"update", "dry-run", "compare-only"}
        or result["overallStatus"] not in {"SUCCESS", "SUCCESS_WITH_WARNINGS", "PARTIAL", "FAILED"}
        or result["exitCode"] != expected_exit
        or any(not isinstance(item, str) for item in result["remainingRequired"])
        or any(not isinstance(item, str) for item in result["optionalDrift"])
    ):
        return None, "ResultSchemaMismatch"
    return result, None


def read_storage_result(path: pathlib.Path) -> tuple[dict | None, str | None]:
    """Read the atomically published storage result with a fail-closed schema."""
    if not path.exists():
        return None, "ResultMissing"
    if not path.is_file():
        return None, "ResultNotFile"
    try:
        payload = path.read_bytes()
    except OSError:
        return None, "ResultUnreadable"
    if not payload.strip():
        return None, "ResultEmpty"
    try:
        text = payload.decode("utf-8-sig")
    except UnicodeDecodeError:
        return None, "ResultInvalidUtf8"
    try:
        result = json.loads(text)
    except json.JSONDecodeError:
        failure = "ResultTruncated" if not text.rstrip().endswith("}") else "ResultMalformed"
        return None, failure
    if not isinstance(result, dict):
        return None, "ResultSchemaMismatch"
    required_types = {
        "schemaVersion": str,
        "runId": str,
        "platform": str,
        "mode": str,
        "profile": str,
        "overallStatus": str,
        "exitCode": int,
        "repositories": list,
        "providers": list,
        "warnings": list,
        "nextAction": str,
    }
    if any(not isinstance(result.get(key), expected) for key, expected in required_types.items()):
        return None, "ResultSchemaMismatch"
    expected_exit = 2 if result["overallStatus"] == "FAILED" else 0
    if (
        result["schemaVersion"] != "1.0"
        or result["platform"] not in {"darwin", "linux", "win32"}
        or result["mode"] not in {"update", "dry-run", "check-only"}
        or result["profile"] not in {"safe", "deep", "none"}
        or result["overallStatus"] not in {"SUCCESS", "SUCCESS_WITH_WARNINGS", "FAILED"}
        or result["exitCode"] != expected_exit
        or any(not isinstance(item, str) for item in result["warnings"])
    ):
        return None, "ResultSchemaMismatch"
    try:
        if str(uuid.UUID(result["runId"])) != result["runId"]:
            return None, "ResultSchemaMismatch"
    except ValueError:
        return None, "ResultSchemaMismatch"
    return result, None


def record_stage(args: argparse.Namespace) -> int:
    try:
        report = json.loads(args.report.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"ERROR\treport\tFAILED\t{exc}")
        return 2
    stages = report.setdefault("stages", [])
    stages[:] = [item for item in stages if item.get("stageId") != args.stage_id]
    stage = {
        "stageId": args.stage_id,
        "status": args.status,
        "exitCode": args.exit_code,
        "durationMs": args.duration_ms,
        "summary": args.summary,
        "nextAction": args.next_action,
    }
    if args.evidence_path:
        stage["evidencePath"] = str(args.evidence_path)
    stages.append(stage)
    if args.toolchain_results:
        toolchain_result, failure_class = read_toolchain_result(args.toolchain_results)
        if failure_class:
            print(
                "ERROR\ttoolchain-results\tFAILED\t"
                f"{failure_class}\tRegenerate the toolchain result atomically."
            )
            return 2
        assert toolchain_result is not None
        items = toolchain_result.get("items")
        if (
            toolchain_result.get("schemaVersion") != "1.0"
            or not isinstance(items, list)
        ):
            print("ERROR\ttoolchain-results\tFAILED\tinvalid result schema")
            return 2
        report["toolchain"] = items
        report["toolchainResult"] = {
            "overallStatus": toolchain_result.get("overallStatus"),
            "exitCode": toolchain_result.get("exitCode"),
            "remainingRequired": toolchain_result.get("remainingRequired", []),
            "optionalDrift": toolchain_result.get("optionalDrift", []),
            "nextAction": toolchain_result.get("nextAction", "N/A"),
        }
        if "failureClass" in toolchain_result:
            report["toolchainResult"]["failureClass"] = toolchain_result["failureClass"]
    if args.storage_results:
        storage_result, failure_class = read_storage_result(args.storage_results)
        if failure_class:
            print(
                "ERROR\tstorage-results\tFAILED\t"
                f"{failure_class}\tRegenerate the storage result atomically."
            )
            return 2
        assert storage_result is not None
        if report.get("runId") and storage_result["runId"] != report["runId"]:
            print("ERROR\tstorage-results\tFAILED\tRunMismatch")
            return 2
        report["storageCleanup"] = storage_result
        report.setdefault("artifacts", {})["storageReportPath"] = str(args.storage_results)
    report["completedAt"] = utc_now()
    statuses = {item.get("status") for item in stages}
    if "Interrupted" in statuses:
        report["overallStatus"] = "INTERRUPTED"
        report["exitCode"] = max(
            int(item.get("exitCode", 0))
            for item in stages
            if item.get("status") == "Interrupted"
        )
    elif "Failed" in statuses:
        report["overallStatus"], report["exitCode"] = "FAILED", 2
    elif statuses.intersection({"Blocked", "DeferredAdminRequired"}):
        report["overallStatus"], report["exitCode"] = "PARTIAL", 1
    elif "Warning" in statuses:
        warning_exit = max(
            int(item.get("exitCode", 0))
            for item in stages
            if item.get("status") == "Warning"
        )
        report["overallStatus"] = "SUCCESS_WITH_WARNINGS"
        report["exitCode"] = warning_exit
    write_report(args.report, report)
    return 0


def finalize_report(args: argparse.Namespace) -> int:
    """Finalize exactly one run-correlated report through atomic replacement."""
    try:
        report = json.loads(args.report.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"ERROR\treport\tFAILED\t{exc}")
        return 2
    if report.get("finalized") is True:
        print(
            f"FINALIZE\t{report.get('runId', 'unknown')}\tALREADY_FINALIZED\t"
            f"{report.get('exitCode', 2)}"
        )
        return 0

    signal_name = args.signal
    canonical_signal_exit = {"INT": 130, "TERM": 143}
    if signal_name != "N/A":
        expected = canonical_signal_exit.get(signal_name)
        if expected is None or args.status != "Interrupted" or args.exit_code != expected:
            print("ERROR\tfinalize\tFAILED\tinvalid signal finalization contract")
            return 2

    stages = report.setdefault("stages", [])
    stages[:] = [item for item in stages if item.get("stageId") != args.stage_id]
    stages.append(
        {
            "stageId": args.stage_id,
            "status": args.status,
            "exitCode": args.exit_code,
            "durationMs": args.duration_ms,
            "summary": args.summary,
            "nextAction": args.next_action,
        }
    )
    if args.status == "Interrupted":
        overall = "INTERRUPTED"
    elif args.status == "Failed":
        overall = "FAILED"
    elif args.status in {"Blocked", "DeferredAdminRequired"}:
        overall = "PARTIAL"
    elif args.status == "Warning":
        overall = "SUCCESS_WITH_WARNINGS"
    else:
        overall = "SUCCESS"
    completed_at = utc_now()
    report.update(
        {
            "completedAt": completed_at,
            "overallStatus": overall,
            "exitCode": args.exit_code,
            "lastStage": args.stage_id,
            "signal": signal_name,
            "finalized": True,
            "finalizedAt": completed_at,
            "nextAction": args.next_action,
        }
    )
    write_report(args.report, report)
    print(
        f"FINALIZE\t{report.get('runId', 'unknown')}\t{overall}\t"
        f"{args.exit_code}\t{args.stage_id}"
    )
    return 0


def validate_registry(args: argparse.Namespace) -> int:
    try:
        manifest = load_manifest(args.manifest)
        registry = json.loads(args.registry.read_text(encoding="utf-8-sig"))
    except (ContractError, OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"REGISTRY\tFAILED\t{exc}")
        return 2
    expected = {
        item["path"].casefold()
        for item in manifest["targets"]
        if item["active"] and item["kind"] == "git-repository"
        and item["maintenanceClass"] == "canonical-fleet"
    }
    entries = registry.get("repositories", []) if isinstance(registry, dict) else registry
    if not isinstance(entries, list):
        print("REGISTRY\tFAILED\trepositories must be an array")
        return 2
    actual: set[str] = set()
    language_findings: list[str] = []
    for entry in entries:
        if not isinstance(entry, dict) or not isinstance(entry.get("path"), str):
            print("REGISTRY\tFAILED\tinvalid repository entry")
            return 2
        path = validate_relative_path(entry["path"]).as_posix().casefold()
        if path not in expected:
            print(f"REGISTRY\tFAILED\tnon-canonical propagation target: {entry['path']}")
            return 2
        if path in actual:
            print(f"REGISTRY\tFAILED\tduplicate propagation target: {entry['path']}")
            return 2
        actual.add(path)
        language = str(entry.get("primaryLanguage", "")).strip().casefold()
        status = str(entry.get("mslStatus", "")).strip().casefold()
        expected_status = None
        if language in KNOWN_MSL_LANGUAGES:
            expected_status = "msl"
        elif language in KNOWN_NON_MSL_LANGUAGES:
            expected_status = "non-msl"
        elif language == "none":
            expected_status = "n/a"
        if expected_status is not None and status != expected_status:
            language_findings.append(
                f"{entry['path']}: language={entry.get('primaryLanguage')} "
                f"expects mslStatus={expected_status}, found {entry.get('mslStatus')}"
            )
    missing = expected - actual
    if missing:
        print(f"REGISTRY\tDRIFT\tmissing canonical targets: {len(missing)}")
        return 1
    if language_findings:
        for finding in language_findings:
            print(
                "REGISTRY\tLANGUAGE_MSL_CONFLICT\t"
                f"{finding}\tnext=Kuratierte Registry-Einstufung prüfen / review curated classification"
            )
        return 1
    print(f"REGISTRY\tCURRENT\tcanonical targets: {len(actual)}")
    return 0


def resolve_preset_profile(args: argparse.Namespace) -> int:
    try:
        catalog = json.loads(args.catalog.read_text(encoding="utf-8-sig"))
        profiles = catalog.get("profiles", {}) if isinstance(catalog, dict) else {}
        if not isinstance(profiles, dict):
            raise ContractError("preset profiles must be an object")
        profile_name = args.profile or catalog.get("defaultProfile")
        if not isinstance(profile_name, str) or profile_name not in profiles:
            raise ContractError(f"unknown preset profile: {profile_name}")
        profile = profiles[profile_name]
        relative = profile.get("presetConfig") if isinstance(profile, dict) else None
        if not isinstance(relative, str) or not relative:
            raise ContractError(f"preset profile has no matrix: {profile_name}")
        source_root = args.source_root.resolve()
        config = contained_path(source_root / relative, source_root, "preset matrix")
        matrix = json.loads(config.read_text(encoding="utf-8-sig"))
        presets = matrix.get("presets", []) if isinstance(matrix, dict) else []
        preset_ids = [
            item.get("id") for item in presets
            if isinstance(item, dict) and isinstance(item.get("id"), str)
        ]
        if not preset_ids or len(preset_ids) != len(presets) or len(set(preset_ids)) != len(preset_ids):
            raise ContractError("preset matrix IDs are empty, invalid or duplicated")
        result = {
            "profileName": profile_name,
            "presetConfig": str(config),
            "presetIds": preset_ids,
            "presetCount": len(preset_ids),
        }
        if args.field == "path":
            print(result["presetConfig"])
        else:
            print(json.dumps(result, ensure_ascii=False, separators=(",", ":")))
        return 0
    except (ContractError, OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"PROFILE\tFAILED\t{exc}", file=sys.stderr)
        return 2


def list_canonical_repositories(args: argparse.Namespace) -> int:
    """Print active canonical Git repositories as level/path TSV records."""
    try:
        manifest = load_manifest(args.manifest)
    except ContractError as exc:
        print(f"REPOSITORIES\tFAILED\t{exc}", file=sys.stderr)
        return 2

    home = args.home_dir.resolve()
    repositories: list[tuple[int, pathlib.Path]] = []
    for target in manifest["targets"]:
        if (
            not target["active"]
            or target["kind"] != "git-repository"
            or target["maintenanceClass"] != "canonical-fleet"
        ):
            continue
        relative = validate_relative_path(target["path"])
        repository = home.joinpath(*relative.parts).resolve()
        try:
            repository.relative_to(home)
        except ValueError:
            print(
                f"REPOSITORIES\tFAILED\ttarget resolves outside HOME: {target['path']}",
                file=sys.stderr,
            )
            return 2
        if args.existing_only and not (repository / ".git").is_dir():
            continue
        repositories.append((target["level"], repository))

    for level, repository in sorted(repositories, key=lambda item: (item[0], str(item[1]).casefold())):
        print(f"{level}\t{repository}")
    return 0


def print_default_remote_ref(args: argparse.Namespace) -> int:
    repository = args.repository.resolve()
    origin = run_git(repository, "remote", "get-url", "origin", check=False)
    if origin.returncode != 0:
        print("DEFAULT_REF\tFAILED\torigin is unavailable", file=sys.stderr)
        return 2
    local = run_git(
        repository,
        "symbolic-ref",
        "--quiet",
        "refs/remotes/origin/HEAD",
        check=False,
    )
    local_ref = local.stdout.strip() if local.returncode == 0 else ""
    evidence, _, error = resolve_default_branch_evidence(
        {"remote": origin.stdout.strip(), "defaultBranch": ""},
        repository,
        local_ref,
    )
    if error or evidence is None:
        print(f"DEFAULT_REF\tFAILED\t{error or 'unknown'}", file=sys.stderr)
        return 1
    print(evidence["trackingRef"])
    return 0


def append_maintenance_event(args: argparse.Namespace) -> int:
    """Append one validated, complete JSONL maintenance event."""
    try:
        run_id = str(uuid.UUID(args.run_id))
        details = json.loads(args.details_json)
        if not isinstance(details, dict):
            raise ContractError("event details must be an object")
        if args.sequence < 1:
            raise ContractError("event sequence must be positive")
        event_stream = args.event_stream.resolve()
        event_stream.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        payload = {
            "schemaVersion": 1,
            "runId": run_id,
            "sequence": args.sequence,
            "timestampUtc": utc_now(),
            "eventType": args.event_type,
            "status": args.status,
            "phaseId": args.phase_id,
            "targetId": args.target_id,
            "messageDe": args.message_de,
            "messageEn": args.message_en,
            "details": details,
        }
        encoded = (
            json.dumps(payload, ensure_ascii=False, separators=(",", ":")) + "\n"
        ).encode("utf-8")
        descriptor = os.open(
            event_stream,
            os.O_APPEND | os.O_CREAT | os.O_WRONLY,
            0o600,
        )
        try:
            os.write(descriptor, encoded)
            os.fsync(descriptor)
        finally:
            os.close(descriptor)
        return 0
    except (ContractError, OSError, UnicodeError, ValueError, json.JSONDecodeError) as exc:
        print(f"EVENT\tFAILED\t{exc}", file=sys.stderr)
        return 2


class CIGateBlocked(RuntimeError):
    """Raised for a validated input whose current gate decision is blocked."""


def _ci_platform() -> str:
    if sys.platform == "darwin":
        return "macos"
    if sys.platform.startswith("win"):
        return "windows"
    return "linux"


def _ci_repository_id(repository: pathlib.Path, explicit: str | None) -> str:
    if explicit:
        return validate_ci_input_component(explicit)
    origin = run_git(repository, "remote", "get-url", "origin", check=False)
    if origin.returncode != 0:
        raise ContractError("configured origin is required to resolve repositoryId")
    normalized = normalize_remote(origin.stdout.strip())
    if normalized.endswith("/home-baseline"):
        return "home-baseline"
    return validate_ci_input_component(pathlib.PurePosixPath(normalized).name)


def _ci_selected_gates(contracts: dict, profile: dict, changed_paths: list[str]) -> tuple[list[dict], list[str]]:
    gate_set = next(
        (item for item in contracts["profiles"]["gateSets"] if item["gateSetId"] == profile["gateSetId"]),
        None,
    )
    if gate_set is None:
        raise ContractError(f"unknown gateSetId: {profile['gateSetId']}")
    normalized_paths = sorted({_normalize_changed_path(path) for path in changed_paths})
    matched_contracts: list[dict] = []
    selected_ids: set[str] = set()
    for contract in contracts["paths"]["pathContracts"]:
        if not normalized_paths:
            continue
        matched_paths = [
            path for path in normalized_paths
            if any(fnmatch.fnmatch(path, pattern) for pattern in contract["includePatterns"])
            and not any(fnmatch.fnmatch(path, pattern) for pattern in contract["excludePatterns"])
        ]
        if matched_paths:
            matched_contracts.append(contract)
            selected_ids.update(contract["gateIds"])
    if not selected_ids:
        selected_ids = {gate["gateId"] for gate in gate_set["gates"]}
    selected = [gate for gate in gate_set["gates"] if gate["gateId"] in selected_ids]
    if len(selected) != len(selected_ids):
        raise ContractError("selected gate set contains an unknown gate")
    return selected, sorted(contract["pathContractId"] for contract in matched_contracts)


def _normalize_changed_path(raw: str) -> str:
    if (
        not isinstance(raw, str)
        or not raw
        or raw.startswith(("/", "-"))
        or "\\" in raw
        or any(character in raw for character in ("\r", "\n", "\0"))
        or ".." in pathlib.PurePosixPath(raw).parts
    ):
        raise ContractError(f"unsafe changed path: {raw!r}")
    return pathlib.PurePosixPath(raw).as_posix()


def _ci_gate_set_hash(
    gate_set_id: str, version: str, gates: list[dict], matched_contract_ids: list[str]
) -> str:
    return canonical_json_hash(
        {
            "schemaVersion": "1.0",
            "gateSetId": gate_set_id,
            "version": version,
            "gates": gates,
            "matchedPathContractIds": matched_contract_ids,
        }
    )


def _ci_head(repository: pathlib.Path, fixture_head: str | None = None) -> str:
    sequence_file = os.environ.get("HB_CI_HEAD_SEQUENCE_FILE")
    if sequence_file:
        sequence_path = pathlib.Path(sequence_file)
        values = sequence_path.read_text(encoding="utf-8").splitlines()
        if not values:
            raise ContractError("injected HEAD sequence is exhausted")
        head = values.pop(0)
        sequence_path.write_text("\n".join(values) + ("\n" if values else ""), encoding="utf-8")
        if not re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", head):
            raise ContractError("injected HEAD is invalid")
        return head
    if fixture_head is not None:
        if not re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", fixture_head):
            raise ContractError("fixture head must be a full lowercase Git object ID")
        return fixture_head
    result = run_git(repository, "rev-parse", "HEAD", check=False)
    head = result.stdout.strip()
    if result.returncode != 0 or not re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", head):
        raise ContractError("a stable full HEAD is required")
    return head


def _ci_evidence_path(
    root: pathlib.Path, repository_id: str, head: str, *, create_parent: bool = True
) -> pathlib.Path:
    repository_id = validate_ci_input_component(repository_id)
    if not re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", head):
        raise ContractError("unsafe evidence HEAD")
    expanded_root = root.expanduser()
    probe = expanded_root if expanded_root.is_absolute() else pathlib.Path.cwd() / expanded_root
    # macOS exposes /var as the supported /private/var alias. Reject an
    # attacker-controlled evidence-root link itself while canonicalizing
    # platform-owned ancestor aliases.
    if probe.exists() and probe.is_symlink():
        raise ContractError(f"unsafe symlink evidence parent: {probe}")
    root = expanded_root.resolve(strict=False)
    destination = root / repository_id / f"{head}.json"
    destination_parent = destination.parent
    if create_parent:
        destination_parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    if destination_parent.exists() and destination_parent.is_symlink():
        raise ContractError("unsafe symlink evidence directory")
    return destination


def _atomic_ci_json(path: pathlib.Path, value: dict) -> None:
    descriptor, temporary_name = tempfile.mkstemp(prefix=f".{path.name}.", dir=path.parent)
    temporary = pathlib.Path(temporary_name)
    try:
        os.fchmod(descriptor, 0o600)
        encoded = (json.dumps(value, ensure_ascii=False, separators=(",", ":")) + "\n").encode("utf-8")
        os.write(descriptor, encoded)
        os.fsync(descriptor)
        os.close(descriptor)
        descriptor = -1
        parsed = json.loads(temporary.read_text(encoding="utf-8"))
        _validate_ci_gate_evidence(parsed)
        os.replace(temporary, path)
        try:
            directory_descriptor = os.open(path.parent, os.O_RDONLY)
            try:
                os.fsync(directory_descriptor)
            finally:
                os.close(directory_descriptor)
        except OSError:
            pass
    finally:
        if descriptor >= 0:
            os.close(descriptor)
        temporary.unlink(missing_ok=True)


def _validate_ci_gate_evidence(value: dict) -> None:
    expected = {
        "schemaVersion", "repositoryId", "headCommit", "ciProfile", "gateSetHash",
        "platform", "generatedAt", "hookVersion", "status", "results",
    }
    _require_exact_keys(value, expected, "CI gate evidence")
    if value["schemaVersion"] != "1.0" or value["status"] != "Passed":
        raise ContractError("only schema 1.0 Passed evidence may be published")
    validate_ci_input_component(value["repositoryId"])
    if not re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", str(value["headCommit"])):
        raise ContractError("evidence HEAD is invalid")
    if not re.fullmatch(r"[0-9a-f]{64}", str(value["gateSetHash"])):
        raise ContractError("evidence gate-set hash is invalid")
    if value["platform"] not in {"macos", "linux", "windows"}:
        raise ContractError("evidence platform is invalid")
    if not re.fullmatch(r"\d+\.\d+\.\d+", str(value["hookVersion"])):
        raise ContractError("evidence hookVersion is invalid")
    results = value["results"]
    if not isinstance(results, list) or not results:
        raise ContractError("evidence results must be non-empty")
    for expected_order, result in enumerate(results, start=1):
        _require_exact_keys(
            result,
            {"order", "gateId", "commandDigest", "status", "exitCode", "durationMs"},
            f"CI gate evidence result {expected_order}",
        )
        if (
            result["order"] != expected_order
            or result["status"] != "Passed"
            or result["exitCode"] != 0
            or not re.fullmatch(r"[0-9a-f]{64}", str(result["commandDigest"]))
        ):
            raise ContractError("CI gate result is incomplete or unordered")


def _print_ci_gate_status(
    profile_name: str,
    decision: str,
    status: str,
    blocker: str,
    next_action: str,
    gate_hash: str,
    gates: list[dict],
    evidence_path: pathlib.Path,
) -> None:
    print(f"Profil / Profile: {profile_name}")
    print(f"Entscheidung / Decision: {decision}")
    print(f"Status: {status}")
    print(f"Blocker: {blocker}")
    print(f"Naechste Aktion / Next action: {next_action}")
    print(f"Gate-Set-Hash: {gate_hash}")
    for gate in gates:
        print(f"Gate {gate['order']}: {gate['gateId']}")
    print(f"Evidence-Ziel / Evidence target: {evidence_path}")


def execute_ci_gate(args: argparse.Namespace) -> int:
    try:
        repository = args.repository_root.resolve()
        contracts = load_ci_budget_contracts(args.profiles, args.path_contracts, args.workflow_template)
        repository_id = _ci_repository_id(repository, args.repository_id)
        assignment = next(
            (item for item in contracts["profiles"]["assignments"] if item["repositoryId"] == repository_id),
            None,
        )
        if assignment is None:
            raise CIGateBlocked(f"repository has no explicit profile assignment: {repository_id}")
        profile = next(
            item for item in contracts["profiles"]["profiles"]
            if item["profileId"] == assignment["profileId"]
        )
        changed_paths = list(args.changed_path)
        if not changed_paths:
            changed = run_git(repository, "diff", "--name-only", "HEAD", check=False)
            if changed.returncode == 0:
                changed_paths = [line for line in changed.stdout.splitlines() if line]
        gates, matched_contracts = _ci_selected_gates(contracts, profile, changed_paths)
        gate_set = next(
            item for item in contracts["profiles"]["gateSets"]
            if item["gateSetId"] == profile["gateSetId"]
        )
        gate_hash = _ci_gate_set_hash(
            gate_set["gateSetId"], gate_set["version"], gates, matched_contracts
        )
        head_before = _ci_head(repository, args.fixture_head)
        evidence_root = args.evidence_root or pathlib.Path(
            os.environ.get("HB_CI_EVIDENCE_ROOT", "~/.home-baseline/evidence/ci-gates")
        )
        evidence_path = _ci_evidence_path(
            evidence_root, repository_id, head_before, create_parent=not args.dry_run
        )
        if args.dry_run:
            _print_ci_gate_status(
                profile["displayName"], "Preview", "Passed", "None",
                "Run without preview only after review.", gate_hash, gates, evidence_path,
            )
            return 0
        evidence_path.unlink(missing_ok=True)
        results = []
        for gate in gates:
            working = repository if gate["workingDirectory"] == "." else resolve_ci_contained_path(
                repository, pathlib.PurePosixPath(gate["workingDirectory"])
            )
            executable = gate["executable"]
            if "/" in executable:
                executable_path = resolve_ci_contained_path(repository, pathlib.PurePosixPath(executable))
                if not executable_path.is_file():
                    raise ContractError(f"gate executable is missing: {executable}")
                command = [str(executable_path), *gate["arguments"]]
            else:
                if shutil.which(executable) is None:
                    raise ContractError(f"gate executable is unavailable: {executable}")
                command = [executable, *gate["arguments"]]
            started = time.monotonic()
            try:
                completed = subprocess.run(
                    command,
                    cwd=working,
                    text=True,
                    capture_output=True,
                    shell=False,
                    check=False,
                    timeout=gate["timeoutSeconds"],
                )
            except subprocess.TimeoutExpired as exc:
                raise CIGateBlocked(f"gate timed out: {gate['gateId']}") from exc
            if completed.returncode != 0:
                diagnostic = (completed.stderr or completed.stdout).strip().splitlines()
                safe_detail = diagnostic[-1][:240] if diagnostic else "no diagnostic"
                safe_detail = safe_detail.replace(str(pathlib.Path.home()), "<home>")
                raise CIGateBlocked(
                    f"gate failed: {gate['gateId']} ({completed.returncode}; {safe_detail})"
                )
            results.append(
                {
                    # A path-dependent subset retains gate precedence but its
                    # evidence rows form their own contiguous executed sequence.
                    "order": len(results) + 1,
                    "gateId": gate["gateId"],
                    "commandDigest": canonical_json_hash(command),
                    "status": "Passed",
                    "exitCode": 0,
                    "durationMs": int((time.monotonic() - started) * 1000),
                }
            )
        head_after = _ci_head(repository, args.fixture_head)
        reloaded = load_ci_budget_contracts(args.profiles, args.path_contracts, args.workflow_template)
        gates_after, matched_after = _ci_selected_gates(reloaded, profile, changed_paths)
        gate_set_after = next(
            item for item in reloaded["profiles"]["gateSets"]
            if item["gateSetId"] == profile["gateSetId"]
        )
        hash_after = _ci_gate_set_hash(
            gate_set_after["gateSetId"], gate_set_after["version"], gates_after, matched_after
        )
        if head_before != head_after or gate_hash != hash_after:
            raise CIGateBlocked("HEAD or gate-set hash changed during execution")
        evidence = {
            "schemaVersion": "1.0",
            "repositoryId": repository_id,
            "headCommit": head_before,
            "ciProfile": profile["displayName"],
            "gateSetHash": gate_hash,
            "platform": _ci_platform(),
            "generatedAt": utc_now(),
            "hookVersion": "1.0.0",
            "status": "Passed",
            "results": results,
        }
        _atomic_ci_json(evidence_path, evidence)
        _print_ci_gate_status(
            profile["displayName"], "LocalGate", "Passed", "None",
            "Review the evidence; server-side policy remains required.", gate_hash, gates, evidence_path,
        )
        return 0
    except KeyboardInterrupt:
        print("Status: Interrupted", file=sys.stderr)
        return 130
    except CIGateBlocked as exc:
        print(f"CI_GATE\tBLOCKED\t{exc}", file=sys.stderr)
        return 1
    except (ContractError, OSError, RuntimeError, StopIteration) as exc:
        print(f"CI_GATE\tFAILED\t{exc}", file=sys.stderr)
        return 2


def simulate_private_governance_policy(
    workflow_template: pathlib.Path,
    ruleset_template: pathlib.Path,
) -> dict:
    """Validate the deliberately small Stage-A workflow/ruleset subset."""
    try:
        workflow_text = workflow_template.read_text(encoding="utf-8")
        ruleset = json.loads(ruleset_template.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ContractError(f"workflow/ruleset template cannot be read: {exc}") from exc

    def scalar(name: str) -> str:
        match = re.search(rf"^{re.escape(name)}:\s*([^\n]+)\s*$", workflow_text, re.MULTILINE)
        if match is None:
            raise ContractError(f"workflow field is missing: {name}")
        return match.group(1).strip().strip('"\'')

    trigger_block = re.search(
        r"^triggers:\s*$\n(?P<body>(?:\s+-\s+[a-z_]+\s*$\n?)+)",
        workflow_text,
        re.MULTILINE,
    )
    triggers = re.findall(r"^\s+-\s+([a-z_]+)\s*$", trigger_block.group("body"), re.MULTILINE) if trigger_block else []
    gate_block = re.search(
        r"^gateIds:\s*$\n(?P<body>(?:\s+-\s+[a-z0-9-]+\s*$\n?)+)",
        workflow_text,
        re.MULTILINE,
    )
    gate_ids = re.findall(r"^\s+-\s+([a-z0-9-]+)\s*$", gate_block.group("body"), re.MULTILINE) if gate_block else []
    product_jobs = re.findall(
        r"^\s+-\s+jobId:\s+([a-z0-9][a-z0-9-]*)\s*$", workflow_text, re.MULTILINE
    )
    required_status = scalar("requiredStatusCheck")
    valid_workflow = (
        scalar("schemaVersion") == "1.0"
        and scalar("active") == "false"
        and scalar("workflowId") == "private-governance-minimal-gate"
        and triggers == ["pull_request"]
        and required_status == "home-baseline/ci-minimal-gate"
        and scalar("runsOn") == "ubuntu-latest"
        and scalar("fullBuild") == "false"
        and scalar("pathDependent") == "true"
        and len(gate_ids) == len(set(gate_ids))
        and bool(gate_ids)
        and sorted(product_jobs) == [
            "casetracker-csharp", "casetracker-go", "casetracker-java",
            "casetracker-python", "casetracker-rust", "casetracker-swift",
        ]
    )
    expected_ruleset_keys = {
        "schemaVersion", "active", "applied", "target", "enforcement",
        "pullRequestRequired", "requiredStatusChecks", "requireStatusChecksToPass",
        "blockedWritePaths", "adminBypassNormalPath", "remoteConverged",
    }
    valid_ruleset = (
        set(ruleset) == expected_ruleset_keys
        and ruleset.get("schemaVersion") == "1.0"
        and ruleset.get("active") is False
        and ruleset.get("applied") is False
        and ruleset.get("target") == "default_branch"
        and ruleset.get("enforcement") == "active"
        and ruleset.get("pullRequestRequired") is True
        and ruleset.get("requiredStatusChecks") == ["home-baseline/ci-minimal-gate"]
        and ruleset.get("requireStatusChecksToPass") is True
        and sorted(ruleset.get("blockedWritePaths", [])) == ["api", "direct", "web"]
        and ruleset.get("adminBypassNormalPath") is False
        and ruleset.get("remoteConverged") is False
    )
    if not valid_workflow or not valid_ruleset:
        raise CIGateBlocked("private governance workflow/ruleset contract is unsafe or too broad")
    return {
        "pullRequestRequired": True,
        "requiredStatusChecks": [required_status],
        "blockedWritePaths": ["api", "direct", "web"],
        "adminBypassNormalPath": False,
        "remoteConverged": False,
        "hookRequiredForServerEnforcement": False,
    }


def authoritative_ci_repositories(
    repository_root: pathlib.Path,
    manifest: dict,
    profile_registry: dict,
) -> list[dict]:
    """Return Level-0 self plus every active Git target, never collections."""
    targets = manifest.get("targets")
    if not isinstance(targets, list):
        raise ContractError("fleet manifest targets must be an array")
    active_git: list[dict] = []
    seen: set[str] = set()
    excluded_collections: list[str] = []
    for target in targets:
        if not isinstance(target, dict) or not target.get("active"):
            continue
        repository_id = validate_ci_input_component(target.get("id"))
        if target.get("kind") == "collection":
            excluded_collections.append(repository_id)
            continue
        if target.get("kind") != "git-repository":
            continue
        if repository_id == "home-baseline":
            raise CIGateBlocked("fleet manifest must not duplicate the Level-0 self record")
        if repository_id in seen:
            raise CIGateBlocked(f"duplicate active repository ID: {repository_id}")
        seen.add(repository_id)
        active_git.append({
            "repositoryId": repository_id,
            "remoteIdentity": normalize_remote(str(target.get("remote", ""))),
            "defaultBranch": str(target.get("defaultBranch", "")),
            "origin": "fleet-manifest",
        })
    origin = run_git(repository_root, "remote", "get-url", "origin", check=False)
    if origin.returncode != 0 or not origin.stdout.strip():
        raise ContractError("Level-0 configured origin is required")
    records = [{
        "repositoryId": "home-baseline",
        "remoteIdentity": normalize_remote(origin.stdout.strip()),
        "defaultBranch": "main",
        "origin": "executing-level0-configured-origin",
    }, *active_git]
    records.sort(key=lambda item: item["repositoryId"])
    assignment_rows = profile_registry.get("assignments", [])
    assignment_ids = [item.get("repositoryId") for item in assignment_rows if isinstance(item, dict)]
    expected_ids = [item["repositoryId"] for item in records]
    if len(assignment_ids) != len(set(assignment_ids)) or set(assignment_ids) != set(expected_ids):
        missing = sorted(set(expected_ids) - set(assignment_ids))
        unknown = sorted(set(assignment_ids) - set(expected_ids))
        raise CIGateBlocked(f"profile assignments differ from authoritative set; missing={missing}, unknown={unknown}")
    assignments = {item["repositoryId"]: item["profileId"] for item in assignment_rows}
    for canary in ("home-baseline", "agent-operations-cockpit", "tui-vision"):
        if assignments.get(canary) != "public-canary":
            raise CIGateBlocked(f"required public canary assignment is missing: {canary}")
    for record in records:
        record["assignmentProfileId"] = assignments[record["repositoryId"]]
    if "spec-kit-preset-projects" not in excluded_collections:
        raise CIGateBlocked("the authoritative collection exclusion is missing")
    return records


def _normalize_ci_workflows(raw: object, label: str) -> list[dict]:
    if not isinstance(raw, list):
        raise ContractError(f"{label}.workflows must be an array")
    normalized: list[dict] = []
    allowed_triggers = {"pull_request", "push", "schedule", "workflow_dispatch"}
    for index, item in enumerate(raw):
        if not isinstance(item, dict):
            raise ContractError(f"{label}.workflows[{index}] must be an object")
        _require_exact_keys(
            item,
            {"workflowId", "jobId", "triggers", "runners", "averageDurationSeconds", "plannedRuns"},
            f"{label}.workflows[{index}]",
        )
        workflow_id = validate_ci_input_component(item["workflowId"])
        job_id = validate_ci_input_component(item["jobId"])
        triggers = sorted(set(item["triggers"])) if isinstance(item["triggers"], list) else []
        runners = sorted(set(item["runners"])) if isinstance(item["runners"], list) else []
        if not triggers or set(triggers) - allowed_triggers or not runners:
            raise ContractError(f"{label}.workflows[{index}] has invalid triggers or runners")
        decimals: dict[str, str | None] = {}
        for field in ("averageDurationSeconds", "plannedRuns"):
            value = item[field]
            if value is None:
                decimals[field] = None
                continue
            try:
                parsed = Decimal(str(value))
            except InvalidOperation as exc:
                raise ContractError(f"{label}.workflows[{index}].{field} is invalid") from exc
            if parsed < 0:
                raise ContractError(f"{label}.workflows[{index}].{field} is negative")
            decimals[field] = format(parsed, "f")
        normalized.append({
            "workflowId": workflow_id,
            "jobId": job_id,
            "triggers": triggers,
            "runners": runners,
            **decimals,
        })
    normalized.sort(key=lambda item: (item["workflowId"], item["jobId"]))
    keys = [(item["workflowId"], item["jobId"]) for item in normalized]
    if len(keys) != len(set(keys)):
        raise ContractError(f"{label}.workflows contains duplicate jobs")
    return normalized


def validate_ci_inventory(
    raw_rows: object,
    authoritative: list[dict],
    profile_registry: dict,
    *,
    source_revision: str,
    observed_at: str,
) -> list[dict]:
    """Validate one complete atomic snapshot and copy only accepted assignments."""
    if not source_revision or any(character in source_revision for character in ("\r", "\n", "\0")):
        raise ContractError("one non-empty atomic sourceRevision is required")
    if not re.fullmatch(r"\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ", observed_at):
        raise ContractError("inventory observedAt must be RFC 3339 UTC without fractions")
    if not isinstance(raw_rows, list):
        raise ContractError("inventory repositories must be an array")
    expected_ids = {item["repositoryId"] for item in authoritative}
    raw_ids = [item.get("repositoryId") for item in raw_rows if isinstance(item, dict)]
    if len(raw_ids) != len(set(raw_ids)) or set(raw_ids) != expected_ids:
        raise CIGateBlocked("inventory IDs do not exactly match the authoritative repository set")
    profiles = {item["profileId"]: item for item in profile_registry["profiles"]}
    assignments = {item["repositoryId"]: item["profileId"] for item in profile_registry["assignments"]}
    authoritative_by_id = {item["repositoryId"]: item for item in authoritative}
    normalized = []
    for raw in raw_rows:
        if not isinstance(raw, dict):
            raise ContractError("inventory row must be an object")
        allowed = {"repositoryId", "remoteIdentity", "visibility", "defaultBranch", "workflows", "profileId"}
        if set(raw) - allowed or not {"repositoryId", "remoteIdentity", "visibility", "defaultBranch", "workflows"} <= set(raw):
            raise ContractError(f"inventory row fields are invalid: {raw.get('repositoryId', '<unknown>')}")
        repository_id = validate_ci_input_component(raw["repositoryId"])
        profile_id = assignments[repository_id]
        if raw.get("profileId", profile_id) != profile_id:
            raise CIGateBlocked(f"inventory profileId drift: {repository_id}")
        if raw["visibility"] != profiles[profile_id]["requiredVisibility"]:
            raise CIGateBlocked(f"inventory visibility conflicts with profile: {repository_id}")
        remote_identity = normalize_remote(str(raw["remoteIdentity"]))
        if remote_identity != authoritative_by_id[repository_id]["remoteIdentity"]:
            raise CIGateBlocked(f"inventory remote identity drift: {repository_id}")
        default_branch = str(raw["defaultBranch"])
        if not default_branch or any(character in default_branch for character in ("\r", "\n", "\0")):
            raise ContractError(f"inventory default branch is invalid: {repository_id}")
        normalized.append({
            "repositoryId": repository_id,
            "remoteIdentity": remote_identity,
            "visibility": raw["visibility"],
            "defaultBranch": default_branch,
            "profileId": profile_id,
            "observedAt": observed_at,
            "workflows": _normalize_ci_workflows(raw["workflows"], repository_id),
        })
    return sorted(normalized, key=lambda item: item["repositoryId"])


def _github_repository_slug(remote: str) -> str:
    parsed = urlsplit(remote)
    path = parsed.path.strip("/") if parsed.scheme else remote.split(":", 1)[-1].strip("/")
    path = path.removesuffix(".git")
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", path):
        raise ContractError(f"GitHub remote cannot be minimized safely: {remote}")
    return path


def _github_get_json(endpoint: str) -> dict:
    assert_stage_a_operation("GET", endpoint)
    command = ["gh", "api", "--method", "GET", endpoint]
    for attempt in range(1, 4):
        try:
            completed = subprocess.run(
                command, text=True, capture_output=True, check=False, timeout=30
            )
        except subprocess.TimeoutExpired:
            completed = subprocess.CompletedProcess(command, 124, "", "timeout")
        if completed.returncode == 0:
            try:
                value = json.loads(completed.stdout)
            except json.JSONDecodeError as exc:
                raise ContractError(f"GitHub GET returned invalid JSON for {endpoint}") from exc
            if not isinstance(value, dict):
                raise ContractError(f"GitHub GET returned an invalid object for {endpoint}")
            return value
        detail = (completed.stderr or completed.stdout).strip()
        transient = bool(re.search(
            r"timeout|reset|resolve|rate limit|HTTP 50[234]|error connecting|internet connection",
            detail,
            re.IGNORECASE,
        ))
        if not transient or attempt == 3:
            raise ContractError(f"GitHub read-only inventory failed for {endpoint}: {detail[-200:]}")
        time.sleep(0.25 * (2 ** (attempt - 1)))
    raise AssertionError("bounded GitHub retry loop exhausted")


def github_read_only_inventory(
    authoritative: list[dict],
    *,
    transport=None,
    observed_at: str | None = None,
) -> tuple[str, str, list[dict]]:
    """Minimize repository metadata from GET-only GitHub observations."""
    getter = transport or _github_get_json
    observed = observed_at or utc_now()
    rows = []
    for expected in authoritative:
        slug = _github_repository_slug(expected["remoteIdentity"])
        value = getter(f"repos/{slug}")
        rows.append({
            "repositoryId": expected["repositoryId"],
            "remoteIdentity": normalize_remote(str(value.get("html_url", expected["remoteIdentity"]))),
            "visibility": "private" if value.get("private") is True else "public",
            "defaultBranch": str(value.get("default_branch", "")),
            "workflows": [],
        })
    revision = canonical_json_hash({"observedAt": observed, "repositories": rows})
    return revision, observed, rows


def evaluate_ci_paths(contracts: dict, changed_paths: list[str]) -> dict:
    normalized_paths = sorted({_normalize_changed_path(path) for path in changed_paths})
    matches: list[dict] = []
    for contract in contracts["paths"]["pathContracts"]:
        if any(
            any(fnmatch.fnmatch(path, pattern) for pattern in contract["includePatterns"])
            and not any(fnmatch.fnmatch(path, pattern) for pattern in contract["excludePatterns"])
            for path in normalized_paths
        ):
            matches.append(contract)
    gate_order = {
        gate["gateId"]: gate["order"]
        for gate_set in contracts["profiles"]["gateSets"]
        for gate in gate_set["gates"]
    }
    gate_ids = sorted(
        {gate for contract in matches for gate in contract["gateIds"]},
        key=lambda gate: (gate_order[gate], gate),
    )
    return {
        "matchedPathContractIds": sorted(
            (contract["pathContractId"] for contract in matches),
            key=lambda contract_id: next(
                (item["category"], item["pathContractId"])
                for item in matches if item["pathContractId"] == contract_id
            ),
        ),
        "gateIds": gate_ids,
        "productJobIds": sorted({
            contract["productJobId"] for contract in matches if "productJobId" in contract
        }),
    }


def assert_stage_a_operation(action: str, target: str) -> None:
    """Fail closed before any Stage-A remote, delivery, or target write."""
    normalized_action = action.strip().upper()
    normalized_target = target.strip().lower()
    if normalized_action in {"POST", "PUT", "PATCH", "DELETE", "COMMIT", "PUSH", "MERGE", "HOME-SYNC", "G4"}:
        raise ContractError(f"Stage A forbids operation: {normalized_action}")
    if normalized_action != "GET":
        raise ContractError(f"Stage A permits only GET for remote transport: {normalized_action}")
    forbidden_fragments = ("/rulesets", "/collaborators", "/reviewers", "/copilot", "/actions/permissions")
    if any(fragment in normalized_target for fragment in forbidden_fragments):
        raise ContractError(f"Stage A forbids mutable administration surface: {target}")


def simulate_ci_workflow_policy(
    profile_id: str,
    repository_id: str,
    event: str,
    path_decision: dict,
) -> dict:
    """Apply the closed Stage-A trigger subset for all five profiles."""
    if event not in {"pull_request", "push", "schedule", "workflow_dispatch"}:
        raise ContractError(f"unsupported workflow event: {event}")
    jobs: list[dict] = []
    decision = "Blocked"
    if repository_id == "private-release-please":
        if event in {"schedule", "workflow_dispatch"}:
            decision = "LocalGate"
            jobs = [{"jobId": "release-please", "runner": "ubuntu-latest"}]
    elif profile_id == "private-governance-scaffold":
        if event == "pull_request":
            decision = "LocalGate"
            jobs = [{"jobId": "ci-minimal-gate", "runner": "ubuntu-latest"}]
    elif profile_id == "private-product":
        product_jobs = list(path_decision.get("productJobIds", []))
        if event == "pull_request":
            decision = "ProductPRGate" if product_jobs else "LocalGate"
            jobs = [
                {"jobId": job_id, "runner": "ubuntu-latest"}
                for job_id in sorted(set(product_jobs))
            ]
        elif repository_id == "secure-casetracker-swift" and event in {"schedule", "workflow_dispatch"}:
            decision = "ProductPRGate"
            jobs = [{"jobId": "casetracker-swift-platform", "runner": "macos-latest"}]
    elif profile_id == "public-preset":
        decision = "FleetPipeline"
    elif profile_id in {"public-canary", "public-product"}:
        decision = "PublicCI"
    else:
        raise ContractError(f"unknown profile policy: {profile_id}")
    return {
        "profileId": profile_id,
        "repositoryId": repository_id,
        "event": event,
        "gateDecision": decision,
        "plannedJobs": jobs,
        "fullBuildCount": 0 if profile_id.startswith("private-") else None,
        "remoteConverged": False,
    }


def project_ci_costs(
    assumptions: dict,
    *,
    recurring_jobs: object = 22,
    recurring_duration_seconds: object = 120,
    demand_runs: object = 20,
    demand_duration_seconds: object = 60,
    copilot_minutes: object = 15,
) -> dict:
    """Keep Actions and Copilot minutes separate and avoid early rounding."""
    values = [recurring_jobs, recurring_duration_seconds, demand_runs, demand_duration_seconds, copilot_minutes]
    if any(value is None for value in values):
        raise CIGateBlocked("budget inputs are incomplete; missing values are not treated as zero")
    try:
        recurring, recurring_duration, demand, demand_duration, copilot = [Decimal(str(value)) for value in values]
    except InvalidOperation as exc:
        raise ContractError("budget inputs must be decimal values") from exc
    if any(value < 0 for value in (recurring, recurring_duration, demand, demand_duration, copilot)):
        raise ContractError("budget inputs must not be negative")
    weeks = Decimal(assumptions["weeksPerMonthNumerator"]) / Decimal(assumptions["weeksPerMonthDenominator"])
    actions_minutes = (recurring * weeks * recurring_duration / Decimal(60)) + (demand * demand_duration / Decimal(60))
    target = Decimal(assumptions["privateMonthlyTargetExclusiveMinutes"])
    if actions_minutes >= target:
        raise CIGateBlocked("private Actions projection does not satisfy the exclusive target")
    return {
        "weeksPerMonthNumerator": assumptions["weeksPerMonthNumerator"],
        "weeksPerMonthDenominator": assumptions["weeksPerMonthDenominator"],
        "recurringPrivateJobsPerWeek": format(recurring, "f"),
        "demandMinimalGateRuns": format(demand, "f"),
        "privateActionsMinutesPerMonth": format(actions_minutes.quantize(Decimal("0.01")), "f"),
        "privateMonthlyBudgetMinutes": assumptions["privateMonthlyBudgetMinutes"],
        "copilotReviewRunnerMinutes": format(copilot, "f"),
        "assumptions": [
            "52/12 weeks per month; recurring and demand Actions minutes are calculated separately.",
            "Copilot review runner minutes remain a separate non-Actions category.",
            "The recurring reference is approximately 22 private jobs per week.",
        ],
    }


def _ci_rollout_decision(profile_id: str) -> tuple[str, list[dict], str]:
    if profile_id == "private-governance-scaffold":
        return "LocalGate", [{"artifactId": "minimal-gate", "action": "Preserve", "stage": "A-Level0Template"}], "Lokale Evidence prüfen; Serverkonvergenz benötigt neue Autorisierung. / Review local evidence; server convergence needs new authorization."
    if profile_id == "private-product":
        return "ProductPRGate", [{"artifactId": "product-pr-gate", "action": "NoChange", "stage": "B-TargetRepository"}], "Pfadabhängigen PR-Gate später autorisieren. / Authorize the path-dependent PR gate later."
    if profile_id == "public-preset":
        return "FleetPipeline", [{"artifactId": "fleet-pipeline", "action": "Preserve", "stage": "A-Level0Template"}], "Flottenpipeline oder lokale Evidence beibehalten. / Keep the fleet pipeline or local evidence."
    return "PublicCI", [{"artifactId": "public-ci", "action": "Preserve", "stage": "B-TargetRepository"}], "Erforderliche öffentliche CI beibehalten. / Preserve required public CI."


def build_ci_inventory_rollout_plan(
    contracts: dict,
    authoritative: list[dict],
    repositories: list[dict],
    *,
    source: str,
    source_revision: str,
    generated_at: str,
) -> dict:
    if source not in {"Fixture", "GitHubReadOnly"}:
        raise ContractError("inventory source is invalid")
    if not re.fullmatch(r"\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ", generated_at):
        raise ContractError("generatedAt must be RFC 3339 UTC without fractions")
    expected_ids = [item["repositoryId"] for item in authoritative]
    repository_ids = [item["repositoryId"] for item in repositories]
    if repository_ids != sorted(expected_ids):
        raise CIGateBlocked("validated inventory order or ID set drifted before rollout")
    profiles = {item["profileId"]: item for item in contracts["profiles"]["profiles"]}
    rollout = []
    cardinalities = {item["displayName"]: 0 for item in contracts["profiles"]["profiles"]}
    for repository in repositories:
        profile_id = repository["profileId"]
        decision, planned_diff, next_action = _ci_rollout_decision(profile_id)
        cardinalities[profiles[profile_id]["displayName"]] += 1
        rollout.append({
            "repositoryId": repository["repositoryId"],
            "profileId": profile_id,
            "plannedDiff": sorted(planned_diff, key=lambda item: item["artifactId"]),
            "gateDecision": decision,
            "blockers": [],
            "nextAction": next_action,
            "remoteConverged": False,
        })
    inventory_hash = canonical_json_hash([
        {key: value for key, value in repository.items() if key != "observedAt"}
        for repository in repositories
    ])
    return {
        "schemaVersion": "1.0",
        "stage": "A",
        "deliveryMode": "LocalImplementation",
        "generatedAt": generated_at,
        "source": source,
        "sourceRevision": source_revision,
        "authoritativeRepositorySet": {
            "level0SelfRepositoryId": "home-baseline",
            "level0RemoteResolution": "executing-level0-configured-origin",
            "fleetManifestPath": "scripts/config/agentic-workspace-fleet.json",
            "includedRepositoryCount": len(repositories),
            "excludedCollectionIds": ["spec-kit-preset-projects"],
        },
        "inventorySnapshotHash": inventory_hash,
        "profileRegistryHash": contracts["profileRegistryHash"],
        "pathContractHash": contracts["pathContractHash"],
        "mutationsPerformed": False,
        "profileCardinalities": cardinalities,
        "repositories": repositories,
        "rollout": rollout,
        "costProjection": project_ci_costs(contracts["profiles"]["budgetAssumptions"]),
    }


def execute_ci_budget_plan(args: argparse.Namespace) -> int:
    """Build one deterministic, read-only Stage-A inventory and rollout plan."""
    try:
        repository = args.repository_root.resolve()
        contracts = load_ci_budget_contracts(args.profiles, args.path_contracts, args.workflow_template)
        manifest = _read_ci_json(args.manifest, "fleet manifest")
        authoritative = authoritative_ci_repositories(repository, manifest, contracts["profiles"])
        if not args.check_only:
            raise ContractError("Stage A CI budget planning requires --check-only")
        if args.output != "-":
            raise ContractError("Stage A permits only --output -")
        if args.adapter == "fixture":
            if args.inventory is None:
                raise ContractError("fixture adapter requires --inventory")
            raw_inventory = _read_ci_json(args.inventory, "fixture inventory")
            source = "Fixture"
            source_revision = str(raw_inventory.get("sourceRevision", ""))
            observed_at = str(raw_inventory.get("observedAt", ""))
            raw_rows = raw_inventory.get("repositories")
        else:
            source = "GitHubReadOnly"
            source_revision, observed_at, raw_rows = github_read_only_inventory(authoritative)
        repositories = validate_ci_inventory(
            raw_rows,
            authoritative,
            contracts["profiles"],
            source_revision=source_revision,
            observed_at=observed_at,
        )
        plan = build_ci_inventory_rollout_plan(
            contracts,
            authoritative,
            repositories,
            source=source,
            source_revision=source_revision,
            generated_at=os.environ.get("HB_CI_FIXTURE_CLOCK", observed_at or utc_now()),
        )
        print(json.dumps(plan, ensure_ascii=False, separators=(",", ":")))
        return 0
    except CIGateBlocked as exc:
        print(f"CI_BUDGET_PLAN\tBLOCKED\t{exc}", file=sys.stderr)
        return 1
    except (ContractError, OSError, RuntimeError) as exc:
        print(f"CI_BUDGET_PLAN\tFAILED\t{exc}", file=sys.stderr)
        return 2


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)
    ci_gate = subparsers.add_parser("ci-gate")
    ci_gate.add_argument("--repository-root", type=pathlib.Path, required=True)
    ci_gate.add_argument("--profiles", type=pathlib.Path, default=pathlib.Path("scripts/config/ci-budget-profiles.json"))
    ci_gate.add_argument("--path-contracts", type=pathlib.Path, default=pathlib.Path("scripts/config/ci-budget-path-contracts.json"))
    ci_gate.add_argument("--workflow-template", type=pathlib.Path, default=pathlib.Path("scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml"))
    ci_gate.add_argument("--repository-id")
    ci_gate.add_argument("--evidence-root", type=pathlib.Path)
    ci_gate.add_argument("--changed-path", action="append", default=[])
    ci_gate.add_argument("--fixture-head")
    ci_gate.add_argument("--dry-run", action="store_true")
    ci_gate.set_defaults(handler=execute_ci_gate)
    ci_plan = subparsers.add_parser("ci-budget-plan")
    ci_plan.add_argument("--repository-root", type=pathlib.Path, required=True)
    ci_plan.add_argument("--manifest", type=pathlib.Path, required=True)
    ci_plan.add_argument("--profiles", type=pathlib.Path, required=True)
    ci_plan.add_argument("--path-contracts", type=pathlib.Path, required=True)
    ci_plan.add_argument("--workflow-template", type=pathlib.Path, default=pathlib.Path("scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml"))
    ci_plan.add_argument("--adapter", choices=("fixture", "github-read-only"), required=True)
    ci_plan.add_argument("--inventory", type=pathlib.Path)
    ci_plan.add_argument("--check-only", action="store_true")
    ci_plan.add_argument("--output", required=True)
    ci_plan.set_defaults(handler=execute_ci_budget_plan)
    fleet = subparsers.add_parser("fleet")
    fleet.add_argument("--manifest", type=pathlib.Path, required=True)
    fleet.add_argument("--home-dir", type=pathlib.Path, required=True)
    fleet.add_argument("--mode", choices=("check-only", "dry-run", "update"), required=True)
    fleet.add_argument("--report", type=pathlib.Path, required=True)
    fleet.add_argument("--log", type=pathlib.Path, required=True)
    fleet.add_argument("--run-id")
    fleet.add_argument("--allowed-dirty-path", action="append", default=[])
    fleet.add_argument("--level0-dir", type=pathlib.Path)
    fleet.set_defaults(handler=execute_fleet)
    stage = subparsers.add_parser("stage")
    stage.add_argument("--report", type=pathlib.Path, required=True)
    stage.add_argument("--stage-id", required=True)
    stage.add_argument(
        "--status",
        choices=(
            "Passed",
            "Warning",
            "Blocked",
            "Failed",
            "Skipped",
            "DeferredAdminRequired",
            "Interrupted",
        ),
        required=True,
    )
    stage.add_argument("--exit-code", type=int, required=True)
    stage.add_argument("--duration-ms", type=int, default=0)
    stage.add_argument("--summary", required=True)
    stage.add_argument("--next-action", default="N/A")
    stage.add_argument("--toolchain-results", type=pathlib.Path)
    stage.add_argument("--storage-results", type=pathlib.Path)
    stage.add_argument("--evidence-path", type=pathlib.Path)
    stage.set_defaults(handler=record_stage)
    finalize = subparsers.add_parser("finalize")
    finalize.add_argument("--report", type=pathlib.Path, required=True)
    finalize.add_argument("--stage-id", required=True)
    finalize.add_argument(
        "--status",
        choices=(
            "Passed",
            "Warning",
            "Blocked",
            "Failed",
            "DeferredAdminRequired",
            "Interrupted",
        ),
        required=True,
    )
    finalize.add_argument("--exit-code", type=int, required=True)
    finalize.add_argument("--duration-ms", type=int, default=0)
    finalize.add_argument("--signal", choices=("N/A", "INT", "TERM"), default="N/A")
    finalize.add_argument("--summary", required=True)
    finalize.add_argument("--next-action", default="N/A")
    finalize.set_defaults(handler=finalize_report)
    registry = subparsers.add_parser("registry")
    registry.add_argument("--manifest", type=pathlib.Path, required=True)
    registry.add_argument("--registry", type=pathlib.Path, required=True)
    registry.set_defaults(handler=validate_registry)
    profile = subparsers.add_parser("profile")
    profile.add_argument("--catalog", type=pathlib.Path, required=True)
    profile.add_argument("--source-root", type=pathlib.Path, required=True)
    profile.add_argument("--profile")
    profile.add_argument("--field", choices=("json", "path"), default="json")
    profile.set_defaults(handler=resolve_preset_profile)
    repositories = subparsers.add_parser("canonical-repositories")
    repositories.add_argument("--manifest", type=pathlib.Path, required=True)
    repositories.add_argument("--home-dir", type=pathlib.Path, required=True)
    repositories.add_argument("--existing-only", action="store_true")
    repositories.set_defaults(handler=list_canonical_repositories)
    default_ref = subparsers.add_parser("default-ref")
    default_ref.add_argument("--repository", type=pathlib.Path, required=True)
    default_ref.set_defaults(handler=print_default_remote_ref)
    event = subparsers.add_parser("event")
    event.add_argument("--event-stream", type=pathlib.Path, required=True)
    event.add_argument("--run-id", required=True)
    event.add_argument("--sequence", type=int, required=True)
    event.add_argument(
        "--event-type",
        choices=(
            "run-started",
            "phase-started",
            "phase-progress",
            "finding",
            "phase-completed",
            "run-completed",
        ),
        required=True,
    )
    event.add_argument(
        "--status",
        choices=(
            "RUNNING",
            "PASSED",
            "PARTIAL",
            "BLOCKED",
            "WARNING",
            "SKIPPED",
            "FAILED",
        ),
        required=True,
    )
    event.add_argument(
        "--phase-id",
        choices=(
            "fleet",
            "level0",
            "home-sync",
            "registry",
            "propagation",
            "preset-profiles",
            "toolchain",
            "final",
        ),
    )
    event.add_argument("--target-id")
    event.add_argument("--message-de", required=True)
    event.add_argument("--message-en", required=True)
    event.add_argument("--details-json", default="{}")
    event.set_defaults(handler=append_maintenance_event)
    lease_create = subparsers.add_parser("lease-create")
    lease_create.add_argument("--state-root", type=pathlib.Path, required=True)
    lease_create.add_argument("--lease", type=pathlib.Path, required=True)
    lease_create.add_argument("--run-id", required=True)
    lease_create.add_argument("--owner-pid", type=int, required=True)
    lease_create.add_argument("--owner-process-identity")
    lease_create.add_argument("--repository", type=pathlib.Path, required=True)
    lease_create.add_argument("--remote-ref", required=True)
    lease_create.add_argument("--commit", required=True)
    lease_create.add_argument("--worktree", type=pathlib.Path, required=True)
    lease_create.set_defaults(handler=create_worktree_lease)
    lease_release = subparsers.add_parser("lease-release")
    lease_release.add_argument("--state-root", type=pathlib.Path, required=True)
    lease_release.add_argument("--lease", type=pathlib.Path, required=True)
    lease_release.add_argument("--run-id", required=True)
    lease_release.set_defaults(handler=release_worktree_lease)
    lease_recover = subparsers.add_parser("lease-recover")
    lease_recover.add_argument("--state-root", type=pathlib.Path, required=True)
    lease_recover.add_argument("--lease-dir", type=pathlib.Path, required=True)
    lease_recover.set_defaults(handler=recover_worktree_leases)
    return parser


def main() -> int:
    counter_file = os.environ.get("HB_CI_ENGINE_COUNTER_FILE")
    if counter_file:
        counter_path = pathlib.Path(counter_file)
        counter_path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        with counter_path.open("a", encoding="utf-8", newline="\n") as stream:
            stream.write(f"{os.getpid()}\n")
            stream.flush()
    arguments = build_parser().parse_args()
    return arguments.handler(arguments)


if __name__ == "__main__":
    raise SystemExit(main())
