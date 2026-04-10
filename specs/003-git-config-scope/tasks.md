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

- [x] T001 Read `.gitconfig` (repo root) to understand current global settings structure before modification
- [x] T002 [P] Read `scripts/sync-home.sh` and `scripts/sync-home.ps1` to understand current file-copy logic before adding `~/.gitconfig.d/` bootstrap block
- [x] T003 [P] Read `scripts/bootstrap-workspace.sh` and `scripts/bootstrap-workspace.ps1` to understand current bootstrap sequence before adding scope isolation step
- [x] T004 [P] Read `scripts/hooks/pre-push`, `scripts/check-homogeneity.sh`, `scripts/check-homogeneity.ps1`, `scripts/bootstrap-project.sh`, `scripts/bootstrap-project.ps1` to understand current state before modification

---

## Phase 2: Foundational — `.gitconfig` Template Update

**Purpose**: Die trackte `~/.gitconfig`-Vorlage auf globale Defaults + `[includeIf]` reduzieren. Dieser Schritt ist **Voraussetzung für alle User Stories** — ohne ihn ist kein `[includeIf]`-Block für home-baseline-tmp vorhanden.

**⚠️ CRITICAL**: Alle User-Story-Phasen setzen diesen Schritt voraus.

**Implements**: FR-001, FR-002, FR-003

- [x] T005 Update `.gitconfig` (repo root): strip any workspace-specific settings outside global scope; add `[includeIf "gitdir:~/home-baseline-tmp/"]` block (tilde `~` format — consistent with all other includeIf entries) pointing to `~/.gitconfig.d/home-baseline.inc`. Allowed global keys after change: `[user]` name+email, `[init]` defaultBranch, `[core]` autocrlf, `[pull]` rebase. Reference: data-model.md §Global Git Config, contracts/script-contracts.md §.gitconfig Template.

**Checkpoint**: `.gitconfig` enthält `[includeIf "gitdir:~/home-baseline-tmp/"]` — Foundation ready.

---

## Phase 3: US1 + US3 (P1/P2) — Per-Workspace Git Identity + sync-home Preservation

**Goal (US1)**: Workspace-spezifische Git-Einstellungen gelten ausschließlich innerhalb des Workspace-Verzeichnisses. Globale Einstellungen bleiben in `~/.gitconfig`. `~/.gitconfig.d/home-baseline.inc` als Einstiegspunkt für Overrides.

**Goal (US3)**: `sync-home` erstellt `~/.gitconfig.d/` beim ersten Lauf; bei bestehendem Verzeichnis bleibt der Inhalt unberührt (keine Datenverlust-Gefahr bei wiederholten Syncs).

**Independent Test (US1 — SC-001)**:
```bash
mkdir -p ~/.gitconfig.d/
printf '[user]\n  email = work@test.com\n' > ~/.gitconfig.d/home-baseline.inc
git -C ~/home-baseline-tmp config user.email   # → work@test.com
git config --show-origin user.email            # → shows ~/home-baseline-tmp included file
git -C ~/MyProjects config user.email          # → global default (NOT work@test.com)
rm ~/.gitconfig.d/home-baseline.inc            # aufräumen / clean up
```

**Independent Test (US3 — SC-003)**:
```bash
echo '# custom' > ~/.gitconfig.d/custom.inc
bash scripts/sync-home.sh --no-pull            # erster Lauf
cat ~/.gitconfig.d/custom.inc                  # → '# custom' (unverändert / unchanged)
bash scripts/sync-home.sh --no-pull            # zweiter Lauf
ls ~/.gitconfig.d/                             # → keine neuen Dateien / no new files
```

### Implementation for US1 + US3

