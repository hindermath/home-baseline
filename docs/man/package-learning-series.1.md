# package-learning-series(1)

## NAME

`package-learning-series.sh`, `package-learning-series.ps1` - erzeugt ein git-freies ZIP-Paket fuer Lernreihen.

## SYNOPSIS

```bash
bash scripts/package-learning-series.sh --source-dir DIR [options]
```

```powershell
pwsh -NoProfile -File scripts/package-learning-series.ps1 -SourceDir DIR [options]
```

## DESCRIPTION

Die Skripte erstellen ein ZIP-Paket aus einem Level-1-Lernreihenordner. Das Paket enthaelt keine `.git`-Verzeichnisse, keine urspruenglichen Remote-URLs und keine lokalen Build- oder IDE-Artefakte. Es ist fuer die Weitergabe an Lernende gedacht.

*The scripts create a ZIP package from a level-1 learning-series folder. The package contains no `.git` directories, no original remote URLs, and no local build or IDE artefacts. It is intended for distribution to learners.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--source-dir DIR` | `-SourceDir DIR` | Level-1-Quellordner der Lernreihe |
| `--series-name NAME` | `-SeriesName NAME` | Anzeigename fuer Manifest und Paketname |
| `--output-dir DIR` | `-OutputDir DIR` | Zielordner fuer ZIP und SHA256 |
| `--package-prefix NAME` | `-PackagePrefix NAME` | Dateiname-Prefix |
| `--start-guide PATH` | `-StartGuide PATH` | Startanleitung relativ zu `SourceDir` oder absolut |
| `--dry-run` | `-WhatIf` | Vorschau ohne ZIP-Erzeugung |

## EXAMPLES

```bash
bash scripts/package-learning-series.sh \
  --source-dir ~/SecureCaseTrackerProjects \
  --series-name "Secure CaseTracker" \
  --package-prefix secure-casetracker \
  --dry-run
```

```powershell
pwsh -NoProfile -File scripts/package-learning-series.ps1 `
  -SourceDir ~/SecureCaseTrackerProjects `
  -SeriesName 'Secure CaseTracker' `
  -PackagePrefix secure-casetracker `
  -WhatIf
```

## OUTPUT

- ZIP-Datei unter `docs/learning-units/dist/` des Quellordners, sofern kein anderer Zielordner angegeben wird.
- SHA256-Datei mit gleichem Namen und Suffix `.sha256`.
- `PACKAGING-MANIFEST.txt` im ZIP mit Branch-/Commit-/Dirty-Status ohne Remote-URLs.

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Paket oder Vorschau erfolgreich |
| 1 | fehlende Parameter, fehlende Werkzeuge oder Paketierungsfehler |
