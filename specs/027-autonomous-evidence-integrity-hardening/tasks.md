# Tasks: Autonomous Evidence Integrity Hardening

## Phase 1 - Foundation

- [x] T001 Validate accepted intake, single review, series status, branch, and authority.
- [x] T002 Create `pr-evidence.md` before implementation edits.
- [x] T003 Create reviewed `autonomous-gate-requirements.json` before implementation edits.
- [x] T004 Record candidate-only release and rollout prohibitions in evidence.
- [x] T005 Inventory canonical and publication preset files and current parity.
- [x] T006 Record current command, script, template, and skill cardinalities.

## Phase 2 - Delivery-Set Test First

- [x] T007 Add a failing tracked-change delivery fixture.
- [x] T008 Add a failing intended-untracked whitespace fixture.
- [x] T009 Add ignored runtime-evidence and unrelated-untracked fixtures.
- [x] T010 Add missing, duplicate, absolute, escape, directory, and symlink fixtures.
- [x] T011 Add index/worktree immutability assertions.
- [x] T012 Implement the provider-neutral delivery-set validation core.
- [x] T013 Add the Bash delivery-set entrypoint and help.
- [x] T014 Add the PowerShell delivery-set entrypoint and help.
- [x] T015 Prove Bash/PowerShell status and exit-code parity.
- [x] T016 Add the delivery-set manpage and README/runbook guidance.

## Phase 3 - Phase-Result Test First

- [x] T017 Add complete structured phase-result fixture.
- [x] T018 Add exit-zero plus `Blocked` and incomplete-task fixtures.
- [x] T019 Add missing, empty, truncated, malformed, wrong-phase, and wrong-hash fixtures.
- [x] T020 Add CRLF, LF, and UTF-8 BOM normalization fixtures.
- [x] T021 Define the phase-result schema and template.
- [x] T022 Implement semantic phase-result validation in PowerShell.
- [x] T023 Extend the routed-phase wrapper with `NeedsRevalidation` before launch.
- [x] T024 Require semantic completion before persisting `Completed`.
- [x] T025 Preserve trustworthy completed evidence during Resume.
- [x] T026 Update fixture runner and model-routing tests.
- [x] T027 Prove existing routing and state-validator regressions.

## Phase 4 - Lifecycle Evidence Test First

- [x] T028 Add valid PreMerge and PostMerge schema-2.0 fixtures.
- [x] T029 Add premature merge-claim and wrong-head fixtures.
- [x] T030 Add wrong requirements, pre-merge hash, and merge-commit fixtures.
- [x] T031 Add mutated earlier evidence and non-empty post-merge delta fixtures.
- [x] T032 Add historical schema-1.0 audit-only fixtures.
- [x] T033 Upgrade the gate-evidence template to schema 2.0.
- [x] T034 Implement Bash lifecycle validation.
- [x] T035 Implement PowerShell lifecycle validation.
- [x] T036 Add explicit historical-mode compatibility.
- [x] T037 Prove Bash/PowerShell lifecycle error parity.
- [x] T038 Update gate manpage, authority, evidence, lifecycle, and recovery docs.

## Phase 5 - Candidate Synchronization

- [x] T039 Set canonical candidate version to 0.4.0.
- [x] T040 Update preset metadata inventories for new scripts/templates.
- [x] T041 Update README, getting-started, compatibility, and field-validation docs.
- [x] T042 Update runbook, readiness checklist, plan/tasks/spec addenda, and agent addendum.
- [x] T043 Confirm no new command and exactly five autonomous commands remain.
- [x] T044 Synchronize canonical changes to the publication copy.
- [x] T045 Prove canonical/publication byte parity.
- [x] T046 Confirm no maintained repository agent surface needs a shared-policy update.

## Phase 6 - Validation

- [x] T047 Run all new delivery-set tests in Bash and PowerShell.
- [x] T048 Run all new phase-result tests in Bash and PowerShell.
- [x] T049 Run all gate-evidence tests in Bash and PowerShell.
- [x] T050 Run existing autonomous state and model-routing regression suites.
- [x] T051 Run Bash syntax and PSScriptAnalyzer.
- [x] T052 Run homogeneity, secret, diff, UTF-8, and line-ending checks.
- [x] T053 Validate all installed presets and command/skill uniqueness in a temporary project.
- [x] T054 Validate the explicit intended delivery set before staging.
- [x] T055 Confirm no tag, release, ZIP, catalog, consumer, or fleet action exists.

## Phase 7 - Delivery and Retrospective

- [x] T056 Update `docs/project-statistics.md` and render the canonical statistics block.
- [x] T057 Complete `pr-evidence.md`, task counts, and candidate boundary.
- [x] T058 Create `retrospective.md` with promotion decision deferred to G2B.
- [x] T059 Validate the exact staged delivery set and commit Feature 027.
- [x] T060 Push and create a non-empty feature PR.
- [ ] T061 Generate and validate temporary schema-2.0 PreMerge exact-head evidence.
- [ ] T062 Converge technical checks and actionable review threads.
- [ ] T063 Merge under current bounded authority and delete the feature branch.
- [ ] T064 Synchronize local `main` and prove clean `(0 0)`.
- [ ] T065 Record G2A closeout without starting G2B or releasing the candidate.

## Dependencies

T001-T006 precede all implementation. Each test-first group precedes its
implementation. Shared preset and evidence files are serialized. T047-T055
precede delivery. T061 is generated only for the exact pushed head. T065 is the
terminal task and grants no G2B execution authority.
