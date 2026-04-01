# Tasks: Workspace Homogeneity Guardian

**Input**: `specs/001-workspace-homogeneity-guardian/plan.md`  
**Branch**: `001-workspace-homogeneity-guardian`  
**Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md) | **Data Model**: [data-model.md](data-model.md)  
**Contracts**: [check-homogeneity-cli.md](contracts/check-homogeneity-cli.md) · [bootstrap-project-cli.md](contracts/bootstrap-project-cli.md)  
**Generated**: 2026-04-01

---

## Format: `[ID] [P?] [Story?] Beschreibung mit Dateipfad`

- **[P]**: Parallel ausführbar (andere Dateien, keine unbefriedigten Abhängigkeiten)
- **[USn]**: Zugehörige User Story (US1–US4)
- Genaue Dateipfade in jeder Beschreibung angegeben

---

## Phase 1: Setup (Gemeinsame Infrastruktur)

**Zweck / Purpose**: Verzeichnisstruktur vorbereiten, `.gitignore`-Whitelist validieren,
Verfassungs-Re-Check abschliessen — bevor der erste Quellcode entsteht.

- [ ] T001 Verifiziere `~/.gitignore`-Whitelist: prüfe dass `!scripts/`, `!specs/`, `!STATS.md`, `!STATS-archive*.md` und `!.specify/` vorhanden sind; ergänze ggf. fehlende Einträge in `~/.gitignore`
- [ ] T002 Erstelle Verzeichnis-Skeleton `scripts/lib/` und `scripts/templates/` (git verlangt mind. eine Datei je Dir — initial werden die Lib-Dateien in Phase 2/3 angelegt)
- [ ] T003 Bearbeite `specs/001-workspace-homogeneity-guardian/plan.md` §Constitution Post-Design Re-Check: markiere `.gitignore`-Punkte als erledigt (STATS-archive✓, scripts/✓, specs/✓); bestätige Constitution Gate vor erster Implementierung

---

## Phase 2: Foundational (Blocking-Voraussetzungen)

**Zweck / Purpose**: Die zwei Basisbibliotheken, von denen **alle** User Stories abhängen:
Traversal-Engine und Secret-Scanner. Müssen vollständig abgeschlossen sein, bevor
Phase 3 beginnt.

