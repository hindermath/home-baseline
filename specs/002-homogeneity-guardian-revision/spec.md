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

| ID | Schwachstelle / Weakness | Schweregrad / Severity | FR/NFR |
|----|--------------------------|:----------------------:|--------|
| SW-01 | Kein `bootstrap-project.sh/.ps1` | HOCH | FR-REV-B02 |
| SW-02 | Kein `check-homogeneity.sh/.ps1` | HOCH | FR-REV-B01 |
| SW-03 | Root-Agentendateien nicht bilingual | HOCH | FR-REV-A01 |
| SW-04 | Kein A11Y-Abschnitt in READMEs | MITTEL | FR-REV-A01 |
| SW-05 | Kein `STATS.md` auf keiner Ebene | MITTEL | FR-REV-B04 |
| SW-06 | Kein SDD-Workflow in Projekten | MITTEL | FR-REV-B05 |
| SW-07 | Pre-Push-Hook Ebene 2 ungeprüft | MITTEL | FR-REV-A04 |
| SW-08 | `Lastenheft*.md` nicht in `.gitignore`-Whitelist | MITTEL | FR-REV-C01 |
| SW-09 | Doppelter `!.specify/`-Eintrag in `.gitignore` | NIEDRIG | FR-REV-C02 |
| SW-10 | `copilot-instructions.md` unvollständig bilingual | NIEDRIG | FR-REV-A01 |
| SW-11 | Kein `rename-lastenheft.sh/.ps1` | NIEDRIG | FR-REV-B03 |
| SW-12 | CLI-Syntax der KI-Agenten-Init nicht spezifiziert | NIEDRIG | FR-REV-D01/D02 |
| SW-13 | Kein `.editorconfig` in C#-Projekten | NIEDRIG | FR-REV-E01 |
| SW-14 | Kein Migrations-Pfad für bestehende Repos | HOCH | FR-REV-A01–A06 |
| SW-15 | Kein Mechanismus zur Constitution-Propagation | MITTEL | FR-REV-F01/F02 |
| SW-16 | Keine CI/CD-Integration | NIEDRIG | FR-REV-G01–G03 |
| SW-17 | TUI-Ausgaben nicht auf A11Y geprüft | MITTEL | NFR-REV-07 |
| SW-18 | STATS.md-Kopfzeilen nicht bilingual | NIEDRIG | NFR-REV-05 |

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Developer migriert bestehende Repos auf Zielstand (Priorität: P1)

Ein Entwickler bringt alle bestehenden Workspace-Repositories (z. B. `MyProjects`,
`HobbyProjects`) auf den Zielstand des Homogenitäts-Lastenhefts, ohne bestehende
Inhalte zu zerstören.

*A developer brings all existing workspace repositories to the target state of the
homogeneity Lastenheft without destroying existing content.*

**Why this priority / Warum P1**: Ohne einen Migrations-Pfad bleibt jeder Workspace
dauerhaft non-compliant. Dieses Szenario ist die Grundvoraussetzung für einen
messbaren Fortschritt.

**Independent Test**: `bash scripts/migrate-workspace.sh --dry-run MyProjects`
listet alle geplanten Änderungen. Anschließend `bash scripts/migrate-workspace.sh MyProjects`
und danach `bash scripts/check-homogeneity.sh` liefert für `MyProjects` keinen `✗`-Befund mehr.

**Acceptance Scenarios**:

1. **Given** `MyProjects/` hat keinen A11Y-Abschnitt und keinen EN-Bilingual-Marker,
   **When** `bash scripts/migrate-workspace.sh MyProjects` läuft,
   **Then** werden die fehlenden Abschnitte als Platzhalter eingefügt, bestehende Inhalte
   bleiben unberührt, und ein Git-Commit `chore: migrate MyProjects to homogeneity baseline v1.1.0` wird erzeugt.

2. **Given** `--dry-run`-Modus,
   **When** das Skript aufgerufen wird,
   **Then** zeigt es alle geplanten Einfügungen ohne eine einzige Datei zu verändern,
   und der Exit-Code ist `0`.

3. **Given** ein Verzeichnis, in dem alle Pflichtabschnitte bereits vorhanden sind,
   **When** das Migrationsskript erneut läuft (idempotenter Aufruf),
   **Then** erzeugt es keinen neuen Commit und meldet `INFO: already compliant — nothing to do`.

4. **Given** Level-2-Projekte (z. B. `MyProjects/example-project`) innerhalb eines migrierten Workspace,
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

1. **Given** alle SW-01–SW-18 behoben,
   **When** `bash scripts/check-homogeneity.sh` ausgeführt wird,
   **Then** ist der Exit-Code `0` und alle Zeilen zeigen `✓` oder `WARN`.

2. **Given** ein frisch bootstrapptes Projekt,
   **When** der Scan unmittelbar danach läuft,
   **Then** meldet er `100 %` Compliance ohne manuelle Nacharbeit (SC-001).

3. **Given** `--json`-Flag,
   **When** der Scan läuft,
   **Then** gibt er `{"score": 100, "by_level": {"0": 100, "1": 100, "2": 100}, "failures": [], "warnings": []}` aus.

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
   zum Zielzustand; jede Zeile im Format `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%`.

---

### User Story 4 — Developer propagiert Constitution-Änderungen (Priorität: P2)

Bei einer Versions-Erhöhung der zentralen `constitution.md` werden alle
Level-1-Workspaces automatisch (nach Bestätigung) auf die neue Version aktualisiert.

*When the central `constitution.md` version is bumped, all child workspaces
are updated automatically (after confirmation).*

**Why this priority / Warum P2**: Ohne einen Propagations-Mechanismus driftet die
Verfassung zwischen Repos auseinander — das Kernproblem des Homogenitäts-Features.

**Independent Test**: `bash scripts/sync-constitution.sh --dry-run` → listet alle
Workspaces, die aktualisiert würden; kein Schreibvorgang.

**Acceptance Scenarios**:

1. **Given** `constitution.md` wurde auf Version 1.2.0 erhöht,
   **When** `bash scripts/sync-constitution.sh` läuft und der Entwickler bestätigt,
   **Then** erhält jeder Level-1-Workspace eine aktualisierte `constitution.md`
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

**Independent Test**: Push auf `main` im `MyProjects`-Repo → GitHub-Actions-Job
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
   **Then** läuft er als Matrix auf `ubuntu-22.04`, `macos-14` und `windows-latest` (NFR-REV-04).

