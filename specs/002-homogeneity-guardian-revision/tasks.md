# Tasks: Workspace Homogeneity Guardian — Revision & Gap Fix
# Aufgaben: Workspace-Homogenitätswächter — Schwachstellen-Behebung

**Input**: `specs/002-homogeneity-guardian-revision/`  
**Branch**: `002-homogeneity-guardian-revision`  
**Spec**: spec.md · **Plan**: plan.md · **Datenmodell**: data-model.md  
**Contracts**: `contracts/` (8 Dateien)

## Format: `[ID] [P?] [Story] Beschreibung mit Dateipfad`

- **[P]**: Parallel ausführbar (unabhängige Dateien, keine wartenden Abhängigkeiten)
- **[Story]**: Zugehörige User Story aus spec.md (US1–US5)
- **Kein Story-Label**: Setup-, Foundation- oder Polish-Aufgaben

---

## Phase 1: Setup (REV-C + Templates)

**Zweck / Purpose**: `.gitignore`-Whitelist korrigieren und Bilingual-Templates erstellen —  
diese Artefakte sind Voraussetzung für alle nachfolgenden Phasen.

*Purpose: Fix `.gitignore` whitelist and create bilingual templates —  
these artifacts are prerequisites for all subsequent phases.*

**Behebt / Fixes**: SW-08, SW-09 *(H2: `!constitution.md` zur Whitelist ergänzt; C1-Fix: T024 in diese Phase vorgezogen — T010/T012/T016 benötigen `~/constitution.md` zur Laufzeit)*

- [X] T001 `.gitignore` korrigieren: Einträge `!Lastenheft*.md`, `!STATS.md`, `!scripts/templates/`, **`!constitution.md`** hinzufügen (FR-REV-C01; `!constitution.md` nötig: `~/constitution.md` ist Root-Sync-Quelle für `sync-constitution.sh` und existiert noch nicht im Tracking, H2); doppelten `!.specify/memory/`-Eintrag entfernen (FR-REV-C02); anschließend `git commit -m "fix(gitignore): REV-C01/C02 — Whitelist constitution.md, Lastenheft, STATS, templates + Duplikat entfernt"` (NFR-REV-03, M1) → `~/.gitignore`
- [X] T002 [P] Template `scripts/templates/a11y-section.md` erstellen — vollständiger bilingualer `## Barrierefreiheit / Accessibility (A11Y)`-Abschnitt, DE zuerst, EN CEFR B2, kein ANSI-Code (NFR-REV-07) → `scripts/templates/a11y-section.md`
- [X] T003 [P] Template `scripts/templates/speckit-workflow-section.md` erstellen — bilingualer `## Spec-kit-Workflow`-Abschnitt mit SDD-Workflow-Erklärung, DE/EN CEFR B2 → `scripts/templates/speckit-workflow-section.md`
- [X] T004 [P] Template `scripts/templates/azubis-section.md` erstellen — bilingualer `## Für Azubis / For Apprentices`-Abschnitt, DE/EN CEFR B2 → `scripts/templates/azubis-section.md`
- [X] T005 [P] Template `scripts/templates/readme-template.md` erstellen — **NEUE** Datei, komplett getrennt von `scripts/templates/README.md.tmpl` (existierendes Workspace-Agenten-Template für `bootstrap-workspace.sh` — nicht anfassen, H3); vollständige bilinguale README mit allen drei Pflichtabschnitten (A11Y, Spec-kit, Azubis) aus T002–T004 eingebettet und EN-Platzhalter-Block `<!-- EN: README.md placeholder -->` am Dateiende; ein frisch bootstrapptes Level-2-Projekt ist sofort 100 % compliant → `scripts/templates/readme-template.md`
- [X] T024 [P] `~/constitution.md` anlegen und tracken (**C1-Fix**: hierher aus Phase 9 verschoben — T010/T012/T016 lesen `~/constitution.md` zur Laufzeit ihrer Tests; **H2**): `~/constitution.md` existiert noch nicht als eigenständige Root-Datei (Quelle: `~/.specify/memory/constitution.md`); Schritt 1: `cp ~/.specify/memory/constitution.md ~/constitution.md`; Schritt 2: erste Zeile auf `# Constitution v1.1.0` prüfen/sicherstellen; Schritt 3: `.gitignore` wurde bereits in T001 um `!constitution.md` erweitert — Datei ist nun getrackt; Schritt 4: `git commit -m "fix(constitution): ~/constitution.md als Root-Sync-Quelle anlegen"` (NFR-REV-03, M1) → `~/constitution.md`

