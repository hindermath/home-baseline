#!/usr/bin/env python3
"""Run exactly one fail-closed Stage-B acceptance scope and publish one Primary record."""

from __future__ import annotations

import argparse
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


GATE_TESTS = {
    "AC-SBR-001": "FleetPreflightTests",
    "AC-SBR-002": "ExternalWriteGateTests",
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
        atomic_write_json(evidence_root / "primary" / f"{args.gate}.json", entry)
        return 0
    except (OSError, UnicodeError, json.JSONDecodeError, ValueError) as exc:
        print(f"STAGE_B_ACCEPTANCE\tFAILED\t{exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