---

### Edge Cases / Randfälle

- Was passiert, wenn eine Datei bereits einen EN-Platzhalter hat?
  → `migrate-workspace.sh` überspringt diese Datei mit `INFO: EN block already present — skip`.

- Was passiert, wenn ein Pflichtabschnitt (`## Barrierefreiheit / Accessibility (A11Y)` etc.) bereits vorhanden ist?
  → Exakter String-Match: Findet das Skript den genauen Heading-Text in der Datei,
  überspringt es diesen Abschnitt mit `INFO: section already present — skip`.
  Schlüsselwort-Treffer ohne exakten Match gelten nicht als vorhanden.

- Was passiert, wenn `bootstrap-project.sh` auf ein bereits initialisiertes Verzeichnis trifft?
  → `WARN: already bootstrapped — use --force to re-apply`; kein Abbruch anderer Schritte.

- Was passiert, wenn das GitHub-Remote-Repo bei `gh repo create` bereits existiert?
  → `bootstrap-project.sh` prüft zunächst per `git remote -v` ob ein Remote konfiguriert ist;
  ist ein Remote vorhanden, wird `gh repo create` übersprungen mit
  `INFO: remote already configured — skipping gh repo create`; kein Abbruch.

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
  **Zieldatei für die drei Abschnitte**: ausschließlich `README.md` je Workspace/Level.
  KI-Agenten-Dateien (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `copilot-instructions.md`)
  erhalten **nur** den EN-Platzhalter-Block, nicht die drei Abschnitte.
  Der Body-Inhalt der drei Abschnitte wird aus **Template-Dateien** gelesen:
  `scripts/templates/a11y-section.md`, `scripts/templates/speckit-workflow-section.md`,
  `scripts/templates/azubis-section.md`. Die Templates MÜSSEN **bilingualen Inhalt**
  enthalten (DE zuerst, EN zweite Zeile/Abschnitt, CEFR B2) — konsistent mit
  dem Projekt-Grundsatz „DE first, EN second". Fehlt eine Template-Datei, bricht das Skript
  mit `ERROR: template not found: scripts/templates/{name}` ab.
  **Argumentverhalten**: Wird ein Workspace-Name übergeben, migriert das Skript nur diesen
  Workspace. Wird **kein Argument** übergeben, migriert es alle Level-1-Workspaces in `~/`
  sequentiell (Alle-auf-einmal-Modus); jeder Workspace durchläuft denselben
  Preview-→-Commit-Zyklus.
  Das Skript erstellt zudem `.github/workflows/homogeneity-check.yml` falls noch nicht
  vorhanden — sowohl in Level-1-Workspaces **als auch** in Level-2-Projekten
  (Inhalt gemäß FR-REV-G01–G03; der CI-Aufruf nutzt `basename "$GITHUB_WORKSPACE"` als
  Workspace-Argument); existiert die Datei bereits, wird sie übersprungen mit
  `INFO: homogeneity-check.yml already present — skip`.
  **Scope der Bilingualisierung**: ausschließlich `README.md`, `CLAUDE.md`, `GEMINI.md`,
  `AGENTS.md`, `.github/copilot-instructions.md`, `STATS.md` (nur Kopfzeilen) und `constitution.md`.
  Spec-Kit-Artefakte (`spec.md`, `plan.md`, `tasks.md`) und sonstige `.md`-Dateien
  bleiben unberührt.

- **FR-REV-A02**: Das Migrationsskript MUSS `--dry-run` / `-WhatIf` unterstützen
  und jeden geplanten Schreibvorgang vor der Ausführung anzeigen. Im Normalmodus
  wird nach der Preview eine interaktive Prompt `Proceed? [y/N]` angezeigt.
  Im **Alle-auf-einmal-Modus** (kein Argument) erscheint eine einzige Gesamt-Preview
  aller Workspaces, gefolgt von einer einzigen `Proceed? [y/N]` — keine separate
  Bestätigung pro Workspace.
  Der Flag `--yes` / `-Force` überspringt nur diese Bestätigungsprompt — die
  Preview-Ausgabe erscheint weiterhin; stille Ausführung ohne Preview ist nicht vorgesehen.

- **FR-REV-A03**: Jeder Migrationslauf MUSS in einem Git-Commit enden mit der Message
  `chore: migrate {workspace} to homogeneity baseline v{version}`.
  `{version}` wird per `grep` aus der ersten Zeile der Root-`constitution.md` extrahiert
  (Format: `# Constitution vX.Y.Z`) — dieselbe Quelle wie FR-REV-F01.
  **STATS.md-Baseline**: Nach dem Git-Commit MUSS `migrate-workspace.sh` automatisch
  `bash scripts/init-stats.sh` aufrufen, um eine STATS.md-Baseline (Post-Migrations-Ist-Zustand)
  für jeden migrierten Workspace zu erzeugen.

- **FR-REV-A04**: Das Migrationsskript MUSS auf Level-2-Ebene den Pre-Push-Hook-Status
  prüfen und bei Fehlen `install-hooks.sh` aufrufen. Als Level-2-Projekt gilt jedes
  Unterverzeichnis eines Level-1-Workspace, das ein eigenes `.git/`-Verzeichnis enthält
  (Git als Wahrheitsquelle — keine externe Konfigurationsdatei erforderlich).
  **Hook-Template-Quelle**: `migrate-workspace.sh` wechselt ins Level-2-Verzeichnis und
  ruft `bash {level1-workspace}/scripts/install-hooks.sh` auf — verwendet das
  Hook-Template (`scripts/hooks/pre-push`) des unmittelbaren Level-1-Parent-Workspace.
  Das Root-`scripts/install-hooks.sh` wird für Level-2 nicht verwendet.

- **FR-REV-A05**: Das Migrationsskript DARF NIEMALS bestehende Inhalte überschreiben —
  ausschließlich Einfügungen und Ergänzungen am Dateiende oder an markierten Stellen.

- **FR-REV-A06**: Bei Teilfehler während der Migration eines Workspace MUSS das Skript
  alle Änderungen des betroffenen Workspace via `git stash` zurückrollen, eine Fehlermeldung
  mit Diff auf stderr ausgeben, und danach mit dem nächsten Workspace fortfahren (andere
  Workspaces bleiben unberührt). Schlägt `git stash` selbst fehl, MUSS das Skript mit
  `ERROR: git stash fehlgeschlagen — manuelle Bereinigung erforderlich` und Exit-Code `2`
  abbrechen; keine weiteren Workspaces werden verarbeitet.

