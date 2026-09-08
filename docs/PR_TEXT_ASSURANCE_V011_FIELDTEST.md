# Assurance v0.1.1: Patch und Feldtest / Patch and field test

## Problem

TinyCalc #67 deckt zwei reale Paketfehler auf: nicht installierte generierte
Validatorpfade und nichtdeterministische Read-only-Hashvergleiche.

*TinyCalc #67 found generated paths that do not exist and nondeterministic
read-only snapshots in the initial public field-test release.*

## Loesung / Solution

Kanonische v0.1.1-Quellen und Publikationskopie korrigieren beide Defekte.
Ein neuer Installationstest prueft acht erzeugte Agentenoberflaechen und
unterscheidet echte Missing-Evidence-Diagnosen von Syntax-/Pfadfehlern.
Native Linux-/macOS-/Windows-CI prueft beide Regressionen.

Paket-PR #2 ist nach allen drei nativen Gates gemergt. Das unveraenderliche
v0.1.1-Tag-ZIP ist als Feldtest-Prerelease veroeffentlicht und installiert.
Die optionale 13er-Matrix, installierte Kopie und erzeugten Oberflaechen dieses
Quellrepos wurden gemeinsam aktualisiert. Die TinyCalc-Integration und beide
fachlichen Feldtestlaeufe sind weiterhin getrennte offene Folgephasen.

*The compatible patch fixes both defects at their source. Installation tests
execute generated paths; contract tests compare canonical raw-byte snapshots.
Evidence schema, command arguments, exit codes and approval boundaries stay
unchanged.*

*Package PR #2 passed all three native gates and is merged. The immutable
v0.1.1 field-test prerelease archive is installed and pinned in the optional
thirteen-preset matrix. TinyCalc integration and substantive field tests remain
separate follow-up phases; this source PR does not claim their completion.*

## Risiko und Authority / Risk and authority

Keine Produktlogik, Baseline-, Secret-, Provider- oder Schutzregelaenderung.
Der Owner genehmigte MergeAndSync mit formalem Admin-Bypass, nie mit Umgehung
materieller Gates. Alte Release-Tags bleiben unveraendert. Installation,
Feldtest und breite Freigabe sind getrennte Schritte.

*Only formal merge rules may use the approved bypass. An unavailable formal
approval is not recorded as an actual independent review. No community
submission or sandbox work is included.*

## Testplan und Dokumentation / Tests and documentation

- `pwsh -NoProfile -File specs/spec-kit-presets/secure-development-assurance-governance/tests/test-secure-development-assurance.ps1`
- `pwsh -NoProfile -File specs/spec-kit-presets/secure-development-assurance-governance/tests/test-installed-surfaces.ps1`
- PSScriptAnalyzer, Shell-Syntax, Secret-Scan und Diff-Pruefung.
- Native Assurance-CI und bestehende Pflichtchecks am exakten PR-Head.
- Dokumentationsauswirkung: `UpdateRequired`, source-only, kein Home-Sync.

Aktueller Fortschritt und Grenzen:
[Feldtest-Nachweis](maintenance/secure-development-assurance-v011-field-test.md).

*See the linked record for observed red/green results and still-open steps.
Successful local checks do not imply an accepted field test.*