- [x] T006 [P] [US1] Add `~/.gitconfig.d/` bootstrap block to `scripts/sync-home.sh`: after file-copy step, check if `~/.gitconfig.d/` exists at `$HOME`; if absent: `mkdir -p "$HOME/.gitconfig.d/"` and write `home-baseline.inc` placeholder (content from research.md R-006 — commented `[user]` block with `email = work@example.com` example); if present: print bilingual skip message. All output bilingual DE/EN (NFR-001). Reference: contracts/script-contracts.md §sync-home.
- [x] T007 [P] [US1] Add same `~/.gitconfig.d/` bootstrap block to `scripts/sync-home.ps1`: identical logic using `$homeDir = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home path (see CLAUDE.md §Windows HOME pitfall); bilingual output (NFR-001). Reference: contracts/script-contracts.md §sync-home, research.md R-006.
- [x] T008 [P] Extend `scripts/hooks/pre-push` to scan `~/.gitconfig.d/` for credential patterns: add new scan block after existing tracked-file scan using exact pattern from research.md R-005 with `"$secret_content_regex"` (same variable, no new regex). Bilingual error message: `"HIGH: Secret-Muster in ~/.gitconfig.d/ gefunden / Secret patterns found in ~/.gitconfig.d/:"`. Bash-only file — no .ps1 counterpart needed (git hooks are sh on all platforms via Git for Windows sh.exe). Reference: contracts/script-contracts.md §pre-push, plan.md §Phase 1C.

> **⚠️ Constitution Principle V MUST**: T009 MUST be executed immediately after T008 before any commit.

- [x] T009 **⚠️ (Constitution Principle V — MANDATORY)** Reinstall pre-push hook after T008 modification: run `bash scripts/install-hooks.sh` from repo root to copy the updated `scripts/hooks/pre-push` into `.git/hooks/pre-push`; confirm output shows `✓ pre-push installiert`; manually verify the hook runs by executing `git push --dry-run` (if supported) or by inspecting `.git/hooks/pre-push` content.

> **⚠️ Constitution Principle I MUST**: T010 MUST be executed and scanner output confirmed before committing T008+T009.

- [x] T010 **⚠️ (Constitution Principle I — MANDATORY GATE before Phase 3 commit)** Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` from repo root; confirm output shows `high=0`; **record the full output verbatim** — it MUST be included in the PR description per Constitution §Governance/Compliance review rule: "Any change to `scripts/hooks/pre-push` MUST explicitly state in the PR which security rule (Principle I) it affects and include scanner output confirming no regressions."

**Checkpoint**: US1 + US3 implementierbar und testbar. `bash scripts/sync-home.sh --dry-run` verifiziert Erstellung (zeigt `[dry-run] ~/.gitconfig.d/`-Erstellung). Zweiter Lauf mit `--no-pull` verifiziert Idempotenz (SC-003). Hook blockiert bei Credential-Muster (SC-008) — erst nach `install-hooks.sh` (T009) aktiv.

---

## Phase 4: US2 (P2) — New Workspace Gets Local Git Settings

**Goal**: `bootstrap-workspace` fügt beim Erstellen eines neuen Workspace idempotent einen `[includeIf]`-Block zu `~/.gitconfig` hinzu und legt eine `.inc`-Platzhalterdatei an. Workspace-spezifische git-Einstellungen (`core.autocrlf`) landen im lokalen `.git/config`, nicht im globalen Config.

**Independent Test (US2 — SC-002)**:
```bash
# Erster Lauf — erstellt Artefakte (OHNE --dry-run)
bash scripts/bootstrap-workspace.sh TestWorkspace
grep 'gitdir:~/TestWorkspace/' ~/.gitconfig  # → Eintrag gefunden
ls ~/.gitconfig.d/test-workspace.inc         # → Datei vorhanden
git -C ~/TestWorkspace config --local core.autocrlf  # → input (macOS/Linux)

# Zweiter Lauf — Idempotenz-Verifikation
bash scripts/bootstrap-workspace.sh TestWorkspace
grep -c 'gitdir:~/TestWorkspace/' ~/.gitconfig  # → exakt 1 (kein Duplikat)

# Dry-run — nur Vorschau ohne Schreibzugriff
bash scripts/bootstrap-workspace.sh --dry-run PreviewWorkspace
```

> **Pfadformat-Konvention (FR-012 + Idempotenz-Korrektheit)**: Alle `[includeIf]`-Werte in `~/.gitconfig` MÜSSEN das Tilde-Format (`~/WorkspaceName/`) verwenden — konsistent mit dem `.gitconfig`-Template (T005). Der Idempotenz-Grep muss deshalb nach `gitdir:~/WorkspaceName/` suchen (NICHT `gitdir:${HOME}/WorkspaceName/`). Auf Windows: `~` durch git-eigene Tilde-Expansion aufgelöst — forward-slash-Format bleibt korrekt. See research.md R-004.

**Implements**: FR-004, FR-005, FR-012

### Implementation for US2

