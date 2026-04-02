# Feature Specification: workspace-homogeneity-guardian-revision
# Revisions-Lastenheft: Workspace-Homogenitätswächter — Schwachstellen & Lücken

**Feature Branch**: `feat/workspace-homogeneity-guardian-revision` *(wird nach Spec-kit-Lauf aktualisiert)*
**Erstellt / Created**: 2026-04-01
**Status**: Draft
**Bezugs-Lastenheft / Reference Lastenheft**: `Lastenheft_workspace-homogeneity-guardian.md`
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: Thorsten Hindermann (`hindermath`)

---

## Zweck dieses Dokuments / Purpose of This Document

> Dieses Revisions-Lastenheft dokumentiert den **Ist-Zustand** der
> Workspace-Infrastruktur, deckt Lücken gegenüber dem Ziel-Lastenheft auf
> und definiert konkrete Maßnahmen zur Behebung. Es dient als Grundlage für
> einen nachgelagerten Fix-Sprint und kann direkt als Eingabe für
> `speckit plan` und `speckit tasks` verwendet werden.
>
> *This revision Lastenheft documents the **current state** of the workspace
> infrastructure, identifies gaps against the target Lastenheft, and defines
> concrete remediation measures. It serves as the basis for a follow-up fix
> sprint and can be used directly as input for `speckit plan` and `speckit tasks`.*

---

## Ist-Zustand / Current State Audit

Durchgeführt am / Conducted: 2026-04-01 · Basis: Live-Scan der Umgebung

### Audit-Ergebnisse / Audit Results

```
╔═══════════════════════════════════════════════════════════════════════╗
║  workspace-homogeneity-guardian — Ist-Zustand / Current State         ║
╠═══════════════════════════════════════════════════════════════════════╣
║  Kriterium                          Status   Befund                   ║
║  ──────────────────────────────     ──────   ──────────────────────── ║
║  Pre-Push-Hook (Ebene 0–1)          ✓ OK     alle 4 Repos identisch   ║
║  Pre-Push-Hook (Ebene 2, Projekte)  ? OFFEN  nicht geprüft            ║
║  Bilingualism (Root-Agentendateien) ✗ FEHLT  0 von 4 bilingual        ║
║  Bilingualism (copilot-instruc.)    ~ WARN   1 Marker (unvollständig) ║
║  A11Y-Abschnitt in READMEs          ✗ FEHLT  0 von 3 geprüften        ║
║  STATS.md (alle Ebenen)             ✗ FEHLT  nirgends vorhanden       ║
║  SDD spec/plan/tasks (Projekte)     ✗ FEHLT  kein einziges Projekt    ║
║  bootstrap-project.sh/.ps1          ✗ FEHLT  Skript nicht vorhanden   ║
║  check-homogeneity.sh/.ps1          ✗ FEHLT  Skript nicht vorhanden   ║
║  rename-lastenheft.sh/.ps1          ✗ FEHLT  Skript nicht vorhanden   ║
║  Lastenheft in .gitignore-Whitelist ✗ FEHLT  nicht eingetragen        ║
║  .gitignore Duplikat-Einträge       ~ WARN   .specify/ 2× vorhanden   ║
║  Directory.Build.props in C#-Proj.  ? OFFEN  nicht geprüft            ║
║  Speckit-Skills in Agent-Cmd-Dirs   ? OFFEN  nicht geprüft            ║
╠═══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ FEHLT · ~ WARN · ? OFFEN (noch zu prüfen)         ║
╚═══════════════════════════════════════════════════════════════════════╝
```

### Schwachstellen-Katalog / Weakness Catalogue

