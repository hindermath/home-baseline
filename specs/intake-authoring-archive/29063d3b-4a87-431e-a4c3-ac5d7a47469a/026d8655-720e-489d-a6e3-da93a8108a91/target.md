<!-- intake-authoring:begin -->
# Lastenheft: Windows-Haertung der Ein-Kommando-Wartung

**Status:** ReadyForReview
**Zielgruppe / Audience:** Maintainer der `home-baseline`-Wartung und spaetere Spec-Kit-Ausfuehrende / maintainers of the `home-baseline` maintenance flow and later Spec Kit operators
**Profil / Profile:** `home-baseline-lastenheft`
**Repository:** `home-baseline`
**Dokumenttyp / Document type:** Windows-spezifischer Spec-Kit-Intake / Windows-specific Spec Kit intake
**Version:** 1.0
**Stand / Date:** 2026-07-22
**Delivery Authority:** `LocalImplementation`

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine eigene Windows-Haertungsrunde fuer das
Ein-Kommando-Wartungsskript. Grundlage sind neun Befunde aus einem realen
Windows-Lauf. Der lokal festgestellte Drift ist bereits bereinigt; offen ist
die belastbare Korrektur der Orchestrierung, damit Pruefung, Reparatur und
Fortsetzung reproduzierbar funktionieren.

*This intake defines a dedicated Windows hardening round for the one-command
maintenance script. It is based on nine findings from a real Windows run. The
observed local drift has already been repaired; the remaining work is to make
inspection, repair, and resume behavior reliable and reproducible.*

Dieses Dokument startet weder eine Implementierung noch einen Wartungslauf.
Es authorisiert keine Commits, Pushes, Pull Requests oder Merges.

*This document starts neither implementation nor maintenance. It grants no
authority to commit, push, open pull requests, or merge.*

## 2. Bindende Vorgaenger und Reihenfolge / Binding Predecessors and Order

Bindender fachlicher Vorgaenger ist
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md` einschliesslich
der daraus bereits entstandenen Wartungsimplementierung. Dieses Lastenheft
ersetzt den Vorgaenger nicht. Es praezisiert Windows-Defekte, die erst im
realen Betrieb sichtbar wurden.

*The binding functional predecessor is
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`, including its
existing maintenance implementation. This intake does not supersede that
predecessor. It specifies Windows defects that became visible only during a
real maintenance run.*

Die Abarbeitung erfolgt auf Position 2 unmittelbar nach dem
plattformuebergreifenden Wartungs-Intake. Danach folgen die getrennte
Linux-/Ubuntu-Haertung und die Preset-/Profil-/Default-Branch-/Worktree-
Haertung. Die Wartungs-TUI bleibt auf Position 5 gesperrt, bis alle Eintraege
1 bis 4 vollstaendig implementiert, validiert und gemaess ihrer jeweiligen
Delivery Authority abgeschlossen sind.

*Processing takes place at position 2 directly after the cross-platform
maintenance intake. The separate Linux/Ubuntu and preset/profile/default-
branch/worktree hardening rounds follow. The maintenance TUI remains blocked
at position 5 until all items 1 through 4 are fully implemented, validated,
and closed under their respective delivery authority.*

## 3. Ausgangslage / Current State

Der Windows-Lauf zeigte folgende geordnete Befunde:

1. `scripts/sync-home.ps1:69` verlangt an der betroffenen Stelle `python3`.
   Unter Windows war nur ein defekter Microsoft-Store-Alias sichtbar, obwohl
   eine nutzbare Python-Installation ueber `python.exe` oder `py -3` erreichbar
   sein kann.
2. Der Home-Sync benoetigt Python, bevor die spaetere Toolchain-Stufe Python
   installieren oder reparieren kann. Damit besteht ein Bootstrap-Zirkel.
3. `-WhatIf` meldete faelschlich, es gebe keine Level-1-Wurzeln. Die
   Repository-Ermittlung liefert unter PowerShell-WhatIf nicht stabil dieselbe
   Zielmenge wie der echte Lauf.
4. Nach `-RepairDrift` konnte der Lauf nicht neu gestartet werden. Die vom Lauf
   selbst erzeugten Aenderungen wurden als fremder Dirty-Worktree abgelehnt.
