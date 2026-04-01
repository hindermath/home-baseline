# Feature Specification: Workspace Homogeneity Guardian — Revision & Gap Fix
# Featurespezifikation: Workspace-Homogenitätswächter — Schwachstellen-Behebung

**Feature Branch**: `002-homogeneity-guardian-revision`  
**Created / Erstellt**: 2026-04-01  
**Status**: Draft  
**Bezugs-Lastenheft / Reference Lastenheft**: `Lastenheft_workspace-homogeneity-guardian-revision.md`  
**Depends on / Abhängig von**: `001-workspace-homogeneity-guardian` (Parent-Feature)  
**Verfassung / Constitution**: v1.1.0

## Zweck / Purpose

Ein Live-Audit der `home-baseline`-Umgebung hat 18 Schwachstellen (SW-01–SW-18) aufgedeckt.
Dieses Feature definiert alle Maßnahmen, die nötig sind, um den Ist-Zustand auf den
Zielstand des Parent-Features `001-workspace-homogeneity-guardian` zu bringen —
ohne bestehende Inhalte zu zerstören.

*A live audit of the `home-baseline` environment revealed 18 weaknesses (SW-01–SW-18).
This feature defines all remediation measures required to bring the current state
to the target defined in the parent feature `001-workspace-homogeneity-guardian` —
without destroying any existing content.*

---

## Audit-Ergebnisse / Audit Results (Ist-Zustand)

| ID | Schwachstelle / Weakness | Schweregrad / Severity |
|----|--------------------------|:----------------------:|
| SW-01 | Kein `bootstrap-project.sh/.ps1` | HOCH |
| SW-02 | Kein `check-homogeneity.sh/.ps1` | HOCH |
| SW-03 | Root-Agentendateien nicht bilingual | HOCH |
| SW-04 | Kein A11Y-Abschnitt in READMEs | MITTEL |
| SW-05 | Kein `STATS.md` auf keiner Ebene | MITTEL |
| SW-06 | Kein SDD-Workflow in Projekten | MITTEL |
| SW-07 | Pre-Push-Hook Ebene 2 ungeprüft | MITTEL |
| SW-08 | `Lastenheft*.md` nicht in `.gitignore`-Whitelist | MITTEL |
| SW-09 | Doppelter `!.specify/`-Eintrag in `.gitignore` | NIEDRIG |
| SW-10 | `copilot-instructions.md` unvollständig bilingual | NIEDRIG |
| SW-11 | Kein `rename-lastenheft.sh/.ps1` | NIEDRIG |
| SW-12 | CLI-Syntax der KI-Agenten-Init nicht spezifiziert | NIEDRIG |
| SW-13 | Kein `.editorconfig` in C#-Projekten | NIEDRIG |
| SW-14 | Kein Migrations-Pfad für bestehende Repos | HOCH |
| SW-15 | Kein Mechanismus zur Constitution-Propagation | MITTEL |
| SW-16 | Keine CI/CD-Integration | NIEDRIG |
| SW-17 | TUI-Ausgaben nicht auf A11Y geprüft | MITTEL |
| SW-18 | STATS.md-Kopfzeilen nicht bilingual | NIEDRIG |

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Developer migriert bestehende Repos auf Zielstand (Priorität: P1)

Ein Entwickler bringt alle bestehenden Workspace-Repositories (z. B. `RiderProjects`,
`C64Projects`) auf den Zielstand des Homogenitäts-Lastenhefts, ohne bestehende
Inhalte zu zerstören.

*A developer brings all existing workspace repositories to the target state of the
homogeneity Lastenheft without destroying existing content.*

**Why this priority / Warum P1**: Ohne einen Migrations-Pfad bleibt jeder Workspace
dauerhaft non-compliant. Dieses Szenario ist die Grundvoraussetzung für einen
messbaren Fortschritt.

**Independent Test**: `bash scripts/migrate-workspace.sh --dry-run RiderProjects`
listet alle geplanten Änderungen. Anschließend `bash scripts/migrate-workspace.sh RiderProjects`
und danach `bash scripts/check-homogeneity.sh` liefert für `RiderProjects` keinen `✗`-Befund mehr.

