#!/usr/bin/env python3
"""Validate Feature-020 documentation architecture audit evidence read-only."""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path, PurePosixPath
import re
import subprocess
import sys
from typing import Any


ARTIFACT_CLASSES = {
    "ActiveSemantic", "Generated", "Historical", "Archived",
    "ExternalReference", "AgentSurface", "IntakeEvidence",
}
DECISIONS = {
    "KeepAsIs", "Restructure", "SplitByTopic", "SplitByLanguage",
    "MergeDuplicate", "GeneratedFromSource", "ArchiveOnly", "FollowUp",
}
REQUIRED_READER_PATHS = (
    "Learner", "DailyUser", "MaintainerAgent", "AuditTroubleshooting",
)
REQUIRED_SURFACES = (
    "README", "Manpage", "Architecture", "A11Y", "Security",
    "ScriptReference", "FeatureContract",
)
REQUIRED_CONTRACT_IDS = (
    "015-windows-preview", "015-result-resume",
    "016-linux-input", "016-result-aggregation", "016-platform-exact-head",
    "017-remote-freshness", "017-safe-pull", "017-network-evidence",
    "017-worktree-leases", "017-cleanup-boundary", "017-dynamic-profiles",
    "018-mode-selection", "018-safe-preview", "018-confirmation",
    "018-live-jsonl", "018-interruption", "018-fallback", "018-canonical-result",
    "019-jsonl-continuity", "019-report-ownership", "019-early-finalization",
    "019-result-reconciliation", "019-bash32-delegation",
)
SOURCE_CLASSES = {"homeRuntime", "sourceOnly", "machineLocal"}
UNIT_STATUSES = {"Pass", "Gap", "N/A"}
DIMENSION_STATUSES = {"Pass", "IntentionalBoundary", "Gap", "N/A"}
FINDING_SUCCESSORS = {"D5", "D6", "D7", "NonRemediation"}
PRIVATE_PATH = re.compile(r"(?:/Users/|/home/|[A-Za-z]:[\\/]+Users[\\/])[^\s\"']+")
SECRET_PATTERNS = (
    re.compile(r"gh" + r"p_[A-Za-z0-9]{20,}"),
    re.compile(r"github" + r"_pat_[A-Za-z0-9_]{20,}"),
    re.compile(r"AK" + r"IA[0-9A-Z]{16}"),
    re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE " + r"KEY-----"),
)