- [x] T011 [P] [US2] Add scope isolation step to `scripts/bootstrap-workspace.sh`: (1) `normalize_name()` function (research.md R-003 Bash implementation); (2) `git config --local core.autocrlf input` in new workspace repo (FR-004); (3) if `~/.gitconfig.d/` exists: idempotency check via `grep -qF "gitdir:~/${workspace_name}/"` (tilde format — see path note above; research.md R-002 adapted), if absent: append `[includeIf "gitdir:~/${workspace_name}/"]` block with tilde path and forward slashes (FR-012), create `~/.gitconfig.d/${normalized_name}.inc` placeholder if not present; (4) if `~/.gitconfig.d/` absent: bilingual skip message; (5) all output bilingual DE/EN (NFR-001). Expected output format from contracts/script-contracts.md §bootstrap-workspace.
- [x] T012 [P] [US2] Add same scope isolation step to `scripts/bootstrap-workspace.ps1`: `ConvertTo-NormalizedName` function (research.md R-003 PowerShell implementation); `$homeDir = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home path; write includeIf value as `~/WorkspaceName/` (tilde format for consistency) — git on Windows resolves `~` correctly; idempotency check via `Select-String "gitdir:~/$workspaceName/"` (matching tilde format); `$path -replace '\\', '/'` for forward-slash normalization of any absolute path constructions (research.md R-004 — if using $homeDir, convert to tilde explicitly); `core.autocrlf = true` on Windows (FR-004 platform variant); all logic mirrors .sh variant. Reference: contracts/script-contracts.md §bootstrap-workspace, plan.md §Phase 1B.

**Checkpoint**: US2 implementierbar und testbar. Erst realen Lauf ohne `--dry-run` ausführen (erstellt `[includeIf]` + `.inc`), dann zweiten Lauf ausführen — `grep -c 'gitdir:~/TestWorkspace/'` MUSS `1` zurückgeben (Idempotenz = SC-002 erfüllt).

---

## Phase 5: US5 (P4) — Homogeneity Check Warns on Missing Scope Isolation

**Goal**: `check-homogeneity` gibt eine nicht-fatale WARN-Meldung aus, wenn `~/.gitconfig.d/` fehlt (GIT-SCOPE-001) oder kein `[includeIf]`-Eintrag für home-baseline-tmp in `~/.gitconfig` vorhanden ist (GIT-SCOPE-002). Compliance-Score wird nicht reduziert.

**Independent Test (US5 — SC-005)**:
```bash
# WARN-Szenario
rm -rf ~/.gitconfig.d/
bash scripts/check-homogeneity.sh
# → Output enthält 'WARN: ~/.gitconfig.d/ fehlt' (oder Äquivalent)
# → Exit-Code: echo $? → 0

# JSON-Modus
bash scripts/check-homogeneity.sh --json
# → JSON enthält "status": "WARN" für "check": "GIT-SCOPE-001"

