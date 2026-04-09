# Tasks: Git-Konfiguration Scope-Isolierung / Git Configuration Scope Isolation

**Feature Branch**: `003-git-config-scope`
**Input**: Design documents from `/specs/003-git-config-scope/`
**Prerequisites**: plan.md ✅ | spec.md ✅ | research.md ✅ | data-model.md ✅ | contracts/ ✅ | quickstart.md ✅

**Tests**: Keine automatisierten Tests — manuelle Verifikation via `--dry-run` / `-WhatIf` per Constitution Principle V. Keine Test-Tasks in dieser Liste.

**Organization**: Tasks gruppiert nach User Story für unabhängige Implementierung und Verifikation.

## Format: `[ID] [P?] [Story?] Description`

- **[P]**: Parallel ausführbar (unterschiedliche Dateien, keine Abhängigkeit von laufenden Tasks)
- **[US?]**: Zuordnung zur User Story aus spec.md
- Exakte Dateipfade in allen Beschreibungen

---

## Phase 1: Setup — Vorbereitende Lektüre / Pre-read

**Purpose**: Alle zu ändernden Dateien lesen, um den Ist-Stand zu verstehen bevor Änderungen vorgenommen werden. Pflicht — Edit/Write-Werkzeuge schlagen fehl wenn eine Datei nicht zuerst gelesen wurde.

- [ ] T001 Read `.gitconfig` (repo root) to understand current global settings structure before modification
- [ ] T002 [P] Read `scripts/sync-home.sh` and `scripts/sync-home.ps1` to understand current file-copy logic before adding `~/.gitconfig.d/` bootstrap block
- [ ] T003 [P] Read `scripts/bootstrap-workspace.sh` and `scripts/bootstrap-workspace.ps1` to understand current bootstrap sequence before adding scope isolation step
- [ ] T004 [P] Read `scripts/hooks/pre-push`, `scripts/check-homogeneity.sh`, `scripts/check-homogeneity.ps1`, `scripts/bootstrap-project.sh`, `scripts/bootstrap-project.ps1` to understand current state before modification

---

## Phase 2: Foundational — `.gitconfig` Template Update

**Purpose**: Die trackte `~/.gitconfig`-Vorlage auf globale Defaults + `[includeIf]` reduzieren. Dieser Schritt ist **Voraussetzung für alle User Stories** — ohne ihn ist kein `[includeIf]`-Block für home-baseline-tmp vorhanden.

**⚠️ CRITICAL**: Alle User-Story-Phasen setzen diesen Schritt voraus.

**Implements**: FR-001, FR-002, FR-003

- [ ] T005 Update `.gitconfig` (repo root): strip any workspace-specific settings outside global scope; add `[includeIf "gitdir:~/home-baseline-tmp/"]` block pointing to `~/.gitconfig.d/home-baseline.inc`. Allowed global keys after change: `[user]` name+email, `[init]` defaultBranch, `[core]` autocrlf, `[pull]` rebase. Reference: data-model.md §Global Git Config, contracts/script-contracts.md §.gitconfig Template.

**Checkpoint**: `.gitconfig` enthält `[includeIf]` für home-baseline-tmp — Foundation ready.

---

## Phase 3: US1 + US3 (P1/P2) — Per-Workspace Git Identity + sync-home Preservation

**Goal (US1)**: Workspace-spezifische Git-Einstellungen gelten ausschließlich innerhalb des Workspace-Verzeichnisses. Globale Einstellungen bleiben in `~/.gitconfig`. `~/.gitconfig.d/home-baseline.inc` als Einstiegspunkt für Overrides.

**Goal (US3)**: `sync-home` erstellt `~/.gitconfig.d/` beim ersten Lauf; bei bestehendem Verzeichnis bleibt der Inhalt unberührt (keine Datenverlust-Gefahr bei wiederholten Syncs).

**Independent Test (US1)**: `mkdir -p ~/.gitconfig.d/ && printf '[user]\n  email = work@test.com\n' > ~/.gitconfig.d/home-baseline.inc` → `git -C ~/home-baseline-tmp config user.email` → `work@test.com`; `git -C ~/MyProjects config user.email` → globaler Default (nicht `work@test.com`).

**Independent Test (US3)**: `echo 'custom' > ~/.gitconfig.d/custom.inc` → `bash scripts/sync-home.sh --no-pull` → `cat ~/.gitconfig.d/custom.inc` → `custom` (unverändert); zweiter Lauf → keine neuen Dateien, kein Fehler.

