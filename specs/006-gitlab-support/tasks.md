# Tasks: GitLab Support for Bootstrap Scripts

**Input**: Design documents from `/specs/006-gitlab-support/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `quickstart.md`, `contracts/`

**Tests**: Kein neues Test-Framework. Verifikation erfolgt manuell per `--dry-run`, `-WhatIf` und `-Preview` gemäß Constitution Principle V.

**Organization**: Tasks are grouped by user story so each story can be implemented and verified independently.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependency on incomplete tasks)
- **[Story]**: User story label (`[US1]`, `[US2]`, `[US3]`, `[US4]`)
- Every task includes exact file paths

---

## Phase 1: Setup (Shared Entry Points)

**Purpose**: Prepare script entry points and user-facing option surfaces for GitLab support

- [ ] T001 Update Bash usage/help text for `--platform` and `--gitlab-url` in `scripts/bootstrap-workspace.sh` and `scripts/bootstrap-project.sh`
- [ ] T002 [P] Update PowerShell parameter/help surface for `-Platform` and `-GitLabUrl` in `scripts/bootstrap-workspace.ps1` and `scripts/bootstrap-project.ps1`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Add shared GitLab parsing and validation scaffolding that all user stories depend on

**⚠️ CRITICAL**: No user story work should start before this phase is complete

- [ ] T003 Implement Bash platform parsing, `https://` validation, and hostname derivation in `scripts/bootstrap-workspace.sh`
- [ ] T004 [P] Implement Bash platform parsing, `https://` validation, hostname derivation, and local `normalize_name()` helper in `scripts/bootstrap-project.sh`
- [ ] T005 [P] Implement PowerShell parameter scaffolding, explicit bilingual platform validation, and `-GitLabUrl` validation in `scripts/bootstrap-workspace.ps1`
- [ ] T006 [P] Implement PowerShell parameter scaffolding, explicit bilingual platform validation, and `-GitLabUrl` validation in `scripts/bootstrap-project.ps1`

**Checkpoint**: Shared GitLab option handling is in place across all four scripts

---

## Phase 3: User Story 1 - Bootstrap a New Workspace on GitLab (Priority: P1) 🎯 MVP

**Goal**: Enable `bootstrap-workspace` to create and push a private GitLab repository while preserving GitHub default behavior

**Independent Test**: Run `bash scripts/bootstrap-workspace.sh --dry-run TestWS --platform gitlab` and confirm GitLab-specific actions are shown; then verify GitHub regression with `bash scripts/bootstrap-workspace.sh --dry-run TestWS`

### Implementation for User Story 1

- [ ] T007 [US1] Implement GitLab CLI install/auth/username pre-flight logic in `scripts/bootstrap-workspace.sh`
- [ ] T008 [US1] Implement GitLab repo creation, remote add, push, and dry-run command output in `scripts/bootstrap-workspace.sh`
- [ ] T009 [US1] Implement platform-aware preamble, slug display, summary output, and `~/README.md` row generation in `scripts/bootstrap-workspace.sh`
- [ ] T010 [P] [US1] Implement the equivalent GitLab workspace flow in `scripts/bootstrap-workspace.ps1`
- [ ] T011 [US1] Run the workspace validation commands from `specs/006-gitlab-support/plan.md` against `scripts/bootstrap-workspace.sh` and `scripts/bootstrap-workspace.ps1`

**Checkpoint**: User Story 1 is complete when workspace bootstrap works on GitLab and still defaults to GitHub without regressions

---

## Phase 4: User Story 2 - Bootstrap a New Project on GitLab (Priority: P2)

**Goal**: Enable `bootstrap-project` to create and push a private GitLab repository with full preview parity and `--no-remote` compatibility

**Independent Test**: Run `bash scripts/bootstrap-project.sh TestProject . --preview --platform gitlab` and confirm GitLab-specific remote actions are previewed; then re-run with `--no-remote` and confirm remote creation is skipped

### Implementation for User Story 2

