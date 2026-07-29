# Tasks: Agentic-Workspace-Wartungs-TUI

**Input**: `specs/018-agentic-workspace-tui/`
**Tests**: Test-first for all five user stories, 35 functional requirements,
22 intake acceptance criteria and Feature 015-017 regressions
**Delivery**: `MergeAndSync` for Feature 018 only; maintenance targets receive
no commit, push, PR, merge, provider, cleanup or administrator authority

## Phase 1: Setup and accepted baseline

**Purpose**: Freeze accepted evidence, establish the project skeleton and prove
the unchanged maintenance baseline before production edits.

- [X] T001 Validate both state validators against `specs/018-agentic-workspace-tui/autonomous-run-state.json`
- [X] T002 Validate intake review and series evidence in Bash and PowerShell and record results in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T003 Validate all completed feature checklists under `specs/018-agentic-workspace-tui/checklists/`
- [X] T004 Run the unchanged Python maintenance suites under `scripts/tests/` and record the baseline count in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T005 Create `scripts/lib/maintenance-tui/NuGet.config` with the verified package source
- [X] T006 Create `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj` targeting `net10.0`
- [X] T007 Create `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj` with pinned test dependencies
- [X] T008 Restore both projects and commit generated `packages.lock.json` files under `scripts/lib/maintenance-tui/`
- [X] T009 Add project output, temporary build and cache exclusions to `.gitignore`
- [X] T010 Add a failing vertical-slice test for default Dry-run selection in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/SelectionTests.cs`
- [X] T011 Add a failing fake-engine success test in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Integration/VerticalSliceTests.cs`
- [X] T012 Record the expected red tests before production implementation in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

---

## Phase 2: Foundational contracts and adapters

**Purpose**: Implement shared typed contracts required by every user story.

**Critical**: No broad presentation or wrapper change starts before the red
vertical slice is recorded.

- [X] T013 Create invocation and UI-mode models in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Contracts/InvocationContext.cs`
- [X] T014 Create maintenance selection and validation models in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Contracts/MaintenanceSelection.cs`
- [X] T015 Create event and phase/status models in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Contracts/MaintenanceEvent.cs`
- [X] T016 Create report and reconciled-result models in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Contracts/RunResult.cs`
- [X] T017 Create cache descriptor and platform identifier models in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Contracts/UiBuildDescriptor.cs`
- [X] T018 Implement typed process-argument construction in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/MaintenanceCommandBuilder.cs`
- [X] T019 Implement strict JSONL record parsing in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/MaintenanceEventReader.cs`
- [X] T020 Implement report/event/process reconciliation in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/RunResultReconciler.cs`
- [X] T021 Implement terminal and environment facts in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/TerminalContext.cs`
- [X] T022 Implement deterministic source fingerprint and platform normalization in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/UiBuildCache.cs`
- [X] T023 Implement the process-runner abstraction and fake boundary in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/MaintenanceProcessRunner.cs`
- [X] T024 Implement shared textual status projection in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/MaintenanceStatusView.cs`
- [X] T025 Implement the minimal application coordinator in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Application/MaintenanceTuiApplication.cs`
- [X] T026 Add the executable entry point in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Program.cs`
- [X] T027 Make the two vertical-slice tests green and record the result in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: One safe Dry-run selection can start one fake engine, consume
one valid event sequence and return one reconciled result.

---

## Phase 3: User Story 1 - Sicherer interaktiver Einstieg (Priority: P1)

**Goal**: Route interactive, non-interactive, explicit and unsupported-terminal
invocations without changing the existing unattended contract.

**Independent Test**: Terminal and wrapper fixtures prove each route and safe
fallback without executing real maintenance.

### Tests for User Story 1

- [X] T028 [US1] Add terminal input/output and explicit-mode routing tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/InvocationRoutingTests.cs`
- [X] T029 [US1] Add TERM=dumb, NO_COLOR and unsupported-capability tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/TerminalCapabilityTests.cs`
- [X] T030 [US1] Add Bash no-argument TTY/non-TTY and selector fixtures in `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T031 [US1] Add PowerShell no-argument TTY/non-TTY and selector fixtures in `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T032 [US1] Execute the US1 tests red and record exact failures in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

### Implementation for User Story 1

