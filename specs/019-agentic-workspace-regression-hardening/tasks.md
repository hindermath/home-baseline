# Tasks: Wartungs-TUI- und Wrapper-Regressionshaertung

**Input**: Accepted Feature-019 artifacts under
`specs/019-agentic-workspace-regression-hardening/`  
**Delivery**: `MergeAndSync`  
**Rule**: Execute in ID order. Shared evidence, state, statistics, workflow and
documentation files are serialized.

## Phase 1 - Setup and Accepted Foundation

- [X] T001 Confirm clean synchronized `main` and `HEAD == origin/main` in the repository worktree.
- [X] T002 Confirm completed predecessor states under `specs/*/autonomous-run-state.json` and no resumable run.
- [X] T003 Run `specify check` against `.specify/` and record success in `autonomous-run-evidence.md`.
- [X] T004 Verify the eleven-preset matrix under `.specify/presets/` and Autonomous v0.3.3.
- [X] T005 Validate `requirements/intakes/series/home-baseline-delivery/manifest.json` read-only in Bash and PowerShell.
- [X] T006 Confirm R-TUI is the only eligible target and D4 is blocked in the Series manifest.
- [X] T007 Validate the R-TUI review under `specs/agentic-workspace-wartungs-tui-und-wrapper-regressionshaertung-intake-review/`.
- [X] T008 Create branch `019-agentic-workspace-regression-hardening` through `.specify/extensions/git/scripts/bash/create-new-feature.sh`.
- [X] T009 Point `.specify/feature.json` to `specs/019-agentic-workspace-regression-hardening`.
- [X] T010 Create `specs/019-agentic-workspace-regression-hardening/spec.md` without scope expansion or clarification markers.
- [X] T011 Complete `checklists/requirements.md` with zero open item.
- [X] T012 Complete `checklists/clarification.md` with zero material question.
- [X] T013 Create and validate `autonomous-run-state.json` with schema 1.1.
- [X] T014 Create `plan.md`, `research.md`, `data-model.md` and `quickstart.md`.
- [X] T015 Create contracts under `contracts/` for event/result reconciliation and Home Runtime delegation.
- [X] T016 Complete `checklists/security.md`, `architecture.md`, `accessibility.md` and `cross-platform.md`.
- [X] T017 Complete `checklists/plan-review.md` with zero Critical, High or Medium finding.
- [X] T018 Create `autonomous-run-gate-requirements.json` before product edits.
- [X] T019 Create `autonomous-run-evidence.md` before product edits.
- [X] T020 Validate the PlanReview checkpoint in `autonomous-run-state.json` using Bash and PowerShell.

## Phase 2 - Tasks and Analyze Convergence

