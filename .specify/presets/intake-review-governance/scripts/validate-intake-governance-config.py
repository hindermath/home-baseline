#!/usr/bin/env python3
"""Validate the portable requirements/intake governance configuration."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path, PurePosixPath

BCP47 = re.compile(r"^[A-Za-z]{2,3}(?:-[A-Za-z0-9]{2,8})*$")
PROFILES = {
    "de": {
        "canonicalIndex": "Pflichtenheft.md",
        "intakePattern": "Lastenheft_<slug>.md",
        "orderView": "Lastenheft_Abarbeitungsreihenfolge.md",
    },
    "en": {
        "canonicalIndex": "RequirementsIndex.md",
        "intakePattern": "RequirementsIntake_<slug>.md",
        "orderView": "RequirementsIntakeOrder.md",
    },
}
ROLE_KEYS = {
    "requirements-index",
    "requirements-intake",
    "intake-order",
    "requirements-baseline",
}
COLLECTION_KEYS = {
    "baseline",
    "active",
    "archive",
    "backlog",
    "history",
    "seriesManifest",
}


class ContractError(Exception):
    """A stable validation error."""

    def __init__(self, code: str, message: str, outcome: str = "Blocked") -> None:
        super().__init__(message)
        self.code = code
        self.outcome = outcome


def fail(code: str, message: str, outcome: str = "Blocked") -> None:
    raise ContractError(code, message, outcome)


def load_json(path: Path) -> dict:
    try:
        raw = path.read_bytes()
        if raw.startswith(b"\xef\xbb\xbf"):
            raw = raw[3:]
        text = raw.decode("utf-8", errors="strict")
        if "\x00" in text:
            fail("RIG001", "binary NUL is not allowed")
        data = json.loads(text.replace("\r\n", "\n").replace("\r", "\n"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        fail("RIG001", f"invalid strict UTF-8 JSON: {exc}")
    if not isinstance(data, dict):
        fail("RIG001", "configuration root must be an object")
    return data


def relative(value: str) -> bool:
    candidate = PurePosixPath(value)
    return bool(value) and not candidate.is_absolute() and ".." not in candidate.parts


def required_text(obj: dict, key: str, code: str) -> str:
    value = obj.get(key)
    if not isinstance(value, str) or not value.strip():
        fail(code, f"{key} must be a non-empty string")
    return value.strip()


def validate_path(value: str, label: str) -> None:
    if not relative(value):
        fail("RIG004", f"{label} must be repository-relative")


def validate_config(data: dict, repo: Path) -> dict:
    schema = data.get("schemaVersion")
    if schema == "1.0":
        fail("RIG002", "schema 1.0 requires an authorized migration", "MigrationRequired")
    if schema != "2.0":
        fail("RIG002", "schemaVersion must be 2.0")

    language = data.get("documentationLanguage")
    if not isinstance(language, str) or not language.strip():
        fail("RIG003", "documentationLanguage needs an explicit BCP-47 value", "NeedsClarification")
    language = language.strip()
    if language in {"Undetermined", "und"}:
        fail("RIG003", "documentation language remains ambiguous", "NeedsClarification")
    if not BCP47.fullmatch(language):
        fail("RIG003", "documentationLanguage is not a supported BCP-47 shape")

    naming = data.get("artifactNaming")
    if not isinstance(naming, dict):
        fail("RIG005", "artifactNaming must be an object")
    profile = required_text(naming, "profile", "RIG005")
    if profile not in {"de", "en", "explicit"}:
        fail("RIG005", "artifactNaming.profile must be de, en, or explicit")
    resolved = dict(PROFILES.get(profile, {}))
    for key in ("canonicalIndex", "intakePattern", "orderView"):
        override = naming.get(key)
        if override is not None:
            if not isinstance(override, str) or not override.strip():
                fail("RIG005", f"artifactNaming.{key} must be non-empty")
            resolved[key] = override.strip()
        if key not in resolved:
            fail("RIG005", f"explicit profile requires artifactNaming.{key}")
        validate_path(resolved[key], f"artifactNaming.{key}")
    if "<slug>" not in resolved["intakePattern"]:
        fail("RIG005", "intakePattern must contain <slug>")

    roles = data.get("roles")
    if not isinstance(roles, dict) or set(roles) != ROLE_KEYS:
        fail("RIG006", "roles must contain exactly the four portable role IDs")
    for key, value in roles.items():
        if not isinstance(value, str):
            fail("RIG006", f"roles.{key} must be a string")
        validate_path(value, f"roles.{key}")

    collections = data.get("collections")
    if not isinstance(collections, dict) or set(collections) != COLLECTION_KEYS:
        fail("RIG007", "collections must contain exactly the six collection paths")
    for key, value in collections.items():
        if not isinstance(value, str):
            fail("RIG007", f"collections.{key} must be a string")
        validate_path(value, f"collections.{key}")
    values = list(collections.values())
    if len(values) != len(set(values)):
        fail("RIG007", "collection paths must be unique")

    aliases = data.get("legacyArtifactNames", [])
    if not isinstance(aliases, list) or len(aliases) > 20:
        fail("RIG008", "legacyArtifactNames must be an array with at most 20 entries")
    for index, alias in enumerate(aliases):
        if not isinstance(alias, str):
            fail("RIG008", f"legacyArtifactNames[{index}] must be a string")
        validate_path(alias, f"legacyArtifactNames[{index}]")
    if len(aliases) != len(set(aliases)):
        fail("RIG008", "legacyArtifactNames must be unique")

    missing: list[str] = []
    for key in ("requirements-index", "intake-order"):
        if not (repo / roles[key]).is_file():
            missing.append(roles[key])
    for key in ("requirements-intake", "requirements-baseline"):
        if not (repo / roles[key]).is_dir():
            missing.append(roles[key])
    if not (repo / collections["seriesManifest"]).is_file():
        missing.append(collections["seriesManifest"])

    outcome = "Aligned" if not missing else "MigrationRequired"
    return {
        "schemaVersion": "2.0",
        "outcome": outcome,
        "documentationLanguage": language,
        "profile": profile,
        "resolvedNaming": resolved,
        "roles": roles,
        "collections": collections,
        "legacyArtifactNames": aliases,
        "missingPaths": sorted(set(missing)),
        "nextAction": "N/A" if outcome == "Aligned" else "$speckit-intake-update",
    }


def validate_journal(data: dict) -> dict:
    if data.get("schemaVersion") != "2.0" or data.get("documentType") != "IntakeGovernanceMigrationJournal":
        fail("RIG009", "migration journal schema or document type is invalid")
    state = required_text(data, "state", "RIG009")
    if state not in {"Proposed", "Authorized", "Applying", "Completed", "RolledBack", "NeedsRepair"}:
        fail("RIG009", "migration journal state is invalid")
    authority = required_text(data, "authorityEvidence", "RIG010")
    if state != "Proposed" and authority == "N/A":
        fail("RIG010", "a mutating journal state requires authority evidence")
    for key in ("beforeSha256", "afterSha256"):
        value = required_text(data, key, "RIG011")
        if value != "N/A" and not re.fullmatch(r"[0-9a-f]{64}", value):
            fail("RIG011", f"{key} must be N/A or lowercase SHA-256")
    if state == "Completed" and data.get("afterSha256") == "N/A":
        fail("RIG011", "Completed requires afterSha256")
    if state == "NeedsRepair" and not data.get("repairBoundary"):
        fail("RIG012", "NeedsRepair requires repairBoundary")
    return {"schemaVersion": "2.0", "outcome": state, "nextAction": "N/A"}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--config")
    parser.add_argument("--journal")
    parser.add_argument("--repo", default=".")
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args()
    if bool(args.config) == bool(args.journal):
        print("ERROR [RIG001]: exactly one of --config or --journal is required", file=sys.stderr)
        return 2
    try:
        path = Path(args.config or args.journal)
        data = load_json(path)
        result = validate_config(data, Path(args.repo).resolve()) if args.config else validate_journal(data)
    except ContractError as exc:
        result = {"outcome": exc.outcome, "errorClass": exc.code, "message": str(exc)}
        if args.json:
            print(json.dumps(result, ensure_ascii=False, sort_keys=True))
        else:
            print(f"ERROR [{exc.code}] {exc.outcome}: {exc}", file=sys.stderr)
        return 1 if exc.outcome in {"MigrationRequired", "NeedsClarification"} else 2
    if args.json:
        print(json.dumps(result, ensure_ascii=False, sort_keys=True))
    else:
        print(f"PASS: requirements intake governance is {result['outcome']}")
    return 0 if result["outcome"] == "Aligned" or args.journal else 1


if __name__ == "__main__":
    raise SystemExit(main())