- [ ] T004 Erstelle `scripts/lib/hg-scan.sh` — 3-Ebenen-Traversal (`~/` → Workspaces → Projekte); `.git`-Erkennung für Workspace/Projekt-Qualifikation; Level ≥ 3 silently ignoriert; gibt pro Verzeichnis `(level, path, type)` aus (FR-001)
- [ ] T005 [P] Erstelle `scripts/lib/hg-scan.ps1` — PowerShell-Counterpart zu `hg-scan.sh` mit nativen PS-Idiomen (`Get-ChildItem`, `Test-Path`)
- [ ] T006 Erstelle `scripts/lib/hg-secrets.sh` — Secret-Pattern-Erkennung (`ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM-Header, Secret-Dateinamen); matched value IMMER als `[REDACTED]`, nur Dateiname + Zeile ausgeben; gilt für Standard/`--verbose`/`--json` (FR-003, R-01)
- [ ] T007 [P] Erstelle `scripts/lib/hg-secrets.ps1` — PowerShell-Counterpart zu `hg-secrets.sh`
- [ ] T008 Manuelle Syntax-Verifikation: `bash -n scripts/lib/hg-scan.sh && bash -n scripts/lib/hg-secrets.sh`; für PS: `pwsh -Command "Get-Command scripts/lib/hg-scan.ps1"`; alle ohne Fehler

---

## Phase 3: User Story 1 — Compliance Check (P1)

**Story-Ziel / Story Goal**: Developer führt `check-homogeneity.sh` aus und sieht sofort
ob alle 3 Ebenen konsistent sind — Dateipräsenz, Hook-Integrität, Bilingualität, A11Y, Secrets, SDD.

**Unabhängiger Test / Independent Test**: `bash scripts/check-homogeneity.sh --dry-run ~/`  
→ Tabellarischer Report ✓/✗/WARN pro Datei pro Ebene, ASCII-Balkendiagramm, Exit-Code 0 oder 1.
Kein STATS.md-Schreibzugriff erforderlich.

- [ ] T009 [US1] Erstelle `scripts/lib/hg-hook.sh` — SHA-256-Vergleich von `.git/hooks/pre-push` mit `~/scripts/hooks/pre-push`; `WARN: hook outdated` wenn Hash-Abweichung; `WARN: hook missing` wenn nicht vorhanden; `shasum -a 256` (macOS) / `sha256sum` (Linux/WSL) (FR-002, R-03)
- [ ] T010 [P] [US1] Erstelle `scripts/lib/hg-hook.ps1` — PowerShell-Counterpart; verwendet `Get-FileHash -Algorithm SHA256`
- [ ] T011 [P] [US1] Erstelle `scripts/lib/hg-bilingual.sh` — Heading-Keyword-Scan mit `rg`; DE-Pattern `Überblick|Verwendung|Einrichtung|Voraussetzungen|Azubi|...`; EN-Pattern `Overview|Usage|Setup|Prerequisites|...`; `[ $has_de -gt 0 ] && [ $has_en -gt 0 ] → PASS`; sonst `WARN: bilingual section missing` (FR-004, R-01)
- [ ] T012 [P] [US1] Erstelle `scripts/lib/hg-bilingual.ps1` — PowerShell-Counterpart; verwendet `Select-String`
- [ ] T013 [P] [US1] Erstelle `scripts/lib/hg-a11y.sh` — drei Checks: (1) Heading-Hierarchie-Lücken (`h1→h3` = WARN; Single-Heading = OK), (2) leere Alt-Texte `![]()` = WARN, (3) fehlender `<th>`/Header in Tabellen = WARN; kein FAIL (FR-005/006, R-02)
- [ ] T014 [P] [US1] Erstelle `scripts/lib/hg-a11y.ps1` — PowerShell-Counterpart zu `hg-a11y.sh`
- [ ] T015 [P] [US1] Erstelle `scripts/lib/hg-deps.sh` — bezahlte NuGet-Blockliste via `rg` in `*.csproj`; Blockliste: `DevExpress\.|Telerik\.|Syncfusion\.|Infragistics\.|MESCIUS\.|ComponentOne\.|GrapeCity\.|Actipro\.`; `WARN: paid dependency detected — <PackageName>`; kein FAIL (FR-016, R-06)
- [ ] T016 [P] [US1] Erstelle `scripts/lib/hg-deps.ps1` — PowerShell-Counterpart; verwendet `Get-Content` + `-match`
- [ ] T017 [P] [US1] Erstelle `scripts/lib/hg-speckit.sh` — liest `speckit_version` aus `~/.specify/init-options.json`; vergleicht mit aktivem `spec.md`-Header; `WARN: spec template version outdated` bei Abweichung; graceful skip wenn kein `.specify/` vorhanden (FR-018, R-05)
- [ ] T018 [P] [US1] Erstelle `scripts/lib/hg-speckit.ps1` — PowerShell-Counterpart; verwendet `ConvertFrom-Json`
- [ ] T019 [US1] Erstelle `scripts/check-homogeneity.sh` — Hauptskript: source alle `hg-*.sh`-Libs; traversiert per `hg-scan.sh`; ruft je Verzeichnis alle Check-Libs auf; baut tabellarischen Report + ASCII-Balkendiagramm + Datei-Präsenz-Matrix; unterstützt `--verbose` (alle Dateien), `--json` (Vorrang vor `--verbose`), `--dry-run` (kein STATS.md-Schreiben), `--fail-fast`, `--no-patch`; Exit-Codes 0/1/2; ANSI-Farben verboten (FR-001–006, FR-016–019; Contracts: check-homogeneity-cli.md)
- [ ] T020 [P] [US1] Erstelle `scripts/check-homogeneity.ps1` — PowerShell-Counterpart mit Parametern `-Verbose`, `-Json`, `-DryRun`, `-FailFast`, `-NoPatch`, `-ApplyPatch`; source alle `hg-*.ps1`-Libs via `. .\scripts\lib\hg-*.ps1`
- [ ] T021 [US1] Manuelle `--dry-run`-Verifikation: `bash scripts/check-homogeneity.sh --dry-run ~/`; bestätige tabellarischen Report, ASCII-Chart, Exit-Code 0 oder 1, kein STATS.md angelegt
- [ ] T022 [P] [US1] Manuelle `--json`-Verifikation: `bash scripts/check-homogeneity.sh --json ~/`; bestätige JSON-Struktur `{"score":N,"failures":[...],"warnings":[...]}`, kein Human-Output, REDACTED in allen Secret-Feldern

---

## Phase 4: User Story 2 — Bootstrap-Projekt (P2)

**Story-Ziel / Story Goal**: Developer (oder Azubi) führt `bootstrap-project.sh` einmal aus
und erhält ein vollständig konfiguriertes Projekt: Agenten-Dateien, Hook, bilinguale
Doku, A11Y-Sections, alle 4 KI-Agenten initialisiert, Spec-kit scaffold — idempotent.

**Unabhängiger Test / Independent Test**:  
`bash scripts/bootstrap-project.sh --preview <leeres-verzeichnis>`  
→ Listet alle 21 geplanten Aktionen, erstellt keine Datei.  
`bash scripts/bootstrap-project.sh <leeres-verzeichnis>` + `bash scripts/check-homogeneity.sh` auf Ergebnis  
→ 100 % Compliance Score (SC-001).

- [ ] T023 [US2] Erstelle `scripts/templates/CLAUDE.md.tmpl` — zweisprachige KI-Agenten-Vorlage (DE/EN); enthält Platzhalter `{{PROJECT_NAME}}`, `{{WORKSPACE}}`, Heading-Hierarchie ohne Lücken, kein leerer Alt-Text (FR-013, FR-014)
- [ ] T024 [P] [US2] Erstelle `scripts/templates/GEMINI.md.tmpl` — zweisprachige Gemini-Agenten-Vorlage analog CLAUDE.md.tmpl
- [ ] T025 [P] [US2] Erstelle `scripts/templates/AGENTS.md.tmpl` — zweisprachige Codex/AGENTS-Vorlage mit `{{PROJECT_NAME}}`, `{{WORKSPACE}}`, Azubi-Hinweis-Abschnitt
- [ ] T026 [P] [US2] Erstelle `scripts/templates/copilot-instructions.tmpl` — zweisprachige Copilot-Vorlage für `.github/copilot-instructions.md`; enthält Projekt-Kontext-Platzhalter
- [ ] T027 [P] [US2] Erstelle `scripts/templates/README.md.tmpl` — bilinguales README (DE/EN CEFR B2): `## Überblick / Overview`, `## Voraussetzungen / Prerequisites`, `## Für Azubis / For Apprentices` (Schritt-für-Schritt), `## Verwendung / Usage`; A11Y-konform; `{{PROJECT_NAME}}`, `{{WORKSPACE}}` Platzhalter (FR-013, FR-014)
- [ ] T028 [P] [US2] Erstelle `scripts/templates/gitignore-project.tmpl` — `.gitignore`-Vorlage für Level-2-Projekte: schützt typische C#-Build-Artefakte (`bin/`, `obj/`, `*.user`) und KI-Agenten-Verzeichnisse, erlaubt Pflichtdateien
- [ ] T029 [US2] Erstelle `scripts/bootstrap-project.sh` — 21-Schritt idempotenter Bootstrap:  
  (1) Zielverzeichnis prüfen/anlegen · (2) `.gitignore` aus Template · (3) `git init` · (4–7) Agenten-Dateien aus Templates · (8) README aus Template · (9) Hook von `~/scripts/hooks/pre-push` installieren · (10) `claude /init` (auto) · (11) `codex` Skip + WARN · (12) `gemini` Skip + WARN · (13) Copilot-Datei kopieren · (14) `gh repo create` (optional, graceful skip) · (15) npx speckit init (optional, graceful skip) · (16) npx speckit specify scaffold (optional) · (17) STATS.md anlegen · (18) FR-012-Hook für Lastenheft-Umbenennung installieren · (19) Initial-Commit · (20) `git push` (optional) · (21) Ausgabe Abschluss-Report; `--preview`-Modus liest alle Schritte ohne Schreibzugriff; idempotent: existierende Artefakte werden übersprungen (FR-009–016; Contract: bootstrap-project-cli.md)
- [ ] T030 [P] [US2] Erstelle `scripts/bootstrap-project.ps1` — PowerShell-Counterpart mit `-ProjectName`, `-TargetWorkspace`, `-Preview`, `-NoSpeckit`, `-NoRemote`, `-Force`-Parametern; spiegelt alle 21 Schritte mit PS-nativen Cmdlets
- [ ] T031 [US2] Manuelle `--preview`-Verifikation: `bash scripts/bootstrap-project.sh --preview ~/tmp/test-project`; bestätige dass alle 21 Aktionen gelistet werden, kein Verzeichnis angelegt, Exit-Code 0
- [ ] T032 [US2] Vollständige Bootstrap-Verifikation: `bash scripts/bootstrap-project.sh ~/tmp/test-project2`; dann `bash scripts/check-homogeneity.sh ~/tmp/test-project2`; erwarteter Score 100 % (SC-001); danach `rm -rf ~/tmp/test-project2`

---

## Phase 5: User Story 3 — Statistiken & Memory Patch (P3)

**Story-Ziel / Story Goal**: Developer sieht nach mehreren Runs wie sich der Compliance-Score
entwickelt — ASCII-Charts ohne externe Tools; Memory-Patch-Datei wird bei Triggern generiert.

**Unabhängiger Test / Independent Test**:  
3× `bash scripts/check-homogeneity.sh ~/` ausführen → `~/STATS.md` enthält 3 Einträge,
ASCII-Balkendiagramm, Datei-Präsenz-Matrix; kein Eintrag wurde verändert (SC-004).

- [ ] T033 [US3] Erstelle `scripts/lib/hg-stats.sh` — STATS.md-Schreiber: `mkdir`-Lock (atomic, 5 s Timeout), append-only `## Run YYYY-MM-DD HH:MM`-Eintrag (Kollisions-Suffix `:2`/`:3` bei Doppel-Timestamp), Tabelle `Level | Dir | Score %`, ASCII-Balkendiagramm (max. 40 Zeichen), Datei-Präsenz-Matrix; Archivierung bei ≥ 500 Einträgen nach `STATS-archive-YYYY.md`; Lock-Cleanup auch bei Exit (FR-007/008, R-04)
- [ ] T034 [P] [US3] Erstelle `scripts/lib/hg-stats.ps1` — PowerShell-Counterpart; verwendet `.Lock`-Datei via `New-Item -ItemType Directory` für atomares Lock
- [ ] T035 [US3] Erstelle `scripts/lib/hg-patch.sh` — `memory-patch.md`-Generator: prüft 3 Trigger-Bedingungen (neues Repo erkannt / Score-Delta ≥ 10 % / neuer WARN/FAIL-Typ); baut `MemoryPatchEntry`-Liste mit Routing-Schema (constitution/agent_file/readme); schreibt `memory-patch.md` in SPECS_DIR; kein Output wenn kein Trigger auslöst (FR-020/021)
- [ ] T036 [P] [US3] Erstelle `scripts/lib/hg-patch.ps1` — PowerShell-Counterpart zu `hg-patch.sh`
- [ ] T037 [US3] Integriere `hg-stats.sh` und `hg-patch.sh` in `scripts/check-homogeneity.sh`: nach dem Scan `hg-stats.sh` aufrufen (außer `--dry-run`); `hg-patch.sh` aufrufen (außer `--dry-run` oder `--no-patch`); `--apply-patch <path>` als eigenständiger Modus implementieren (liest + zeigt + bestätigt + committet); Änderung in `scripts/check-homogeneity.ps1` spiegeln
- [ ] T038 [US3] Manuelle 3-Run STATS.md-Verifikation: `check-homogeneity.sh` 3× hintereinander ausführen; Prüfe: 3 `## Run`-Headings vorhanden, ASCII-Chart sichtbar, kein Eintrag überschrieben, Lock-Datei nach jedem Run entfernt (SC-004)
- [ ] T039 [US3] Memory-Patch-Verifikation: einen WARN/FAIL-Score-Trigger erzeugen (z.B. GEMINI.md umbenennen); `check-homogeneity.sh` ausführen; prüfe `memory-patch.md` erzeugt; `check-homogeneity.sh --apply-patch memory-patch.md` ausführen; bestätige Agenten-Datei aktualisiert + git-Commit vorhanden; GEMINI.md zurückbenennen

---

## Phase 6: User Story 4 — Azubi-Dokumentation & Cross-Platform (P3)

**Story-Ziel / Story Goal**: Azubi auf Ubuntu 22.04 LTS (oder WSL2) folgt nur dem
`README.md`-Azubi-Abschnitt und bootstrapt erfolgreich ein C#-CLI-Projekt (100 % Score,
nur freie Tools) — ohne Senior-Hilfe.

