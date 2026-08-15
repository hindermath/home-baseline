# Implementation Plan: Feature 028

## Summary

Run an independent evidence-only field validation of the merged v0.4.0
candidate, publish it only after all gates pass, dynamically update applicable
consumers, submit the serial community update, close the originating workitem,
and restore the pre-G2 Series topology without starting Position 7.

## Technical Context

- Primary tooling: existing PowerShell 7, Bash wrappers, Python validator cores,
  Git, GitHub CLI, Spec Kit 0.12.11, and current registry scripts.
- Product source: canonical and publication-copy autonomous preset trees.
- Public package repository: dynamically resolved registered preset checkout.
- Testing: candidate regression suites, controlled temporary Git fixtures,
  PSScriptAnalyzer, Homogeneity, Secret Scan, full preset composition, ZIP
  installation, consumer exact-head CI, and Series validators.
- Delivery: `MergeAndSync`; narrow bypass only for Human Approval after all
  technical gates and actionable threads converge.

## Constitution Check

- Fail-closed integrity and authority: required and satisfied by design.
- Cross-platform Bash/PowerShell parity: mandatory.
- DE-first/EN-second, CEFR B2, explained terms, text-first, WCAG 2.2 AA: required.
- MSL: PowerShell and Python are accepted; Bash remains governed strict-mode
  infrastructure. No new language or dependency is introduced.
- Supply chain: release checksum, source/tag binding, ZIP smoke, dependency and
  secret checks apply. SBOM/VEX decisions are documented for script-only source.
- Agent parity: all generated command/skill surfaces checked together.
- Documentation Impact: `UpdateRequired` plus `GeneratedUpdate`.

## Delivery Slices

### Slice 1 - Independent Field Proof

Create evidence and gate declarations first. Re-run candidate regressions, then
perform controlled delivery-set, semantic phase, Resume, and lifecycle field
sequences in isolated temporary repositories.

### Slice 2 - Package and Release

Confirm canonical/publication parity, update field-validation evidence without
changing candidate behavior, deliver the public preset repository through a
normal PR, publish tag/release v0.4.0, and verify the immutable ZIP/checksum.

### Slice 3 - Dynamic Consumer Rollout

Inventory registered repositories and profiles, separate collection and
inapplicable targets, update only applicable consumers through non-empty PRs,
and converge exact-head checks/reviews before merge and sync.

### Slice 4 - Community and Governance Closeout

Submit one official serial catalog update, mark the workitem Implemented, merge
the Home Baseline feature, validate causal lifecycle evidence, archive G2A/G2B,
restore 32/3/36 with Position 7 eligible, and complete an evidence-only causal
closeout if post-merge facts cannot truthfully exist on the feature head.

## Validation Strategy

1. Validate accepted intake/review, Series, model routing, and independent state.
2. Re-run all G2A suites and controlled negative/positive field sequences.
3. Validate cross-shell parity, syntax, static analysis, secrets, homogeneity,
   agent parity, and exact intended delivery sets.
4. Validate public-repository PR, tag, release, ZIP checksum, and fresh install.
5. Validate every applicable consumer at exact head and record exclusions.
6. Validate temporary PreMerge evidence before each merge and causal PostMerge
   evidence afterward.
7. Validate final workitem and restored Series; never start Position 7.

## Plan Review

No Critical, High, or unresolved Medium issue remains. Release, bypass,
consumer, external-catalog, and next-feature boundaries are explicit.
