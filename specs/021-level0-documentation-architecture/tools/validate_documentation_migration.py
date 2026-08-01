#!/usr/bin/env python3
"""Validate the bounded Feature-021 documentation migration contract."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path, PurePosixPath
from urllib.parse import unquote


DECISIONS = {"Retained", "Moved", "Merged", "Obsolete"}
READERS = {"Learner", "DailyUser", "MaintainerAgent", "AuditTroubleshooting"}
LINK_PATTERN = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
HEADING_PATTERN = re.compile(r"^#{1,6}\s+(.+?)\s*$", re.MULTILINE)
PRIVATE_PATH_PATTERN = re.compile(r"(?:/Users/[^/\s]+|/home/[^/\s]+|[A-Za-z]:\\Users\\[^\\\s]+)")
SECRET_PATTERN = re.compile(r"(?:gh[pousr]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16})")


class ContractError(Exception):
    """One stable validation failure with a machine-readable class."""

    def __init__(self, error_class: str, message: str) -> None:
        super().__init__(f"{error_class}: {message}")


def normalized_bytes(raw: bytes) -> bytes:
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    return raw.replace(b"\r\n", b"\n").replace(b"\r", b"\n")


def load_json(path: Path) -> dict[str, object]:
    try:
        return json.loads(normalized_bytes(path.read_bytes()).decode("utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise ContractError("JSON", f"cannot read {path}: {exc}") from exc


def string_values(value: object):
    """Yield original string values without JSON escape transformations."""
    if isinstance(value, str):
        yield value
    elif isinstance(value, dict):
        for item in value.values():
            yield from string_values(item)
    elif isinstance(value, list):
        for item in value:
            yield from string_values(item)


def repo_path(repo: Path, value: object, error_class: str) -> Path:
    if not isinstance(value, str) or not value:
        raise ContractError(error_class, "path must be a non-empty string")
    candidate = PurePosixPath(value)
    if candidate.is_absolute() or ".." in candidate.parts:
        raise ContractError(error_class, f"path is not repository-relative: {value}")
    return repo / Path(*candidate.parts)


def github_anchor(heading: str) -> str:
    text = re.sub(r"<[^>]+>", "", heading).strip().lower()
    text = re.sub(r"[^\w\- ]", "", text, flags=re.UNICODE)
    return re.sub(r"\s+", "-", text)


def anchors(path: Path) -> set[str]:
    text = normalized_bytes(path.read_bytes()).decode("utf-8")
    return {github_anchor(match) for match in HEADING_PATTERN.findall(text)}


def validate_source(repo: Path, source: object) -> None:
    if not isinstance(source, dict):
        raise ContractError("SOURCE", "source must be an object")
    path = source.get("path")
    commit = source.get("commit")
    expected_hash = source.get("normalizedSha256")
    expected_lines = source.get("lineCount")
    if not all(isinstance(value, str) and value for value in (path, commit, expected_hash)):
        raise ContractError("SOURCE", "path, commit, and normalizedSha256 are required")
    try:
        raw = subprocess.check_output(
            ["git", "show", f"{commit}:{path}"], cwd=repo, stderr=subprocess.PIPE
        )
    except subprocess.CalledProcessError as exc:
        raise ContractError("SOURCE_COMMIT", f"cannot resolve {commit}:{path}") from exc
    data = normalized_bytes(raw)
    actual_hash = hashlib.sha256(data).hexdigest()
    if actual_hash != expected_hash:
        raise ContractError("SOURCE_HASH", f"expected {expected_hash}, got {actual_hash}")
    actual_lines = len(data.decode("utf-8").splitlines())
    if actual_lines != expected_lines:
        raise ContractError("SOURCE_LINES", f"expected {expected_lines}, got {actual_lines}")


def validate_sections(repo: Path, payload: dict[str, object]) -> set[Path]:
    required = payload.get("requiredSectionIds")
    sections = payload.get("sections")
    if not isinstance(required, list) or not all(isinstance(item, str) and item for item in required):
        raise ContractError("SECTION_SET", "requiredSectionIds must be non-empty strings")
    if len(required) != len(set(required)):
        raise ContractError("SECTION_SET", "requiredSectionIds contains duplicates")
    if not isinstance(sections, list):
        raise ContractError("SECTION_SET", "sections must be an array")
    ids = [section.get("sectionId") for section in sections if isinstance(section, dict)]
    if len(ids) != len(set(ids)):
        raise ContractError("SECTION_DUPLICATE", "a sectionId occurs more than once")
    if set(ids) != set(required):
        raise ContractError("SECTION_SET", "sections do not exactly match requiredSectionIds")

    active_paths: set[Path] = set()
    for section in sections:
        if not isinstance(section, dict):
            raise ContractError("SECTION", "section rows must be objects")
        decision = section.get("decision")
        if decision not in DECISIONS:
            raise ContractError("DECISION", f"unsupported decision {decision!r}")
        if section.get("findingId") != "DIA001":
            raise ContractError("FINDING", "every section must trace to DIA001")
        for field in ("sourceHeading", "rationale", "linkEvidence"):
            if not isinstance(section.get(field), str) or not section[field].strip():
                raise ContractError("SECTION", f"{field} is required")
        start, end = section.get("sourceStartLine"), section.get("sourceEndLine")
        if not isinstance(start, int) or not isinstance(end, int) or start < 1 or end < start:
            raise ContractError("SECTION_LINES", "source line range is invalid")
        if decision == "Obsolete":
            continue
        target = repo_path(repo, section.get("targetPath"), "TARGET")
        partner = repo_path(repo, section.get("languagePartner"), "LANGUAGE_PARTNER")
        if not target.is_file():
            raise ContractError("TARGET", f"missing target {target.relative_to(repo)}")
        if not partner.is_file():
            raise ContractError("LANGUAGE_PARTNER", f"missing partner {partner.relative_to(repo)}")
        anchor = section.get("targetAnchor")
        if not isinstance(anchor, str) or not anchor or anchor not in anchors(target):
            raise ContractError("TARGET_ANCHOR", f"missing anchor {anchor!r} in {target.relative_to(repo)}")
        active_paths.update((target, partner))
    return active_paths


def validate_readers(repo: Path, payload: dict[str, object]) -> set[Path]:
    rows = payload.get("readerPaths")
    if not isinstance(rows, list):
        raise ContractError("READER_PATH", "readerPaths must be an array")
    ids = [row.get("readerPathId") for row in rows if isinstance(row, dict)]
    if set(ids) != READERS or len(ids) != len(READERS):
        raise ContractError("READER_PATH", "exactly four unique reader paths are required")
    paths: set[Path] = set()
    for row in rows:
        if not isinstance(row, dict):
            raise ContractError("READER_PATH", "reader path must be an object")
        for field in ("entryPoints", "prerequisites", "orderedSteps", "deepReferences", "languagePartners"):
            value = row.get(field)
            if not isinstance(value, list) or not value or not all(isinstance(item, str) and item for item in value):
                raise ContractError("READER_PATH", f"{row.get('readerPathId')} lacks {field}")
        if not isinstance(row.get("safeNextAction"), str) or not row["safeNextAction"].strip():
            raise ContractError("READER_PATH", f"{row.get('readerPathId')} lacks safeNextAction")
        for field in ("entryPoints", "deepReferences", "languagePartners"):
            for value in row[field]:
                path = repo_path(repo, value, "READER_PATH")
                if not path.is_file():
                    raise ContractError("READER_PATH", f"missing {value}")
                paths.add(path)
    return paths


def validate_markdown_links(repo: Path, paths: set[Path]) -> None:
    for path in sorted(paths):
        if path.suffix.lower() != ".md":
            continue
        text = normalized_bytes(path.read_bytes()).decode("utf-8")
        for raw_target in LINK_PATTERN.findall(text):
            target = raw_target.strip().split(maxsplit=1)[0].strip("<>")
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            decoded = unquote(target)
            file_part, _, fragment = decoded.partition("#")
            resolved = (path.parent / file_part).resolve() if file_part else path.resolve()
            try:
                resolved.relative_to(repo.resolve())
            except ValueError as exc:
                raise ContractError("LINK", f"link escapes repository: {path}: {target}") from exc
            if not resolved.exists():
                raise ContractError("LINK", f"missing target in {path.relative_to(repo)}: {target}")
            if fragment and (not resolved.is_file() or fragment not in anchors(resolved)):
                raise ContractError("LINK", f"missing fragment in {path.relative_to(repo)}: {target}")


def validate(repo: Path, migration: Path) -> dict[str, int]:
    payload = load_json(migration)
    if payload.get("schemaVersion") != "1.0" or payload.get("findingId") != "DIA001":
        raise ContractError("SCHEMA", "schemaVersion 1.0 and findingId DIA001 are required")
    values = list(string_values(payload))
    if any(PRIVATE_PATH_PATTERN.search(value) for value in values):
        raise ContractError("PRIVATE_PATH", "publishable evidence contains a private absolute path")
    if any(SECRET_PATTERN.search(value) for value in values):
        raise ContractError("SECRET", "publishable evidence contains a secret-like token")
    if payload.get("d6FindingCount") != 0 or payload.get("d7FindingCount") != 0:
        raise ContractError("SUCCESSOR_SCOPE", "D6 and D7 finding counts must remain zero")
    validate_source(repo, payload.get("source"))
    paths = validate_sections(repo, payload)
    paths.update(validate_readers(repo, payload))
    validate_markdown_links(repo, paths)
    return {"sections": len(payload["sections"]), "readerPaths": len(payload["readerPaths"]), "linksScannedFiles": len(paths)}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--migration", required=True, type=Path)
    args = parser.parse_args()
    try:
        summary = validate(args.repo.resolve(), args.migration.resolve())
    except ContractError as exc:
        print(str(exc), file=sys.stderr)
        return 1
    print(f"PASS: DIA001 migration has {summary['sections']} sections, {summary['readerPaths']} reader paths, and {summary['linksScannedFiles']} linked files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