**Acceptance Scenarios**:

1. **Given** `RiderProjects/` hat keinen A11Y-Abschnitt und keinen EN-Bilingual-Marker,
   **When** `bash scripts/migrate-workspace.sh RiderProjects` läuft,
   **Then** werden die fehlenden Abschnitte als Platzhalter eingefügt, bestehende Inhalte
   bleiben unberührt, und ein Git-Commit `chore: migrate RiderProjects to homogeneity baseline v1.1.0` wird erzeugt.

2. **Given** `--dry-run`-Modus,
   **When** das Skript aufgerufen wird,
   **Then** zeigt es alle geplanten Einfügungen ohne eine einzige Datei zu verändern,
   und der Exit-Code ist `0`.

3. **Given** ein Verzeichnis, in dem alle Pflichtabschnitte bereits vorhanden sind,
   **When** das Migrationsskript erneut läuft (idempotenter Aufruf),
   **Then** erzeugt es keinen neuen Commit und meldet `INFO: already compliant — nothing to do`.

4. **Given** Level-2-Projekte (z. B. `RiderProjects/TinyCalc`) innerhalb eines migrierten Workspace,
   **When** das Migrationsskript läuft,
   **Then** prüft und installiert es den Pre-Push-Hook auf Level-2-Ebene.

---

### User Story 2 — Developer führt vollständigen Compliance-Nachweis durch (Priorität: P1)

Nach Abschluss aller Fix-Maßnahmen liefert `check-homogeneity.sh` für die gesamte
Umgebung einen Bericht ohne `✗`-Befunde.

*After completing all fixes, `check-homogeneity.sh` delivers a zero-failure report.*

**Why this priority / Warum P1**: Ohne das Compliance-Tool gibt es keinen messbaren
Beweis dafür, dass alle Schwachstellen tatsächlich behoben wurden.

**Independent Test**: `bash scripts/check-homogeneity.sh` auf der gesamten Umgebung →
Exit-Code `0`, alle Zeilen `✓` oder `WARN` (kein `✗`). Report enthält ASCII-Chart.

**Acceptance Scenarios**:

1. **Given** alle SW-01–SW-10 behoben,
   **When** `bash scripts/check-homogeneity.sh` ausgeführt wird,
   **Then** ist der Exit-Code `0` und alle Zeilen zeigen `✓` oder `WARN`.

2. **Given** ein frisch bootstrapptes Projekt,
   **When** der Scan unmittelbar danach läuft,
   **Then** meldet er `100 %` Compliance ohne manuelle Nacharbeit (SC-001).

3. **Given** `--json`-Flag,
   **When** der Scan läuft,
   **Then** gibt er `{"score": 100, "failures": [], "warnings": []}` aus.

---

### User Story 3 — Developer erfasst Baseline und verfolgt Fortschritt (Priorität: P2)

Der Entwickler erzeugt eine initiale `STATS.md`-Baseline mit dem Ist-Zustand
vor allen Fixes, damit der Fortschritt messbar und dokumentiert ist.

*The developer creates an initial `STATS.md` baseline capturing the current state
before all fixes, making progress measurable and documented.*

**Why this priority / Warum P2**: Ohne Baseline fehlt der Vergleichspunkt für
spätere Scans. Die Baseline ist die Grundlage für SC-REV-03.

**Independent Test**: `bash scripts/init-stats.sh` → `STATS.md` auf Level 0/1/2
enthält mindestens eine Baseline-Zeile mit Timestamp und Score.

**Acceptance Scenarios**:

1. **Given** kein `STATS.md` auf irgendeiner Ebene,
   **When** `bash scripts/init-stats.sh` läuft,
   **Then** werden `STATS.md`-Dateien auf Level 0, 1 und 2 angelegt mit je einem
   `## Run <timestamp>` Baseline-Eintrag, der den Ist-Score dokumentiert.

2. **Given** `STATS.md` bereits vorhanden,
   **When** `init-stats.sh` erneut läuft,
   **Then** hängt es einen neuen Baseline-Eintrag an (append-only) und überschreibt nichts.

