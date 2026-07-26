#!/usr/bin/env python3
"""Validate the feature-local documentation reality audit ledger."""

from __future__ import annotations

import argparse
import json
import pathlib
import re
import sys


DECISIONS = {
    "CurrentAndSupported",
    "UpdateRequired",
    "GeneratedDrift",
    "HistoricalEvidence",
    "IntentionalDeviation",
    "FollowUp",
    "NotApplicable",
    "Blocked",
}
SEVERITIES = {"Critical", "High", "Medium", "Low"}
OWNER_LEVELS = {"Level0", "Level1", "Level2"}
HANDOFFS = {"D2", "D3", "NonRemediation"}
PRIVATE_PATH = re.compile(r"(^|[\s\"'])/(?:Users|home)/[^/\s]+/|[A-Za-z]:\\\\Users\\\\")


def _strings(value):
    if isinstance(value, dict):
        for key, item in value.items():
            yield str(key)
            yield from _strings(item)
    elif isinstance(value, list):
        for item in value:
            yield from _strings(item)
    elif isinstance(value, str):
        yield value


def validate(snapshot: dict, audit: dict) -> list[str]:
    errors: list[str] = []
    repositories = snapshot.get("repositories")
    areas = audit.get("areas")
    findings = audit.get("findings")

    if not isinstance(repositories, list) or not repositories:
        return ["TARGET_COVERAGE: snapshot repositories must be a non-empty list"]
    if not isinstance(areas, list):
        return ["TARGET_COVERAGE: audit areas must be a list"]
    if not isinstance(findings, list):
        return ["FINDING_COMPLETENESS: findings must be a list"]

    target_ids = [item.get("targetId") for item in repositories if isinstance(item, dict)]
    if any(not item for item in target_ids) or len(target_ids) != len(set(target_ids)):
        errors.append("TARGET_IDENTITY: snapshot target IDs must be non-empty and unique")
    known_targets = set(target_ids)

    area_ids: set[str] = set()
    covered_targets: set[str] = set()
    area_by_id: dict[str, dict] = {}
    for area in areas:
        if not isinstance(area, dict):
            errors.append("AREA_IDENTITY: every area must be an object")
            continue
        area_id = area.get("areaId")
        target_id = area.get("targetId")
        if not area_id or area_id in area_ids:
            errors.append(f"AREA_IDENTITY: duplicate or empty area ID {area_id!r}")
        else:
            area_ids.add(area_id)
            area_by_id[area_id] = area
        if target_id not in known_targets:
            errors.append(f"TARGET_COVERAGE: unknown target {target_id!r}")
        else:
            covered_targets.add(target_id)

        decision = area.get("decision")
        if decision not in DECISIONS:
            errors.append(f"DECISION: invalid decision {decision!r} for {area_id!r}")
        evidence = area.get("evidence")
        if not isinstance(evidence, list):
            errors.append(f"CLAIM_EVIDENCE: evidence must be a list for {area_id!r}")
            evidence = []
        if decision in {
            "CurrentAndSupported",
            "HistoricalEvidence",
            "IntentionalDeviation",
        } and not evidence:
            errors.append(f"CLAIM_EVIDENCE: {decision} requires evidence for {area_id!r}")
        for required in ("rationale", "residualRisk", "reevaluationTrigger"):
            if not area.get(required):
                errors.append(f"AREA_COMPLETENESS: {required} missing for {area_id!r}")

    missing_targets = sorted(known_targets - covered_targets)
    if missing_targets:
        errors.append(
            "TARGET_COVERAGE: missing audited targets " + ", ".join(missing_targets)
        )

    finding_ids: set[str] = set()
    finding_count_by_area: dict[str, int] = {}
    required_finding_fields = {
        "findingId",
        "areaId",
        "severity",
        "summary",
        "evidence",
        "ownerLevel",
        "owner",
        "residualRisk",
        "correctionBoundary",
        "reevaluationTrigger",
        "handoff",
    }
    for finding in findings:
        if not isinstance(finding, dict):
            errors.append("FINDING_COMPLETENESS: every finding must be an object")
            continue
        finding_id = finding.get("findingId")
        if (
            not isinstance(finding_id, str)
            or not re.fullmatch(r"DOC[0-9]{3}", finding_id)
            or finding_id in finding_ids
        ):
            errors.append(f"FINDING_IDENTITY: invalid or duplicate ID {finding_id!r}")
        else:
            finding_ids.add(finding_id)
        missing = [
            field
            for field in sorted(required_finding_fields)
            if finding.get(field) in (None, "", [])
        ]
        if missing:
            errors.append(
                f"FINDING_COMPLETENESS: {finding_id!r} missing {', '.join(missing)}"
            )
        area_id = finding.get("areaId")
        if area_id not in area_by_id:
            errors.append(f"FINDING_REFERENCE: unknown area {area_id!r}")
        else:
            finding_count_by_area[area_id] = finding_count_by_area.get(area_id, 0) + 1
        if finding.get("severity") not in SEVERITIES:
            errors.append(f"FINDING_COMPLETENESS: invalid severity for {finding_id!r}")
        if finding.get("ownerLevel") not in OWNER_LEVELS:
            errors.append(f"FINDING_COMPLETENESS: invalid owner level for {finding_id!r}")
        if finding.get("handoff") not in HANDOFFS:
            errors.append(f"FINDING_COMPLETENESS: invalid handoff for {finding_id!r}")

    for area_id, area in area_by_id.items():
        count = finding_count_by_area.get(area_id, 0)
        if area.get("decision") in {"UpdateRequired", "GeneratedDrift"} and count != 1:
            errors.append(
                f"FINDING_RELATION: {area_id!r} requires exactly one finding, got {count}"
            )

    for value in _strings({"snapshot": snapshot, "audit": audit}):
        if PRIVATE_PATH.search(value):
            errors.append("PRIVACY: private absolute path found in publishable evidence")
            break

    if audit.get("status") == "Ready" and errors:
        errors.append("STATUS: Ready is invalid while contract errors remain")
    return errors


def load_json(path: pathlib.Path) -> dict:
    with path.open("r", encoding="utf-8-sig", newline=None) as stream:
        data = json.load(stream)
    if not isinstance(data, dict):
        raise ValueError(f"{path} must contain one JSON object")
    return data


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", type=pathlib.Path, default=pathlib.Path("."))
    parser.add_argument("--snapshot", type=pathlib.Path, required=True)
    parser.add_argument("--audit", type=pathlib.Path, required=True)
    args = parser.parse_args()

    try:
        snapshot = load_json(args.snapshot)
        audit = load_json(args.audit)
    except (OSError, UnicodeError, json.JSONDecodeError, ValueError) as error:
        print(f"INPUT: {error}", file=sys.stderr)
        return 2

    errors = validate(snapshot, audit)
    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        return 1

    print(
        "PASS: documentation audit is current "
        f"({len(snapshot['repositories'])} targets, "
        f"{len(audit['areas'])} areas, {len(audit['findings'])} findings)"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
