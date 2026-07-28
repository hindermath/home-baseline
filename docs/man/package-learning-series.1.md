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

Die Skripte erstellen ein ZIP-Paket aus einem Level-1-Lernreihenordner. Das Paket enthaelt keine `.git`-Verzeichnisse, keine urspruenglichen Remote-URLs, keine lokalen Build-/IDE-Artefakte und keine lokalen `intake-review-result.json`- oder `intake-review-report.md`-Nachweise. Portable Preset-, Policy- und Guidance-Dateien bleiben enthalten. `START-HERE-FUER-LERNENDE.md` ist der verbindliche Root-Einstieg; `GIT-START-FUER-LERNENDE.md` und `INSTITUTIONELLES-GIT-HOSTING.md` werden ebenfalls aufgenommen. Fehlt eine dieser Dateien, bricht die Paketierung ab.

*The scripts create a ZIP package from a level-1 learning-series folder. The package contains no `.git` directories, original remotes, local build/IDE artefacts, or local intake-review result/report evidence. Portable preset, policy, and guidance files remain included. `START-HERE-FUER-LERNENDE.md` is the required root entry; `GIT-START-FUER-LERNENDE.md` and `INSTITUTIONELLES-GIT-HOSTING.md` are included as well.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--source-dir DIR` | `-SourceDir DIR` | Level-1-Quellordner der Lernreihe |
| `--series-name NAME` | `-SeriesName NAME` | Anzeigename fuer Manifest und Paketname |
| `--output-dir DIR` | `-OutputDir DIR` | Zielordner fuer ZIP und SHA256 |
| `--package-prefix NAME` | `-PackagePrefix NAME` | Dateiname-Prefix |
| `--start-guide PATH` | `-StartGuide PATH` | Startanleitung relativ zu `SourceDir` oder absolut |
| `--git-guide PATH` | `-GitGuide PATH` | Git-Startanleitung relativ zu `SourceDir` oder absolut |
| `--hosting-guide PATH` | `-HostingGuide PATH` | Leitfaden fuer institutionelles Git-Hosting |
| `--dry-run` | `-WhatIf` | Vorschau ohne ZIP-Erzeugung |

## EXAMPLES

```bash
bash scripts/package-learning-series.sh \
  --source-dir ~/secure-casetracker-baseline \
  --series-name "Secure CaseTracker" \
  --package-prefix secure-casetracker \
  --dry-run
```

```powershell
pwsh -NoProfile -File scripts/package-learning-series.ps1 `
  -SourceDir ~/secure-casetracker-baseline `
  -SeriesName 'Secure CaseTracker' `
  -PackagePrefix secure-casetracker `
  -WhatIf
```

## OUTPUT

- ZIP-Datei unter `docs/learning-units/dist/` des Quellordners, sofern kein anderer Zielordner angegeben wird.
- SHA256-Datei mit gleichem Namen und Suffix `.sha256`.
- `PACKAGING-MANIFEST.txt` im ZIP mit Branch-/Commit-/Dirty-Status ohne Remote-URLs.
- Beide Startanleitungen im Paket-Root; das Manifest verweist auf beide Dateien.

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Paket oder Vorschau erfolgreich |
| 1 | fehlende Parameter, fehlende Werkzeuge oder Paketierungsfehler |
