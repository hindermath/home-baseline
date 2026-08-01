# Implementation Plan: Agentic Workspace Efficiency Guide

**Branch**: `022-agentic-workspace-efficiency-guide` | **Date**: 2026-08-01 | **Spec**: [spec.md](spec.md)

## Summary

Deliver one synchronized German/English operating guide for the agentic
workspace and one-command maintenance, route the four existing reader paths to
the relevant sections, and bind every operational claim to current source
truth through a machine-readable source matrix. A feature-local Python
standard-library validator and fixtures prove matrix completeness and drift;
no executable maintenance surface changes.

## Technical Context

- **Primary artifacts**: Markdown documentation and JSON evidence
- **Test-only tooling**: Python 3 standard library
- **Dependencies**: Existing repository tools only; no package changes
- **Storage**: Git-tracked files; no service, database or runtime state
- **Validation**: Python fixtures, Markdown links, Homogeneity,
  PSScriptAnalyzer discovery, A11Y/text review, secret scan, statistics,
  provider and exact-head gates
- **Target platforms described**: macOS, Linux/Ubuntu and Windows
- **Delivery**: `MergeAndSync`
- **Scope**: Level-0 documentation only; D7 remains outside implementation

## Constitution Check

### Required gates

- **Security-first**: Pass. Examples use check or preview paths; private paths,
  credentials, logs and machine-local state are excluded from publishable
  evidence.
- **Inclusion/A11Y**: Applicable. DE first, EN second, CEFR B2, first-use term
  explanations, text-first states and WCAG 2.2 AA review are mandatory.
- **Cross-platform**: Applicable to documented commands and evidence. New or
  changed Bash/PowerShell tools, manpages or cmdlets are `N/A` because no
  operational script changes are permitted.
- **Documentation Impact**: `UpdateRequired`. Audiences are learners, daily
  users, maintainers/AI agents and reviewers. Canonical sources are the paired
  D6 guide and source matrix. Distribution is `sourceOnly`; no Home sync is
  expected.
- **Statistics**: `docs/project-statistics.md` is updated after implementation
  and delivery using the scripting-infrastructure baseline.
- **Agent parity**: Review all five maintained surfaces. Update is
  `NoUpdateRequired` unless implementation discovers a new normative rule.
- **MSL and secure code**: Product-language assessment is `N/A`; the only new
  executable artifact is feature-local test tooling using Python, an allowed
  memory-safe language, with path and input validation.

### Preset applicability

| Preset | Version | Applicability and evidence |
|---|---:|---|
| `security-governance` | 0.6.1 | Applicable to safe commands, secrets, admin, sandbox and provider boundaries; other checkpoints recorded in `pr-evidence.md` |
| `architecture-governance` | 0.5.1 | Applicable to information architecture; runtime/cloud threat checkpoints `N/A` |
| `isaqb-architecture-governance` | 0.2.1 | Applicable to reader-path/source-of-truth design; runtime architecture `N/A` |
| `a11y-governance` | 0.4.2 | Applicable to every changed user-facing document |
| `cross-platform-governance` | 0.2.1 | Applicable to examples and parity evidence; script creation `N/A` |
| `agent-parity-governance` | 0.4.1 | Review required; update conditional on shared-rule change |
| `intake-authoring-governance` | 0.3.0 | Accepted D6 receipt is binding; no authoring operation in product work |
| `intake-review-governance` | 0.2.0 | Accepted D6 review `89bbb2fa-8b91-41b4-a1f6-887436d6ee37` is binding |
| `intake-sequencing-governance` | 0.2.2 | D6 is sole preferred `Eligible` target in the accepted 35/3/42 Series |
| `autonomous-run-governance` | 0.3.3 | Applicable to full `MergeAndSync` orchestration and exact-head evidence |
| `parallel-autonomous-run-governance` | 0.2.4 | `N/A`; this is a serial single-feature run |

### Standards decisions

- NIST SSDF and CWE Top 25: applicable as secure documentation and test-tool
  review checkpoints.
