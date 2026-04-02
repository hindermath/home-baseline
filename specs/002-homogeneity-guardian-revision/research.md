# Forschungsergebnisse / Research Findings
# Phase 0 — Workspace Homogeneity Guardian Revision

**Feature**: `002-homogeneity-guardian-revision`  
**Datum / Date**: 2026-04-02  
**Status**: Vollständig / Complete — 10 Klärungsrunden in spec.md integriert

---

## Übersicht / Overview

Alle technischen Entscheidungen wurden durch 10 iterative `speckit-clarify`-Runden
direkt in `spec.md` eingearbeitet (52 Klärungsfragen, 47 vor Round 10 + 5 in Round 10).
Dieses Dokument konsolidiert die wesentlichen Design-Entscheidungen mit Begründung.

*All technical decisions were incorporated into `spec.md` through 10 iterative
`speckit-clarify` rounds (52 clarification questions total). This document consolidates
the key design decisions with rationale.*

---

## Entscheidung 1: Ausgabeformat `check-homogeneity.sh`

**Entscheidung / Decision**: Dual-Output — Klartext auf `stdout`, Markdown-Tabelle in `$GITHUB_STEP_SUMMARY`.

**Begründung / Rationale**: Klartext ist maschinenlesbar und funktioniert in allen Terminal-Kontexten;
die Markdown-Tabelle ist renderbar in der GitHub Actions UI. Beide Ausgabekanäle haben unterschiedliche
Konsumenten und müssen immer befüllt werden.

**Alternativen / Alternatives considered**:
- Nur Markdown → abgelehnt, da Terminal-Ausgabe unleserlich
- Nur Plain Text → abgelehnt, da GitHub Actions UI den Report nicht rendert

**Referenz / Reference**: FR-REV-G01, FR-REV-G02, Clarification Round 10 Q5

---

## Entscheidung 2: STATS.md Prüftiefe

**Entscheidung / Decision**: Nur Präsenz-Check — Datei existiert → PASS, fehlt → FAIL.

**Begründung / Rationale**: Konsistent mit dem Präsenz-Prinzip aller anderen Pflichtdateien
(`README.md`, `constitution.md`, `AGENTS.md`). Inhaltsprüfung würde false-positive Failures
nach einem frischen `init-stats.sh`-Lauf riskieren (leere Datei).

**Alternativen / Alternatives considered**:
- Präsenz + ≥1 Run-Eintrag → abgelehnt, komplexer ohne messbaren Mehrwert
- Präsenz + Header-Validierung → abgelehnt, gleiche Begründung

**Referenz / Reference**: FR-REV-B01, Clarification Round 10 Q4

---

## Entscheidung 3: constitution.md-Quelle für neue Projekte

**Entscheidung / Decision**: `bootstrap-project.sh` kopiert `~/constitution.md` (Level-0-Root)
direkt ins neue Projekt. Spätere Updates übernimmt `sync-constitution.sh`.

**Begründung / Rationale**: Einfachste sofort-korrekte Lösung; neues Projekt ist
beim ersten Scan 100 % compliant. Eine leere constitution.md würde sofort einen `✗`-Befund erzeugen.

**Alternativen / Alternatives considered**:
- Leere constitution.md anlegen → abgelehnt, sofortiger Compliance-Fehler
- constitution.md vom Level-1-Parent kopieren → abgelehnt, Level-0-Root ist kanonische Quelle

**Referenz / Reference**: FR-REV-B02, Clarification Round 10 Q3

---

## Entscheidung 4: bootstrap-project.sh erstellt homogeneity-check.yml direkt

**Entscheidung / Decision**: `bootstrap-project.sh` erstellt `.github/workflows/homogeneity-check.yml`
direkt beim Anlegen des Projekts (kein nachträglicher `migrate-workspace.sh`-Lauf nötig).

**Begründung / Rationale**: Neue Projekte sollen sofort 100 % compliant sein.
Ein zweistufiger Prozess (bootstrap + migrate) wäre fehleranfällig und widerspricht dem
Bootstrap-Automation-Prinzip (Constitution III).

**Alternativen / Alternatives considered**:
- Nur via `migrate-workspace.sh` → abgelehnt, neue Projekte wären initial non-compliant
- Kein CI für neue Projekte → abgelehnt, widerspricht SC-REV-06

**Referenz / Reference**: FR-REV-B02, Clarification Round 10 Q2

---

## Entscheidung 5: init-stats.sh Auto-Aufruf

