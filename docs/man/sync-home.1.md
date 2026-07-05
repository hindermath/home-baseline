# sync-home(1)

## NAME

`sync-home.sh`, `sync-home.ps1` - synchronisiert `~/home-baseline-tmp` nach `~/`. *Synchronizes `~/home-baseline-tmp` into `~/`.*

## SYNOPSIS

```bash
bash scripts/sync-home.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/sync-home.ps1 [options]
```

## DESCRIPTION

Das Skript kopiert Skripte und Hooks aus dem Git-Klon `~/home-baseline-tmp` in die lokale Kopie `~/`. Standardmaessig wird zuvor `git pull` im Klon und danach ein `git commit` in `~/` ausgefuehrt; beide Schritte lassen sich abschalten.

*The script copies scripts and hooks from the git clone `~/home-baseline-tmp` into the local copy `~/`. By default it runs `git pull` in the clone beforehand and `git commit` in `~/` afterwards; both steps can be disabled.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--pull` | — | `git pull` vor dem Sync (Standard) |
| `--no-pull` | `-NoPull` | Kein `git pull`, nur kopieren |
| `--commit` | — | `git commit` in `~/` nach dem Sync (Standard) |
| `--no-commit` | `-NoCommit` | Kein automatischer Commit in `~/` |
| `--dry-run` | `-WhatIf` | Nur anzeigen, was gemacht wuerde |

## EXAMPLES

```bash
bash ~/scripts/sync-home.sh --no-pull
```

```powershell
pwsh -NoProfile -File scripts/sync-home.ps1 -NoCommit
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler / error |

## SEE ALSO

`sync-constitution.1`