#### REV-B — Fehlende Skripte / Missing Scripts

- **FR-REV-B01**: `scripts/check-homogeneity.sh` / `.ps1` MUSS gemäß den Anforderungen
  FR-001–FR-021 des Parent-Features `001-workspace-homogeneity-guardian` implementiert werden.
  Der Compliance-Score wird berechnet als `score = ✓ / (✓ + ✗) × 100` (ungewichtet; WARN zählt
  nicht als Fehler). Im `--json`-Modus wird ein **aggregierter Gesamt-Score** plus
  **Score pro Ebene** ausgegeben:
  `{"score": 75, "by_level": {"0": 100, "1": 80, "2": 60}, "failures": [...], "warnings": []}`.
  **Klartext-Ausgabeformat** (Standard ohne `--json`): eine Zeile pro Check im Format
  `[✓|✗|WARN] Level-N  {datei}  {check-name}`, abschließend eine Score-Zeile
  `Score: 75% (15/20 checks passed)` sowie das ASCII-Chart im STATS.md-Format.
  **STATS.md-Check**: Das Skript prüft `STATS.md` ausschließlich auf **Vorhandensein**
  (Datei existiert → PASS; fehlt → FAIL). Inhalt und Gültigkeit des ASCII-Charts werden
  nicht geprüft — konsistent mit dem Präsenz-Prinzip aller anderen Pflichtdateien.
  **Argument-Interface**: `check-homogeneity.sh [workspace-name]` — ohne Argument: globaler
  Scan aller Level 0–2; mit optionalem Workspace-Namen: nur dieser Level-1-Workspace
  und seine Level-2-Projekte werden geprüft (Level-0-Checks entfallen).
  Jeder Failure-Eintrag ist ein strukturiertes Objekt:
  `{"file": "<relativer Pfad>", "check": "<Prüfname>", "level": <0|1|2>}`.
  Beispiel-Ausgabe mit Befunden:
  `{"score": 75, "by_level": {"0": 100, "1": 80, "2": 60}, "failures": [{"file": "README.md", "check": "A11Y section", "level": 0}], "warnings": []}`.

- **FR-REV-B02**: `scripts/bootstrap-project.sh` / `.ps1` MUSS gemäß den Anforderungen
  FR-009–FR-016 des Parent-Features implementiert werden.
  **README-Template**: Das Skript MUSS `scripts/templates/readme-template.md` als
  Basis für die neue `README.md` verwenden. Dieses Template enthält bereits alle
  Pflichtabschnitte (`## Barrierefreiheit / Accessibility (A11Y)`, `## Spec-kit-Workflow`,
  `## Für Azubis / For Apprentices`) und den EN-Platzhalter-Block — sodass ein frisch
  gebooststrapptes Projekt sofort 100 % compliant ist ohne nachträglichen
  `migrate-workspace.sh`-Lauf. Fehlt das Template, bricht das Skript mit
  `ERROR: template not found: scripts/templates/readme-template.md` ab.
  **CI-Workflow**: Das Skript MUSS `.github/workflows/homogeneity-check.yml` direkt beim
  Anlegen des Projekts erstellen (gleicher Inhalt wie FR-REV-G01–G03).
  **constitution.md**: Das Skript MUSS `~/constitution.md` (Level-0-Root) als initiale
  `constitution.md` ins neue Projekt kopieren. `sync-constitution.sh` übernimmt spätere
  Updates. Fehlt `~/constitution.md`, bricht das Skript mit
  `ERROR: root constitution.md not found at ~/constitution.md` ab.
  **STATS.md-Baseline**: Am Ende des Bootstrap-Runs MUSS das Skript automatisch
  `bash scripts/init-stats.sh` aufrufen, um eine initiale STATS.md-Baseline für das
  neue Projekt zu erzeugen.

- **FR-REV-B03**: `scripts/rename-lastenheft.sh` / `.ps1` MUSS implementiert werden:
  Aufruf `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` benennt die Datei
  via `git mv` um und erzeugt einen Commit `chore: rename Lastenheft to {new-name}`.
  **Ziel-Dateinamenformel**: `{original-stem}.{branch-name}.md` —
  der Stem (Dateiname ohne `.md`) der Originaldatei + Punkt + Branch-Name + `.md`.
  Beispiel: `Lastenheft_foo.md` + Branch `002-bar` → `Lastenheft_foo.002-bar.md`.

- **FR-REV-B04**: `scripts/init-stats.sh` / `.ps1` MUSS eine initiale `STATS.md` auf
  Level 0, 1 und 2 erzeugen, die den Ist-Zustand als Baseline festhält, und den
  STATS.md-Schema-Standard aus FR-007/008 des Parent-Features einhält.
  **Granularität Level 2**: Jedes Level-2-Projekt erhält eine **eigene `STATS.md`**
  in seinem Projektstammverzeichnis — eine Datei pro Projekt, nicht aggregiert.
  **ASCII-Chart-Format**: horizontale Balken, eine Zeile pro Scan-Run:
  `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%`
  (█ = belegter Anteil, ░ = freier Anteil, Gesamtbreite 20 Zeichen = 100 %;
  Score wird auf nächste 5 % gerundet für die Balkendarstellung).
  Zur Score-Ermittlung ruft `init-stats.sh` intern `check-homogeneity.sh --json` auf
  und extrahiert den `score`-Wert aus dem JSON-Output. Ist `check-homogeneity.sh`
  nicht ausführbar, bricht das Skript mit
  `ERROR: check-homogeneity.sh nicht gefunden — zuerst FR-REV-B01 implementieren` ab.

- **FR-REV-B05**: `scripts/bootstrap-project.sh` MUSS spec-kit im neuen Projekt
  initialisieren: `.specify/`-Verzeichnis anlegen, `create-new-feature.sh` installieren,
  einen Verweis auf den SDD-Workflow in `AGENTS.md` einfügen, sodass nach Ausführung
  ein `speckit-specify`-Aufruf sofort möglich ist. *(behebt SW-06)*
  Zusätzlich MUSS das Skript spec-kit für alle vier KI-Agenten initialisieren:
  ```
  speckit specify init --here --ai claude
  speckit specify init --here --ai gemini
  speckit specify init --here --ai copilot
  speckit specify init --here --ai codex --ai-skills
  ```
  Ist eine `speckit`-CLI nicht verfügbar, gibt das Skript
  `WARN: speckit not found — run manually: speckit specify init --here --ai {agent}` aus
  und fährt fort.