- [ ] T012 [US2] Implement GitLab-aware preview output and Step 13 remote creation flow in `scripts/bootstrap-project.sh`
- [ ] T013 [US2] Preserve `--no-remote`, add platform-aware project summary and normalized GitLab slug output, and keep `~/README.md` behavior platform-aware in `scripts/bootstrap-project.sh`
- [ ] T014 [P] [US2] Implement the equivalent GitLab project flow, summary output, slug display, and `-Preview` parity in `scripts/bootstrap-project.ps1`
- [ ] T015 [US2] Run the project validation commands from `specs/006-gitlab-support/plan.md` and `specs/006-gitlab-support/quickstart.md` against `scripts/bootstrap-project.sh` and `scripts/bootstrap-project.ps1`, including invalid `--platform` / `-Platform` and invalid `--gitlab-url` / `-GitLabUrl` fatal-path checks

**Checkpoint**: User Story 2 is complete when project bootstrap previews and executes GitLab remote actions correctly while `--no-remote` remains unchanged

---

## Phase 5: User Story 4 - Guided Error Handling for Missing or Unauthenticated glab (Priority: P2)

**Goal**: Provide clear bilingual guidance when GitLab CLI is missing, unauthenticated, or misconfigured

**Independent Test**: Simulate missing or unauthenticated `glab` and verify the scripts emit bilingual installation/auth guidance without cryptic failures

### Implementation for User Story 4

- [ ] T016 [US4] Add bilingual invalid-platform, missing-`glab`, missing-auth, and username-retrieval error paths to `scripts/bootstrap-workspace.sh`
- [ ] T017 [P] [US4] Add bilingual invalid-platform, missing-`glab`, missing-auth, and username-retrieval error paths to `scripts/bootstrap-workspace.ps1`
- [ ] T018 [US4] Add bilingual GitLab error guidance to `scripts/bootstrap-project.sh`
- [ ] T019 [P] [US4] Add bilingual GitLab error guidance to `scripts/bootstrap-project.ps1`
- [ ] T020 [US4] Update troubleshooting and `glab auth login` pitfall guidance in `README.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`
- [ ] T021 [US4] Update standard GitLab examples and the two explanatory blockquotes under `### Nächste Schritte / Next steps` in `README.md`
- [ ] T022 [US4] Run deterministic error-handling validation for the four bootstrap scripts in `scripts/` using PATH masking to simulate missing `glab`, and `glab auth logout` or host-specific logout to simulate unauthenticated GitLab sessions, following `specs/006-gitlab-support/quickstart.md` and `specs/006-gitlab-support/plan.md`

**Checkpoint**: User Story 4 is complete when missing-tool and auth failures are self-explanatory and bilingual across Bash and PowerShell

---

## Phase 6: User Story 3 - Use Self-Hosted GitLab Instance (Priority: P3)

**Goal**: Support `--gitlab-url` / `-GitLabUrl` for self-hosted GitLab across workspace and project bootstrap flows

**Independent Test**: Run the self-hosted dry-run/preview commands with `https://gitlab.example.com` and verify hostname, remote URL, summary output, and README links all use the custom base URL

### Implementation for User Story 3

- [ ] T023 [US3] Implement self-hosted `--gitlab-url` handling in `scripts/bootstrap-workspace.sh`
- [ ] T024 [P] [US3] Implement self-hosted `-GitLabUrl` handling in `scripts/bootstrap-workspace.ps1`
- [ ] T025 [US3] Implement self-hosted `--gitlab-url` handling in `scripts/bootstrap-project.sh`
- [ ] T026 [P] [US3] Implement self-hosted `-GitLabUrl` handling in `scripts/bootstrap-project.ps1`
- [ ] T027 [US3] Update self-hosted usage examples and platform-aware URL wording in `README.md`
- [ ] T028 [US3] Run the self-hosted validation commands from `specs/006-gitlab-support/plan.md` and `specs/006-gitlab-support/quickstart.md` against `scripts/bootstrap-workspace.sh`, `scripts/bootstrap-workspace.ps1`, `scripts/bootstrap-project.sh`, and `scripts/bootstrap-project.ps1`

**Checkpoint**: User Story 3 is complete when both bootstrap flows consistently target a custom GitLab base URL

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final parity pass, manual validation sweep, and documentation cleanup across all stories

