# Preset Follow-up: 021 Terminal and Charset Hardening

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `021-terminal-charset-hardening` |
| Feature PR | `hindermath/TuiVision#51` |
| Feature merge | `8f50c07760f1622e4ff13ec055e2ad25cd433038` |
| Evidence closeout PR | `hindermath/TuiVision#52` |
| Closeout merge/final source main | `0ed394c4b0e6a96b3eaa5b582d88b9e96401c040` |
| Retrospective PR | `N/A`; no non-empty TuiVision workflow correction was justified |
| Delivery mode | `MergeAndSync` |
| Required checks | Passed on feature and closeout PRs |
| Review state | Claude passed without findings; GraphQL reported zero actionable threads; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the otherwise sole code-owner/human-approval rule after green checks and zero actionable threads |
| Field-input snapshot | `specs/autonomous-run-governance/field-inputs/021/` |

## Workitem AR-021-01: Pre-named Causal Closeout Confirmed

| Field | Value |
|---|---|
| Observation | Feature 021 named `closeout-evidence.md` before implementation delivery, verified the unchanged feature head, merged it, and only then recorded reviewed-head and post-merge facts. The feature head did not receive a self-invalidating evidence commit. |
| Artifact kind | Field validation of AR-020-01; runbook, skill, tasks/evidence-template, agent-policy, and readiness-checklist input |
| TuiVision-specific exclusions | Do not prescribe GitHub, PR numbering, merge commits, Claude/Copilot, DocFX, numbered branches, or the `pr-evidence.md` filename. |
| Generic target rule | Preserve one pre-named causal closeout path for current-head facts that cannot be committed without invalidating themselves and for true post-merge facts. Verify remote gates before merge and keep authority independent from the evidence transport. |
| Occurrence count | Confirmed across Features 018-021; 020 exposed the self-invalidation defect and 021 followed the corrected path. |
| Confidence | High. Revision identity and check execution remained stable through the feature merge. |
| Permission risk | High if closeout is treated as implicit remote authority. `LocalImplementation` remains the safe default; `PublishPR`, `MergeAndSync`, and bypass each require explicit current authorization. |
| Reproducible test | Use a synthetic checked head H. Require the workflow to reject committing “H passed” onto H, verify H before merge, and route the immutable H result plus post-merge facts to one pre-named closeout artifact. |
| Decision | `Promote` |
| Confirms | AR-020-01 |

## Workitem AR-021-02: Closeout Self-reference Retriggered CI

| Field | Value |
|---|---|
| Observation | The first closeout commit created the evidence artifact. A second commit inserted the newly known closeout-PR URL and final task markers, causing a second full check set on the closeout PR even though no acceptance fact changed. |
| Artifact kind | Command/task-shaping efficiency candidate; retrospective metric |
| TuiVision-specific exclusions | Do not prescribe GitHub URL syntax, TuiVision tasks, branch rules, or a specific CI provider. |
| Generic target rule | A closeout artifact should not require its own remote identifier to satisfy acceptance when adding that identifier retriggers the complete gate set. Prefer provider-derived metadata, PR-description evidence, or a single post-creation update only when the identifier is contractually required. |
| Occurrence count | 1 explicit field run. Feature 020 proved feature-head self-invalidation, not this closeout self-reference variant. |
| Confidence | High for the observed redundant gate cycle; medium for the portable remedy. |
| Permission risk | Low, but omitting a required traceability identifier would weaken evidence. The preset must distinguish optional convenience links from required acceptance facts. |
| Reproducible test | Create a synthetic closeout PR whose first commit has all required immutable facts but no self URL. Verify readiness succeeds without a second commit; if policy requires the URL, verify an external/provider-derived evidence channel can carry it without changing the reviewed head. |
| Decision | `ObserveAgain` |

## Workitem AR-021-03: Physical-host Evidence Classification Promoted

