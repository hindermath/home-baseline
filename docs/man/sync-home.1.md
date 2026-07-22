# sync-home(1)

## NAME

`sync-home.sh`, `sync-home.ps1` - synchronisiert `~/home-baseline-source` nach `~/`. *Synchronizes `~/home-baseline-source` into `~/`.*

## SYNOPSIS

```bash
bash scripts/sync-home.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/sync-home.ps1 [options]
```

## DESCRIPTION

Das Skript synchronisiert die im Home-Sync-v2-Manifest als `homeRuntime`
klassifizierten, mit Git versionierten Dateien aus `~/home-baseline-source` in
die lokale Betriebskopie `~/`. Dazu gehoeren Skripte, gemeinsame Agent-Guidance
und ausgewaehlte Spec-Kit-Oberflaechen. `sourceOnly`-Artefakte werden direkt aus
dem dauerhaften Klon gelesen; `machineLocal`-Dateien bleiben lokal verwaltet.
Standardmaessig wird zuvor `git pull` im Klon und danach ein pfadbegrenzter
`git commit` in `~/` ausgefuehrt; beide Schritte lassen sich abschalten. Ein
echter No-op erzeugt auch unter dem mit macOS gelieferten Bash 3.2 keinen Commit
und endet erfolgreich.

*The script synchronizes Git-tracked files classified as `homeRuntime` by the
Home Sync v2 manifest from `~/home-baseline-source` into the local runtime copy
`~/`. `sourceOnly` artifacts are read from the permanent clone and
`machineLocal` files remain locally managed. By default, sync pulls the clone
first and creates a path-limited Home commit afterwards; both steps are
optional. A real no-op creates no commit and succeeds under macOS Bash 3.2.*

Der Klon bleibt dauerhaft die versionierte Level-0-Quelle. SHA-256, Dateimodus
und Quell-Commit werden unter `~/.home-baseline/home-sync-state.json`
protokolliert. Lokale Konflikte stoppen den Lauf vor dem ersten Schreibzugriff.
In der ABS-DD-Sandbox sind schreibende Sync-Laeufe nach `/home/adedev`
gesperrt; dort wird die eingebundene Referenz direkt verwendet.

Beim Wechsel von State v1 auf v2 werden Pfade ausserhalb von `homeRuntime` aus
der Verwaltung entlassen, aber nicht geloescht. Nur explizite
`legacyCleanupPaths` erlauben eine Entfernung. Ein lokal veraenderter
Cleanup-Pfad bleibt ein blockierender Konflikt. Freigegebene Pfade bleiben im
lokalen State als Provenienz erhalten.

*During the v1-to-v2 state transition, paths outside `homeRuntime` are released
from management without deletion. Only explicit `legacyCleanupPaths` permit
removal. A locally modified cleanup target remains a blocking conflict.
Released paths remain in local state as provenance.*

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
