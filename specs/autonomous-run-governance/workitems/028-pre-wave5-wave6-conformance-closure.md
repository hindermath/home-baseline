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

## Workitem AR-028-03: Resume Must Reconcile New Mandatory Rules

| Field | Value |
|---|---|
| Observation | The real Feature-028 resume under preset v0.2.0 correctly reconstructed state, revalidated authority, and reran Analyze. The accepted tasks had been generated before the current marker-consumer rule, however, and the resume contract preserved them because their hashes had not drifted. After the gate marker changed, the first remote CI run found two stale executable assertions that local task execution had not selected. |
| Immutable field evidence | TuiVision PR `#79`; feature head `75889b85474b732ffd43ac54a55b016e352ae62c`; merge `28f23cc10a400e7450131da387421cb92b9e4ce7`; first failing CI run `29440455237`; final passing CI run `29440943486`; final local Release suite `756/756`; gate requirements hash `62c0a68f5aad09717b0912f720b3b5678ce76514fdbffd9ff98580230bf3e3a4`. |
| Artifact kind | Resume command and generated skill, runbook, readiness checklist, agent addendum, field validation, and workitem |
| TuiVision-specific exclusions | Do not promote Feature-028 marker names, .NET test paths, build-counter rules, TuiVision gate states, provider run IDs, branch policy, or Wave-5/6 ordering. |
| Generic target rule | After preset or governance drift, compare current mandatory correctness, security, permission, and evidence-integrity rules with accepted Plan, Tasks, and checklists. If an applicable mandatory rule is missing, amend only the affected entries in place and rerun readiness plus Analyze before implementation. Preserve scope and prior decisions; efficiency-only preferences remain retrospective input. |
| Occurrence count | Two related deterministic marker-consumer findings: Feature 027 established the consumer-search rule; the real Feature-028 resume exposed the missing rule-migration step. |
| Confidence | High. Both failures are reproducible evidence-integrity defects, and the v0.2.1 correction is provider-neutral and scope-preserving. |
| Permission risk | Low. The correction adds analysis and bounded artifact amendment only; it grants no implementation or remote authority. |
| Reproducible test | Accept a fixture task list under an older preset without a marker-consumer dependency task, then resume under a newer preset that makes the rule mandatory. Require a minimal Plan/Tasks/checklist delta and Analyze rerun. Add an efficiency-only rule and require accepted artifacts to remain unchanged. |
| Decision | `Promote` as `autonomous-run-governance` v0.2.1. This is a correctness/evidence-integrity correction after deterministic field evidence, not a broad task regeneration rule. |

## Field Boundary

AR-028-01 and AR-028-02 justified the portable lifecycle correction before the
feature continued. Thorsten then explicitly released the run. The real resume,
implementation, PR, and merge completed without runtime, API, dependency,
example, or historical-source changes. AR-028-03 is the bounded follow-up before
the causal closeout; Feature 029 remains the sole next intake and is not started.
