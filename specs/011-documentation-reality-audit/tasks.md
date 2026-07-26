# Tasks: Registered Documentation Reality Audit

**Input:** `specs/011-documentation-reality-audit/`
**Execution:** Serialized because registry, ledger, evidence, state, statistics,
and delivery files are shared.

## Phase 1: Evidence Foundation

- [X] T001 Create `autonomous-run-state.json` with accepted input hashes
- [X] T002 Create `autonomous-run-gate-requirements.json`
- [X] T003 Create the phase and validation ledger in `autonomous-run-evidence.md`
- [X] T004 Revalidate the active 20-target Series review in Bash and PowerShell
- [X] T005 Freeze Level-0 and fleet-manifest provenance in `registry-snapshot.json`

## Phase 2: Test-First Audit Contract

- [X] T006 Implement missing-target negative fixture in `tests/test_documentation_audit.py`
- [X] T007 Implement duplicate-target negative fixture
- [X] T008 Implement invalid-decision negative fixture
- [X] T009 Implement unsupported-claim-without-evidence negative fixture
- [X] T010 Implement incomplete-finding negative fixture
- [X] T011 Implement duplicate-finding and missing-handoff negative fixtures
- [X] T012 Implement private-absolute-path negative fixture
- [X] T013 Record the expected red baseline for T006-T012
- [X] T014 Implement structured ledger validation in `tools/validate_documentation_audit.py`
- [X] T015 Prove all negative fixtures and one minimal positive fixture green

## Phase 3: User Story 1 - Complete Inventory

- [X] T016 [US1] Record exact Level-0 Git and documentation-family inventory
- [X] T017 [US1] Inventory all registered Level-1 repositories
- [X] T018 [US1] Inventory the `cc65` Level-2 repository with its non-MSL boundary
- [X] T019 [US1] Inventory non-learning C# Level-2 repositories
- [X] T020 [US1] Inventory Secure OrderDesk Level-2 repositories
- [X] T021 [US1] Inventory Secure ServiceHarvester Level-2 repositories
- [X] T022 [US1] Inventory Secure CaseTracker Level-2 repositories
- [X] T023 [US1] Inventory `absdd-image-sandbox`
- [X] T024 [US1] Inventory all registered preset Level-2 repositories
- [X] T025 [US1] Reconcile exact target cardinality and blocked targets

## Phase 4: User Story 2 - Reality Decisions and Findings

- [X] T026 [US2] Review current guidance and source-of-truth ownership
- [X] T027 [US2] Review specifications, architecture, security, and A11Y families
- [X] T028 [US2] Review generated-document and statistics contracts
- [X] T029 [US2] Review learner-facing and agent-facing documentation
- [X] T030 [US2] Assign exactly one accepted decision to every audit area
- [X] T031 [US2] Create stable `DOC###` findings only for evidenced contradictions
- [X] T032 [US2] Record owner, severity, residual risk, boundary, and trigger
- [X] T033 [US2] Validate all positive claims against exact current evidence

## Phase 5: User Story 3 - Bounded Handoff

- [X] T034 [US3] Route each Level-0 finding exclusively to D2
- [X] T035 [US3] Route each Level-1/2 finding exclusively to D3
- [X] T036 [US3] Record justified non-remediation outcomes
- [X] T037 [US3] Prove no finding has duplicate or missing handoff
- [X] T038 [US3] Record D2/D3 successor boundaries without starting either run

## Phase 6: Governance and Validation

- [X] T039 Complete `checklists/audit-governance.md`
- [X] T040 Record all preset applicability and N/A re-evaluation triggers
- [X] T041 Review all five agent surfaces and record unchanged or synchronized result
- [X] T042 Run the complete audit validator and feature tests
- [X] T043 Run `git diff --check`, Homogeneity, Markdown-link, and generated-doc gates
- [X] T044 Run PSScriptAnalyzer, secret scan, agent-parity, and `specify check`
- [X] T045 Confirm no audited repository worktree or remote was changed
- [X] T046 Update and canonically render `docs/project-statistics.md`
- [X] T047 Archive the D1 intake through the repository rename workflow
- [X] T048 Reconcile tasks, accepted hashes, scope, and final local evidence

## Phase 7: MergeAndSync Delivery

- [X] T049 Validate and stage only the exact intended feature candidate
- [X] T050 Commit, push, and create the Feature 011 PR
- [X] T051 Converge mandatory checks and actionable review threads
- [X] T052 Generate and validate temporary exact-head provider evidence
- [X] T053 Merge only after every technical gate passes
- [X] T054 Delete the feature branch and synchronize clean local `main`
- [X] T055 Complete the retrospective without starting D2

## Dependencies and Coverage

- T001-T005 precede every implementation task.
- T006-T015 establish the deterministic proof contract.
- T016-T025 cover FR-001 through FR-003 and SC-001.
- T026-T033 cover FR-004 through FR-013 and SC-002 through SC-008.
- T034-T038 cover FR-014, SC-004, SC-005, and the D2/D3 boundary.
- T039-T048 cover CR-001 through CR-009 and all validation gates.
- T049-T055 cover SC-009 and MergeAndSync completion.
