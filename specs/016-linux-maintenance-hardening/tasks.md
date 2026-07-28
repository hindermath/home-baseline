# Tasks: Linux-/Ubuntu-Härtung der Ein-Kommando-Wartung

**Input**: `specs/016-linux-maintenance-hardening/`  
**Tests**: Test-first für alle LUM-001 bis LUM-011 und AC-001 bis AC-015.  
**Delivery**: `MergeAndSync`; technischer Admin-/Sicherheits-Bypass bleibt
unzulässig.

## Phase 1: Setup and red baseline

**Purpose**: Akzeptierte Artefakte einfrieren und den testbaren Fixture-Rahmen
vor Produktionsänderungen herstellen.

- [X] T001 Validate `specs/016-linux-maintenance-hardening/autonomous-run-state.json`, `autonomous-run-gate-requirements.json` and both files under `checklists/`
- [X] T002 Run and record the unchanged maintenance baseline from `scripts/tests/test_agentic_workspace_maintenance.py`, `scripts/tests/test_maintenance_contracts.py` and `scripts/tests/test_home_sync_files.py`
- [X] T003 Create isolated HOME, PATH, registry, process and report fixture helpers in `scripts/tests/test_linux_maintenance_hardening.py`
- [X] T004 Execute the new fixture suite before product implementation and record the expected red baseline in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`

---

## Phase 2: Foundational Linux contracts

**Purpose**: Gemeinsame sichere Daten-, Prozess- und Fixture-Grenzen
bereitstellen, die alle fünf User Stories benötigen.

**Critical**: Keine User-Story-Implementierung beginnt vor dem roten
TDD-Nachweis aus Phase 1.

- [X] T005 Implement traversal-safe temp paths, bounded process-group execution, evidence sanitization and JSON result serialization in `scripts/lib/linux-maintenance-hardening.py`
- [X] T006 [P] Add schema and platform validation fixtures for the shared CLI registry in `scripts/tests/test_maintenance_contracts.py`
- [X] T007 Add `--cli-registry PATH` and `--allow-admin-prompts` parsing without mutation to `scripts/maintain-agentic-brew-apps.sh`
- [X] T008 Re-run the fixture harness in `scripts/tests/test_linux_maintenance_hardening.py` and preserve only story-specific expected failures

**Checkpoint**: Sichere Grundverträge und rote Story-Nachweise sind vorhanden.

---

## Phase 3: User Story 1 - Vollständige Paketverarbeitung (Priority: P1) 🎯 MVP

**Goal**: Jeder ausgewählte Eintrag wird trotz stdin-lesendem Kindprozess
genau einmal und in Registry-Reihenfolge verarbeitet.

**Independent Test**: Ein Fake-Homebrew liest beim ersten `install` bis EOF;
drei Einträge erhalten trotzdem genau einen geordneten Endstatus und ein
zweiter Lauf startet keine Installation.

### Tests for User Story 1

- [X] T009 [US1] Add failing stdin-consumption, three-item ordering and idempotent-second-run tests to `scripts/tests/test_linux_maintenance_hardening.py`

### Implementation for User Story 1

- [X] T010 [US1] Implement ordered registry snapshots and one `RegistryItemResult` per sequence in `scripts/lib/linux-maintenance-hardening.py`
- [X] T011 [US1] Isolate Homebrew formula and cask iteration descriptors and child stdin in `scripts/maintain-agentic-brew-apps.sh`
- [X] T012 [US1] Apply the same complete per-item accounting to apt, CLI, npm and VS Code loops in `scripts/maintain-agentic-brew-apps.sh`
- [X] T013 [US1] Prove SC-001, SC-002 and SC-009 with the isolated fixtures in `scripts/tests/test_linux_maintenance_hardening.py`

**Checkpoint**: User Story 1 ist unabhängig grün und liefert ein
stdin-sicheres MVP.

---

## Phase 4: User Story 2 - Wahrheitsgetreuer Required-Abschluss (Priority: P1)

**Goal**: Required-Drift bestimmt vollständig und konsistent den Paket- und
Orchestratorabschluss; ausschließlich optionaler Drift bleibt nicht fatal.

**Independent Test**: Leere und nicht leere Required-Mengen, ausschließlich
optionaler Drift und Parent-Aggregation liefern die dokumentierte Exitmatrix.

### Tests for User Story 2

- [X] T014 [US2] Add failing Required-empty, Required-missing, Optional-only and parent-propagation tests to `scripts/tests/test_linux_maintenance_hardening.py`

### Implementation for User Story 2

- [X] T015 [US2] Implement Required/Optional aggregation and canonical package exitcodes in `scripts/lib/linux-maintenance-hardening.py`
- [X] T016 [US2] Return complete Required drift and the canonical non-zero exitcode from `scripts/maintain-agentic-brew-apps.sh`
- [X] T017 [US2] Capture the toolchain child exitcode and preserve it in stage and final status in `scripts/maintain-agentic-workspace.sh`
- [X] T018 [US2] Store the same toolchain result in the atomic JSON report through `scripts/lib/agentic_workspace_fleet.py`
- [X] T019 [US2] Prove SC-003, SC-004 and SC-005 in `scripts/tests/test_linux_maintenance_hardening.py`

**Checkpoint**: User Story 2 ist unabhängig über Paketlauf, Terminal und
Report prüfbar.

---

## Phase 5: User Story 3 - Sichere Swift-Bereitstellung (Priority: P1)

**Goal**: Unterstützte Ubuntu-Profile erhalten Swift über einen offiziellen,
versions- und hashgebundenen, im selben Lauf aktivierten Vertrag.

**Independent Test**: Lokale Archive und Fake-Swiftly simulieren Erfolg,
Hashabweichung, unbekannte Plattform/Architektur, Post-Install-Fehler und
idempotenten Zweitlauf ohne Netzwerk oder Paketmutation.

### Tests for User Story 3

- [X] T020 [US3] Add failing supported-platform, checksum, unsupported-platform, activation and idempotence tests to `scripts/tests/test_linux_maintenance_hardening.py`

### Implementation for User Story 3

- [X] T021 [US3] Add Swiftly `1.1.2`, Swift `6.3.3`, the Ubuntu 22.04/24.04 platform matrix, architecture URLs and reviewed SHA-256 values to `scripts/config/required-cli-tools-registry.json`
- [X] T022 [US3] Implement fail-closed Ubuntu/os-release, architecture and Swift contract resolution in `scripts/lib/linux-maintenance-hardening.py`
- [X] T023 [US3] Implement verified download, extraction and unattended profile-safe Swiftly bootstrap in `scripts/maintain-agentic-brew-apps.sh`
- [X] T024 [US3] Implement authorized post-install, current-shell environment activation and same-run Swift probe in `scripts/maintain-agentic-brew-apps.sh`
- [X] T025 [US3] Prove SC-006, SC-007 and SC-008 in `scripts/tests/test_linux_maintenance_hardening.py`

**Checkpoint**: User Story 3 ist ohne reale Swift-Installation unabhängig
prüfbar.

---

## Phase 6: User Story 4 - Privilegiengrenze und nutzbare CLI (Priority: P1)

**Goal**: Admin-Autorität, tatsächliche Mutation und CLI-Nutzbarkeit bleiben
getrennte, begrenzte und wahrheitsgetreue Zustände.

**Independent Test**: Ohne Autorität wird kein Fake-sudo gestartet; defekte,
Capability-gesperrte und hängende Launcher erhalten getrennte Status.

### Tests for User Story 4

- [X] T026 [US4] Add failing no-admin, Unusable, TimedOut, CapabilityBlocked and sanitized-evidence tests to `scripts/tests/test_linux_maintenance_hardening.py`

### Implementation for User Story 4

- [X] T027 [US4] Implement bounded process-group probes and status classification in `scripts/lib/linux-maintenance-hardening.py`
- [X] T028 [US4] Replace presence-only CLI checks with structured bounded probes in `scripts/maintain-agentic-brew-apps.sh`
- [X] T029 [US4] Bound and classify the Unix PowerShell-module launcher path in `scripts/maintain-agentic-brew-apps.sh`
- [X] T030 [US4] Forward current admin-prompt authority and preserve `DEFERRED_ADMIN_REQUIRED` plus remaining Required drift in `scripts/maintain-agentic-workspace.sh`
- [X] T031 [US4] Prove SC-012, SC-013 and SC-014 in `scripts/tests/test_linux_maintenance_hardening.py`

**Checkpoint**: User Story 4 ist unabhängig ohne `sudo` oder hängende
Prozesse prüfbar.

---

## Phase 7: User Story 5 - Abbruchfester, barrierefreier Abschluss (Priority: P1)

**Goal**: Erfolg, später Fehler, `INT` und `TERM` erzeugen genau eine atomare,
run-korrelierte Wahrheit in Terminal, Log, Report und Prozessstatus.

**Independent Test**: Ein Prozess-Harness erzwingt späten Fehler und beide
Signale nach erfolgreichen Stufen und prüft letzten Stage-Namen, Signal,
Exitcode, nächste Aktion und fehlende Teil-JSON-Dateien.

### Tests for User Story 5

- [X] T032 [US5] Add failing late-error, stale-success, INT, TERM and exactly-once finalization tests to `scripts/tests/test_linux_maintenance_hardening.py`

### Implementation for User Story 5

- [X] T033 [US5] Add idempotent atomic run-finalization support to `scripts/lib/agentic_workspace_fleet.py`
- [X] T034 [US5] Track the current stage and install separate EXIT/INT/TERM finalization paths in `scripts/maintain-agentic-workspace.sh`
- [X] T035 [US5] Reconcile final terminal text, log text, report status and process exitcode in `scripts/maintain-agentic-workspace.sh`
- [X] T036 [US5] Prove SC-015 and the linear text-first status contract in `scripts/tests/test_linux_maintenance_hardening.py`

**Checkpoint**: Alle fünf User Stories funktionieren und bleiben einzeln
regressionsprüfbar.

---

## Phase 8: Polish, governance and cross-platform evidence

**Purpose**: Dokumentation, Parität, Sicherheit, Statistik und lokale
Lieferkandidatenprüfung schließen.

- [X] T037 [P] Update bilingual CLI help and exit/status matrices in `scripts/maintain-agentic-brew-apps.sh` and `scripts/maintain-agentic-workspace.sh`
- [X] T038 [P] Update DE-first/EN-second operational guidance in `docs/man/maintain-agentic-brew-apps.1.md`, `docs/man/maintain-agentic-workspace.1.md` and `README.md`
- [X] T039 Register the new helper in `scripts/config/script-catalog.json` and update runtime propagation/package declarations in `scripts/config/agentic-toolchain-maintenance-files.json` plus matching propagation scripts if required
- [X] T040 Regenerate and verify the canonical script inventory under `docs/scripts/` with `scripts/render-script-reference.ps1`
- [X] T041 [P] Review Bash/PowerShell shared registry and status parity in `scripts/maintain-agentic-winget-apps.ps1`, `scripts/maintain-agentic-workspace.ps1` and `scripts/tests/test_windows_maintenance_hardening.py`; record `N/A` where behavior is Linux-only
- [X] T042 [P] Review text-first A11Y, DE-first/EN-second CEFR-B2 wording and didactic comments in all changed user-facing files and record the result in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T043 Record secure-coding, architecture, NIST SSDF, CWE, CAPEC, SAMM, OpenSSF and explicit N/A dispositions in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T044 Create the exact Documentation Impact decisions in `specs/016-linux-maintenance-hardening/documentation-impact-evidence.json` and sanitized terminal/report examples in `specs/016-linux-maintenance-hardening/sanitized-report-examples.json`
- [X] T045 Review `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` and `.github/agents/copilot-instructions.md`; record the no-new-rule disposition in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T046 Run focused and existing test suites, Bash syntax, JSON validation and applicable PowerShell/PSScriptAnalyzer gates and record results in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T047 Run package- and profile-mutation-free compare-only, check-only and dry-run validation from `specs/016-linux-maintenance-hardening/quickstart.md` and reconcile allowed fetch/log/report writes in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T048 Render the new milestone and current Profile 2 block in `docs/project-statistics.md` from `docs/project-statistics.config.json`
- [X] T049 Run Documentation Impact, diff, secret, generated-reference, statistics and Homogeneity gates and record results in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [X] T050 Reconcile all LUM/AC coverage, completed tasks, Analyze findings and autonomous hashes in `specs/016-linux-maintenance-hardening/tasks.md` and `specs/016-linux-maintenance-hardening/autonomous-run-state.json`
- [X] T051 Archive the completed intake with `scripts/rename-lastenheft.sh` from `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md` to the branch-stamped Level-0 filename

---

## Phase 9: Validate, deliver and close out

**Purpose**: Den exakten Kandidaten reviewen, mit der autorisierten
MergeAndSync-Grenze liefern und die Serie genau einmal fortschreiben.

- [X] T052 Stage only intended paths and validate the exact candidate against `specs/016-linux-maintenance-hardening/autonomous-run-gate-requirements.json`
- [X] T053 Commit the reviewed candidate with required co-author trailer and push branch `016-linux-maintenance-hardening`
- [X] T054 Open the feature pull request and record its URL/head in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [ ] T055 Converge all Ubuntu, macOS and Windows checks plus actionable review threads for the exact PR head and write temporary provider-neutral gate evidence from `specs/016-linux-maintenance-hardening/autonomous-run-gate-requirements.json`
- [ ] T056 Merge only the converged exact head with the authorized repository admin bypass and record the merge result in `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md`
- [ ] T057 Delete the feature branch, fast-forward local `main`, prove equality with `origin/main` and sync Home Runtime through `scripts/sync-home.sh`
- [ ] T058 Execute the manifest-declared post-merge intake archive/series advancement and fresh review for `requirements/intakes/series/home-baseline-delivery/manifest.json` without starting the next feature
- [ ] T059 Complete `specs/016-linux-maintenance-hardening/retrospective.md`, final autonomous state and the final Level-0 Git fetch/pull/commit/push inventory

## Dependencies and execution order

- Phase 1 precedes all production edits.
- Phase 2 depends on Phase 1 and blocks every user story.
- US1 is the first vertical slice and MVP.
- US2 depends on US1 result accounting.
- US3 depends on US2 fail-closed aggregation.
- US4 reuses the probe and admin contracts introduced by US2/US3.
- US5 integrates the terminal states produced by US1-US4.
- Phase 8 depends on all five stories. T037/T038, T041/T042 and selected
  evidence reviews may run in parallel because they touch different files.
- Phase 9 starts only after Analyze, all local gates and the exact staged
  candidate are green. T058 is post-merge and idempotent.

## Parallel opportunities

- T006 can run independently of T005/T007 after the red baseline.
- Documentation T037/T038 and parity/A11Y reviews T041/T042 can proceed in
  parallel after behavior has stabilized.
- Security/evidence disposition T043-T045 can be reviewed in parallel, but
  final writes to `autonomous-run-evidence.md` must be serialized.
- User stories share the same Bash and helper files and therefore execute
  sequentially despite each having an independent fixture.

## Independent test criteria

- **US1**: stdin-consuming first installer cannot hide entries; each result is
  unique, ordered and idempotent.
- **US2**: Required missing is exit `1`, Optional-only is non-fatal, and parent
  report/process status agree.
- **US3**: supported fixture installs and activates Swift; unsupported
  platform, bad hash and install failure stop safely.
- **US4**: no authority means no privileged invocation; defunct,
  capability-blocked and timed-out launchers remain distinguishable.
- **US5**: normal, late-error, `INT` and `TERM` paths finalize exactly once and
  leave no stale success or partial JSON.

## Requirement coverage

- LUM-001/002 and AC-001/002/009: T009-T013.
- LUM-003/004 and AC-003/004/005: T014-T019.
- LUM-005/006/007/008 and AC-006/007/008: T020-T025.
- LUM-009/010 and AC-012/013/014: T026-T031.
- LUM-011 and AC-015: T032-T036.
- AC-010/011 plus cross-platform, security, A11Y, documentation and statistics:
  T037-T050.
- MergeAndSync, Exact-Head-Evidence, series closeout and final inventory:
  T051-T059.

## Implementation strategy

1. Phase 1/2 establishes the red proof and shared safe boundary.
2. Deliver US1 as the smallest vertical slice and validate it independently.
3. Add US2-US5 sequentially, rerunning earlier story fixtures after each slice.
4. Complete cross-cutting evidence only after behavior stabilizes.
5. Merge only the exact reviewed head, synchronize `main` and Home Runtime,
   advance the intake series, and stop before any successor feature.