**Unabhängiger Test / Independent Test**:  
Azubi-Anleitung in `~/README.md §Für Azubis` von Anfang bis Ende befolgen →
`check-homogeneity.sh` meldet 100 % für das neue Projekt (SC-005).

- [ ] T040 [US4] Aktualisiere `~/README.md`: füge bilingualen `## Für Azubis / For Apprentices`-Abschnitt ein mit Schritt-für-Schritt-Anleitung (`bootstrap-project.sh`, `check-homogeneity.sh`, typische WARN-Behebung); sudo-Hinweise für Ubuntu; Voraussetzungs-Checkliste; A11Y-konform (FR-013, FR-014, SC-005)
- [ ] T041 [P] [US4] Verifiziere FR-012 Lastenheft-Umbenennung: `speckit specify` auf Test-Projekt ausführen, Feature-Branch `001-test-branch` zuweisen; Prüfe ob Lastenheft-Datei Suffix `001-test-branch` erhält + git-Commit dokumentiert Umbenennung (SC-008)
- [ ] T042 [US4] WSL2-End-to-End-Verifikation: in WSL2-Terminal (Ubuntu 22.04 LTS) `bootstrap-project.sh` + `check-homogeneity.sh` ausführen; Prüfe identisches Output wie auf nativem Linux; NTFS-Lock-Verhalten beobachten (FR-015)
- [ ] T043 [P] [US4] A11Y-Compliance-Verifikation aller generierten Dateien: `hg-a11y.sh` gegen alle `.md`-Dateien unter `~/tmp/test-project2/` und `~/`; Prüfe: keine leeren Alt-Texte, keine Heading-Lücken, kein `FAIL`-Output; alle `WARN` dokumentieren (SC-006)

