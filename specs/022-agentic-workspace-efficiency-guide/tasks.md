# Tasks: Agentic Workspace Efficiency Guide

**Input**: `spec.md`, `plan.md`, `research.md`, `data-model.md`, `quickstart.md`, `contracts/`
**Delivery**: `MergeAndSync`
**Scope**: Documentation and feature-local validation only

## Phase 1: Setup And Accepted Evidence

- [X] T001 Verify clean branch, `.specify/feature.json`, `specify check`, prerequisites and completed checklists in repository root
- [X] T002 Validate D6 authoring receipt with Bash and PowerShell validators in `specs/intake-authoring-receipts/agentic-workspace-und-ein-kommando-wartung-effizienzleitfaden.json`
- [X] T003 Validate D6 Intake Review with Bash and PowerShell validators in `specs/documentation-architecture-intakes/reviews/d6/`
- [X] T004 Validate active Series manifest, receipt and review with Bash and PowerShell validators under `requirements/intakes/series/home-baseline-delivery/` and `specs/active-lastenheft-normalization/`
- [X] T005 Create evidence foundation in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T006 Create schema-1.1 run state in `specs/022-agentic-workspace-efficiency-guide/autonomous-run-state.json`
- [X] T007 Create gate declaration in `specs/022-agentic-workspace-efficiency-guide/autonomous-run-gate-requirements.json`
- [X] T008 Freeze normalized hashes for intake, review, Series and Features 018-021 in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`

## Phase 2: Source Matrix Foundation

- [X] T009 Inventory public Bash options and exitcodes from `scripts/maintain-agentic-workspace.sh` in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T010 Inventory public PowerShell parameters and help from `scripts/maintain-agentic-workspace.ps1` in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T011 Inventory manpage, script-reference, report and TUI evidence in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T012 Record source precedence and historical boundaries in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T013 Create initial schema and one valid reference slice in `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T014 [P] Write positive contract test in `specs/022-agentic-workspace-efficiency-guide/tests/test_efficiency_guide.py`
- [X] T015 [P] Write isolated negative fixtures for duplicate, missing, stale and historical-current claims in `specs/022-agentic-workspace-efficiency-guide/tests/test_efficiency_guide.py`
- [X] T016 Run tests before validator implementation and record the expected failure in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T017 Implement schema, path, hash, reader-path and claim validation in `specs/022-agentic-workspace-efficiency-guide/tools/validate_efficiency_guide.py`
- [X] T018 Run the positive and negative matrix tests green and record results in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T019 Complete all four ReaderPath rows in `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T020 Complete required Documentation Impact fields in `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`

## Phase 3: User Story 1 - Sicherer erster Wartungslauf (P1)

**Goal**: First-year learners can select and interpret a safe read-only run.

**Independent Test**: Follow only the first-run section and identify command,
side effects, possible exitcodes and exact next action.

- [X] T021 [US1] Write purpose, audience, first-use glossary and safety boundary in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T022 [US1] Write the check-preview-real decision flow in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T023 [US1] Document macOS/Linux first-run commands and proof limits in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T024 [US1] Document Windows first-run commands and proof limits in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T025 [US1] Explain exitcodes 0, 1, 2, 3, 130 and Linux TERM 143 in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T026 [US1] Add text-first next-action examples for pass, drift and operational failure in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T027 [US1] Create equivalent English first-run content in `docs/maintenance/agentic-workspace-efficiency-guide.en.md`
- [X] T028 [US1] Add reciprocal language links to both guide files in `docs/maintenance/`
- [X] T029 [US1] Link the learner path from `docs/getting-started.md` and `docs/getting-started.en.md`
- [X] T030 [US1] Add US1 claims and source hashes to `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T031 [US1] Validate US1 independently and record learner-review evidence in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`

## Phase 4: User Story 2 - Regelmaessiger sicherer Betrieb (P2)

**Goal**: Daily users can classify repository state and choose the allowed operation.

**Independent Test**: Determine the action for all seven worktree states and
interpret report, Run-ID and exitcode together.

- [X] T032 [US2] Document Remote Freshness ordering and complete-audit behavior in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T033 [US2] Document Clean, Dirty, Ahead, Behind, Diverged, Detached and Non-Default decisions in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T034 [US2] Document TUI, Plain and Headless selection boundaries in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T035 [US2] Document `--scripts-only`, drift repair, optional packages and admin-prompt boundaries in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T036 [US2] Document report, log, Run-ID and JSONL evidence hierarchy in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T037 [US2] Document routine-operation safe completion and retention in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T038 [US2] Create equivalent English routine-operation content in `docs/maintenance/agentic-workspace-efficiency-guide.en.md`
- [X] T039 [US2] Link the daily-user path from `docs/maintenance/README.md` and `docs/maintenance/README.en.md`
- [X] T040 [US2] Add US2 claims and source hashes to `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T041 [US2] Validate all worktree-class and option claims against current sources
- [X] T042 [US2] Record US2 independent review in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`

## Phase 5: User Story 3 - Maintainer And AI-Agent Handoff (P3)

**Goal**: Maintainers and agents derive edit, sync and delivery boundaries.

**Independent Test**: Given one path and delivery authority, select canonical
edit location, serialization, sync need and remote stop boundary.

- [X] T043 [US3] Document Level-0 source, Home Runtime and machine-local state in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T044 [US3] Document `homeRuntime`, `sourceOnly` and `machineLocal` decision tables in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T045 [US3] Document manifest/resolver authority, Host sync and sandbox boundary in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T046 [US3] Document LocalImplementation, PublishPR and MergeAndSync boundaries in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T047 [US3] Add reusable AI-agent prompt and authority checklist in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T048 [US3] Document serialized writers and safe serial/parallel work in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T049 [US3] Document drift-repair branch/review/PR handoff in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T050 [US3] Create equivalent English maintainer/agent content in `docs/maintenance/agentic-workspace-efficiency-guide.en.md`
- [X] T051 [US3] Link the maintainer path from both `docs/architecture/source-and-home-runtime*.md` files
- [X] T052 [US3] Add US3 claims and source hashes to `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T053 [US3] Record US3 independent review in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`

## Phase 6: User Story 4 - Fehleranalyse And Audit (P4)

**Goal**: Reviewers reconstruct failure, interruption and evidence boundaries.

**Independent Test**: Diagnose one interrupted and one degraded-stream case
without assuming successful completion.

- [X] T054 [US4] Document lock ownership, interruption and resume evidence in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T055 [US4] Document exactly-once `Ctrl+C`, exit 130/143 and cleanup boundaries in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T056 [US4] Document `EVENT_STREAM_DEGRADED`, report reconciliation and proof limits in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T057 [US4] Document provider, timeout, retry and deferred-admin classifications in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T058 [US4] Document audit retention, reproducibility and source re-evaluation triggers in `docs/maintenance/agentic-workspace-efficiency-guide.md`
- [X] T059 [US4] Create equivalent English troubleshooting/audit content in `docs/maintenance/agentic-workspace-efficiency-guide.en.md`
- [X] T060 [US4] Link the audit path from `docs/troubleshooting/README.md` and `docs/troubleshooting/README.en.md`
- [X] T061 [US4] Add US4 claims and source hashes to `docs/maintenance/agentic-workspace-efficiency-source-matrix.json`
- [X] T062 [US4] Record US4 independent review in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`

