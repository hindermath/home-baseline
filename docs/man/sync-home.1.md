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

Das Skript synchronisiert die im Home-Sync-Manifest verwalteten, mit Git versionierten Dateien aus `~/home-baseline-tmp` in die lokale Betriebskopie `~/`. Standardmaessig wird zuvor `git pull` im Klon und danach ein pfadbegrenzter `git commit` in `~/` ausgefuehrt; beide Schritte lassen sich abschalten.

*The script synchronizes Git-tracked files selected by the Home sync manifest from `~/home-baseline-tmp` into the local runtime copy `~/`. By default it runs `git pull` in the clone beforehand and a path-limited `git commit` in `~/` afterwards; both steps can be disabled.*

Der Klon bleibt dauerhaft die versionierte Level-0-Quelle. SHA-256, Dateimodus
und Quell-Commit werden unter `~/.home-baseline/home-sync-state.json`
protokolliert. Lokale Konflikte stoppen den Lauf vor dem ersten Schreibzugriff.
In der ABS-DD-Sandbox sind schreibende Sync-Laeufe nach `/home/adedev`
gesperrt; dort wird die eingebundene Referenz direkt verwendet.

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--pull` | — | `git pull` vor dem Sync (Standard) |
| `--no-pull` | `-NoPull` | Kein `git pull`, nur kopieren |
| `--commit` | — | `git commit` in `~/` nach dem Sync (Standard) |
| `--no-commit` | `-NoCommit` | Kein automatischer Commit in `~/` |
| `--dry-run` | `-WhatIf` | Nur anzeigen, was gemacht wuerde |
| `--check-only` | `-CheckOnly` | Ohne Pull und Schreibzugriff auf Drift pruefen |
| `--force` | `-Force` | Gepruefte Konflikte verwalteter Dateien ueberschreiben |

## EXAMPLES

```bash
bash ~/scripts/sync-home.sh --no-pull
```

```bash
bash ~/scripts/sync-home.sh --check-only
```

```powershell
pwsh -NoProfile -File scripts/sync-home.ps1 -NoCommit
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Drift oder Konflikt / drift or conflict |
| 2 | Betriebs- oder Konfigurationsfehler / operational or configuration error |

## SEE ALSO

`sync-constitution.1`
