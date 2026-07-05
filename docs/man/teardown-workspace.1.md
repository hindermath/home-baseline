# teardown-workspace(1)

## NAME

`teardown-workspace.sh`, `teardown-workspace.ps1` - entfernt einen Workspace lokal und optional das Remote-Repository. *Removes a workspace locally and optionally the remote repository.*

## SYNOPSIS

```bash
bash scripts/teardown-workspace.sh <WorkspaceName> [options]
```

```powershell
pwsh -NoProfile -File scripts/teardown-workspace.ps1 -WorkspaceName <Name> [options]
```

## DESCRIPTION

Das Skript baut einen Workspace kontrolliert ab: es entfernt das Verzeichnis, bereinigt `README.md`, `.gitignore` und die `.gitconfig.d/*.inc`-Fragmente und loescht optional das Remote-Repository. Der geschuetzte Name `home-baseline` wird abgelehnt. Mit `--dry-run` werden alle Aktionen nur angezeigt.

*The script tears a workspace down in a controlled way: it removes the directory, cleans up `README.md`, `.gitignore`, and the `.gitconfig.d/*.inc` fragments, and optionally deletes the remote repository. The protected name `home-baseline` is rejected. With `--dry-run` all actions are only shown.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<WorkspaceName>` | `-WorkspaceName <Name>` | Abzubauender Workspace (Pflicht) |
| `--backup` | `-Backup` | Vor der Loeschung ein Backup-Archiv erstellen |
| `--keep-remote` | `-KeepRemote` | Remote-Repository nicht loeschen |
| `--recursive` | `-Recursive` | Level-2-Repositories zuerst verarbeiten |
| `--force` | `-Force` | Sicherheitspruefungen ueberspringen |
| `--yes` | `-Yes` | Rueckfrage ueberspringen |
| `--dry-run` | `-WhatIf` | Alle Aktionen ohne Ausfuehrung zeigen |

## EXAMPLES

```bash
bash scripts/teardown-workspace.sh WebstormProjects --dry-run
```

```powershell
pwsh -NoProfile -File scripts/teardown-workspace.ps1 -WorkspaceName WebstormProjects -Backup -KeepRemote
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 2 | ungueltige Option, fehlender oder geschuetzter Workspace / invalid option, missing or protected workspace |

## SEE ALSO

`bootstrap-workspace.1`, `bootstrap-project.1`