5. Die Registry wurde mit dem Acht-Preset-Profil erzeugt, obwohl die vollstaendige
   lokale Flotte nachweislich das Zehn-Preset-Profil verwendet.
6. 90 von 93 Drift-Meldungen waren nur Zeilenendennormalisierungen und erzeugten
   keinen Git-Diff.
7. GitHub-Timeouts beendeten den gesamten Lauf ohne begrenzten Retry.
8. `scripts/maintain-agentic-winget-apps.ps1:541` kann bei
   `winget upgrade --all` oder UAC-Installern unbegrenzt warten. Timeout,
   Deferred-Status und zuverlaessige Prozessbereinigung fehlen.
9. Die WinGet-Zusammenfassung meldete teilweise Pakete als fehlend, die zuvor
   als vorhandenes `OK package` erkannt worden waren.

*The Windows run exposed nine ordered findings: unreliable Python command
resolution, a Python bootstrap cycle, unstable WhatIf repository discovery,
non-resumable self-created drift repair, an incorrect eight-preset registry
profile, line-ending-only false drift, missing bounded GitHub retries,
unbounded WinGet or UAC waits, and contradictory package status summaries.*

Der Drift ist lokal bereinigt. Diese Bereinigung ist kein Nachweis, dass der
Orchestrator die gleichen Bedingungen bei einem neuen Lauf sicher behandelt.

*The local drift has been repaired. That repair is not evidence that the
orchestrator can safely handle the same conditions in a new run.*

## 4. Zielzustand / Target State

Ein Windows-Wartungslauf soll aus einer frischen, teilweise eingerichteten
oder nach einer eigenen Reparatur unterbrochenen Umgebung deterministisch
starten beziehungsweise fortsetzen. Read-only-Ermittlung, `-WhatIf`, echter
Lauf und Resume verwenden dieselbe Zielauflosung. Externe Wartezustaende sind
begrenzt, eigene Zwischenstaende sind nachweisbar, und der Abschlussbericht
enthaelt keine widerspruechlichen Paket- oder Driftbefunde.

*A Windows maintenance run must start or resume deterministically from a fresh,
partially provisioned, or self-repaired interrupted environment. Read-only
discovery, WhatIf, real execution, and resume use the same target resolution.
External waits are bounded, self-created intermediate state is traceable, and
the final report contains no contradictory package or drift findings.*

## 5. Betroffene Flaechen / Affected Surfaces

Primaer betroffen sind:

- `scripts/maintain-agentic-workspace.ps1`
- `scripts/sync-home.ps1`
- `scripts/maintain-agentic-winget-apps.ps1`
- die von diesen Skripten gelesenen Flotten-, Registry-, Preset- und
  Maschinenkonfigurationen
- zugehoerige PowerShell-Tests, Hilfsskripte, README-Abschnitte und
  comment-based help
- der strukturierte Wartungsbericht und lokal gespeicherte Resume-Evidence

*Primary surfaces are the Windows maintenance orchestrator, home sync, WinGet
maintenance, their fleet and registry inputs, matching PowerShell tests and
documentation, the structured report, and local resume evidence.*

Gemeinsam genutzte Schemas oder Statusvertraege sind auch in der Bash-Variante
auf Paritaet zu pruefen. Windows-spezifische Prozess- und UAC-Logik bleibt in
PowerShell.

*Shared schemas or status contracts must also be checked for Bash parity.
Windows-specific process and UAC behavior remains in PowerShell.*

## 6. Scope und Nicht-Ziele / Scope and Non-Goals

### In Scope

- validierte Python-Aufloesung und Aufbrechen des Bootstrap-Zirkels
- identische, read-only Repository-Ermittlung in `-WhatIf` und echtem Lauf
- sichere, phasenbasierte Wiederaufnahme nach selbst erzeugten Aenderungen
- korrekte Auswahl des dokumentierten Zehn-Preset-Flottenprofils
- Git-normalisierte Driftpruefung
- begrenzte Retries fuer transiente GitHub-Netzwerkfehler
- Timeout, Deferred-Status und Prozessbereinigung fuer WinGet und UAC
- widerspruchsfreie Paketklassifikation und Zusammenfassung
- deterministische Logs, strukturierter Bericht und Regressionstests

*In scope are validated Python resolution, bootstrap ordering, stable WhatIf
discovery, safe phase resume, the ten-preset fleet profile, Git-normalized
drift checks, bounded GitHub retries, bounded WinGet execution, process
cleanup, consistent package status, and deterministic evidence.*