#### REV-C — .gitignore-Bereinigung / .gitignore Cleanup

- **FR-REV-C01**: Die Root-`.gitignore` MUSS die Einträge `!Lastenheft*.md`,
  `!STATS.md` und `!scripts/templates/` enthalten, damit diese Dateien versioniert werden.
  Das Template-Verzeichnis umfasst: `a11y-section.md`, `speckit-workflow-section.md`,
  `azubis-section.md` und `readme-template.md`.

- **FR-REV-C02**: Der doppelte Eintrag `!.specify/memory/` in der Root-`.gitignore`
  MUSS entfernt werden (Duplikat-Bereinigung).

#### REV-D — KI-Agenten-CLI-Syntax / AI Agent CLI Syntax

- **FR-REV-D01**: Das Bootstrap-Skript MUSS die genauen Init-Befehle aller vier
  Agenten-CLIs dokumentieren und aufrufen:
  Claude (`claude /init`), Copilot (`gh extension exec github/gh-copilot`).
  Codex und Gemini sind interaktive CLIs und werden **nicht automatisch aufgerufen** —
  das Skript gibt stattdessen aus:
  `WARN: codex CLI is interactive — run manually: codex` bzw.
  `WARN: gemini CLI is interactive — run manually: gemini`.

- **FR-REV-D02**: Das Bootstrap-Skript MUSS vor jedem Agenten-Aufruf die CLI-Verfügbarkeit
  per `which`/`Get-Command` prüfen; bei Fehlen: `WARN: {agent} CLI not found — install manually`.

#### REV-E — C#-Projekt-Härtung / C# Project Hardening

- **FR-REV-E01**: Jedes C#-Projekt MUSS eine `.editorconfig` mit Mindestregeln erhalten:
  `indent_style=space`, `indent_size=4`, `charset=utf-8`, `end_of_line=lf`,
  `insert_final_newline=true`.
  **Erstellung in bestehenden Projekten**: `migrate-workspace.sh` erkennt per
  `find . -maxdepth 2 -name "*.sln"` alle C#-Projekte und legt `.editorconfig`
  mit den Mindestregeln an, falls die Datei noch nicht vorhanden ist.
  Existiert `.editorconfig` bereits: `INFO: .editorconfig already present — skip`.

- **FR-REV-E02**: Das Compliance-Check-Skript MUSS `.editorconfig` als Pflichtdatei für
  C#-Projekte in die Datei-Präsenzmatrix aufnehmen. Als C#-Projekt gilt jedes
  Level-2-Verzeichnis, das mindestens eine `*.sln`-Datei enthält
  (`find . -maxdepth 1 -name "*.sln"` — Solution-Level-Erkennung).

#### REV-F — Constitution-Propagation / Constitution Propagation

- **FR-REV-F01**: Das Skript `scripts/sync-constitution.sh` / `.ps1` MUSS bei
  Constitution-Versionsänderungen die `constitution.md` in alle **Level-1-Workspaces**
  propagieren sowie anschließend in alle **Level-2-Projekte** innerhalb dieser Workspaces
  (Level-2-Erkennung via `find {workspace} -mindepth 2 -maxdepth 2 -name '.git' -type d`),
  je Workspace/Projekt einen Git-Commit erzeugen,
  und eine abschließende Zusammenfassung aller Workspaces ausgeben mit Status
  `UPDATED` / `SKIPPED (dirty)` / `ALREADY UP-TO-DATE`.

  **Propagations-Strategie — Merge-First** *(Product-Owner-Entscheidung 2026-04-02)*:
  Das Skript entscheidet pro Ziel-Repository nach folgendem Entscheidungsbaum:

  1. `constitution.md` **fehlt** im Ziel → **Kopieren**:
     `cp ~/constitution.md {target}/constitution.md`;
     Commit `chore: sync constitution to v{version}`; Status `UPDATED`.

  2. `constitution.md` vorhanden, **Version identisch** →
     Status `ALREADY UP-TO-DATE` (kein Schreibvorgang).

  3. `constitution.md` vorhanden, **Version veraltet** oder **Versionszeile fehlt**:
     Prüfe: `grep -q "^## Workspace" {target}/constitution.md`
     - **JA** (workspace-spezifische Abschnitte vorhanden) → **Merge**:
       Alle Root-Sections bis zum ersten `## Workspace-`-Heading durch aktuellen
       Root-Inhalt ersetzen; alle `## Workspace-*`-Abschnitte vollständig erhalten
       (append-only für workspace-spezifischen Teil, NFR-REV-02-konform);
       Versionszeile auf neue Version aktualisieren;
       Commit `chore: merge constitution to v{version}`; Status `UPDATED`.
     - **NEIN** (keine workspace-spezifischen Abschnitte) → **Kopieren** wie Fall 1;
       Commit `chore: sync constitution to v{version}`; Status `UPDATED`.

  Vor der Ausführung MUSS eine Preview aller `WOULD UPDATE`-Ziele ausgegeben
  und eine interaktive Prompt `Proceed? [y/N]` angezeigt werden; `--yes` überspringt
  nur die Prompt, nicht die Preview.
  Die Versionsnummer wird per `grep` aus der ersten Zeile der **Root**-`constitution.md`
  extrahiert (Format: `# Constitution vMAJOR.MINOR.PATCH`). Fehlt diese Zeile, bricht
  das Skript mit `ERROR: constitution.md hat keine Versionszeile` ab.

- **FR-REV-F02**: Das Skript MUSS `--dry-run` / `-WhatIf` unterstützen; bei Fehler
  MUSS es alle Teiländerungen zurückrollen (`git stash`). Workspaces mit uncommitteten
  lokalen Änderungen werden mit `WARN: {workspace} hat uncommittete Änderungen — übersprungen`
  übersprungen; alle übrigen Workspaces werden normal verarbeitet. Schlägt `git stash`
  selbst fehl, bricht das Skript mit `ERROR: git stash fehlgeschlagen — manuelle Bereinigung
  erforderlich` und Exit-Code `2` ab.

