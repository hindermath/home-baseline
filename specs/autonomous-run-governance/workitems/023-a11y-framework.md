# Preset Follow-up: 023 A11Y Framework

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `023-a11y-framework` |
| Feature PR | `hindermath/TuiVision#56` |
| Feature merge | `7f90fdab2fee1141104ac46d39e0d770aa1f7155` |
| Evidence closeout PR | `hindermath/TuiVision#57` |
| Closeout merge | `0437e3e2871959a81e5d895152163a838b5eab6b` |
| Retrospective PR/final source main | `hindermath/TuiVision#58`; `47d64599f1e65f40aa1c830f51f7b97d85235637` |
| Delivery mode | `MergeAndSync` |
| Required checks | Passed on feature, closeout, and retrospective PRs |
| Review state | Claude passed without findings; GraphQL reported zero actionable threads; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass remained limited to the sole human-approval rule after green checks and zero actionable threads |
| Field-input snapshot | `specs/autonomous-run-governance/field-inputs/023/` |

## Workitem AR-023-01: One Validation Token per Invocation

| Field | Value |
|---|---|
| Observation | One shell step ran two explicit `dotnet test` invocations after one manual build-counter increment. Both tests passed, but the version evidence no longer represented the repository contract. |
| Artifact kind | Runbook, command/skill, task template, evidence template, agent addendum, readiness checklist |
| TuiVision-specific exclusions | Do not prescribe .NET, `Directory.Build.props`, numbered branches, semantic versions, or a manual build counter. |
| Generic target rule | When a repository requires a mutable token, version, lease, or counter before a validation command, one token transition authorizes exactly one explicit invocation. Batch cases inside that invocation; do not chain multiple invocations behind one transition. |
| Occurrence count | One direct field defect; promoted immediately because it is an evidence-integrity error rather than an efficiency preference. |
| Confidence | High for one-to-one authorization; medium for repositories without mutable validation tokens, where the rule is `N/A`. |
| Permission risk | Medium. A token transition may write shared metadata and must remain within current repository authority. |
| Reproducible test | Configure a synthetic mutable counter, attempt two validation invocations after one increment, and require readiness to reject the second invocation until another increment occurs. |
| Decision | `Promote` |

## Workitem AR-023-02: Validation Requires Exit and Error-channel Integrity

| Field | Value |
|---|---|
| Observation | The PowerShell homogeneity wrapper emitted a missing-function ErrorRecord and the Bash wrapper emitted `command not found`, yet both continued to exit 0. The PowerShell call also defaulted to HOME because no repository root was passed. |
| Artifact kind | Runbook, command/skill, task/evidence template, agent addendum, readiness checklist, validation-script contract |
| TuiVision-specific exclusions | Do not prescribe homogeneity checks, HOME layout, PowerShell function names, TuiVision scripts, or one shell's output wording. |
| Generic target rule | Pass the intended repository root explicitly. Accept a validation helper only when its exit status and structured/error channel are both clean. A nominal success code cannot override an ErrorRecord, command-not-found message, fatal signature, or missing required output. |
| Occurrence count | One autonomous run exposed equivalent false-success behavior in Bash and PowerShell. Correctness and evidence defects may be promoted immediately. |
| Confidence | High. Both failure paths reproduced deterministically and now return exit code 2. |
| Permission risk | Low for detection; medium if a helper defaults to scanning or writing outside the delegated repository. Explicit root is therefore mandatory. |
| Reproducible test | Remove one required helper in synthetic Bash and PowerShell fixtures. Require nonzero exit, fatal diagnostic, no success record, and no write outside the explicit temporary repository root. |
| Decision | `Promote` |

## Workitem AR-023-03: Wrapper and Helper Libraries Deploy Atomically

| Field | Value |
|---|---|
| Observation | TuiVision contained both homogeneity wrappers but not their `scripts/lib/hg-*` dependencies. The wrappers now fail closed; adding the complete Home-Baseline helper set made both proceed past dependency preflight. |
| Artifact kind | Script packaging, install contract, cross-platform checklist, negative fixture |
| TuiVision-specific exclusions | Do not move the homogeneity scanner into the autonomous preset. It belongs to Home-Baseline repository tooling. |
| Generic target rule | A packaged command and its required helper libraries form one installable unit. Installation, reinstallation, disable, and removal tests must not leave an executable wrapper that can report false success with missing helpers. |
| Occurrence count | One deployment defect affecting both shell variants. |
| Confidence | High for atomic deployment; medium for whether the autonomous preset needs any script at v0.1.0. |
| Permission risk | Medium because installers alter repository-owned command surfaces. Dry-run and temporary-project tests are required. |
| Reproducible test | Install into a temporary project, verify all declared helpers, remove one helper and expect fail-closed parity, then reinstall and verify normal execution. |
| Decision | `Promote` as packaging governance; no autonomous preset script until a separate deterministic need is proven |

## Workitem AR-023-04: Closeout and Duplicate-run Rules Confirmed

| Field | Value |
|---|---|
| Observation | Closeout PR #57 remained one evidence commit without self-reference. Push and pull-request workflow sets were equivalent; the PR-context set was the gate and no run was cancelled. |
| Artifact kind | Field validation of AR-022-01 and AR-022-02 |
| TuiVision-specific exclusions | Do not prescribe GitHub Actions, exact PR files, Claude, Copilot, or admin bypass. |
| Generic target rule | Retain the promoted one-commit closeout and duplicate-run classification rules without granting provider actions. |
| Occurrence count | Confirmed again after Features 021 and 022. |
| Confidence | High. |
| Permission risk | High for remote actions; authority remains an explicit current input. |
| Reproducible test | Keep the existing non-recursive closeout and duplicate-event synthetic cases in package acceptance. |
| Decision | `NoPromotion`; existing promoted rules are sufficient |

## Workitem AR-023-05: Prior Observe-again Items

| Field | Value |
|---|---|
| Observation | Feature 023 used the correctly quoted multi-word coverage argument and its primary app-loop proof marker without a new failure. This is positive operation, not a second independent defect. |
| Artifact kind | Command metadata and proof-readiness observations from AR-022-03/04 |
| TuiVision-specific exclusions | Do not prescribe Coverlet, app loops, view trees, or TuiVision harness APIs. |
| Generic target rule | Preserve argv boundaries in command metadata and keep formal proof classification consistent with semantic evidence. |
| Occurrence count | One earlier failure each; Feature 023 supplied no second independent failure. |
| Confidence | Medium for general guidance, low for new generic automation. |
| Permission risk | Low. |
| Reproducible test | Keep one multi-word argv fixture and one semantic-proof/formal-marker mismatch fixture in package validation. |
| Decision | `ObserveAgain`; include as readiness guidance, not a new script or core API |

## Snapshot Coverage

The 023 snapshot includes the orchestration skill and OpenAI UI metadata,
runbook, retrospective ledger, agent/tasks/evidence templates, synchronized
agent policy, feature and closeout evidence, and both corrected wrapper scripts.
It intentionally does not promote TuiVision A11Y implementation details.

## Package Gate

All six field workitems now exist. Productize the promoted provider-neutral
rules as optional `autonomous-run-governance` v0.1.0. Scripts are included only
if a deterministic autonomous need is demonstrated with Bash/PowerShell parity;
the homogeneity wrappers themselves remain field evidence, not preset payload.
