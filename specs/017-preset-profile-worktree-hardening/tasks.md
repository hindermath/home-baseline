# Tasks: Preset-Profil-, Default-Branch- und Worktree-Härtung

**Input**: `specs/017-preset-profile-worktree-hardening/`
**Tests**: Test-first für PWH-001 bis PWH-020 und AC-001 bis AC-027.
**Delivery**: `MergeAndSync` nur für Feature 017; Ziel-Repositories bleiben
ohne Commit-, Push-, PR- oder Merge-Autorität.

## Phase 1: Setup and red baseline

**Purpose**: Akzeptierte Artefakte einfrieren, bestehende Regressionen
beweisen und neue Sicherheitsanforderungen vor Produktionsänderungen rot
nachweisen.

- [X] T001 Validate `specs/017-preset-profile-worktree-hardening/autonomous-run-state.json`, `autonomous-run-gate-requirements.json` and every file under `checklists/`
- [X] T002 Record binding intake, receipt, Series request/result and manifest hashes in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T003 Run the unchanged baseline from `scripts/tests/test_agentic_workspace_maintenance.py`, `scripts/tests/test_maintenance_contracts.py`, `scripts/tests/test_windows_maintenance_hardening.py` and `scripts/tests/test_linux_maintenance_hardening.py`
- [X] T004 Add isolated multi-repository, bare-remote, operation-log and state-hash fixture helpers to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T005 Add failing Dirty-before-Fetch, early-failure-continuation and mutation-before-barrier tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T006 Add failing `trunk`, remote symbolic-HEAD, missing-HEAD, ambiguity and commit-mismatch tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T007 Execute the new fixtures before product implementation and record the expected red baseline in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`

---

## Phase 2: Foundational fleet and evidence contracts

**Purpose**: Gemeinsame sichere Daten-, Netzwerk-, Report- und
Operationsverträge bereitstellen.

**Critical**: Keine Story-Implementierung beginnt vor dem roten Nachweis aus
Phase 1.

- [X] T008 Extend network-attempt fixtures for duration, timeout, retry count, silent failure and sanitized evidence in `scripts/tests/test_maintenance_contracts.py`
- [X] T009 Add `NetworkAttempt`, `DefaultBranchEvidence` and ordered operation fields to `scripts/lib/agentic_workspace_fleet.py`
- [X] T010 Record fetch and pull duration, final status, retry count and next action in `scripts/lib/agentic_workspace_fleet.py`
- [X] T011 Add fleet expected/completed Git-target counts and separate Collection counts to `scripts/lib/agentic_workspace_fleet.py`
- [X] T012 Add a persisted `MutationBarrier` result that cannot pass with incomplete targets or failed freshness in `scripts/lib/agentic_workspace_fleet.py`
- [X] T013 Preserve atomic report replacement and Features 015/016 finalization semantics in `scripts/lib/agentic_workspace_fleet.py`
- [X] T014 Update report-schema and cardinality assertions in `scripts/tests/test_maintenance_contracts.py`
- [X] T015 Re-run foundational tests and leave only story-specific expected failures in `scripts/tests/test_agentic_workspace_maintenance.py`

**Checkpoint**: Gemeinsame Evidence kann alle Ziel- und Netzwerkoperationen
vollständig und atomar abbilden.

---

## Phase 3: User Story 1 - Vollständige Remote-Freshness-Barriere (Priority: P1)

**Goal**: Level 0 und jedes aktive Git-Ziel werden vor jeder Domainmutation
gefetcht; die Collection bleibt getrennt und ein Einzelbefund beendet die
weitere Inventur nicht.

**Independent Test**: Ein Mehr-Repository-Fixture belegt alle Fetches vor
Home-Sync/Registry/Propagation/Toolchain und sperrt diese Phasen bei einem
Pflichtbefund.

### Tests for User Story 1

- [X] T016 [US1] Add failing exact-cardinality tests for Level 0, 43 manifest Git targets and one separate Collection in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T017 [US1] Add failing operation-order tests that prohibit Home Sync, registry, propagation, preset repair and toolchain before the complete barrier in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T018 [US1] Add failing first-target-error tests that still require every later read-only inventory result in `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T019 [US1] Add failing CheckOnly/Preview tests that permit control evidence and fetch but prohibit pull and domain mutation in `scripts/tests/test_agentic_workspace_maintenance.py`