**Checkpoint Phase 1**: `.gitignore` korrigiert, `~/constitution.md` angelegt + getrackt (**C1-Fix**: Voraussetzung für Runtime-Tests in Phase 4/5/7), alle 4 Templates vorhanden → Phase 2 kann beginnen.

---

## Phase 2: Foundation — check-homogeneity (US2 / P1, REV-B01)

**Ziel / Goal**: Das primäre Compliance-Prüf-Skript liefert Berichte ohne `✗`-Befunde.  
*Goal: The primary compliance check script delivers reports without `✗` findings.*

**Warum Foundation**: `init-stats.sh` (Phase 3) ruft `check-homogeneity.sh --json` intern auf —  
diese Phase muss abgeschlossen sein, bevor Phase 3 beginnt.

**Unabhängiger Test / Independent Test**:  
`bash scripts/check-homogeneity.sh` → Klartext-Report, Exit-Code 0 oder 1;  
`bash scripts/check-homogeneity.sh --json` → valides JSON `{"score": N, "by_level": {...}, "failures": [], "warnings": []}`.

**Behebt / Fixes**: SW-02, SW-17

- [X] T006 [US2] `scripts/check-homogeneity.sh` **erweitern** (**H1**: Basis ist existierendes Skript für FR-001–FR-021 des Parent-Features — **nicht überschreiben**, additive Erweiterung): fehlende Checks aus `contracts/check-homogeneity-cli.md` ergänzen: Inhalts-Checks (`A11Y section`, `Spec-kit section`, `Azubis section`, `EN placeholder`), `.editorconfig`-Check für C#-Level-2 (FR-REV-E02, `find . -maxdepth 1 -name "*.sln"`), ANSI-Escape-Prüfung in `scripts/` via **`rg`** statt `grep -rP` (**M4-orig**: `grep -rP` schlägt auf macOS BSD-grep fehl; `rg` ist Pflicht per NFR-REV-04); Pattern: **`rg -l -e $'\x1b\[' -e $'\\033\[' -e $'\\e\[' scripts/`** — ein einziger Aufruf mit drei `-e`-Alternationen; **H1-Fix**: `||` wäre falsch (stoppt bei erstem Fund, übersieht restliche Patterns); `-e` prüft alle drei Escape-Formen exhaustiv; NFR-REV-07), vollständige Pflichtdatei-Präsenz-Matrix Level 0–2, Score `✓/(✓+✗)×100`, `by_level` separat; Klartext-Ausgabe `[✓|✗|WARN] Level-N  {datei}  {check-name}` + Score-Zeile + ASCII-Chart; JSON-Modus (`--json`); Markdown-Tabelle → `$GITHUB_STEP_SUMMARY`; Exit-Codes 0/1/2 per Vertrag → `scripts/check-homogeneity.sh`
- [X] T007 [P] [US2] `scripts/check-homogeneity.ps1` **aktualisieren** (**H1**: existierendes PS1-Skript als Basis — **nicht überschreiben**): vollständige funktionale Parität zur erweiterten Bash-Variante (T006); ANSI-Prüfung via `Select-String` mit Pattern `\x1b\[|\033\[|\e\[` (PS1 unterstützt .NET-Regex, kein BSD-grep-Problem); Parameter `-WorkspaceName` (optional) und `-Json`; dieselben Exit-Codes; `$env:GITHUB_STEP_SUMMARY` für Job-Summary → `scripts/check-homogeneity.ps1`

**Checkpoint Phase 2**: `bash scripts/check-homogeneity.sh` ausführbar → Phase 3 kann beginnen.

---

## Phase 3: User Story 3 — init-stats (P2, REV-B04)

**Ziel / Goal**: `STATS.md`-Baseline auf Level 0, 1 und 2 erzeugen; Progress mit ASCII-Chart messbar machen.  
*Goal: Create `STATS.md` baseline on Level 0, 1, and 2; make progress measurable via ASCII chart.*

**Unabhängiger Test / Independent Test**:  
`bash scripts/init-stats.sh` → `STATS.md` auf allen Ebenen vorhanden; jede Datei enthält mindestens eine Zeile `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ N%` mit dem Ist-Score; zweiter Aufruf hängt neue Zeile an (append-only).

