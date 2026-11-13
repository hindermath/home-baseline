#!/usr/bin/env python3
"""Validate and optionally render Feature-024 mapping evidence."""
import argparse
import hashlib
import json
import os
import stat
import tempfile
from pathlib import Path

STANDARD = ["security-governance", "architecture-governance", "isaqb-architecture-governance", "a11y-governance", "cross-platform-governance", "agent-parity-governance", "autonomous-run-governance", "parallel-autonomous-run-governance"]
OPTIONAL = ["intake-authoring-governance", "intake-review-governance", "intake-sequencing-governance"]
REQUIRED = ["kind", "applicability", "implementation", "rationale", "evidence", "owner", "reviewer", "residualRisk", "followUp", "reevaluationTrigger"]
MAPPING_PATH = "docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md"
MANIFEST_PATH = "docs/secure-development/baseline-manifest.json"
REVIEW_PATH = "specs/024-mitgeltende-dokumente-verzahnung/mapping-review.json"
CANONICAL_REPOSITORY = Path(__file__).resolve().parents[3]


class MappingSecurityError(RuntimeError):
    """Raised when a canonical Feature-024 path leaves its repository boundary."""


def require_canonical_repository(requested):
    if Path(requested).resolve() != CANONICAL_REPOSITORY:
        raise MappingSecurityError(
            "Feature-024 validation is restricted to its canonical repository"
        )


def repository_file(repo, relative):
    root = repo.resolve()
    lexical = root / relative
    try:
        resolved = lexical.resolve(strict=True)
        resolved.relative_to(root)
    except (FileNotFoundError, ValueError) as exc:
        raise MappingSecurityError(f"unsafe repository file: {relative}") from exc
    if lexical.is_symlink() or not resolved.is_file():
        raise MappingSecurityError(f"repository file is not a regular canonical file: {relative}")
    return resolved


def write_review(repo, data):
    root = repo.resolve()
    relative = Path(REVIEW_PATH)
    parent = (root / relative.parent).resolve(strict=True)
    try:
        parent.relative_to(root)
    except ValueError as exc:
        raise MappingSecurityError("review directory escapes repository boundary") from exc
    if not parent.is_dir():
        raise MappingSecurityError("review directory is not a directory")
    target = parent / relative.name
    try:
        information = target.lstat()
        target_mode = (
            stat.S_IMODE(information.st_mode)
            if stat.S_ISREG(information.st_mode) and not target.is_symlink()
            else 0o644
        )
    except FileNotFoundError:
        target_mode = 0o644
    descriptor, temporary_name = tempfile.mkstemp(prefix=".mapping-review.", dir=parent)
    try:
        if hasattr(os, "fchmod"):
            os.fchmod(descriptor, target_mode)
        with os.fdopen(descriptor, "w", encoding="utf-8", newline="\n") as stream:
            json.dump(data, stream, indent=2, ensure_ascii=True)
            stream.write("\n")
        os.replace(temporary_name, target)
    except BaseException:
        try:
            os.unlink(temporary_name)
        except FileNotFoundError:
            pass
        raise

def digest(path):
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    normalized = raw.replace(b"\r\n", b"\n").replace(b"\r", b"\n")
    return hashlib.sha256(normalized).hexdigest()

def build(repo):
    manifest = json.loads(repository_file(repo, MANIFEST_PATH).read_text(encoding="utf-8-sig"))
    mapping = repository_file(repo, MAPPING_PATH)
    rows = []
    for item in manifest["relatedDocuments"]:
        rows.append({"path": item["path"], "kind": "RelatedDocument", "applicability": "Applicable", "implementation": "Fulfilled", "rationale": "The managed document has a mapping entry or an explicit family mapping.", "evidence": mapping.relative_to(repo).as_posix(), "owner": "Secure-Development Governance", "reviewer": "Feature 024 review", "residualRisk": "Low; revalidate after document or preset changes.", "followUp": "N/A", "reevaluationTrigger": "Document, checklist, baseline, or preset profile changes."})
    return {"schemaVersion":"1.0", "baselineVersion":manifest["baselineVersion"], "checklistCount":len(manifest["checklists"]), "checklistItemCount":manifest["checklistItemCount"], "profiles":{"publicStandard":STANDARD,"managedOptional":OPTIONAL}, "mapping":{"path":MAPPING_PATH,"sha256":digest(mapping)}, "rows":rows, "findings":[]}

def validate(repo, data):
    errors=[]
    if data.get("checklistCount") != 12: errors.append("MDV-001 checklist cardinality")
    if data.get("checklistItemCount") != 157: errors.append("MDV-002 checklist item cardinality")
    profiles=data.get("profiles",{})
    if profiles.get("publicStandard") != STANDARD: errors.append("MDV-003 public profile")
    if profiles.get("managedOptional") != OPTIONAL: errors.append("MDV-004 optional profile")
    manifest=json.loads(repository_file(repo, MANIFEST_PATH).read_text(encoding="utf-8-sig"))
    rows=data.get("rows",[])
    expected={item["path"] for item in manifest["relatedDocuments"]}
    actual={row.get("path") for row in rows}
    if actual != expected or len(rows) != len(expected): errors.append("MDV-005 related-document coverage")
    for row in rows:
        if any(not str(row.get(key,"")).strip() for key in REQUIRED): errors.append(f"MDV-006 incomplete row {row.get('path')}")
        if row.get("applicability") not in {"Applicable","N/A","Open"}: errors.append("MDV-007 applicability")
        if row.get("implementation") not in {"Fulfilled","Partly Fulfilled","Not Fulfilled","Not Assessed"}: errors.append("MDV-008 implementation")
    mapping_evidence = data.get("mapping", {})
    mapping = repository_file(repo, MAPPING_PATH)
    if mapping_evidence.get("path") != MAPPING_PATH:
        errors.append("MDV-009 canonical mapping path")
    if digest(mapping) != mapping_evidence.get("sha256"):
        errors.append("MDV-009 mapping hash")
    text=mapping.read_text(encoding="utf-8-sig")
    for preset in STANDARD+OPTIONAL:
        if f"`{preset}`" not in text: errors.append(f"MDV-010 missing preset {preset}")
    return errors

def main():
    p=argparse.ArgumentParser(); p.add_argument("--repo",default="."); p.add_argument("--write",action="store_true"); p.add_argument("--input")
    a=p.parse_args()
    try:
        require_canonical_repository(a.repo); repo=CANONICAL_REPOSITORY
        data=json.loads(Path(a.input).read_text(encoding="utf-8-sig")) if a.input else build(repo)
        if a.write: write_review(repo, data)
        errors=validate(repo,data)
    except (MappingSecurityError, OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"FAIL: {exc}")
        return 1
    if errors: print("FAIL: "+"; ".join(errors)); return 1
    print(f"PASS: 12 checklists, 157 items, {len(data['rows'])} documents, 8+3 presets")
    return 0
if __name__ == "__main__": raise SystemExit(main())