3. **Given** mehrere aufeinanderfolgende Scans,
   **When** die `STATS.md` gelesen wird,
   **Then** zeigt das ASCII-Balkendiagramm einen messbaren Trend vom Ist-Zustand
   zum Zielzustand.

---

### User Story 4 — Developer propagiert Constitution-Änderungen (Priorität: P2)

Bei einer Versions-Erhöhung der zentralen `constitution.md` werden alle
Child-Workspaces automatisch (nach Bestätigung) auf die neue Version aktualisiert.

*When the central `constitution.md` version is bumped, all child workspaces
are updated automatically (after confirmation).*

**Why this priority / Warum P2**: Ohne einen Propagations-Mechanismus driftet die
Verfassung zwischen Repos auseinander — das Kernproblem des Homogenitäts-Features.

**Independent Test**: `bash scripts/sync-constitution.sh --dry-run` → listet alle
Workspaces, die aktualisiert würden; kein Schreibvorgang.

**Acceptance Scenarios**:

1. **Given** `constitution.md` wurde auf Version 1.2.0 erhöht,
   **When** `bash scripts/sync-constitution.sh` läuft und der Entwickler bestätigt,
   **Then** erhält jeder Child-Workspace eine aktualisierte `constitution.md`
   und einen Commit `chore: sync constitution to v1.2.0`.

2. **Given** `--dry-run`,
   **When** das Skript läuft,
   **Then** listet es alle Workspaces mit `WOULD UPDATE` ohne eine Datei zu ändern.

3. **Given** ein fehlgeschlagener Propagations-Lauf (z. B. Schreibrechte fehlen),
   **When** das Skript abbricht,
   **Then** werden alle bereits durchgeführten Änderungen zurückgerollt (`git stash`),
   und ein Fehler mit Diff ausgegeben.

---

### User Story 5 — Azubi verfolgt CI/CD-Checks in GitHub Actions (Priorität: P3)

Bei jedem Push auf einen Workspace-Branch läuft automatisch `check-homogeneity.sh`
in GitHub Actions und schlägt fehl, wenn `✗`-Befunde vorhanden sind.

*On every push to a workspace branch, `check-homogeneity.sh` runs automatically
in GitHub Actions and fails if any `✗` findings are present.*

**Why this priority / Warum P3**: CI-Integration ist wertvoll, aber optional — die
Homogenität kann auch ohne CI manuell geprüft werden.

**Independent Test**: Push auf `main` im `RiderProjects`-Repo → GitHub-Actions-Job
`homogeneity-check` läuft grün auf `ubuntu-22.04`.

**Acceptance Scenarios**:

1. **Given** ein Workspace-Push mit komplianten Dateien,
   **When** der GitHub-Actions-Workflow läuft,
   **Then** ist der Exit-Code `0` und der Job ist grün.

2. **Given** ein Workspace-Push mit einer fehlenden Pflichtdatei,
   **When** der Workflow läuft,
   **Then** schlägt der Job fehl (Exit-Code `1`) und der Report erscheint als
   GitHub Job Summary.

3. **Given** der Workflow,
   **Then** läuft er auf `ubuntu-22.04` (kostenlos im GitHub Free-Tier).

---

### Edge Cases / Randfälle

- Was passiert, wenn eine Datei bereits einen EN-Platzhalter hat?
  → `migrate-workspace.sh` überspringt diese Datei mit `INFO: EN block already present — skip`.

- Was passiert, wenn `bootstrap-project.sh` auf ein bereits initialisiertes Verzeichnis trifft?
  → `WARN: already bootstrapped — use --force to re-apply`; kein Abbruch anderer Schritte.

- Was passiert bei fehlgeschlagenem Constitution-Propagations-Lauf?
  → `git stash` in jedem teilweise geänderten Workspace; Fehlermeldung + Diff auf stderr.

- Was passiert, wenn der GitHub-Actions-Workflow in einem Repo ohne `check-homogeneity.sh` läuft?
  → Workflow schlägt mit `ERROR: check-homogeneity.sh not found — run bootstrap-project.sh first` fehl.

---

## Requirements *(mandatory)*

### Functional Requirements

#### REV-A — Migration bestehender Infrastruktur / Migration of Existing Infrastructure