### Implementation for US1 + US3

- [ ] T006 [P] [US1] Add `~/.gitconfig.d/` bootstrap block to `scripts/sync-home.sh`: after file-copy step, check if `~/.gitconfig.d/` exists at `$HOME`; if absent: `mkdir -p "$HOME/.gitconfig.d/"` and write `home-baseline.inc` placeholder (content from research.md R-006 — commented `[user]` block); if present: print bilingual skip message. All output bilingual DE/EN (NFR-001). Reference: contracts/script-contracts.md §sync-home.
- [ ] T007 [P] [US1] Add same `~/.gitconfig.d/` bootstrap block to `scripts/sync-home.ps1`: identical logic using `$homeDir = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home path (see CLAUDE.md §Windows HOME pitfall); bilingual output (NFR-001). Reference: contracts/script-contracts.md §sync-home, research.md R-006.
- [ ] T008 [P] [US1] Extend `scripts/hooks/pre-push` to scan `~/.gitconfig.d/` for credential patterns: add new scan block after existing tracked-file scan using exact pattern from research.md R-005 with `"$secret_content_regex"` (same variable, no new regex). Bilingual error message: `"HIGH: Secret-Muster in ~/.gitconfig.d/ gefunden / Secret patterns found in ~/.gitconfig.d/:"`. Bash-only file — no .ps1 counterpart needed (git hooks are sh on all platforms). Reference: contracts/script-contracts.md §pre-push, plan.md §Phase 1C.

**Checkpoint**: US1 + US3 implementierbar und testbar. `sync-home --dry-run` verifiziert Erstellung; zweiter Lauf verifiziert Idempotenz (SC-003). Hook blockiert bei Credential-Muster (SC-008).

---

## Phase 4: US2 (P2) — New Workspace Gets Local Git Settings

**Goal**: `bootstrap-workspace` fügt beim Erstellen eines neuen Workspace idempotent einen `[includeIf]`-Block zu `~/.gitconfig` hinzu und legt eine `.inc`-Platzhalterdatei an. Workspace-spezifische git-Einstellungen (`core.autocrlf`) landen im lokalen `.git/config`, nicht im globalen Config.

**Independent Test (US2)**: `bash scripts/bootstrap-workspace.sh --dry-run TestWorkspace` → Output zeigt `[includeIf]`-Eintrag und `.inc`-Erstellung; zweiter Aufruf → kein Duplikat-Eintrag. `git -C ~/TestWorkspace config --local core.autocrlf` → `input` (macOS/Linux).

**Implements**: FR-004, FR-005, FR-012

### Implementation for US2

- [ ] T009 [P] [US2] Add scope isolation step to `scripts/bootstrap-workspace.sh`: (1) `normalize_name()` function (research.md R-003 Bash implementation); (2) `git config --local core.autocrlf input` in new workspace repo (FR-004); (3) if `~/.gitconfig.d/` exists: idempotency check via `grep -qF "gitdir:${HOME}/${workspace_name}/"` (research.md R-002), if absent: append `[includeIf]` block with forward-slash path (research.md R-004), create `.inc` placeholder if not present; (4) if `~/.gitconfig.d/` absent: bilingual skip message; (5) all output bilingual DE/EN (NFR-001). Expected output format from contracts/script-contracts.md §bootstrap-workspace.
- [ ] T010 [P] [US2] Add same scope isolation step to `scripts/bootstrap-workspace.ps1`: `ConvertTo-NormalizedName` function (research.md R-003 PowerShell implementation); `$homeDir = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home path; `$path -replace '\\', '/'` for forward-slash normalization (research.md R-004); `core.autocrlf = true` on Windows (FR-004 platform variant); idempotency check and all logic mirroring .sh variant. Reference: contracts/script-contracts.md §bootstrap-workspace, plan.md §Phase 1B.

**Checkpoint**: US2 implementierbar und testbar. `--dry-run TestWorkspace` zweimal ausführen → exakt ein `[includeIf]`-Eintrag, SC-002 erfüllt.

---

## Phase 5: US5 (P4) — Homogeneity Check Warns on Missing Scope Isolation

**Goal**: `check-homogeneity` gibt eine nicht-fatale WARN-Meldung aus, wenn `~/.gitconfig.d/` fehlt (GIT-SCOPE-001) oder kein `[includeIf]`-Eintrag für home-baseline-tmp in `~/.gitconfig` vorhanden ist (GIT-SCOPE-002). Compliance-Score wird nicht reduziert.

