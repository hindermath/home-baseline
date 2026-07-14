# Preset Follow-up: 028 Paused Conformance Closure

## Run Evidence

| Field | Value |
|---|---|
| Source feature | `028-pre-wave5-wave6-conformance-closure` |
| Feature branch | Local unpublished branch at planning checkpoint `5550fbf` |
| Completed phases | Specify, Clarify, checklists, Plan, plan review, and Tasks |
| Interrupted phase | Repeated read-only Analyze; no accepted result existed |
| Implementation state | Not started; no implementation evidence or runtime edit |
| User decision | Pause Feature 028 until separate explicit release |
| Safe boundary | Clean working tree; no external command running |
| Required next action | Explicit resume, drift/authority audit, then repeated Analyze |

## Workitem AR-028-01: Deliberate Pause Needs a Protected State

| Field | Value |
|---|---|
| Observation | The existing preset described resume in prose but exposed no durable lifecycle state, read-only status command, or protected deliberate-stop path. A user pause therefore depended on conversational context and could be mistaken for an unexpected interruption or a request to continue. |
| Artifact kind | Command, state template, validator, runbook, evidence, readiness checklist, agent guidance, and retrospective contract |
| TuiVision-specific exclusions | Do not promote feature number 028, TuiVision branch versioning, conformance findings, Turbo Vision sources, .NET commands, or repository merge policy. |
| Generic target rule | Give every autonomous run one validated feature-local state index. A cooperative stop records `PausedByUser` at the next safe boundary; the general autonomous command refuses to resume it; explicit resume rechecks drift, uncertain operations, governance, and current authority. |
| Occurrence count | One deterministic permission and resume-integrity finding during Feature 028 planning-to-Analyze transition. |
| Confidence | High for the missing contract and required fail-closed behavior; real completion remains a later field gate. |
| Permission risk | High. Silent continuation can execute implementation or remote work after the user intended a pause. The correction narrows authority and performs no automatic delivery action. |
| Reproducible test | In a temporary project, persist `PausedByUser` during Analyze, require status to remain read-only, require the general autonomous command to refuse continuation, and permit only explicit resume after branch, feature, artifact, task, operation, governance, and authority reconciliation. |
| Decision | `Promote` as `autonomous-run-governance` v0.2.0. Feature 028 remains paused until explicit release and later supplies the real resume field result. |

## Workitem AR-028-02: Interrupted Operations Cannot Inherit Success

| Field | Value |
|---|---|
| Observation | A prompt command cannot atomically terminate an arbitrary external process. After a hard interruption, command start alone is insufficient proof that a build, test, validation, or delivery action completed successfully. |
| Artifact kind | State model, validator, stop/resume command, and runbook clarification |
| TuiVision-specific exclusions | Do not promote specific build counters, test commands, runners, or provider check names. |
| Generic target rule | Cooperative stop acts only at a safe orchestration boundary. Any operation without a trustworthy terminal result is `NeedsRevalidation` and must be rerun or otherwise re-proven before continuation. |
| Occurrence count | One concrete interruption boundary plus existing provider-neutral evidence rules. |
| Confidence | High; this is a correctness rule rather than an efficiency preference. |
| Permission risk | Medium. Rerunning an uncertain remote mutation can duplicate effects, so resume must classify operation ownership and authority before repetition. |
| Reproducible test | Create an `Interrupted` fixture whose last operation claims `Completed`; require both Bash and PowerShell validators to reject it. Change the operation to `NeedsRevalidation` and require both to pass. |
| Decision | `Promote` in v0.2.0 with a graceful-stop contract only; no platform-specific force-abort command is introduced. |

## Field Boundary

This workitem justifies the portable correction before Feature 028 continues.
Synthetic validation and release-ZIP adoption can complete while the feature is
paused. Actual 028 resume, implementation, PR, merge, and closeout remain open
until Thorsten explicitly releases the paused run.
