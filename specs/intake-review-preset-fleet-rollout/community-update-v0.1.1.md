# Queued Community Update: Intake Review Governance v0.1.1

Status: `QUEUED - DO NOT SUBMIT BEFORE #3682, #3683, AND #3684 ARE COMPLETE`

This body follows the current `github/spec-kit` preset-submission template. It
references the completed original submission #3604 and must be submitted as a
new issue only after the existing serial catalog queue is empty.

## Proposed title

`[Preset]: Update Intake Review Governance to v0.1.1`

## Preset ID

intake-review-governance

## Preset Name

Intake Review Governance

## Version

0.1.1

## Description

Adds hash-bound review, repair, status, and Series-graph gates for intake files
before interactive, autonomous, or parallel Spec Kit execution.

## Author

Thorsten Hindermann

## Repository URL

https://github.com/hindermath/spec-kit-preset-intake-review-governance

## Download URL

https://github.com/hindermath/spec-kit-preset-intake-review-governance/archive/refs/tags/v0.1.1.zip

## Documentation URL

https://github.com/hindermath/spec-kit-preset-intake-review-governance/blob/v0.1.1/README.md

## License

MIT

## Required Spec Kit Version

>=0.8.3

## Required Extensions (optional)

None

## Templates Provided

- `intake-review-policy-template` - project policy for optional or mandatory
  intake review
- `intake-review-request-template` - Single, Series, or Campaign review request
- `intake-review-result-template` - machine-readable hash-bound outcome
- `intake-review-report-template` - accessible human-readable review report
- `intake-review-checklist-template` - review dimensions and acceptance gates
- `intake-review-runbook-template` - review, repair, status, and consumer gates
- `intake-review-agent-guidance-addendum-template` - agent-neutral guidance
- `intake-review-field-validation-summary` - synthetic and field evidence

## Commands Provided

- `speckit.intake-review` - reviews intake files without changing their content
- `speckit.intake-repair` - repairs explicitly authorized findings
- `speckit.intake-review-status` - inspects result freshness read-only

## Number of Scripts (optional)

2

## Tags

intake, review, governance, quality-gate, autonomous

## Key Features

Hi @mnriem, thank you for accepting the original v0.1.0 submission in #3604
and generated PR #3613.

- Keeps Single and Campaign schema 1.0 compatible while requiring request-bound
  schema 1.1 for Series reviews.
- Binds every Series result to the repository-relative request path and its
  normalized SHA-256 hash.
- Validates review identity, mode, policy, target set, roles, exact target
  order, roots, edge references, duplicate edges, predecessor coverage,
  ordering consistency, and acyclicity.
- Rejects `Ready` and `ReadyWithAcceptedRisks` when request or graph drift is
  present.
- Uses the same stable request-binding, identity, target-set, ordering,
  reference, duplicate, cycle, and root-coverage error classes in Bash and
  PowerShell.
- Preserves read-only review and status behavior. Repair still requires
  explicit file authority, and no command grants feature, commit, push, PR,
  merge, provider, or administrative authority.
- Remains optional and stackable at priority 65. The standard eight-preset
  matrix remains unchanged.
- Passed positive and negative fixtures, LF/CRLF/BOM normalization checks,
  PSScriptAnalyzer, Bash syntax, secret and homogeneity checks, and a complete
  ten-preset Add/List/Info/Resolve/Disable/Enable/Remove/Reinstall lifecycle.
- Generated each of the three commands exactly once for Codex, Claude, Copilot,
  and Antigravity surfaces.
- Was installed in all 33 registered Level-0, Level-1, Level-2, and
  learning-series repositories.
- Re-reviewed all nine active Series sets under schema 1.1: 241 targets, 12
  roots, 229 dependency edges, nine superseding reviews, and zero unresolved
  graph decisions.
- The versioned ZIP SHA-256 is
  `c34d5ef0d5787ee69dcca8a8f38abaf98ffa6e391bd96225b3aa9463227ce8c6`.

Maintainer feedback on the schema boundary and catalog update would be
appreciated. This update remains opt-in and does not change execution
authority.

## Testing Checklist

- [x] Preset installs successfully via `specify preset add`
- [x] Template resolution works correctly after installation
- [x] Documentation is complete and accurate
- [x] Tested on at least one real project

## Submission Requirements

- [x] Valid `preset.yml` manifest included
- [x] Linked README explains this preset and contains the tagged install command
- [x] LICENSE file included
- [x] GitHub release created with version tag
- [x] Preset ID follows naming conventions