---

## Phase 7: Polish & Abschluss

**Zweck / Purpose**: Security-Gate, finale Compliance, Commit, Push.

- [ ] T044 Security-Gate: `bash scripts/scan-agent-secrets.sh --fail-on-high .`; kein HIGH-Befund erlaubt; bei Befund: betreffende Datei prüfen und bereinigen
- [ ] T045 Aktualisiere `specs/001-workspace-homogeneity-guardian/plan.md` §Constitution Post-Design Re-Check: markiere alle `.gitignore`-Punkte als `✅ erledigt`; SHA-256-Vergleich-Notiz bestätigen
- [ ] T046 Finale Compliance-Prüfung: `bash scripts/check-homogeneity.sh --verbose ~/`; Ziel: Score ≥ 90 %; alle verbleibenden WARNs dokumentieren oder beheben
- [ ] T047 [P] Finale PS-Syntax-Prüfung: `pwsh -Command "& { . scripts/check-homogeneity.ps1; . scripts/bootstrap-project.ps1 }"` ohne Fehler
- [ ] T048 Alle neuen Dateien stagen: `git add scripts/ specs/001-workspace-homogeneity-guardian/tasks.md ~/README.md`; Commit: `feat(scripts): check-homogeneity + bootstrap-project implementation complete`
- [ ] T049 Push: `git push origin 001-workspace-homogeneity-guardian`; bestätige pre-push Hook läuft + kein Abbruch durch Secret-Scanner