| ID | Schwachstelle / Weakness | Schweregrad | Quelle |
|---|---|:---:|---|
| SW-01 | Keine `bootstrap-project.sh/.ps1` — neue Projekte werden manuell und inkonsistent angelegt | HOCH | Audit |
| SW-02 | Kein `check-homogeneity.sh/.ps1` — kein automatischer Nachweis des Zustands | HOCH | Audit |
| SW-03 | Alle Root-Agentendateien (README, CLAUDE.md, GEMINI.md, AGENTS.md) sind **nicht bilingual** | HOCH | Audit |
| SW-04 | Kein A11Y-Abschnitt in irgendeiner bestehenden README | MITTEL | Audit |
| SW-05 | Kein `STATS.md` auf keiner Ebene — keine Baseline, kein Trend | MITTEL | Audit |
| SW-06 | Kein SDD-Workflow in Projekten etabliert — keine `spec.md`, `plan.md`, `tasks.md` | MITTEL | Audit |
| SW-07 | Pre-Push-Hook auf Ebene 2 (Projekte) nicht geprüft — Lücke möglich | MITTEL | Audit |
| SW-08 | `Lastenheft*.md` nicht in `.gitignore`-Whitelist — Lastenheft wird nicht committed | MITTEL | Audit |
| SW-09 | `.gitignore` enthält doppelten Eintrag `!.specify/` und `!.specify/memory/` | NIEDRIG | Audit |
| SW-10 | `copilot-instructions.md` hat nur 1 Bilingual-Marker — unvollständig | NIEDRIG | Audit |
| SW-11 | Kein `rename-lastenheft.sh/.ps1` — Branch-Umbenennung nach Spec-kit manuell | NIEDRIG | Spec-Lücke |
| SW-12 | CLI-Syntax der KI-Agenten-Init-Aufrufe nicht spezifiziert (z. B. `claude /init`?) | NIEDRIG | Spec-Lücke |
| SW-13 | Kein `.editorconfig` in C#-Projekten definiert — Coding-Style nicht erzwungen | NIEDRIG | Spec-Lücke |
| SW-14 | Kein Migrations-Pfad für bestehende Workspaces/Projekte definiert | HOCH | Spec-Lücke |
| SW-15 | Kein Mechanismus zur Propagation von Constitution-Änderungen in Child-Repos | MITTEL | Spec-Lücke |
| SW-16 | GitHub Actions / CI-Integration nicht erwähnt — kein automatischer Scan in Pipelines | NIEDRIG | Spec-Lücke |
| SW-17 | TUI-Ausgaben der Skripte nicht A11Y-geprüft (Screenreader-Kompatibilität) | MITTEL | Spec-Lücke |
| SW-18 | STATS.md Kopfzeilen/Legenden sind nicht bilingual | NIEDRIG | Spec-Lücke |

---

## Anwendungsszenarien & Tests / User Scenarios & Testing

### Szenario 1 — Migration bestehender Repos / Migration of Existing Repos (Priorität: P1)

Ein bestehender Workspace (z. B. `RiderProjects`) wird auf den Zielstand des
Homogenitäts-Lastenhefts gebracht, ohne bestehende Inhalte zu zerstören.

*An existing workspace (e.g. `RiderProjects`) is brought to the target state of
the homogeneity Lastenheft without destroying existing content.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** `RiderProjects/` hat weder A11Y-Abschnitt noch Bilingual-Marker,
   **wenn** `bash scripts/migrate-workspace.sh RiderProjects` läuft,
   **dann** werden fehlende Abschnitte als Platzhalter eingefügt und bestehende
   Inhalte bleiben unberührt.

2. **Gegeben** ein Migrationslauf,
   **dann** erzeugt das Skript einen Git-Commit
   `chore: migrate RiderProjects to homogeneity baseline`.

3. **Gegeben** `--dry-run`-Modus,
   **dann** zeigt das Skript alle geplanten Änderungen, ohne etwas zu schreiben.

---

### Szenario 2 — Vollständiger Homogenitäts-Nachweis / Full Compliance Proof (Priorität: P1)

Nach Abschluss aller Fixes liefert `check-homogeneity.sh` für die gesamte
Umgebung einen Bericht ohne `✗`-Einträge.

*After completing all fixes, `check-homogeneity.sh` delivers a report with no
`✗` entries for the entire environment.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** alle SW-01–SW-10 behoben,
   **wenn** `bash scripts/check-homogeneity.sh` ausgeführt wird,
   **dann** ist der Exit-Code `0` und alle Zeilen zeigen `✓`.

2. **Gegeben** der Scan läuft auf einem frisch bootstrappten Projekt (SW-01),
   **dann** meldet er sofort `100 %` Compliance ohne manuelle Nacharbeit.

---

### Szenario 3 — Spec-kit-Ersteinrichtung in Projekten / Speckit First Setup (Priorität: P2)

Alle bestehenden SDD-fähigen Projekte erhalten einen initialen `spec.md`-Scaffold.

*All existing SDD-capable projects receive an initial `spec.md` scaffold.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** `TinyCalc/` hat keine `spec.md`,
   **wenn** `bash scripts/bootstrap-project.sh --sdd-only TinyCalc` läuft,
   **dann** wird `spec.md` mit bilingualem Scaffold + A11Y-Abschnitt erstellt.

2. **Gegeben** der Spec-kit-Durchlauf endet erfolgreich,
   **dann** wird `spec.md` zu `Lastenheft_TinyCalc.{branch}.md` umbenannt.

---

### Randfälle / Edge Cases

