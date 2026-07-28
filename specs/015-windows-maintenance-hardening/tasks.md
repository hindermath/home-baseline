# Tasks: Windows-Härtung der Ein-Kommando-Wartung

**Input**: `specs/015-windows-maintenance-hardening/`
**Tests**: Test-first for all WEM-001 through WEM-013 contracts.

## Phase 1: Setup and contracts

- [X] T001 Validate and freeze autonomous run state and gate requirements
- [X] T002 Freeze Spec, plan, research, data model, contracts and checklists
- [X] T003 Add Windows hardening contract fixtures in `scripts/tests/test_windows_maintenance_hardening.py`
- [X] T004 Execute and record the expected red baseline

## Phase 2: Deterministic startup and preview (US1)

- [X] T005 [US1] Implement the single canonical mode projection in `scripts/maintain-agentic-workspace.ps1`
- [X] T006 [US1] Implement bounded Python 3 launcher resolution
- [X] T007 [US1] Move required Python and PSScriptAnalyzer gates before the first mutation
- [X] T008 [US1] Keep repository discovery read-only and mode-independent
- [X] T009 [US1] Finalize the correlated report and exit with its canonical exitcode
- [X] T010 [US1] Prove WEM-001, WEM-002, WEM-003, WEM-010, WEM-011 and WEM-013

## Phase 3: Safe repair and profile integrity (US2)

- [X] T011 [US2] Implement atomic local phase resume evidence
- [X] T012 [US2] Reject unknown, partial or changed dirty states
- [X] T013 [US2] Separate raw differences from Git-actionable drift
- [X] T014 [US2] Bind registry repair to the explicit eleven-preset profile
- [X] T015 [US2] Prove WEM-004, WEM-005 and WEM-006

## Phase 4: Bounded external operations (US3)

- [X] T016 [US3] Add bounded transient Git retry classification and evidence
- [X] T017 [US3] Add WinGet hard timeout and complete process-tree cleanup
- [X] T018 [US3] Classify unattended admin work as `DEFERRED_ADMIN_REQUIRED`
- [X] T019 [US3] Prevent orphan or duplicate WinGet workers on resume
- [X] T020 [US3] Prove WEM-007 and WEM-008

## Phase 5: Package and harness parity (US4)

- [X] T021 [US4] Canonicalize package IDs and reduce to one final status
- [X] T022 [US4] Use the same installed set for detection and summary
- [X] T023 [US4] Preserve Windows absolute paths in Bash subprocess fixtures
- [X] T024 [US4] Recognize orchestrator-managed dirty files in fixtures
- [X] T025 [US4] Restore Bash/PowerShell statistics JSON semantic parity
- [X] T026 [US4] Prove WEM-009 and WEM-012

## Phase 6: Documentation and governance

- [X] T027 Update bilingual PowerShell help and maintenance manpage
- [X] T028 Record A11Y, secure coding, architecture and standards evidence
- [X] T029 Review all maintained agent guidance surfaces and record disposition
- [X] T030 Archive the completed intake through the Windows rename workflow
- [X] T031 Update and render `docs/project-statistics.md`

## Phase 7: Validation and delivery

- [X] T032 Run Windows hardening and existing maintenance suites
- [X] T033 Run parser, PSScriptAnalyzer and project-statistics suites
- [X] T034 Run CheckOnly and WhatIf and prove no mutation
- [X] T035 Run diff, secret, homogeneity and agent-parity gates
- [X] T036 Reconcile tasks, hashes and final autonomous state
- [X] T037 Stage only intended paths and validate the exact candidate
- [X] T038 Commit, push and open the Feature 015 PR
- [X] T039 Converge exact-head checks and actionable review threads
- [X] T040 Validate provider-neutral exact-head gate evidence
- [X] T041 Merge under authorized MergeAndSync authority only after all gates
- [X] T042 Delete feature branch, sync clean local `main` and prove exact equality
- [X] T043 Complete retrospective and genuinely required causal closeout
- [X] T044 Inventory Git state, fetch, perform safe pulls, then intentional commits and pushes

## Requirement Coverage

- WEM-001/002/003/010/011/013: T005-T010.
- WEM-004/005/006: T011-T015.
- WEM-007/008: T016-T020.
- WEM-009/012: T021-T026.
- AC-001 through AC-016: T010, T015, T020, T026 and T032-T040.
- Documentation, security, A11Y and statistics: T027-T031.
- MergeAndSync and final Git inventory: T036-T044.
