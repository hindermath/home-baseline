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

Das Skript kopiert das serienspezifische Lernmaterial aus Level-0 (`~/home-baseline-tmp/docs/learning-units/`) in die zugehoerigen Repos: Lastenhefte (Intakes), Uebersichten, `Rahmenlehrplan-Lernfeld-Mapping.md`, das IT-Berufe-Mapping, die Lernbegleiter unter `lernbegleiter/` und die Vorlagen unter `templates/`.

Die Ziel-Repos werden aus `~/.home-baseline/level2-repository-registry.json` ermittelt und ueber den Serien-Praefix gefiltert. Level-2-Repos erhalten die Intakes zusaetzlich in der Repo-Wurzel (Bootstrap-Layout); Level-1 erhaelt nur `docs/learning-units/`. Andere Reihen (z. B. Secure InventoryHub) und die Ordner `dist/` und `presentations/` bleiben unberuehrt.

Der Lauf ist idempotent: nur echte Inhaltsaenderungen erzeugen einen Commit. Bei Aenderungen committet und pusht das Skript pro Repo auf `main`.

*The script copies the series-specific learning material from Level-0 into the matching repositories: intake files, overviews, the curriculum learning-field mapping, the IT-occupation mapping, the study companions under `lernbegleiter/`, and the templates. Target repos are discovered from the level-2 registry and filtered by the series prefix. Level-2 repos additionally receive the intakes in the repository root (bootstrap layout); Level-1 receives only `docs/learning-units/`. Other series and the `dist/` and `presentations/` folders stay untouched. The run is idempotent; only real content changes create a commit, which is then pushed to `main` per repository.*

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
- Ziel / target: `<repo>/docs/learning-units/` und bei Level-2 zusaetzlich die Repo-Wurzel

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Propagation oder Vorschau erfolgreich |
| 1 | fehlende Quelle/Registry, fehlende Werkzeuge oder keine Repos gefunden |
| 2 | ungueltige Option / invalid option |

## SEE ALSO

`package-learning-series(1)`, `register-level2-repository(1)`, `propagate-security-guidance(1)`
