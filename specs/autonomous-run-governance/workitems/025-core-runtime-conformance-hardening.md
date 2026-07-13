# Preset Follow-up: 025 Core Runtime Conformance Hardening

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `025-core-runtime-conformance-hardening` |
| Feature PR | `hindermath/TuiVision#69` |
| Feature head | `ef0887b7fe6fcf9714b922e079efe3bc2ee6355f` |
| Feature merge | `3c0af04d7d462e4c9bfc3770934d9e8810646ed3` |
| Retrospective PR | `hindermath/TuiVision#70` |
| Retrospective head | `ad8c6c5a4bf84f3b797674a2d86bdcbb21985cc1` |
| Retrospective merge | `d0db40a1d1831d6edb867e67186d883cfa72cffb` |
| Gate-scope correction PR | `hindermath/TuiVision#71` |
| Gate-scope correction head | `05ae5ff7a7dd9ec41d7aeb79558a8dc20811c980` |
| Gate-scope correction merge | `015cc6064fa860f337faaac07df946bec1eba95b` |
| Delivery mode | `MergeAndSync` |
| Required checks | All pull-request-context technical checks passed; Pages deployment was the expected pull-request skip |
| Review state | Claude passed with no findings; GraphQL reported zero threads; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the sole Human Approval rule after green technical checks and zero actionable threads |
| Source evidence | `hindermath/TuiVision@d0db40a:docs/spec-kit-autonomous-retrospectives.md` and `hindermath/TuiVision@3c0af04:specs/025-core-runtime-conformance-hardening/pr-evidence.md` |

## Workitem AR-025-01: Exact Delivery Candidate Integrity

| Field | Value |
|---|---|
| Observation | `git diff --check` passed while newly created, untracked Spec-Kit Markdown files still contained trailing whitespace. After the intended files were staged, `git diff --cached --check` rejected the exact commit candidate. |
| Artifact kind | Command, generated skill, runbook, tasks addendum, evidence template, readiness checklist, agent addendum, field-validation summary, and preset follow-up documentation |
| TuiVision-specific exclusions | Do not promote .NET build counters, numbered branch versions, DocFX commands, Turbo Vision source rules, Feature-024 schemas, coverage thresholds, or TuiVision agent-file names. |
| Generic target rule | Validate the exact delivery candidate, not only tracked working-tree changes. Before an authorized commit, stage only intended files, run `git diff --cached --check`, and compare staged paths with repository status so no intended untracked or unstaged file remains outside the candidate. Preserve unrelated changes. In local-only mode, use an equivalent per-file or temporary-index check and restore the prior index state. |
| Occurrence count | One deterministic evidence-integrity failure during Feature 025. |
| Confidence | High. Git omits untracked files from the normal worktree diff by definition, and the staged candidate reproduced the failure immediately. |
| Permission risk | Medium. Staging must never infer commit, push, or merge authority and must not absorb unrelated user changes. Local-only validation must preserve the original index. |
| Reproducible test | In a temporary repository, create a new untracked file with trailing whitespace. Require `git diff --check` to remain clean, then stage only that file and require `git diff --cached --check` to fail. Remove the whitespace, restage, require the cached check to pass, and verify the staged path inventory exactly matches the intended candidate. |
| Decision | `Promote`; this is a correctness and evidence-integrity rule, so one deterministic occurrence is sufficient. |

## Workitem AR-025-02: Acceptance Evidence Must Match Executed Scope

| Field | Value |
|---|---|
| Observation | Feature 025 required macOS, Linux, and Windows/WSL runtime evidence. PR #69 had a green `Repository Tooling (windows-2022)` job, but that workflow executed secret and rename tooling only, not the .NET runtime suite. The missing platform proof was discovered during causal closeout and closed by temporary Actions run 29282485680, which passed all 725 tests and DocFX on `windows-latest`. |
| Artifact kind | Command, generated skill, runbook, tasks addendum, evidence template, readiness checklist, agent addendum, field-validation summary, and preset follow-up documentation |
| TuiVision-specific exclusions | Do not promote TuiVision workflow names, the Windows requirement, .NET commands, test totals, DocFX, or the temporary proof-branch technique as universal defaults. |
| Generic target rule | Before merge, map every acceptance-specific gate to the actual workflow, job, runner or platform, and executed command. A green aggregate status or platform-named job is evidence only for the scope it demonstrably executed. Missing required scope blocks merge and cannot be replaced by a permission bypass. |
| Occurrence count | One deterministic evidence-integrity failure during Feature 025. |
| Confidence | High. Workflow definitions and job logs objectively showed that the initial Windows job did not execute runtime tests, while the supplemental job did. |
| Permission risk | High. Treating unrelated green checks as acceptance evidence can authorize an invalid merge. Admin or ruleset bypass never supplies missing technical proof. |
| Reproducible test | In a temporary project, provide two green jobs with the same platform label: one tooling-only and one executing the required proof command. Require readiness to reject the tooling-only job and accept only the workflow/job/log tuple that executed the required command. |
| Decision | `Promote`; this is a correctness and evidence-integrity rule, so one deterministic occurrence is sufficient. |

## Proposed Portable Surfaces

| Surface | Required change |
|---|---|
| `commands/speckit.autonomous.md` | Add an exact-candidate gate before any authorized commit and a non-mutating equivalent for local-only mode. |
| Generated agent skills | Preserve candidate, unrelated-change, index-restoration, authority, and acceptance-scope mapping boundaries for Codex, Claude, Copilot, and Antigravity-compatible integrations. |
| `templates/autonomous-runbook-template.md` | Distinguish tracked worktree validation from final staged-candidate validation and green check status from executed acceptance scope. |
| `templates/tasks-addendum.md` | Require one dependency-ordered candidate-integrity task before commit/push and one workflow/job/platform/command mapping before merge. |
| `templates/autonomous-run-evidence-template.md` | Record tracked check, cached check, staged inventory, remaining untracked/unstaged boundary, index preservation, and acceptance-gate execution mapping. |
| `templates/autonomous-run-readiness-checklist-template.md` | Reject readiness when intended new files are absent or a required proof lacks a matching executed workflow/job/platform/command. |
| `templates/agent-file-addendum.md` | State that `git diff --check` alone is insufficient for new files and that green names or aggregate status cannot replace unexecuted acceptance proof. |
| `templates/field-validation-summary.md` | Add Feature 025 as the field proof for exact-candidate validation and remote gate-scope integrity. |
| Scripts | No script is required. Existing Git commands provide the deterministic proof without adding Bash/PowerShell parity surface. |

## Package Boundary

This workitem is ready for a later bounded patch release after Home Baseline
applies and validates the portable surfaces together. It does not itself bump
`autonomous-run-governance` beyond v0.1.1, publish a release, comment on an
upstream issue, or grant commit, push, merge, bypass, or publication authority.

The implementation should be exercised in a temporary project for both an
authorized delivery mode and a local-only mode before release. A later public
update may reference `github/spec-kit#3499` only after the package and versioned
ZIP have been validated.

## Promotion Status

| Field | Value |
|---|---|
| Target version | `autonomous-run-governance` v0.1.2 |
| Portable surfaces | Command, runbook, tasks, evidence, readiness, agent guidance, and field-validation summary |
| Script decision | `N/A`; existing Git commands provide deterministic proof without a new cross-platform payload |
| Local package validation | Pass; see `specs/autonomous-run-governance/package-validation-v0.1.2.md` |
| Release-dependent validation | Open until Home-Baseline merge, public tag, ZIP smoke, TuiVision adoption, and issue update exist |