### Non-Goals

- keine Implementierung der Wartungs-TUI
- kein automatisches Committen oder Pushen in gewarteten Repositories
- kein Force-Push, Hard Reset oder automatisches Verwerfen fremder Aenderungen
- kein Umgehen von UAC oder anderen Administratorgrenzen
- keine pauschale Installation optionaler Pakete
- keine Erweiterung der Flotte oder Aenderung ihrer fachlichen
  Repository-Zusammensetzung
- keine allgemeine Neuentwicklung der macOS-/Linux-Wartung ausserhalb
  gemeinsam betroffener Schnittstellen und Paritaetstests

*The work excludes the maintenance TUI, automatic commits or pushes, destructive
Git recovery, UAC bypass, blanket installation of optional packages, fleet
membership changes, and unrelated redesign of macOS or Linux maintenance.*

## 7. Atomare Anforderungen / Atomic Requirements

### WEM-001 - Validierte Python-Aufloesung

`sync-home.ps1` MUSS einen tatsaechlich ausfuehrbaren Python-3-Interpreter
ermitteln. Die Kandidaten `python3`, `python` und `py -3` sind in einer
dokumentierten Reihenfolge zu pruefen. Eine blosse Command-Aufloesung reicht
nicht: Jeder Kandidat MUSS mit einem begrenzten Versionsaufruf validiert
werden. Defekte Microsoft-Store-Aliase sind als nicht nutzbar zu behandeln.
Log und Bericht nennen den gewaehlten Launcher und die erkannte Hauptversion,
aber keinen privaten absoluten Installationspfad.

*The home sync must resolve a working Python 3 interpreter. It validates
`python3`, `python`, and `py -3` in a documented order with a bounded version
probe. A broken Microsoft Store alias is unavailable. Logs and reports identify
the selected launcher and major version without exposing a private absolute
installation path.*

### WEM-002 - Bootstrap-Zirkel aufloesen

Die fuer Home-Sync zwingend benoetigte Python-Verfuegbarkeit MUSS vor dem
Python-abhaengigen Sync hergestellt oder durch einen PowerShell-nativen
Bootstrap-Pfad ersetzt werden. Fehlt jeder valide Interpreter, darf der Lauf
nicht erst in einer spaeten Toolchain-Stufe ueberraschend scheitern. Er MUSS
frueh einen eindeutigen, fortsetzbaren Status mit naechster Aktion und
vollstaendigem Abschlussbericht liefern. `-WhatIf` darf dabei keine
Installation ausloesen.

*Python required by home sync must be made available before the Python-based
sync or replaced by a PowerShell-native bootstrap path. If no interpreter is
usable, the run fails or defers early with a clear resumable status, next
action, and complete report. WhatIf performs no installation.*

### WEM-003 - Stabile Repository-Ermittlung unter WhatIf

Repository- und Level-1-Wurzel-Ermittlung MUSS read-only und unabhaengig von
`ShouldProcess` erfolgen. Bei identischen Eingaben muessen Check-only,
`-WhatIf` und echter Lauf dieselbe geordnete Zielmenge sowie dieselben
Ausschlussgruende melden. Nur mutierende Aktionen duerfen durch WhatIf
unterdrueckt werden.

*Repository and Level 1 root discovery must be read-only and independent of
`ShouldProcess`. Check-only, WhatIf, and real execution return the same ordered
target set and exclusion reasons for the same inputs. WhatIf suppresses only
mutations.*

### WEM-004 - Wiederaufnehmbare Phasensteuerung

Der Orchestrator MUSS fuer jede mutierende Phase atomare lokale
Resume-Evidence mit Lauf-ID, Phase, betroffenen relativen Pfaden,
Vorher-/Nachher-Hashes und Ergebnisstatus schreiben. Ein Neustart darf nur
Aenderungen als eigene Zwischenstaende akzeptieren, die vollstaendig zu dieser
Evidence passen. Unbekannte, nachtraeglich veraenderte oder nur teilweise
passende Dirty-Dateien bleiben ein harter Stopp. Nach erfolgreicher Fortsetzung
wird der Zwischenstand abgeschlossen oder eindeutig als historisch markiert.