## Phase 7: Cross-Cutting Documentation And Governance

- [X] T063 Add guide navigation to `README.md`, `README.en.md`, `docs/README.md` and `docs/README.en.md`
- [X] T064 Review `docs/man/maintain-agentic-workspace.1.md` and `docs/scripts/reference.md`; record `NoUpdateRequired` or bounded change evidence
- [X] T065 Review all five maintained agent surfaces and `.specify/templates/`; record parity and no-change rationale in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T066 Record all eleven preset applicability outcomes in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T067 Record NIST SSDF, CWE Top 25 and all conditional security/architecture/supply-chain/regulatory `N/A` rows in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T068 Complete Documentation Impact evidence for each changed documentation family in `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md`
- [X] T069 Perform DE/EN semantic parity and CEFR-B2 review across changed Markdown
- [X] T070 Perform WCAG 2.2 AA, text-first, keyboard, screenreader, Braille and text-browser applicability review
- [X] T071 Run the exact Lychee command from `.github/workflows/documentation-and-learning-package.yml`, or record local-tool absence and require its exact-head provider job
- [X] T072 Run source-matrix tests and production validation from `quickstart.md`
- [X] T073 Run `git diff --check`, secret scan, Homogeneity, PSScriptAnalyzer and `specify check`
- [X] T074 Run changed-path scope proof and confirm zero executable, dependency, preset, registry, workflow or fleet changes
- [X] T075 Decide automation follow-up as `NoFollowUpRequired` or create one evidenced non-empty intake
- [X] T076 Update and render `docs/project-statistics.md`
- [X] T077 Complete `specs/022-agentic-workspace-efficiency-guide/pr-evidence.md` with all commands, results, skips and risks
- [X] T078 Validate all requirements, success criteria, checklists, contracts and task coverage

## Phase 8: Delivery And Causal Closeout

- [X] T079 Validate staged exact candidate, commit and push Feature 022 branch
- [X] T080 Create one non-empty Feature 022 PR and converge required checks and actionable reviews
- [X] T081 Re-run source-matrix tests locally on the exact pushed head, generate temporary provider evidence for existing workflows, and validate both evidence classes with Bash and PowerShell
- [X] T082 Merge Feature 022 under approved rules and synchronize clean `main` with `(0 0)`
- [X] T083 Create Feature 022 retrospective and terminal run-state evidence through one causal closeout PR if required
- [X] T084 Archive D6, update and independently review D7, and update the active Series without starting Feature 023 inside Feature 022

## Dependencies And Execution Order

- Phase 1 blocks all later phases.
- Phase 2 blocks source-backed documentation work.
- User stories are independently reviewable but execute serially because they
  share the paired guide and source matrix.
- Phase 7 depends on all four stories.
- Delivery depends on all validation tasks.
- Causal closeout begins only after the product PR merge.

## Parallel Opportunities

- T014 and T015 may be prepared independently before the failing test run.
- No documentation story task is marked parallel because the same guide and
  matrix are shared writer surfaces.
- Provider jobs may run concurrently after the exact candidate is pushed; the
  evidence evaluation remains serialized.

## Implementation Strategy

1. Prove the matrix contract on one vertical slice.
2. Deliver US1 as the minimal safe learner path.
3. Add routine operation, maintainer/agent and audit paths in order.
4. Complete cross-cutting navigation and governance.
5. Deliver and close D6 causally; do not start D7 within this run.
