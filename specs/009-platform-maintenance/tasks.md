# Tasks: Platformübergreifende Ein-Kommando-Wartung

**Input**: `specs/009-platform-maintenance/`
**Tests**: Test-first für Manifest-, Git-Zustands-, Fehler- und Paritätsverträge.

## Phase 1: Setup

- [X] T001 Synchronize the Plan phase and accepted artifact hashes in `specs/009-platform-maintenance/autonomous-run-state.json`
- [X] T002 Review and freeze acceptance gates in `specs/009-platform-maintenance/autonomous-run-gate-requirements.json`
- [X] T003 Record planning, governance and scope evidence in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T004 Verify the existing script and test ownership categories in `scripts/config/script-catalog.json`

## Phase 2: Foundational Contracts

- [X] T005 Create the versioned manifest with 42 Git targets plus one collection in `scripts/config/agentic-workspace-fleet.json`
- [X] T006 Create structural validation rules in `scripts/config/agentic-workspace-fleet.schema.json`
- [X] T007 [P] Add manifest cardinality and semantic contract tests in `scripts/tests/test_maintenance_contracts.py`
- [X] T008 [P] Add temporary-HOME and local-bare-remote fixture helpers in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T009 Add negative fixtures for traversal, duplicates, invalid collections and orphan Level-2 targets in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T010 Execute T007-T009 and record the expected red baseline in `specs/009-platform-maintenance/autonomous-run-evidence.md`

## Phase 3: User Story 1 - Complete Safe Maintenance (P1)

**Goal**: Missing and existing declared repositories are classified and only
safe clone or fast-forward actions execute.

**Independent Test**: Local bare-remotes prove Missing, Current, Behind, Ahead,
Diverged, Dirty, Detached and PathConflict without touching real repositories.

- [X] T011 [US1] Implement shared manifest loading, semantics and path safety in `scripts/lib/agentic_workspace_fleet.py`
- [X] T012 [US1] Add Bash manifest option and contract-engine boundary in `scripts/maintain-agentic-workspace.sh`
- [X] T013 [US1] Add PowerShell ManifestPath and contract-engine boundary in `scripts/maintain-agentic-workspace.ps1`
- [X] T014 [US1] Implement shared target classification and HOME-relative resolution in `scripts/lib/agentic_workspace_fleet.py`
- [X] T015 [US1] Add classification tests for all declared repository states in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T016 [US1] Implement transactional clone-on-missing in `scripts/lib/agentic_workspace_fleet.py`
- [X] T017 [US1] Integrate transactional clone results in `scripts/maintain-agentic-workspace.sh`
- [X] T018 [US1] Implement safe current/behind/ahead/diverged/dirty/detached/path-conflict decisions in `scripts/lib/agentic_workspace_fleet.py`
- [X] T019 [US1] Integrate transactional clone and repository decisions in `scripts/maintain-agentic-workspace.ps1`
- [X] T020 [US1] Restrict propagation to canonical-fleet targets in `scripts/maintain-agentic-workspace.sh`
- [X] T021 [US1] Restrict propagation to canonical-fleet targets in `scripts/maintain-agentic-workspace.ps1`
- [X] T022 [US1] Prove US1 green behavior and exact target cardinalities in `specs/009-platform-maintenance/autonomous-run-evidence.md`

## Phase 4: User Story 2 - Read-only and Preview Modes (P1)

**Goal**: Check-only and Preview inventory the same fleet without persistent
mutation.

**Independent Test**: Before/after filesystem and Git hashes remain unchanged,
while proposed clone and pull actions are reported.

- [X] T023 [US2] Add check-only and preview mutation-boundary fixtures in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T024 [US2] Make Bash check-only and dry-run cover missing targets and collections without mutation in `scripts/maintain-agentic-workspace.sh`
- [X] T025 [US2] Make PowerShell CheckOnly and WhatIf cover missing targets and collections without mutation in `scripts/maintain-agentic-workspace.ps1`
- [X] T026 [US2] Preserve Bash-3.2 empty-array no-op behavior in `scripts/maintain-agentic-workspace.sh`
- [X] T027 [US2] Preserve PowerShell empty-collection no-op behavior in `scripts/maintain-agentic-workspace.ps1`
- [X] T028 [US2] Verify US2 before/after hashes and no-op evidence in `specs/009-platform-maintenance/autonomous-run-evidence.md`

## Phase 5: User Story 3 - Continue after Isolated Failure (P2)

**Goal**: Independent stages continue and a terminal report survives isolated
failures.

**Independent Test**: A forced target and subprocess failure blocks only
dependants and still writes the correlated log and JSON report.

- [X] T029 [US3] Add stage dependency, partial-failure and report-survival fixtures in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T030 [US3] Implement shared stage result capture and dependency-aware continuation in `scripts/lib/agentic_workspace_fleet.py`
- [X] T031 [US3] Integrate shared stage continuation in `scripts/maintain-agentic-workspace.ps1`
- [X] T032 [US3] Integrate run ID, durable log and JSON report in `scripts/maintain-agentic-workspace.sh`
- [X] T033 [US3] Integrate run ID, durable transcript and JSON report in `scripts/maintain-agentic-workspace.ps1`
- [X] T034 [US3] Derive overall status and compatible exitcodes from terminal results in `scripts/maintain-agentic-workspace.sh`
- [X] T035 [US3] Derive overall status and compatible exitcodes from terminal results in `scripts/maintain-agentic-workspace.ps1`
- [X] T036 [US3] Prove partial-failure continuation and report integrity in `specs/009-platform-maintenance/autonomous-run-evidence.md`

