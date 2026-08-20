#!/usr/bin/env python3
"""Run exactly one CI-budget acceptance scope and publish one Primary record."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import pathlib
import shutil
import subprocess
import sys
import tempfile
import uuid
from datetime import datetime, timezone


GATE_TESTS = {
    "AC-CBG-001": "FleetClassificationTests",
    "AC-CBG-002": "HookEvidenceRulesetTests",
    "AC-CBG-003": "WorkflowPathBudgetTests",
    "AC-CBG-004": "WorkflowPathBudgetTests",
    "AC-CBG-005": "WorkflowPathBudgetTests",
    "AC-CBG-006": "RolloutDeterminismMutationTests",
    "AC-CBG-007": "HookEvidenceRulesetTests",
    "AC-CBG-008": "PlatformParityAccessibilityTests",
    "AC-CBG-009": "RolloutDeterminismMutationTests",
    "AC-CBG-010": "FleetClassificationTests",
}
INTERNAL_INPUTS = {
    "AC-CBG-007": ["internal/ac-cbg-007-008-hook-installation-macos.json"],
    "AC-CBG-008": [
        "internal/ac-cbg-007-008-hook-installation-macos.json",
        "internal/manual-bash-macos.json",
        "internal/manual-powershell-macos.json",
        "internal/regression-macos.json",
    ],
    "AC-CBG-009": ["internal/stage-a-diff-allowlist.json"],
    "AC-CBG-010": ["internal/live-inventory-read-only-macos.json"],
}


def validate_internal_input(relative: str, value: object) -> None:
    """Reject stale or incomplete internal evidence before it can be hash-bound."""
    if not isinstance(value, dict) or value.get("schemaVersion") != "1.0":
        raise ValueError(f"invalid internal evidence schema: {relative}")
    if relative.endswith("ac-cbg-007-008-hook-installation-macos.json"):
        source = value.get("sourceHook", {})
        installed = value.get("installedHook", {})
        fixtures = value.get("fixtures", [])
        if not (
            value.get("result") == "Passed"
            and value.get("installerRerun") is False
            and value.get("pushPerformed") is False
            and source.get("sha256") == installed.get("sha256")
            and installed.get("executable") is True
            and value.get("byteComparison", {}).get("exitCode") == 0
            and len(fixtures) == 2
            and all(item.get("result") == "Passed" for item in fixtures)
            and sorted(item.get("exitCode") for item in fixtures) == [0, 1]
        ):
            raise ValueError(f"hook evidence is incomplete or failed: {relative}")
        return
    if relative.endswith("stage-a-diff-allowlist.json"):
        if value.get("result") != "Passed" or value.get("violations") != []:
            raise ValueError(f"Stage A mutation evidence is not green: {relative}")
        return
    if relative.endswith("live-inventory-read-only-macos.json"):
        repositories = value.get("repositories")
        if (
            value.get("observedAt", "").endswith("Z") is not True
            or not isinstance(repositories, list)
            or len(repositories) != 48
            or len({item.get("repositoryId") for item in repositories if isinstance(item, dict)}) != 48
        ):
            raise ValueError(f"live inventory evidence is incomplete: {relative}")
        return
    if value.get("result") not in {"Pass", "Passed"}:
        raise ValueError(f"internal evidence is not green: {relative}")
    commands = value.get("commands", [])
    if commands and any(item.get("exitCode") != 0 for item in commands):
        raise ValueError(f"internal command evidence contains a failure: {relative}")
    if "macos" in relative and value.get("runnerOrPlatform", value.get("platform")) != "macOS":
        raise ValueError(f"internal platform token is not truthful macOS: {relative}")


def run_additional_scope(gate: str, root: pathlib.Path, evidence_root: pathlib.Path) -> int:
    """Execute cross-artifact checks that are wider than one unittest class."""
    commands: list[list[str]] = []
    if gate == "AC-CBG-008":
        commands = [
            ["bash", "-n", "scripts/maintain-agentic-workspace.sh"],
            ["pwsh", "-NoProfile", "-File", "scripts/invoke-psscriptanalyzer.ps1"],
            ["python3", "scripts/tests/test_spec_kit_agent_surface_parity.py"],
            ["bash", "scripts/validate-documentation-impact.sh", "--evidence", "specs/029-ci-budget-governance/documentation-impact-evidence.json"],
            ["pwsh", "-NoProfile", "-File", "scripts/test-render-project-statistics.ps1"],
            ["bash", "scripts/scan-agent-secrets.sh", "--fail-on-high", "."],
        ]
    elif gate == "AC-CBG-010":
        commands = [[
            "python3", "scripts/lib/agentic_workspace_fleet.py", "ci-budget-plan",
            "--repository-root", ".",
            "--manifest", "scripts/config/agentic-workspace-fleet.json",
            "--profiles", "scripts/config/ci-budget-profiles.json",
            "--path-contracts", "scripts/config/ci-budget-path-contracts.json",
            "--adapter", "fixture",
            "--inventory", str(evidence_root / "internal/live-inventory-read-only-macos.json"),
            "--check-only", "--output", "-",
        ]]
    for command in commands:
        completed = subprocess.run(
            command,
            cwd=root,
            text=True,
            stdout=subprocess.DEVNULL if gate == "AC-CBG-010" else None,
            check=False,
        )
        if completed.returncode != 0:
            return completed.returncode
    if gate == "AC-CBG-008":
        with tempfile.TemporaryDirectory(prefix="ci-budget-candidate-") as directory:
            candidate_root = pathlib.Path(directory)
            candidate_index = candidate_root / "index"
            candidate_objects = candidate_root / "objects"
            candidate_objects.mkdir()
            shutil.copy2(root / ".git/index", candidate_index)
            environment = os.environ.copy()
            environment.update({
                "GIT_INDEX_FILE": str(candidate_index),
                "GIT_OBJECT_DIRECTORY": str(candidate_objects),
                "GIT_ALTERNATE_OBJECT_DIRECTORIES": str(root / ".git/objects"),
            })
            staged = subprocess.run(
                ["git", "add", "-A"], cwd=root, env=environment, check=False
            )
            if staged.returncode != 0:
                return staged.returncode
            statistics = subprocess.run(
                ["bash", "scripts/render-project-statistics.sh", "--repo", ".", "--check-only"],
                cwd=root,
                env=environment,
                check=False,
            )
            if statistics.returncode != 0:
                return statistics.returncode
        for relative in (
            "docs/accessibility/ci-budget-governance.md",
            "docs/architecture/ci-budget-governance.md",
            "docs/security/security-checklist.md",
            "scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml",
        ):
            if not (root / relative).is_file():
                return 2
    return 0


def normalized_sha256(path: pathlib.Path) -> str:
    raw = path.read_bytes().replace(b"\r\n", b"\n").replace(b"\r", b"\n")
    return hashlib.sha256(raw).hexdigest()


def atomic_write_json(path: pathlib.Path, value: object) -> None:
    path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    descriptor, temporary_name = tempfile.mkstemp(prefix=f".{path.name}.", dir=path.parent)
    temporary = pathlib.Path(temporary_name)
    try:
        os.fchmod(descriptor, 0o600)
        encoded = (json.dumps(value, ensure_ascii=False, separators=(",", ":")) + "\n").encode("utf-8")
        os.write(descriptor, encoded)
        os.fsync(descriptor)
        os.close(descriptor)
        descriptor = -1
        json.loads(temporary.read_text(encoding="utf-8"))
        os.replace(temporary, path)
    finally:
        if descriptor >= 0:
            os.close(descriptor)
        temporary.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--gate", choices=tuple(GATE_TESTS), required=True)
    parser.add_argument("--repository-root", type=pathlib.Path, required=True)
    parser.add_argument("--evidence-root", type=pathlib.Path, required=True)
    args = parser.parse_args()
    root = args.repository_root.resolve()
    evidence_root = (root / args.evidence_root).resolve() if not args.evidence_root.is_absolute() else args.evidence_root.resolve()
    if sys.platform != "darwin":
        print("ERROR: this Stage-A Primary requires an actually executed macOS runner", file=sys.stderr)
        return 2
    requirements_path = root / "specs/029-ci-budget-governance/autonomous-run-gate-requirements.json"
    requirements = json.loads(requirements_path.read_text(encoding="utf-8"))
    requirement = next((item for item in requirements["gates"] if item["gateId"] == args.gate), None)
    if requirement is None:
        print(f"ERROR: no requirement for {args.gate}", file=sys.stderr)
        return 2
    internal_hashes = []
    for relative in INTERNAL_INPUTS.get(args.gate, []):
        candidate = evidence_root / relative
        if not candidate.is_file():
            print(f"ERROR: required internal input is missing: {relative}", file=sys.stderr)
            return 2
        try:
            value = json.loads(candidate.read_text(encoding="utf-8"))
            validate_internal_input(relative, value)
        except (UnicodeError, json.JSONDecodeError) as exc:
            print(f"ERROR: invalid internal input {relative}: {exc}", file=sys.stderr)
            return 2
        except ValueError as exc:
            print(f"ERROR: {exc}", file=sys.stderr)
            return 2
        internal_hashes.append({"path": relative, "sha256": normalized_sha256(candidate)})
    test_command = [
        sys.executable,
        "scripts/tests/test_ci_budget_governance.py",
        GATE_TESTS[args.gate],
    ]
    completed = subprocess.run(test_command, cwd=root, text=True, check=False)
    if completed.returncode != 0:
        return completed.returncode
    additional_exit = run_additional_scope(args.gate, root, evidence_root)
    if additional_exit != 0:
        return additional_exit
    head = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        text=True,
        capture_output=True,
        check=False,
    )
    reviewed_head = head.stdout.strip()
    if head.returncode != 0 or len(reviewed_head) not in (40, 64):
        print("ERROR: full reviewed HEAD is unavailable", file=sys.stderr)
        return 2
    executed_command = (
        f"python3 scripts/tests/run_ci_budget_acceptance.py --gate {args.gate} "
        "--repository-root . --evidence-root "
        ".specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence"
    )
    entry = {
        "gateId": args.gate,
        "evidenceRole": "Primary",
        "applicability": requirement["applicability"],
        "requiredScope": requirement["requiredScope"],
        "headSha": reviewed_head,
        "provider": "LocalImplementation",
        "runId": str(uuid.uuid4()),
        "workflow": "speckit.implement",
        "job": GATE_TESTS[args.gate],
        "runnerOrPlatform": "macOS",
        "executedCommand": executed_command,
        "result": "Pass",
        "evidenceReference": json.dumps(internal_hashes, separators=(",", ":")) if internal_hashes else "local-test-scope",
        "rationale": requirement["rationale"],
        "reevaluationTrigger": requirement["reevaluationTrigger"],
        "supplementalFor": "",
    }
    output = evidence_root / "primary" / f"{args.gate}.json"
    atomic_write_json(output, entry)
    print(json.dumps(entry, ensure_ascii=False, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
