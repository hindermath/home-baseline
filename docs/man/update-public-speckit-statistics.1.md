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

Version 3 ergänzt Repo-Schätzungen gegenüber 80 Textzeilen/Arbeitstag. Geprüfte
Profil-2-Werte haben Vorrang; fehlende Werte werden aus GitHub-Daten berechnet.
Summen nutzen Textbestand und Repo-Aktivtage, fehlende Grundlagen zeigen
`nicht berechenbar`. Quellstände und Teilabdeckung bleiben sichtbar. Private
Einzelbelege bleiben privat; nur validierte Summen werden übernommen.

*Version 3 adds repository estimates against 80 text lines/workday. Validated
Profile 2 values take precedence; missing values are calculated from GitHub.
Totals use underlying text stock and repository active days. Missing bases are
not calculable. Source dates and partial coverage remain visible. Private
individual evidence stays private; only validated aggregates are imported.*

- `--action`: Aktion; Standard `Validate`. / Action; default Validate.
- `--repo`: Level-0-Quelle; sonst gemeinsame Quellauflösung. / Source checkout; otherwise uses the shared source resolver.
- `--check-only`: keine Dateien schreiben, Drift melden. / No writes; report drift.
- `--dry-run`: Schreibvorschau; bei Collect mit Remote-Lesezugriff. / Write preview; Collect still reads remote evidence.
- `--help`: Hilfe. / Help.

PowerShell: `-Action`, `-Repo`, `-CheckOnly`, `-WhatIf`.

## EXIT STATUS

Regelversion 2 benötigt das freigegebene `private-aggregate.json` neben dem
öffentlichen Snapshot. Jede öffentliche Repository-Zeile erhält eigene
Ausführungsarten; private Einzelbelege werden von diesem Werkzeug nicht gelesen.
Fehlende oder unzulässige Summen verhindern Validate und Render.

*Rule version 2 requires the sanitized private-aggregate.json beside the public
snapshot. Each public repository has individual execution-mode counts. This
tool never reads private individual evidence. Missing or invalid totals fail
Validate and Render.*

`0`: Erfolg/aktuell; `1`: Drift; `2`: Aufruf-, Quellen- oder Validierungsfehler.

*0: success/current; 1: drift; 2: invocation, source or validation error.*

## EXAMPLES

`bash scripts/update-public-speckit-statistics.sh --action Collect --dry-run`

`bash scripts/update-public-speckit-statistics.sh --action Render --check-only`

## SEE ALSO

[Zählvertrag und Betrieb / Counting contract and operation](../spec-kit-runs/README.md)