## Phase 6: User Story 4 - Platform Parity (P2)

**Goal**: macOS/Linux Bash and Windows PowerShell expose equivalent operations,
decisions and evidence.

**Independent Test**: Identical fixture inputs produce equivalent status,
exitcode and normalized report projections.

- [X] T037 [US4] Add normalized Bash/PowerShell report comparison fixtures in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T038 [US4] Add current-run admin prompt opt-in and deferred status to `scripts/maintain-agentic-workspace.sh`
- [X] T039 [US4] Add current-run admin prompt opt-in and deferred status to `scripts/maintain-agentic-workspace.ps1`
- [X] T040 [US4] Expose `Invoke-HBAgenticWorkspaceMaintenance` as the approved advanced function in `scripts/maintain-agentic-workspace.ps1`
- [X] T041 [US4] Align compact DE-first/EN-second terminal summaries in `scripts/maintain-agentic-workspace.sh`
- [X] T042 [US4] Align compact DE-first/EN-second terminal summaries in `scripts/maintain-agentic-workspace.ps1`
- [X] T043 [US4] Add or update only necessary didactic comments in `scripts/maintain-agentic-workspace.sh`
- [X] T044 [US4] Add or update only necessary didactic comments in `scripts/maintain-agentic-workspace.ps1`
- [X] T045 [US4] Record platform and comment-adequacy decisions in `specs/009-platform-maintenance/autonomous-run-evidence.md`

## Phase 7: Documentation and Governance

- [X] T046 Update bilingual CLI usage and report guidance in `docs/man/maintain-agentic-workspace.1.md`
- [X] T047 Update the script catalog if new test ownership requires it in `scripts/config/script-catalog.json`
- [X] T048 Record NIST SSDF, CWE, CAPEC, SAMM and OpenSSF evidence in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T049 Record explicit N/A and re-evaluation triggers for ASVS, SBOM, VEX, SLSA, AI-SBOM, regulatory, Zero Trust and BSI C3A/C5 in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T050 Complete the text-first, bilingual and WCAG-applicability review in `specs/009-platform-maintenance/checklists/governance.md`
- [X] T051 Review all five agent surfaces and record unchanged or synchronized disposition in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T052 Archive the completed intake through the repository rename workflow for `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`

## Phase 8: Validation and Delivery

- [X] T053 Run manifest and maintenance behavior tests and record results in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T054 Run Bash syntax, Bash safe modes and PowerShell parser/PSScriptAnalyzer gates and record results in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T055 Run `git diff --check`, secret scan, homogeneity and agent-parity gates and record results in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T056 Validate real macOS check-only and dry-run without fleet mutations and record results in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T057 Update and canonically render `docs/project-statistics.md`
- [X] T058 Reconcile all tasks, hashes, scope boundaries and final local validation in `specs/009-platform-maintenance/autonomous-run-state.json`
- [X] T059 Stage only intended paths and validate the exact delivery candidate recorded in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T060 Commit, push and create the Feature 009 PR under MergeAndSync authority and record it in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T061 Converge mandatory macOS/Linux/Windows checks and actionable review threads for the exact PR head in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T062 Generate and validate temporary exact-head provider gate evidence using `specs/009-platform-maintenance/autonomous-run-gate-requirements.json`
- [X] T063 Merge with the authorized narrow bypass only if Human Approval is the sole remaining gate and record the decision in `specs/009-platform-maintenance/autonomous-run-evidence.md`
- [X] T064 Delete the feature branch, synchronize clean local `main`, and prove `HEAD == origin/main`
- [X] T065 Complete retrospective and any genuinely required non-empty causal closeout evidence in `specs/009-platform-maintenance/retrospective.md`

## Dependencies and Execution Order

- T001-T010 establish the shared contract and red baseline.
- US1 provides target classification and mutation boundaries.
- US2 depends on US1 decisions but independently proves non-mutation.
- US3 depends on target results and adds continuation/reporting.
- US4 depends on all prior contracts and closes platform parity.
- T046-T052 follow stable behavior; T053-T065 serialize validation and delivery.
- Shared scripts, evidence, statistics and state files are intentionally
  serialized; no unsafe parallel marker is used for them.

## Requirement Coverage

- FR-001-FR-010: T005-T022.
- FR-011-FR-013, FR-027: T023-T028.
- FR-014-FR-021: T029-T036.
- FR-022-FR-026, FR-028: T037-T045.
- FR-029-FR-030 and CR-001-CR-012: T046-T065.
- SC-001: T015-T022.
- SC-002: T023-T028.
- SC-003-SC-004: T026-T028 and T037-T045.
- SC-005-SC-006: T015-T022.
- SC-007-SC-008: T029-T036 and T041-T042.
- SC-009-SC-010: T053-T065.
