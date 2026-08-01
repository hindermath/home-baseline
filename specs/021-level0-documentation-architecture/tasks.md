# Tasks: Level-0 Documentation Architecture

All tasks are serialized because the migration matrix, portals, shared guidance,
templates, evidence, Series, and statistics are common write surfaces.

## Phase 1: Evidence Foundation

- [X] T001 Confirm branch, starting commit, and MergeAndSync authority in `autonomous-run-evidence.md`
- [X] T002 Revalidate D5 authoring receipt and record its accepted hash
- [X] T003 Revalidate D5 Intake Review in Bash and PowerShell
- [X] T004 Revalidate the active Series in Bash and PowerShell
- [X] T005 Confirm D5 is the sole preferred `Eligible` candidate
- [X] T006 Bind accepted intake, review, Series, Constitution, and D4 evidence in run state
- [X] T007 Validate the initial run state in Bash and PowerShell
- [X] T008 Record Specify and Clarify convergence
- [X] T009 Complete requirements, plan-review, and documentation-governance checklists
- [X] T010 Record repeated Analyze convergence with zero Critical/High/Medium blockers

## Phase 2: Test-First Migration Contract

- [X] T011 Create a minimal positive migration fixture in `tests/test_documentation_migration.py`
- [X] T012 Add missing-section negative coverage
- [X] T013 Add duplicate-section-decision negative coverage
- [X] T014 Add unsupported-decision negative coverage
- [X] T015 Add missing-target negative coverage
- [X] T016 Add broken-link negative coverage
- [X] T017 Add missing-language-partner negative coverage
- [X] T018 Add incomplete-reader-path negative coverage
- [X] T019 Add private-absolute-path and secret negative coverage
- [X] T020 Add non-zero D6/D7 count negative coverage
- [X] T021 Add stale-source-hash negative coverage
- [X] T022 Add LF, CRLF, and UTF-8-BOM normalization coverage
- [X] T023 Record the expected failing reference slice
- [X] T024 Implement `tools/validate_documentation_migration.py`
- [X] T025 Prove the minimal positive and all negative fixtures green

## Phase 3: Root and Portal Architecture

- [X] T026 [US1] Inventory all former top-level `README.md` sections and exact source lines
- [X] T027 [US1] Define German root-entry information requirements
- [X] T028 [US1] Define English root-entry parity requirements
- [X] T029 [US1] Create compact German `README.md`
- [X] T030 [US1] Create equivalent `README.en.md`
- [X] T031 [US1] Add descriptive reciprocal language links
- [X] T032 [US1] Create German `docs/README.md` portal
- [X] T033 [US1] Create English `docs/README.en.md` portal
- [X] T034 [US1] Prove all four reader paths are reachable in at most two links
- [X] T035 [US1] Prove root purpose, prerequisites, safe first action, security, and A11Y coverage

## Phase 4: Topic Migration

- [X] T036 [US3] Migrate template and repository-orientation content to paired getting-started pages
- [X] T037 [US3] Migrate prerequisites and workspace-bootstrap content to paired getting-started pages
- [X] T038 [US3] Migrate Git scope and device-setup content to paired getting-started pages
- [X] T039 [US2] Migrate developer and synchronization workflows to paired operations pages
- [X] T040 [US2] Migrate maintenance-command and Homogeneity quick reference to paired operations pages
- [X] T041 [US2] Migrate platform overview and tool setup to paired reference pages
- [X] T042 [US1] Route apprentice guidance to the existing learner documentation entry
- [X] T043 [US1] Migrate Spec Kit workflow guidance to paired getting-started/reference pages
- [X] T044 [US4] Migrate known pitfalls and troubleshooting guidance to paired troubleshooting pages
- [X] T045 [US3] Route security, accessibility, and secure-development material to canonical sources
- [X] T046 [US3] Route generated statistics, manpages, and script inventories to canonical sources
- [X] T047 [US3] Verify no historical or archived evidence file changed

## Phase 5: Source and Home Runtime Orientation

- [X] T048 [US2] Document Level-0 source ownership in German
- [X] T049 [US2] Document Level-0 source ownership in English
- [X] T050 [US2] Define Home Runtime without equating it to the complete home directory
- [X] T051 [US2] Define `homeRuntime`, `sourceOnly`, and `machineLocal`
- [X] T052 [US2] Document canonical edit locations and synchronization triggers
- [X] T053 [US2] Document commit, push, merge, force, host, and container boundaries
- [X] T054 [US2] Link concrete runtime membership to `home-sync-manifest.json`
- [X] T055 [US2] Prove representative classification for each distribution class
- [X] T056 [US2] Prove source/runtime orientation is reachable from both language entries in two links

## Phase 6: Migration Matrix and Link Proof