**Behebt / Fixes**: SW-05, SW-18

- [X] T008 [US3] `scripts/init-stats.sh` erstellen (Bash 5+, `set -euo pipefail`): ruft `check-homogeneity.sh --json` intern auf und extrahiert `score`-Wert; bricht ab mit `ERROR: check-homogeneity.sh nicht gefunden — zuerst FR-REV-B01 implementieren`, falls nicht ausführbar; erstellt/ergänzt `STATS.md` auf Level 0 (`~/STATS.md`), Level 1 (je `~/WorkspaceName/STATS.md`) und Level 2 (je Projekt-Root); Dateiformat: **bilinguale** Kopfzeilen (**L3-Fix**: Tippfehler korrigiert; NFR-REV-05), Baseline-Abschnitt `## Run YYYY-MM-DD HH:MM`; ASCII-Balken-Format `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ N%` (20 Zeichen Gesamtbreite, Score auf 5 % gerundet); append-only (nie überschreiben, FR-REV-A05-konform) → `scripts/init-stats.sh`
- [X] T009 [P] [US3] `scripts/init-stats.ps1` erstellen (PowerShell 7+): vollständige Parität zu T008; identisches STATS.md-Ausgabeformat; dasselbe ASCII-Balken-Format; **L2-Fix**: `~/STATS.md`-Pfad via `Join-Path $HOME 'STATS.md'` auflösen statt `~/STATS.md` wörtlich (in PS7 ist `~/` in `-NonInteractive`-Shells und `Start-Process`-Kontexten nicht zuverlässig expandiert) → `scripts/init-stats.ps1`

**Checkpoint Phase 3**: `bash scripts/init-stats.sh` erzeugt `~/STATS.md` → Phase 4 kann beginnen.

---

## Phase 4: User Story 1 — migrate-workspace (P1, REV-A + REV-E01)

**Ziel / Goal**: Bestehende Workspace-Repos idempotent auf Zielstand bringen ohne Inhaltsverlust.  
*Goal: Bring existing workspace repos idempotently to target state without losing content.*

**Unabhängiger Test / Independent Test**:  
`bash scripts/migrate-workspace.sh --dry-run RiderProjects` → Preview ohne Dateiänderung, Exit-Code 0;  
nach `bash scripts/migrate-workspace.sh RiderProjects` → `bash scripts/check-homogeneity.sh RiderProjects` liefert keinen `✗`-Befund für `RiderProjects` (SC-REV-07: Score +40 pp gegenüber Baseline).

**Behebt / Fixes**: SW-03, SW-04, SW-06, SW-07, SW-10, SW-13, SW-14