**Independent Test (US5)**: `rm -rf ~/.gitconfig.d/` → `bash scripts/check-homogeneity.sh` → Output enthält `WARN`-Zeile, Exit-Code 0. `bash scripts/check-homogeneity.sh --json` → JSON enthält `"status": "WARN"` für `GIT-SCOPE-001`.

**Implements**: FR-009, SC-005

### Implementation for US5

- [ ] T011 [US5] Create `scripts/lib/hg-git-scope.sh` (new file — pattern from existing `scripts/lib/hg-*.sh`): implement `hg_check_git_scope()` function with GIT-SCOPE-001 check (`~/.gitconfig.d/` exists) and GIT-SCOPE-002 check (`[includeIf]` for home-baseline-tmp present); severity WARN (does NOT increment fail counter, does NOT affect exit code); bilingual messages; JSON output support when `--json` flag active. Reference: research.md R-007, contracts/script-contracts.md §check-homogeneity.
- [ ] T012 [US5] Integrate `hg-git-scope.sh` into `scripts/check-homogeneity.sh`: source `scripts/lib/hg-git-scope.sh`; call `hg_check_git_scope`; ensure WARN output is visible in standard and JSON modes; WARN does NOT increment existing FAIL counter. Reference: contracts/script-contracts.md §check-homogeneity GIT-SCOPE-001/002.
- [ ] T013 [P] [US5] Add GIT-SCOPE-001 and GIT-SCOPE-002 checks to `scripts/check-homogeneity.ps1` (paired with T012, PowerShell equivalent logic): `$homeDir` fallback for Windows HOME; same WARN severity and bilingual messages; JSON output block mirroring Bash. Reference: contracts/script-contracts.md §check-homogeneity.

**Note**: T011 must complete before T012 can source the new lib file. T012 and T013 can run in parallel.

**Checkpoint**: US5 implementierbar und testbar. WARN emittiert bei fehlendem `~/.gitconfig.d/`, Exit-Code bleibt 0 (SC-005).

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: NFR-001 für `bootstrap-project`, README-Dokumentation, Sicherheits-Scan (Constitution Principle I MANDATORY), finale Verifikation.