- OWASP ASVS, CAPEC, Zero Trust, S-ADR, arc42 security concepts, SAMM, BSI C3A,
  BSI C5, NIS2, CRA, EU AI Act and DORA: `N/A` because no web/API/auth,
  runtime boundary, cloud service, deployment, product or regulated processing
  changes. Re-evaluate on any such scope change.
- SBOM, VEX, SLSA, OpenSSF Scorecard and AI-SBOM: `N/A` because no dependency,
  distributable software or AI runtime is added. Re-evaluate if dependencies or
  release artifacts change.

Pre-design and post-design Constitution gates pass without exception.

## Project Structure

```text
README.md
README.en.md
docs/
  README.md
  README.en.md
  getting-started.md
  getting-started.en.md
  maintenance/
    README.md
    README.en.md
    agentic-workspace-efficiency-guide.md
    agentic-workspace-efficiency-guide.en.md
    agentic-workspace-efficiency-source-matrix.json
  architecture/
    source-and-home-runtime.md
    source-and-home-runtime.en.md
  troubleshooting/
    README.md
    README.en.md
specs/022-agentic-workspace-efficiency-guide/
  spec.md
  plan.md
  research.md
  data-model.md
  quickstart.md
  contracts/documentation-guide-acceptance.md
  tools/validate_efficiency_guide.py
  tests/test_efficiency_guide.py
  pr-evidence.md
  autonomous-run-state.json
  autonomous-run-gate-requirements.json
  tasks.md
```

**Structure decision**: One paired canonical guide carries detailed operating
content. Existing portals and four reader-path pages contain short orientation
and deep links, avoiding a second monolith or duplicated source truth. The JSON
matrix is evidence, not a runtime configuration.

## Design And Execution

1. Freeze intake, review, Series and predecessor hashes in run state and
   evidence before documentation edits.
2. Build a complete source inventory from the current wrapper help, PowerShell
   help, manpage, generated script reference, reports and Features 018-021.
3. Define the source-matrix contract and first prove one valid and one failing
   reference slice.
4. Write the German guide by progressive disclosure: safe start, routine
   operation, maintainer/agent handoff, troubleshooting/audit.
5. Write the synchronized English partner and reciprocal links.
6. Integrate exact deep links into both root portals and all four existing
   reader-path families.
7. Populate every operational claim in the source matrix with one primary
   current source or one historical boundary.
8. Validate semantic parity, commands, links, A11Y, source truth and no-runtime
   scope.
9. Deliver one non-empty feature PR. Archive D6 and prepare/review D7 only in a
   causal post-merge closeout.

## Validation Strategy

- Positive matrix fixture with all required claim and reader-path classes.
- Negative fixtures for duplicate IDs, missing claims, stale hashes, unknown
  status, missing language partner, absent proof boundary and historical source
  presented as current.
- Run the validator against repository root and delivered matrix.
- Run safe wrapper help and check-only/preview examples only where environment
  isolation prevents target mutation; otherwise validate syntax/source mapping.
- Run the repository's Lychee command locally when available, Homogeneity, PSScriptAnalyzer discovery,
  secret scan, `specify check`, statistics renderer and changed-path scope scan.
- Run the source-matrix test and validator locally again on the exact pushed
  head; run existing provider checks and exact-head gate-evidence validation
  before merge. No workflow is changed to add a feature-specific job.
- No product build/test expansion is triggered because no runtime source is
  changed; existing Maintenance TUI CI remains a regression gate.

## Documentation Impact

`UpdateRequired`. Owner: Level-0 Documentation Maintainer. Affected families:
root/docs portals, getting started, maintenance, source/runtime architecture,
troubleshooting and project statistics. Language strategy: paired DE/EN files.
Navigation: four existing reader paths gain exact guide links. Distribution:
`sourceOnly`; Home sync `false`. Evidence: source matrix, validator, tests,
`pr-evidence.md` and provider gates. Re-evaluate when maintenance options,
status classes, report schema, runtime distribution or reader paths change.

## Complexity Tracking

No Constitution violation. The feature-local validator is the smallest
deterministic mechanism that can prove one-source-per-claim and hash drift;
prose review alone cannot satisfy SC-002 or SC-006.