- [X] T010 [US1] `scripts/migrate-workspace.sh` erstellen (Bash 5+, `set -euo pipefail`): scannt alle fehlenden Pflicht-Inhalte; Preview aller geplanten Einfügungen; **Prompt-Verhalten (FR-REV-A02, M2)**: Einzelner-Workspace-Modus → Preview für diesen Workspace + einmalige `Proceed? [y/N]`; **Alle-auf-einmal-Modus** (kein Argument) → **eine einzige** kombinierte Gesamt-Preview aller Workspaces gefolgt von **einem einzigen** `Proceed? [y/N]` — keine separate Bestätigung pro Workspace (Prompt entfällt bei `--dry-run` / `--yes`); **Einfügungen (append-only, FR-REV-A05)**: EN-Platzhalter `<!-- EN: {datei} placeholder\n[DE-Zusammenfassung als Kommentar]\n-->` an Dateiende in `README.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `.github/copilot-instructions.md`, **`constitution.md`** (**M1-Fix**: FR-REV-A01 listet `constitution.md` explizit im Bilingualisierungs-Scope — Einfügung idempotent, nur wenn noch kein EN-Block vorhanden; **L4-Hinweis**: `constitution.md` ist bereits englischsprachig, der EN-Platzhalter dient als Compliance-Marker für `check-homogeneity.sh`); drei README-Abschnitte (A11Y, Spec-kit, Azubis) nur in `README.md` aus Templates T002–T004; `homogeneity-check.yml` anlegen falls fehlend in Level-1-Workspaces **und** Level-2-Projekten (**M3**, FR-REV-A01: Level-2-Erkennung via `find {workspace} -mindepth 2 -maxdepth 2 -name '.git' -type d`; FR-REV-G01–G03-konform); `.editorconfig` für C#-Level-2-Projekte anlegen falls fehlend (`find . -maxdepth 2 -name "*.sln"`, FR-REV-E01); Level-2 pre-push Hook via `{level1-workspace}/scripts/install-hooks.sh` prüfen/installieren (FR-REV-A04); Idempotenz-Regeln per Vertrag `contracts/migrate-workspace-cli.md`; Git-Commit `chore: migrate {workspace} to homogeneity baseline v{version}` (Version aus erster Zeile `~/constitution.md`); `bash scripts/init-stats.sh` nach Commit aufrufen (FR-REV-A03); Fehlerrollback `git stash` pro Workspace (FR-REV-A06); `--yes`-Flag; Alle-auf-einmal-Modus ohne Argument → `scripts/migrate-workspace.sh`
- [X] T011 [P] [US1] `scripts/migrate-workspace.ps1` erstellen (PowerShell 7+): vollständige Parität zu T010; Parameter `-WorkspaceName`, `-WhatIf`, `-Force`; identische Idempotenz-Regeln und Fehlerbehandlung → `scripts/migrate-workspace.ps1`

**Checkpoint Phase 4**: Migrations-Workflow vollständig und getestet → Phase 5 kann beginnen.

---

## Phase 5: bootstrap-project (REV-B02, REV-B05, REV-D01, REV-D02)

**Zweck / Purpose**: Neue Projekte sofort 100 % compliant bootstrappen.  
*Purpose: Bootstrap new projects immediately at 100% compliance.*

**Unabhängiger Test / Independent Test**:  
`bash scripts/bootstrap-project.sh TestProject --dry-run` → Preview ohne Dateien;  
nach echtem Lauf: `ls TestProject/` zeigt README.md, constitution.md, STATS.md, .github/workflows/homogeneity-check.yml; `bash scripts/check-homogeneity.sh TestProject` Exit-Code 0.

**Behebt / Fixes**: SW-01, SW-06, SW-12 *(H1: Skript existiert bereits für FR-009–016 des Parent-Features — additive Erweiterung, kein Overwrite)*

- [X] T012 Bootstrap-Skript `scripts/bootstrap-project.sh` **erweitern/aktualisieren** (**H1**: Basis ist existierendes Skript für FR-009–FR-016 des Parent-Features — **nicht überschreiben**; additive Erweiterungen gemäß `contracts/bootstrap-project-cli.md`): `README.md` aus `scripts/templates/readme-template.md` (T005) verwenden statt direkt erzeugen — bricht ab mit `ERROR: template not found: scripts/templates/readme-template.md` falls fehlt; `~/constitution.md` kopieren (T024 in Phase 1 sichergestellt) — bricht ab mit `ERROR: root constitution.md not found at ~/constitution.md` falls fehlt; `homogeneity-check.yml` erstellen (FR-REV-G01–G03-konform); spec-kit init: `.specify/` anlegen, `create-new-feature.sh` installieren, SDD-Verweis in `AGENTS.md` (FR-REV-B05); Agenten-CLIs: `claude /init` + `gh extension exec github/gh-copilot` (falls verfügbar, sonst WARN; FR-REV-D01/D02); Codex + Gemini: WARN interaktiv; `speckit specify init --here --ai {claude|gemini|copilot|codex}` (alle 4, falls `speckit` verfügbar, sonst WARN; FR-REV-B05); `bash scripts/init-stats.sh` am Ende aufrufen (FR-REV-B02); **`--dry-run`** für Preview ohne Schreibvorgang (**L1-Fix**: Phase-5-Testblock erwartet dieses Flag); `--force` für Re-Apply → `scripts/bootstrap-project.sh`
- [X] T013 [P] `scripts/bootstrap-project.ps1` **aktualisieren** (**H1**: existierendes PS1-Skript als Basis — **nicht überschreiben**): vollständige Parität zur erweiterten Bash-Variante (T012); Parameter `-ProjectName`, `-RepoName`, `-Description`, **`-WhatIf`** (entspricht `--dry-run`, **L1-Fix**), `-Force` → `scripts/bootstrap-project.ps1`

---

## Phase 6: rename-lastenheft (REV-B03)

**Zweck / Purpose**: Lastenheft-Dateien nach Spec-Kit-Durchlauf automatisch umbenennen.  
*Purpose: Automatically rename Lastenheft files after Spec-Kit workflow completion.*

**Behebt / Fixes**: SW-11

- [X] T014 [P] `scripts/rename-lastenheft.sh` erstellen (Bash 5+): Aufruf `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>`; berechnet neuen Namen `{original-stem}.{branch-name}.md` (Stem = Dateiname ohne `.md`, Trennzeichen Punkt); führt `git mv <alt> <neu>` aus; erzeugt Commit `chore: rename Lastenheft to {new-name}`; Fehler falls Datei nicht existiert oder nicht `.md`-Endung hat → `scripts/rename-lastenheft.sh`
- [X] T015 [P] `scripts/rename-lastenheft.ps1` erstellen (PowerShell 7+): Parität zu T014; Parameter `-LHFile`, `-BranchName` → `scripts/rename-lastenheft.ps1`

---

## Phase 7: User Story 4 — sync-constitution (P2, REV-F01–F02)

**Ziel / Goal**: Constitution-Versionsänderungen automatisch in alle Level-1-Workspaces **und Level-2-Projekte** propagieren (**I1-Fix**).  
*Goal: Automatically propagate constitution version changes to all Level-1 workspaces and Level-2 projects.*

**Unabhängiger Test / Independent Test**:  
`bash scripts/sync-constitution.sh --dry-run` → listet alle Workspaces mit `WOULD UPDATE` / `WOULD SKIP`, keine Dateiänderung, Exit-Code 0.

**Behebt / Fixes**: SW-15

- [X] T016 [US4] `scripts/sync-constitution.sh` erstellen (Bash 5+, `set -euo pipefail`): Version aus erster Zeile `~/constitution.md` per `grep` extrahieren (`# Constitution vMAJOR.MINOR.PATCH`) — `ERROR: constitution.md hat keine Versionszeile` + Abbruch falls fehlend; Preview aller Ziel-Repos mit `WOULD UPDATE` / `WOULD SKIP`; Prompt `Proceed? [y/N]` (entfällt bei `--yes`/`--dry-run`); uncommittete Änderungen → `WARN: {ws} hat uncommittete Änderungen — übersprungen`; Abschlusszusammenfassung `UPDATED` / `SKIPPED (dirty)` / `ALREADY UP-TO-DATE`; Fehlerrollback via `git stash`; `--dry-run` Flag; **Scope (M4-Fix, FR-REV-F01-Amendment)**: Level-1-Workspaces **UND** zugehörige Level-2-Projekte (`find {workspace} -mindepth 2 -maxdepth 2 -name '.git' -type d`); **Merge-First-Propagation pro Ziel `{target}` (M2-Fix, Product-Owner-Entscheidung 2026-04-02)**:
  - **(A) Datei fehlt** → `cp ~/constitution.md {target}/constitution.md`; Commit `chore: sync constitution to v{version}`; Status `UPDATED`
  - **(B) Version identisch** → Status `ALREADY UP-TO-DATE` (kein Schreibvorgang)
  - **(C) Version veraltet**: `grep -q "^## Workspace" {target}/constitution.md`?
    - **JA (workspace-spezifische Abschnitte vorhanden)** → **Merge**: alle Root-Sections bis zum ersten `## Workspace-`-Heading durch Root-Inhalt ersetzen; alle `## Workspace-*`-Abschnitte vollständig erhalten (append-only für workspace-spezifischen Teil, NFR-REV-02-konform); Versionszeile auf neue Version setzen; Commit `chore: merge constitution to v{version}`; Status `UPDATED`
    - **NEIN (keine workspace-spezifischen Abschnitte)** → `cp ~/constitution.md {target}/constitution.md`; Commit `chore: sync constitution to v{version}`; Status `UPDATED`
  **Level-2 Dirty-Repo-Handling (U1-Fix)**: Level-2-Repos mit uncommitteten Änderungen → analog `WARN: {project} hat uncommittete Änderungen — übersprungen`; restliche Level-2-Projekte dieses Workspace werden normal verarbeitet
  → `scripts/sync-constitution.sh`