- **FR-REV-A01**: Das System MUSS ein Skript `scripts/migrate-workspace.sh` (Bash) und
  `scripts/migrate-workspace.ps1` (PowerShell 7+) bereitstellen, das idempotent alle
  fehlenden Pflichtabschnitte in bestehende Dateien einfügt:
  bilingualen EN-Platzhalter-Block (am **Dateiende** als einziger Block im Format
  `<!-- EN: [Dateiname] placeholder\n[DE-Zusammenfassung als Kommentar]\n-->`),
  `## Barrierefreiheit / Accessibility (A11Y)`, `## Spec-kit-Workflow`,
  `## Für Azubis / For Apprentices`.
  **Scope der Bilingualisierung**: ausschließlich `README.md`, `CLAUDE.md`, `GEMINI.md`,
  `AGENTS.md`, `copilot-instructions.md`, `STATS.md` (nur Kopfzeilen) und `constitution.md`.
  Spec-Kit-Artefakte (`spec.md`, `plan.md`, `tasks.md`) und sonstige `.md`-Dateien
  bleiben unberührt.

- **FR-REV-A02**: Das Migrationsskript MUSS `--dry-run` / `-WhatIf` unterstützen
  und jeden geplanten Schreibvorgang vor der Ausführung anzeigen (außer im `--yes`/`-Force`-Modus).

- **FR-REV-A03**: Jeder Migrationslauf MUSS in einem Git-Commit enden mit der Message
  `chore: migrate {workspace} to homogeneity baseline v{version}`.

- **FR-REV-A04**: Das Migrationsskript MUSS auf Level-2-Ebene den Pre-Push-Hook-Status
  prüfen und bei Fehlen `install-hooks.sh` aufrufen.

- **FR-REV-A05**: Das Migrationsskript DARF NIEMALS bestehende Inhalte überschreiben —
  ausschließlich Einfügungen und Ergänzungen am Dateiende oder an markierten Stellen.

- **FR-REV-A06**: Bei Teilfehler während der Migration eines Workspace MUSS das Skript
  alle Änderungen des betroffenen Workspace via `git stash` zurückrollen, eine Fehlermeldung
  mit Diff auf stderr ausgeben, und danach mit dem nächsten Workspace fortfahren (andere
  Workspaces bleiben unberührt).

#### REV-B — Fehlende Skripte / Missing Scripts

- **FR-REV-B01**: `scripts/check-homogeneity.sh` / `.ps1` MUSS gemäß den Anforderungen
  FR-001–FR-021 des Parent-Features `001-workspace-homogeneity-guardian` implementiert werden.
  Der Compliance-Score wird berechnet als `score = ✓ / (✓ + ✗) × 100` (ungewichtet; WARN zählt
  nicht als Fehler). Im `--json`-Modus wird der Score als Integer `0–100` ausgegeben.

- **FR-REV-B02**: `scripts/bootstrap-project.sh` / `.ps1` MUSS gemäß den Anforderungen
  FR-009–FR-016 des Parent-Features implementiert werden.

- **FR-REV-B03**: `scripts/rename-lastenheft.sh` / `.ps1` MUSS implementiert werden:
  Aufruf `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` benennt die Datei
  via `git mv` um und erzeugt einen Commit `chore: rename Lastenheft to {new-name}`.

- **FR-REV-B04**: `scripts/init-stats.sh` / `.ps1` MUSS eine initiale `STATS.md` auf
  Level 0, 1 und 2 erzeugen, die den Ist-Zustand als Baseline festhält, und den
  STATS.md-Schema-Standard aus FR-007/008 des Parent-Features einhält.

#### REV-C — .gitignore-Bereinigung / .gitignore Cleanup

- **FR-REV-C01**: Die Root-`.gitignore` MUSS die Einträge `!Lastenheft*.md` und
  `!STATS.md` enthalten, damit diese Dateien versioniert werden.

- **FR-REV-C02**: Der doppelte Eintrag `!.specify/memory/` in der Root-`.gitignore`
  MUSS entfernt werden (Duplikat-Bereinigung).

#### REV-D — KI-Agenten-CLI-Syntax / AI Agent CLI Syntax

