# Statistik-Preset-Pilot / Statistics preset pilot

Aktueller Schritt 4, Teil 1 / Current step 4, part 1:
[Native Home-Baseline-Nachweise bestanden](project-statistics-home-native-proof-v010.md).
Der [lokale Pilotnachweis](../project-statistics-pilot/README.md) dokumentiert
die vorherige macOS-Pruefphase; deren native Fortsetzung steht im neuen Nachweis.
Die PR-Vorbereitung mit regulaerer Statistik-Fortschreibung bleibt offen.
Native evidence now supplements the earlier local macOS record; statistics
refresh and governed PR delivery remain pending.
Die Installation aus Schritt 3 ist mit [PR #300](https://github.com/hindermath/home-baseline/pull/300)
geliefert; der [lokale Installationsnachweis](project-statistics-installation-v010.md)
bleibt als historischer Vorbereitungsstand erhalten. / Installation is delivered;
the original local installation receipt remains historical.
Schritt 2 wurde mit [PR #299](https://github.com/hindermath/home-baseline/pull/299)
nach 18 gruenen Checks gemergt; der folgende lokale Vorbereitungsstand bleibt historisch erhalten.
Step 2 is merged; the local preparation evidence below remains historical.

## Umfang / Scope

Genehmigt: Project Statistics Governance v0.1.0 als Pre-Release und getrennte
Pilotberichte in Home Baseline, TinyCalc und absdd-image-sandbox. Owner und
fachlicher Reviewer: Thorsten Hindermann. Technische Ergebnisse ersetzen keine
menschliche Freigabe. Keine Community-Einreichung, stabile Freigabe,
Legacy-Abloesung oder allgemeine Flottenverteilung.

Approved: v0.1.0 pre-release and separate reports in the three named projects.
Owner/reviewer: Thorsten Hindermann. Technical results grant no human approval.
No community submission, stable promotion, legacy replacement or fleet rollout.

## Quelle und Profil / Source and profile

Produktquelle ist ausschliesslich
[Project Statistics Governance](https://github.com/hindermath/spec-kit-preset-project-statistics-governance).
Das optionale Profil `project-statistics-fourteen-governance-presets` ergaenzt
die unveraenderte 13-Preset-Matrix um Statistik mit Prioritaet 90.
Alle bisherigen Profile und globale Defaults bleiben erhalten. Nur die drei
genehmigten Piloten duerfen in Schritt 3 die neue Zuordnung erhalten;
die zentrale Profildefinition allein aendert keine Projektzuordnung.

The standalone repository is the only product source. The optional fourteen
preset profile adds statistics at priority 90 to the unchanged thirteen-preset
matrix. Existing profiles and global defaults remain unchanged. Only the three
approved pilots may opt in during step 3; defining the profile changes no
project assignment.

Der Pilotkontext liegt unter `docs/project-statistics-pilot/`. Der bisherige
Renderer und die Portfolio-Auswertung bleiben bestehen; neue Ausgaben werden
als generierte Artefakte ausgeschlossen. Referenz-Modellrechnungen bleiben aus.

Pilot context: `docs/project-statistics-pilot/`. Keep the existing renderer and
portfolio consumers. Exclude new generated outputs. Reference estimates stay off.

## Tracking / Tracking

- [Zentral / Central #1](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/issues/1)
- [Home #298](https://github.com/hindermath/home-baseline/issues/298)
- [TinyCalc #84](https://github.com/hindermath/TinyCalc/issues/84)
- [Sandbox #70](https://github.com/hindermath/absdd-image-sandbox/issues/70)

## Nachweise / Evidence

### Veroeffentlichte Quelle / Published source

- [v0.1.0-Pre-Release](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/releases/tag/v0.1.0)
- Commit: `7e824ca8de11212aefdc5b05d7d05637f5343dab`
- Tag-ZIP-SHA-256: `d8ad7d5eef920f50b629121b64ba8123c22ec4f6dadd14da5cd826d1c50f420a`
- Kanonische Bindung / canonical binding: [preset-source-lock.json](preset-source-lock.json).
- [Native Produkt-CI / native product CI](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/actions/runs/34852050586):
  macOS/Linux je 67 Assertions, Windows 61; Installations-Lifecycle auf allen
  drei Plattformen bestanden. Die Release-Assets sichern die Originalnachweise.

Die Quellenbindung ist kein Feldtest-Abschluss. GitHub meldet fuer dieses
Release keine aktivierte Immutability-Sperre. Tag/Commit und ZIP-SHA-256
werden deshalb explizit gegen die Quellenliste geprueft; Drift blockiert.
Der Installer konsumiert die Profilmatrix, nicht automatisch diese separate
Quellenliste: vor jedem Pilotlauf bleibt die ZIP-Hashpruefung erforderlich.

Source provenance is not field acceptance. GitHub release immutability is not
enabled. Validate tag/commit and ZIP SHA-256 against the source lock; drift
blocks the source test. The installer consumes the profile matrix, not this
separate provenance lock; verify the ZIP hash before each pilot installation.

### Zentrale Profilpruefung / Central profile validation

Schritt 2 prueft ausschliesslich die zentrale Vorbereitung. Der Source-Test
laedt die 14 hashgebundenen Pakete und installiert Profile 8 bis 14 nur in
temporaeren Fixtures. Er prueft IDs, Versionen, Prioritaeten, Aktivstatus,
`preset list`, `preset info`, Template-Resolve sowie Bash-/PowerShell-CheckOnly.
Zusaetzlich prueft er, dass das Standardprofil unveraendert acht Presets hat
und das 14er-Profil die unveraenderte 13er-Matrix plus Statistik v0.1.0 bei
Prioritaet 90 enthaelt. Assurance- und Statistik-Kommandotests bleiben aktiv.

Step 2 validates central preparation only. The source test downloads all 14
hash-bound packages and installs profiles 8 through 14 exclusively in temporary
fixtures. It checks exact registry state, list/info/resolve and both installer
CheckOnly entrypoints, unchanged defaults and additive composition. Assurance
and statistics generated-command tests remain active.

```powershell
pwsh -NoProfile -File scripts/tests/test-preset-sources.ps1
```

Die Home-Sync-Fixtures pruefen zusaetzlich, dass alle zwoelf moeglichen
Statistik-Commandpfade (drei Kommandos, vier Agentenpfade) nicht in eine
temporaere Home-Runtime gelangen; ein bestehendes Spec-Kit-Kommando bleibt
enthalten. Es wird kein echter Home-Sync ausgefuehrt.

Home-Sync fixtures additionally exclude all twelve statistics command paths
(three commands, four agent paths) while retaining an existing Spec Kit
command. No real Home Runtime sync is performed.

```bash
python3 -m unittest scripts/tests/test_home_sync_files.py
```

Lokaler Pruefstand 2026-09-14: macOS/arm64, PowerShell 7.6.6, Spec Kit 0.12.8.
Basiscommit `ade796af59bdd2248a264d0dc0d3f45728997838`; Commit und Push auf
`codex/project-statistics-pilot` sind als Zwischensicherung beauftragt.
PR, Merge und Pilotinstallation bleiben offen. Die folgenden Resultate gelten
fuer die unten gebundenen lokalen Dateien, nicht fuer einen Remote-CI-Lauf.

| Pruefung / Check | Ergebnis / Result |
| --- | --- |
| Source-Test: Tag/Commit und ZIP-SHA-256 | 14 Pakete verifiziert; Exit 0 |
| Profile 8, 9, 10, 11, 12, 13, 14 | Alle sieben Profile mit list/info/resolve und Bash-/PowerShell-CheckOnly bestanden |
| Assurance-Vertraege und generierte Commands | Vollstaendiger gebundener Paketselbsttest und installierte Oberflaechen bestanden |
| Statistik-Preset-Lifecycle | Isolierte Installation, Commands, Resolve, Disable/Enable, Remove/Reinstall bestanden |
| Home-Sync-Fixtures | 8 Tests bestanden; kein echter Home-Sync |
| 14er-Installer-Vorschau auf Home Baseline | Bash Dry-Run und PowerShell WhatIf: nur Statistik fehlt; keine Installation |
| Bestehende 13er-Home-Installation | Bash und PowerShell CheckOnly: exakt gueltig, Exit 0 |
| PSScriptAnalyzer 1.25.0 fuer geaenderten PowerShell-Test | Keine Warning-/Error-Befunde |
| Workflow-YAML und Drei-Runner-Matrix | Geparst und geprueft; actionlint lokal nicht verfuegbar |
| Git-Diff | Keine Whitespace-Fehler; Preset- und generierte Command-Installationen unveraendert |

| Gebundene Datei / Bound file | SHA-256 |
| --- | --- |
| scripts/config/spec-kit-project-statistics-governance-presets.json | `f71224fc7c6c5e68431a9dfe507e8210f834d70c91f5dc63b85ce9f608fa6617` |
| docs/maintenance/preset-source-lock.json | `b28dfda0582fddf49245b454b76d45fbbe72761af810e6ec662cfa1ac874b763` |
| scripts/tests/test-preset-sources.ps1 | `9c3946ca54e54501aeac089d834a0cdc461d67255729ff290b3cd53499cffca4` |
| scripts/config/home-sync-manifest.json | `4d7c1b85fa134b3c25c325b0542bd85a2f0de24a8552762900af1e3b576d0d0b` |

Native Linux-/Windows-Pruefung der geaenderten zentralen Tests ist noch offen;
die gruenen Produkt-CI-Nachweise oben ersetzen sie nicht. Der vorbereitete
Workflow prueft alle drei Plattformen bei der spaeteren PR-Lieferung.
Das commitgebundene Rendering der bestehenden Profil-2-Statistik folgt erst
nach dem Inhaltscommit; der aktuelle Ledger-Eintrag dokumentiert Vorbereitung,
nicht abgeschlossene Pilotabnahme.

Local macOS validation passed all seven profiles, fourteen source bindings,
both shell CheckOnly entrypoints, assurance and statistics package tests,
eight Home-Sync fixtures and PowerShell analysis. The existing thirteen-preset
installation and generated commands remain unchanged. The local files are
hash-bound above; commit and push to the pilot branch are authorized as an
intermediate checkpoint, not PR/merge delivery or pilot installation. Native
Linux/Windows evidence for the modified central suite is pending; existing
product CI is not a substitute. The configured three-platform workflow runs
with later PR delivery. Legacy statistics rendering follows the content commit;
the current ledger entry records preparation, not pilot acceptance.

### Offene Folgeschritte / Remaining steps

Schritt 3: Installation und Zuordnung in Home Baseline, TinyCalc und Sandbox.
Danach folgen eigenstaendige Messungen, drei Pilotberichte und die geregelte
Lieferung. Der zentrale Feldbericht und die Schliessung der Tracking-Issues
folgen erst nach allen drei Piloten. Keine `ReleaseAccepted`-Behauptung aus
einer reinen Quellen- oder Profilpruefung.

Step 3 installs and assigns the profile in the three approved projects.
Independent measurements, three pilot reports and governed delivery follow.
Publish the central field report and close tracking only after all pilots;
source/profile checks alone do not establish `ReleaseAccepted`.

## Dokumentationsauswirkung / Documentation impact

UpdateRequired. Owner: Thorsten Hindermann. Zielgruppen: Maintainer, Lernende,
Pruefende. Leserpfad: Preset-Quellenuebersicht -> dieses Dokument -> separater
Pilotbericht -> kanonischer Feldbericht im Produktrepository.
Quelle: Produktrepository fuer Messkern/Methodik; Home Baseline fuer Profile
und Integrationsnachweise. ActiveSemantic; DE zuerst/EN danach.
Plattformnachweise kommen aus nativer Paket-CI und den ausgefuehrten Piloten.
Bestehende Statistik wird regulaer gepflegt, aber nicht migriert.
Kein Home-Runtime-Sync in diesem Auftrag; Pilotbefehle bleiben source-only.
Wiedervorlage bei Preset-, Methoden-, Profil- oder Konfigurationsaenderung.

UpdateRequired. Maintainers, learners and reviewers follow the source index,
this integration record, the separate pilot report and the canonical field
report. The product repository owns code/methodology; Home Baseline owns
profiles/integration. Active semantic bilingual documentation. Platform proof
comes from executed CI/pilots. Maintain legacy statistics without migration.
No Home Runtime sync; pilot commands stay source-only. Reevaluate on version,
method, profile or configuration changes.