- [X] T017 [P] [US4] `scripts/sync-constitution.ps1` erstellen (PowerShell 7+): vollständige Parität zu T016 einschließlich Merge-First-Logik (**M2-Fix**: `Select-String -Pattern "^## Workspace"` für Workspace-Abschnitt-Erkennung; Section-Extrakt via `Get-Content` + Zeilen-Index); Parameter `-WhatIf`, `-Force`; Level-2-Scope identisch zu T016 → `scripts/sync-constitution.ps1`

**Checkpoint Phase 7**: Constitution-Propagation testbar → Phase 8 kann beginnen.

---

## Phase 8: User Story 5 — CI/CD-Workflow (P3, REV-G01–G03)

**Ziel / Goal**: Automatischer Compliance-Check bei jedem Push via GitHub Actions.  
*Goal: Automatic compliance check on every push via GitHub Actions.*

**Unabhängiger Test / Independent Test**:  
Push auf Branch → GitHub-Actions-Job `homogeneity-check` läuft grün auf `ubuntu-22.04`.

**Behebt / Fixes**: SW-16

- [X] T018 [US5] `.github/workflows/homogeneity-check.yml` erstellen: Trigger `push` + `pull_request`; Matrix-Strategie `[ubuntu-22.04, macos-14, windows-latest]` (NFR-REV-04); `timeout-minutes: 10` pro Matrix-Job; Ripgrep-Installation per Plattform (`apt-get install ripgrep` / `brew install ripgrep` / `choco install ripgrep`); Compliance-Aufruf: Ubuntu/macOS → `bash scripts/check-homogeneity.sh $(basename "$GITHUB_WORKSPACE")`; Windows → `pwsh scripts/check-homogeneity.ps1 -WorkspaceName (Split-Path $env:GITHUB_WORKSPACE -Leaf)`; Plain Text → stdout; Markdown-Tabelle → `$GITHUB_STEP_SUMMARY` / `$env:GITHUB_STEP_SUMMARY`; Exit-Code 1 bei `✗`-Befunden (FR-REV-G02) → `.github/workflows/homogeneity-check.yml`

