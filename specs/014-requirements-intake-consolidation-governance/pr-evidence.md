# Feature 014 Evidence

## Authority and Scope

- Delivery mode: `MergeAndSync`.
- Admin bypass: only after green technical gates or a proven provider-zero-step
  rejection, zero actionable threads, and Human Approval as the sole open rule.
- Product code, APIs, dependencies, and requirements meaning remained out of
  scope.
- No follow-up feature or learner Spec-Kit run was started.

## Accepted Inputs

| Artifact | Result |
|---|---|
| Binding intake | Current and hash-bound |
| Authoring receipt | Bash and PowerShell `PASS` |
| Active Series Review | `Ready`, 18 targets, 1 root, 28 dependencies |
| Preset matrix | 11 enabled presets |
| Analyze | 22 requirements and 8 success criteria mapped; no Critical or High finding |

## Package Delivery

| Preset | Release | Publication result | ZIP SHA-256 |
|---|---:|---|---|
| Intake Authoring Governance | `v0.3.0` | PR #4 merged, tag published | `902748540bdb3f6f1b30384107826206f52fb4e5952cba743d22bb9a0cfa526b` |
| Intake Review Governance | `v0.2.0` | PR #4 merged, tag published | `5bca9b395da7a4e25c0cf5ff4686d1bae4a27a4e1fabd5f824a19cd10bc5cdb3` |
| Intake Sequencing Governance | `v0.2.0` | PR #3 merged, tag published | `192731b33a47db10cd70bd369447431ed3f3da9f4505c5a5f4dd36006cf9d24b` |

All three archives passed integrity, installation, resolution, disable/enable,
remove/reinstall, and eleven-preset composition checks. Commands and skills
appear exactly once on each maintained agent surface.

## Field Validation

Seven project shapes were used:

- TuiVision, TinyCalc, and TinyPl0 preserved their existing consolidated
  requirements structures while adopting schema 2.0.
- Home Baseline added the portable role contract and a hash-bound 18-target
  manifest without moving or renaming an intake.
- InventarWorkerService, cc65, and absdd-image-sandbox adopted the role model
  while preserving their flat collections, non-MSL/fork boundary, or sandbox
  evidence respectively.

The six external migration/adoption PRs are merged. TuiVision, TinyCalc,
TinyPl0, InventarWorkerService, cc65, and absdd-image-sandbox passed their
technical gates and had zero actionable review threads. The Level-0 adoption
is part of this Feature-014 head.

## Fleet Delivery

`fleet-delivery-evidence.json` binds all 32 registered Level-1/2 repositories
to their PR head and merge commit:

- 6 migration/adoption PRs;
- 26 version-only PRs;
- 119 provider-rejected workflow runs inspected for the 26 version-only PRs;
- zero executed steps in every rejected job;
- a Billing/Spending annotation in every rejected run;
- zero actionable review threads;
- all local repositories clean and synchronized after merge.

The narrow Admin bypass was used only for the Human Approval rule after either
technical success or the documented provider-zero-step classification.

## Community Submission

