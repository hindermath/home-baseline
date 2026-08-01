#!/usr/bin/env python3

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path


READER_PATH_IDS = {
    "FirstSafeRun",
    "RegularOperation",
    "MaintainerAgent",
    "AuditTroubleshooting",
}
CLAIM_CATEGORIES = {
    "Option",
    "Status",
    "ExitCode",
    "Evidence",
    "SafetyBoundary",
    "Distribution",
    "Recovery",
    "Platform",
    "NextAction",
}
SOURCE_STATES = {"Current", "HistoricalBoundary"}
HEX_40 = re.compile(r"^[0-9a-f]{40}$")
HEX_64 = re.compile(r"^[0-9a-f]{64}$")
CLAIM_ID = re.compile(r"^AEC[0-9]{3}$")


def normalized_text(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig").replace("\r\n", "\n").replace("\r", "\n")


def normalized_hash(path: Path) -> str:
    return hashlib.sha256(normalized_text(path).encode("utf-8")).hexdigest()


def non_empty(value) -> bool:
    return isinstance(value, str) and bool(value.strip())


def resolve_relative(repo: Path, value, error_class: str, errors: list[str]) -> Path | None:
    if not non_empty(value):
        errors.append(f"{error_class}: missing repository-relative path")
        return None
    candidate = Path(value)
    if candidate.is_absolute() or ".." in candidate.parts:
        errors.append(f"{error_class}: path must stay repository-relative: {value}")
        return None
    resolved_repo = repo.resolve()
    resolved = (resolved_repo / candidate).resolve()
    try:
        resolved.relative_to(resolved_repo)
    except ValueError:
        errors.append(f"{error_class}: path escapes repository: {value}")
        return None
    if not resolved.is_file():
        errors.append(f"{error_class}: file does not exist: {value}")
        return None
    tracked = subprocess.run(
        ["git", "ls-files", "--error-unmatch", "--", candidate.as_posix()],
        cwd=resolved_repo,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        check=False,
    )
    if tracked.returncode != 0:
        errors.append(f"{error_class}: file is not Git-tracked: {value}")
        return None
    return resolved


def validate_reader_paths(repo: Path, matrix: dict, errors: list[str]) -> dict[str, dict]:
    records = matrix.get("readerPaths")
    if not isinstance(records, list):
        errors.append("READER_PATH: readerPaths must be an array")
        return {}
    by_id: dict[str, dict] = {}
    for record in records:
        if not isinstance(record, dict):
            errors.append("READER_PATH: each reader path must be an object")
            continue
        identifier = record.get("id")
        if identifier in by_id:
            errors.append(f"READER_PATH: duplicate reader path: {identifier}")
            continue
        if identifier not in READER_PATH_IDS:
            errors.append(f"READER_PATH: unknown reader path: {identifier}")
            continue
        by_id[identifier] = record
        resolve_relative(repo, record.get("germanEntry"), "READER_PATH", errors)
        resolve_relative(repo, record.get("englishEntry"), "READER_PATH", errors)
        if not non_empty(record.get("guideAnchor")):
            errors.append(f"READER_PATH: {identifier} lacks guideAnchor")
        if not non_empty(record.get("safeNextAction")):
            errors.append(f"READER_PATH: {identifier} lacks safeNextAction")
    missing = READER_PATH_IDS - set(by_id)
    extra = set(by_id) - READER_PATH_IDS
    if missing or extra or len(records) != len(READER_PATH_IDS):
        errors.append(
            "READER_PATH: expected exactly "
            + ", ".join(sorted(READER_PATH_IDS))
            + f"; missing={sorted(missing)} extra={sorted(extra)}"
        )
    return by_id


def validate_claims(repo: Path, matrix: dict, reader_paths: dict[str, dict], errors: list[str]) -> None:
    required = matrix.get("requiredClaimCategories")
    if not isinstance(required, list) or set(required) != CLAIM_CATEGORIES or len(required) != len(CLAIM_CATEGORIES):
        errors.append("CLAIM_COVERAGE: requiredClaimCategories must contain every allowed category exactly once")
    claims = matrix.get("claims")
    if not isinstance(claims, list) or not claims:
        errors.append("CLAIM_COVERAGE: claims must be a non-empty array")
        return
    seen: set[str] = set()
    covered: set[str] = set()
    for claim in claims:
        if not isinstance(claim, dict):
            errors.append("CLAIM_IDENTITY: every claim must be an object")
            continue
        identifier = claim.get("id")
        if not isinstance(identifier, str) or not CLAIM_ID.fullmatch(identifier):
            errors.append(f"CLAIM_IDENTITY: invalid claim id: {identifier}")
        elif identifier in seen:
            errors.append(f"CLAIM_IDENTITY: duplicate claim id: {identifier}")
        else:
            seen.add(identifier)

        category = claim.get("category")
        if category not in CLAIM_CATEGORIES:
            errors.append(f"CLAIM_COVERAGE: unknown category for {identifier}: {category}")
        else:
            covered.add(category)

        claim_paths = claim.get("readerPaths")
        if not isinstance(claim_paths, list) or not claim_paths or len(claim_paths) != len(set(claim_paths)):
            errors.append(f"CLAIM_READER_PATH: {identifier} needs unique reader paths")
        elif any(path not in reader_paths for path in claim_paths):
            errors.append(f"CLAIM_READER_PATH: {identifier} references unknown reader path")

        languages = claim.get("languages")
        if languages != ["de", "en"]:
            errors.append(f"LANGUAGE_PARTNER: {identifier} languages must be exactly ['de', 'en']")
        for field in ("statement", "sourceLocator", "proofBoundary", "reevaluationTrigger"):
            if not non_empty(claim.get(field)):
                errors.append(f"CLAIM_CONTENT: {identifier} lacks {field}")

        source = resolve_relative(repo, claim.get("sourcePath"), "SOURCE_PATH", errors)
        expected_hash = claim.get("sourceNormalizedSha256")
        if not isinstance(expected_hash, str) or not HEX_64.fullmatch(expected_hash):
            errors.append(f"SOURCE_HASH: {identifier} has invalid SHA-256")
        elif source is not None and normalized_hash(source) != expected_hash:
            errors.append(f"SOURCE_HASH: {identifier} source hash drift")
        if source is not None and non_empty(claim.get("sourceLocator")):
            if claim["sourceLocator"] not in normalized_text(source):
                errors.append(f"SOURCE_LOCATOR: {identifier} locator not found in source")

        source_state = claim.get("sourceState")
        if source_state not in SOURCE_STATES:
            errors.append(f"SOURCE_STATE: {identifier} has unknown source state")
        elif source_state == "HistoricalBoundary":
            boundary = str(claim.get("proofBoundary", "")).lower()
            if "not current authority" not in boundary:
                errors.append(
                    f"HISTORICAL_BOUNDARY: {identifier} must state that the source is not current authority"
                )

    missing_categories = CLAIM_CATEGORIES - covered
    if missing_categories:
        errors.append(f"CLAIM_COVERAGE: missing categories: {', '.join(sorted(missing_categories))}")


def validate_impact(repo: Path, matrix: dict, reader_paths: dict[str, dict], errors: list[str]) -> None:
    impact = matrix.get("documentationImpact")
    if not isinstance(impact, dict):
        errors.append("DOCUMENTATION_IMPACT: documentationImpact must be an object")
        return
    required_strings = (
        "owner",
        "navigationImpact",
        "documentClass",
        "languageStrategy",
        "platformAndExampleProof",
        "evidence",
        "reevaluationTrigger",
    )
    if impact.get("decision") != "UpdateRequired":
        errors.append("DOCUMENTATION_IMPACT: decision must be UpdateRequired")
    for field in required_strings:
        if not non_empty(impact.get(field)):
            errors.append(f"DOCUMENTATION_IMPACT: missing {field}")
    for field in ("audiences", "readerPaths", "canonicalSources", "languagePartners"):
        value = impact.get(field)
        if not isinstance(value, list) or not value or len(value) != len(set(value)):
            errors.append(f"DOCUMENTATION_IMPACT: {field} must be a non-empty unique array")
    if set(impact.get("readerPaths", [])) != set(reader_paths):
        errors.append("DOCUMENTATION_IMPACT: readerPaths must cover all four paths")
    if impact.get("distributionClass") != "sourceOnly" or impact.get("homeSyncRequired") is not False:
        errors.append("DOCUMENTATION_IMPACT: distribution must be sourceOnly with homeSyncRequired=false")

    partners = impact.get("languagePartners", [])
    if not isinstance(partners, list) or len(partners) != 2:
        errors.append("LANGUAGE_PARTNER: exactly two guide partners are required")
        return
    partner_paths = [resolve_relative(repo, value, "LANGUAGE_PARTNER", errors) for value in partners]
    for reader in reader_paths.values():
        anchor = reader.get("guideAnchor")
        if not non_empty(anchor):
            continue
        marker = f'id="{anchor}"'
        for partner in partner_paths:
            if partner is not None and marker not in normalized_text(partner):
                errors.append(f"LANGUAGE_PARTNER: anchor {anchor} missing from {partner.relative_to(repo)}")
    for value in impact.get("canonicalSources", []):
        resolve_relative(repo, value, "DOCUMENTATION_IMPACT", errors)


def validate(repo: Path, matrix: dict) -> list[str]:
    repo = repo.resolve()
    errors: list[str] = []
    if matrix.get("schemaVersion") != "1.0":
        errors.append("SCHEMA: schemaVersion must be 1.0")
    if matrix.get("feature") != "022-agentic-workspace-efficiency-guide":
        errors.append("SCHEMA: feature identity mismatch")
    head = matrix.get("generatedFromHead")
    if not isinstance(head, str) or not HEX_40.fullmatch(head):
        errors.append("SCHEMA: generatedFromHead must be a lowercase 40-character commit id")
    reader_paths = validate_reader_paths(repo, matrix, errors)
    validate_claims(repo, matrix, reader_paths, errors)
    validate_impact(repo, matrix, reader_paths, errors)
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate the Feature 022 source matrix")
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--matrix", required=True, type=Path)
    args = parser.parse_args()
    repo = args.repo.resolve()
    matrix_path = args.matrix if args.matrix.is_absolute() else repo / args.matrix
    try:
        matrix = json.loads(normalized_text(matrix_path))
    except (OSError, UnicodeError, json.JSONDecodeError) as error:
        print(f"MATRIX_PARSE: {error}")
        return 1
    if not isinstance(matrix, dict):
        print("SCHEMA: matrix root must be an object")
        return 1
    errors = validate(repo, matrix)
    if errors:
        for error in errors:
            print(error)
        return 1
    print(
        "PASS: Feature 022 source matrix "
        f"({len(matrix['readerPaths'])} reader paths, {len(matrix['claims'])} claims)"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