### Implementation for User Story 1

- [X] T020 [US1] Refactor `classify_repository` in `scripts/lib/agentic_workspace_fleet.py` so safe fetch precedes dirty, branch, upstream and divergence classification
- [X] T021 [US1] Include Level 0 in the same fleet freshness execution and report contract in `scripts/lib/agentic_workspace_fleet.py`
- [X] T022 [US1] Continue all active target inspections after individual blocking findings in `scripts/lib/agentic_workspace_fleet.py`
- [X] T023 [US1] Move Bash Home Sync and all later domain stages behind the completed fleet barrier in `scripts/maintain-agentic-workspace.sh`
- [X] T024 [US1] Move PowerShell Home Sync and all later domain stages behind the completed fleet barrier in `scripts/maintain-agentic-workspace.ps1`
- [X] T025 [US1] Preserve control-only lock, log and atomic report creation before the barrier in both `scripts/maintain-agentic-workspace.sh` and `scripts/maintain-agentic-workspace.ps1`
- [X] T026 [US1] Emit ordered target and barrier status with exact next actions from both orchestrators and `scripts/lib/agentic_workspace_fleet.py`
- [X] T027 [US1] Prove AC-013, AC-016, AC-018, AC-020 and AC-021 in `scripts/tests/test_agentic_workspace_maintenance.py`

**Checkpoint**: User Story 1 ist als vollständige, fail-closed
Flottenbarriere unabhängig grün.

---

## Phase 4: User Story 2 - Sichere Branch- und Pull-Entscheidung (Priority: P1)

**Goal**: Default-Branches werden ohne Namensraten aufgelöst und nur sichere
Behind-only-Zustände per Fast-forward aktualisiert.

**Independent Test**: Die Branch-/Pull-Matrix unterscheidet Current, Behind,
Dirty, Ahead, Diverged, Detached, Branch-Mismatch, Missing-Upstream,
Remote-Mismatch und Remote-HEAD-Fehler ohne unzulässige Checkout-Mutation.

### Tests for User Story 2

- [X] T028 [US2] Add failing local-symbolic-HEAD and remote-`ls-remote --symref` resolution tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T029 [US2] Add failing remote-HEAD absence, ambiguity, stale tracking-ref and commit-mismatch tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T030 [US2] Add failing safe-pull conjunction and all blocked state-matrix tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T031 [US2] Add dirty-worktree pre/post index, tracked-file and status-hash assertions to `scripts/tests/test_agentic_workspace_maintenance.py`

### Implementation for User Story 2

- [X] T032 [US2] Implement local-then-remote symbolic HEAD resolution without `main`/`master` guessing in `scripts/lib/agentic_workspace_fleet.py`
- [X] T033 [US2] Bind resolved symbolic ref, tracking ref and exact post-fetch commit in `scripts/lib/agentic_workspace_fleet.py`
- [X] T034 [US2] Require clean canonical branch, matching upstream, `ahead=0` and `behind>0` before `pull --ff-only` in `scripts/lib/agentic_workspace_fleet.py`
- [X] T035 [US2] Replace Bash fallback branch heuristics with the shared evidence result in `scripts/maintain-agentic-workspace.sh`
- [X] T036 [US2] Replace PowerShell fallback branch heuristics with the shared evidence result in `scripts/maintain-agentic-workspace.ps1`
- [X] T037 [US2] Prove AC-001 through AC-003, AC-014, AC-015 and AC-019 in `scripts/tests/test_agentic_workspace_maintenance.py`

**Checkpoint**: User Story 2 aktualisiert nur beweisbar sichere
Fast-forward-Ziele.

---

## Phase 5: User Story 3 - Eigentumsgebundene Worktree-Wiederherstellung (Priority: P1)