- [ ] T014 [P] Add bilingual output to `scripts/bootstrap-project.sh` for existing `git config --local` step (NFR-001 only — FR-006 logic already implemented per research.md R-009). Add DE/EN message alongside existing step, e.g. `Lokale git-Einstellungen gesetzt / Local git settings applied`.
- [ ] T015 [P] Add bilingual output to `scripts/bootstrap-project.ps1` for existing `git config --local` step (paired with T014, same NFR-001 requirement, same R-009 context).
- [ ] T016 Add `## Git Scope-Isolierung / Git Scope Isolation` section to `README.md` after `## Workspace-Einrichtung / Workspace Setup` section (FR-010): bilingual heading (WCAG 2.4.6); explain `includeIf` mechanism; list global vs. workspace-specific settings; show user.email override example; reference `~/.gitconfig.d/` and `.inc` format; add TOC entry under `##` headings (2-level TOC convention); all code blocks with language tags (WCAG 4.1.1).
- [ ] T017 **⚠️ MANDATORY (Constitution Principle I)**: Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` from repo root; confirm output shows `high=0`; record output to include verbatim in PR description.
- [ ] T018 [P] Verify `~/.gitconfig.d/` remains untracked: run `git -C ~/home-baseline-tmp ls-files ~/.gitconfig.d/`; confirm empty output (constraint from plan.md §Technical Context).
- [ ] T019 Run end-to-end verification per quickstart.md: `bash scripts/sync-home.sh --dry-run`; `bash scripts/bootstrap-workspace.sh --dry-run TestWorkspace` (run twice → no duplicate `[includeIf]`); `bash scripts/check-homogeneity.sh` with and without `~/.gitconfig.d/`; confirm all outputs are bilingual (NFR-001).

**Checkpoint**: Alle Phasen abgeschlossen. PR kann erstellt werden.

---

## User Story 4 (P3) — Out of Scope

**US4**: Workspace Teardown Cleans Up Git Config — `teardown-workspace.sh/.ps1` existiert noch nicht. Implementierung erfolgt in separatem Feature (`Lastenheft_Workspace_Teardown.md`). Keine Tasks in dieser Liste. Nutzer-Mitigation bis dahin: quickstart.md §„Bekannte Lücken bis teardown-workspace".

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Keine Abhängigkeiten — alle T001–T004 können sofort starten
- **Foundational (Phase 2)**: Depends on Phase 1 completion (T005 requires T001 to have read `.gitconfig`)
- **Phase 3 (US1+US3)**: Depends on Phase 2 (T005 must complete — `.gitconfig` must have correct structure) — T006, T007, T008 can then run in parallel
- **Phase 4 (US2)**: Depends on Phase 2 (T005 must complete) — T009, T010 can then run in parallel, independent of Phase 3
- **Phase 5 (US5)**: Depends on Phase 2 — T011 must complete before T012; T012 and T013 can run in parallel
- **Polish (Phase 6)**: T014/T015/T016 independent; T017 should run after T008 committed; T019 should run after T006/T009 committed

### User Story Dependencies

- **US1+US3 (Phase 3)**: Can start after Foundational (Phase 2). Independent of US2, US5.
- **US2 (Phase 4)**: Can start after Foundational (Phase 2). Independent of US1/US3, US5.
- **US5 (Phase 5)**: Can start after Foundational (Phase 2). Independent of US1/US3, US2.
- **US4**: Out of scope — no dependency.

### Within Each Phase

- Read before write (Phase 1 before Phase 2)
- `.gitconfig` template (T005) before any script additions
- New lib file (T011) before integration (T012)
- Implementation before scanner verification (T008 before T017)

### Parallel Opportunities

```text
Phase 1:   T001 ‖ T002 ‖ T003 ‖ T004         (all read-only, different files)
Phase 3:   T006 ‖ T007 ‖ T008                 (different files: .sh, .ps1, pre-push)
Phase 4:   T009 ‖ T010                         (different files: .sh, .ps1)
Phase 5:   T012 ‖ T013  (after T011 complete)  (different files: .sh, .ps1)
Phase 6:   T014 ‖ T015 ‖ T016 ‖ T018          (different files)
```

---

## Parallel Example: US2 (Phase 4)

```text
# After T005 (Foundational) completes, launch both variants simultaneously:

Task T009: "Add scope isolation step to scripts/bootstrap-workspace.sh"
  → normalize_name(), idempotency check, includeIf append, .inc creation, git config --local

Task T010: "Add scope isolation step to scripts/bootstrap-workspace.ps1"
  → ConvertTo-NormalizedName, $homeDir fallback, $path -replace, same logic PS1 syntax
```

---

## Implementation Strategy

### MVP First (US1 only — Per-Workspace Git Identity)

1. Complete Phase 1: Setup (T001–T004)
2. Complete Phase 2: Foundational — `.gitconfig` template (T005)
3. Complete Phase 3 US1 only: sync-home + pre-push hook (T006, T007, T008)
4. **STOP and VALIDATE**: Run US1 Independent Test (git config --show-origin in workspace vs. outside)
5. Run scanner T017 (Constitution Principle I gate)

### Incremental Delivery

1. Phase 1 + 2 → Foundation ready
2. Phase 3 (T006–T008) → US1+US3: sync-home + security hook working
3. Phase 4 (T009–T010) → US2: bootstrap-workspace scope isolation working
4. Phase 5 (T011–T013) → US5: check-homogeneity WARN working
5. Phase 6 (T014–T019) → Polish + MANDATORY scanner run

### Commit Strategy

- Commit after each phase completion
- Phase 3 commit MUST include T017 scanner output in commit message or be in PR description
- Phase 2 (`.gitconfig` template) can be a standalone commit (visible tracked-file change)

---

## Notes

- [P] = unterschiedliche Dateien, keine Abhängigkeit von laufenden Tasks
- [US?] = Rückverfolgung zur User Story aus spec.md
- Keine automatisierten Tests — manuelle Verifikation per `--dry-run` / `-WhatIf`
- T017 (Scanner) ist **verbindliches Gate** (Constitution Principle I) — MUSS vor PR-Erstellung laufen
- Alle neuen Benutzerausgaben MÜSSEN bilingual DE/EN sein (NFR-001)
- Windows-Powershell: HOME-Pfad immer über `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` (CLAUDE.md)
- `.gitconfig.d/` darf nie in die Whitelist-gitignore aufgenommen werden
