# Assurance-Preset: Korrekturen und Feldtest / Corrections and field test

## Auftrag und Grenzen / Authority and boundaries

Der Owner hat die Preset-Korrektur, v0.1.1-Veroeffentlichung, TinyCalc-PR #67,
genau zwei serielle RL-SE-/GSDB-Laeufe und den Abschlussbericht genehmigt.
MergeAndSync gilt mit Admin-Bypass ausschliesslich fuer formale Merge-Regeln.
Diese neue Freigabe ersetzt das fruehere Bypass-Verbot in TinyCalc #66 und
home-baseline #268. Materielle technische, Security-, A11Y-, fachliche Review-
und Evidence-Gates bleiben zwingend. Der damalige Auftrag schloss eine
Community-Einreichung, Sandbox-Laeufe, Produkthaertung und
Schutzregelaenderungen aus. Am 2026-09-06 hat der Owner nach dem vollstaendigen
GSDB-Closeout die einzelne Community-Einreichung von v0.1.2 ausdruecklich als
separate Folgeaktion genehmigt. Eine Auswahl oder Aktualisierung weiterer
Level-2-Repositories bleibt davon ausgeschlossen und wird spaeter entschieden.

*The owner approved the patch release, existing installation PR, exactly two
serial field tests, and final report. Formal-rule-only admin bypass replaces
the previous prohibition, never a material gate. Community submission,
sandbox work, product hardening, and ruleset changes remained excluded. On
2026-09-06 the owner separately authorised the single v0.1.2 Community
submission after the complete GSDB closeout. Selecting or updating further
Level-2 repositories remains outside this authority and will be decided later.*

Am 2026-09-05 hat der Owner die enge Folgekorrektur SDA-FT-003 als neue
Version v0.1.2 ausdruecklich genehmigt. v0.1.0 und v0.1.1 bleiben unveraendert.
Reihenfolge: Paketkorrektur und Release, bestehender TinyCalc-PR #67 bis
MergeAndSync, RL-SE-Feature, GSDB-Feature, Abschlussbericht und Issue-Closeout.
PR #67 wird vor den beiden Feature-Laeufen geschlossen, nicht danach.

*The owner explicitly approved the narrow SDA-FT-003 correction as v0.1.2.
Preserve both existing releases. Deliver the package and installation PR #67
before starting RL-SE and then GSDB. Finish with the report and issue closeout.*

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
  Cross-Shell-Regression lokal bestanden. Alle drei nativen Plattform-Gates
  bestanden am finalen Paket-Head `41318dbebdbffbd00754dafc8b9064b5ba0eb677`.