| Field | Value |
|---|---|
| Observation | As in Feature 020, the runner was macOS but non-interactive with `TERM=dumb`. Deterministic host classification passed while physical macOS, Linux, and Windows/WSL observations remained explicitly `NotRun`. |
| Artifact kind | Evidence schema, readiness checklist, plan/tasks addendum |
| TuiVision-specific exclusions | Do not prescribe terminal protocols, macOS/Linux/WSL, `TERM`, or TTY APIs. |
| Generic target rule | A platform label is not physical-runtime evidence. Keep deterministic injection, remote CI, and physical observation as distinct evidence classes. An unavailable physical condition remains `NotRun`, never Pass. |
| Occurrence count | 2 consecutive field runs: candidate in 020, confirmed in 021. |
| Confidence | High for the evidence-honesty invariant and sufficient for a generic preset field shape. |
| Permission risk | Low. The safety risk is overclaiming environmental proof; the classification prevents that. |
| Reproducible test | Run a host-sensitive synthetic feature with redirected I/O. Require deterministic proof to pass while the physical row remains `NotRun` with residual risk and re-evaluation trigger. |
| Decision | `Promote` |
| Confirms | AR-020-04 |

## Workitem AR-021-04: Missing Reviewer Invariant Confirmed

| Field | Value |
|---|---|
| Observation | Copilot quota was exhausted on both 021 PRs. Claude and all checks passed, GraphQL had zero actionable threads, and only the named human-approval rule remained. |
| Artifact kind | Permission-boundary field validation |
| TuiVision-specific exclusions | Do not require Copilot, Claude, GitHub, or admin bypass. |
| Generic target rule | An unavailable reviewer is missing, not successful. Any bypass requires explicit current authority, green required gates, zero actionable threads, and one named residual rule. |
| Occurrence count | 4 feature runs and associated delivery PRs. |
| Confidence | High for the invariant; provider-specific failure taxonomy remains pluggable. |
| Permission risk | High if authority is inferred from autonomy, repository ownership, or previous runs. |
| Reproducible test | Inject reviewer quota, unavailable, and timeout outcomes. None may count as approval; unauthorized remote modes must refuse writes and merge. |
| Decision | `Promote` for the invariant; `ObserveAgain` for provider taxonomy |
| Confirms | AR-020-05 |

## Workitem AR-021-05: Narrow Text-status Priority Is Feature-specific

| Field | Value |
|---|---|
| Observation | A Controls green attempt exposed that `Unsupported` was clipped in a narrow terminal view. Reordering status fields made capability state visible and the next focused run passed. |
| Artifact kind | Feature A11Y/proof evidence only |
| TuiVision-specific exclusions | The view width, status vocabulary, buffer model, and terminal profile are TuiVision-specific. |
| Generic target rule | None yet. Generic autonomous governance already requires triggered A11Y and visible-state proof; this is an instance of that rule. |
| Occurrence count | 1 domain-specific field run. |
| Confidence | High for 021 correctness, low for a new cross-project workflow rule. |
| Permission risk | None. |
| Reproducible test | Retained in TuiVision `TTerminalViewTests`; no portable preset test proposed. |
| Decision | `RejectProjectSpecific` |

## Workitem AR-021-06: Solution-level Targeted Filter Noise

| Field | Value |
|---|---|
| Observation | One targeted solution-level command efficiently covered the touched Driver, Controls, and Compatibility boundaries but also produced no-matching-test noise in unrelated projects. Separate final affected-project batches were clearer. |
| Artifact kind | Validation batching efficiency candidate |
| TuiVision-specific exclusions | Do not prescribe `dotnet test`, solution filters, MSTest, project names, or manual build counters. |
| Generic target rule | Prefer the smallest command batch whose output maps unambiguously to every touched ownership boundary; avoid broad filters that report unrelated no-match results unless they materially reduce work and remain machine-verifiable. |
| Occurrence count | 1 field run. |
| Confidence | Medium; both approaches were correct and the trade-off is stack-dependent. |
| Permission risk | None. Validation must never be reduced below repository gates for efficiency. |
| Reproducible test | Compare a synthetic multi-project filtered command with explicit affected-project commands; require identical target coverage and reject ambiguous no-match handling. |
| Decision | `ObserveAgain` |

## Snapshot Coverage

The 021 snapshot includes the orchestration skill, OpenAI UI metadata, runbook,
retrospective ledger, task/evidence templates, causal agent policy, and concrete
feature plus closeout ledgers. It proposes no script because no portable,
deterministic, Bash/PowerShell-parity detector has been field-proven.

## Next Field Gate

Feature 022 should keep the pre-named causal closeout path and test whether a
closeout PR can avoid self-referential evidence churn. It should reuse the
promoted deterministic/remote/physical evidence classes for platform-aware
visual examples and continue to classify unavailable reviewers without
granting authority.
