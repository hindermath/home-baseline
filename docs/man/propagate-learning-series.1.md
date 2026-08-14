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

Das Skript kopiert das serienspezifische Lernmaterial aus Level-0 (`~/home-baseline-source/docs/learning-units/`) in die zugehoerigen Repos: Lastenhefte (Intakes), Uebersichten, `Rahmenlehrplan-Lernfeld-Mapping.md`, das IT-Berufe-Mapping, die Lernbegleiter unter `lernbegleiter/`, die Vorlagen unter `templates/`, das gemeinsame Secure-Trader-Universum (`Secure-Trader-*.md`, u. a. die Systemlandschaft), beide Lernenden-Startanleitungen und den geteilten Datensatz-Baum unter `datasets/` (Generator, CSVs, `schema.sql`). Beide Startanleitungen werden zusaetzlich in die Repo-Wurzel gespiegelt und dort aus der README verlinkt. Der bilinguale Leitsatz `Programmierung #include<everyone>` / `Programming #include<everyone>` wird idempotent direkt nach der ersten README-Ueberschrift verankert; vorhandener README-Inhalt bleibt erhalten.

Die Ziel-Repos werden aus `~/.home-baseline/level2-repository-registry.json` ermittelt und ueber den Serien-Praefix gefiltert. Level-2-Repos erhalten die Intakes zusaetzlich in der Repo-Wurzel (Bootstrap-Layout); Level-1 erhaelt nur `docs/learning-units/`. Andere Reihen (z. B. Secure InventoryHub) und die Ordner `dist/` und `presentations/` bleiben unberuehrt.

Der Lauf ist idempotent: nur echte Inhaltsaenderungen erzeugen einen Commit. Vor Aenderungen verlangt er einen sauberen `main`, der `origin/main` folgt, prueft `origin` gegen die erwartete `hindermath`-Remote und aktualisiert per `fetch` plus `pull --ff-only`. Dirty, divergierte, falsch zugeordnete oder anders ausgecheckte Repositories werden ohne Reset oder Force-Push uebersprungen und im Abschlussbericht genannt. Ist mindestens eine Zieldatei neuer als ihre kanonische Quelle, wird das ganze Repo vor der ersten Kopie uebersprungen; es entsteht kein Teil-Commit. Bei Aenderungen committet und pusht das Skript pro Repo auf `main`; der Commit enthaelt keinen modellbezogenen Co-Author-Trailer.

Mit `--shared-guides-only` beziehungsweise `-SharedGuidesOnly` ist der Umfang
absichtlich enger: Nur `START-HERE-FUER-LERNENDE.md`,
`GIT-START-FUER-LERNENDE.md` und `INSTITUTIONELLES-GIT-HOSTING.md` werden in
die Repo-Wurzel und nach `docs/learning-units/` kopiert. Intakes,
Lernbegleiter, Vorlagen, Datensaetze und README bleiben unberuehrt. Sauberkeits-,
Remote-, Fast-forward- und Neuer-als-Quelle-Pruefungen gelten in diesem Modus
nur fuer diese sechs Zielpfade.

*The script copies the series-specific learning material, both learner start guides, and the shared dataset tree from Level 0 into the matching repositories. Both guides are also mirrored to each repository root and linked from its README. It idempotently places the bilingual `Programmierung #include<everyone>` / `Programming #include<everyone>` guiding principle directly after the first README heading while preserving existing README content. Target repos are discovered from the level-2 registry and filtered by series prefix. Before changing a target, the script requires a clean `main` tracking `origin/main`, checks `origin` against the expected `hindermath` remote, and updates it with fetch plus fast-forward-only pull. Dirty, diverged, wrongly mapped, or differently checked-out repositories are skipped without reset or force-push and reported. If any target file is newer, the whole repository is skipped before copying, preventing partial commits. Only real changes create a neutral commit that is pushed to `main`.*

*With `--shared-guides-only` or `-SharedGuidesOnly`, the scope is deliberately
limited to the three shared learner guides in the repository root and
`docs/learning-units/`. Intakes, companions, templates, datasets, and README
remain untouched. Safety checks apply only to those six target paths.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-DryRun` / `-WhatIf` | Vorschau ohne Schreiben / preview without writing |
| `--no-push` | `-NoPush` | Committen ohne Push / commit without pushing |
| `--shared-guides-only` | `-SharedGuidesOnly` | Nur die drei gemeinsamen Guides in Root und `docs/learning-units/` / only the three shared guides in root and `docs/learning-units/` |
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

# Nur gemeinsame Guides pruefen
bash scripts/propagate-learning-series.sh --shared-guides-only --dry-run --verbose
```

```powershell
pwsh -NoProfile -File scripts/propagate-learning-series.ps1 -DryRun
```

## FILES

- Quelle / source: `~/home-baseline-source/docs/learning-units/`
- Registry: `~/.home-baseline/level2-repository-registry.json`
- Ziel / target: `<repo>/docs/learning-units/`, beide Startanleitungen, README-Verweis und sichtbarer Leitsatz in der Repo-Wurzel sowie bei Level-2 die Root-Intakes

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Propagation oder Vorschau erfolgreich |
| 1 | fehlende Quelle/Registry/Werkzeuge, keine Repos, uebersprungene Repos oder Push-Fehler |
| 2 | ungueltige Option / invalid option |

## SEE ALSO

`package-learning-series(1)`, `register-level2-repository(1)`, `propagate-security-guidance(1)`