---

## Abhängigkeitsgraph / Dependency Graph

```text
Phase 1 (Setup)
  └── Phase 2 (Foundational: hg-scan + hg-secrets)
        └── Phase 3 (US1: alle hg-check-libs + check-homogeneity)
              ├── Phase 4 (US2: Templates + bootstrap-project)  [unabhängig von Phase 5]
              ├── Phase 5 (US3: hg-stats + hg-patch → in check-homogeneity integrieren)
              │     [T037 MUSS NACH T019/T020 — integriert in Hauptskript]
              └── Phase 6 (US4: Docs + Verifikation)
                    └── Phase 7 (Polish + Push)
```

**Parallele Ausführung je Phase**:

| Phase | Parallel-Gruppe A | Parallel-Gruppe B |
|-------|-------------------|-------------------|
| Phase 2 | T004, T006 (Bash libs) | T005, T007 (PS libs) |
| Phase 3 | T009, T011, T013, T015, T017 (Bash libs) | T010, T012, T014, T016, T018 (PS libs) |
| Phase 3 | T019 (check-homogeneity.sh) | T020 (check-homogeneity.ps1, nach T019) |
| Phase 4 | T023 (CLAUDE.tmpl) | T024–T028 alle Templates parallel |
| Phase 4 | T029 (bootstrap.sh) | T030 (bootstrap.ps1) |
| Phase 5 | T033, T035 (Bash libs) | T034, T036 (PS libs) |
| Phase 6 | T040 (README update) | T041, T043 (Verifikationen) |
| Phase 7 | T044 (Security) | T046, T047 (Compliance + PS) |

