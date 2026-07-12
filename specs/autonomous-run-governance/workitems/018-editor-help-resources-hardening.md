# Preset Follow-up: 018 Editor, Help and Resources Hardening

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `018-editor-help-resources-hardening` |
| Feature PR | `hindermath/TuiVision#42` |
| Feature merge | `271b85bf17b740fe64a739c4c4e4e97567e4b391` |
| Evidence closeout PR | `hindermath/TuiVision#43` |
| Retrospective PR | `hindermath/TuiVision#44` |
| Final source main | `945d8eb` |
| Delivery mode | `MergeAndSync` |
| Required checks | Passed on feature, closeout, and retrospective PRs |
| Review state | Claude passed; GraphQL reported zero threads; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the otherwise sole human-approval rule after green checks and zero threads |
| Field-input snapshot | `specs/autonomous-run-governance/field-inputs/018/` |

## Workitem AR-018-01: Explicit Evidence Paths for Delivery Tasks

| Field | Value |
|---|---|
| Observation | The first Analyze pass found four remote tasks whose acceptance result had no exact repository evidence path. This weakened traceability and deterministic resume. |
| Artifact kind | Skill correction, task-template correction, agent-policy correction, runbook clarification |
| TuiVision-specific exclusions | Do not prescribe `pr-evidence.md`, GitHub, merge commits, human-approval bypass, `Directory.Build.props`, .NET, DocFX, or TuiVision branch numbering as universal behavior. |
| Generic target rule | Every remote or delivery task must name the exact repository evidence path that records its acceptance result. An implicit instruction to record evidence is insufficient. |
| Occurrence count | 1 field run, 4 independently detected task rows |
| Confidence | High for the evidence invariant; Analyze produced actionable Medium findings and the corrected task set converged. |
| Permission risk | None from the rule itself. The evidence path must document authority but must never create remote authority. |
| Reproducible test | Generate tasks for a synthetic `MergeAndSync` plan. Fail validation when any push, PR, review, merge, cleanup, or sync task lacks a repository path. Re-run Analyze and require zero unmapped delivery tasks. |
| Decision | `Promote` |

### Candidate Package Surfaces

- `speckit.autonomous` command and generated agent skill
- tasks addendum and readiness checklist
- runbook delivery and resume sections
- autonomous evidence template
- agent addendum for cross-surface parity

## Workitem AR-018-02: Group Project-local Red Boundaries

| Field | Value |
|---|---|
| Observation | Serialization negative boundaries were implemented across two focused red/green cycles. Both cycles found real defects, but each required another version/build-counter transition. |
| Artifact kind | Task-shaping candidate, validation-efficiency candidate |
| TuiVision-specific exclusions | Do not generalize .NET project boundaries, Coverlet, manual build counters, serialization formats, or the exact test projects. |
| Generic target rule | When independent negative cases share one bounded project and contract, consider creating the complete red boundary matrix before the first green implementation, while keeping each expected failure observable. |
| Occurrence count | 1 field run |
| Confidence | Medium-low; the second cycle added real evidence, so batching could also hide useful learning or increase repair scope. |
| Permission risk | None. The risk is proof quality: batching must not allow implementation-before-test or ambiguous failures. |
| Reproducible test | Compare Feature 019 task execution with and without grouped red boundaries. Record build/test cycles, newly discovered defects, task traceability, and whether the first green change remained bounded. |
| Decision | `ObserveAgain` |

## Workitem AR-018-03: Missing Automated Reviewer and Narrow Bypass

| Field | Value |
|---|---|
| Observation | Copilot could not review because the requester quota was exhausted. Required checks and Claude passed, GraphQL had zero threads, and only the human-approval rule blocked merge. |
| Artifact kind | Permission-boundary validation |
| TuiVision-specific exclusions | Do not encode TuiVision branch protection, Copilot/Claude availability, or admin bypass as a required platform configuration. |
| Generic target rule | An unavailable reviewer is a missing review, never a passed review. `MergeAndSync` may use an explicitly delegated bypass only for the named residual rule after all required checks pass and actionable threads are zero. |
| Occurrence count | Repeated across prior TuiVision autonomous delivery and Feature 018 |
| Confidence | High; the existing runbook handled the condition without weakening technical gates. |
| Permission risk | High if generalized incorrectly. Default preset behavior must remain `LocalImplementation`; remote writes and bypass require current explicit authority. |
| Reproducible test | Run synthetic delivery with reviewer quota failure and no remote authority: expect stop and evidence. Repeat with explicit bounded authority and one remaining human-approval rule: permit only that bypass after green checks and zero threads. |
| Decision | `Promote` for the safety invariant; `ObserveAgain` for provider-specific wording |

## Snapshot Coverage

The 018 handoff includes the exact field-used skill source, OpenAI UI metadata,
runbook, evidence template, and retrospective model. No script is proposed from
this run: no deterministic need beyond existing Git/Spec-Kit commands was
proven, so Bash/PowerShell parity is not triggered yet.

## Next Field Gate

Feature 019 must verify that generated delivery tasks all name evidence paths.
It must also record whether grouped red boundaries reduce validation churn
without weakening test-first proof. A later workitem may supersede this one,
but must preserve its source PR and merge evidence.
