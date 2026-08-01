#!/usr/bin/env python3
"""Collect deterministic Feature-020 documentation evidence from a Git tree."""

from __future__ import annotations

import argparse
from collections import Counter
import copy
import fnmatch
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import subprocess
import sys
from typing import Any


DEFAULT_SUFFIXES = (".md", ".json", ".txt", ".1", ".rst", ".adoc")
SCRIPT_SUFFIXES = (".sh", ".ps1")
SCRIPT_HELP_MARKERS = (".SYNOPSIS", ".DESCRIPTION", "Usage:", "Verwendung")


class CollectionError(ValueError):
    """Raised when accepted Git evidence cannot be collected safely."""


def run_git(repo: Path, *args: str) -> bytes:
    process = subprocess.run(
        ["git", "-C", str(repo), *args],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if process.returncode != 0:
        detail = process.stderr.decode("utf-8", errors="replace").strip()
        raise CollectionError(f"git {' '.join(args)} failed: {detail}")
    return process.stdout


def normalize_text_bytes(data: bytes) -> bytes:
    if data.startswith(b"\xef\xbb\xbf"):
        data = data[3:]
    text = data.decode("utf-8", errors="strict")
    if "\x00" in text:
        raise CollectionError("binary NUL detected")
    return text.replace("\r\n", "\n").replace("\r", "\n").encode("utf-8")


def normalized_sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(normalize_text_bytes(data)).hexdigest()


def stable_unit_id(path: str) -> str:
    digest = hashlib.sha256(path.encode("utf-8")).hexdigest()[:16]
    return f"DU-{digest}"


def blob_bytes(repo: Path, commit: str, path: str) -> bytes:
    return run_git(repo, "show", f"{commit}:{path}")


def list_tree_paths(repo: Path, commit: str) -> list[str]:
    raw = run_git(repo, "ls-tree", "-r", "-z", "--name-only", commit)
    paths = [part.decode("utf-8", errors="strict") for part in raw.split(b"\0") if part]
    if len(paths) != len(set(paths)):
        raise CollectionError("Git tree contains duplicate path identities")
    return sorted(paths)


def is_documentation_surface(path: str, data: bytes, decisions: dict[str, Any]) -> bool:
    suffixes = tuple(str(item).lower() for item in decisions.get("documentationSuffixes", DEFAULT_SUFFIXES))
    lower = path.lower()
    if lower.endswith(suffixes) or PurePosixPath(path).name in {"LICENSE", "COPYING", "NOTICE"}:
        return True
    if decisions.get("includeScriptHelp", False) and lower.endswith(SCRIPT_SUFFIXES):
        text = normalize_text_bytes(data).decode("utf-8")
        return any(marker in text for marker in SCRIPT_HELP_MARKERS)
    return False


def family_for(path: str) -> str:
    parts = PurePosixPath(path).parts
    if len(parts) == 1:
        return "Root"
    if parts[0] == "docs" and len(parts) > 2:
        return "/".join(parts[:2])
    if parts[0] == "specs" and len(parts) > 2:
        return "/".join(parts[:2])
    if parts[0] == ".specify" and "presets" in parts and len(parts) > 3:
        return "/".join(parts[:3])
    return parts[0]


def match_rule(path: str, rule: dict[str, Any]) -> bool:
    checks = []
    if "pathEquals" in rule:
        checks.append(path == rule["pathEquals"])
    if "pathPrefix" in rule:
        checks.append(path.startswith(rule["pathPrefix"]))
    if "pathContains" in rule:
        checks.append(rule["pathContains"] in path)
    if "pathSuffix" in rule:
        checks.append(path.endswith(rule["pathSuffix"]))
    if "pathRegex" in rule:
        checks.append(re.search(rule["pathRegex"], path) is not None)
    return bool(checks) and all(checks)


def manifest_group_matches(path: str, group: dict[str, Any]) -> bool:
    name = PurePosixPath(path).name
    if path in group.get("rootFiles", []):
        return True
    if "/" not in path and any(fnmatch.fnmatch(name, pattern) for pattern in group.get("rootGlobs", [])):
        return True
    if any(path.startswith(prefix) for prefix in group.get("trackedPrefixes", [])):
        return True
    return any(fnmatch.fnmatch(path, pattern) for pattern in group.get("trackedGlobs", []))


def manifest_group_excludes(path: str, group: dict[str, Any]) -> bool:
    if path in group.get("excludePaths", []):
        return True
    if any(path.startswith(prefix) for prefix in group.get("excludePrefixes", [])):
        return True
    return any(fnmatch.fnmatch(path, pattern) for pattern in group.get("excludeGlobs", []))


def distribution_class(path: str, manifest: dict[str, Any]) -> str:
    for class_name in ("machineLocal", "homeRuntime", "sourceOnly"):
        group = manifest.get(class_name, {})
        if manifest_group_matches(path, group) and not manifest_group_excludes(path, group):
            return class_name
    return "sourceOnly"


def apply_decision(path: str, decisions: dict[str, Any], distribution: str) -> dict[str, Any]:
    selected = copy.deepcopy(decisions["defaultDecision"])
    for rule in decisions.get("rules", []):
        if match_rule(path, rule):
            selected.update(copy.deepcopy(rule.get("set", {})))
    selected.update(copy.deepcopy(decisions.get("overrides", {}).get(path, {})))
    for field in ("canonicalSource",):
        if selected.get(field) == "self":
            selected[field] = path
    selected["evidence"] = [path if item == "self" else item for item in selected.get("evidence", [])]
    selected["distributionClass"] = distribution
    return selected


def collect_inventory(repo: Path, commit: str, decisions: dict[str, Any]) -> dict[str, Any]:
    repo = repo.resolve()
    accepted_commit = run_git(repo, "rev-parse", f"{commit}^{{commit}}").decode("ascii").strip()
    if accepted_commit != decisions.get("repositoryCommit"):
        raise CollectionError("decisions repositoryCommit does not match requested commit")

    manifest_path = "scripts/config/home-sync-manifest.json"
    manifest = json.loads(normalize_text_bytes(blob_bytes(repo, commit, manifest_path)).decode("utf-8"))
    units: list[dict[str, Any]] = []
    excluded: list[dict[str, Any]] = []
    for path in list_tree_paths(repo, commit):
        data = blob_bytes(repo, commit, path)
        try:
            if not is_documentation_surface(path, data, decisions):
                continue
            selected = apply_decision(path, decisions, distribution_class(path, manifest))
            unit = {
                "unitId": stable_unit_id(path),
                "path": path,
                "normalizedSha256": normalized_sha256_bytes(data),
                "family": family_for(path),
                **selected,
            }
        except (CollectionError, UnicodeError) as exc:
            exclusion = decisions.get("exclusions", {}).get(path)
            if not isinstance(exclusion, dict):
                raise CollectionError(f"{path}: {exc}") from exc
            excluded.append({
                "path": path,
                "rawSha256": hashlib.sha256(data).hexdigest(),
                "reason": exclusion.get("reason", ""),
                "rationale": exclusion.get("rationale", ""),
                "owner": exclusion.get("owner", ""),
                "reevaluationTrigger": exclusion.get("reevaluationTrigger", ""),
            })
            continue
        units.append(unit)

    class_counts = Counter(unit["artifactClass"] for unit in units)
    decision_counts = Counter(unit["decision"] for unit in units)
    distribution_counts = Counter(unit["distributionClass"] for unit in units)
    return {
        "schemaVersion": "1.0",
        "auditId": decisions["auditId"],
        "repositoryCommit": accepted_commit,
        "inventorySource": "GitTree",
        "selectionPolicy": {
            "documentationSuffixes": decisions.get("documentationSuffixes", list(DEFAULT_SUFFIXES)),
            "includeScriptHelp": bool(decisions.get("includeScriptHelp", False)),
        },
        "documentationUnits": units,
        "excludedSurfaces": excluded,
        "summary": {
            "documentationUnitCount": len(units),
            "excludedSurfaceCount": len(excluded),
            "artifactClassCounts": dict(sorted(class_counts.items())),
            "decisionCounts": dict(sorted(decision_counts.items())),
            "distributionClassCounts": dict(sorted(distribution_counts.items())),
        },
    }


def expand_maintenance_contracts(decisions: dict[str, Any]) -> list[dict[str, Any]]:
    shared = decisions.get("maintenanceSurfaceEvidence", {})
    rows: list[dict[str, Any]] = []
    for source in decisions.get("maintenanceContracts", []):
        row = copy.deepcopy(source)
        feature_evidence = row.pop("featureEvidence", [])
        status_by_surface = row.pop("statusBySurface", {})
        evidence_by_surface = row.pop("evidenceBySurface", {})
        dimensions: dict[str, Any] = {}
        for surface in (
            "README", "Manpage", "Architecture", "A11Y", "Security",
            "ScriptReference", "FeatureContract",
        ):
            evidence = evidence_by_surface.get(surface)
            if evidence is None:
                evidence = feature_evidence if surface == "FeatureContract" else shared.get(surface, [])
            dimensions[surface] = {
                "status": status_by_surface.get(surface, "Pass"),
                "evidence": copy.deepcopy(evidence),
            }
        row["dimensions"] = dimensions
        rows.append(row)
    return rows


def expand_source_runtime_records(
    inventory: dict[str, Any], decisions: dict[str, Any],
) -> list[dict[str, Any]]:
    paths_by_class: dict[str, list[str]] = {}
    for unit in inventory["documentationUnits"]:
        paths_by_class.setdefault(unit["distributionClass"], []).append(unit["path"])
    rows: list[dict[str, Any]] = []
    for source in decisions.get("sourceRuntimeRecords", []):
        row = copy.deepcopy(source)
        if row.get("resolvedPaths") == "$inventory":
            row["resolvedPaths"] = sorted(paths_by_class.get(row.get("artifactClass"), []))
        rows.append(row)
    return rows


def build_audit(inventory: dict[str, Any], decisions: dict[str, Any]) -> dict[str, Any]:
    findings = copy.deepcopy(decisions.get("findings", []))
    successor_counts = Counter(finding.get("successor") for finding in findings)
    audit = {
        "schemaVersion": "1.0",
        "auditId": inventory["auditId"],
        "capturedAt": decisions["capturedAt"],
        "repositoryCommit": inventory["repositoryCommit"],
        "inventorySource": "GitTree",
        "selectionPolicy": inventory["selectionPolicy"],
        "acceptedEvidence": copy.deepcopy(decisions.get("acceptedEvidence", [])),
        "documentationUnits": inventory["documentationUnits"],
        "excludedSurfaces": inventory.get("excludedSurfaces", []),
        "readerPaths": copy.deepcopy(decisions.get("readerPaths", [])),
        "maintenanceContracts": expand_maintenance_contracts(decisions),
        "sourceRuntimeRecords": expand_source_runtime_records(inventory, decisions),
        "findings": findings,
        "governance": copy.deepcopy(decisions.get("governance", [])),
        "summary": {
            **inventory["summary"],
            "status": decisions.get("status", "Draft"),
            "findingCount": len(findings),
            "d5FindingCount": successor_counts.get("D5", 0),
            "d6FindingCount": successor_counts.get("D6", 0),
            "d7FindingCount": successor_counts.get("D7", 0),
        },
    }
    return audit


def write_json(path: Path, value: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--commit", required=True)
    parser.add_argument("--decisions", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--audit-output", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        decisions = json.loads(args.decisions.read_text(encoding="utf-8-sig"))
        inventory = collect_inventory(args.repo, args.commit, decisions)
        write_json(args.output, inventory)
        if args.audit_output is not None:
            write_json(args.audit_output, build_audit(inventory, decisions))
    except (CollectionError, UnicodeError, OSError, json.JSONDecodeError, KeyError, TypeError) as exc:
        print(f"COLLECTION_ERROR: {exc}", file=sys.stderr)
        return 2
    print(
        f"PASS: {inventory['summary']['documentationUnitCount']} documentation units "
        f"from {inventory['repositoryCommit']}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
