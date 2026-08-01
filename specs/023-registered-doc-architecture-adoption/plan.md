# Implementation Plan: Registered Documentation Architecture Adoption

**Branch**: `023-registered-doc-architecture-adoption` | **Date**: 2026-08-01 | **Spec**: [spec.md](spec.md)

## Summary

Inventory the complete current Level-1/2 fleet, evaluate all 17 Feature-022
documentation claims against each target, and record one repository-specific
decision. Deliver a target PR only for a real portable documentation gap. A
feature-local Python validator proves target and decision completeness while
repository-native gates prove any target changes. Runtime, toolchain and
technical propagation scope remain unchanged.

## Technical Context

- **Primary artifacts**: Markdown and JSON evidence
- **Test-only tooling**: Python 3 standard library
- **Dependencies**: Existing repository and provider tools only
- **Storage**: Git-tracked evidence; machine-local preflight reports remain local
- **Validation**: Python fixtures, intake/Series validators, repository-native
  documentation/A11Y/security/homogeneity gates, provider exact-head evidence
- **Target platforms**: Repository-dependent; Feature 023 itself is text-first
  and platform-neutral
- **Project type**: Cross-repository documentation-governance adoption
- **Scale**: Current manifest: 44 active Level-1/2 Git targets plus one collection;
  actual counts remain manifest-derived
- **Delivery**: `MergeAndSync`, serial target writers

## Constitution Check

### Core gates

- **Level-2 environment**: Applicable per target. Each target uses its registry
  row and repository-native runtime/build/docs/A11Y/statistics/agent contract.
- **MSL and secure generation**: No product language is introduced. Python is
  used only for feature-local deterministic tests. Existing non-MSL decisions,
  especially cc65, remain unchanged.
- **Secure architecture**: No trust boundary or runtime architecture changes.
  Least authority, fail-closed preflight, exact-head revalidation and serialized
  writers apply to the delivery process.
- **Security documentation**: Existing repository security files are reviewed
  only when a target documentation change reaches their audience; no default
  security-document update is assumed.
- **Security-first**: No credentials, private paths, logs, machine state or local
  registry content enters publishable evidence.
- **Inclusion/A11Y**: Applicable to all changed user-facing documentation.
  Decisions and dependencies remain text-first; repository language policy,
  CEFR B2 and WCAG 2.2 AA apply.
- **Documentation Impact**: `UpdateRequired` for Feature-023 fleet evidence and
  each adopted target. Other targets record `NoUpdateRequired` with rationale.
- **Statistics**: Update Level-0 statistics after completed feature delivery.
  Target statistics change only when their repository contract requires it.
- **Agent parity**: Review all target-declared maintained surfaces; change them
  only when the shared target rule changes.

### Preset applicability

| Preset | Version | Decision |
|---|---:|---|
| Security Governance | 0.6.1 | Applicable to authority, path, secret and evidence boundaries |
| Architecture Governance | 0.5.1 | Applicable to documentation/source architecture; runtime/cloud changes `N/A` |
| iSAQB Architecture Governance | 0.2.1 | Applicable to source/owner/view decisions; product architecture `N/A` |
| A11Y Governance | 0.4.2 | Applicable to changed user-facing documentation |
| Cross-Platform Governance | 0.2.1 | Applicable per target validation; no new script pair |
| Agent Parity Governance | 0.4.1 | Applicable to target-maintained agent surfaces and fleet evidence |
| Intake Authoring Governance | 0.3.0 | Accepted D7 receipt is binding; no authoring mutation in implementation |
| Intake Review Governance | 0.2.0 | D7 review `2df4f9ec-169b-4089-ba33-9a4a79aaf15b` is binding |
| Intake Sequencing Governance | 0.2.2 | D7 is sole preferred candidate in accepted 34/3/40 Series |
| Autonomous Run Governance | 0.3.3 | Applicable to MergeAndSync, state and exact-head evidence |
| Parallel Autonomous Run Governance | 0.2.4 | `N/A`; shared writers and deliveries are serialized |

### Standards decisions