- **FR-REV-D01**: Das Bootstrap-Skript MUSS die genauen Init-Befehle aller vier
  Agenten-CLIs dokumentieren und aufrufen:
  Claude (`claude /init`), Codex (interaktiv, SKIP mit WARN),
  Gemini (interaktiv, SKIP mit WARN), Copilot (`gh extension exec github/gh-copilot`).

- **FR-REV-D02**: Das Bootstrap-Skript MUSS vor jedem Agenten-Aufruf die CLI-Verfügbarkeit
  per `which`/`Get-Command` prüfen; bei Fehlen: `WARN: {agent} CLI not found — install manually`.

#### REV-E — C#-Projekt-Härtung / C# Project Hardening

- **FR-REV-E01**: Jedes C#-Projekt MUSS eine `.editorconfig` mit Mindestregeln erhalten:
  `indent_style=space`, `indent_size=4`, `charset=utf-8`, `end_of_line=lf`,
  `insert_final_newline=true`.

- **FR-REV-E02**: Das Compliance-Check-Skript MUSS `.editorconfig` als Pflichtdatei für
  C#-Projekte in die Datei-Präsenzmatrix aufnehmen.

#### REV-F — Constitution-Propagation / Constitution Propagation

- **FR-REV-F01**: Das Skript `scripts/sync-constitution.sh` / `.ps1` MUSS bei
  Constitution-Versionsänderungen die neue `constitution.md` in alle Child-Workspaces
  kopieren, je Workspace einen Git-Commit `chore: sync constitution to v{version}` erzeugen,
  und eine Zusammenfassung der geänderten Workspaces ausgeben.
  Die Versionsnummer wird per `grep` aus der ersten Zeile der `constitution.md` extrahiert
  (Format: `# Constitution vMAJOR.MINOR.PATCH`). Fehlt diese Zeile, bricht das Skript mit
  `ERROR: constitution.md hat keine Versionszeile` ab.

- **FR-REV-F02**: Das Skript MUSS `--dry-run` / `-WhatIf` unterstützen; bei Fehler
  MUSS es alle Teiländerungen zurückrollen (`git stash`).

#### REV-G — CI/CD-Integration / CI/CD Integration

- **FR-REV-G01**: Jeder Workspace MUSS eine GitHub-Actions-Workflow-Datei
  `.github/workflows/homogeneity-check.yml` erhalten, die bei jedem Push
  `check-homogeneity.sh` für den eigenen Workspace ausführt.

- **FR-REV-G02**: Der Workflow MUSS bei `✗`-Befunden mit Exit-Code `1` fehlschlagen
  und den Report als GitHub Job Summary ausgeben.

- **FR-REV-G03**: Der Workflow MUSS auf `ubuntu-22.04` laufen
  (kostenlos im GitHub Free-Tier).

### Non-Functional Requirements / Nicht-funktionale Anforderungen

- **NFR-REV-01 Umsetzungsreihenfolge / Implementation Order**: Die Maßnahmen MÜSSEN
  in dieser Reihenfolge implementiert werden:
  (1) REV-C → (2) REV-B01 → (3) REV-B04 → (4) REV-A → (5) REV-B02 →
  (6) REV-B03 → (7) REV-D → (8) REV-E → (9) REV-F → (10) REV-G.

- **NFR-REV-02 Nicht-destruktiv / Non-destructive**: Alle Migrations- und
  Reparaturskripte DÜRFEN niemals existierende Inhalte überschreiben.

- **NFR-REV-03 Auditierbarkeit / Auditability**: Jeder Fix-Schritt MUSS einen
  eigenen Git-Commit mit Conventional-Commit-Message erzeugen.

- **NFR-REV-04 Plattform / Platform**: Alle Bash-Skripte erfordern Bash 5+;
  PowerShell-Varianten erfordern PowerShell Core 7+. Unterstützte Plattformen:
  macOS 14+, Ubuntu 22.04/24.04 LTS, Debian 12, Windows 10/11 (native + WSL2).

- **NFR-REV-05 Bilingualism in STATS.md / Bilingualität**: Alle STATS.md-Kopfzeilen
  MÜSSEN bilingual sein (DE zuerst, EN zweite Zeile, CEFR B2).