- [X] T033 [US1] Implement UI-selector parsing and internal headless recursion guard in `scripts/maintain-agentic-workspace.sh`
- [X] T034 [US1] Implement equivalent `-Tui`, `-PlainUi`, `-NoTui` parsing and internal headless guard in `scripts/maintain-agentic-workspace.ps1`
- [X] T035 [US1] Implement enhanced/plain/headless routing in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Application/InvocationRouter.cs`
- [X] T036 [US1] Implement the Bash TTY and terminal-capability decision before engine initialization in `scripts/maintain-agentic-workspace.sh`
- [X] T037 [US1] Implement the PowerShell TTY and terminal-capability decision before engine initialization in `scripts/maintain-agentic-workspace.ps1`
- [X] T038 [US1] Preserve every existing argument path as headless in `scripts/maintain-agentic-workspace.sh` and `scripts/maintain-agentic-workspace.ps1`
- [X] T039 [US1] Add visible enhanced-to-plain fallback reasons in `scripts/maintain-agentic-workspace.sh` and `scripts/maintain-agentic-workspace.ps1`
- [X] T040 [US1] Make all US1 fixtures green in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/` and `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T041 [US1] Record AC-01 through AC-03 and fallback proof in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: Interactive no-argument use is safe while unattended and
parameterized automation remains compatible.

---

## Phase 4: User Story 2 - Nachvollziehbare und sichere Moduswahl (Priority: P1)

**Goal**: Offer only engine-valid choices, show an explanatory command and
default every real mutation to No.

**Independent Test**: Console and wrapper tests cover every allowed and rejected
combination plus cancellation before engine start.

### Tests for User Story 2

- [X] T042 [US2] Add mode-combination matrix tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/SelectionTests.cs`
- [X] T043 [US2] Add default-No and cancellation tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/ConfirmationTests.cs`
- [X] T044 [US2] Add typed argument and explanatory command escaping tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/CommandBuilderTests.cs`
- [X] T045 [US2] Add Bash/PowerShell plain-assistant parity fixtures in `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T046 [US2] Execute the US2 tests red and record exact failures in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

### Implementation for User Story 2

- [X] T047 [US2] Implement selection validation and disabled-option reasons in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Application/MaintenanceSelectionValidator.cs`
- [X] T048 [US2] Implement Spectre prompts with Dry-run selected in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/EnhancedMaintenancePrompt.cs`
- [X] T049 [US2] Implement default-No mutation confirmation in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/EnhancedMaintenancePrompt.cs`
- [X] T050 [US2] Implement line-oriented Bash fallback selection and confirmation in `scripts/maintain-agentic-workspace.sh`
- [X] T051 [US2] Implement line-oriented PowerShell fallback selection and confirmation in `scripts/maintain-agentic-workspace.ps1`
- [X] T052 [US2] Render the escaped equivalent Bash or PowerShell command without executing it in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/CommandSummaryView.cs`
- [X] T053 [US2] Map pre-start cancellation to exit `130` without report or maintenance mutation in all presentation paths
- [X] T054 [US2] Make all US2 fixtures green in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/` and `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T055 [US2] Prove the wrappers reject every forbidden UI/maintenance option combination with exit `2`
- [X] T056 [US2] Record AC-04 through AC-06 and authority-boundary proof in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: Every selectable mode is valid, understandable and safely
confirmed before one engine invocation.

---

## Phase 5: User Story 3 - Ehrlicher Live- und Abschlussstatus (Priority: P1)

**Goal**: Present structured live state, degrade safely on malformed events and
reconcile every terminal result without implicit retry.

**Independent Test**: A deterministic fake engine covers all event, report,
exit, partial, mismatch and cancellation boundaries.

### Tests for User Story 3

- [X] T057 [US3] Add JSON-schema and strict event model tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/MaintenanceEventTests.cs`
- [X] T058 [US3] Add incomplete-line, invalid-JSON, sequence-gap, schema and run-ID tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/EventReaderTests.cs`
- [X] T059 [US3] Add success, warnings, PARTIAL/1, BLOCKED, exit 2, exit 3 and exit 130 fake-engine cases in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Integration/FakeEngineTests.cs`
- [X] T060 [US3] Add missing/non-finalized report and `RESULT_MISMATCH` cases in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/RunResultReconcilerTests.cs`
- [X] T061 [US3] Add slow-output and first/second cancellation cases in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Integration/CancellationTests.cs`
- [X] T062 [US3] Add engine event-parameter and append-only record fixtures in `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T063 [US3] Execute the US3 tests red and record exact failures in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

### Implementation for User Story 3

- [X] T064 [US3] Add validated event emission support to `scripts/lib/agentic_workspace_fleet.py`
- [X] T065 [US3] Add `--event-stream` phase/start/finding/completion emission to `scripts/maintain-agentic-workspace.sh`
- [X] T066 [US3] Add `-EventStream` phase/start/finding/completion emission to `scripts/maintain-agentic-workspace.ps1`
- [X] T067 [US3] Complete JSONL tailing and permanent degraded-mode behavior in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/MaintenanceEventReader.cs`
- [X] T068 [US3] Implement bounded live-state projection in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/LiveMaintenanceView.cs`
- [X] T069 [US3] Implement full final report/event/process reconciliation in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/RunResultReconciler.cs`
- [X] T070 [US3] Implement exactly-once controlled interrupt forwarding in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/MaintenanceProcessRunner.cs`
- [X] T071 [US3] Prevent any UI fallback from starting a second engine after process start in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Application/MaintenanceTuiApplication.cs`
- [X] T072 [US3] Make all US3 fixtures green in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/` and `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T073 [US3] Validate `specs/018-agentic-workspace-tui/contracts/maintenance-event-v1.schema.json` against positive and negative fixtures
- [X] T074 [US3] Record AC-07 through AC-09 and AC-15/16 in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: Live presentation is useful but never overrides canonical
engine completion.