- P03: [Quell-PR #269](https://github.com/hindermath/home-baseline/pull/269)
  ist mit `91ef83d97a094d0c9ac603f2c84622674a8d084f` gemergt und lokal
  Fast-Forward-synchronisiert. [Paket-PR #2](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/2)
  ist gemergt und lokal Fast-Forward-synchronisiert. v0.1.1 ist als
  unveraenderlicher Feldtest-Prerelease veroeffentlicht. Die zentrale optionale
  13er-Matrix und die Quellrepo-Installation verwenden nun dieses echte Archiv;
  weder Home noch andere Flotten-Repositories wurden aktualisiert.
- P04: [TinyCalc-PR #67](https://github.com/hindermath/TinyCalc/pull/67)
  installierte v0.1.2 als dreizehntes Preset und wurde als Merge-Commit
  `ed5afad1bbea12f93bbae29332e35f3a54c1abc7` abgeschlossen.
- P05: Der RL-SE-Lauf und sein kausaler Closeout wurden ueber
  [PR #68](https://github.com/hindermath/TinyCalc/pull/68) und
  [PR #69](https://github.com/hindermath/TinyCalc/pull/69) gemergt.
- P06: Der GSDB-Lauf und sein kausaler Closeout wurden ueber
  [PR #70](https://github.com/hindermath/TinyCalc/pull/70) und
  [PR #71](https://github.com/hindermath/TinyCalc/pull/71) gemergt. TinyCalc
  `main` steht auf `94624918c455da86ec59af8e4153e764113725ad`.
- P07: Die einzelne autorisierte Community-Einreichung wurde als
  [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
  angelegt. Der Upstream-Draft-PR wird nach Maintainer-Triage durch die
  offizielle Automation erzeugt; kein manueller Parallel-PR wurde erstellt.

- SDA-FT-003: v0.1.1 ist seit dem bestaetigten Folgefund `PatchRequired`.
  Die Korrektur v0.1.2 ist als unveraenderlicher Prerelease veroeffentlicht;
  kein alter Tag wurde umgeschrieben. Die zentrale Matrix, die installierte
  Quellkopie und TinyCalc verwenden das echte Archiv. Quell-PR #270 und
  TinyCalc-PR #67 sind gemergt. Beide seriellen Feldtestlaeufe und ihre
  Closeouts sind abgeschlossen.

*The final package passed all three native platforms, was reviewed and merged,
and is published as an immutable field-test prerelease. The source repository
and TinyCalc install that archive. Both serial field-test runs and their
closeouts are complete. No Home sync or fleet rollout took place.*

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

### Aktueller macOS-Nachweis / Current macOS evidence

Paketlauf
[33969865821](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/33969865821)
am Head `3af44960f75babfd0b706c8bfb871c20ef59b419` besteht unter Linux und
Windows einschliesslich aller acht generierten Oberflaechen. macOS meldet bei
der neuen `legacy-lf`-Fixture Exit 2 ohne den erwarteten Diagnosegrund.
Lokal ist das mit Bash 3.2 sowie Apple-jq 1.7.1 und offiziellem jq 1.8.2 nicht
reproduzierbar. Die Capability-Proben werden nun in Subshells isoliert; eine
unerwartete Fixture-Antwort zeigt Exitcode, beide Ausgabekanaele und einmalig
einen auf 8 KiB begrenzten Trace der rein synthetischen Fehlfixture. Das ist
keine bestaetigte Ursachenbehebung und kein Gate-Ersatz. Der neue native
macOS-Nachweis bleibt vor Merge und Release zwingend.

*Linux and Windows pass the current package, including generated commands.
The new legacy-LF fixture still fails on native macOS and cannot be reproduced
locally with either tested jq version. Isolate capability probes and retain
bounded synthetic-fixture diagnostics. This does not claim a proven root-cause
fix or replace the required native macOS pass.*

### Patch-Veroeffentlichung / Patch publication

- Finaler nativer Paketlauf
  [33971814720](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/33971814720):
  Linux, macOS und Windows bestanden, einschliesslich beider Tests und aller
  acht Oberflaechen. Der macOS-Folgenachweis besteht nach Probe-Isolation;
  eine weitergehende, lokal reproduzierte Ursachenbehauptung wird nicht erhoben.
- Provider-Merge-Commit: `00e72dc1c0eedec3ea420072e79f3709573c6cf7`;
  Eltern sind v0.1.0 und der exakt gepruefte PR-Head. Provider-Nachweis und
  lokales `main == origin/main` wurden unmittelbar read-only kontrolliert.
- [v0.1.1 Release](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.1),
  [Tag-ZIP](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.1.zip).
- ZIP-SHA-256: `516eaba9b6ce258c27777e88decb7e45a1e1810cab5d3cb866738bc2326453a4`.
- Installationstest mit `-ArchiveUrl` gegen dieses Tag-ZIP: acht Oberflaechen
  bestanden, Exit 0. v0.1.0 zeigt weiterhin auf `e51e40e8ff46d8b4c00aa99b654b0d82264885ab`.
- Unabhaengige Reviews ohne materielle Findings. Der Copilot-Hinweis zur
  angeblichen Kulturabhaengigkeit von `String.Contains(String)` wurde anhand
  der [Microsoft-Dokumentation](https://learn.microsoft.com/en-us/dotnet/api/system.string.contains?view=net-10.0#system-string-contains(system-string))
  als False Positive begruendet beantwortet und aufgeloest.
- Admin-Bypass nur fuer die formale Approval-Regel; alle technischen und
  fachlichen Gates bestanden vor Merge. Der gemergte Arbeitsbranch wurde
  lokal und remote bereinigt; seine Historie bleibt ueber PR und Merge erhalten.
- Die lokale CLI erzeugt OpenCode-Dateien im vorhandenen ignorierten
  `.opencode/commands/`. Die beiden betroffenen erzeugten Dateien wurden
  unveraendert in den versionierten Repo-Pfad `.opencode/command/` uebernommen;
  andere lokale Agenten-/Cache-Dateien bleiben unberuehrt.

*All native package gates pass at the final reviewed head. The actual provider
merge and fast-forward synchronization are verified. The immutable tag archive
has a recorded SHA-256 and passes all eight installation tests. v0.1.0 is
unchanged. The review false positive is dispositioned with primary-source
evidence; formal approval bypass does not replace substantive review or CI.
Only the two generated OpenCode files are mirrored into the tracked legacy
directory; unrelated local agent data is preserved.*

### SDA-FT-003: Risiko-ID-Paritaet / Accepted-risk ID parity

Ein gezielter Kontroll-/Negativnachweis bestaetigt den
[Review-Fund](https://github.com/hindermath/TinyCalc/pull/67#discussion_r3940986668):
Die gueltige Risiko-Fixture besteht Status und Delta-Review in beiden Shells
mit Exit 0. Wird ausschliesslich `acceptedRisks[0].id` entfernt, bestehen beide
Bash-Aufrufe weiterhin; PowerShell blockiert beide mit Exit 2 und
`Blocked: acceptedRisks.id fehlt.` Die Fixture bleibt bytegleich read-only,
menschliche Entscheidungen bleiben `Open`. Vorherige gruene Suites deckten
diesen Negativfall nicht ab; er ist nicht durch Admin-Bypass uebergehbar.

Die gemeinsame Pruefgrenze ist die Risiko-Prueffunktion, die Status und alle
vier Gate-Reviews verwenden. Die Korrektur muss eine echte, nicht leere
Text-ID verlangen und darf gueltige IDs, Exitcodes, Schemas, Gate-Ergebnisse
oder menschliche Freigabegrenzen nicht veraendern. NIST SSDF, CWE Top 25,
Release-Provenienz und textorientierte A11Y bleiben anwendbar; kein neuer
Dienst, keine neue Abhaengigkeit und keine Produkt-KI.

*The valid control passes both entry points in both shells. Removing only the
accepted-risk ID leaves Bash successful while PowerShell rejects it. Existing
green CI did not cover that negative case. Fix the shared risk-validation
boundary without changing legitimate IDs, schemas, output semantics or human
authority. Technical failure is never a formal-rule bypass condition.*

Lokaler v0.1.2-Nachweis: Der neue Test scheiterte vor der Korrektur mit
`Risk ID missing (baseline) was not rejected`, Bash Exit 0. Danach besteht
dieselbe Regression fuer Status und alle vier Reviews. Delta-Negativfaelle:
fehlend, null, leer, Unicode-Leerzeichen, Zahl, Boolean, Objekt, einteiliges
Array und falscher Feldname `ID`. Jeder Fall verlangt Exit 2, keine
Erfolgsausgabe, passende ID-Diagnose und unveraenderte rohe Snapshots.
Gueltige Unicode-IDs mit umgebenden Leerzeichen bleiben erhalten. Die
PowerShell-Korrektur prueft den Rohwert vor dem Pipeline-Entpacken; globale
Text-/Property-Helfer und der Datums-Kompatibilitaetspfad bleiben unveraendert.
Bestehende Vertrags-, jq-, Runbook- und Human-Decision-Tests bestehen.
Bash-Syntax und PSScriptAnalyzer 1.25.0 mit dem tatsaechlichen Repo-Profil
`scripts/config/PSScriptAnalyzerSettings.psd1` bestehen ebenfalls. Ein erster
Analyzer-Aufruf mit falschem Profilpfad wurde nicht als Nachweis gewertet.
Auch ein spaeterer Aufruf mit einer vom Cmdlet nicht unterstuetzten Pfadliste
wurde verworfen; die korrekte Einzeldatei-Schleife besteht ohne Findings.
Der unabhaengige Patch-Review fand zusaetzlich eine JSON-Stream-Umgehung:
Bash akzeptierte zwei verkettete JSON-Wurzeln, wenn das zweite Teildokument
das fehlende ID-Pruefergebnis ueberschrieb; PowerShell blockierte dieselbe
Datei bereits. Der neue Rot-Nachweis ergab Bash Exit 0 fuer Status und
Delta-Review. Die zentrale Bash-Gate-Grenze verlangt nun mit einer
Slurp-Laengenpruefung genau eine JSON-Wurzel. Danach bestehen beide Shells
Status und Review nur mit Exit 2, leerer Erfolgsausgabe und unveraenderten
Evidence-Bytes; alle gueltigen Einzeldokumente und die vollstaendige Suite
bleiben gruen. Der native Paketlauf `33976340466` besteht unter Linux, macOS
und Windows am exakten Head `cf7e18fe7dc45dca93801a8c58d19c7dfc2f4fc1`.

*The new regression failed before the fix and passes afterward. Both entry
points reject the missing and alternate invalid IDs without success output
or evidence writes, while valid Unicode text remains accepted. Shared helpers
and date compatibility are unchanged. Existing contracts and the correctly
configured syntax/analyzer checks pass. A mistyped analyzer-profile invocation
and a later unsupported path-array invocation were discarded, not counted as
evidence; the correct per-file loop passes. Independent review then found that
Bash accepted a two-root JSON stream whose trailing partial document masked
the first root's missing ID. A new red/green regression now enforces exactly
one JSON root for every Bash gate while preserving valid single documents,
read-only bytes and full cross-shell parity. Native package run `33976340466`
passes on Linux, macOS and Windows at the exact reviewed head; the release
evidence is complete.*

### v0.1.2-Veroeffentlichung / v0.1.2 publication

- [Paket-PR #3](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/3)
  wurde nach den materiellen Gates mit dem nur formal verwendeten Admin-Bypass
  gemergt. Provider-Merge-Commit: `02423602592ad0183454e259df628ab940436ba6`;
  Eltern: vorheriges `main` und exakt gepruefter PR-Head.
- [v0.1.2 Prerelease](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.2)
  und [Tag-ZIP](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.2.zip).
- ZIP-SHA-256: `4eb30804bb3c329681e0b7d44187c8daeb3e9e4f250bb6003d5b746c0ad0b656`.
- Der Archiv-Installationstest besteht fuer alle acht Agentenoberflaechen.
  Die zentrale optionale Matrix und installierte Quellkopie melden exakt 13
  aktive Presets mit Assurance v0.1.2; die fuenf veraenderten Paketdateien sind
  in kanonischer Quelle, Publikationsspiegel, Installation und Paket bytegleich.
- v0.1.0 und v0.1.1 bleiben unveraendert. TinyCalc-Installation, RL-SE, GSDB
  und ihre kausalen Closeouts sind abgeschlossen.

*Package PR #3 was merged only after all material gates passed. The actual
provider merge has the expected previous-main and reviewed-head parents. The
immutable v0.1.2 tag archive has the recorded SHA-256 and passes all eight
installed-surface checks. Canonical, publication, installed, and standalone
package copies match. Earlier releases remain unchanged; TinyCalc installation
and both field-test features are complete.*

## Feldtestabschluss / Field-test closeout

**Empfehlung / Recommendation: `ReleaseAccepted` fuer / for v0.1.2.**

Der Feldtest bewertet das Preset und seinen Evidence-Vertrag, nicht die
allgemeine Sicherheit oder Freigabe von TinyCalc. Die drei waehrend der
Erprobung reproduzierten Preset-Fehler SDA-FT-001 bis SDA-FT-003 wurden in den
unveraenderten Patch-Releases v0.1.1 und v0.1.2 korrigiert. Die abschliessenden
Paket-, Installations- und Realprojekt-Nachweise zeigen keinen offenen
materiellen Preset-Defekt.

*The field test evaluates the preset and its evidence contract, not the
general security or release status of TinyCalc. All three reproduced preset
defects were fixed through immutable patch releases. Final package,
installation, and real-project evidence contains no open material preset
defect.*

### Release- und Testbindung / Release and test binding

- Preset: `secure-development-assurance-governance` v0.1.2, Prioritaet 15.
- Release: https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.2
- Tag-ZIP: https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.2.zip
- ZIP-SHA-256: `4eb30804bb3c329681e0b7d44187c8daeb3e9e4f250bb6003d5b746c0ad0b656`.
- Testprojekt: `hindermath/TinyCalc`, lokales C#/.NET-TUI-Projekt ohne
  produktionsnahe Daten oder Dienste.
- Tooling: Spec Kit 0.12.11, `security-governance` v0.6.2, Bash und
  PowerShell 7; native CI unter Linux, macOS und Windows.

### Ergebnisse / Results

| Pruefung / Test | Ergebnis / Result | Exitcode beziehungsweise Evidence |
|---|---|---|
| Unveraendertes Tag-ZIP und acht erzeugte Agentenoberflaechen | Pass | Exit 0; Paketlauf `33976340466` |
| Positiver Statuskontext und vier Gate-Reviews | Pass | Bash/PowerShell Exit 0, gleiche Statusklassen |
| Bewusst blockierte Kontexte einschliesslich Risiko-ID und mehrfacher JSON-Wurzel | Pass | erwarteter Exit 2, keine Erfolgsausgabe, Evidence bytegleich |
| LF-, CRLF-, BOM- und rohe Read-only-Hashparitaet | Pass | Bash/PowerShell und drei native Plattformen |
| Vollstaendige Komposition | Pass | exakt 13 aktive Presets; Acht-Preset-Standardprofil unveraendert |
| TinyCalc RL-SE-Lauf | Pass | PR #68/#69 gemergt; finale materielle Checks erfolgreich |
| TinyCalc GSDB-Lauf | Pass | PR #70/#71 gemergt; finale materielle Checks erfolgreich |
| Aktuelle Review-Threads PR #67 bis #71 | Pass | null ungeloeste, nicht veraltete Threads |

### Offene Punkte und Grenzen / Open items and boundaries

- Die bekannte Spec-Kit-0.12.11-Remove-Grenze kann bei aktiver
  Multi-Agent-Integration zwei nicht ausfuehrbare Claude-Skills hinterlassen.
  Sie bleibt dokumentiert und wird nicht als vollstaendiger Uninstall-Erfolg
  umgedeutet.
- Der GSDB-Lauf weist 13 TinyCalc-Folgefindings und 42 Human-only-Zeilen aus.
  Sie sind als `DoesNotBlockCompletedAssessment` klassifiziert, bleiben offen
  und sind keine verdeckten Preset-Passes.
- Technische Validierung erteilt weder Pilot-, Projekt-, Sandbox-, Produkt-
  noch Flottenfreigabe und begruendet keine C5-, ISO-, Konformitaets-,
  Testat- oder Zertifizierungsbehauptung.
- Die Empfehlung autorisiert nur die getrennt beauftragte serielle
  Community-Einreichung von v0.1.2. Diese ist als
  [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
  erfolgt und wartet auf die Upstream-Maintainer-Triage. Sie waehlt keine
  Level-2-Repositories aus und startet keinen Rollout.

*The known Spec Kit removal limitation and all TinyCalc follow-up and
human-only findings remain visible. The separately requested serial v0.1.2
Community submission is filed as `github/spec-kit#4455` and awaits upstream
maintainer triage and its automated draft PR. It grants no project, sandbox,
product, fleet, compliance, attestation, certification, or Level-2 rollout
decision.*