- **NIST SSDF and CWE Top 25**: Applicable as process and secure test-tool review.
- **OWASP ASVS, CAPEC, STRIDE and Zero Trust**: `N/A`; no web/API/auth or trust
  boundary changes. Re-evaluate if target scope reaches those surfaces.
- **SBOM, VEX, SLSA, OpenSSF Scorecard and AI-SBOM**: `N/A`; no dependency,
  distributable software or AI runtime is introduced. Re-evaluate on such scope.
- **S-ADR, arc42 security concepts, SAMM, BSI C3A and BSI C5**: `N/A` for product
  architecture/cloud assurance. Re-evaluate on architecture or provider change.
- **NIS2, CRA, EU AI Act and DORA**: `N/A`; documentation-only adoption changes
  no regulated product or service. Re-evaluate on runtime/product scope.

Pre-design and post-design Constitution gates pass without exception.

## Project Structure

```text
specs/023-registered-doc-architecture-adoption/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/fleet-adoption-acceptance.md
├── checklists/
├── fleet-adoption-matrix.json
├── tools/validate_fleet_adoption.py
├── tests/test_fleet_adoption.py
├── pr-evidence.md
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── retrospective.md
└── tasks.md
```

Target repositories receive only their repository-specific documentation delta,
if any. Feature evidence remains centralized and does not become part of the
technical propagation package.

## Design And Execution

1. Freeze accepted D7, Series, Feature-022 and fleet-manifest hashes in run state
   and evidence.
2. Complete the check-only Remote Freshness barrier and preserve its run ID and
   classification summary without publishing personal absolute paths or logs.
3. Build one matrix row per active manifest target and inventory its Git state,
   reader paths, canonical documentation, languages, generated/historical
   boundaries and repository-native validators.
4. Prove one clean/aligned vertical slice and validator negative cases before
   broad target repetition.
5. Evaluate all 17 Feature-022 claims per non-blocked Git target, using local
   terminology and evidence.
6. Route each target to `Adopted`, `AlreadyAligned`, `NotApplicable`, or
   `Blocked`; never create a branch for the last three outcomes.
7. For each `Adopted` target, serialize edit, validation, commit, push, PR,
   exact-head review, merge and local synchronization.
8. Validate matrix completeness, no-product scope, unchanged propagation target
   set, Level-0 feature evidence, statistics and provider gates.
9. Merge Feature 023, archive D7 and update the active Series only through a
   causal evidence closeout when post-merge facts require it.

## Validation Strategy

- Positive matrix fixture with one Git target of each decision plus one
  collection target.
- Negative fixtures for missing/duplicate targets, invalid decisions,
  incomplete claim coverage, adopted-without-PR, blocked-with-change,
  aligned-with-PR, private path, missing Documentation Impact, stale head and
  propagation-set drift.
- Run intake authoring, review and sequencing validators in Bash and PowerShell.
- Run the feature matrix test and production validator.
- For target changes, run repository-native gates and record exact commands,
  runner/platform and exact head.
- Run Level-0 `git diff --check`, Homogeneity, Documentation Impact,
  PSScriptAnalyzer discovery, secret scan, `specify check`, statistics renderer
  and exact-head autonomous gate validator.
- Confirm no executable, package, dependency, workflow, toolchain or propagation
  manifest path changed.

## Documentation Impact

`UpdateRequired`. Source: Feature-023 matrix, validated against the current
manifest and D6 claim matrix. Owner: Level-0 Documentation Maintainer. Audiences:
repository users, learners, maintainers/agents and reviewers. Reader paths:
repository-specific. Navigation: only when a target finding requires it. Class:
fleet governance evidence plus scoped target documentation. Language:
repository policy, DE-first/EN-second where required. Distribution:
`sourceOnly`; Home sync `false` unless a target's own contract proves otherwise.
Evidence: matrix, validator, tests, target PRs, feature PR and provider gates.
Re-evaluate when the fleet manifest, D6 claims or target documentation
architecture changes.

## Complexity Tracking

No Constitution violation. A centralized matrix avoids duplicating campaign
metadata in every repository, while independent target PRs preserve ownership.
