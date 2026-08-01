# Implementation Plan: Documentation Information Architecture Audit

**Branch:** `020-documentation-architecture-audit` | **Date:** 2026-08-01  
**Spec:** `specs/020-documentation-architecture-audit/spec.md`  
**Input:** `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md`

## Summary

Feature 020 performs the serialized D4 read-only audit of all Git-tracked
Level-0 documentation. A feature-local Python standard-library collector and
validator derive the inventory from the Git index, bind every unit to one
artifact class and decision, validate four reader paths, compare the delivered
maintenance contracts from Features 015 through 019, and model the
`homeRuntime`/`sourceOnly`/`machineLocal` boundary. Confirmed findings are
deduplicated and handed to D5, D6, or D7; the audit changes none of the assessed
documentation.

## Technical Context

**Language/Version:** Python 3 standard library for deterministic audit proof;
Markdown and JSON for feature evidence  
**Primary Dependencies:** Git CLI and repository-native validators; no package
dependency  
**Storage:** Feature-local JSON ledgers and Markdown report  
**Testing:** Python `unittest`, malformed-ledger fixtures, Bash/PowerShell
governance validators, Homogeneity, link checks, PSScriptAnalyzer, secret scan  
**Target Platform:** Level-0 delivery on macOS with exact-head macOS, Ubuntu,
and Windows provider evidence  
**Project Type:** Read-only documentation-governance audit  
**Performance Goals:** Linear Git inventory; deterministic ordering; one clear
terminal summary  
**Constraints:** No assessed documentation, runtime, script, workflow, preset,
or fleet mutation; no private absolute paths; exact-one class and decision  
**Scale/Scope:** Current Git index, approximately 2,400 text/document evidence
surfaces, four reader paths, three source/runtime classes, and the Feature
015-019 maintenance contract family

## Constitution Check

*GATE: passed before research and rechecked after design.*

- **MSL and secure coding:** Python is memory-safe. The validator accepts only
  repository-relative Git paths, parses structured JSON, performs no dynamic
  execution, and fails closed on malformed or incomplete evidence.
- **Security:** NIST SSDF and CWE Top 25 apply to evidence hygiene and path
  validation. ASVS, SBOM, VEX, SLSA, OpenSSF Scorecard, AI-SBOM, CRA, NIS2,
  EU AI Act, and DORA are `N/A` because no released software, dependency,
  web/API boundary, supply-chain artifact, or AI product component changes.
- **Architecture and iSAQB:** The audit records the existing workspace boundary
  but changes no runtime architecture. STRIDE/CIA/CAPEC, S-ADR, arc42 runtime
  changes, Zero Trust, SAMM, BSI C3A, and BSI C5 are `N/A` unless the audit
  uncovers a separately owned documentation gap.
- **A11Y and learners:** Reports are text-first, use German first and English
  second where user-facing, target CEFR B2, explain terms on first use, and do
  not rely on diagrams, color, or prior Spec Kit experience.
- **Cross-platform:** Feature-local Python proof is platform-neutral. Existing
  Bash and PowerShell product tools remain unchanged; governance JSON is
  validated through both installed variants.
- **Agent parity:** All maintained agent surfaces are reviewed as audit units
  but remain unchanged in Feature 020. A confirmed finding receives a successor
  handoff.
- **Intake governance:** Current Authoring, Review, and Sequencing hashes are
  accepted inputs. Autonomous Run controls state and delivery. Parallel
  Autonomous is `N/A` because the audit serializes shared ledgers.
- **Documentation Impact:** `NoUpdateRequired` for active documentation during
  implementation; only feature evidence and generated audit output change.
- **Statistics:** The source ledger is updated after the accepted audit, then
  rendered from a clean committed state.

## Project Structure

```text
specs/020-documentation-architecture-audit/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/documentation-architecture-audit.md
├── checklists/
│   ├── requirements.md
│   ├── plan-review.md
│   └── audit-governance.md
├── tools/
│   ├── collect_documentation_architecture.py
│   └── validate_documentation_architecture.py
├── tests/test_documentation_architecture.py
├── ../../scripts/tests/test_feature_020_documentation_architecture.py
├── documentation-inventory.json
├── audit-decisions.json
├── documentation-architecture-audit.json
├── documentation-audit-report.md
└── tasks.md
```

**Structure Decision:** Executable proof and evidence remain feature-local.
The Git index, Home Sync manifest, existing Feature evidence, and active
documentation remain canonical inputs and are never rewritten by the audit.

## Design and Execution

1. Freeze the exact Level-0 commit, D4 intake/review hashes, Series identity,
   and Git-tracked documentation inventory.
2. Write malformed-ledger tests before accepting the validator. Cover missing
   and duplicate paths, invalid classes/decisions, incomplete reader paths,
   incomplete source/runtime classification, contract omissions, invalid
   findings, private paths, and stale inventory hashes.
3. Prove one vertical slice containing the root README, Home Sync manifest,
   maintenance manpage, one Feature contract, one generated artifact, and one
   archived intake.
4. Collect the full deterministic inventory and assign path-derived default
   classes. Record semantic decisions separately so the collector never guesses
   ownership, language split, or remediation.
5. Review all documentation families, four reader paths, maintenance contracts,
   and source/runtime/local-state records. Add findings only for reproducible
   current gaps.
6. Validate complete cardinality, hashes, decisions, handoffs, privacy,
   generated boundaries, and cross-matrix references.
7. Deliver one Level-0 feature PR. Archive and advance Series state only in a
   causal closeout after merge facts exist.

## Validation Strategy

- Positive validation of every Git-tracked documentation unit and all required
  matrix rows.
- Negative fixtures for missing/duplicate inventory, invalid enumeration,
  evidence-free decisions, incomplete reader paths, missing Feature contracts,
  `Gap` without finding, finding without owner/handoff, private absolute paths,
  stale Git hashes, and LF/CRLF/BOM normalization.
- Current D4 Authoring/Review and Series evidence in Bash and PowerShell.
- `python3 -m unittest discover -s specs/020-documentation-architecture-audit/tests -p 'test_*.py'`.
- Accepted-ledger validation with the feature-local validator.
- A test-only discovery bridge under `scripts/tests/` runs the Feature-020
  suite and accepted-ledger validation in the existing macOS/Ubuntu/Windows
  maintenance-regression jobs; it exposes no operational command.
- `git diff --check`, `specify check`, Homogeneity, local Markdown links,
  PSScriptAnalyzer, secret scanning, and statistics rendering.
- Exact-head provider checks for macOS, Ubuntu, and Windows before merge.
- DocFX/browser A11Y is not triggered because active docs, navigation, and HTML
  are not changed; re-evaluate if scope drifts.

## Post-Design Constitution Check

Passed. The design introduces no product behavior, public API, dependency,
architecture, deployment, cloud service, learner runtime, or fleet write. The
feature-local validator is deterministic, memory-safe, and bounded to audit
evidence. Every governance `N/A` includes a re-evaluation trigger in the audit
checklist and gate requirements.

## Complexity Tracking

No Constitution deviation requires justification.
