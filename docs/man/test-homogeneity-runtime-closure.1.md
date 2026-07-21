# test-homogeneity-runtime-closure(1)

## Name / Name

`test-homogeneity-runtime-closure.sh`, `test-homogeneity-runtime-closure.ps1` -
prueft das vollstaendige Homogeneity-Hilfspaket und seinen Fail-closed-Vertrag.

*Validates the complete Homogeneity helper package and its fail-closed contract.*

## Verwendung / Usage

```bash
bash scripts/test-homogeneity-runtime-closure.sh [REPOSITORY_ROOT]
pwsh -NoProfile -File scripts/test-homogeneity-runtime-closure.ps1 [-RepoRoot PATH]
```

Der Test erzeugt eine temporaere unvollstaendige Installation, die Exitcode 2
liefern muss. Anschliessend wird das vollstaendige Paket im Dry-Run geprueft.

*The test creates an incomplete temporary installation that must return exit
code 2. It then checks the complete package in dry-run mode.*

## Exitcodes / Exit Codes

- `0`: Beide Vertragspruefungen waren erfolgreich. / Both contract checks passed.
- `1`: Mindestens eine Vertragspruefung ist fehlgeschlagen. / At least one contract check failed.