# PASS-Szenario (nach sync-home)
bash scripts/sync-home.sh --dry-run
bash scripts/check-homogeneity.sh
# → Keine GIT-SCOPE WARN (wenn ~/.gitconfig.d/ und includeIf vorhanden)
```

**Implements**: FR-009, SC-005

### Implementation for US5

- [x] T013 [US5] Create `scripts/lib/hg-git-scope.sh` (new file — pattern from existing `scripts/lib/hg-*.sh`): implement `hg_check_git_scope()` function with GIT-SCOPE-001 check (`~/.gitconfig.d/` exists → WARN if absent) and GIT-SCOPE-002 check (`[includeIf "gitdir:~/home-baseline-tmp/"]` present in `~/.gitconfig` → WARN if absent); severity WARN (does NOT increment fail counter, does NOT affect exit code); bilingual WARN messages (NFR-001); JSON output support when `--json` flag active (emit JSON object per contracts/script-contracts.md §check-homogeneity). Reference: research.md R-007, contracts/script-contracts.md §check-homogeneity.
- [x] T014 [P] [US5] Integrate `hg-git-scope.sh` into `scripts/check-homogeneity.sh`: source `scripts/lib/hg-git-scope.sh`; call `hg_check_git_scope`; ensure WARN output is visible in standard and `--json` modes; WARN does NOT increment existing FAIL counter. Reference: contracts/script-contracts.md §check-homogeneity GIT-SCOPE-001/002.
- [x] T015 [P] [US5] Add GIT-SCOPE-001 and GIT-SCOPE-002 checks to `scripts/check-homogeneity.ps1` (paired with T014, PowerShell equivalent logic): `$homeDir` fallback for Windows HOME; same WARN severity and bilingual messages (NFR-001); JSON output block mirroring Bash check. Reference: contracts/script-contracts.md §check-homogeneity.

**Note**: T013 must complete before T014 can source the new lib file. T014 and T015 can run in parallel after T013.

**Checkpoint**: US5 implementierbar und testbar. WARN emittiert bei fehlendem `~/.gitconfig.d/`, Exit-Code bleibt 0 (SC-005). `--json` gibt korrektes JSON zurück.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: NFR-001 für `bootstrap-project`, README-Dokumentation, finale Ende-zu-Ende-Verifikation.

> **Hinweis**: Constitution Principle I Scanner-Gate (T010) wurde bereits in Phase 3 ausgeführt. Der End-to-End-Verifikationsschritt T020 dient als abschließende Qualitätssicherung.

- [x] T016 [P] Add bilingual output to `scripts/bootstrap-project.sh` for existing `git config --local` step (NFR-001 only — FR-006 logic already implemented per research.md R-009). Add DE/EN message alongside existing step, e.g. `Lokale git-Einstellungen gesetzt / Local git settings applied`.
- [x] T017 [P] Add bilingual output to `scripts/bootstrap-project.ps1` for existing `git config --local` step (paired with T016, same NFR-001 requirement, same R-009 context).
- [x] T018 [US1] Add `## Git Scope-Isolierung / Git Scope Isolation` section to `README.md` after `## Workspace-Einrichtung / Workspace Setup` section (FR-010): bilingual heading (WCAG 2.4.6); explain `includeIf` mechanism; list global vs. workspace-specific settings; show user.email override example; reference `~/.gitconfig.d/` and `.inc` format; add TOC entry under `##` headings (2-level TOC convention); all code blocks with language tags (WCAG 4.1.1).
- [x] T019 [P] Verify `~/.gitconfig.d/` remains untracked: run `git -C ~/home-baseline-tmp ls-files ~/.gitconfig.d/`; confirm empty output (constraint from plan.md §Technical Context).
- [x] T020 Run comprehensive end-to-end verification covering all open Success Criteria:
  ```bash
  # SC-001: per-workspace identity (see Phase 3 Independent Test — run again for final confirmation)
  printf '[user]\n  email = work@test.com\n' > ~/.gitconfig.d/home-baseline.inc
  git -C ~/home-baseline-tmp config user.email              # → work@test.com
  git config --show-origin user.email                       # → shows inc file path
  git -C ~/MyProjects config user.email                     # → global default
  rm ~/.gitconfig.d/home-baseline.inc                       # clean up

  # SC-002: bootstrap-workspace idempotency (see Phase 4 Independent Test)
  # SC-003: sync-home preservation (see Phase 3 Independent Test)

  # SC-005: check-homogeneity WARN (see Phase 5 Independent Test)

  # SC-006: Level-2 project git operations unaffected
  mkdir -p ~/home-baseline-tmp/test-level2-project/.git
  git -C ~/home-baseline-tmp/test-level2-project init
  git -C ~/home-baseline-tmp/test-level2-project status    # → correct status output
  git -C ~/home-baseline-tmp/test-level2-project config user.email  # inherits inc scope
  rm -rf ~/home-baseline-tmp/test-level2-project           # clean up

  # SC-007: no regressions — existing git operations in all repos
  git -C ~/home-baseline-tmp status                        # → working tree status
  git -C ~/home-baseline-tmp log --oneline -3              # → recent commits visible

  # NFR-001: confirm all new output lines are bilingual
  bash scripts/sync-home.sh --dry-run        | grep -E '(✓|→)' # all bilingual?
  bash scripts/bootstrap-workspace.sh --dry-run TestW | grep -E '(✓|→)' # all bilingual?
  bash scripts/check-homogeneity.sh --json   # JSON well-formed?
  ```

**Checkpoint**: Alle Phasen abgeschlossen. PR kann erstellt werden. PR-Beschreibung MUSS enthalten: (1) T010 Scanner-Output, (2) Aussage „This change extends secret scanning per Constitution Principle I", (3) `--dry-run` / `-WhatIf` Output aller geänderten Scripts, (4) Bilingual-Sample-Output.

---

## User Story 4 (P3) — Out of Scope

**US4**: Workspace Teardown Cleans Up Git Config — `teardown-workspace.sh/.ps1` existiert noch nicht. Implementierung erfolgt in separatem Feature (`Lastenheft_Workspace_Teardown.md`). Keine Tasks in dieser Liste. Nutzer-Mitigation bis dahin: quickstart.md §„Bekannte Lücken bis teardown-workspace".

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Keine Abhängigkeiten — alle T001–T004 können sofort starten
- **Foundational (Phase 2)**: T005 benötigt T001 (`.gitconfig` gelesen)
- **Phase 3 (US1+US3)**:
  - T005 muss abgeschlossen sein
  - T006, T007, T008 können parallel starten (verschiedene Dateien)
  - **T009 muss direkt nach T008 folgen** (Constitution Principle V)
  - **T010 muss direkt nach T009 folgen und VOR Phase-3-Commit** (Constitution Principle I)