def _load_collector():
    path = Path(__file__).with_name("collect_documentation_architecture.py")
    spec = importlib.util.spec_from_file_location("feature020_collector_runtime", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load collector {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


collector = _load_collector()
stable_unit_id = collector.stable_unit_id
normalized_sha256_bytes = collector.normalized_sha256_bytes


def add(errors: list[str], category: str, message: str) -> None:
    errors.append(f"{category}: {message}")


def required_text(errors: list[str], value: Any, category: str, label: str) -> str:
    if not isinstance(value, str) or not value.strip():
        add(errors, category, f"{label} must be a non-empty string")
        return ""
    return value.strip()


def valid_relative(path: Any) -> bool:
    if (
        not isinstance(path, str)
        or not path
        or "\\" in path
        or re.match(r"^[A-Za-z]:/", path)
    ):
        return False
    pure = PurePosixPath(path)
    return not pure.is_absolute() and ".." not in pure.parts


def git_blob(repo: Path, commit: str, path: str) -> bytes | None:
    process = subprocess.run(
        ["git", "-C", str(repo), "show", f"{commit}:{path}"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    return process.stdout if process.returncode == 0 else None


def scan_sensitive(value: Any, errors: list[str], location: str = "root") -> None:
    if isinstance(value, dict):
        for key, item in value.items():
            scan_sensitive(item, errors, f"{location}.{key}")
    elif isinstance(value, list):
        for index, item in enumerate(value):
            scan_sensitive(item, errors, f"{location}[{index}]")
    elif isinstance(value, str):
        if PRIVATE_PATH.search(value):
            add(errors, "PRIVATE_PATH", f"private absolute path at {location}")
        if any(pattern.search(value) for pattern in SECRET_PATTERNS):
            add(errors, "SECRET", f"secret-like value at {location}")


def expected_document_paths(repo: Path, commit: str, audit: dict[str, Any]) -> set[str]:
    policy = audit.get("selectionPolicy", {})
    decisions = {
        "documentationSuffixes": policy.get("documentationSuffixes", list(collector.DEFAULT_SUFFIXES)),
        "includeScriptHelp": bool(policy.get("includeScriptHelp", False)),
    }
    paths: set[str] = set()
    for path in collector.list_tree_paths(repo, commit):
        data = collector.blob_bytes(repo, commit, path)
        if collector.is_documentation_surface(path, data, decisions):
            paths.add(path)
    return paths


def validate_exclusions(audit: dict[str, Any], repo: Path, errors: list[str]) -> set[str]:
    rows = audit.get("excludedSurfaces", [])
    if not isinstance(rows, list):
        add(errors, "EXCLUSION_SET", "excludedSurfaces must be an array")
        return set()
    paths = [row.get("path") for row in rows if isinstance(row, dict)]
    if len(paths) != len(set(paths)):
        add(errors, "EXCLUSION_SET", "excluded surface paths must be unique")
    commit = str(audit.get("repositoryCommit", ""))
    for index, row in enumerate(rows):
        if not isinstance(row, dict):
            add(errors, "EXCLUSION_FIELD", f"excludedSurfaces[{index}] must be an object")
            continue
        path = row.get("path")
        if not valid_relative(path):
            add(errors, "EXCLUSION_FIELD", f"excludedSurfaces[{index}].path is invalid")
            continue
        blob = git_blob(repo, commit, path)
        if blob is None or row.get("rawSha256") != hashlib.sha256(blob).hexdigest():
            add(errors, "EXCLUSION_HASH", f"{path} raw hash drift")
        for field in ("reason", "rationale", "owner", "reevaluationTrigger"):
            required_text(errors, row.get(field), "EXCLUSION_FIELD", f"{path}.{field}")
    return {path for path in paths if isinstance(path, str)}


def validate_units(audit: dict[str, Any], repo: Path, errors: list[str]) -> None:
    commit = required_text(errors, audit.get("repositoryCommit"), "IDENTITY", "repositoryCommit")
    units = audit.get("documentationUnits")
    if not isinstance(units, list):
        add(errors, "INVENTORY_SET", "documentationUnits must be an array")
        return
    paths = [unit.get("path") for unit in units if isinstance(unit, dict)]
    duplicates = sorted(path for path, count in Counter(paths).items() if count > 1)
    if duplicates:
        add(errors, "INVENTORY_DUPLICATE", f"duplicate paths: {duplicates}")
    excluded = validate_exclusions(audit, repo, errors)
    try:
        expected = expected_document_paths(repo, commit, audit)
    except Exception as exc:  # collection errors become a stable validation category
        add(errors, "INVENTORY_SET", f"cannot derive accepted tree: {exc}")
        expected = set()
    actual = {path for path in paths if isinstance(path, str)}
    if not excluded.issubset(expected):
        add(errors, "EXCLUSION_SET", f"excluded non-surfaces: {sorted(excluded-expected)}")
    expected_active = expected - excluded
    if actual != expected_active:
        add(errors, "INVENTORY_SET", f"missing={sorted(expected_active-actual)} extra={sorted(actual-expected_active)}")

    for index, unit in enumerate(units):
        label = f"documentationUnits[{index}]"
        if not isinstance(unit, dict):
            add(errors, "UNIT_FIELD", f"{label} must be an object")
            continue
        path = unit.get("path")
        if not valid_relative(path):
            add(errors, "UNIT_PATH", f"{label}.path is not repository-relative")
            continue
        if unit.get("unitId") != stable_unit_id(path):
            add(errors, "UNIT_ID", f"{label}.unitId does not match path")
        blob = git_blob(repo, commit, path)
        if blob is None:
            add(errors, "INVENTORY_HASH", f"{path} is absent from accepted tree")
        else:
            try:
                expected_hash = normalized_sha256_bytes(blob)
            except Exception as exc:
                add(errors, "INVENTORY_HASH", f"{path}: {exc}")
            else:
                if unit.get("normalizedSha256") != expected_hash:
                    add(errors, "INVENTORY_HASH", f"{path} hash drift")
        if unit.get("artifactClass") not in ARTIFACT_CLASSES:
            add(errors, "UNIT_CLASS", f"{path} has invalid artifactClass")
        if unit.get("decision") not in DECISIONS:
            add(errors, "UNIT_DECISION", f"{path} has invalid decision")
        for field in ("family", "canonicalSource", "owner", "rationale", "risk", "reevaluationTrigger"):
            required_text(errors, unit.get(field), "UNIT_FIELD", f"{label}.{field}")
        if not isinstance(unit.get("audiences"), list) or not unit["audiences"]:
            add(errors, "UNIT_FIELD", f"{path} requires audiences")
        if not isinstance(unit.get("readerPaths"), list) or not unit["readerPaths"]:
            add(errors, "UNIT_FIELD", f"{path} requires readerPaths")
        evidence = unit.get("evidence")
        if not isinstance(evidence, list) or not evidence:
            add(errors, "UNIT_EVIDENCE", f"{path} requires evidence")
        if unit.get("distributionClass") not in SOURCE_CLASSES:
            add(errors, "SOURCE_CLASS", f"{path} has invalid distributionClass")


def validate_reader_paths(audit: dict[str, Any], findings: set[str], errors: list[str]) -> None:
    rows = audit.get("readerPaths")
    if not isinstance(rows, list):
        add(errors, "READER_SET", "readerPaths must be an array")
        return
    ids = [row.get("readerPathId") for row in rows if isinstance(row, dict)]
    if len(ids) != len(set(ids)) or set(ids) != set(REQUIRED_READER_PATHS):
        add(errors, "READER_SET", f"expected {list(REQUIRED_READER_PATHS)}, got {ids}")
    for row in rows:
        if not isinstance(row, dict):
            add(errors, "READER_FIELD", "reader path must be an object")
            continue
        row_id = row.get("readerPathId", "unknown")
        for field in ("entryPoints", "prerequisites", "steps", "deepReferences", "evidence"):
            if not isinstance(row.get(field), list) or not row[field]:
                add(errors, "READER_FIELD", f"{row_id}.{field} must be non-empty")
        required_text(errors, row.get("safeNextAction"), "READER_FIELD", f"{row_id}.safeNextAction")
        if row.get("status") not in UNIT_STATUSES:
            add(errors, "READER_FIELD", f"{row_id}.status is invalid")
        validate_gap_reference(row, findings, errors, f"readerPath {row_id}")


def validate_gap_reference(row: dict[str, Any], findings: set[str], errors: list[str], label: str) -> None:
    status = row.get("status")
    finding_id = row.get("findingId")
    if status == "Gap" and finding_id not in findings:
        add(errors, "GAP_FINDING", f"{label} Gap requires a known finding")
    if status != "Gap" and finding_id not in (None, "N/A"):
        add(errors, "GAP_FINDING", f"{label} accepted status cannot retain a finding")


def validate_contracts(audit: dict[str, Any], findings: set[str], errors: list[str]) -> None:
    rows = audit.get("maintenanceContracts")
    if not isinstance(rows, list):
        add(errors, "CONTRACT_SET", "maintenanceContracts must be an array")
        return
    ids = [row.get("contractId") for row in rows if isinstance(row, dict)]
    if len(ids) != len(set(ids)) or set(ids) != set(REQUIRED_CONTRACT_IDS):
        add(errors, "CONTRACT_SET", "maintenance contract set is incomplete or duplicated")
    for row in rows:
        if not isinstance(row, dict):
            add(errors, "CONTRACT_FIELD", "contract row must be an object")
            continue
        contract_id = row.get("contractId", "unknown")
        for field in ("sourceFeature", "topic", "expectedBehavior", "proofBoundary"):
            required_text(errors, row.get(field), "CONTRACT_FIELD", f"{contract_id}.{field}")
        dimensions = row.get("dimensions")
        if not isinstance(dimensions, dict) or set(dimensions) != set(REQUIRED_SURFACES):
            add(errors, "CONTRACT_SURFACE", f"{contract_id} requires all surfaces")
            continue
        for surface, decision in dimensions.items():
            if not isinstance(decision, dict) or decision.get("status") not in DIMENSION_STATUSES:
                add(errors, "CONTRACT_FIELD", f"{contract_id}.{surface} status is invalid")
                continue
            if not isinstance(decision.get("evidence"), list) or not decision["evidence"]:
                add(errors, "CONTRACT_FIELD", f"{contract_id}.{surface} requires evidence")
            validate_gap_reference(decision, findings, errors, f"contract {contract_id}.{surface}")


def validate_source_runtime(audit: dict[str, Any], findings: set[str], errors: list[str]) -> None:
    rows = audit.get("sourceRuntimeRecords")
    if not isinstance(rows, list):
        add(errors, "SOURCE_CLASS_SET", "sourceRuntimeRecords must be an array")
        return
    classes = [row.get("artifactClass") for row in rows if isinstance(row, dict)]
    if len(classes) != len(set(classes)) or set(classes) != SOURCE_CLASSES:
        add(errors, "SOURCE_CLASS_SET", f"expected {sorted(SOURCE_CLASSES)}, got {classes}")
    expected_paths: dict[str, set[str]] = {class_name: set() for class_name in SOURCE_CLASSES}
    for unit in audit.get("documentationUnits", []):
        if isinstance(unit, dict) and unit.get("distributionClass") in SOURCE_CLASSES:
            expected_paths[unit["distributionClass"]].add(unit.get("path"))
    for row in rows:
        if not isinstance(row, dict):
            add(errors, "SOURCE_FIELD", "source/runtime record must be an object")
            continue
        record_id = row.get("recordId", "unknown")
        for field in (
            "recordId", "owner", "canonicalEditLocation", "commitAuthority",
            "remoteAuthority", "benefit", "proofBoundary", "safeNextAction",
        ):
            required_text(errors, row.get(field), "SOURCE_FIELD", f"{record_id}.{field}")
        if not isinstance(row.get("resolvedPaths"), list) or not row["resolvedPaths"]:
            add(errors, "SOURCE_FIELD", f"{record_id}.resolvedPaths must be non-empty")
        elif expected_paths.get(row.get("artifactClass")) and set(row["resolvedPaths"]) != expected_paths[row["artifactClass"]]:
            add(errors, "SOURCE_COVERAGE", f"{record_id}.resolvedPaths does not cover its inventory class")
        if not isinstance(row.get("syncRequired"), bool):
            add(errors, "SOURCE_FIELD", f"{record_id}.syncRequired must be boolean")
        if row.get("status") not in UNIT_STATUSES:
            add(errors, "SOURCE_FIELD", f"{record_id}.status is invalid")
        validate_gap_reference(row, findings, errors, f"source/runtime {record_id}")


def validate_findings(audit: dict[str, Any], errors: list[str]) -> set[str]:
    rows = audit.get("findings")
    if not isinstance(rows, list):
        add(errors, "FINDING_SET", "findings must be an array")
        return set()
    ids = [row.get("findingId") for row in rows if isinstance(row, dict)]
    if len(ids) != len(set(ids)):
        add(errors, "FINDING_SET", "finding IDs must be unique")
    for row in rows:
        if not isinstance(row, dict):
            add(errors, "FINDING_FIELD", "finding must be an object")
            continue
        finding_id = row.get("findingId", "")
        if not re.fullmatch(r"DIA\d{3}", str(finding_id)):
            add(errors, "FINDING_FIELD", f"invalid findingId {finding_id}")
        for field in (
            "summary", "owner", "residualRisk", "targetBoundary",
            "reevaluationTrigger", "status",
        ):
            required_text(errors, row.get(field), "FINDING_FIELD", f"{finding_id}.{field}")
        if row.get("severity") not in {"Critical", "High", "Medium", "Low"}:
            add(errors, "FINDING_FIELD", f"{finding_id}.severity is invalid")
        if row.get("successor") not in FINDING_SUCCESSORS:
            add(errors, "FINDING_FIELD", f"{finding_id}.successor is invalid")
        if not isinstance(row.get("evidence"), list) or not row["evidence"]:
            add(errors, "FINDING_FIELD", f"{finding_id}.evidence must be non-empty")
    return {str(item) for item in ids if isinstance(item, str)}


def validate_governance(audit: dict[str, Any], errors: list[str]) -> None:
    rows = audit.get("governance")
    if not isinstance(rows, list) or not rows:
        add(errors, "GOVERNANCE_SET", "governance must contain reviewed checkpoints")
        return
    for index, row in enumerate(rows):
        if not isinstance(row, dict):
            add(errors, "GOVERNANCE_FIELD", f"governance[{index}] must be an object")
            continue
        label = f"governance[{index}]"
        for field in (
            "preset", "checkpoint", "applicability", "result", "rationale",
            "owner", "reviewer", "reviewDate", "residualRisk", "followUp",
            "reevaluationTrigger",
        ):
            required_text(errors, row.get(field), "GOVERNANCE_FIELD", f"{label}.{field}")
        if row.get("applicability") not in {"Applicable", "N/A", "Open"}:
            add(errors, "GOVERNANCE_FIELD", f"{label}.applicability is invalid")
        if not isinstance(row.get("evidence"), list) or not row["evidence"]:
            add(errors, "GOVERNANCE_FIELD", f"{label}.evidence must be non-empty")


def validate_summary(audit: dict[str, Any], errors: list[str]) -> None:
    summary = audit.get("summary")
    if not isinstance(summary, dict):
        add(errors, "SUMMARY", "summary must be an object")
        return
    units = audit.get("documentationUnits", [])
    findings = audit.get("findings", [])
    if summary.get("documentationUnitCount") != len(units):
        add(errors, "SUMMARY", "documentationUnitCount mismatch")
    if summary.get("excludedSurfaceCount", 0) != len(audit.get("excludedSurfaces", [])):
        add(errors, "SUMMARY", "excludedSurfaceCount mismatch")
    if summary.get("findingCount") != len(findings):
        add(errors, "SUMMARY", "findingCount mismatch")
    counts = Counter(row.get("successor") for row in findings if isinstance(row, dict))
    for successor, field in (("D5", "d5FindingCount"), ("D6", "d6FindingCount"), ("D7", "d7FindingCount")):
        if summary.get(field) != counts.get(successor, 0):
            add(errors, "SUMMARY", f"{field} mismatch")
    if summary.get("status") not in {"Ready", "ReadyWithFindings", "Blocked"}:
        add(errors, "SUMMARY", "status is invalid")
    if findings and summary.get("status") == "Ready":
        add(errors, "SUMMARY", "Ready cannot conceal findings")


def validate_audit(audit: dict[str, Any], repo: Path) -> list[str]:
    errors: list[str] = []
    if audit.get("schemaVersion") != "1.0":
        add(errors, "SCHEMA", "schemaVersion must be 1.0")
    required_text(errors, audit.get("auditId"), "IDENTITY", "auditId")
    if audit.get("inventorySource") != "GitTree":
        add(errors, "IDENTITY", "inventorySource must be GitTree")
    scan_sensitive(audit, errors)
    findings = validate_findings(audit, errors)
    validate_units(audit, repo.resolve(), errors)
    validate_reader_paths(audit, findings, errors)
    validate_contracts(audit, findings, errors)
    validate_source_runtime(audit, findings, errors)
    validate_governance(audit, errors)
    validate_summary(audit, errors)
    return errors


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--audit", required=True, type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        audit = json.loads(args.audit.read_text(encoding="utf-8-sig"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"INVOCATION: {exc}", file=sys.stderr)
        return 2
    errors = validate_audit(audit, args.repo)
    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        return 1
    summary = audit["summary"]
    print(
        "PASS: "
        f"{summary['documentationUnitCount']} units, "
        f"{len(audit['readerPaths'])} reader paths, "
        f"{len(audit['maintenanceContracts'])} contracts, "
        f"{len(audit['sourceRuntimeRecords'])} source/runtime classes, "
        f"{summary['findingCount']} findings"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
