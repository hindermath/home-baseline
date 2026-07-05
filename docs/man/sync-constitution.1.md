# sync-constitution(1)

## NAME

`sync-constitution.sh`, `sync-constitution.ps1` - synchronisiert `constitution.md` in alle Level-1-Workspaces. *Synchronizes `constitution.md` into all level-1 workspaces.*

## SYNOPSIS

```bash
bash scripts/sync-constitution.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/sync-constitution.ps1 [options]
```

## DESCRIPTION

Das Skript verteilt die kanonische `~/constitution.md` in alle erkannten Level-1-Workspaces. `--dry-run` zeigt die geplanten Kopiervorgaenge, `--yes` ueberspringt die Bestaetigung.

*The script distributes the canonical `~/constitution.md` into all detected level-1 workspaces. `--dry-run` shows the planned copy operations, `--yes` skips the confirmation.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Vorschau ohne Schreibvorgang |
| `--yes` | `-Force` | Rueckfrage ueberspringen |

## EXAMPLES

```bash
bash scripts/sync-constitution.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/sync-constitution.ps1 -Force
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler oder unbekannte Option / error or unknown option |

## SEE ALSO

`sync-home.1`, `migrate-workspace.1`