---

## Phase 9: Polish & Direktkorrekturen

**Zweck / Purpose**: Schwachstellen in der `home-baseline` direkt (ohne Skript-Aufruf) beheben;  
finale Validierung aller SC-REV-Erfolgskriterien.

*Purpose: Fix weaknesses in `home-baseline` directly (without script invocation);  
final validation of all SC-REV success criteria.*

**Behebt direkt / Directly fixes**: SW-03, SW-04, SW-10

- [X] T019 [P] `~/README.md` direkt bearbeiten: Abschnitte `## Barrierefreiheit / Accessibility (A11Y)`, `## Spec-kit-Workflow`, `## Für Azubis / For Apprentices` (Inhalte aus Templates T002–T004) einfügen, falls noch nicht vorhanden; EN-Platzhalter-Block `<!-- EN: README.md placeholder\n[DE-Zusammenfassung als Kommentar]\n-->` an Dateiende (SW-03, SW-04) → `~/README.md`
- [X] T020 [P] `~/CLAUDE.md` direkt bearbeiten: EN-Platzhalter-Block `<!-- EN: CLAUDE.md placeholder\n[DE-Zusammenfassung als Kommentar]\n-->` an Dateiende (SW-03) → `~/CLAUDE.md`
- [X] T021 [P] `~/GEMINI.md` direkt bearbeiten: EN-Platzhalter-Block `<!-- EN: GEMINI.md placeholder\n[DE-Zusammenfassung als Kommentar]\n-->` an Dateiende (SW-03) → `~/GEMINI.md`
- [X] T022 [P] `~/AGENTS.md` direkt bearbeiten: EN-Platzhalter-Block `<!-- EN: AGENTS.md placeholder\n[DE-Zusammenfassung als Kommentar]\n-->` an Dateiende (SW-03) → `~/AGENTS.md`
- [X] T023 [P] `~/.github/copilot-instructions.md` direkt bearbeiten: EN-Platzhalter-Block einfügen (SW-10) → `~/.github/copilot-instructions.md`
- [X] T024a Phase-9-Direktkorrekturen committen (**M1**, NFR-REV-03): `git add README.md CLAUDE.md GEMINI.md AGENTS.md .github/copilot-instructions.md` + `git commit -m "fix(bilingual): EN-Platzhalter + A11Y/Spec-kit/Azubis in Root-Dateien (SW-03, SW-04, SW-10; SC-REV-02)"` — fasst alle Dateiänderungen aus T019–T023 in einem Commit zusammen → `~/` (kein Datei-Pfad — Git-Commit)
- [X] T025 Vollständigen Validierungslauf durchführen: `bash scripts/check-homogeneity.sh` auf gesamter Umgebung — Ziel: Exit-Code 0, kein `✗`-Befund (SC-REV-01); alle SC-REV-01–SC-REV-07 manuell verifizieren
- [X] T026 STATS.md Level-0 Baseline erzeugen: `bash scripts/init-stats.sh` ausführen — `~/STATS.md` erhält Baseline-Eintrag (SC-REV-03); anschließend nach allen Korrekturen erneut aufrufen für Post-Fix-Eintrag; **Commit-Pflicht (M3-Fix, NFR-REV-03)**: `git add STATS.md && git commit -m "chore(stats): Level-0 Baseline + Post-Fix-Eintrag nach Spec-002-Korrekturen"` — STATS.md ist getrackt (`!STATS.md` in .gitignore via T001)

