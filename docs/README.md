# Dokumentationsportal

[English documentation portal](README.en.md)

Dieses Portal führt nach Aufgabe und Zielgruppe zu den kanonischen Dokumenten.
Ein **kanonisches Dokument** ist die verbindliche Quelle, die bei Änderungen
zuerst gepflegt wird. Abgeleitete oder generierte Dateien verlinken dorthin.

## Vier Leserpfade

### Lernende und Neueinsteiger

**Voraussetzungen:** Textbrowser oder Editor; keine Spec-Kit-Erfahrung.

1. [Erste Schritte](getting-started.md) lesen.
2. [Lernreihen-Start](learning-units/START-HERE-FUER-LERNENDE.md) öffnen.
3. Ausbildungsberuf, Lehrjahr und Lern-Unit auswählen.
4. Vor agentischer Arbeit den Sandbox-Preflight durchführen.

**Nächste Aktion:** Die erste freigegebene Unit in der angegebenen Reihenfolge
bearbeiten.

### Tägliche Nutzende

**Voraussetzungen:** Unterstützte Shell und lokaler Level-0-Checkout.

1. [Wartungsportal](maintenance/README.md) öffnen.
2. Betriebssystem und sicheren Prüfmodus auswählen.
3. Textorientiertes Ergebnis und Sperrgründe lesen.
4. Nur die ausdrücklich freigegebene nächste Aktion ausführen.

**Nächste Aktion:** `--dry-run`, `--check-only` oder `-WhatIf` vor einem echten
Wartungslauf verwenden.

### Maintainer und KI-Agenten

**Voraussetzungen:** [Agenten-Guidance](../AGENTS.md) und Constitution gelesen.

1. [Source und Home Runtime](architecture/source-and-home-runtime.md) verstehen.
2. [Skriptreferenz](scripts/reference.md) und betroffene Architektur lesen.
3. Security-, A11Y- und Documentation-Impact-Grenzen bestimmen.
4. Betroffene Validierung ausführen und Evidence festhalten.

**Nächste Aktion:** Nur die kanonische Level-0-Quelle ändern und genau eine
Documentation-Impact-Entscheidung dokumentieren.

### Prüfung und Fehleranalyse

**Voraussetzungen:** Commit-Identität und read-only Evidence-Zugriff.

1. [Prüfung und Fehleranalyse](troubleshooting/README.md) öffnen.
2. Feature, Lauf, exakten Head und akzeptierte Hashes bestimmen.
3. Report-, Event-, Test- und Provider-Evidence vergleichen.
4. Proof-Grenze und Wiedervorlage anwenden.

**Nächste Aktion:** Veraltete Evidence vor einer Entscheidung am aktuellen Head
neu validieren.

Der [Effizienzleitfaden](maintenance/agentic-workspace-efficiency-guide.md)
führt alle vier Pfade in einem ausführlichen, quellengebundenen Betriebsmodell
zusammen.

## Themenbereiche

| Bereich | Kanonischer Einstieg |
|---|---|
| Einstieg und Lernen | [Erste Schritte](getting-started.md), [Lernreihen](learning-units/README.md) |
| Betrieb und Wartung | [Wartung](maintenance/README.md), [Effizienzleitfaden](maintenance/agentic-workspace-efficiency-guide.md), [Manpages](man/) |
| Architektur | [Source und Home Runtime](architecture/source-and-home-runtime.md), [Wartungs-TUI](architecture/maintenance-tui.md) |
| Governance und sichere Entwicklung | [Dokumentations-Governance](documentation-governance.md), [Security](security/README.md), [Secure Development](secure-development/) |
| Technische Referenz | [Skripte](scripts/README.md), [vollständige Skriptreferenz](scripts/reference.md) |
| Prüfung und Fehleranalyse | [Troubleshooting](troubleshooting/README.md), [Projektstatistik](project-statistics.md) |

## Dokumentklassen

- **Aktiv und semantisch:** Wird redaktionell in der kanonischen Quelle gepflegt.
- **Generiert:** Wird über Quelle und Renderer aktualisiert.
- **Archiviert oder historisch:** Bleibt als Evidence unverändert.
- **Agentenoberfläche:** Wird auf allen gepflegten Agentenflächen synchronisiert.
- **Intake- und Feature-Evidence:** Ist an Hashes, Entscheidungen und Proof-Grenzen gebunden.

Die verbindlichen Regeln stehen in
[Dokumentations-Governance](documentation-governance.md).