- [X] T021 Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks`.
- [X] T022 Verify zero incomplete items under `specs/019-agentic-workspace-regression-hardening/checklists/`.
- [X] T023 Map FR-001-FR-024 and SC-001-SC-012 in the traceability section of `tasks.md`.
- [X] T024 Run first read-only Analyze across `spec.md`, `plan.md`, `tasks.md` and `.specify/memory/constitution.md`.
- [X] T025 Remediate material Analyze findings only in affected Feature-019 artifacts.
- [X] T026 Run a second read-only Analyze pass for remaining or introduced findings.
- [X] T027 Confirm zero Critical and High findings in the repeated Analyze report.
- [X] T028 Update and validate the Analyze checkpoint in `autonomous-run-state.json`.

## Phase 3 - User Story 1: Complete Live Status

**Goal**: Bash emits valid, contiguous and complete event evidence.  
**Independent test**: A real isolated check-only path produces valid JSONL,
sequence `1..n`, one run start and one matching completion without false
degradation.

- [X] T029 [US1] Add a failing real-Bash event fixture to `scripts/tests/test_maintenance_tui_wrappers.py`.
- [X] T030 [US1] Require object-valued `details`, UTF-8 JSONL and contiguous persisted sequence in `test_maintenance_tui_wrappers.py`.
- [X] T031 [US1] Require one matching start and completion with report/log/status/exit details in `test_maintenance_tui_wrappers.py`.
- [X] T032 [US1] Record the expected pre-fix event failure in `autonomous-run-evidence.md`.
- [X] T033 [US1] Repair details selection in `scripts/maintain-agentic-workspace.sh` without weakening Python validation.
- [X] T034 [US1] Couple `EVENT_SEQUENCE` advancement to successful persistence in `scripts/maintain-agentic-workspace.sh`.
- [X] T035 [US1] Preserve warning-only degradation after a genuine writer failure in `scripts/maintain-agentic-workspace.sh`.
- [X] T036 [US1] Run focused positive event tests from `scripts/tests/test_maintenance_tui_wrappers.py`.
- [X] T037 [US1] Run malformed-details, failed-write, partial-line, unknown-schema and duplicate-completion fixtures from `scripts/tests/`.
- [X] T038 [US1] Confirm no false `SequenceGap` or `EVENT_STREAM_DEGRADED` in the isolated evidence output.
- [X] T039 [US1] Review changed event logic in `maintain-agentic-workspace.sh` for concise bilingual didactic-comment need.
- [X] T040 [US1] Record US1 green proof and boundary in `autonomous-run-evidence.md`.

## Phase 4 - User Story 2: Truthful Completion

**Goal**: A valid deterministic report remains canonical when advisory
completion evidence is unavailable.  
**Independent test**: Valid report plus exit 0 passes without a completion
event, while missing, unfinished, foreign and contradictory evidence fails
closed.

- [X] T041 [US2] Add a failing no-completion report test under `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Infrastructure/`.
- [X] T042 [US2] Add missing, unfinished, foreign-run and malformed report tests under the same test directory.
- [X] T043 [US2] Retain real contradiction tests in `Contracts/RunResultReconcilerTests.cs`.
- [X] T044 [US2] Record the expected pre-fix report-discovery failure in `autonomous-run-evidence.md`.
- [X] T045 [US2] Add typed `ReportPath` to `Infrastructure/MaintenanceCommandBuilder.cs`.
- [X] T046 [US2] Derive the expected report path from Home directory and run ID in `MaintenanceCommandBuilder.cs`.
- [X] T047 [US2] Update all `ProcessInvocation` uses under `src/` and `tests/` without changing wrapper CLI arguments.
- [X] T048 [US2] Prefer matching completion-event evidence in `Infrastructure/MaintenanceProcessRunner.cs`.
- [X] T049 [US2] Fall back only to typed `ReportPath` in `MaintenanceProcessRunner.cs` when completion evidence is absent or unusable.
- [X] T050 [US2] Require finalization, expected run ID, status and exit code before reconciled acceptance in `MaintenanceProcessRunner.cs`.
- [X] T051 [US2] Reject scans, newest-file selection and foreign-run fallback in process-runner tests.
- [X] T052 [US2] Apply deterministic report lookup to cancellation handling in `MaintenanceProcessRunner.cs`.
- [X] T053 [US2] Run focused positive and negative .NET report tests in Release configuration.
- [X] T054 [US2] Confirm genuine contradictions still produce `RESULT_MISMATCH` in reconciler tests.
- [X] T055 [US2] Review reconciliation proof boundaries for concise bilingual comments in changed C# files.
- [X] T056 [US2] Record US2 green proof and boundary in `autonomous-run-evidence.md`.

## Phase 5 - User Story 3: Safe Argumentless Home Delegation

**Goal**: Home Runtime delegates zero, one and multiple arguments safely under
Bash 3.2.  
**Independent test**: `/bin/bash` preserves every argument boundary and starts
exactly one canonical engine process.

- [X] T057 [US3] Add zero/one/many delegation fixtures to `scripts/tests/test_maintenance_tui_wrappers.py`.
- [X] T058 [US3] Add empty, whitespace, wildcard, quote and metacharacter cases to the delegation fixture.
- [X] T059 [US3] Add one-process assertion to the Home Runtime delegation fixture.
- [X] T060 [US3] Record the expected pre-fix Bash-3.2 zero-argument failure in `autonomous-run-evidence.md`.
- [X] T061 [US3] Add an explicit zero-argument branch to `scripts/maintain-agentic-workspace.sh`.
- [X] T062 [US3] Preserve quoted array forwarding for non-zero arguments in `maintain-agentic-workspace.sh`.
- [X] T063 [US3] Preserve one `exec` transition to the canonical Level-0 script.
- [X] T064 [US3] Run all delegation fixtures under macOS `/bin/bash`.
- [X] T065 [US3] Confirm direct and delegated options and exit codes remain equivalent.
- [X] T066 [US3] Confirm `scripts/maintain-agentic-workspace.ps1` behavior remains unchanged and valid.
- [X] T067 [US3] Review the Bash-3.2 compatibility branch for a concise bilingual didactic comment.
- [X] T068 [US3] Record US3 green proof and boundary in `autonomous-run-evidence.md`.

## Phase 6 - User Story 4: Platform-Equal Accessible Evidence

**Goal**: macOS, Linux and Windows preserve the same understandable status and
result boundaries.  
**Independent test**: TUI, Plain and `TERM=dumb` expose status, reason and next
action without relying on color or layout, and native platform tests agree.

- [X] T069 [US4] Review user contract claims in `README.md`, `docs/man/maintain-agentic-workspace.1.md` and `docs/scripts/reference.md`.
- [X] T070 [US4] Review evidence claims in `docs/architecture/maintenance-tui.md` and `docs/accessibility/maintenance-tui.md`.
- [X] T071 [US4] Review security boundaries in the affected files under `docs/security/`.
- [X] T072 [US4] Update only semantically affected documentation in German-first/English-second CEFR-B2 form.
- [X] T073 [US4] Record the architecture decision `NoUpdateRequired` or update affected S-ADR/arc42 evidence under `docs/architecture/`.
- [X] T074 [US4] Record applicable STRIDE/CAPEC evidence and trigger-based cloud N/A decisions under `docs/security/` or feature evidence.
- [X] T075 [US4] Verify text-first status, reason and next action in TUI, Plain and `TERM=dumb` tests.
- [X] T076 [US4] Verify `NO_COLOR`, keyboard and exactly-once cancellation regressions remain green.
- [X] T077 [US4] Run focused wrapper behavior on macOS and retain Ubuntu/Windows exact-head gates for delivery.
- [X] T078 [US4] Verify Unix manpage and PowerShell help parity; update both only if the public contract changed.
- [X] T079 [US4] Review `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` and `.github/agents/copilot-instructions.md` together.
- [X] T080 [US4] Record `NoUpdateRequired` for shared agent guidance unless a durable rule changed.
- [X] T081 [US4] Record Documentation Impact with owner, sources, outputs and proof in `documentation-impact-evidence.json`.
- [X] T082 [US4] Record applicability and explicit re-evaluation triggers for ASVS, SBOM, VEX, SLSA, OpenSSF, AI-SBOM, NIS2, CRA, EU AI Act, DORA, Zero Trust, BSI C3A and BSI C5 in `autonomous-run-evidence.md`.
- [X] T083 [US4] Record US4 green proof and cross-platform boundary in `autonomous-run-evidence.md`.

## Phase 7 - Full Local Validation and Polish

- [X] T084 Run `bash -n scripts/maintain-agentic-workspace.sh` and shell syntax checks for every changed shell file.
- [X] T085 Run focused wrapper and event tests in `scripts/tests/test_maintenance_tui_wrappers.py`.
- [X] T086 Run the TUI test project under `scripts/lib/maintenance-tui/tests/` in Release with locked restore.
- [X] T087 Run Feature-015-018 maintenance regression suites under `scripts/tests/`.
- [X] T088 Run full repository Python test discovery for `scripts/tests/`.
- [X] T089 Run `scripts/invoke-psscriptanalyzer.ps1` against tracked PowerShell files.
- [X] T090 Run homogeneity and agent-parity checks from `scripts/`.
- [X] T091 Run `scripts/scan-agent-secrets.sh --fail-on-high .`.
- [X] T092 Run `git diff --check` and review UTF-8, LF/CRLF and personal-path boundaries.
- [X] T093 Confirm locked package and vulnerability state under `scripts/lib/maintenance-tui/` is unchanged.
- [X] T094 Confirm DocFX/web-A11Y is not triggered unless the final documentation diff meets its trigger.
- [X] T095 Create a validated local implementation checkpoint commit, then render and verify `docs/project-statistics.md` with `scripts/render-project-statistics.sh`.
- [X] T096 Confirm no dependency, CLI, schema, target-repository or maintenance-authority diff.
- [X] T097 Re-run `specify check` and Feature-019 acceptance cardinalities.
- [X] T098 Validate the Validate checkpoint in `autonomous-run-state.json` with Bash and PowerShell.

## Phase 8 - Publish, Review and Exact-Head Delivery

- [X] T099 Align accepted-artifact hashes and final implementation evidence in `autonomous-run-state.json` and `autonomous-run-evidence.md`.
- [X] T100 Commit the non-empty Feature-019 implementation on the exact feature branch.
- [X] T101 Push the branch and create the MergeAndSync pull request with evidence-based description.
- [ ] T102 Inspect every mandatory technical check for the exact PR head.
- [ ] T103 Confirm macOS, Ubuntu and Windows proof; treat absent native evidence as missing.
- [ ] T104 Create temporary provider-neutral `autonomous-run-gate-evidence.json` for the exact head.
- [ ] T105 Validate exact-head gate evidence with Bash and PowerShell gate validators.
- [ ] T106 Inspect Copilot, Claude and GraphQL review threads and resolve every actionable finding.
- [ ] T107 Re-run affected gates after corrections and invalidate stale exact-head evidence.
- [ ] T108 Confirm all technical gates green and zero actionable review threads.
- [ ] T109 Use the authorized narrow Admin Bypass only if Human Approval is the sole remaining rule.
- [ ] T110 Merge with a merge commit and delete the remote feature branch.
- [ ] T111 Switch to `main`, fetch/prune, fast-forward pull and prove clean `HEAD == origin/main`.

## Phase 9 - Causal Series Closeout and Retrospective

- [ ] T112 Create a non-empty causal closeout branch from synchronized `main` because merge facts could not exist on the reviewed head.
- [ ] T113 Archive the R-TUI intake through the repository archive workflow.
- [ ] T114 Update the active Series manifest, receipt and visible order for completed R-TUI.
- [ ] T115 Bind actual Feature-019 PR and merge evidence into D4 without inventing D4 findings.
- [ ] T116 Re-review affected Intake/Series evidence and validate Bash/PowerShell authoring, review and sequencing contracts.
- [ ] T117 Confirm D4 is the one eligible documentation-audit candidate and do not start it in Feature 019.
- [ ] T118 Deliver the non-empty closeout PR with exact-head checks, review convergence and narrow bypass rules.
- [ ] T119 Merge the closeout and prove local `main` is clean, synchronized and `(0 0)`.
- [ ] T120 Complete `retrospective.md` with the established promotion decision taxonomy.
- [ ] T121 Promote no preset change unless a reproducible provider-neutral defect is proven.
- [ ] T122 Finalize `autonomous-run-state.json` as `Retrospective`, `Completed`, with `nextExactAction: N/A`.

## Requirement Traceability

| Requirement group | Task coverage |
|---|---|
| FR-001-FR-006 / SC-001-SC-004 / US1 | T029-T040, T085, T087 |
| FR-007-FR-011 / SC-003-SC-005 / US2 | T041-T056, T086 |
| FR-012-FR-015 / SC-006 / US3 | T057-T068, T085 |
| FR-016-FR-022 / SC-007-SC-009 / US4 | T069-T083, T084-T098, T102-T109 |
| FR-023-FR-024 / SC-010 | T039, T055, T067, T069-T082, T095 |
| SC-011 | T099-T110 |
| SC-012 / GOV-007-GOV-009 | T111-T122 |

## Dependencies and Strategy

- T024-T028 gate product edits.
- US1, US2 and US3 are independently testable but execute serially because
  they share run evidence and invocation contracts.
- US4 follows the three repairs so documentation describes actual behavior.
- Full validation precedes every publish action.
- Causal closeout depends on the merged Feature-019 head and synchronized
  `main`; D4 may begin only after T122 and a fresh explicit preflight.

The smallest useful vertical slice is US1: one real valid event stream without
a false sequence gap. No `[P]` marker is used because the accepted autonomous
workflow serializes shared evidence, state and overlapping wrapper/TUI files.