- **Phase 4 (US2)**: T005 muss abgeschlossen sein — T011, T012 parallel; unabhängig von Phase 3
- **Phase 5 (US5)**: T005 muss abgeschlossen sein — T013 → T014 ‖ T015; unabhängig von Phase 3/4
- **Polish (Phase 6)**: T016, T017, T018, T019 unabhängig; T020 erst nach Phase 3+4+5 abgeschlossen

### User Story Dependencies

- **US1+US3 (Phase 3)**: Can start after Foundational (Phase 2). Independent of US2, US5.
- **US2 (Phase 4)**: Can start after Foundational (Phase 2). Independent of US1/US3, US5.
- **US5 (Phase 5)**: Can start after Foundational (Phase 2). Independent of US1/US3, US2.
- **US4**: Out of scope — no dependency.

### Within Each Phase

- Read before write (Phase 1 before Phase 2)
- `.gitconfig` template (T005) before any script additions
- New lib file (T013) before integration (T014)
- Hook modification (T008) → reinstall (T009) → scanner gate (T010) → commit Phase 3

### Parallel Opportunities

```text
Phase 1:   T001 ‖ T002 ‖ T003 ‖ T004             (all read-only, different files)
Phase 3:   T006 ‖ T007 ‖ T008                     (different files: .sh, .ps1, pre-push)
           T009 → T010                             (sequential: install then scan)
Phase 4:   T011 ‖ T012                             (different files: .sh, .ps1)
Phase 5:   T013 → (T014 ‖ T015)                   (T013 first, then parallel)
Phase 6:   T016 ‖ T017 ‖ T018 ‖ T019             (different files)
```

---

## Parallel Example: US1 + US3 (Phase 3)

```text
# After T005 (Foundational) completes:

[PARALLEL]
  Task T006: "Add ~/.gitconfig.d/ block to scripts/sync-home.sh"
  Task T007: "Add ~/.gitconfig.d/ block to scripts/sync-home.ps1"
  Task T008: "Extend scripts/hooks/pre-push to scan ~/.gitconfig.d/"

[SEQUENTIAL after T008]
  Task T009: "bash scripts/install-hooks.sh" → Constitution Principle V gate
  Task T010: "bash scripts/scan-agent-secrets.sh --fail-on-high ." → Constitution Principle I gate
  → Record output → Include in PR description
  → COMMIT Phase 3
```

---

## Implementation Strategy

### MVP First (US1 only — Per-Workspace Git Identity)

1. Complete Phase 1: Setup (T001–T004)
2. Complete Phase 2: Foundational — `.gitconfig` template (T005)
3. Complete Phase 3 US1: sync-home + pre-push hook (T006, T007, T008, **T009, T010**)
4. **STOP and VALIDATE**: Run US1 Independent Test (SC-001 — git config --show-origin in workspace vs. outside)
5. Commit Phase 3 with T010 scanner output in PR description

### Incremental Delivery

1. Phase 1 + 2 → Foundation ready
2. Phase 3 (T006–T010) → US1+US3: sync-home + security hook working; **scanner GATE passed**
3. Phase 4 (T011–T012) → US2: bootstrap-workspace scope isolation working
4. Phase 5 (T013–T015) → US5: check-homogeneity WARN working
5. Phase 6 (T016–T020) → Polish + comprehensive end-to-end verification

### Commit Strategy

- Commit nach jeder Phase-Fertigstellung
- Phase-3-Commit: MUST include T010 scanner output verbatim (Constitution Principle I requirement)
- Phase-2-Commit (`.gitconfig` template): standalone commit empfohlen (sichtbare Tracked-File-Änderung)
- Conventional Commits: `feat(003-git-config-scope): ...` für Script-Änderungen, `docs(003-git-config-scope): ...` für README

---

## Notes

- [P] = unterschiedliche Dateien, keine Abhängigkeit von laufenden Tasks
- [US?] = Rückverfolgung zur User Story aus spec.md
- Keine automatisierten Tests — manuelle Verifikation per `--dry-run` / `-WhatIf`
- **T009 + T010 (Constitution Gates in Phase 3)** sind verbindlich und nicht überspringbar
- **Pfadformat**: Alle `[includeIf]`-Werte in `~/.gitconfig` MÜSSEN Tilde-Format `~/WorkspaceName/` verwenden. Grep-Idempotenz-Check ebenfalls auf `gitdir:~/` prüfen.
- Alle neuen Benutzerausgaben MÜSSEN bilingual DE/EN sein (NFR-001)
- Windows-PowerShell: HOME-Pfad immer über `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` (CLAUDE.md)
- `.gitconfig.d/` darf nie in die Whitelist-gitignore aufgenommen werden (T019 verifiziert)
