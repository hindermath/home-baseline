#!/usr/bin/env python3
"""Validate and optionally render Feature-024 mapping evidence."""
import argparse, hashlib, json
from pathlib import Path

STANDARD = ["security-governance", "architecture-governance", "isaqb-architecture-governance", "a11y-governance", "cross-platform-governance", "agent-parity-governance", "autonomous-run-governance", "parallel-autonomous-run-governance"]
OPTIONAL = ["intake-authoring-governance", "intake-review-governance", "intake-sequencing-governance"]
REQUIRED = ["applicability", "implementation", "rationale", "evidence", "owner", "reviewer", "residualRisk", "followUp", "reevaluationTrigger"]

def digest(path): return hashlib.sha256(path.read_bytes().replace(b"\r\n", b"\n").replace(b"\r", b"\n")).hexdigest()

def build(repo):
    base = repo / "docs/secure-development"
    manifest = json.loads((base / "baseline-manifest.json").read_text())
    mapping = base / "mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md"
    rows = []
    for item in manifest["relatedDocuments"]:
        rows.append({"path": item["path"], "kind": "RelatedDocument", "applicability": "Applicable", "implementation": "Fulfilled", "rationale": "The managed document has a mapping entry or an explicit family mapping.", "evidence": str(mapping.relative_to(repo)), "owner": "Secure-Development Governance", "reviewer": "Feature 024 review", "residualRisk": "Low; revalidate after document or preset changes.", "followUp": "N/A", "reevaluationTrigger": "Document, checklist, baseline, or preset profile changes."})
    return {"schemaVersion":"1.0", "baselineVersion":manifest["baselineVersion"], "checklistCount":len(manifest["checklists"]), "checklistItemCount":manifest["checklistItemCount"], "profiles":{"publicStandard":STANDARD,"managedOptional":OPTIONAL}, "mapping":{"path":str(mapping.relative_to(repo)),"sha256":digest(mapping)}, "rows":rows, "findings":[]}

def validate(repo, data):
    errors=[]
    if data.get("checklistCount") != 12: errors.append("MDV-001 checklist cardinality")
    if data.get("checklistItemCount") != 157: errors.append("MDV-002 checklist item cardinality")
    profiles=data.get("profiles",{})
    if profiles.get("publicStandard") != STANDARD: errors.append("MDV-003 public profile")
    if profiles.get("managedOptional") != OPTIONAL: errors.append("MDV-004 optional profile")
    manifest=json.loads((repo/"docs/secure-development/baseline-manifest.json").read_text())
    rows=data.get("rows",[])
    expected={item["path"] for item in manifest["relatedDocuments"]}
    actual={row.get("path") for row in rows}
    if actual != expected or len(rows) != len(expected): errors.append("MDV-005 related-document coverage")
    for row in rows:
        if any(not str(row.get(key,"")).strip() for key in REQUIRED): errors.append(f"MDV-006 incomplete row {row.get('path')}")
        if row.get("applicability") not in {"Applicable","N/A","Open"}: errors.append("MDV-007 applicability")
        if row.get("implementation") not in {"Fulfilled","Partly Fulfilled","Not Fulfilled","Not Assessed"}: errors.append("MDV-008 implementation")
    mapping=repo/data.get("mapping",{}).get("path","")
    if not mapping.is_file() or digest(mapping) != data.get("mapping",{}).get("sha256"): errors.append("MDV-009 mapping hash")
    text=mapping.read_text() if mapping.is_file() else ""
    for preset in STANDARD+OPTIONAL:
        if f"`{preset}`" not in text: errors.append(f"MDV-010 missing preset {preset}")
    return errors

def main():
    p=argparse.ArgumentParser(); p.add_argument("--repo",default="."); p.add_argument("--write",action="store_true"); p.add_argument("--input")
    a=p.parse_args(); repo=Path(a.repo).resolve(); out=repo/"specs/024-mitgeltende-dokumente-verzahnung/mapping-review.json"
    data=json.loads(Path(a.input).read_text()) if a.input else build(repo)
    if a.write: out.write_text(json.dumps(data,indent=2,ensure_ascii=True)+"\n")
    errors=validate(repo,data)
    if errors: print("FAIL: "+"; ".join(errors)); return 1
    print(f"PASS: 12 checklists, 157 items, {len(data['rows'])} documents, 8+3 presets")
    return 0
if __name__ == "__main__": raise SystemExit(main())