---

## Abhängigkeitsreihenfolge / Dependency Order

```
T001 → T002–T005, T024 (parallel — C1-Fix: constitution.md früh anlegen)
T024 → T010, T012, T016 (~/constitution.md für Laufzeit-Tests benötigt)
T002–T005 → T006 (Templates nötig für Inhalts-Checks)
T006 ↔ T007 (parallel — gleiche Anforderungen)
T006 → T008 (init-stats ruft check-homogeneity --json auf)
T008 ↔ T009 (parallel)
T002–T005 + T008 → T010 (migrate liest Templates + ruft init-stats auf)
T010 ↔ T011 (parallel)
T005 + T010 → T012 (bootstrap nutzt readme-template + Migrationsmuster)
T012 ↔ T013 (parallel)
T014 ↔ T015 (parallel, keine Deps auf andere Phasen)
T006 → T016 (sync-constitution commit-Muster analog)
T016 ↔ T017 (parallel)
T006 → T018 (CI-Workflow ruft check-homogeneity auf)
T010–T018 → T019–T023 (parallel — Direktkorrekturen Agenten-Dateien)
T019–T023 → T024a (Commit Direktkorrekturen)
T024a → T025 (Validierung nach allen Korrekturen — C1-Fix: T024 kein Blocker mehr)
T025 → T026 (Post-Fix Baseline nach bestandenem Check)
```

## Parallelisierungsmöglichkeiten / Parallel Execution Opportunities

| Paket / Batch | Aufgaben / Tasks | Voraussetzung |
|---|---|---|
| Templates + constitution.md | T002, T003, T004, T005, T024 | T001 ✓ (C1-Fix: T024 jetzt in Phase 1) |
| Bash+PS1 Check | T006, T007 | T002–T005 ✓ |
| Bash+PS1 Stats | T008, T009 | T006 ✓ |
| Bash+PS1 Migrate | T010, T011 | T008 + T024 ✓ |
| Bash+PS1 Bootstrap | T012, T013 | T005 + T010 + T024 ✓ |
| Bash+PS1 Rename | T014, T015 | (T001 ✓) |
| Bash+PS1 Sync | T016, T017 | T006 + T024 ✓ |
| CI/CD | T018 | T006 ✓ |
| Direktkorrekturen | T019, T020, T021, T022, T023 | T010–T018 ✓ |
| Commit Phase 9 | T024a | T019–T023 ✓ |
| Validierung | T025 | T024a ✓ |
| Baseline-Commit | T026 | T025 ✓ |

## Implementierungsstrategie / Implementation Strategy

**MVP**: US2 (check-homogeneity) + US3 (init-stats) → messbare Baseline, vollständiger Compliance-Report  
**Inkrementell**: US1 (migrate) schließt SW-14 — größten Gap für bestehende Workspaces  
**Vollständig**: US4 (sync-constitution) + US5 (CI) schließen alle 18 Schwachstellen

**Mandatory order (NFR-REV-01)**:  
Phase 1 (REV-C) → Phase 2 (REV-B01) → Phase 3 (REV-B04) → Phase 4 (REV-A) →  
Phase 5 (REV-B02) → Phase 6 (REV-B03) → [implizit in T012: REV-D] →  
[implizit in T010/T006: REV-E] → Phase 7 (REV-F) → Phase 8 (REV-G) → Phase 9 (Polish)

---

*Generiert von `/speckit-tasks` am 2026-04-02 · Spec: `002-homogeneity-guardian-revision` · **27 Tasks** · 9 Phasen · Analysiert und korrigiert 2026-04-02 (H1, H2, H3, M1–M4) · Runde-3-Korrekturen: C1, I1, U1, L1–L4*