- [ ] T029 [P] Reconcile final bilingual wording and heading consistency in `README.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`
- [ ] T030 Verify the final implementation against `specs/006-gitlab-support/checklists/plan-review.md`, `specs/006-gitlab-support/contracts/bootstrap-workspace-cli.md`, and `specs/006-gitlab-support/contracts/bootstrap-project-cli.md`
- [ ] T031 Run the full manual verification command set from `specs/006-gitlab-support/plan.md` and `specs/006-gitlab-support/quickstart.md`, including the timed `SC-001` live bootstrap check

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies
- **Foundational (Phase 2)**: Depends on Phase 1 and blocks all story work
- **User Story phases (Phase 3-6)**: Depend on Phase 2 completion
- **Polish (Phase 7)**: Depends on all intended user stories being complete

### User Story Dependencies

- **US1 (P1)**: Starts immediately after Foundational; it is the MVP and baseline for GitLab support
- **US2 (P2)**: Starts after Foundational; should preserve parity with US1 but remains independently verifiable
- **US4 (P2)**: Starts after Foundational; can proceed alongside US1/US2 where file ownership does not overlap
- **US3 (P3)**: Starts after US1 GitLab core flow exists; self-hosted support builds on the GitLab path already introduced for US1 and US2

### Within Each User Story

- Parsing and validation before repo creation
- Pre-flight and error paths before summary/output polish
- Bash and PowerShell parity before story validation
- Manual validation before closing the story

---

## Parallel Opportunities

- T002 can run in parallel with T001
- T004, T005, and T006 can run in parallel after T001-T002
- T010 can run in parallel with T007-T009 once US1 Bash behavior is structurally defined
- T014 can run in parallel with T012-T013 once US2 Bash behavior is structurally defined
- T017 and T019 can run in parallel with T016 and T018 because they target different PowerShell files
- T024 and T026 can run in parallel with T023 and T025 because workspace and project PowerShell files are independent
- T029 can run in parallel with T030 after the implementation phases are complete

---

## Parallel Example: User Story 1

```text
Task: T007 Implement GitLab CLI install/auth/username pre-flight logic in scripts/bootstrap-workspace.sh
Task: T010 Implement the equivalent GitLab workspace flow in scripts/bootstrap-workspace.ps1
```

## Parallel Example: User Story 2

```text
Task: T012 Implement GitLab-aware preview output and Step 13 remote creation flow in scripts/bootstrap-project.sh
Task: T014 Implement the equivalent GitLab project flow, summary output, slug display, and -Preview parity in scripts/bootstrap-project.ps1
```

## Parallel Example: User Story 4

```text
Task: T016 Add bilingual GitLab error paths to scripts/bootstrap-workspace.sh
Task: T017 Add bilingual GitLab error paths to scripts/bootstrap-workspace.ps1
Task: T018 Add bilingual GitLab error guidance to scripts/bootstrap-project.sh
Task: T019 Add bilingual GitLab error guidance to scripts/bootstrap-project.ps1
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Stop and validate the workspace GitLab flow with the manual commands in `specs/006-gitlab-support/plan.md`

### Incremental Delivery

1. Setup + Foundational establish GitLab parameter handling across all scripts
2. Deliver US1 for workspace bootstrap on GitLab
3. Deliver US2 for project bootstrap parity
4. Deliver US4 for guided failure handling
5. Deliver US3 for self-hosted GitLab support
6. Finish with Phase 7 polish and a full manual verification sweep

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, and Phase 3 (US1)
- **Next increment**: Phase 4 (US2)
- **Then**: Phase 5 (US4) and Phase 6 (US3)

---

## Notes

- No automated test tasks were generated because the spec and constitution call for manual verification rather than TDD or a new test framework
- `[P]` markers are used only where tasks target different files and do not require unfinished work in the same file
- Every user story includes an explicit manual validation task using `specs/006-gitlab-support/plan.md` and/or `specs/006-gitlab-support/quickstart.md`
- Keep Bash/PowerShell parity tight to avoid regressions between script variants
