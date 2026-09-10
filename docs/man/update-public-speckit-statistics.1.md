# update-public-speckit-statistics(1)

## NAME

update-public-speckit-statistics — öffentliche Spec-Kit-Läufe erheben und rendern / collect and render public Spec Kit runs

## SYNOPSIS

`bash scripts/update-public-speckit-statistics.sh [--action Collect|Validate|Render] [--repo PATH] [--check-only|--dry-run]`

## DESCRIPTION

PowerShell 7 ist die kanonische Engine. `Collect` liest öffentliche GitHub-Belege
mit `gh`, prüft das versionierte Register und schreibt nur bei geänderter Evidence
einen Snapshot. `Validate` und `Render` arbeiten offline; nur `Render` ersetzt
markierte README-Blöcke und generierte Dateien. Keine Git-Schreiboperationen.

*PowerShell 7 is the canonical engine. Collect reads public GitHub evidence with gh
and writes a snapshot only for changed evidence. Validate and Render work offline;
Render replaces marked README blocks and generated files. No Git writes.*

## OPTIONS

- `--action`: Aktion; Standard `Validate`. / Action; default Validate.
- `--repo`: Level-0-Quelle; Standard ist die Quelle des Skripts. / Source checkout; defaults to script source root.
- `--check-only`: keine Dateien schreiben, Drift melden. / No writes; report drift.
- `--dry-run`: Schreibvorschau; bei Collect mit Remote-Lesezugriff. / Write preview; Collect still reads remote evidence.
- `--help`: Hilfe. / Help.

PowerShell: `-Action`, `-Repo`, `-CheckOnly`, `-WhatIf`.

## EXIT STATUS

`0`: Erfolg/aktuell; `1`: Drift; `2`: Aufruf-, Quellen- oder Validierungsfehler.

*0: success/current; 1: drift; 2: invocation, source or validation error.*

## EXAMPLES

`bash scripts/update-public-speckit-statistics.sh --action Collect --dry-run`

`bash scripts/update-public-speckit-statistics.sh --action Render --check-only`

## SEE ALSO

[Zählvertrag und Betrieb / Counting contract and operation](../spec-kit-runs/README.md)
