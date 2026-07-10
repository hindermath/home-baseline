# propagate-learning-series(1)

## NAME

`propagate-learning-series.sh`, `propagate-learning-series.ps1` - propagiert revidiertes Lernreihen-Material aus Level-0 in die Level-1- und Level-2-Repos einer Serie.

## SYNOPSIS

```bash
bash scripts/propagate-learning-series.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/propagate-learning-series.ps1 [options]
```

## DESCRIPTION

Das Skript kopiert das serienspezifische Lernmaterial aus Level-0 (`~/home-baseline-tmp/docs/learning-units/`) in die zugehoerigen Repos: Lastenhefte (Intakes), Uebersichten, `Rahmenlehrplan-Lernfeld-Mapping.md`, das IT-Berufe-Mapping, die Lernbegleiter unter `lernbegleiter/`, die Vorlagen unter `templates/`, das gemeinsame Secure-Trader-Universum (`Secure-Trader-*.md`, u. a. die Systemlandschaft), beide Lernenden-Startanleitungen und den geteilten Datensatz-Baum unter `datasets/` (Generator, CSVs, `schema.sql`). Beide Startanleitungen werden zusaetzlich in die Repo-Wurzel gespiegelt und dort aus der README verlinkt.

Die Ziel-Repos werden aus `~/.home-baseline/level2-repository-registry.json` ermittelt und ueber den Serien-Praefix gefiltert. Level-2-Repos erhalten die Intakes zusaetzlich in der Repo-Wurzel (Bootstrap-Layout); Level-1 erhaelt nur `docs/learning-units/`. Andere Reihen (z. B. Secure InventoryHub) und die Ordner `dist/` und `presentations/` bleiben unberuehrt.

Der Lauf ist idempotent: nur echte Inhaltsaenderungen erzeugen einen Commit. Vor Aenderungen verlangt er einen sauberen `main`, der `origin/main` folgt, prueft `origin` gegen die erwartete `hindermath`-Remote und aktualisiert per `fetch` plus `pull --ff-only`. Dirty, divergierte, falsch zugeordnete oder anders ausgecheckte Repositories werden ohne Reset oder Force-Push uebersprungen und im Abschlussbericht genannt. Ist mindestens eine Zieldatei neuer als ihre kanonische Quelle, wird das ganze Repo vor der ersten Kopie uebersprungen; es entsteht kein Teil-Commit. Bei Aenderungen committet und pusht das Skript pro Repo auf `main`; der Commit enthaelt keinen modellbezogenen Co-Author-Trailer.

*The script copies the series-specific learning material, both learner start guides, and the shared dataset tree from Level 0 into the matching repositories. Both guides are also mirrored to each repository root and linked from its README. Target repos are discovered from the level-2 registry and filtered by series prefix. Before changing a target, the script requires a clean `main` tracking `origin/main`, checks `origin` against the expected `hindermath` remote, and updates it with fetch plus fast-forward-only pull. Dirty, diverged, wrongly mapped, or differently checked-out repositories are skipped without reset or force-push and reported. If any target file is newer, the whole repository is skipped before copying, preventing partial commits. Only real changes create a neutral commit that is pushed to `main`.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-DryRun` / `-WhatIf` | Vorschau ohne Schreiben / preview without writing |
| `--no-push` | `-NoPush` | Committen ohne Push / commit without pushing |
| `--series NAME` | `-Series NAME` | Serien-/Registry-Praefix (Standard: `SecureCaseTracker`) |
| `--file-prefix NAME` | `-FilePrefix NAME` | Datei-Praefix mit Bindestrich (Standard aus Serie abgeleitet, z. B. `Secure-CaseTracker`) |
| `--home-dir DIR` | `-HomeDir DIR` | Basisverzeichnis fuer Repos (Standard: `~`) |
| `--registry PFAD` | — | Abweichende Registry-Datei / alternative registry file |
| `--verbose`, `-v` | `-Verbose` | Einzelne Dateien anzeigen / show individual files |

## EXAMPLES

```bash
# Vorschau ueber alle Repos der Serie / preview across all series repos
bash scripts/propagate-learning-series.sh --dry-run --verbose

# Realer Lauf: syncen, committen, pushen
bash scripts/propagate-learning-series.sh

# Nur committen, nicht pushen
bash scripts/propagate-learning-series.sh --no-push
```

```powershell
pwsh -NoProfile -File scripts/propagate-learning-series.ps1 -DryRun
```

## FILES

- Quelle / source: `~/home-baseline-tmp/docs/learning-units/`
- Registry: `~/.home-baseline/level2-repository-registry.json`
- Ziel / target: `<repo>/docs/learning-units/`, beide Startanleitungen und README-Verweis in der Repo-Wurzel sowie bei Level-2 die Root-Intakes

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Propagation oder Vorschau erfolgreich |
| 1 | fehlende Quelle/Registry/Werkzeuge, keine Repos, uebersprungene Repos oder Push-Fehler |
| 2 | ungueltige Option / invalid option |

## SEE ALSO

`package-learning-series(1)`, `register-level2-repository(1)`, `propagate-security-guidance(1)`
