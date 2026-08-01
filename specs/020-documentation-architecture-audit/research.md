# Research: Documentation Information Architecture Audit

## Decision 1: Derive inventory from Git

**Decision:** Freeze the accepted pre-feature Git tree and use
`git ls-tree -r -z --name-only <commit>` to classify its tracked documentation
surfaces with deterministic repository-relative rules.

**Rationale:** Git is the publishable Level-0 boundary and avoids stale manual
counts. The frozen tree prevents newly generated Feature-020 evidence from
changing its own inventory. NUL-delimited input preserves unusual filenames.

**Alternatives considered:** Filesystem traversal would include caches and
machine-local state. A manually curated list would drift and violate DIA-001.

## Decision 2: Separate mechanical classification from semantic decisions

**Decision:** The collector produces path, hash, family, and suggested artifact
class. A reviewed decision source supplies the accepted class, decision,
audience, owner, rationale, and evidence.

**Rationale:** Paths can establish provenance but cannot safely decide whether
content should be split, merged, or restructured.

**Alternatives considered:** Fully automatic semantic classification would
hide assumptions. A fully manual inventory would be expensive and fragile.

## Decision 3: One accepted aggregate with normalized hashes

**Decision:** Produce one accepted audit JSON that binds inventory, decisions,
reader paths, maintenance contracts, source/runtime records, findings, and
governance. Normalize UTF-8 BOM and line endings before SHA-256 comparison.

**Rationale:** Cross-references and cardinalities can be validated atomically,
while source ledgers remain independently reviewable.

**Alternatives considered:** Unrelated spreadsheets or Markdown-only evidence
would make exact-one and stale-hash checks difficult.

## Decision 4: Feature-local Python proof

**Decision:** Use Python 3 standard library under the Feature directory.

**Rationale:** Python is memory-safe, available on provider runners, supports
strict JSON and hashing, and adds no package dependency or product interface.

**Alternatives considered:** New Bash/PowerShell product scripts would violate
the no-maintenance-script boundary. A C# utility would add build and project
surface without additional assurance for this data-only audit.

## Decision 5: Findings drive successors

**Decision:** Create findings only from reproducible current gaps. Assign every
finding exactly once to D5, D6, D7, or `NonRemediation`.

**Rationale:** D5 must not be prefilled with assumed work. D6 and D7 retain
their separate operational-guide and fleet-adoption ownership.

**Alternatives considered:** Starting all successors regardless of findings
would produce speculative scope and potentially empty PRs.

## Decision 6: Validation boundaries

**Decision:** Mechanical validators prove syntax, hashes, enumerations,
cardinality, and referential integrity. Human/agent semantic review proves
meaning, reader suitability, contradiction, and justified language splitting.

**Rationale:** A schema-valid statement can still be misleading or stale.

**Alternatives considered:** Treating deterministic validation as semantic
approval would contradict DIA-016 and the Documentation Impact contract.