---

## Implementierungsstrategie / Implementation Strategy

**MVP-Scope** (nur US1 — standalone lieferbar):
T001–T022 (Phase 1–3) → `check-homogeneity.sh` ist vollständig funktional als Read-only-Audit-Tool ohne Bootstrap und ohne STATS.md.

**Inkrementelle Lieferung**:
1. MVP: T001–T022 → Compliance Check läuft, exits 0/1/2
2. Increment 2: T023–T032 → Bootstrap-Tool fertig; Compliance Check validiert Bootstrap-Ergebnis
3. Increment 3: T033–T039 → STATS.md tracking + Memory Patch aktiv
4. Final: T040–T049 → Azubi-Doku, Cross-Platform-Tests, Security-Gate, Push

**Manuelle Testpunkte** (Constitution Principle V — Manual-First):
- T008: Syntax-Check libs
- T021, T022: US1 Independent Test (--dry-run + --json)
- T031, T032: US2 Independent Test (--preview + vollständiger Bootstrap)
- T038, T039: US3 Independent Test (3-Run STATS + apply-patch)
- T042, T043: US4 Cross-Platform + A11Y

---

## Statistik / Task Statistics

| Phase | Story | Tasks | Parallel [P] |
|-------|-------|-------|--------------|
| Phase 1 | — | 3 | 0 |
| Phase 2 | — | 5 | 2 |
| Phase 3 | US1 (P1) | 14 | 9 |
| Phase 4 | US2 (P2) | 10 | 7 |
| Phase 5 | US3 (P3) | 7 | 3 |
| Phase 6 | US4 (P3) | 4 | 2 |
| Phase 7 | — | 6 | 2 |
| **Gesamt** | | **49** | **25** |