**Goal**: Eigene temporäre Preset-Worktrees werden normal und nach Hard Abort
gezielt bereinigt; fremde oder mehrdeutige Evidence bleibt unangetastet.

**Independent Test**: Lease-Fixtures unterscheiden normal, orphaned, active,
PID-reused, foreign, tampered, escaped und already-released.

### Tests for User Story 3

- [X] T038 [US3] Add failing lease schema, atomic-write, path-containment and Git-registration tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T039 [US3] Add failing normal-release, simulated-hard-abort and idempotent-second-run tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T040 [US3] Add failing active-owner, PID-reuse, foreign-repository, tampered-path and escaped-state tests to `scripts/tests/test_agentic_workspace_maintenance.py`
- [X] T041 [US3] Add a failing state-transition fixture that reveals a new untracked path and invalidates stale cleanup authority in `scripts/tests/test_agentic_workspace_maintenance.py`

### Implementation for User Story 3

- [X] T042 [US3] Implement atomic `WorktreeLease` creation, validation and classification in `scripts/lib/agentic_workspace_fleet.py`
- [X] T043 [US3] Implement startup recovery for only owned, consistent and provably orphaned leases in `scripts/lib/agentic_workspace_fleet.py`
- [X] T044 [US3] Integrate lease creation and normal release with Bash preset validation in `scripts/maintain-agentic-workspace.sh`
- [X] T045 [US3] Integrate the same lease lifecycle with PowerShell preset validation in `scripts/maintain-agentic-workspace.ps1`
- [X] T046 [US3] Re-inventory exact cleanup candidates after relevant state changes in `scripts/lib/agentic_workspace_fleet.py`
- [X] T047 [US3] Prove AC-004 through AC-006, AC-022 and AC-023 in `scripts/tests/test_agentic_workspace_maintenance.py`

**Checkpoint**: User Story 3 beseitigt ausschließlich nachweislich eigene
verwaiste Ressourcen.

---

## Phase 6: User Story 4 - Dynamische Profile und ehrliche Registry-Befunde (Priority: P1)

**Goal**: Profile skalieren datengetrieben und Registry-Widersprüche bleiben
sichtbare, nicht mutierende Governance-Entscheidungen.

**Independent Test**: Das reale Elf-Preset-Profil und eine synthetische
Erweiterung bestehen; MSL-Konflikte werden gemeldet, akzeptierte Werte und
Registry-Hash bleiben unverändert.

### Tests for User Story 4

- [X] T048 [US4] Add real-eleven and synthetic-extended profile tests to `scripts/tests/test_maintenance_contracts.py`
- [X] T049 [US4] Add contradictory and accepted MSL/non-MSL registry fixtures with byte-hash assertions to `scripts/tests/test_maintenance_contracts.py`
- [X] T050 [US4] Add target-repository no-commit/no-push/no-PR/no-merge command-spy assertions to `scripts/tests/test_agentic_workspace_maintenance.py`

### Implementation for User Story 4

- [X] T051 [US4] Remove any fixed preset-count assumption from Bash and PowerShell profile summaries in `scripts/maintain-agentic-workspace.sh` and `scripts/maintain-agentic-workspace.ps1`
- [X] T052 [US4] Resolve profile IDs and count only from `scripts/config/spec-kit-preset-profiles.json` and referenced matrices
- [X] T053 [US4] Add non-mutating language/MSL consistency findings to the registry command in `scripts/lib/agentic_workspace_fleet.py`
- [X] T054 [US4] Emit profile and Registry findings with owner-facing next actions from both orchestrators
- [X] T055 [US4] Prove AC-008 through AC-010, AC-024 and the target-repository boundary in the maintenance test suites

**Checkpoint**: User Story 4 akzeptiert Profilerweiterungen ohne Codeänderung
und verändert keine kuratierte Registry.

---

## Phase 7: User Story 5 - Plattformgleiche und zugängliche Evidence (Priority: P1)