*Each mutating phase writes atomic local resume evidence containing run ID,
phase, affected relative paths, before and after hashes, and result. A restart
accepts a dirty intermediate state only when it fully matches that evidence.
Unknown, later modified, or partially matching dirty files remain a hard stop.
Successful resume closes or clearly archives the intermediate state.*

### WEM-005 - Zehn-Preset-Flottenprofil bewahren

Registry-Erzeugung und -Reparatur MUESSEN das explizit konfigurierte und lokal
nachgewiesene Flottenprofil verwenden. Fuer die aktuelle vollstaendige Flotte
ist dies das Zehn-Preset-Profil. Die portable Acht-Preset-Standardmatrix darf
nicht stillschweigend als lokaler Istzustand eingesetzt werden. Profilquelle,
Profil-ID und erwartete Preset-Anzahl muessen im Bericht nachvollziehbar sein;
unbekannte oder widerspruechliche Profile scheitern fail-closed.

*Registry creation and repair preserve the explicitly configured and locally
verified fleet profile. The current complete fleet uses ten presets. The
portable eight-preset default must not silently replace local state. Reports
show profile source, profile ID, and expected count; unknown or conflicting
profiles fail closed.*

### WEM-006 - Git-normalisierte Driftpruefung

Driftvergleiche fuer Git-getrackte Textdateien MUESSEN den Inhalt nach dem fuer
das Ziel-Repository wirksamen Git-Normalisierungsvertrag vergleichen. Reine
CRLF-/LF-Unterschiede, die keinen Git-Diff erzeugen, duerfen weder als
aktionsfaehiger Drift gezaehlt noch repariert werden. Echter Inhaltsdrift,
Attributfehler und binaere Dateien bleiben unterscheidbar. Der Bericht MUSS
Rohdatei-Abweichungen und aktionsfaehigen Git-Drift getrennt zaehlen.

*Drift checks for Git-tracked text compare content under the target
repository's effective Git normalization contract. CRLF or LF-only differences
that produce no Git diff are not actionable drift and are not repaired. Real
content drift, attribute errors, and binary files remain distinguishable. The
report separates raw file differences from actionable Git drift.*

### WEM-007 - Begrenzte GitHub-Retries

Transiente GitHub-, `git fetch`- und `git pull --ff-only`-Timeouts MUESSEN mit
einer kleinen konfigurierbaren Obergrenze, begrenztem Backoff und Jitter erneut
versucht werden. Authentifizierungs-, Berechtigungs-, Not-found-, Dirty-,
Ahead- und Diverged-Fehler sind nicht als transiente Retries zu behandeln. Nach
Erschoepfung der Versuche wird das Ziel als Netzwerkfehler berichtet;
unabhaengige Ziele und der Abschlussbericht laufen weiter.

*Transient GitHub, fetch, and fast-forward pull timeouts use a small configurable
retry limit with bounded backoff and jitter. Authentication, authorization,
not-found, dirty, ahead, and diverged errors are not transient retries. After
retry exhaustion, the target is reported as a network failure while independent
targets and final reporting continue.*

### WEM-008 - Begrenzte WinGet- und UAC-Prozesse

Jeder WinGet-Unterprozess, insbesondere `winget upgrade --all`, MUSS eine
konfigurierbare harte Laufzeitgrenze besitzen. Ein UAC- oder interaktiver
Installer, der nicht unbeaufsichtigt abgeschlossen werden kann, erhaelt den
Status `DEFERRED_ADMIN_REQUIRED` statt unbegrenzt zu warten. Bei Timeout,
Abbruch oder Fehler ist der vollstaendige gestartete Prozessbaum kontrolliert
zu beenden und abzuwarten. Der Resume-Lauf darf keine verwaisten oder parallel
duplizierten WinGet-Worker uebernehmen.

*Every WinGet subprocess, especially `winget upgrade --all`, has a configurable
hard timeout. A UAC or interactive installer that cannot complete unattended is
reported as `DEFERRED_ADMIN_REQUIRED`. Timeout, cancellation, or failure
terminates and waits for the complete spawned process tree. Resume never adopts
or duplicates orphaned WinGet workers.*

### WEM-009 - Widerspruchsfreie Paketstatus