- Was passiert, wenn ein Projekt schon eine `CLAUDE.md` hat, die nicht bilingual ist?
  → Migrationsskript fügt EN-Platzhalter-Block am Ende ein, bestehender DE-Text
  bleibt unberührt. Marker `<!-- EN: placeholder -->` kennzeichnet ihn klar.

- Was passiert, wenn `bootstrap-project.sh` auf ein bereits initialisiertes
  Verzeichnis trifft?
  → `--force`-Flag erforderlich; ohne Flag: `WARN: already bootstrapped — use --force`.

- Was passiert bei fehlgeschlagenem Constitution-Propagations-Lauf?
  → Änderungen werden zurückgerollt (git stash); Fehlermeldung mit Diff ausgegeben.

---

## Anforderungen / Requirements

### Funktionale Anforderungen / Functional Requirements

#### REV-A — Migration bestehender Infrastruktur / Migration of Existing Infrastructure

- **FR-REV-A01**: Das Skript `scripts/migrate-workspace.sh` (Bash) und
  `scripts/migrate-workspace.ps1` (PowerShell 7+) MÜSSEN idempotent alle
  fehlenden Pflichtabschnitte in bestehende Dateien einfügen:
  - Bilingualen EN-Platzhalter-Block falls kein EN-Marker vorhanden
  - `## Barrierefreiheit / Accessibility (A11Y)` Abschnitt falls fehlend
  - `## Spec-kit-Workflow` Abschnitt falls fehlend
  - `## Für Azubis / For Apprentices` Abschnitt falls fehlend

- **FR-REV-A02**: Das Migrationsskript MUSS `--dry-run` / `-WhatIf` unterstützen
  und vor jedem Schreibvorgang eine Bestätigung ausgeben (außer im
  `--yes`-Modus / `-Force`-Modus).

- **FR-REV-A03**: Jeder Migrationslauf MUSS in einem Git-Commit enden mit
  Message `chore: migrate {workspace} to homogeneity baseline v{version}`.

- **FR-REV-A04**: Das Migrationsskript MUSS auf Ebene 2 (Projekte) den
  Pre-Push-Hook-Status prüfen und ggf. `install-hooks.sh` aufrufen.

#### REV-B — Fehlende Skripte / Missing Scripts

- **FR-REV-B01**: `scripts/check-homogeneity.sh` / `.ps1` MUSS implementiert
  werden (spezifiziert in FR-A01–FR-A05 des Bezugs-Lastenhefts).

- **FR-REV-B02**: `scripts/bootstrap-project.sh` / `.ps1` MUSS implementiert
  werden (spezifiziert in FR-F01–FR-F05 des Bezugs-Lastenhefts).

- **FR-REV-B03**: `scripts/rename-lastenheft.sh` / `.ps1` MUSS implementiert
  werden gemäß der Dateibenennungs-Konvention (alle drei Ebenen):
  ```bash
  # Aufruf / Usage:
  bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>
  # Beispiel / Example:
  bash scripts/rename-lastenheft.sh \
    Lastenheft_workspace-homogeneity-guardian.md \
    001-workspace-homogeneity-guardian
  ```

- **FR-REV-B04**: `scripts/init-stats.sh` / `.ps1` MUSS eine initiale `STATS.md`
  auf allen drei Ebenen (0, 1, 2) erzeugen, die den aktuellen Ist-Zustand als
  Baseline festhält.

#### REV-C — .gitignore-Bereinigung / .gitignore Cleanup

- **FR-REV-C01**: Die Root-`.gitignore` MUSS um folgenden Eintrag erweitert
  werden, damit Lastenheft-Dateien versioniert werden:
  ```
  !Lastenheft*.md
  !STATS.md
  ```

- **FR-REV-C02**: Der doppelte Eintrag `!.specify/` und `!.specify/memory/` in
  der Root-`.gitignore` MUSS bereinigt werden (Duplikat entfernen).

#### REV-D — KI-Agenten-CLI-Syntax / AI Agent CLI Syntax Specification

- **FR-REV-D01**: Die genaue Init-Syntax aller vier Agenten-CLIs MUSS im
  Bootstrap-Skript dokumentiert und getestet sein:

  | Agent | Init-Befehl | Verfügbarkeit prüfen |
  |---|---|---|
  | Claude | `claude /init` | `which claude` |
  | Codex | `codex` (startet interaktiv) | `which codex` |
  | Gemini | `gemini` (startet interaktiv) | `which gemini` |
  | Copilot | `gh extension exec github/gh-copilot` | `gh extension list` |
  | Speckit | `npx speckit init` | `which npx` |