---

## Phase 6: User Story 4 - Plattformgleiche Verfuegbarkeit und Fallbacks (Priority: P1)

**Goal**: Reuse exact cached builds or safely fall back before engine start on
all supported platforms.

**Independent Test**: Fingerprint, platform, atomic cache and failure fixtures
prove no stale or partial build runs.

### Tests for User Story 4

- [X] T075 [US4] Add source-order, content-change and lock-change fingerprint tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/UiBuildCacheTests.cs`
- [X] T076 [US4] Add all six normalized platform-ID tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Contracts/UiBuildCacheTests.cs`
- [X] T077 [US4] Add complete-hit, partial-cache, corrupt-cache and atomic-publication tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Integration/CacheIntegrationTests.cs`
- [X] T078 [US4] Add missing SDK, offline restore, build failure and non-writable cache fixtures in `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T079 [US4] Execute the US4 tests red and record exact failures in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

### Implementation for User Story 4

- [X] T080 [US4] Complete deterministic fingerprint and platform normalization in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Infrastructure/UiBuildCache.cs`
- [X] T081 [US4] Implement cache lookup, temporary locked build and atomic publish in `scripts/maintain-agentic-workspace.sh`
- [X] T082 [US4] Implement equivalent cache lookup, temporary locked build and atomic publish in `scripts/maintain-agentic-workspace.ps1`
- [X] T083 [US4] Reject partial, foreign-platform and stale-fingerprint cache entries in `scripts/maintain-agentic-workspace.sh` and `scripts/maintain-agentic-workspace.ps1`
- [X] T084 [US4] Ensure generated binaries and temporary cache output remain excluded through `.gitignore`
- [X] T085 [US4] Make all US4 fixtures green in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/` and `scripts/tests/test_maintenance_tui_wrappers.py`
- [X] T086 [US4] Prove `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/packages.lock.json` and `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/packages.lock.json` remain unchanged under locked restore
- [X] T087 [US4] Run package inventory and vulnerability checks for `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj` and `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj`
- [X] T088 [US4] Record AC-10, license, source, package and fallback evidence in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: Enhanced UI availability is deterministic and never a
prerequisite for safe maintenance access.

---

## Phase 7: User Story 5 - Barrierearme Wartung fuer Lernende und Maintainer (Priority: P1)

**Goal**: Make every selection, status, warning and next action usable by
keyboard and text-oriented assistive technology.

**Independent Test**: Stable snapshots cover enhanced, compact, linear,
NO_COLOR, TERM=dumb and all status classes.

### Tests for User Story 5

