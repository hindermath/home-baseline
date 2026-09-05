# Assurance v0.1.1: Korrektur und Feldtest / Correction and field test

## Auftrag und Grenzen / Authority and boundaries

Der Owner hat die Preset-Korrektur, v0.1.1-Veroeffentlichung, TinyCalc-PR #67,
genau zwei serielle RL-SE-/GSDB-Laeufe und den Abschlussbericht genehmigt.
MergeAndSync gilt mit Admin-Bypass ausschliesslich fuer formale Merge-Regeln.
Diese neue Freigabe ersetzt das fruehere Bypass-Verbot in TinyCalc #66 und
home-baseline #268. Materielle technische, Security-, A11Y-, fachliche Review-
und Evidence-Gates bleiben zwingend. Keine Community-Einreichung, kein
Sandbox-Lauf, keine Produkthaertung und keine Schutzregelaenderung.

*The owner approved the patch release, existing installation PR, exactly two
serial field tests, and final report. Formal-rule-only admin bypass replaces
the previous prohibition, never a material gate. Community submission,
sandbox work, product hardening, and ruleset changes remain excluded.*

## Ausgangspunkt / Starting point

- Quellstand / Source: home-baseline `467a761`.
- Installation: TinyCalc PR #67, Head `5635a25cd5580b411155cbed65779ae8879e7ef3`.
- SDA-FT-001: erzeugte Validatorpfade sind nicht ausfuehrbar.
- SDA-FT-002: Read-only-Snapshots sind reihenfolge-/formatabhaengig.
- v0.1.0 bleibt unveraendert. v0.1.1 ist vor Freigabe ein Feldtest-Kandidat.
- Lokale Spec-Kit-CLI: `0.12.11`; der installierte Stand wird geprueft, nicht
  automatisch auf eine andere Version umgestellt.

*The generated paths and nondeterministic hash snapshots require correction.
The existing public release remains immutable; the patch is a field-test
candidate. The current CLI is tested without an implicit toolchain upgrade.*

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`: Preset-Quellen, Installationsanleitungen, Runbook und
Release-Evidence fuer Maintainer und Lernende. Quellen sind die Scaffolds unter
`specs/spec-kit-presets/`; Export und installierte Oberflaechen werden daraus
abgeleitet. Owner: Thorsten Hindermann. DE-first/EN-second, CEFR B2,
textorientierter Leserpfad: Fehler -> Korrektur -> Tests -> Installation ->
Feldtest. Source-only; kein Home-Sync und kein Flotten-Rollout. Die bestehenden
Versions-/Schema-/Freigabegrenzen bleiben unveraendert.

*Update the canonical preset sources and derived usage/release documentation.
The source-only change requires no Home synchronization or fleet rollout.
Review generated paths and readable bilingual instructions together.*

## Sicherheitsanwendbarkeit / Security applicability

NIST SSDF, CWE Top 25, sichere Pfad-/Prozessbehandlung, Release-Provenienz und
anwendbare SBOM-/VEX-/SLSA-Nachweise gelten. A11Y: WCAG 2.2 AA, soweit auf
Text-/CLI-Artefakte anwendbar. ASVS und Zero Trust: N/A fuer lokale Validatoren
ohne Webdienst. Produkt-AI-SBOM: N/A, KI nur als Entwicklungswerkzeug.
Wiedervorlage bei neuem Dienst, Abhaengigkeit oder Produkt-KI.

*Apply secure-development, process/path, supply-chain, and text-accessibility
checks. Web-service and product-AI controls are not applicable to these local
validators; reassess when that scope changes.*

## Laufstand / Execution state

- P01: Quellen und Autoritaet geprueft; Issues/PR aktualisiert.
- P02: Beide gezielten Rot-Nachweise erbracht; kanonische Korrektur und
  Cross-Shell-Regression lokal bestanden. Native Plattform-CI und Review offen.
- P03: Quell-PR wird vorbereitet. Die Installationsmatrix bleibt bis zum
  realen Patch-Release auf dem vorhandenen v0.1.0-Archiv; sie wird danach
  gemeinsam mit der installierten Kopie auf v0.1.1 gebracht.
- P04-P06: Noch nicht begonnen; kein Feldtest gestartet.

*Local red/green regressions pass. Native CI, review, publication, integration,
both field tests, and the final report remain open. Deployment pins change
only once the replacement archive actually exists.*

## Gezielte Evidenz / Focused evidence

- SDA-FT-001 Rot: Installationstest meldet ungueltigen generierten Codex-Pfad,
  Exit 1. Gruen: acht Status-/Review-Oberflaechen mit vorhandenem Bash- und
  PowerShell-Validator, korrektem Missing-Evidence-Grund und Exit 2.
- SDA-FT-002 Rot: umgekehrte Enumeration meldet
  `Snapshot depends on enumeration order`, Exit 1. Gruen: kanonische Pfade,
  versteckte Dateien, Mutationen und rohe BOM/CRLF-Aenderungen erkannt.
- Vollstaendiger bestehender Validatorvertrag und Bash-/PowerShell-Paritaet:
  Exit 0. Plattform: macOS, PowerShell 7.6.5, Spec Kit 0.12.11.
- Vier echte Mixed-Mode-Gate-Reviews pro Shell: acht erfolgreiche Aufrufe;
  acht fehlende Runbooks mit Exit 2 und genauer Ursache. Jeder Aufruf bleibt
  bytegleich read-only. Closure bleibt `NeedsRemediation`, alle drei
  menschlichen Entscheidungen bleiben `Open`.
- PSScriptAnalyzer 1.25.0: beide Testskripte ohne Findings.
- Bestehende Maintenance-Vertragstests: 22 Tests erfolgreich.
- Schema/API: keine fachliche Aenderung. Regulierung, Standards und bestehende
  fachliche Baseline werden nicht durch diesen Patch veraendert.

*Both original defects have observed red/green regressions. Local results do
not claim native Windows/Linux execution; those runners remain CI gates.*

*All four mixed-mode gates pass in both shells. Missing runbooks fail with
the expected cause. Raw-byte snapshots remain unchanged after each call;
neither remediation closure nor human decisions are promoted by validation.*