Erkennung, Upgrade-Entscheidung und Zusammenfassung MUESSEN dieselbe
kanonische Paket-ID, Aliasauflosung und Statusprioritaet verwenden. Ein Paket,
das im selben Lauf als `OK package` erkannt wurde, darf nicht zugleich als
fehlend erscheinen. Abweichende Quellen oder unklare Aliaszuordnungen werden
als eigener Konfliktstatus mit Evidence gemeldet.

*Detection, upgrade decisions, and summary use the same canonical package ID,
alias resolution, and status precedence. A package recognized as `OK package`
cannot also be missing in the same run. Conflicting sources or unresolved
aliases receive a distinct conflict status with evidence.*

## 8. Qualitaet und Governance / Quality and Governance

### Sicherheit und Datenschutz / Security and Privacy

- Resume-Evidence enthaelt keine Tokens, Zugangsdaten oder privaten absoluten
  Pfade.
- Fremde Dirty-Aenderungen bleiben unangetastet; ein eigener Resume-Nachweis
  erweitert keine Git-Berechtigung.
- UAC wird nicht automatisiert bestaetigt oder umgangen.
- Git-Aktualisierungen bleiben auf `fetch` und `pull --ff-only` begrenzt.
- Prozessargumente und Logs duerfen keine Secrets offenlegen.

*Resume evidence contains no credentials or private absolute paths. Foreign
dirty changes remain untouched, UAC is not bypassed, Git updates remain limited
to fetch and fast-forward pull, and process arguments or logs expose no secrets.*

### Barrierefreiheit und Sprache / Accessibility and Language

Nutzerseitige Ausgabe folgt WCAG 2.2 AA, soweit fuer eine CLI anwendbar. Status
und Fehler sind in Text sichtbar, nicht nur durch Farbe. Tabellen besitzen
stabile ASCII-Spalten oder eine lineare Textalternative. Deutsche Meldungen
stehen zuerst; englische Entsprechungen folgen. Fortschritt darf eine
Screenreader-Ausgabe nicht laufend ueberschreiben.

*User-facing output follows WCAG 2.2 AA where applicable to a CLI. Status and
errors are conveyed in text rather than color alone. Tables provide stable
ASCII columns or linear text alternatives. German comes first, followed by
English. Progress output must not continuously overwrite screen-reader text.*

### Kompatibilitaet und Beobachtbarkeit / Compatibility and Observability

- Primaerplattform ist Windows 10/11 mit PowerShell 7.
- Bestehende oeffentliche Parameter und Exitcodes bleiben kompatibel, sofern
  eine begruendete Vertragsaenderung nicht in Spezifikation und Migration
  dokumentiert wird.
- Der Terminalabschluss bleibt kompakt; Detail-Evidence liegt in Log und JSON.
- Jeder Befund nennt Phase, Ziel, kanonischen Status, Versuchszahl oder Timeout
  soweit anwendbar sowie eine konkrete naechste Aktion.
- Gemeinsame Status- oder Berichtsschemas bleiben zwischen PowerShell und Bash
  kompatibel.

*The primary platform is Windows 10 or 11 with PowerShell 7. Existing public
parameters and exit codes remain compatible unless a justified migration is
specified. Terminal output stays concise while logs and JSON retain detail.
Shared status and report schemas remain compatible between PowerShell and Bash.*

## 9. Abhaengigkeiten, Risiken und harte Stopps / Dependencies, Risks, and Hard Stops

Abhaengigkeiten sind Git, PowerShell 7, die vorhandenen Wartungsskripte, die
versionierten Flotten- und Preset-Registries sowie fuer echte Paketlaeufe eine
verfuegbare WinGet-Installation. Tests muessen externe Prozesse und
Netzwerkantworten kontrolliert simulieren koennen.

*Dependencies are Git, PowerShell 7, the existing maintenance scripts,
versioned fleet and preset registries, and WinGet for real package runs. Tests
must be able to control external processes and network responses.*

Harte Stopps gelten bei unbekanntem Dirty-Worktree, nicht passender oder
manipulierter Resume-Evidence, unbekanntem Preset-Profil, ungueltiger Registry,
nicht sicher klassifizierbaren Git-Zustaenden und fehlender
Prozessbereinigungs-Evidence nach einem Timeout. Ein harter Stopp verhindert
abhaengige Mutation, aber nicht den Abschlussbericht oder unabhaengige
read-only Pruefungen.