- **FR-REV-D02**: Das Bootstrap-Skript MUSS vor dem Init-Aufruf die
  CLI-Verfügbarkeit mit `which`/`Get-Command` prüfen und bei Fehlen eine
  `WARN: {agent} CLI not found — install manually` Meldung ausgeben.

#### REV-E — C#-Projekt-Härtung / C# Project Hardening

- **FR-REV-E01**: Jedes C#-Projekt MUSS zusätzlich zur `Directory.Build.props`
  eine `.editorconfig` mit folgenden Mindestregeln erhalten:
  ```ini
  root = true

  [*.cs]
  indent_style = space
  indent_size = 4
  charset = utf-8
  end_of_line = lf
  insert_final_newline = true
  ```

- **FR-REV-E02**: Das Prüfskript MUSS `.editorconfig` als Pflichtdatei für
  C#-Projekte in die Präsenzmatrix aufnehmen.

#### REV-F — Constitution-Propagation / Constitution Propagation

- **FR-REV-F01**: Ein Skript `scripts/sync-constitution.sh` / `.ps1` MUSS
  erstellt werden, das bei Constitution-Versionsänderung:
  1. Die neue `constitution.md` in alle Child-Workspaces kopiert
     (`~/{Workspace}/.specify/memory/constitution.md`)
  2. Pro Workspace einen Git-Commit erstellt:
     `chore: sync constitution to v{version}`
  3. Eine Zusammenfassung der geänderten Workspaces ausgibt

- **FR-REV-F02**: Das Skript MUSS `--dry-run` / `-WhatIf` unterstützen.

#### REV-G — CI/CD-Integration / CI/CD Integration

- **FR-REV-G01**: Jeder Workspace MUSS eine GitHub-Actions-Workflow-Datei
  `.github/workflows/homogeneity-check.yml` erhalten, die bei jedem Push
  `check-homogeneity.sh` für den eigenen Workspace ausführt.

- **FR-REV-G02**: Der Workflow MUSS bei `✗`-Befunden fehlschlagen (Exit-Code 1)
  und den Report als Job-Summary ausgeben.

- **FR-REV-G03**: Der Workflow MUSS auf `ubuntu-22.04` laufen (kostenlos bei
  öffentlichen/privaten Repos im Free-Tier).

### Nicht-funktionale Anforderungen / Non-Functional Requirements

- **NFR-REV-01 Reihenfolge / Order**: Die Maßnahmen MÜSSEN in dieser Reihenfolge
  umgesetzt werden, um Abhängigkeiten aufzulösen:
  ```
  1. REV-C (.gitignore bereinigen)
  2. REV-B01 (check-homogeneity.sh)
  3. REV-B04 (init-stats.sh → Baseline)
  4. REV-A  (Migrationsskript)
  5. REV-B02 (bootstrap-project.sh)
  6. REV-B03 (rename-lastenheft.sh)
  7. REV-D  (CLI-Syntax dokumentieren)
  8. REV-E  (C#-Härtung)
  9. REV-F  (Constitution-Propagation)
  10. REV-G (CI/CD)
  ```

- **NFR-REV-02 Nicht-destruktiv / Non-destructive**: Alle Migrations- und
  Reparaturskripte DÜRFEN niemals existierende Inhalte überschreiben —
  ausschließlich Ergänzungen und Einfügungen.
  *All migration and repair scripts MUST NEVER overwrite existing content —
  additions and insertions only.*

- **NFR-REV-03 Auditierbarkeit / Auditability**: Jeder Fixschritt MUSS einen
  eigenen Git-Commit mit aussagekräftiger Conventional-Commit-Message erzeugen,
  damit der Revisionsverlauf nachvollziehbar bleibt.

---

## Schlüsselobjekte / Key Entities

- **Schwachstelle / Weakness (SW-xx)**: Ein identifizierter Ist-/Soll-Abstand
  aus dem Audit, mit Schweregrad HOCH / MITTEL / NIEDRIG.
- **Migrationsskript / Migration Script**: Idempotentes Skript, das bestehende
  Dateien auf Zielstand bringt, ohne Inhalte zu zerstören.
- **Baseline**: Erster `STATS.md`-Eintrag, der den Ist-Zustand vor allen
  Reparaturen festhält — als Vergleichspunkt für spätere Scans.
- **Constitution-Propagation**: Mechanismus zur synchronen Verteilung einer
  neuen Constitution-Version in alle Child-Repos.

---

## Erfolgskriterien / Success Criteria

- **SC-REV-01**: `check-homogeneity.sh` liefert für alle Ebenen 0–2 Exit-Code `0`
  nach Abschluss aller Maßnahmen.

