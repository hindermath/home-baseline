#!/usr/bin/env python3
"""Read-only acceptance aggregator for G4 Copilot review governance.

Fixture evidence is deliberately Supplemental/Open. Primary/Passed is emitted
only when a later routed phase supplies the complete gate-specific evidence.
This helper never performs provider, Git-ref, Home, series, subscription,
budget, cancellation, optional-hook, or Position-7 writes.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any

GATES = tuple(f"AC-CRG-{index:03d}" for index in range(1, 11))
OWNERS = {
    "AC-CRG-001": ("Fleet Governance Owner", "Privacy and Security Reviewer"),
    "AC-CRG-002": ("Fleet Governance Owner", "Acceptance Reviewer"),
    "AC-CRG-003": ("Fleet Governance Owner", "Security Reviewer"),
    "AC-CRG-004": ("Fleet Governance Owner", "Provider Surface Reviewer"),
    "AC-CRG-005": ("PR Lifecycle Owner", "PR Lifecycle Reviewer"),
    "AC-CRG-006": ("Human Review Owner", "Human Review Reviewer"),
    "AC-CRG-007": ("Review Governance Owner", "Security and Delivery Reviewer"),
    "AC-CRG-008": ("Usage Owner", "Privacy and Billing Reviewer"),
    "AC-CRG-009": ("Transaction Owner", "Security Reviewer"),
    "AC-CRG-010": ("Autonomous Run Owner", "Intake and Authority Reviewer"),
}


def canonical_bytes(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")) + "\n").encode("utf-8")


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def supplemental_record(gate_id: str) -> dict[str, Any]:
    owner, reviewer = OWNERS[gate_id]
    return {
        "schemaVersion": "1.0",
        "gateId": gate_id,
        "evidenceRole": "Supplemental",
        "status": "Open",
        "owner": owner,
        "reviewer": reviewer,
        "fixtureAssertionsPassed": True,
        "primaryCommandExecuted": False,
        "providerWrites": 0,
        "networkWrites": 0,
        "gitRefWrites": 0,
        "position7Mutations": 0,
        "subscriptionMutations": 0,
        "budgetPurchaseMutations": 0,
        "cancellationMutations": 0,
        "optionalHookExecutions": 0,
        "followUp": "Complete the gate-specific native/live/provider/delivery evidence in its later routed phase.",
        "reevaluationTrigger": "Exact source, provider, platform, authority, delivery, or accepted artifact hash changes.",
    }


def write_supplemental_matrix(repository_root: Path, selected: tuple[str, ...] = GATES) -> list[Path]:
    root = repository_root / "specs/031-github-copilot-review-governance/evidence/v1/supplemental"
    root.mkdir(parents=True, exist_ok=True)
    written: list[Path] = []
    for gate_id in selected:
        path = root / f"{gate_id}-fixtures.json"
        path.write_bytes(canonical_bytes(supplemental_record(gate_id)))
        written.append(path)
    return written


def validate_primary(repository_root: Path, evidence_root: Path, gate_id: str) -> tuple[bool, str]:
    # Primary evidence is a later-phase contract. A local fixture record can
    # never satisfy it, even if every deterministic assertion is green.
    primary = evidence_root / "primary" / f"{gate_id}.json"
    if not primary.is_file():
        return False, "Primary evidence is absent; Supplemental/Open remains truthful."
    data = json.loads(primary.read_text(encoding="utf-8"))
    required = {
        "gateId": gate_id,
        "evidenceRole": "Primary",
        "status": "Passed",
        "providerMutationsOutsideAuthorizedScope": 0,
        "secretFindings": 0,
    }
    if any(data.get(key) != value for key, value in required.items()):
        return False, "Primary evidence is incomplete or violates the closed-world gate contract."
    payload_path = data.get("payloadPath")
    payload_hash = data.get("payloadSha256")
    if not isinstance(payload_path, str) or not isinstance(payload_hash, str):
        return False, "Primary payload binding is missing."
    payload = (repository_root / payload_path).resolve()
    if repository_root.resolve() not in payload.parents or not payload.is_file():
        return False, "Primary payload path is unsafe or missing."
    if sha256_file(payload) != payload_hash:
        return False, "Primary payload hash mismatch."
    return True, "Primary evidence passed."


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--gate", choices=GATES, required=True)
    parser.add_argument("--repository-root", default=".")
    parser.add_argument("--evidence-root", required=True)
    parser.add_argument("--check-only", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("-WhatIf", action="store_true", dest="what_if")
    args = parser.parse_args()

    repository_root = Path(args.repository_root).resolve()
    evidence_root = Path(args.evidence_root)
    if not evidence_root.is_absolute():
        evidence_root = (repository_root / evidence_root).resolve()
    if repository_root not in evidence_root.parents:
        raise SystemExit("Evidence root must remain below the repository root")

    passed, reason = validate_primary(repository_root, evidence_root, args.gate)
    result = {
        "schemaVersion": "1.0",
        "gateId": args.gate,
        "result": "Passed" if passed else "Open",
        "evidenceRole": "Primary" if passed else "Supplemental",
        "reason": reason,
        "writes": 0,
    }
    print(json.dumps(result, ensure_ascii=False, sort_keys=True))
    return 0 if passed else 3


if __name__ == "__main__":
    raise SystemExit(main())
