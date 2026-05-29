# Arbeitsnotiz: cc65 EN-Guidance-Check nach Level-0 uebernehmen

Status: offen
Quelle: `/Users/thorstenhindermann/C64Projects/cc65`
Quelle-Commit: `178105978 Relax homogeneity EN guidance check`
Datum: 2026-05-28

## Anlass

Im cc65-Repo wurde die Homogeneity-Pruefung korrigiert, weil die alte Regel nur den Literal-Marker `<!-- EN:` akzeptiert hat. Dateien mit echter DE/EN-Guidance, zum Beispiel `Gemeinsame ... / Shared ...`, wurden dadurch faelschlich als `EN placeholder missing` gemeldet.

Die Korrektur ist Level-0-relevant, weil Homogeneity- und Migrationsskripte aus `home-baseline` heraus in andere Workspaces wirken. Wenn Level-0 die alte Regel behaelt, kann sie spaeter wieder falsche Marker-Pflichten oder unnoetige Placeholder erzeugen.

## Zu pruefende Uebernahme

- `scripts/check-homogeneity.sh`
- `scripts/check-homogeneity.ps1`
- `scripts/migrate-workspace.sh`
- `scripts/migrate-workspace.ps1`

## Gewuenschtes Verhalten

- `<!-- EN:` bleibt als expliziter Placeholder-/Template-Marker gueltig.
- Echte bilinguale Guidance zaehlt ebenfalls als gueltig, insbesondere DE/EN-Ueberschriften mit Slash-Form und passende DE/EN-Begriffspaare.
- `README.md` ist nicht mehr Teil der EN-Placeholder-Pflicht fuer Agent-/Governance-Dateien; fuer README gelten die vorhandenen Abschnittspruefungen.
- Die Migrationsskripte schreiben keine EN-Placeholder in Dateien, die bereits echte bilinguale Guidance enthalten.

## Validierung fuer Level-0

- `bash -n scripts/check-homogeneity.sh scripts/migrate-workspace.sh`
- PowerShell-Parser fuer `scripts/check-homogeneity.ps1` und `scripts/migrate-workspace.ps1`
- `bash scripts/check-homogeneity.sh --dry-run --no-patch .`
- `pwsh -NoProfile -File scripts/check-homogeneity.ps1 -TargetDir . -DryRun -NoPatch`
- Optional: Migration dry-run gegen ein Test-Workspace

## Hinweise aus cc65

- Bash-Dry-run nach Korrektur: `100 % (24/24 checks)`
- PowerShell-Dry-run nach Korrektur: `100 % (24/24 checks)`
- Beim cc65-Fix wurde zusaetzlich der Param-Block in `scripts/migrate-workspace.ps1` repariert, weil vorher `Set-StrictMode` vor `[CmdletBinding()] param(...)` stand.

## Entscheidung

Level-0 soll entscheiden, ob der cc65-Fix direkt uebernommen oder in eine groessere Homogeneity-Guardian-Revision integriert wird.