- **SC-REV-02**: Alle Root-Agentendateien (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`,
  `README.md`, `copilot-instructions.md`) enthalten mindestens je einen DE- und
  EN-Abschnitt.

- **SC-REV-03**: `STATS.md` auf Root-Ebene enthält eine Baseline-Zeile
  (Ist-Zustand) und mindestens eine Post-Fix-Zeile mit verbessertem Score.

- **SC-REV-04**: `Lastenheft_workspace-homogeneity-guardian.md` ist in
  `.gitignore` als `!Lastenheft*.md` whitelisted und wird von `git status` als
  getracktes File angezeigt.

- **SC-REV-05**: `rename-lastenheft.sh` benennt eine Test-Datei korrekt um und
  erzeugt einen `git mv`-Commit.

- **SC-REV-06**: Der GitHub-Actions-Workflow läuft grün auf `ubuntu-22.04` nach
  einem Push auf `main`.

---

## Annahmen / Assumptions

- Die bestehenden Pre-Push-Hooks auf Ebene 0–1 sind korrekt — nur Ebene 2
  muss noch geprüft werden.
  *Existing pre-push hooks at levels 0–1 are correct — only level 2 needs checking.*

- Die Bilingualisierung bestehender Agentendateien erfolgt durch Platzhalter-
  Einfügung; inhaltliche Übersetzung ist eine nachgelagerte Aufgabe.
  *Bilingual migration inserts placeholders; actual translation is a follow-up task.*

- GitHub Actions Free-Tier ist für alle privaten Repos verfügbar (2 000 Minuten/
  Monat für private Repos reichen für diesen Workflow aus).

- Die KI-Agenten-CLIs (`claude`, `codex`, `gemini`) sind nicht zwingend
  auf allen Maschinen installiert; das Revisionsskript prüft ihre Verfügbarkeit
  vor jedem Aufruf.

---

## Abhängigkeiten zum Bezugs-Lastenheft / Dependencies to Reference Lastenheft

| Revisions-FR | Bezug / Reference |
|---|---|
| FR-REV-A01–A04 | FR-G01–G05 (README-Dokumentation) |
| FR-REV-B01 | FR-A01–FR-A05 (Homogenitätsprüfung) |
| FR-REV-B02 | FR-F01–FR-F05 (Bootstrap) |
| FR-REV-B03 | Dateibenennungs-Konvention (Abschnitt 2) |
| FR-REV-B04 | FR-E01–FR-E05 (Statistik) |
| FR-REV-C01–C02 | FR-A02 (Dateipräsenz-Prüfung) |
| FR-REV-D01–D02 | FR-F01 Schritt 12–15 |
| FR-REV-E01–E02 | FR-I01–FR-I05 (C#-Konventionen) |
| FR-REV-F01–F02 | Constitution Prinzip IV |
| FR-REV-G01–G03 | NFR-REV-04 (Plattform ubuntu-22.04) |

---

## Dateibenennungs-Konvention / File Naming Convention

Gilt auf allen Ebenen (0, 1, 2) — identisch mit dem Bezugs-Lastenheft.

- **Vor Spec-kit-Lauf**: `Lastenheft_workspace-homogeneity-guardian-revision.md`
- **Nach Spec-kit-Lauf**: `Lastenheft_workspace-homogeneity-guardian-revision.{branch}.md`

---

## Barrierefreiheit / Accessibility (A11Y)

### Docs-A11Y-Checkliste / Docs A11Y Checklist

- [x] Alle Tabellen haben Kopfzeilen / All tables have header rows
- [x] Überschriftenhierarchie ohne Sprünge / Heading hierarchy without gaps
- [x] ASCII-Diagramme haben Klartextbeschreibung (Legende) / ASCII diagrams have plain-text description
- [ ] Keine Bilder vorhanden — kein Alt-Text erforderlich / No images — no alt text needed
- [x] Abkürzungen beim ersten Vorkommen erklärt (SW = Schwachstelle, LTS, SDD) / Abbreviations explained

*Dieses Dokument ist Speckit-kompatibel und kann direkt als Eingabe für
`speckit plan` und `speckit tasks` verwendet werden.*

*This document is Speckit-compatible and can be used directly as input for
`speckit plan` and `speckit tasks`.*
hwachstelle, LTS, SDD) / Abbreviations explained

*Dieses Dokument ist Speckit-kompatibel und kann direkt als Eingabe für
`speckit plan` und `speckit tasks` verwendet werden.*

*This document is Speckit-compatible and can be used directly as input for
`speckit plan` and `speckit tasks`.*