#### REV-G — CI/CD-Integration / CI/CD Integration

- **FR-REV-G01**: Jeder Workspace MUSS eine GitHub-Actions-Workflow-Datei
  `.github/workflows/homogeneity-check.yml` erhalten, die bei jedem Push **und**
  Pull Request (`push` + `pull_request`-Events) `check-homogeneity.sh` für den
  eigenen Workspace ausführt. Der Workflow verwendet eine **Matrix-Strategie**:
  `ubuntu-22.04`, `macos-14`, `windows-latest`. Ripgrep wird je Plattform installiert
  (`apt-get install ripgrep` / `brew install ripgrep` / `choco install ripgrep`).
  **CI-Aufruf**: Auf Ubuntu/macOS `bash scripts/check-homogeneity.sh $(basename "$GITHUB_WORKSPACE")`,
  auf Windows `pwsh scripts/check-homogeneity.ps1 -WorkspaceName (Split-Path $env:GITHUB_WORKSPACE -Leaf)`.
  Das Workspace-Name-Argument scoped den Scan auf das ausgecheckte Repo (Level-0-Checks entfallen).
  **Job-Summary-Format**: Plain Text (Klartext-Ausgabeformat) geht auf `stdout`; eine
  **Markdown-Tabelle** wird zusätzlich in `$GITHUB_STEP_SUMMARY` / `$env:GITHUB_STEP_SUMMARY`
  geschrieben — renderbar in der GitHub Actions UI. Beide Ausgabekanäle werden immer befüllt.

- **FR-REV-G02**: Der Workflow MUSS bei `✗`-Befunden mit Exit-Code `1` fehlschlagen
  und den Report sowohl als Plain Text (stdout) als auch als Markdown-Tabelle
  (`$GITHUB_STEP_SUMMARY`) ausgeben.

- **FR-REV-G03**: Der Workflow MUSS die Matrix `[ubuntu-22.04, macos-14, windows-latest]`
  verwenden (NFR-REV-04-konform). `timeout-minutes: 10` gilt für jeden Matrix-Job.

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

- **NFR-REV-06 Laufzeit / Runtime**: Kein programmatisches Timeout — Skripte laufen
  bis zum Abschluss. Der Nutzer kann jederzeit mit `Ctrl+C` abbrechen; ein `Ctrl+C`-Abbruch
  löst keinen automatischen Rollback aus. Der GitHub-Actions-Workflow (FR-REV-G01)
  erhält `timeout-minutes: 10` als CI-Sicherheitsnetz.

- **NFR-REV-07 TUI-A11Y-Prüfung / TUI A11Y Check**: `check-homogeneity.sh` MUSS als
  Teil des Compliance-Checks verifizieren, dass keine Datei in `scripts/` ANSI-Escape-
  Sequenzen enthält. Erkennungsmuster: `grep -rP '\x1b\[|\\033\[|\\e\['`
  (erfasst literal ESC-Byte, Oktal-Notation `\033[` und Bash-Kurzform `\e[`).
  Befunde werden als `✗`-Zeile im Report ausgegeben und senken den Compliance-Score.
  *(behebt SW-17)*

---

## Key Entities / Schlüsselobjekte

- **Level 0**: Das Home-Verzeichnis `~/` selbst — das `home-baseline`-Repository.
  *The home directory `~/` — the `home-baseline` repository.*
- **Level 1**: Direkte Workspace-Unterverzeichnisse von `~/`, die ein eigenes
  `.git/`-Verzeichnis enthalten (z. B. `~/MyProjects/`, `~/HobbyProjects/`).
  *Direct workspace subdirectories of `~/` that contain their own `.git/` directory.*
- **Level 2**: Projekte innerhalb eines Level-1-Workspace, die selbst ein
  `.git/`-Verzeichnis enthalten (z. B. `~/MyProjects/example-project`).
  *Projects inside a Level-1 workspace that themselves contain a `.git/` directory.*
- **Schwachstelle (SW-xx)**: Ein identifizierter Ist-/Soll-Abstand aus dem Audit
  mit Schweregrad HOCH / MITTEL / NIEDRIG.
- **Migrationsskript**: Idempotentes Skript, das bestehende Dateien auf Zielstand
  bringt, ohne Inhalte zu zerstören.
- **Baseline**: Erster STATS.md-Eintrag, der den Ist-Zustand vor allen Reparaturen
  festhält — Vergleichspunkt für spätere Scans.
- **Constitution-Propagation**: Mechanismus zur synchronen Verteilung einer neuen
  Constitution-Version in alle Level-1-Workspaces.
- **EN-Platzhalter**: Markierter Block `<!-- EN: [Dateiname] placeholder -->` am
  **Ende** einer Pflichtdatei (ein Block pro Datei); wird von `migrate-workspace.sh`
  eingefügt, wenn die Datei noch keinen EN-Abschnitt enthält.

---

## Success Criteria / Erfolgskriterien

- **SC-REV-01**: `check-homogeneity.sh` liefert für alle Levels 0–2 Exit-Code `0`
  nach Abschluss aller Maßnahmen (kein einziger `✗`-Befund).