**Entscheidung / Decision**: Beide `bootstrap-project.sh` UND `migrate-workspace.sh`
rufen am Ende automatisch `bash scripts/init-stats.sh` auf.

**Begründung / Rationale**: Garantiert SC-REV-03 ohne manuellen Zusatzschritt.
`bootstrap`: neue Projekt-Baseline; `migrate`: Post-Migrations-Ist-Zustand.
Der Nutzer muss `init-stats.sh` nie separat aufrufen, wenn er bootstrap/migrate verwendet.

**Referenz / Reference**: FR-REV-A03, FR-REV-B02, Clarification Round 10 Q1

---

## Entscheidung 6: CI-Matrix-Strategie

**Entscheidung / Decision**: Matrix `[ubuntu-22.04, macos-14, windows-latest]`;
Ripgrep-Install je Plattform (`apt-get` / `brew` / `choco`); `bash`/`pwsh` je OS;
`timeout-minutes: 10` pro Job.

**Begründung / Rationale**: Entspricht NFR-REV-04; deckt alle drei Zielplattformen ab.
Timeout als CI-Sicherheitsnetz (NFR-REV-06: kein Timeout in Skripten selbst).

**Referenz / Reference**: FR-REV-G01–G03, NFR-REV-04, Clarification Round 7 Q2

---

## Entscheidung 7: check-homogeneity.sh Argument-Interface

**Entscheidung / Decision**: `check-homogeneity.sh [workspace-name]` —
ohne Argument: globaler Scan Level 0–2; mit Workspace-Namen: nur dieser Level-1-Workspace
und seine Level-2-Projekte (Level-0-Checks entfallen).

**Begründung / Rationale**: CI ruft mit `$(basename "$GITHUB_WORKSPACE")` auf —
Level-0-Checks würden in einem ausgecheckten Workspace-Repo stets fehlschlagen
(kein `~/`-Kontext vorhanden).

**Referenz / Reference**: FR-REV-B01, FR-REV-G01, Clarification Round 8 Q2, Round 9 Q1

---

## Entscheidung 8: STATS.md ASCII-Chart-Format

**Entscheidung / Decision**: Horizontale Balken, eine Zeile pro Scan-Run:
`YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%`
(█ = belegter Anteil, ░ = freier Anteil, 20 Zeichen = 100 %, gerundet auf 5 %).

**Begründung / Rationale**: Plain-Text-kompatibel, A11Y-freundlich (keine ANSI-Codes
gemäß NFR-REV-07), auf allen Terminals lesbar, per Grep auswertbar.

**Referenz / Reference**: FR-REV-B04, NFR-REV-05, Clarification Round 8 Q3

---

## Entscheidung 9: rename-lastenheft.sh Namensformel

**Entscheidung / Decision**: `{original-stem}.{branch-name}.md`
Beispiel: `Lastenheft_foo.md` + Branch `002-bar` → `Lastenheft_foo.002-bar.md`.

**Begründung / Rationale**: Lesbar, reversibel, ohne externe Werkzeuge parsbar.
Konsistent mit dem bestehenden Lastenheft-Naming in `~/`.

**Referenz / Reference**: FR-REV-B03, Clarification Round 7 Q3

---

## Entscheidung 10: Template-Bilinguismus

**Entscheidung / Decision**: Alle 4 Template-Dateien (a11y-section, speckit-workflow-section,
azubis-section, readme-template) sind vollständig bilingual — DE zuerst, EN zweite
Zeile/Abschnitt, CEFR B2.

**Begründung / Rationale**: Konsistent mit dem Projekt-Grundsatz „DE first, EN second".
Templates sind die kanonische Quelle — `migrate-workspace.sh` kopiert ihren Inhalt direkt
in Zieldateien ohne Nachbearbeitung.

**Referenz / Reference**: FR-REV-A01, Clarification Round 8 Q5

---

## Entscheidung 11: sync-constitution.sh — fehlende constitution.md

**Entscheidung / Decision**: Fehlende `constitution.md` in Level-1 wird wie
Versionsabweichung behandelt — kopieren + Status `UPDATED` setzen. Kein Sonderfall.

**Begründung / Rationale**: Einheitliche Behandlung vereinfacht die Logik und den Code.
Das Ergebnis ist in beiden Fällen identisch: Level-1-Workspace hat die aktuelle constitution.md.

**Referenz / Reference**: FR-REV-F01, Clarification Round 8 Q4

---

## Offene Punkte / Open Items

Keine. Alle technischen Entscheidungen sind durch 10 Klärungsrunden vollständig gelöst.
*None. All technical decisions are fully resolved through 10 clarification rounds.*
