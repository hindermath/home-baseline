# Contract: Maintenance CLI

## Entrypoints

- macOS/Linux: `bash scripts/maintain-agentic-workspace.sh`
- Windows: `pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1`
- PowerShell-Cmdlet: `Invoke-HBAgenticWorkspaceMaintenance`

## Modes

| Meaning | Bash | PowerShell |
|---|---|---|
| Update | no mode flag | no mode switch |
| Read-only | `--check-only` | `-CheckOnly` |
| Preview | `--dry-run` | `-WhatIf` |
| Scripts only | `--scripts-only` | `-ScriptsOnly` |
| Include optional | `--include-optional` | `-IncludeOptional` |
| Permit current-run admin prompt | `--allow-admin-prompts` | `-AllowAdminPrompts` |
| Alternate HOME | `--home-dir PATH` | `-HomeDir PATH` |
| Alternate manifest | `--manifest PATH` | `-ManifestPath PATH` |

Check-only und Preview sind gegenseitig ausgeschlossen. Admin-Prompts sind
standardmäßig verboten und dürfen weder Credentials speichern noch loggen.

## Output and exits

Textausgabe: Start, höchstens eine Ergebniszeile pro Ziel/Abschnitt,
Abschlussstatus sowie Log- und Reportpfad. Bedeutung hängt nicht von Farbe ab.

- `0`: Erfolg oder ausschließlich optionale Warnung.
- `1`: Drift oder unvollständige erforderliche Arbeit.
- `2`: fataler Aufruf-, Schema-, Source- oder Orchestrierungsfehler.
- `3`: nur bestehender kompatibler `repair-drift`-Erfolg.

Beide Oberflächen müssen dieselben Entscheidungen, Statusklassen und
semantisch äquivalenten Berichtsfelder liefern.
