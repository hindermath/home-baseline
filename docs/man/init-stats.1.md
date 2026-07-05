# init-stats(1)

## NAME

`init-stats.sh`, `init-stats.ps1` - erzeugt eine `STATS.md`-Baseline fuer einen Workspace. *Generates a `STATS.md` baseline for a workspace.*

## SYNOPSIS

```bash
bash scripts/init-stats.sh [workspace-name-or-path]
```

```powershell
pwsh -NoProfile -File scripts/init-stats.ps1 [-WorkspaceName <name>]
```

## DESCRIPTION

Das Skript ruft `check-homogeneity` auf und schreibt aus dem Ergebnis eine `STATS.md`-Baseline mit Compliance-Score und ASCII-Fortschrittsbalken. Ohne Argument wird der aktuelle Workspace verwendet.

*The script invokes `check-homogeneity` and writes a `STATS.md` baseline from the result, including the compliance score and an ASCII progress bar. Without an argument the current workspace is used.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `[workspace-name-or-path]` | `-WorkspaceName <name>` | Workspace-Name oder Pfad (optional) |

## EXAMPLES

```bash
bash scripts/init-stats.sh RiderProjects
```

```powershell
pwsh -NoProfile -File scripts/init-stats.ps1 -WorkspaceName RiderProjects
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler / error |

## SEE ALSO

`check-homogeneity.1`, `migrate-workspace.1`
