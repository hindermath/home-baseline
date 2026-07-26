# Implementation Plan: Registered Documentation Reality Audit

**Branch:** `011-documentation-reality-audit` | **Date:** 2026-07-26 |
**Spec:** `specs/011-documentation-reality-audit/spec.md`
**Input:** `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md`

## Summary

Feature 011 performs a read-only documentation reality audit of Level 0 and
every repository in the current Level-1/2 fleet manifest. It freezes exact Git
identity, inventories repository-owned documentation families, checks claims
against current evidence, assigns one decision to each review area, and routes
stable `DOC###` findings to D2 or D3. A deterministic Python standard-library
validator checks the audit ledger and negative fixtures; it never mutates an
audited repository.

## Technical Context

**Language/Version:** Python 3 standard library for feature-local validation;
Markdown and JSON for evidence
**Primary Dependencies:** Git CLI and existing repository-native validators;
no new package dependency
**Storage:** Feature-local JSON snapshot and Markdown evidence
**Testing:** Python `unittest`, malformed-ledger fixtures, repository-native
read-only checks, Homogeneity, links, PSScriptAnalyzer, secret scan
**Target Platform:** Level-0 delivery on macOS; evidence covers registered
macOS/Linux/Windows repositories without changing them
**Project Type:** Read-only governance audit
**Performance Goals:** Linear inventory; one terminal summary row per
repository; complete machine ledger for the frozen target set
**Constraints:** No fleet writes, no remediation, no private absolute paths in
publishable evidence, exact-one decision and handoff contracts
**Scale/Scope:** Level 0 plus the current 44-target fleet manifest

## Constitution Check

*GATE: passed before research and rechecked after contracts.*

- **Level-2 environments:** Each target's own Constitution and environment
  metadata are evidence; none is changed.
- **MSL:** Python is memory-safe. Non-MSL target repositories, including
  `cc65`, retain their documented exception and are not reclassified.
- **Secure coding:** The validator parses structured JSON, constrains
  repository-relative identities, performs no dynamic execution, and emits no
  credentials or private paths.
- **Secure architecture:** Product trust boundaries, deployment, runtime, and
  APIs are unchanged. Read-only repository inspection is fail-closed.
- **Security standards:** NIST SSDF and CWE Top 25 apply to evidence hygiene and
  validation. ASVS, SBOM, VEX, SLSA, AI-SBOM, Zero Trust, BSI C3A/C5, NIS2,
  CRA, EU AI Act, and DORA are `N/A` because no product, dependency, release,
  cloud, AI-runtime, or regulated operating boundary changes.
- **Architecture/iSAQB:** Product ADR, S-ADR, arc42, STRIDE, CIA, CAPEC, and
  SAMM changes are `N/A`; the audit may record follow-up applicability but may
  not change architecture.
- **Presets:** The installed governance matrix applies. Intake Authoring,
  Intake Review, Intake Sequencing, and Autonomous Run are applicable;
  Parallel Autonomous is `N/A` for the serialized D1 feature.
- **A11Y and learners:** All reports are text-first, DE-first/EN-second where
  user-facing, CEFR B2, and understandable without prior Spec-Kit experience.
- **Cross-platform:** The feature-local Python validator is provider-neutral
  and has no shell-specific product interface. Native target claims remain
  blocked unless repository evidence proves them.
- **Agent parity:** Shared guidance changes only on a confirmed durable
  finding; otherwise all five maintained surfaces are recorded unchanged.
- **Statistics:** `docs/project-statistics.md` is updated after completion with
  the Level-0 80/100 lines-per-workday references.
- **Security-first:** Only normalized repository-relative paths, public remote
  identities, commits, counts, decisions, and evidence summaries are tracked.

## Project Structure

```text
specs/011-documentation-reality-audit/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/documentation-audit-ledger.md
├── checklists/
│   ├── requirements.md
│   ├── plan-review.md
│   └── audit-governance.md
├── tools/collect_documentation_audit.py
├── tools/validate_documentation_audit.py
├── tests/test_documentation_audit.py
├── registry-snapshot.json
├── documentation-audit.json
└── tasks.md
```

**Structure Decision:** All executable proof remains feature-local and
test-only. The fleet manifest remains the canonical target source. No
repository product or shared maintenance script is modified.

## Design and Execution

1. Freeze the exact Level-0 commit and 44-target manifest into a normalized
   repository snapshot.
2. Create the ledger contract and red negative fixtures before producing the
   accepted audit ledger.
3. Inspect each target read-only for Git identity, documentation families,
   governance surfaces, generated-content contracts, and native proof.
4. Record one repository-level documentation-family decision per target and
   stable findings only where current evidence contradicts a claim.
5. Validate cardinality, decisions, findings, handoffs, privacy boundaries,
   line endings, and target coverage.
6. Reconcile governance, statistics, archive the D1 intake, and deliver one
   Level-0 PR.

## Validation Strategy

- Positive ledger validation for Level 0 plus all 44 frozen targets.
- Negative fixtures for missing/duplicate targets, invalid decisions, positive
  claims without evidence, findings without owner, duplicate findings, missing
  handoffs, and private absolute paths.
- Read-only Git checks for path, remote, branch, exact commit, clean/dirty
  classification, ahead/behind, and reachability.
- Repository-native documentation/build checks are recorded when safely
  available; unavailable native proof is never converted to pass.
- `git diff --check`, all feature tests, Homogeneity, Markdown links,
  PSScriptAnalyzer, secret scan, agent parity, statistics rendering, and
  `specify check`.
- Exact-head provider evidence is generated temporarily before merge.

## Post-Design Constitution Check

Passed. The contracts introduce no product behavior, public API, dependency,
cloud service, release artifact, or fleet mutation. The feature-local validator
is deterministic, memory-safe, provider-neutral, and bounded to accepted
evidence.

## Complexity Tracking

No Constitution deviation requires justification.
