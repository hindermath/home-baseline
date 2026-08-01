#!/usr/bin/env python3
"""Validate Feature-023 fleet adoption evidence against its current sources."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import uuid
from collections import Counter
from pathlib import Path, PurePosixPath
from typing import Any


DECISIONS = {"Adopted", "AlreadyAligned", "NotApplicable", "Blocked"}
APPLICABILITY = {"Applicable", "AlreadyCovered", "N/A"}
IMPACT_DECISIONS = {"UpdateRequired", "NoUpdateRequired", "GeneratedUpdate", "FollowUp"}
SHA256 = re.compile(r"[0-9a-f]{64}")
COMMIT = re.compile(r"[0-9a-f]{40}")


def normalized_sha256(path: Path) -> str:
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    text = raw.decode("utf-8", errors="strict")
    if "\x00" in text:
        raise ValueError(f"binary NUL in {path}")
    normalized = text.replace("\r\n", "\n").replace("\r", "\n")
    return hashlib.sha256(normalized.encode("utf-8")).hexdigest()


def load_json(path: Path) -> dict[str, Any]:
    data = json.loads(path.read_text(encoding="utf-8-sig"))
    if not isinstance(data, dict):
        raise ValueError(f"JSON root must be an object: {path}")
    return data


def relative_path(value: Any) -> bool:
    if not isinstance(value, str) or not value:
        return False
    path = PurePosixPath(value)
    return not path.is_absolute() and ".." not in path.parts and "\\" not in value


class Validation:
    def __init__(self) -> None:
        self.errors: list[str] = []

    def add(self, error_class: str, message: str) -> None:
        self.errors.append(f"{error_class}: {message}")

    def text(self, obj: dict[str, Any], key: str, label: str) -> str:
        value = obj.get(key)
        if not isinstance(value, str) or not value.strip():
            self.add("FIELD_REQUIRED", f"{label}.{key} must be non-empty text")
            return ""
        return value.strip()


def validate_impact(check: Validation, impact: Any, label: str) -> str:
    if not isinstance(impact, dict):
        check.add("IMPACT_REQUIRED", f"{label} must be an object")
        return ""
    decision = check.text(impact, "decision", label)
    if decision not in IMPACT_DECISIONS:
        check.add("IMPACT_DECISION", f"{label}.decision is invalid")
    for field in (
        "source",
        "owner",
        "navigationImpact",
        "documentClass",
        "languageStrategy",
        "platformAndExampleProof",
        "distributionClass",
        "residualRisk",
        "reevaluationTrigger",
    ):
        check.text(impact, field, label)
    for field in ("audiences", "readerPaths", "targetPaths", "languagePartners", "evidence"):
        value = impact.get(field)
        if not isinstance(value, list):
            check.add("IMPACT_REQUIRED", f"{label}.{field} must be an array")
    if not isinstance(impact.get("homeSyncRequired"), bool):
        check.add("IMPACT_REQUIRED", f"{label}.homeSyncRequired must be boolean")
    for path in impact.get("targetPaths", []) + impact.get("evidence", []):
        if not relative_path(path):
            check.add("PATH_SAFETY", f"{label} contains unsafe path {path!r}")
    if decision == "FollowUp":
        for field in ("followUpOwner", "risk", "dueDate", "scopeRationale"):
            check.text(impact, field, label)
    return decision


def validate_delivery(check: Validation, delivery: Any, label: str) -> None:
    if not isinstance(delivery, dict):
        check.add("DELIVERY_REQUIRED", f"{label} must be an object")
        return
    for field in ("branch", "pullRequest"):
        check.text(delivery, field, label)
    for field in ("commit", "reviewedHead", "mergeCommit", "finalDefaultBranchHead"):
        value = check.text(delivery, field, label)
        if value and not COMMIT.fullmatch(value):
            check.add("DELIVERY_HEAD", f"{label}.{field} must be a full Git commit")
    if delivery.get("reviewedHead") != delivery.get("commit"):
        check.add("DELIVERY_HEAD", f"{label} reviewed head differs from committed head")
    if delivery.get("actionableThreads") != 0:
        check.add("DELIVERY_REVIEW", f"{label} must have zero actionable threads")
    if delivery.get("synchronized") is not True:
        check.add("DELIVERY_SYNC", f"{label} must end synchronized")
    for field in ("requiredGates", "providerEvidence"):
        value = delivery.get(field)
        if not isinstance(value, list) or not value:
            check.add("DELIVERY_REQUIRED", f"{label}.{field} must be non-empty")
        for path in value if isinstance(value, list) and field == "providerEvidence" else []:
            if not relative_path(path):
                check.add("PATH_SAFETY", f"{label} contains unsafe evidence path {path!r}")


def validate_target(
    check: Validation,
    target: dict[str, Any],
    expected: dict[str, Any],
    claim_ids: set[str],
    status: str,
) -> None:
    target_id = expected["id"]
    label = f"target[{target_id}]"
    for key in ("kind", "level", "maintenanceClass"):
        if target.get(key) != expected.get(key):
            check.add("TARGET_IDENTITY", f"{label}.{key} differs from manifest")
    if target.get("repositoryPathClass") != expected.get("path") or not relative_path(target.get("repositoryPathClass")):
        check.add("PATH_SAFETY", f"{label}.repositoryPathClass is unsafe or differs from manifest")

    kind = expected.get("kind")
    decision = target.get("decision")
    if decision not in DECISIONS:
        check.add("DECISION", f"{label}.decision is invalid")
    if kind == "collection" and decision not in {"NotApplicable", "Blocked"}:
        check.add("DECISION", f"{label} collection cannot be {decision}")

    assessments = target.get("claimAssessments")
    if not isinstance(assessments, list):
        check.add("CLAIM_SET", f"{label}.claimAssessments must be an array")
        assessments = []
    assessment_ids = [item.get("claimId") for item in assessments if isinstance(item, dict)]
    if kind == "git-repository":
        if len(assessment_ids) != len(set(assessment_ids)) or set(assessment_ids) != claim_ids:
            check.add("CLAIM_SET", f"{label} must assess every source claim exactly once")
        for index, assessment in enumerate(assessments):
            if not isinstance(assessment, dict):
                check.add("CLAIM_SET", f"{label}.claimAssessments[{index}] is invalid")
                continue
            if assessment.get("applicability") not in APPLICABILITY:
                check.add("CLAIM_APPLICABILITY", f"{label} has invalid claim applicability")
            for field in ("targetEvidence", "targetTerminology", "proofBoundary"):
                check.text(assessment, field, f"{label}.claimAssessments[{index}]")
    elif assessments:
        check.add("CLAIM_SET", f"{label} collection must not contain claim assessments")

    impact_decision = validate_impact(check, target.get("documentationImpact"), f"{label}.documentationImpact")
    delivery = target.get("delivery")
    if decision == "Adopted":
        if impact_decision not in {"UpdateRequired", "GeneratedUpdate"}:
            check.add("IMPACT_DECISION", f"{label} adopted target requires an update impact")
        if status == "Complete":
            validate_delivery(check, delivery, f"{label}.delivery")
    elif delivery is not None:
        check.add("DELIVERY_FORBIDDEN", f"{label} non-adopted target must not have delivery")
    if decision in {"AlreadyAligned", "NotApplicable"} and impact_decision != "NoUpdateRequired":
        check.add("IMPACT_DECISION", f"{label} unchanged target requires NoUpdateRequired")
    if decision == "Blocked" and impact_decision != "FollowUp":
        check.add("IMPACT_DECISION", f"{label} blocked target requires FollowUp")

    for field in ("rationale", "residualRisk", "nextAction", "reevaluationTrigger"):
        check.text(target, field, label)


def validate(repo: Path, matrix_path: Path) -> tuple[list[str], dict[str, int]]:
    check = Validation()
    try:
        matrix = load_json(matrix_path)
    except Exception as exc:
        return [f"JSON_INVALID: {exc}"], {}

    if matrix.get("schemaVersion") != "1.0":
        check.add("SCHEMA", "schemaVersion must be 1.0")
    if matrix.get("feature") != "023-registered-doc-architecture-adoption":
        check.add("SCHEMA", "feature identity is invalid")
    status = matrix.get("status")
    if status not in {"Draft", "Complete"}:
        check.add("SCHEMA", "status must be Draft or Complete")

    sources: dict[str, dict[str, Any]] = {}
    for key in ("sourceManifest", "sourceClaims"):
        source = matrix.get(key)
        if not isinstance(source, dict):
            check.add("SOURCE_BINDING", f"{key} must be an object")
            continue
        path_value = source.get("path")
        digest_value = source.get("normalizedSha256")
        if not relative_path(path_value):
            check.add("PATH_SAFETY", f"{key}.path is unsafe")
            continue
        source_path = repo / path_value
        if not source_path.is_file():
            check.add("SOURCE_BINDING", f"{key}.path does not exist")
            continue
        try:
            actual = normalized_sha256(source_path)
        except Exception as exc:
            check.add("SOURCE_BINDING", f"{key} cannot be normalized: {exc}")
            continue
        if not isinstance(digest_value, str) or not SHA256.fullmatch(digest_value) or digest_value != actual:
            check.add("SOURCE_BINDING", f"{key} hash differs from current source")
        try:
            sources[key] = load_json(source_path)
        except Exception as exc:
            check.add("SOURCE_BINDING", f"{key} JSON is invalid: {exc}")

    manifest_targets = {
        item["id"]: item
        for item in sources.get("sourceManifest", {}).get("targets", [])
        if isinstance(item, dict) and item.get("active") is True and isinstance(item.get("id"), str)
    }
    claims = sources.get("sourceClaims", {}).get("claims", [])
    claim_ids = {item.get("id") for item in claims if isinstance(item, dict) and isinstance(item.get("id"), str)}
    if len(claim_ids) != 17 or matrix.get("sourceClaims", {}).get("count") != 17:
        check.add("CLAIM_SET", "source claims must contain exactly 17 unique IDs")

    targets = matrix.get("targets")
    if not isinstance(targets, list):
        check.add("TARGET_SET", "targets must be an array")
        targets = []
    target_ids = [item.get("targetId") for item in targets if isinstance(item, dict)]
    duplicates = [target_id for target_id, count in Counter(target_ids).items() if count > 1]
    if duplicates:
        check.add("TARGET_DUPLICATE", f"duplicate targets: {', '.join(sorted(duplicates))}")
    if set(target_ids) != set(manifest_targets):
        check.add("TARGET_SET", "matrix targets differ from active manifest targets")

    preflight = matrix.get("preflight")
    if not isinstance(preflight, dict):
        check.add("PREFLIGHT", "preflight must be an object")
        preflight = {}
    try:
        uuid.UUID(str(preflight.get("runId")))
    except ValueError:
        check.add("PREFLIGHT", "preflight.runId must be a UUID")
    git_count = sum(item.get("kind") == "git-repository" for item in manifest_targets.values())
    collection_count = len(manifest_targets) - git_count
    if preflight.get("gitTargets") != git_count or preflight.get("fetchAttemptsCompleted") != git_count:
        check.add("PREFLIGHT", "all active Git targets must have completed fetch attempts")
    if preflight.get("collectionTargets") != collection_count:
        check.add("PREFLIGHT", "collection target count differs from manifest")
    before = preflight.get("propagationTargetSetBefore")
    after = preflight.get("propagationTargetSetAfter")
    if not isinstance(before, str) or not SHA256.fullmatch(before):
        check.add("PREFLIGHT", "propagationTargetSetBefore must be SHA-256")
    if status == "Complete" and before != after:
        check.add("PROPAGATION_DRIFT", "propagation target set changed")
    if status == "Complete" and preflight.get("firstTargetMutation") != "AfterFetchBarrier":
        check.add("PREFLIGHT", "complete evidence must place first mutation after fetch barrier")

    for target in targets:
        if not isinstance(target, dict) or target.get("targetId") not in manifest_targets:
            continue
        validate_target(check, target, manifest_targets[target["targetId"]], claim_ids, status)

    counts = Counter(item.get("decision") for item in targets if isinstance(item, dict))
    return check.errors, {decision: counts.get(decision, 0) for decision in sorted(DECISIONS)}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", type=Path, required=True)
    parser.add_argument("--matrix", type=Path, required=True)
    args = parser.parse_args()
    errors, counts = validate(args.repo.resolve(), args.matrix.resolve())
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    count_text = ", ".join(f"{key}={value}" for key, value in counts.items())
    print(f"PASS: fleet adoption matrix is current ({count_text})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