- **SC-REV-02**: Alle Root-Agentendateien (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`,
  `README.md`, `.github/copilot-instructions.md`) enthalten je mindestens einen DE- und EN-Abschnitt.

- **SC-REV-03**: `STATS.md` auf Root-Ebene enthält eine Baseline-Zeile (Ist-Zustand)
  und mindestens eine Post-Fix-Zeile mit verbessertem Compliance-Score.

- **SC-REV-04**: `Lastenheft_workspace-homogeneity-guardian.md` ist in `.gitignore`
  als `!Lastenheft*.md` whitelisted und wird von `git status` als getracktes File angezeigt.

- **SC-REV-05**: `rename-lastenheft.sh` benennt eine Test-Datei korrekt um und
  erzeugt einen `git mv`-Commit mit der erwarteten Message.

- **SC-REV-06**: Der GitHub-Actions-Workflow läuft grün auf allen drei Matrix-Plattformen
  (`ubuntu-22.04`, `macos-14`, `windows-latest`) nach einem Push auf den Default-Branch
  eines Workspace-Repos.

- **SC-REV-07**: Das Migrationsskript läuft auf `MyProjects` und erhöht den
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
| FR-REV-A01–A06 | FR-001–FR-006 (Dateistruktur/-präsenz, Parent 001); `constitution.md` (Versionsextraktion FR-REV-A03) |
| FR-REV-B01 | FR-001–FR-021 (Homogenitätsprüfung, Parent 001) |
| FR-REV-B02 | FR-009–FR-016 (Bootstrap, Parent 001) |
| FR-REV-B03 | FR-012 (Dateibenennungs-Konvention, Parent 001) |
| FR-REV-B04 | FR-007/008 (STATS.md-Schema, Parent 001) |
| FR-REV-C01–C02 | FR-002 (Dateipräsenz-Prüfung, Parent 001) |
| FR-REV-D01–D02 | FR-009 Bootstrap-Agenten-Init; `gh` CLI (Copilot-Init) |
| FR-REV-E01–E02 | FR-016 (C#-Dep-Scan erweitert) |
| FR-REV-F01–F02 | Constitution Prinzip IV (Workspace Isolation) |
| FR-REV-G01–G03 | NFR-REV-04 (Platform matrix: ubuntu-22.04 + macos-14 + windows-latest); GitHub Actions Free-Tier |

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
  → A: Nur `README.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `.github/copilot-instructions.md`, `STATS.md` (Kopfzeilen), `constitution.md`. Spec-Kit-Artefakte und sonstige `.md`-Dateien bleiben unberührt. (→ FR-REV-A01)

- **Q: Wie verhält sich `sync-constitution.sh` bei uncommitteten Änderungen in einem Level-1-Workspace?**
  → A: Workspace überspringen mit `WARN: {workspace} hat uncommittete Änderungen — übersprungen`; alle anderen Workspaces werden normal verarbeitet. (→ FR-REV-F02)

- **Q: Wie erkennt `migrate-workspace.sh` Level-2-Projekte?**
  → A: Jedes Unterverzeichnis eines Level-1-Workspace mit eigenem `.git/`-Verzeichnis gilt als Level-2-Projekt. (→ FR-REV-A04)

- **Q: Was bewirkt `--yes`/`-Force` in `migrate-workspace.sh` genau?**
  → A: Preview wird immer ausgegeben; `--yes` überspringt nur die interaktive `Proceed? [y/N]`-Prompt. Stille Ausführung ohne Preview ist nicht vorgesehen. (→ FR-REV-A02)

- **Q: Gibt es ein Timeout für langlaufende Skripte?**
  → A: Kein programmatisches Timeout; unbegrenzte Laufzeit. `Ctrl+C` bricht ab ohne Rollback. GitHub-Actions-Workflow erhält `timeout-minutes: 10`. (→ NFR-REV-06)

- **Q: Wie sieht die abschließende Zusammenfassung von `sync-constitution.sh` aus?**
  → A: Alle Workspaces werden mit Status `UPDATED` / `SKIPPED (dirty)` / `ALREADY UP-TO-DATE` aufgelistet — auch übersprungene. (→ FR-REV-F01)

- **Q: Was passiert, wenn `git stash` beim Rollback selbst fehlschlägt?**
  → A: `ERROR: git stash fehlgeschlagen — manuelle Bereinigung erforderlich` auf stderr + Diff; Exit-Code `2`; Skript bricht sofort ab, keine weiteren Workspaces werden berührt. (→ FR-REV-A06, FR-REV-F02)

- **Q: Ist SW-06 (Kein SDD-Workflow) durch FR-REV-B02 abgedeckt oder braucht es ein eigenes FR?**
  → A: Eigenes FR-REV-B05 hinzugefügt: `bootstrap-project.sh` muss spec-kit initialisieren (`.specify/`, `create-new-feature.sh`, `AGENTS.md`-Verweis). (→ FR-REV-B05)

- **Q: Hat `sync-constitution.sh` einen Bestätigungsschritt vor dem Schreiben?**
  → A: Ja — wie `migrate-workspace.sh`: Preview aller `WOULD UPDATE`-Workspaces, dann `Proceed? [y/N]`; `--yes` überspringt nur die Prompt. (→ FR-REV-F01)

- **Q: Woher kommt `v{version}` in der Commit-Message von `migrate-workspace.sh`?**
  → A: Aus der ersten Zeile der Root-`constitution.md` per `grep` — dieselbe Quelle wie FR-REV-F01. (→ FR-REV-A03)

- **Q: Unter welchem Pfad liegt `copilot-instructions.md`?**
  → A: `.github/copilot-instructions.md` — GitHub-Standard-Pfad. FR-REV-A01 und SC-REV-02 aktualisiert. (→ FR-REV-A01)

- **Q: Soll SW-17 (TUI-A11Y) als formales NFR oder nur über den A11Y-Abschnitt abgedeckt sein?**
  → A: Neues NFR-REV-07: `check-homogeneity.sh` prüft aktiv per `grep -rP '\x1b\['` ob Scripts ANSI-Codes enthalten; Befunde als `✗` im Report. (→ NFR-REV-07)

- **Q: Wie sind Level 0, Level 1 und Level 2 formal definiert?**
  → A: Level 0 = `~/` (Home-Verzeichnis, `home-baseline`-Repo); Level 1 = direkte Workspace-Unterverzeichnisse mit eigenem `.git/` (z. B. `~/MyProjects/`); Level 2 = Projekte innerhalb eines Level-1-Workspace mit eigenem `.git/` (z. B. `~/MyProjects/example-project`). Formale Definitionen in §Key Entities ergänzt. (→ FR-REV-A04, SC-REV-01)

- **Q: Wie erkennt `check-homogeneity.sh` C#-Projekte für die `.editorconfig`-Pflichtprüfung?**
  → A: Anwesenheit einer `*.sln`-Datei im Level-2-Verzeichnis (`find . -maxdepth 1 -name "*.sln"`) — Solution-Level-Erkennung. (→ FR-REV-E02)

- **Q: Was passiert, wenn `gh repo create` in `bootstrap-project.sh` aufgerufen wird, aber das Remote-Repo auf GitHub bereits existiert?**
  → A: Vorher `git remote -v` prüfen; ist ein Remote konfiguriert → `INFO: remote already configured — skipping gh repo create`; kein Abbruch. (→ FR-REV-B02, Edge Cases)

- **Q: Was genau löst in `bootstrap-project.sh` das SKIP für Codex und Gemini aus (FR-REV-D01)?**
  → A: Codex und Gemini werden grundsätzlich nie aufgerufen — immer `WARN: {agent} CLI is interactive — run manually: {cmd}`. Kein TTY-Check, kein Timeout. (→ FR-REV-D01)

- **Q: Soll `bootstrap-project.sh` `speckit specify` aktiv aufrufen oder nur vorbereiten (FR-REV-B05)?**
  → A: Aktiv aufrufen — jedoch `speckit specify init --here --ai {agent}` (AI-Initialisierung, keine Feature-Spec). Befehle: `speckit specify init --here --ai claude`, `--ai gemini`, `--ai copilot`, `--ai codex --ai-skills`. Bei fehlender CLI: WARN + manueller Hinweis. (→ FR-REV-B05)

- **Q: Ist das ANSI-Erkennungsmuster in NFR-REV-07 vollständig (nur `\x1b\[` oder auch Text-Notationen)?**
  → A: Erweitert auf `grep -rP '\x1b\[|\\033\[|\\e\['` — erfasst literal ESC-Byte, Oktal-Notation `\033[` und Bash-Kurzform `\e[`. (→ NFR-REV-07)

- **Q: Welches Format haben Failure-Einträge im `--json`-Output von `check-homogeneity.sh`?**
  → A: Strukturierte Objekte: `{"file": "<relativer Pfad>", "check": "<Prüfname>", "level": <0|1|2>}`. Vollständiges Format inkl. `by_level`: `{"score": 75, "by_level": {"0": 100, "1": 80, "2": 60}, "failures": [...], "warnings": []}`. (→ FR-REV-B01)

- **Q: Was wird als Body-Inhalt unter den von `migrate-workspace.sh` eingefügten Abschnitts-Überschriften eingefügt?**
  → A: Inhalt aus Template-Dateien in `scripts/templates/`: `a11y-section.md`, `speckit-workflow-section.md`, `azubis-section.md`. Fehlende Template → `ERROR` + Abbruch. `scripts/templates/` auch in `.gitignore`-Whitelist aufgenommen. (→ FR-REV-A01, FR-REV-C01)

- **Q: Was passiert, wenn `migrate-workspace.sh` ohne Workspace-Argument aufgerufen wird?**
  → A: Alle Level-1-Workspaces in `~/` werden sequentiell migriert (Alle-auf-einmal-Modus); jeder Workspace durchläuft denselben Preview-→-Commit-Zyklus. (→ FR-REV-A01)

- **Q: Wie ermittelt `init-stats.sh` den Compliance-Score für den Baseline-Eintrag?**
  → A: Intern `check-homogeneity.sh --json` aufrufen und `score`-Wert extrahieren. Ist check-homogeneity.sh nicht vorhanden → `ERROR` + Abbruch. (→ FR-REV-B04)

- **Q: Erscheint `Proceed? [y/N]` im Alle-auf-einmal-Modus einmal oder pro Workspace?**
  → A: Einmal — eine einzige Gesamt-Preview aller Workspaces, dann eine einzige `Proceed? [y/N]`. Keine separate Bestätigung pro Workspace. (→ FR-REV-A02)

- **Q: Wie prüft `migrate-workspace.sh` die Idempotenz für neue Pflichtabschnitte (A11Y, Spec-kit-Workflow, Azubis)?**
  → A: Exakter String-Match des Heading-Texts (z. B. `## Barrierefreiheit / Accessibility (A11Y)`) → `INFO: section already present — skip`. Schlüsselwort-Treffer ohne exakten Match gelten nicht als vorhanden. (→ FR-REV-A01, FR-REV-A05, Edge Cases)

- **Q: Auf welche Ebenen synchronisiert `sync-constitution.sh` — Level-1 oder Level-1+2?**
  → A: **Level-1 UND Level-2** (M4-Fix, FR-REV-F01-Amendment 2026-04-02). Level-2-Projekte werden direkt via `find {workspace} -mindepth 2 -maxdepth 2 -name '.git' -type d` erkannt und erhalten dieselbe Merge-First-Propagation wie Level-1. (→ FR-REV-F01)

- **Q: Wer erstellt `.github/workflows/homogeneity-check.yml` in bereits bestehenden Repos?**
  → A: `migrate-workspace.sh` — erstellt die Workflow-Datei wenn nicht vorhanden (FR-REV-G01–G03-konform); existiert sie bereits → `INFO: homogeneity-check.yml already present — skip`. (→ FR-REV-A01)

- **Q: Wer erstellt `.editorconfig` in bestehenden C#-Projekten?**
  → A: `migrate-workspace.sh` erkennt `*.sln`-Dateien und legt `.editorconfig` mit Mindestregeln an falls fehlend; existiert sie bereits → `INFO: .editorconfig already present — skip`. (→ FR-REV-E01)

- **Q: Welches `install-hooks.sh` und welches Hook-Template verwendet `migrate-workspace.sh` beim Pre-Push-Hook-Setup auf Level-2?**
  → A: `migrate-workspace.sh` wechselt ins Level-2-Verzeichnis und ruft `bash {level1-workspace}/scripts/install-hooks.sh` auf — verwendet das Hook-Template (`scripts/hooks/pre-push`) des unmittelbaren Level-1-Parent-Workspace. Root-`scripts/install-hooks.sh` wird für Level-2 nicht verwendet. (→ FR-REV-A04)

- **Q: Welche Mindeststruktur hat `homogeneity-check.yml` — ubuntu-22.04 only oder Multi-Plattform-Matrix?**
  → A: Matrix-Strategie `[ubuntu-22.04, macos-14, windows-latest]`; ripgrep-Install je Plattform (`apt`/`brew`/`choco`); `bash`/`pwsh` je OS; Report per `$GITHUB_STEP_SUMMARY`; `timeout-minutes: 10` pro Matrix-Job. (→ FR-REV-G01, FR-REV-G03, SC-REV-06)

- **Q: Welches Ziel-Dateinamenformat verwendet `rename-lastenheft.sh`?**
  → A: `{original-stem}.{branch-name}.md` — Stem (ohne `.md`) + Punkt + Branch-Name + `.md`. Beispiel: `Lastenheft_foo.md` + `002-bar` → `Lastenheft_foo.002-bar.md`. (→ FR-REV-B03)

- **Q: Gibt `check-homogeneity.sh` einen globalen Score oder separate Scores pro Ebene aus?**
  → A: Beides — aggregierter Gesamt-Score plus `by_level`-Objekt mit Scores für Level 0, 1 und 2. Format: `{"score": 75, "by_level": {"0": 100, "1": 80, "2": 60}, "failures": [...], "warnings": []}`. (→ FR-REV-B01, SC-REV-07)

- **Q: Soll die Terminologie „Child-Workspace/Child-Repo" auf den Canonical Term „Level-1-Workspace" normalisiert werden?**
  → A: Ja — alle Vorkommen von „Child-Workspace(s)" und „Child-Repo(s)" durch „Level-1-Workspace(s)" ersetzt. Canonical Term ist „Level-1-Workspace" gemäß §Key Entities.

- **Q: In welche Dateien fügt `migrate-workspace.sh` die Abschnitte A11Y, Spec-kit-Workflow und Azubis ein?**
  → A: Ausschließlich `README.md` je Workspace/Level. KI-Agenten-Dateien (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `copilot-instructions.md`) erhalten nur den EN-Platzhalter-Block, nicht die drei Abschnitte. (→ FR-REV-A01)

- **Q: Akzeptiert `check-homogeneity.sh` ein optionales Workspace-Argument für scoped Checks?**
  → A: Ja — `check-homogeneity.sh [workspace-name]`: ohne Argument globaler Scan Level 0–2; mit Workspace-Namen nur dieser Level-1-Workspace + Level-2-Projekte (Level-0-Checks entfallen). (→ FR-REV-B01, SC-REV-07)

- **Q: Welches Format hat das ASCII-Chart in `STATS.md`?**
  → A: Horizontale Balken, eine Zeile pro Scan-Run: `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%` (20 Zeichen Breite = 100 %; Score auf 5 % gerundet). (→ FR-REV-B04, US3 Szenario 3)

- **Q: Was passiert, wenn `constitution.md` in einem Level-1-Workspace komplett fehlt (Erstinstallation)?**
  → A: Datei fehlt → Kopieren: `cp ~/constitution.md {target}/constitution.md`; Commit `chore: sync constitution to v{version}`; Status `UPDATED`. Kein Sonderfall, kein Fehler. **Merge-Strategie** gilt nur wenn Datei bereits vorhanden und Version veraltet (→ FR-REV-F01, Product-Owner-Entscheidung 2026-04-02).

- **Q: Sollen die Template-Dateien (`a11y-section.md` etc.) bilingualen Inhalt haben?**
  → A: Ja — vollständig bilingual (DE zuerst, EN zweite Zeile/Abschnitt, CEFR B2), konsistent mit dem Projektgrundsatz „DE first, EN second". (→ FR-REV-A01)

- **Q: Wie ruft der GitHub-Actions-Workflow `check-homogeneity.sh` auf, wenn nur das Level-1-Repo ausgecheckt ist?**
  → A: `bash scripts/check-homogeneity.sh $(basename "$GITHUB_WORKSPACE")` (Bash/macOS); `pwsh scripts/check-homogeneity.ps1 -WorkspaceName (Split-Path $env:GITHUB_WORKSPACE -Leaf)` (Windows). Workspace-Argument scoped den Scan — Level-0-Checks entfallen. (→ FR-REV-G01, FR-REV-B01)

- **Q: Bekommt jedes Level-2-Projekt eine eigene `STATS.md` oder gibt es eine aggregierte pro Level-1?**
  → A: Eine `STATS.md` pro Level-2-Projekt, im jeweiligen Projektstammverzeichnis — nicht aggregiert. (→ FR-REV-B04)

- **Q: Erstellt `bootstrap-project.sh` eine sofort-compliant `README.md` oder benötigt es nachträgliches `migrate-workspace.sh`?**
  → A: Sofort-compliant via `scripts/templates/readme-template.md` — Template enthält bereits alle Pflichtabschnitte + EN-Placeholder. Fehlt Template → `ERROR` + Abbruch. (→ FR-REV-B02, FR-REV-C01)

- **Q: Erhalten Level-2-Projekte ebenfalls eine `homogeneity-check.yml` CI-Workflow-Datei?**
  → A: Ja — `migrate-workspace.sh` erstellt sie auch in Level-2-Projekten (gleiches Template, gleiche Idempotenz-Regel `INFO: already present — skip`). (→ FR-REV-A01, FR-REV-G01)

- **Q: Wie sieht die Klartext-Ausgabe (ohne `--json`) von `check-homogeneity.sh` aus?**
  → A: Eine Zeile pro Check: `[✓|✗|WARN] Level-N  {datei}  {check-name}`; abschließend `Score: 75% (15/20 checks passed)` + ASCII-Chart im STATS.md-Format. (→ FR-REV-B01)

- **Q: Rufen `bootstrap-project.sh` und `migrate-workspace.sh` automatisch `init-stats.sh` auf?**
  → A: Ja, beide — `bootstrap-project.sh` am Ende des Runs (neue Projekt-Baseline); `migrate-workspace.sh` nach dem Git-Commit (Post-Migrations-Ist-Zustand). Garantiert SC-REV-03. (→ FR-REV-A03, FR-REV-B02)
- **Q: Erstellt `bootstrap-project.sh` auch `.github/workflows/homogeneity-check.yml` direkt beim Anlegen?**
  → A: Ja — neues Projekt ist sofort 100 % compliant, kein nachträglicher `migrate-workspace.sh`-Lauf nötig. (→ FR-REV-B02)
- **Q: Woher kommt `constitution.md` für ein neues Projekt in `bootstrap-project.sh`?**
  → A: Bootstrap kopiert `~/constitution.md` (Level-0-Root) direkt ins neue Projekt; `sync-constitution.sh` übernimmt Updates. Fehlt Root-Datei → ERROR + Abbruch. (→ FR-REV-B02)
- **Q: Prüft `check-homogeneity.sh` STATS.md nur auf Vorhandensein oder auch auf Inhalt?**
  → A: Nur Präsenz — Datei existiert → PASS, fehlt → FAIL; konsistent mit allen anderen Pflichtdateien. (→ FR-REV-B01)
- **Q: GitHub Job Summary: Markdown-Tabelle oder Plain Text?**
  → A: Beides — Plain Text → stdout (Konsole/CI-Log); Markdown-Tabelle → `$GITHUB_STEP_SUMMARY` (GitHub Actions UI). (→ FR-REV-G01, FR-REV-G02)
