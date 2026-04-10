# Tasks: Workspace- und Projekt-Teardown

**Input**: Design documents from `/specs/005-workspace-teardown/`
**Prerequisites**: `plan.md` (required), `spec.md` (required for user stories), `research.md`, `data-model.md`, `contracts/`

**Tests**: No automated test tasks are generated. The feature specification and plan require manual verification with `--dry-run` / `-WhatIf`, live-run spot checks, and regression checks.

**Organization**: Tasks are grouped by user story to enable independent implementation and manual validation of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Scripts live in `scripts/`
- Feature design artifacts live in `specs/005-workspace-teardown/`
- Manual verification references the scenarios in `specs/005-workspace-teardown/quickstart.md`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create the new teardown entry points and establish the implementation surface defined by the plan.

- [ ] T001 Create paired teardown script files `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`
- [ ] T002 Scaffold the top-level command structure, usage/help text, and strict-mode headers in `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core runtime infrastructure that MUST be complete before any user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Implement CLI argument parsing, teardown context assembly, and home-directory resolution in `scripts/teardown-workspace.sh`
- [ ] T004 [P] Implement parameter parsing, teardown context assembly, and home-directory resolution in `scripts/teardown-workspace.ps1`
- [ ] T005 Implement shared Bash helpers for bilingual output, preamble/completion boxes, and dry-run execution control in `scripts/teardown-workspace.sh`
- [ ] T006 [P] Implement shared PowerShell helpers for bilingual output, preamble/completion boxes, and `ShouldProcess`/`-WhatIf` execution control in `scripts/teardown-workspace.ps1`
- [ ] T007 Bind normalized workspace naming in `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1` to the existing `normalize_name()` / `ConvertTo-NormalizedName()` behavior from `scripts/bootstrap-workspace.sh` and `scripts/bootstrap-workspace.ps1`

**Checkpoint**: Foundational teardown infrastructure is ready for story-specific behavior

---

## Phase 3: User Story 1 - Sicheres lokales Entfernen eines Workspace (Priority: P1) 🎯 MVP

**Goal**: Remove a workspace safely on the local machine, including safety gates, local deletion, artifact cleanup, and bilingual reporting.

**Independent Test**: `teardown-workspace.sh --dry-run MyProjects` lists all local teardown actions without writes; a live run on a clean workspace removes the directory and cleans tracked artifacts in `~/`.

### Implementation for User Story 1

- [ ] T008 [US1] Implement `home-baseline` protection, workspace existence validation, and exit-code handling in `scripts/teardown-workspace.sh`
- [ ] T009 [P] [US1] Implement `home-baseline` protection, workspace existence validation, and exit-code handling in `scripts/teardown-workspace.ps1`
- [ ] T010 [US1] Implement safety checks for uncommitted changes, unpushed commits, and non-recursive Level-2 detection in `scripts/teardown-workspace.sh`
- [ ] T011 [P] [US1] Implement safety checks for uncommitted changes, unpushed commits, and non-recursive Level-2 detection in `scripts/teardown-workspace.ps1`
- [ ] T012 [US1] Implement local workspace deletion, artifact cleanup (`~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/*.inc`), and atomic artifact commit fallback handling in `scripts/teardown-workspace.sh`
- [ ] T013 [P] [US1] Implement local workspace deletion, artifact cleanup (`~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/*.inc`), and atomic artifact commit fallback handling in `scripts/teardown-workspace.ps1`
- [ ] T014 [US1] Implement interactive confirmation, dry-run invariants, and bilingual completion reporting for the local-only flow in `scripts/teardown-workspace.sh`
- [ ] T015 [P] [US1] Implement interactive confirmation, dry-run invariants, and bilingual completion reporting for the local-only flow in `scripts/teardown-workspace.ps1`
- [ ] T016 [US1] Manually validate User Story 1 scenarios from `specs/005-workspace-teardown/spec.md`, `specs/005-workspace-teardown/quickstart.md`, and the local-flow portions of `specs/005-workspace-teardown/contracts/cli.md` using `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`

**Checkpoint**: User Story 1 is functional and manually testable as the MVP without backup, remote deletion, or recursive teardown

---

## Phase 4: User Story 2 - Backup vor Löschung + Remote-Repo entfernen (Priority: P2)

**Goal**: Add pre-delete backup creation and remote repository teardown behavior for GitHub/GitLab, including skip and failure paths.

**Independent Test**: `teardown-workspace.sh MyProjects --backup` creates a collision-safe archive before deletion; `--keep-remote` preserves the remote; remote-delete failure aborts before local deletion.

### Implementation for User Story 2

- [ ] T017 [US2] Implement backup archive creation, numeric collision suffix handling, and `tar` warning behavior in `scripts/teardown-workspace.sh`
- [ ] T018 [P] [US2] Implement backup archive creation, numeric collision suffix handling, and `tar` warning behavior in `scripts/teardown-workspace.ps1`
- [ ] T019 [US2] Implement remote URL detection, GitHub deletion, no-remote skip, and `--keep-remote` branching in `scripts/teardown-workspace.sh`
- [ ] T020 [P] [US2] Implement remote URL detection, GitHub deletion, no-remote skip, and `-KeepRemote` branching in `scripts/teardown-workspace.ps1`
- [ ] T021 [US2] Implement GitLab optional `glab` deletion path and remote-delete failure abort gate in `scripts/teardown-workspace.sh`
- [ ] T022 [P] [US2] Implement GitLab optional `glab` deletion path and remote-delete failure abort gate in `scripts/teardown-workspace.ps1`
- [ ] T023 [US2] Manually validate backup, keep-remote, no-remote, GitHub/GitLab, and remote-failure scenarios from `specs/005-workspace-teardown/spec.md` and `specs/005-workspace-teardown/quickstart.md` using `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`

**Checkpoint**: User Stories 1 and 2 both work, and the backup/remote flow remains independently verifiable

---

## Phase 5: User Story 3 - Rekursiver Teardown mit Level-2-Projekten (Priority: P3)

**Goal**: Process Level-2 repositories safely and recursively before tearing down the parent workspace.

**Independent Test**: A workspace with two Level-2 repos aborts without `--recursive`; with `--recursive`, all Level-2 repos are processed first and the workspace artifact commit still runs only once.

### Implementation for User Story 3

- [ ] T024 [US3] Implement Level-2 repository discovery, recursive sequencing, and `--force` propagation in `scripts/teardown-workspace.sh`
- [ ] T025 [P] [US3] Implement Level-2 repository discovery, recursive sequencing, and `-Force` propagation in `scripts/teardown-workspace.ps1`
- [ ] T026 [US3] Implement consolidated recursive preamble/confirmation flow and ensure no artifact commit is created for Level-2 repositories in `scripts/teardown-workspace.sh`
- [ ] T027 [P] [US3] Implement consolidated recursive preamble/confirmation flow and ensure no artifact commit is created for Level-2 repositories in `scripts/teardown-workspace.ps1`
- [ ] T028 [US3] Manually validate recursive and non-recursive Level-2 scenarios from `specs/005-workspace-teardown/spec.md` and `specs/005-workspace-teardown/quickstart.md` using `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`

**Checkpoint**: User Stories 1-3 are functional, and recursive teardown remains independently testable

---

## Phase 6: User Story 4 - `--teardown`-Alias in bootstrap-workspace (Priority: P4)

**Goal**: Delegate teardown through the existing bootstrap entry points without introducing a second teardown implementation path.

**Independent Test**: `bootstrap-workspace.sh --teardown --dry-run MyProjects` and the PowerShell equivalent behave the same as direct calls to the teardown scripts.

### Implementation for User Story 4

- [ ] T029 [US4] Add `--teardown` delegation to `scripts/bootstrap-workspace.sh` so it forwards directly to `scripts/teardown-workspace.sh`
- [ ] T030 [P] [US4] Add `-Teardown` delegation to `scripts/bootstrap-workspace.ps1` so it forwards directly to `scripts/teardown-workspace.ps1`
- [ ] T031 [US4] Manually validate alias parity against direct teardown invocation using `specs/005-workspace-teardown/spec.md`, `specs/005-workspace-teardown/quickstart.md`, `scripts/bootstrap-workspace.sh`, and `scripts/bootstrap-workspace.ps1`

**Checkpoint**: All four user stories are independently functional and manually verifiable

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final parity, regression, and delivery-readiness checks across all stories

- [ ] T032 [P] Review bilingual message consistency, exit-code parity, and dry-run parity across `scripts/teardown-workspace.sh`, `scripts/teardown-workspace.ps1`, `scripts/bootstrap-workspace.sh`, and `scripts/bootstrap-workspace.ps1`
- [ ] T033 Run the full manual verification matrix from `specs/005-workspace-teardown/quickstart.md` on the current OS-first script path and cross-check the paired shell path
- [ ] T034 Verify regression expectations from `specs/005-workspace-teardown/plan.md` by confirming an unrelated workspace and the existing bootstrap flow still behave correctly after teardown changes
- [ ] T035 Measure SC-001 dry-run timing in `specs/005-workspace-teardown/quickstart.md` scenarios and record pass/fail for `<2s` in `specs/005-workspace-teardown/quickstart.md` for `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`
- [ ] T036 Measure SC-002 full teardown timing in controlled manual runs and record pass/fail for `<30s` in `specs/005-workspace-teardown/quickstart.md`
- [ ] T037 Verify CLI contract conformance against `specs/005-workspace-teardown/contracts/cli.md` for help text, preamble box, confirmation prompt, completion report, dry-run output, and exit codes in `scripts/teardown-workspace.sh` and `scripts/teardown-workspace.ps1`, and summarize the verification results in `specs/005-workspace-teardown/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; starts immediately
- **Foundational (Phase 2)**: Depends on Setup completion; blocks all user stories
- **User Story phases (Phase 3-6)**: Depend on Foundational completion; recommended execution order is P1 → P2 → P3 → P4, but US2 and US3 may start earlier when team capacity and risk tolerance allow
- **Polish (Phase 7)**: Depends on completion of all user story phases

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational; no dependency on other stories
- **User Story 2 (P2)**: Can start after Foundational; recommended after US1 because it extends the same teardown flow and reduces integration risk
- **User Story 3 (P3)**: Can start after Foundational; recommended after US2 because it reuses the finalized remote/local sequencing and recursive orchestration is easier to validate on top of it
- **User Story 4 (P4)**: Depends on the teardown implementation being complete enough for delegation parity; in practice it should follow US1-US3

### Within Each User Story

- Bash and PowerShell tasks for the same behavior should stay functionally aligned and finish together
- Core flow changes come before manual validation
- Story-level validation happens before moving to the next priority

### Parallel Opportunities

- **Phase 2**: T003/T004 and T005/T006 can proceed in parallel by shell variant after task boundaries are clear
- **User Story 1**: T008/T009, T010/T011, T012/T013, and T014/T015 can run in parallel by shell variant
- **User Story 2**: T017/T018, T019/T020, and T021/T022 can run in parallel by shell variant
- **User Story 3**: T024/T025 and T026/T027 can run in parallel by shell variant
- **User Story 4**: T029/T030 can run in parallel by shell variant

---

## Parallel Example: User Story 2

```text
Task: T017 Implement backup archive creation, numeric collision suffix handling, and `tar` warning behavior in scripts/teardown-workspace.sh
Task: T018 Implement backup archive creation, numeric collision suffix handling, and `tar` warning behavior in scripts/teardown-workspace.ps1

Task: T019 Implement remote URL detection, GitHub deletion, no-remote skip, and `--keep-remote` branching in scripts/teardown-workspace.sh
Task: T020 Implement remote URL detection, GitHub deletion, no-remote skip, and `-KeepRemote` branching in scripts/teardown-workspace.ps1
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE** User Story 1 manually before expanding scope

### Incremental Delivery

1. Finish Setup + Foundational once
2. Deliver User Story 1 as the MVP local teardown
3. Add User Story 2 for backup and remote cleanup
4. Add User Story 3 for recursive Level-2 teardown
5. Add User Story 4 for bootstrap alias delegation
6. Finish with cross-cutting parity and regression checks

### Parallel Team Strategy

1. One engineer completes Setup + Foundational
2. Then split Bash/PowerShell work within each user story across two engineers
3. Rejoin for story-level manual validation and final regression checks

---

## Notes

- `[P]` tasks are separated by shell variant or by non-overlapping validation work
- Manual validation is part of the implementation scope because the repository standard is manual-first verification
- Every user story phase includes an independent validation step before the next story begins
- Keep the teardown pair and bootstrap alias pair commit-aligned per Constitution Principle II
