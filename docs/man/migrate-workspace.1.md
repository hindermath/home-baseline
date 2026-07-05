# migrate-workspace(1)

## NAME

`migrate-workspace.sh`, `migrate-workspace.ps1` - migriert einen Workspace auf die Homogenitaets-Baseline. *Migrates a workspace to the homogeneity baseline.*

## SYNOPSIS

```bash
bash scripts/migrate-workspace.sh [workspace-name] [options]
```

```powershell
pwsh -NoProfile -File scripts/migrate-workspace.ps1 [-WorkspaceName <name>] [options]
```

## DESCRIPTION

Das Skript bringt einen bestehenden Workspace auf die aktuelle Homogenitaets-Baseline: es aktualisiert `.gitignore` fuer erkannte Sub-Repositories, legt Standarddateien an und ruft `init-stats` fuer die gemeinsame Statistik auf. Mehrere Migrationen nicht parallel starten, da `init-stats` die geteilte Level-0/1/2-Statistik aktualisiert.

*The script brings an existing workspace to the current homogeneity baseline: it updates `.gitignore` for detected sub-repositories, creates standard files, and calls `init-stats` for the shared statistics. Do not run several migrations in parallel, because `init-stats` updates the shared level-0/1/2 statistics.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `[workspace-name]` | `-WorkspaceName <name>` | Zu migrierender Workspace (optional) |
| `--dry-run` | `-WhatIf` | Vorschau ohne Aenderungen |
| `--yes` | `-Force` | Rueckfragen ueberspringen |

## EXAMPLES

```bash
bash scripts/migrate-workspace.sh RiderProjects --dry-run
```

```powershell
pwsh -NoProfile -File scripts/migrate-workspace.ps1 -WorkspaceName RiderProjects -Force
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | teilweiser Fehlschlag / partial fail |
| 2 | kritischer Fehler / critical error |

## SEE ALSO

`check-homogeneity.1`, `init-stats.1`, `bootstrap-workspace.1`
