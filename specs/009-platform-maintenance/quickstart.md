# Quickstart: Feature 009 Validation

## Prerequisites

- macOS/Linux mit Bash, Git und Python 3.
- PowerShell 7 für die Paritätsprüfung.
- Keine echten Flotten- oder Provider-Schreibrechte erforderlich.

## Contract tests

```bash
python3 -m unittest scripts.tests.test_maintenance_contracts
python3 -m unittest scripts.tests.test_agentic_workspace_maintenance
bash -n scripts/maintain-agentic-workspace.sh
pwsh -NoProfile -Command '$null = [System.Management.Automation.Language.Parser]::ParseFile("scripts/maintain-agentic-workspace.ps1", [ref]$null, [ref]$null)'
```

Erwartung: Positive Fixtures bestehen; ungültige Manifeste, unsichere
Repositoryzustände und fehlerhafte Reports werden mit den vereinbarten
Statusklassen abgelehnt.

## Safe-mode validation

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

Erwartung: Check-only verändert keine Arbeitsdateien. Preview beschreibt Clone-
und Pull-Aktionen, führt sie aber nicht aus. Beide Varianten erzeugen
semantisch äquivalente Berichte.

## Repository gates

```bash
git diff --check
bash scripts/scan-agent-secrets.sh --fail-on-high .
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
bash scripts/maintain-agentic-workspace.sh --check-only
```

Ein echter Update-Lauf erfolgt erst nach erfolgreicher Vorschau und expliziter
aktueller Autorität. Ziel-Repositories werden in Feature 009 nicht committed
oder gepusht.
