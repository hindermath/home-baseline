# Erste Schritte mit home-baseline

[English version](getting-started.en.md)

## Zweck und Modell

`home-baseline` trennt drei Ebenen: die versionierte Level-0-Quelle, daraus
verteilte betriebliche Dateien und ausschließlich lokalen Maschinenzustand.
Diese Trennung schützt private Daten und macht Änderungen prüfbar.

## Voraussetzungen installieren

1. Git installieren und Identität konfigurieren.
2. Auf Windows PowerShell 7, auf macOS/Linux Bash verwenden.
3. Für die jeweilige Hosting-Plattform optional `gh` oder `glab` installieren.
4. Für Spec Kit Python, `uv` und `specify-cli` nach Projektvorgabe installieren.
5. Für vollständige Prüfungen `rg`, Python 3 und `pwsh` bereitstellen.

Ein GitHub-Konto ist nur für den GitHub-Pfad oder optionale Copilot-Anmeldung
nötig. GitLab, Codeberg, Forgejo und institutionelle Git-Systeme sind ebenfalls
möglich.

## Level 0 einrichten

```bash
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-source
cd ~/home-baseline-source
bash scripts/bootstrap-workspace.sh --dry-run Ausbildung
```

Auf Windows:

```powershell
git clone https://github.com/hindermath/home-baseline.git "$HOME/home-baseline-source"
Set-Location "$HOME/home-baseline-source"
pwsh -NoProfile -File scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung -WhatIf
```

Die Vorschau zeigt Nebenwirkungen, bevor Dateien angelegt oder Werkzeuge
installiert werden. Erst nach Prüfung wird derselbe Befehl ohne Vorschauoption
ausgeführt.

## Bestehende Projekte einordnen

- Level 0 enthält gemeinsame Workspace-Governance und wiederverwendbare Skripte.
- Level 1 gruppiert Projekte, zum Beispiel `RiderProjects` oder `C64Projects`.
- Level 2 ist ein einzelnes Produkt-, Lern- oder Preset-Repository.

Registrierung und Migration werden zuerst im Prüfmodus ausgeführt. Eine neuere
Remote-README oder bestehende Nutzeränderung darf nicht still überschrieben
werden.

## Spec Kit beginnen

Spec Kit unterstützt Specification-Driven Development, also Entwicklung aus
einer geprüften Spezifikation. Der übliche Weg ist:

1. Intake erstellen oder aktualisieren.
2. Intake unabhängig prüfen.
3. Feature spezifizieren und Unklarheiten klären.
4. Plan, Tasks und Analyse konvergieren.
5. Implementieren, validieren und nur mit passender Autorität liefern.

Die installierten Governance-Presets ergänzen diese Schritte. Ihre Priorität
bestimmt die Kompositionsreihenfolge, nicht ihre Wichtigkeit. Details stehen in
[Spec-Kit-Preset-Prioritäten](maintenance/Spec-Kit-Preset-Priorities.md).

Für den ersten Wartungslauf führt der
[Effizienzleitfaden](maintenance/agentic-workspace-efficiency-guide.md#erster-sicherer-lauf-first-safe-run)
schrittweise von der Hilfe über Check-only und Vorschau bis zur sicheren
nächsten Aktion.

## Nächste Aktion

Lernende öffnen [START-HERE](learning-units/START-HERE-FUER-LERNENDE.md). Maintainer lesen
[Source und Home Runtime](architecture/source-and-home-runtime.md), bevor sie
Dateien ändern oder synchronisieren.