**Goal**: macOS, Linux und Windows liefern dieselben semantischen Ergebnisse
und verständliche, textorientierte Evidence.

**Independent Test**: Gemeinsame Fixtures, Parser, Analyzer und CI-Runner
bestätigen Status-/Exit-Parität, Regressionserhalt und bilinguale Ausgabe.

### Tests for User Story 5

- [X] T056 [US5] Extend Windows semantic behavior fixtures for freshness, pull, barrier and lease outcomes in `scripts/tests/test_windows_maintenance_hardening.py`
- [X] T057 [US5] Extend Linux/macOS regression fixtures for the shared barrier without changing package behavior in `scripts/tests/test_linux_maintenance_hardening.py`
- [X] T058 [US5] Add cross-shell status-class and exitcode comparison assertions to `scripts/tests/test_maintenance_contracts.py`

### Implementation for User Story 5

- [X] T059 [US5] Align Bash and PowerShell status names, next actions and report fields in both maintenance orchestrators
- [X] T060 [US5] Preserve approved `Verb-Noun` PowerShell functions and complete bilingual comment-based help in `scripts/maintain-agentic-workspace.ps1`
- [X] T061 [US5] Update bilingual Bash usage and first-use term explanations in `scripts/maintain-agentic-workspace.sh`
- [X] T062 [US5] Sanitize publishable report examples and private paths in `scripts/lib/agentic_workspace_fleet.py`
- [X] T063 [US5] Prove AC-007, AC-011, AC-012, AC-017, AC-025 and AC-026 across all maintenance test suites
- [X] T064 [US5] Record platform parity, A11Y and learner-language evidence in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`

**Checkpoint**: Alle fünf User Stories sind einzeln und gemeinsam
regressionsprüfbar.

---

## Phase 8: Polish, governance and local validation

**Purpose**: Dokumentation, Sicherheit, Agentenparität, Statistik und den
lokalen Lieferkandidaten schließen.

- [X] T065 Update DE-first/EN-second Freshness, branch, pull, lease, timeout and target-write guidance in `docs/man/maintain-agentic-workspace.1.md`
- [X] T066 Update the maintenance script inventory source and affected generated references under `docs/scripts/`
- [X] T067 Update operator documentation for the Freshness barrier and safe modes in `README.md` or record an exact `NoUpdateRequired` rationale in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T068 Create Documentation Impact decisions in `specs/017-preset-profile-worktree-hardening/documentation-impact-evidence.json`
- [X] T069 Create sanitized fleet, barrier, lease and profile report examples in `specs/017-preset-profile-worktree-hardening/sanitized-report-examples.json`
- [X] T070 Record NIST SSDF, CWE, STRIDE/CIA/CAPEC, SAMM, architecture and every explicit N/A disposition in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T071 Review `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` and `.github/agents/copilot-instructions.md` together and record the parity decision in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T072 Run all maintenance Python tests and record counts/results in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T073 Run Bash syntax, PowerShell parser, PSScriptAnalyzer and JSON validation and record results in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [X] T074 Run `--check-only`, `--dry-run`, `-CheckOnly` and `-WhatIf` in isolated fixtures and record permitted control/fetch effects and prohibited mutations
- [ ] T075 Run Documentation Impact, generated-reference, Homogeneity, diff and secret gates and record results in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [ ] T076 Render the Feature 017 milestone and Profile 2 block in `docs/project-statistics.md` from `docs/project-statistics.config.json`
- [X] T077 Reconcile PWH-001 through PWH-020, AC-001 through AC-027, all Analyze findings and all gate requirements in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [ ] T078 Archive the completed intake with `scripts/rename-lastenheft.sh` to `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.017-preset-profile-worktree-hardening.md`
- [ ] T079 Re-run the complete local acceptance suite after the archived intake and statistics update

---

## Phase 9: Validate, deliver and close out

**Purpose**: Exakten Kandidaten liefern, Reviews konvergieren und die Serie
ohne Start von Position 4 kausal fortschreiben.

- [ ] T080 Stage only intended paths and validate the exact candidate against `specs/017-preset-profile-worktree-hardening/autonomous-run-gate-requirements.json`
- [ ] T081 Align all autonomous hashes and task counts in `specs/017-preset-profile-worktree-hardening/autonomous-run-state.json`
- [ ] T082 Commit the reviewed candidate with required co-author trailer and push branch `017-preset-profile-worktree-hardening`
- [ ] T083 Open a non-empty feature pull request and record URL and exact head in `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md`
- [ ] T084 Converge Ubuntu, macOS and Windows checks plus actionable review threads for the exact PR head and validate temporary provider-neutral gate evidence
- [ ] T085 Merge only the converged exact head, using the authorized narrow admin bypass solely for a remaining Human Approval rule
- [ ] T086 Delete the feature branch, fast-forward local `main`, prove `HEAD == origin/main` and synchronize Home Runtime if runtime-distributed files changed
- [ ] T087 Execute the manifest-declared intake archive and Series advancement through a causal closeout PR only if required, without starting Position 4
- [ ] T088 Complete `specs/017-preset-profile-worktree-hardening/retrospective.md` with `NoPromotion` or a reproducible provider-neutral PresetFollowUp
- [ ] T089 Validate final autonomous state, exact Series status, clean `(0 0)` main and the final Level-0 Git inventory

## Dependencies and execution order

- Phase 1 precedes every production edit.
- Phase 2 depends on the red baseline and blocks all user stories.
- US1 establishes the global barrier used by every later story.
- US2 depends on US1 freshness evidence.
- US3 depends on US2 exact Repository/Ref identity.
- US4 depends on US1 target enumeration but not on lease mutation; it remains
  sequential because it edits the same core and report files.
- US5 integrates all prior status and report contracts.
- Phase 8 starts only after all stories are green.
- Phase 9 starts only after repeated Analyze converges and all local gates pass.
- T087 is post-merge, idempotent and must not start the successor.

## Parallel opportunities

- T008 and the story-specific red tests can be prepared in separate files, but
  writes to `test_agentic_workspace_maintenance.py` remain serialized.
- T065-T067 may be reviewed independently after behavior stabilizes.
- T070 and T071 are independent reviews, but writes to shared autonomous
  Evidence are serialized.
- Provider jobs may execute in parallel; gate evaluation and merge remain
  serialized against one exact head.

## Independent test criteria

- **US1**: Every Git target gets a bounded fetch before domain mutation; the
  Collection is separate and early failure does not suppress later inventory.
- **US2**: Arbitrary symbolic default branches resolve without guessing; only
  clean, canonical, behind-only state fast-forwards.
- **US3**: Only owned, consistent, orphaned leases are removed once; all
  ambiguous or foreign evidence remains.
- **US4**: Real and extended profiles resolve without code changes; MSL
  conflicts are visible without Registry mutation or target provider writes.
- **US5**: Bash and PowerShell status, barrier, recovery and exit semantics
  agree and remain accessible without visual-only cues.

## Requirement coverage

- PWH-001/002/012/014/015/019 and AC-013/016/018/020/021/026: T008-T027.
- PWH-003/004/013 and AC-001/002/003/014/015/019: T028-T037.
- PWH-005/006/007/018 and AC-004/005/006/022/023: T038-T047.
- PWH-009/010/016/020 and AC-008/009/010/024: T048-T055.
- PWH-008/011/017 and AC-007/011/012/017/025: T056-T064.
- Governance, documentation, security, A11Y, statistics and full coverage:
  T065-T079.
- Exact-head invalidation AC-027, MergeAndSync and post-merge Series closeout:
  T080-T089.

## Implementation strategy

1. Establish red safety and sequencing evidence.
2. Implement the global fleet barrier as the first vertical slice.
3. Add branch/pull identity, then lease recovery, then profile/registry checks.
4. Close cross-platform semantics and all inherited regressions.
5. Complete documentation and governance after behavior stabilizes.
6. Merge only the exact reviewed head, perform any required causal closeout,
   synchronize `main`, and stop before Position 4.