*Hard stops apply to unknown dirty worktrees, mismatched or modified resume
evidence, unknown preset profiles, invalid registries, unsafe Git state, and
missing process-cleanup evidence after a timeout. A hard stop blocks dependent
mutation, while final reporting and independent read-only checks continue.*

Wesentliche Risiken sind Store-Alias-Falschpositive, falsche Uebernahme
fremder Aenderungen, Plattformabweichungen der Git-Zeilenendennormalisierung,
prozesslokale WinGet-Kindprozesse und eine zu breite Retry-Klassifikation.
Diese Risiken sind durch isolierte Fixtures und Negativtests abzudecken.

*Main risks are Store alias false positives, accidental adoption of foreign
changes, platform-specific Git line-ending behavior, WinGet child processes,
and over-broad retry classification. Isolated fixtures and negative tests must
cover them.*

## 10. Erwartete Artefakte und Evidence / Expected Artifacts and Evidence

Die spaetere Implementierung liefert mindestens:

- gezielte Aenderungen an den betroffenen PowerShell-Skripten
- ein dokumentiertes, atomar geschriebenes Resume-State-Format mit
  Versionskennung und Validierung
- Regressionstests fuer alle neun Anforderungen einschliesslich Fehler- und
  Resume-Pfade
- bei gemeinsam geaenderten Vertraegen passende Bash-Paritaetstests
- aktualisierte bilinguale comment-based help, README-Abschnitte und
  gegebenenfalls Schema-/Registry-Dokumentation
- einen sanitisierten Beispielbericht fuer erfolgreichen Lauf, Deferred-Fall,
  Retry-Erschoepfung und harten Resume-Stopp
- die gemaess Repository-Guidance aktualisierte Projektstatistik

*Later implementation provides focused PowerShell changes, a versioned and
validated atomic resume-state format, regression tests for all nine findings,
Bash parity where shared contracts change, bilingual help and documentation,
sanitized sample reports for important outcomes, and updated project
statistics.*

## 11. Abnahmekriterien / Acceptance Criteria

- **AC-001:** Ein Fixture mit defektem `python3`-Store-Alias und gueltigem
  `python.exe` waehlt `python`; ein zweites Fixture faellt erfolgreich auf
  `py -3` zurueck. Python 2 und nicht startbare Aliase werden abgelehnt.
- **AC-002:** Ein System ohne validen Python-3-Interpreter erreicht vor dem
  Home-Sync einen eindeutigen Bootstrap- oder Deferred-Status. `-WhatIf`
  veraendert dabei keine Maschine, und jeder Pfad erzeugt einen Abschlussbericht.
- **AC-003:** Check-only, `-WhatIf` und echter Lauf liefern aus derselben
  Registry bytegleich geordnete Repository-IDs und dieselben
  Ausschlussgruende; vorhandene Level-1-Wurzeln werden nicht als leer gemeldet.
- **AC-004:** Ein absichtlich nach einer Drift-Reparatur abgebrochener Lauf
  setzt mit passender Evidence an der naechsten sicheren Phase fort. Eine
  nachtraeglich veraenderte Datei und eine fremde Dirty-Datei fuehren jeweils
  vor Mutation zu einem harten Stopp.
- **AC-005:** Registry-Neuanlage und -Reparatur bewahren fuer die vollstaendige
  lokale Flotte das Zehn-Preset-Profil. Ein Acht-Preset-Default wird nur bei
  explizit passender Konfiguration verwendet; unbekannte Profile scheitern.
- **AC-006:** Ein Fixture mit 90 CRLF-/LF-only-Abweichungen und drei echten
  Inhaltsabweichungen meldet `rawDifferences=93` und `actionableDrift=3`.
  Nach Reparatur der drei Dateien ist `git diff --exit-code` erfolgreich.
- **AC-007:** Zwei simulierte GitHub-Timeouts mit anschliessendem Erfolg werden
  innerhalb der Obergrenze wiederholt. Dauerhafter Timeout endet nach exakt
  der konfigurierten Versuchszahl; Authentifizierungsfehler werden nicht
  wiederholt und unabhaengige Ziele laufen weiter.
- **AC-008:** Ein haengender WinGet-Mock endet innerhalb der konfigurierten
  Laufzeitgrenze, hinterlaesst keinen Kindprozess und erzeugt einen
  Timeout-Status. Ein UAC-pflichtiger Mock erzeugt
  `DEFERRED_ADMIN_REQUIRED`; Resume startet genau einen neuen Worker.