Authoring v0.3.0 was submitted as
[`github/spec-kit#3780`](https://github.com/github/spec-kit/issues/3780).
`@mnriem` was addressed once and the predecessor #3720/#3721 was referenced.

The Review v0.2.0 update remains serially deferred until #3780 closes.
Sequencing v0.2.0 remains deferred until the Review update closes. This
preserves the Maintainer-requested one-submission-at-a-time rule. External
catalog processing is not a local completion condition.

## Validation Ledger

| Phase | Command or evidence | Result |
|---|---|---|
| Preflight | Fetch, clean default branch, exact `origin` synchronization | `PASS` |
| Authoring input | Bash and PowerShell receipt validators | `PASS` |
| Review input | Bash and PowerShell review validators | `PASS` |
| Contract | Positive and negative schema-2 fixtures | `PASS` |
| Authoring package | Lifecycle, receipt, config, and migration tests | `PASS` |
| Review package | Review and config tests | `PASS` |
| Sequencing package | Manifest, receipt, field, and config tests | `PASS` |
| Cross-shell | Bash and PowerShell config/journal validation | `PASS` |
| Package quality | Bash syntax, PSScriptAnalyzer, Homogeneity, diff, links, and secrets | `PASS` |
| Composition | Temporary eleven-preset Spec Kit project | `PASS` |
| ZIP | Three exact tag archives and checksums | `PASS` |
| Pilots | Seven project shapes; product and intake meaning preserved | `PASS` |
| Fleet | 32 registered Level-1/2 repositories | `PASS` or proven provider-zero-step |
| Level-0 config | Schema 2.0, 18 targets, one `Eligible` | `PASS` |

## Documentation Impact

Decision: `UpdateRequired`. Owner: Feature 014.

Preset documentation, commands, templates, runbooks, manpages, field summaries,
agent surfaces, profile matrices, the Home requirements index, feature
evidence, and project statistics are updated together. Product documentation
and intake meaning were not changed. The post-merge closeout will archive
Feature 014, restore the six prior roots, and mark Windows maintenance as the
next candidate without starting it.

## Residual Risks and Follow-up

- GitHub Billing/Spending currently prevents hosted jobs from starting in 26
  version-only repositories. Local exact-matrix, `specify check`, diff, secret,
  and statistics checks passed before push; the provider failure was never
  reported as a technical pass.
- Spec Kit generated an extra blank EOF line in two baseline repositories.
  Their feature branches were normalized deterministically. A shared installer
  normalization improvement is a bounded future maintenance follow-up, not a
  reason to expand Feature 014.
- Catalog updates for Review and Sequencing remain externally serialized behind
  #3780.

## Post-Merge Closeout

- Feature PR #136 merged as
  `c9058d3139e5ab24954c3b77acade63576b6bf68`.
- The reviewed feature head `16fa245` passed Homogeneity, PSScriptAnalyzer,
  local Markdown links, and the learning-package matrix on macOS, Ubuntu, and
  Windows.
- The completed intake is archived with the Feature-014 suffix.
- The prior 18-target review is preserved unchanged under its review ID.
- The successor review is `Ready` with 17 targets, six roots, 22 dependencies,
  zero findings, and zero open questions.
- Windows hardening is the only declared `Eligible` candidate. No successor
  run was started.
- The causal closeout normalizes six project-specific assurance edge labels in
  the portable manifest to `AssessmentBaseline`; graph meaning is unchanged.

## Schema-2 Fleet Adoption Closeout

The 26 repositories that had received the preset versions but had not yet
received the professional Schema-2 requirements migration were migrated
separately through non-empty pull requests. The machine-readable ledger is
`fleet-schema2-adoption-evidence.json`.

- 20 existing intake collections remain `Active`.
- Six repositories without active intakes use the strict empty `Idle` state.
- No existing intake text, product file, project name, or historical structure
  changed.
- Bash and PowerShell configuration, series, and migration-journal validators
  passed for every repository.
- `specify check`, `git diff --check`, and Gitleaks current-diff checks passed
  for every repository.
- All 26 remote PRs had zero actionable review threads.
- GitHub Actions rejected all remote jobs before their first step; the approved
  narrow Admin bypass applied only after this provider-zero-step evidence and
  local Exact-Head validation.
- Every PR was merged with a merge commit, its feature branch was removed, and
  every local checkout was returned to a clean exact default branch.

The field run promoted two portable sequencing fixes: v0.2.1 introduced a
strict `Idle` series, and v0.2.2 excluded independently owned nested Git
repositories from the parent index-uniqueness check. The original Feature-014
retrospective remains historically correct for the original run; the later
promotion is recorded separately in `fleet-adoption-retrospective.md`.

The final profile-parity closeout is recorded in
`fleet-v022-profile-evidence.json`. All 32 canonical Level-1/Level-2
repositories now carry the v0.2.2 profile. The six original Schema-2 pilots
were reinstalled at v0.2.2; their real CI found only stale generated statistics,
which were rendered from the exact profile heads before all checks passed. The
other 26 repositories retained their documented provider-zero-step boundary.

The final one-command maintenance check reports no sequencing-profile or
installed-profile drift. It still reports pre-existing shared agent-template
drift in `absdd-image-sandbox`, `TinyCalc`, `TinyPl0`, and `TuiVision`. That
separate propagation concern does not change the Schema-2 contract and remains
outside this closeout rather than being silently bundled into it.