- [X] T089 [US5] Add keyboard-flow and focus-text tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/AccessibilityTests.cs`
- [X] T090 [US5] Add NO_COLOR and ASCII-status snapshots in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/AccessibilityTests.cs`
- [X] T091 [US5] Add narrow and linear reading-order snapshots in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/AccessibilityTests.cs`
- [X] T092 [US5] Add markup-injection path and message cases in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/MarkupEscapingTests.cs`
- [X] T093 [US5] Add DE-first/EN-second and required first-use term tests in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/LanguageTests.cs`
- [X] T094 [US5] Execute the US5 tests red and record exact failures in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

### Implementation for User Story 5

- [X] T095 [US5] Complete one canonical textual status projection in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/MaintenanceStatusView.cs`
- [X] T096 [US5] Implement enhanced, compact and linear layout selection in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/LiveMaintenanceView.cs`
- [X] T097 [US5] Enforce maximum 10-Hz updates and no invented percentage in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/LiveMaintenanceView.cs`
- [X] T098 [US5] Escape all foreign text through Spectre markup utilities in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/MarkupText.cs`
- [X] T099 [US5] Add bilingual CEFR-B2 labels and first-use explanations in `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/Messages.cs`
- [X] T100 [US5] Keep final status, paths and next actions copyable in every mode through `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/MaintenanceStatusView.cs` and `scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/Presentation/LiveMaintenanceView.cs`
- [X] T101 [US5] Make all US5 console and snapshot tests green in `scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/Console/`
- [X] T102 [US5] Complete the WCAG 2.2 AA applicability review in `docs/accessibility/maintenance-tui.md`
- [X] T103 [US5] Record AC-11 and text-first evidence in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`

**Checkpoint**: All five stories are independently testable and share one
safe textual state model.

---

## Phase 8: Governance, documentation and local acceptance

**Purpose**: Close security, architecture, documentation, parity and exact
local candidate evidence.

