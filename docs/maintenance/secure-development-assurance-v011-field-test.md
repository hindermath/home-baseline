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
  Cross-Shell-Regression lokal bestanden. Native Linux-/macOS-CI bestanden;
  Windows-Fixture-Korrektur wartet auf den neuen nativen Nachweis.
- P03: [Quell-PR #269](https://github.com/hindermath/home-baseline/pull/269)
  und [Paket-PR #2](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/2)
  sind offen. Die Installationsmatrix bleibt bis zum
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

## Ergaenzende CI- und Kompositionsbefunde / Additional CI and composition findings

- Erster nativer Paketlauf
  [33968047207](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/33968047207):
  Linux und macOS bestanden. Windows fand eine unzulaessige
  `WriteAllText`-Mutation einer Hidden-Testdatei. Die Korrektur trennt echte
  Hidden-Enumeration von Byte-Mutationen an einer normalen Testdatei;
  lokale Suite und ScriptAnalyzer bestanden erneut.
- Die neue Skriptdatei erforderte die deterministische Ergaenzung von
  `docs/scripts/embedded-scripts.md`; keine Katalogaenderung notwendig.
- Vollstaendiger lokaler Lifecycle: 13 aktiv, Aufloesung und `specify check`,
  Disable/Enable, Remove, danach exakte Profile 12, 11, 10, 9 und 8 bestanden.
  Der neue exakte 13er-Versionscheck und Archiv-Reinstall folgen dem Release.
- Spec Kit 0.12.11 entfernt beim Multi-Agent-Uninstall nur Skills der aktiven
  Integration. Zwei Claude-Skills bleiben verwaist; ihre fehlenden Validatoren
  fuehren nicht zu einem fachlichen Erfolg. Der Runbook-Hinweis dokumentiert
  diese CLI-Grenze und die enge manuelle Bereinigung. Kein CLI-Patch,
  keine Community-Einreichung und kein pauschaler Remove-Erfolgsnachweis.
- Der Review entdeckte ausserdem eine Body-Paritaetsluecke: auch ein nackter
  Top-Level-Pfad in erklaerender Prosa wird vom Generator umgeschrieben.
  Die kanonische Korrektur und die neue Body-Regression sind vor Release
  zwingend; der technische TinyCalc-Paritaetstest bleibt unveraendert.

*The first native CI exposed a Windows-only fixture issue, now corrected
without weakening raw-byte or hidden-file checks. Script inventory is
regenerated. Existing profiles 8 through 12 compose correctly. CLI removal
leaves two unusable Claude skills in this multi-agent setup; the runbook
records that limitation, not a complete uninstall pass. Exact generated-body
parity is an additional mandatory regression before publication.*

### Windows-Hashparitaet / Windows hash parity

Der Paketlauf
[33968631847](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/33968631847)
am Head `8c889b969b46b293d11793cf6a3041e5d82ee64f` besteht die neue
Snapshot-Regression, zeigt danach aber einen echten Bash-Validatorfehler:
Exit 2, `Manifest-Hashdrift`, trotz unveraenderter positiver Fixture.
Windows-`jq.exe` kann normalisierte LF beim Ausgeben wieder in CRLF umwandeln;
dieses Verhalten ist im [jq-Handbuch](https://jqlang.org/manual/#invoking-jq)
beschrieben. Die enge Korrektur entfernt solche CR erst hinter der bestehenden
semantischen Normalisierung, vor SHA-256. Rohe Read-only-Hashes, Schemas,
API und menschliche Freigaben bleiben unveraendert. Die native Windows-
Bestaetigung bleibt zwingend vor Release.

*Native Windows exposed a normalized-hash mismatch after the snapshot checks
passed. The jq manual documents native newline conversion. Remove the
reintroduced CR bytes only after semantic line normalization and before
hashing; do not alter raw read-only hashes, schemas or human decisions.
A native passing run is still required before publication.*

Der Folgelauf
[33968996666](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/33968996666)
am Head `1995d6d6b4866e73c4fb6492e7ed59a873e11ed8` bestaetigt den
Hash-Fix und legt dieselbe native Zeilenenden-Konvertierung bei Listen offen.
Die Abhilfe wird daher zentral auf alle jq-Aufrufe einschliesslich `xargs`
angewendet: `--binary`, wenn unterstuetzt; andernfalls exakte LF-Probe fuer
aelteres POSIX-jq. Nicht unterstuetzte native CRLF-Ausgabe oder ein fehlerhafter
Probeprozess blockieren mit Exit 2. Keine nachtraegliche pauschale Entfernung
fachlicher CR aus JSON-Werten. Neue Fixtures pruefen moderne, alte LF-,
alte CRLF- und fehlerhafte Varianten getrennt. Der neue Workflow laeuft je
PR-Stand einmal und zusaetzlich auf `main`; die Plattform-Gates bleiben gleich.

*The following native run passed hashing and exposed the same conversion in
lists. Apply binary output centrally to all jq calls, retaining tested legacy
POSIX LF behavior. Unsupported native CRLF output or a faulty probe fails
closed. Do not strip semantic CR from JSON values. Test modern, legacy LF,
legacy CRLF and faulty tools separately. CI avoids duplicate push/PR runs
while retaining the same platform gates.*