- [X] T057 [US3] Create `documentation-migration.json` metadata bound to the original README hash
- [X] T058 [US3] Record the root-title and table-of-contents decisions
- [X] T059 [US3] Record workspace overview and template-orientation decisions
- [X] T060 [US3] Record prerequisites and workspace-creation decisions
- [X] T061 [US3] Record Git scope and device-setup decisions
- [X] T062 [US3] Record developer workflow and contents decisions
- [X] T063 [US3] Record Homogeneity and platform decisions
- [X] T064 [US3] Record learner and Spec Kit decisions
- [X] T065 [US3] Record pitfalls and accessibility decisions
- [X] T066 [US3] Add target, anchor, language partner, rationale, proof, and `DIA001` to every row
- [X] T067 [US3] Generate `documentation-migration-report.md`
- [X] T068 [US3] Validate all active internal links and documented replacements
- [X] T069 [US3] Confirm no orphaned active content or unowned normative duplicate
- [X] T070 [US3] Confirm D6 and D7 finding counts remain zero

## Phase 7: Durable Governance

- [X] T071 [US3] Extend `docs/documentation-governance.md` with reader-path and architecture fields
- [X] T072 [US3] Synchronize the normative core in `constitution.md`
- [X] T073 [US3] Synchronize the normative core in `.specify/memory/constitution.md`
- [X] T074 [US3] Update Spec template documentation-impact prompts
- [X] T075 [US3] Update Plan template documentation-impact prompts
- [X] T076 [US3] Update Tasks template documentation-impact prompts
- [X] T077 [US3] Update checklist and PR template surfaces that collect documentation evidence
- [X] T078 [US3] Synchronize `AGENTS.md`
- [X] T079 [US3] Synchronize `CLAUDE.md`
- [X] T080 [US3] Synchronize `GEMINI.md`
- [X] T081 [US3] Synchronize `.github/copilot-instructions.md`
- [X] T082 [US3] Synchronize `.github/agents/copilot-instructions.md`
- [X] T083 [US3] Prove exact shared-guidance parity or documented intentional differences

## Phase 8: Semantic and Deterministic Validation

- [X] T084 Review German-first/English-second semantic parity and CEFR-B2 readability
- [X] T085 Review first-use terminology for learners without Spec Kit knowledge
- [X] T086 Review headings, descriptive links, tables, keyboard use, and text alternatives for WCAG 2.2 AA
- [X] T087 Review every changed command example for platform, prerequisites, side effects, and safe preview
- [X] T088 Run migration contract tests and validator
- [X] T089 Run repository Markdown and internal-link validators discovered for changed paths
- [X] T090 Run `git diff --check`
- [X] T091 Run Homogeneity validation
- [X] T092 Run PowerShell static analysis
- [X] T093 Run secret scanning
- [X] T094 Run `specify check` and Spec Kit preset resolution checks
- [X] T095 Run agent-parity validation
- [X] T096 Run DocFX and Playwright/Axe documentation checks
- [X] T097 Confirm runtime, API, dependency, package, fleet, historical, D6, and D7 scope exclusion

## Phase 9: Evidence, Statistics, and Delivery

- [X] T098 Update `autonomous-run-evidence.md` with every command, result, skipped trigger, and proof boundary
- [X] T099 Update and render `docs/project-statistics.md`
- [ ] T100 Archive the completed D5 intake using the repository workflow
- [ ] T101 Update Pflichtenheft and Series state without starting D6 or D7
- [ ] T102 Validate the successor Series and identify the sole next preferred candidate
- [ ] T103 Complete all tasks and bind final artifact hashes in run state
- [ ] T104 Stage the exact delivery candidate and validate its path inventory and cached diff
- [ ] T105 Commit, push, and create one non-empty Feature-021 PR
- [ ] T106 Converge mandatory provider checks and actionable review threads on the exact head
- [ ] T107 Validate exact-head gate evidence in Bash and PowerShell
- [ ] T108 Merge under repository policy, delete the feature branch, and synchronize local `main`
- [ ] T109 Create one causal evidence closeout only if post-merge facts require it
- [ ] T110 Complete retrospective, final state, clean-worktree proof, and successor lock evidence

## Requirement Mapping

- DAS-001 to DAS-006: T026-T047, T057-T070
- DAS-007 to DAS-010: T071-T083
- DAS-011 to DAS-014: T045-T047, T068, T087
- DAS-015 to DAS-018: T084-T086, T098
- DAS-019 to DAS-020: T097, T109-T110
- DAS-021 to DAS-027: T048-T056, T087
- DAS-028: T001, T057, T070, T097, T110
- AC-DAS-001 to AC-DAS-016: T057-T070, T083-T108
