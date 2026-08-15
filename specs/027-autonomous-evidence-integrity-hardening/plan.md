# Implementation Plan: Autonomous Evidence Integrity Hardening

## Summary

Build an unreleased `autonomous-run-governance` v0.4.0 candidate in the
canonical scaffold and publication copy. Implement test-first delivery-set,
phase-result, and lifecycle-evidence contracts, preserve historical reading and
existing commands, validate the full preset composition, and deliver only the
candidate through a Home Baseline feature PR.

## Technical Context

- Primary implementation: PowerShell 7 plus Bash wrappers and existing Python
  validation cores; all are already repository-supported.
- Product roots:
  `specs/spec-kit-presets/autonomous-run-governance/` and
  `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/`.
- Testing: deterministic Bash/PowerShell fixtures, PSScriptAnalyzer,
  homogeneity, secret scan, temporary Git repositories, preset composition,
  and Exact-Head provider evidence.
- Distribution: `sourceOnly`; no Home Runtime sync, public preset PR, tag,
  release, ZIP, catalog, or fleet propagation in Feature 027.

## Constitution Check

- Fail-closed security, strict path handling, no implicit authority: Pass.
- Cross-platform Bash/PowerShell parity: Required.
- DE-first/EN-second, CEFR B2, text-first and WCAG 2.2 AA: Required.
- Agent parity: Required; existing five commands only.
- MSL: PowerShell, Python, and documentation are existing accepted tooling;
  Bash is repository-governed script infrastructure with strict-mode rules.
- Documentation Impact: `UpdateRequired`, defined in `spec.md`.
- Release/supply-chain evidence: deferred to G2B; Feature 027 is unreleased.

## Architecture and Slices

### Slice 1: Intended Delivery Set

Add a portable contract with repository root, explicit intended-path input,
stable path classifications, and a read-only result. Bash and PowerShell
entrypoints call equivalent validation logic. A temporary-index or per-path
comparison validates tracked and named untracked content without staging.

### Slice 2: Semantic Phase Result

Add a schema/template and result validator. Extend the routed-phase wrapper to
persist `NeedsRevalidation` before launch and to mark completion only after the
result schema, phase identity, outcome, task totals, gates, payload hash, and
document hash pass. Existing safe results are accepted during resume; absent or
uncertain evidence is not repeated blindly.

### Slice 3: Lifecycle Gate Evidence

Upgrade gate evidence to schema 2.0 with separate `PreMerge` and `PostMerge`
snapshots. Preserve schema 1.0 only under an explicit historical flag.
Pre-merge validates current gates but cannot claim merge. Post-merge validates
the accepted pre-merge normalized hash and actual merge commit and contains no
new product paths.

### Slice 4: Candidate Parity and Documentation

Update both preset trees, metadata version, templates, README/manuals, runbook,
checklist, field-validation summary, and agent addendum. Keep commands stable.
Run all existing and new regression suites and verify byte parity.

## File Plan

- Add delivery-set validator and tests under `scripts/` and `tests/`.
- Add phase-result schema/template and test fixture; modify the routed-phase
  PowerShell core and its Bash wrapper documentation.
- Replace gate-evidence template with schema 2.0 and extend both validators.
- Update preset metadata inventory for newly provided templates/scripts.
- Synchronize every changed file to the publication copy mechanically.
- Add feature-local evidence, gate requirements, quickstart, contract,
  research, data model, checklist, tasks, and retrospective.

## Validation Strategy

1. Write failing fixtures for each reproduced defect.
2. Implement the smallest provider-neutral behavior to make each fixture pass.
3. Run Bash and PowerShell parity for every positive and negative case.
4. Run existing model-routing and autonomous state suites.
5. Validate PSScriptAnalyzer, Bash syntax, strict UTF-8, LF/CRLF/BOM, secrets,
   homogeneity, preset metadata, command/skill uniqueness, and all installed
   presets in a temporary project.
6. Before commit, validate the explicit delivery set including intended
   untracked files.
7. Before merge, generate temporary schema-2.0 `PreMerge` exact-head evidence.

## Delivery and Closeout

Commit and push Feature 027, open a non-empty PR, converge all technical checks
and actionable review threads, and use the current narrow bypass only if Human
Approval is the sole remaining rule. Merge with a merge commit, delete the
feature branch, synchronize `main`, and record the candidate as merged but
unreleased. Do not start G2B.