- **AC-009:** Fuer jede kanonische Paket-ID entsteht genau ein finaler Status.
  Ein zuvor als `OK package` erkanntes Paket erscheint nicht als fehlend;
  Alias-Konflikte werden separat und reproduzierbar berichtet.
- **AC-010:** Der PowerShell-Testlauf, PSScriptAnalyzer fuer geaenderte
  PowerShell-Dateien, der Receipt-Validator und alle betroffenen
  Repository-Homogeneity-Pruefungen sind erfolgreich.
- **AC-011:** Ein zweiter erfolgreicher Lauf ist idempotent und meldet weder
  aktionsfaehigen Drift noch ausstehende eigene Resume-Phasen.
- **AC-012:** Vollstaendiger Log- und JSON-Bericht entstehen bei Erfolg,
  partiellem Fehler, Deferred-Status und hartem Stopp; die sichtbare Ausgabe
  bleibt textorientiert und enthaelt keine Secrets oder privaten absoluten
  Pfade.

*Acceptance covers working Python fallbacks, early bootstrap behavior, stable
WhatIf discovery, safe resume and rejection of foreign changes, exact
ten-preset preservation, Git-normalized drift counts, bounded network retries,
bounded WinGet and UAC handling, unique package status, static and regression
checks, idempotence, and complete accessible reports for every outcome.*

## 12. Annahmen und offene Fragen / Assumptions and Open Questions

Annahmen:

- Die Zielumgebung verwendet Windows 10 oder 11 und PowerShell 7.
- Die vollstaendige verwaltete lokale Flotte verwendet zum Stand dieses
  Intakes das dokumentierte Zehn-Preset-Profil.
- Der bereits lokal bereinigte Drift muss nicht rekonstruiert werden; die
  Zahlen 90 Zeilenenden-Abweichungen und drei echte Abweichungen dienen als
  verbindliches Regressionstest-Szenario.
- `LocalImplementation` erlaubt nur lokale Implementierung und Validierung im
  aktuellen Repository.

*Assumptions are Windows 10 or 11 with PowerShell 7, the documented ten-preset
profile for the complete managed local fleet, use of the observed 90 plus 3
drift split as a regression scenario, and local-only implementation authority.*

Offene materielle Fragen: keine.

*Open material questions: none.*

## 13. Abschlussgrenze / Completion Boundary

Die Windows-Haertungsrunde ist erst abgeschlossen, wenn alle Abnahmekriterien
mit lokaler, reproduzierbarer Evidence bestanden sind und kein offener
High-Severity-Befund fuer Python-Bootstrap, WhatIf-Ermittlung, Resume-Sicherheit,
Git-Drift, GitHub-Retry oder WinGet-Prozesskontrolle verbleibt. Mit der
aktuellen `LocalImplementation`-Authority endet ein spaeterer Autonomous-Lauf
vor Commit, Push, Pull Request oder Merge.

*The hardening round is complete only when all acceptance criteria pass with
local reproducible evidence and no high-severity finding remains for Python
bootstrap, WhatIf discovery, resume safety, Git drift, GitHub retry, or WinGet
process control. Under the current LocalImplementation authority, a later
Autonomous run stops before commit, push, pull request, or merge.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md Erstelle die Spezifikation ausschliesslich aus diesem Intake und seinen bindenden Vorgaengern. Bewahre WEM-001 bis WEM-009, AC-001 bis AC-012, die Position-2-Reihenfolge, die TUI-Sperre bis zum Abschluss aller Eintraege 1 bis 4 und alle Sicherheits-, A11Y- und Kompatibilitaetsgrenzen. Implementiere nichts, veraendere keine Remote-Zustaende und starte keinen Autonomous- oder Parallel-Autonomous-Lauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md Fuehre den vollstaendigen Spec-Kit-Lauf gebunden an diesen Intake mit deliveryAuthority=LocalImplementation aus. Bewahre die Position-2-Reihenfolge und die TUI-Sperre bis zum Abschluss aller Eintraege 1 bis 4. Implementiere und validiere lokal bis zur definierten Abschlussgrenze. Stoppe bei fehlender Vorgaenger-Evidence oder einem harten Stopp. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