- [X] T104 Update TUI invocation, defaults, fallback and authority guidance in `README.md`
- [X] T105 Update full bilingual command/help details in `docs/man/maintain-agentic-workspace.1.md`
- [X] T106 Update script inventory and links in `docs/scripts/reference.md`, classify the runtime through `scripts/config/script-catalog.json`, confirm Home Runtime inclusion through `scripts/config/home-sync-manifest.json`, and add every distributed TUI source, test and lock file to `scripts/config/agentic-toolchain-maintenance-files.json`
- [X] T107 Create runtime/build/test architecture guidance in `docs/architecture/maintenance-tui.md`
- [X] T108 Update STRIDE/CIA/CAPEC boundaries in `docs/security/threat-model.md`
- [X] T109 Add the TUI boundary S-ADR under `docs/security/adr/`
- [X] T110 Update `docs/security/arc42-security.md` and `docs/security/security-quality-scenarios.md`
- [X] T111 Update package inventory, license, vulnerability, SBOM and VEX disposition in `docs/security/dependency-audit.md` and `docs/security/supply-chain-evidence.md`
- [X] T112 Update applicable NIST SSDF/CWE/SAMM and explicit N/A decisions in `docs/security/security-checklist.md`, `docs/security/samm-assessment.md` and feature evidence
- [X] T113 Create exactly one `UpdateRequired` record in `specs/018-agentic-workspace-tui/documentation-impact-evidence.json`
- [X] T114 Review all maintained agent surfaces together and record `NoUpdateRequired` or update them atomically in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T115 Add exact macOS/Ubuntu/Windows restore/build/test jobs to `.github/workflows/maintenance-tui.yml`
- [X] T116 Run locked restore, build and TUI tests locally and record results in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T117 Run all Python maintenance regressions in `scripts/tests/`, Bash syntax for affected `scripts/*.sh`, and PSScriptAnalyzer for affected `scripts/*.ps1`, recording results in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T118 Run `scripts/check-homogeneity.sh`, `scripts/scan-agent-secrets.sh`, Git diff checks, JSON parsing and `specify check`, recording results in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T119 Reconcile FR-001–FR-035, SC-001–SC-012, AC-01–AC-22 and every gate in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T120 Render the Feature 018 milestone in `docs/project-statistics.md` through `docs/project-statistics.config.json`
- [X] T121 Prepare the exact post-merge archive and Series-closeout mapping for `Lastenheft_Agentic-Workspace-Maintenance-TUI.md` in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md` without changing the active Series before feature merge
- [X] T122 Re-run the complete local acceptance suite after documentation and statistics updates, and draft `specs/018-agentic-workspace-tui/retrospective.md` for exact-head review

---

## Phase 9: Exact-head delivery and closeout

**Purpose**: Deliver one reviewed candidate, converge provider evidence, merge
and return to synchronized main without starting a successor.

- [X] T123 Stage only intended paths and reconcile staged, unstaged and untracked inventory in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T124 Run `git diff --cached --check` and every affected validator against the exact staged candidate
- [X] T125 Finalize task counts, accepted artifact hashes and gate-requirements hash in `specs/018-agentic-workspace-tui/autonomous-run-state.json`
- [X] T126 Commit the reviewed candidate and push branch `018-agentic-workspace-tui`
- [X] T127 Create a non-empty pull request and record URL and exact head in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T128 Converge all mandatory checks and actionable review threads for the exact PR head and record them in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T129 Generate `.git/spec-kit-autonomous/018-gate-evidence.json` and validate it with `.specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.sh` and `.specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.ps1`
- [X] T130 Merge the exact reviewed head, using the narrow admin bypass only if Human Approval is the sole open rule, and record the merge in `specs/018-agentic-workspace-tui/autonomous-run-evidence.md`
- [X] T131 Delete the remote feature branch, switch locally to `main`, fetch/prune and fast-forward pull
- [X] T132 Complete a genuinely required causal closeout for `Lastenheft_Agentic-Workspace-Maintenance-TUI.md`, `requirements/intakes/series/home-baseline-delivery/manifest.json`, its Schema-1.1 review evidence, `specs/018-agentic-workspace-tui/retrospective.md` and `specs/018-agentic-workspace-tui/autonomous-run-state.json` without starting the successor feature
- [X] T133 Validate final `specs/018-agentic-workspace-tui/retrospective.md` and `specs/018-agentic-workspace-tui/autonomous-run-state.json`, prove clean `(0 0)`, and run `scripts/sync-home.sh --check-only` plus `scripts/sync-home.sh --no-pull` when `scripts/config/home-sync-manifest.json` classifies changed files as Home Runtime

## Dependencies and execution order

- Phase 1 precedes all production edits.
- Phase 2 blocks every user-story implementation.
- US1 establishes routing used by US2–US5.
- US2 establishes the typed selection passed to US3.
- US3 establishes the live/result contract consumed by US5.
- US4 can be reasoned about independently but remains serialized because it
  edits both wrappers and the same application startup.
- US5 integrates all prior states into the accessible presentation.
- Phase 8 starts only after all story tests are green.
- Phase 9 starts only after repeated Analyze has no Critical/High finding and
  all local acceptance gates pass.

## Parallel opportunities

- The first failing tests in distinct .NET files may be authored independently,
  but production application and wrapper writes remain serialized.
- Security, architecture and accessibility documentation can be reviewed in
  parallel after behavior stabilizes; writes to autonomous evidence and
  statistics remain serialized.
- Provider jobs run in parallel by platform, while evidence evaluation and
  merge remain serialized against one exact head.

## Independent test criteria

- **US1**: TTY/non-TTY, explicit Enhanced/Plain/Headless and fallback routes
  select exactly one path without changing existing automation.
- **US2**: Every valid choice creates one typed argument vector; every invalid
  choice exits 2; real mutation defaults No; pre-start cancellation exits 130.
- **US3**: Valid live events display; malformed events degrade; report/process
  mismatch is visible; no engine is retried.
- **US4**: Only exact complete cache entries run; every unavailable prerequisite
  falls back before engine start.
- **US5**: Keyboard, NO_COLOR, TERM=dumb, narrow/linear and screenreader-oriented
  snapshots preserve all information in DE-first/EN-second ASCII text.

## Requirement coverage

- FR-001–FR-005, AC-01–AC-03: T028–T041.
- FR-006–FR-010, AC-04–AC-06: T042–T056.
- FR-011–FR-017, FR-030–FR-032, AC-07–AC-09, AC-15–AC-16: T057–T074.
- FR-018–FR-021, AC-10, AC-12: T075–T088 and T115–T117.
- FR-022–FR-026, AC-11: T089–T103.
- FR-027–FR-029, FR-033–FR-035, AC-13–AC-14, AC-17–AC-22:
  T104–T122.
- MergeAndSync and exact-head acceptance: T123–T133.

## Implementation strategy

1. Freeze evidence and make one representative slice fail.
2. Implement the typed foundation and make the slice green.
3. Deliver routing, selection, event/result, cache/fallback and A11Y stories in
   order, preserving an independently runnable test boundary after each.
4. Close documentation and governance only after behavior stabilizes.
5. Deliver and merge only the exact reviewed head.
6. Synchronize `main`, complete retrospective evidence and stop without
   starting the next intake.