---

## Key Entities / Schlüsselobjekte

- **Schwachstelle (SW-xx)**: Ein identifizierter Ist-/Soll-Abstand aus dem Audit
  mit Schweregrad HOCH / MITTEL / NIEDRIG.
- **Migrationsskript**: Idempotentes Skript, das bestehende Dateien auf Zielstand
  bringt, ohne Inhalte zu zerstören.
- **Baseline**: Erster STATS.md-Eintrag, der den Ist-Zustand vor allen Reparaturen
  festhält — Vergleichspunkt für spätere Scans.
- **Constitution-Propagation**: Mechanismus zur synchronen Verteilung einer neuen
  Constitution-Version in alle Child-Repos.
- **EN-Platzhalter**: Markierter Block `<!-- EN: [Dateiname] placeholder -->` am
  **Ende** einer Pflichtdatei (ein Block pro Datei); wird von `migrate-workspace.sh`
  eingefügt, wenn die Datei noch keinen EN-Abschnitt enthält.

---

## Success Criteria / Erfolgskriterien

- **SC-REV-01**: `check-homogeneity.sh` liefert für alle Levels 0–2 Exit-Code `0`
  nach Abschluss aller Maßnahmen (kein einziger `✗`-Befund).

- **SC-REV-02**: Alle Root-Agentendateien (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`,
  `README.md`, `copilot-instructions.md`) enthalten je mindestens einen DE- und EN-Abschnitt.

- **SC-REV-03**: `STATS.md` auf Root-Ebene enthält eine Baseline-Zeile (Ist-Zustand)
  und mindestens eine Post-Fix-Zeile mit verbessertem Compliance-Score.

- **SC-REV-04**: `Lastenheft_workspace-homogeneity-guardian.md` ist in `.gitignore`
  als `!Lastenheft*.md` whitelisted und wird von `git status` als getracktes File angezeigt.

- **SC-REV-05**: `rename-lastenheft.sh` benennt eine Test-Datei korrekt um und
  erzeugt einen `git mv`-Commit mit der erwarteten Message.

- **SC-REV-06**: Der GitHub-Actions-Workflow läuft grün auf `ubuntu-22.04` nach
  einem Push auf den Default-Branch eines Workspace-Repos.

- **SC-REV-07**: Das Migrationsskript läuft auf `RiderProjects` und erhöht den
  Compliance-Score für diesen Workspace um mindestens 40 Prozentpunkte gegenüber dem
  Baseline-Scan.

---

## Assumptions / Annahmen

- Die bestehenden Pre-Push-Hooks auf Level 0–1 sind korrekt — nur Level 2 muss
  noch geprüft werden.
- Die Bilingualisierung bestehender Agentendateien erfolgt durch Platzhalter-Einfügung;
  inhaltliche Übersetzung ist eine nachgelagerte Aufgabe.
- GitHub Actions Free-Tier ist für alle privaten Repos des Users verfügbar
  (2 000 Minuten/Monat für private Repos).
- Die KI-Agenten-CLIs (`claude`, `codex`, `gemini`) sind optional; das Revisionsskript
  prüft ihre Verfügbarkeit vor jedem Aufruf.
- `git`, `bash ≥ 5`, und `ripgrep (rg)` sind auf allen Zielplattformen verfügbar.
- Das Parent-Feature `001-workspace-homogeneity-guardian` definiert das Zielschema;
  dieses Feature implementiert den Delta-Pfad vom Ist-Zustand dorthin.

---

## Dependencies / Abhängigkeiten

| Revisions-FR | Bezug / Reference |
|---|---|
| FR-REV-A01–A05 | FR-G01–G05 (README-Dokumentation, Parent 001) |
| FR-REV-B01 | FR-001–FR-021 (Homogenitätsprüfung, Parent 001) |
| FR-REV-B02 | FR-009–FR-016 (Bootstrap, Parent 001) |
| FR-REV-B03 | FR-012 (Dateibenennungs-Konvention, Parent 001) |
| FR-REV-B04 | FR-007/008 (STATS.md-Schema, Parent 001) |
| FR-REV-C01–C02 | FR-002 (Dateipräsenz-Prüfung, Parent 001) |
| FR-REV-D01–D02 | FR-009 Bootstrap-Agenten-Init |
| FR-REV-E01–E02 | FR-016 (C#-Dep-Scan erweitert) |
| FR-REV-F01–F02 | Constitution Prinzip IV (Workspace Isolation) |
| FR-REV-G01–G03 | NFR-REV-04 (Platform ubuntu-22.04) |

---

## Out of Scope / Nicht im Umfang

- Automatische inhaltliche Übersetzung (nur Platzhalter-Einfügung)
- Submodule-Unterstützung
- Docker/Container-Konfigurationen
- Nicht-Markdown-Dateiformate (außer `.csproj`, `.editorconfig`)
- Kostenpflichtige GitHub-Actions-Features (Artifacts-Storage > Free-Tier)

---

## Barrierefreiheit / Accessibility (A11Y)

- Alle CLI-Ausgaben verwenden ausschließlich Plain-Unicode-Zeichen (✓, ✗, →, !) —
  keine ANSI-Farbcodes, um Screenreader-Kompatibilität zu gewährleisten.
- Alle generierten Markdown-Dateien haben lückenlose Heading-Hierarchien und
  keine leeren Alt-Texte.
- Alle Tabellen haben Kopfzeilen.
- Abkürzungen werden beim ersten Vorkommen erklärt (SW = Schwachstelle, LTS, SDD).

---

## Dateibenennungs-Konvention / File Naming Convention

- **Vor Spec-kit-Lauf**: `Lastenheft_workspace-homogeneity-guardian-revision.md`
- **Nach Spec-kit-Lauf**: `Lastenheft_workspace-homogeneity-guardian-revision.002-homogeneity-guardian-revision.md`

---

## Clarifications / Klärungen

### Session 2026-04-01

- **Q: Soll `sync-constitution.sh` alle Workspaces immer synchronisieren oder nur geänderte?**
  → A: Nur Workspaces, bei denen die lokale Version von der Root-Version abweicht (diff-basiert).

- **Q: Soll `migrate-workspace.sh` auch Level-2-Projekte (Kind-Projekte) migrieren?**
  → A: Ja — rekursiv; Level-2-Projekte werden nach Level-1-Workspace migriert.

- **Q: Sollen GitHub-Actions-Workflows auch auf PRs laufen oder nur auf Push?**
  → A: Auf beides (`push` + `pull_request`) für maximale Frühwarnung.

- **Q: Was passiert bei Teilfehler in `migrate-workspace.sh`?**
  → A: `git stash`-Rollback für den betroffenen Workspace; Fehlermeldung + Diff auf stderr; andere Workspaces unberührt. (→ FR-REV-A06)

- **Q: Wie wird der Compliance-Score berechnet?**
  → A: `score = (Anzahl ✓) / (Anzahl ✓ + Anzahl ✗) × 100` — ungewichteter Prozentsatz bestandener Checks; jeder Check zählt gleich. WARN-Einträge zählen weder als ✓ noch als ✗. (→ FR-REV-B01)

- **Q: Wie ist das Constitution-Versionsschema definiert?**
  → A: Semver `vMAJOR.MINOR.PATCH`, manuell gepflegt als erste Zeile der `constitution.md` im Format `# Constitution vX.Y.Z`. Das Skript extrahiert die Version per `grep`; fehlt die Zeile, bricht es mit einem Fehler ab. (→ FR-REV-F01)

- **Q: Wo wird der EN-Platzhalter-Block eingefügt?**
  → A: Am Dateiende als einziger Block pro Datei im Format `<!-- EN: [Dateiname] placeholder\n[DE-Zusammenfassung als Kommentar]\n-->`. (→ FR-REV-A01)

- **Q: Welche Dateien erhalten den EN-Platzhalter?**
  → A: Nur `README.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `copilot-instructions.md`, `STATS.md` (Kopfzeilen), `constitution.md`. Spec-Kit-Artefakte und sonstige `.md`-Dateien bleiben unberührt. (→ FR-REV-A01)
