<!-- intake-authoring:begin -->
# Lastenheft: Windows-Haertung der Ein-Kommando-Wartung

**Status:** ReadyForReview
**Zielgruppe / Audience:** Maintainer der `home-baseline`-Wartung und spaetere Spec-Kit-Ausfuehrende / maintainers of the `home-baseline` maintenance flow and later Spec Kit operators
**Profil / Profile:** `home-baseline-lastenheft`
**Repository:** `home-baseline`
**Dokumenttyp / Document type:** Windows-spezifischer Spec-Kit-Intake / Windows-specific Spec Kit intake
**Version:** 1.2
**Stand / Date:** 2026-07-28
**Delivery Authority:** `MergeAndSync`

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine eigene Windows-Haertungsrunde fuer das
Ein-Kommando-Wartungsskript. Grundlage sind dreizehn Befunde aus realen
Windows-Laeufen vom 22. und 28. Juli 2026. Der lokal festgestellte
Repository- und Registry-Drift ist bereinigt; offen ist die belastbare
Korrektur der Orchestrierung, damit Pruefung, Reparatur, Toolchain-Wartung und
Fortsetzung reproduzierbar funktionieren.

*This intake defines a dedicated Windows hardening round for the one-command
maintenance script. It is based on thirteen findings from real Windows runs on
22 and 28 July 2026. The observed repository and registry drift has already
been repaired; the remaining work is to make inspection, repair, toolchain
maintenance, and resume behavior reliable and reproducible.*

Dieses Dokument startet weder eine Implementierung noch einen Wartungslauf.
Der aktuelle Nutzerauftrag autorisiert den spaeteren autonomen Feature-Lauf mit
`MergeAndSync`. Technische, Sicherheits-, Test- und Review-Gates bleiben auch
bei administrativer Merge-Freigabe verbindlich.

*This document starts neither implementation nor maintenance. The current
user instruction authorizes the later autonomous feature run with
`MergeAndSync`. Technical, security, test, and review gates remain binding even
when administrative merge authority is available.*

## 2. Bindende Vorgaenger und Reihenfolge / Binding Predecessors and Order

Historische fachliche Grundlage ist Feature 009 mit dem archivierten Intake
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`
und der daraus entstandenen Wartungsimplementierung. Feature 009 ist kein
aktiver Knoten der aktuellen Intake-Serie mehr. Dieses Lastenheft ersetzt die
Grundlage nicht. Es praezisiert Windows-Defekte, die erst im realen Betrieb
sichtbar wurden.

*The historical functional baseline is Feature 009 with the archived intake
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`
and its delivered maintenance implementation. Feature 009 is no longer an
active node in the current intake series. This intake specifies Windows
defects that became visible only during a real maintenance run.*

Die Abarbeitung erfolgt als Root auf Position 1. Danach folgen die getrennte
Linux-/Ubuntu-Haertung auf Position 2 und die
Preset-/Profil-/Default-Branch-/Worktree-Haertung auf Position 3. Diese drei
Intakes sind untereinander keine technischen Vorgaenger. Ihre serielle
Reihenfolge vermeidet Konflikte an gemeinsamen Wartungsdateien. Die
Wartungs-TUI bleibt auf Position 4 gesperrt, bis Feature 009 und die aktiven
Positionen 1 bis 3 vollstaendig abgeschlossen sind.

*Processing takes place as a root at position 1. Linux/Ubuntu hardening follows
at position 2 and preset/profile/default-branch/worktree hardening at position
3. These roots are not technical predecessors of each other; serial delivery
avoids conflicts in shared maintenance files. The maintenance TUI at position
4 remains blocked until Feature 009 and active positions 1 through 3 are
closed.*

## 3. Ausgangslage / Current State

Die Windows-Laeufe zeigten folgende geordnete Befunde:

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
5. Die lokale Registry blieb auf einem aelteren Preset-Soll stehen. Die
   vollstaendige kanonische Flotte verwendet inzwischen nachweislich das
   Elf-Preset-Profil `intake-sequencing-eleven-governance-presets`.
6. 90 von 93 Drift-Meldungen waren nur Zeilenendennormalisierungen und erzeugten
   keinen Git-Diff.
7. GitHub-Timeouts beendeten den gesamten Lauf ohne begrenzten Retry.
8. `scripts/maintain-agentic-winget-apps.ps1:541` kann bei
   `winget upgrade --all` oder UAC-Installern unbegrenzt warten. Timeout,
   Deferred-Status und zuverlaessige Prozessbereinigung fehlen.
9. Die WinGet-Zusammenfassung meldete teilweise Pakete als fehlend, die zuvor
   als vorhandenes `OK package` erkannt worden waren.
10. Die vollstaendige `-WhatIf`-Vorschau wies alle Ziele aus, scheiterte aber
    am Abschluss, weil der Orchestrator fuer den verschachtelten Home-Sync
    gegenseitig ausschliessende Check- und Preview-Flags kombinierte.
11. Ein strukturierter Wartungsbericht meldete `overallStatus=PARTIAL` und
    `exitCode=1`, waehrend der umgebende PowerShell-Prozess mit Exitcode 0
    endete. Aufrufer konnten den fachlichen Fehlschlag dadurch uebersehen.
12. Windows-Regressionslaeufe zeigten drei Harness-Abweichungen: ein
    Bash-Untertest verstuemmelte absolute Windows-Pfade, ein
    PowerShell-Fixture klassifizierte eine verwaltete `AGENTS.md` als fremden
    Dirty-Zustand, und die Statistikpruefung verfehlte die erwartete
    Bash-/PowerShell-JSON-Byteparitaet.
13. PSScriptAnalyzer 1.25.0 war vor der uebersprungenen Toolchain-Stufe nicht
    verfuegbar. Der spaetere echte Toolchain-Lauf blieb mehr als 50 Minuten in
    `winget upgrade --all`, oeffnete mehrere UAC-Dialoge, erzeugte
    MSI-Abbrueche 1602 und musste mit seinem Prozessbaum explizit beendet
    werden.

*The Windows runs exposed thirteen ordered findings: unreliable Python command
resolution, a Python bootstrap cycle, unstable WhatIf repository discovery,
non-resumable self-created drift repair, a stale fleet preset profile,
line-ending-only false drift, missing bounded GitHub retries, unbounded WinGet
or UAC waits, contradictory package summaries, invalid nested preview flag
composition, contradictory report and process exit status, Windows path and
test-harness divergence, and late or unavailable static-analysis prerequisites.*

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
- korrekte Auswahl des dokumentierten Elf-Preset-Flottenprofils
- Git-normalisierte Driftpruefung
- begrenzte Retries fuer transiente GitHub-Netzwerkfehler
- Timeout, Deferred-Status und Prozessbereinigung fuer WinGet und UAC
- widerspruchsfreie Paketklassifikation und Zusammenfassung
- widerspruchsfreie verschachtelte Check-/Preview-Parameter
- identische fachliche Report- und Prozess-Exitcodes
- Windows-native Pfad-, Fixture- und Bash-/PowerShell-Paritaet
- fruehe, deterministische Toolchain- und Static-Analysis-Voraussetzungen
- deterministische Logs, strukturierter Bericht und Regressionstests

*In scope are validated Python resolution, bootstrap ordering, stable WhatIf
discovery, safe phase resume, the eleven-preset fleet profile, Git-normalized
drift checks, bounded GitHub retries, bounded WinGet execution, process
cleanup, consistent package status, coherent nested preview flags, truthful
exit codes, Windows path and harness parity, early toolchain prerequisites,
and deterministic evidence.*

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

### WEM-005 - Elf-Preset-Flottenprofil bewahren

Registry-Erzeugung und -Reparatur MUESSEN das explizit konfigurierte und lokal
nachgewiesene Flottenprofil verwenden. Fuer die aktuelle vollstaendige Flotte
ist dies `intake-sequencing-eleven-governance-presets`. Aeltere Acht- oder
Zehn-Preset-Matrizen duerfen nicht stillschweigend als lokaler Istzustand
eingesetzt werden. Profilquelle, Profil-ID, erwartete Preset-Anzahl und
Migration des lokalen Sollzustands muessen im Bericht nachvollziehbar sein;
unbekannte oder widerspruechliche Profile scheitern fail-closed.

*Registry creation and repair preserve the explicitly configured and locally
verified fleet profile. The current complete fleet uses
`intake-sequencing-eleven-governance-presets`. Older eight- or ten-preset
matrices must not silently replace local state. Reports show profile source,
profile ID, expected count, and local desired-state migration; unknown or
conflicting profiles fail closed.*

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

### WEM-010 - Widerspruchsfreie Preview-Parameter

Der Orchestrator MUSS Check-, Preview- und Mutationsparameter fuer jeden
verschachtelten Skriptaufruf aus genau einem kanonischen Modus ableiten.
Gegenseitig ausschliessende Flags wie Check-only und WhatIf duerfen niemals
gemeinsam weitergereicht werden. Eine vollstaendige Vorschau MUSS nach
Ausweisung aller Ziele mit einem fachlich korrekten Exitcode und einem
vollstaendigen Bericht enden.

*The orchestrator derives check, preview, and mutation parameters for every
nested script invocation from exactly one canonical mode. Mutually exclusive
flags such as check-only and WhatIf are never forwarded together. A complete
preview ends with a truthful exit code and complete report after listing all
targets.*

### WEM-011 - Wahrheitsgetreue Prozess- und Report-Exitcodes

Der fachliche Abschlussstatus im JSON-Bericht, der sichtbare Terminalstatus und
der Exitcode des obersten PowerShell-Prozesses MUESSEN dieselbe kanonische
Erfolgsklassifikation abbilden. `PARTIAL`, `Blocked`, `Failed` und nicht
akzeptierte Deferred-Zustaende duerfen nicht mit Prozess-Exitcode 0 enden.
Wrapper MUESSEN den Bericht eindeutig dem gestarteten Lauf zuordnen und duerfen
nicht versehentlich einen aelteren Bericht auswerten.

*The JSON result, visible terminal result, and top-level PowerShell process
exit code represent the same canonical outcome. `PARTIAL`, `Blocked`, `Failed`,
and unaccepted deferred states do not exit with process code zero. Wrappers
bind exactly the report produced by their run and never select stale evidence.*

### WEM-012 - Windows-Pfad- und Testharness-Paritaet

Gemeinsame Tests und Hilfsprogramme MUESSEN Windows-Pfade als undurchsichtige
native Pfade behandeln und duerfen Laufwerksbuchstaben, Backslashes oder
Gross-/Kleinschreibung nicht durch Bash-Konvertierung beschaedigen. Fixtures
MUESSEN verwaltete, vom Test selbst erzeugte Aenderungen von fremdem
Dirty-Worktree unterscheiden. Gemeinsame JSON-Vertraege vergleichen
kanonischen Inhalt; wenn Byteparitaet gefordert ist, MUSS die Encoding- und
Zeilenendenregel plattformunabhaengig festgelegt sein.

*Shared tests and helpers treat Windows paths as opaque native paths and do not
damage drive letters, backslashes, or path casing through Bash conversion.
Fixtures distinguish managed, test-created changes from foreign dirty work.
Shared JSON contracts compare canonical content; any required byte parity has
an explicit cross-platform encoding and line-ending rule.*

### WEM-013 - Fruehe Toolchain- und Static-Analysis-Gates

Erforderliche Validierungswerkzeuge, insbesondere die gepinnte
PSScriptAnalyzer-Version, MUESSEN vor dem ersten davon abhaengigen Gate
verfuegbar sein oder frueh als eigener, fortsetzbarer Prerequisite-Status
erscheinen. Eine blockierte Flottenphase darf fehlende Toolchain-Evidence nicht
als `N/A` verschleiern. Nach Toolchain-Wartung MUSS derselbe Lauf die
installierte Version pruefen und die statische Analyse entweder ausfuehren oder
einen eindeutigen Deferred-/Fehlerstatus berichten.

*Required validation tools, especially the pinned PSScriptAnalyzer version,
are available before their first dependent gate or reported early as a
resumable prerequisite state. A blocked fleet phase does not disguise missing
toolchain evidence as `N/A`. After toolchain maintenance, the same run verifies
the installed version and either performs static analysis or reports a clear
deferred or failed result.*

## 8. Qualitaet und Governance / Quality and Governance

### Sicherheit und Datenschutz / Security and Privacy

- Resume-Evidence enthaelt keine Tokens, Zugangsdaten oder privaten absoluten
  Pfade.
- Fremde Dirty-Aenderungen bleiben unangetastet; ein eigener Resume-Nachweis
  erweitert keine Git-Berechtigung.
- UAC wird nicht automatisiert bestaetigt oder umgangen.
- Die administrative Freigabe erlaubt erforderliche Prompts und einen
  regelkonformen administrativen Merge, ersetzt aber kein technisches,
  Sicherheits-, Test- oder Review-Gate.
- Git-Aktualisierungen bleiben auf `fetch` und `pull --ff-only` begrenzt.
- Prozessargumente und Logs duerfen keine Secrets offenlegen.

*Resume evidence contains no credentials or private absolute paths. Foreign
dirty changes remain untouched, UAC is not bypassed, and administrative
authority does not replace technical, security, test, or review gates. Git
updates remain limited to fetch and fast-forward pull, and process arguments or
logs expose no secrets.*

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
Windows-Pfadkonvertierung, widerspruechliche Exitcodes, prozesslokale
WinGet-Kindprozesse und eine zu breite Retry-Klassifikation. Diese Risiken sind
durch isolierte Fixtures und Negativtests abzudecken.

*Main risks are Store alias false positives, accidental adoption of foreign
changes, platform-specific Git line-ending behavior, Windows path conversion,
contradictory exit codes, WinGet child processes, and over-broad retry
classification. Isolated fixtures and negative tests must cover them.*

## 10. Erwartete Artefakte und Evidence / Expected Artifacts and Evidence

Die spaetere Implementierung liefert mindestens:

- gezielte Aenderungen an den betroffenen PowerShell-Skripten
- ein dokumentiertes, atomar geschriebenes Resume-State-Format mit
  Versionskennung und Validierung
- Regressionstests fuer alle dreizehn Anforderungen einschliesslich Fehler- und
  Resume-Pfade
- bei gemeinsam geaenderten Vertraegen passende Bash-Paritaetstests
- aktualisierte bilinguale comment-based help, README-Abschnitte und
  gegebenenfalls Schema-/Registry-Dokumentation
- einen sanitisierten Beispielbericht fuer erfolgreichen Lauf, Deferred-Fall,
  Retry-Erschoepfung und harten Resume-Stopp
- die gemaess Repository-Guidance aktualisierte Projektstatistik

*Later implementation provides focused PowerShell changes, a versioned and
validated atomic resume-state format, regression tests for all thirteen findings,
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
  lokale Flotte das Elf-Preset-Profil. Aeltere Acht- oder Zehn-Preset-Defaults
  werden nur bei explizit passender Konfiguration verwendet; unbekannte
  Profile scheitern.
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
- **AC-013:** Check-only und `-WhatIf` erzeugen fuer jeden verschachtelten
  Aufruf jeweils genau einen Modus. Kein Aufruf enthaelt gegenseitig
  ausschliessende Flags; die vollstaendige Vorschau endet mit Exitcode 0 und
  einem vollstaendigen Bericht.
- **AC-014:** Fuer erfolgreiche, partielle, blockierte, fehlgeschlagene und
  Deferred-Fixtures stimmen JSON-Status, JSON-Exitcode, sichtbarer Status und
  oberster Prozess-Exitcode exakt ueberein. Ein absichtlich bereitgestellter
  aelterer Bericht wird nicht dem neuen Lauf zugeordnet.
- **AC-015:** Windows-Tests bewahren Laufwerksbuchstaben, Backslashes und
  kanonische CaseTracker-Pfade, akzeptieren ausschliesslich nachgewiesene
  verwaltete Fixture-Aenderungen und bestehen den dokumentierten
  Bash-/PowerShell-JSON-Paritaetsvertrag.
- **AC-016:** Ein Fixture ohne PSScriptAnalyzer 1.25.0 meldet vor dem ersten
  Analyse-Gate einen fortsetzbaren Prerequisite-Status. Nach simulierter
  Toolchain-Installation prueft derselbe Lauf die Version und fuehrt die
  Analyse aus; eine blockierte Flottenphase markiert die Toolchain nicht als
  `N/A`.

*Acceptance covers working Python fallbacks, early bootstrap behavior, stable
WhatIf discovery, safe resume and rejection of foreign changes, exact
eleven-preset preservation, Git-normalized drift counts, bounded network
retries, bounded WinGet and UAC handling, unique package status, coherent
preview flags, truthful exit codes, Windows path and harness parity, early
static-analysis prerequisites, idempotence, and complete accessible reports
for every outcome.*

## 12. Annahmen und offene Fragen / Assumptions and Open Questions

Annahmen:

- Die Zielumgebung verwendet Windows 10 oder 11 und PowerShell 7.
- Die vollstaendige verwaltete lokale Flotte verwendet zum Stand dieses
  Intakes das dokumentierte Elf-Preset-Profil.
- Der bereits lokal bereinigte Drift muss nicht rekonstruiert werden; die
  Zahlen 90 Zeilenenden-Abweichungen und drei echte Abweichungen dienen als
  verbindliches Regressionstest-Szenario.
- `MergeAndSync` erlaubt Commit, Push, Pull Request, regelkonformen Merge und
  lokale Default-Branch-Synchronisierung erst nach bestandenen Gates.

*Assumptions are Windows 10 or 11 with PowerShell 7, the documented
eleven-preset profile for the complete managed local fleet, use of the observed
90 plus 3 drift split as a regression scenario, and MergeAndSync delivery only
after all gates pass.*

Offene materielle Fragen: keine.

*Open material questions: none.*

## 13. Abschlussgrenze / Completion Boundary

Die Windows-Haertungsrunde ist erst abgeschlossen, wenn alle Abnahmekriterien
mit lokaler, reproduzierbarer Evidence bestanden sind und kein offener
High-Severity-Befund fuer Python-Bootstrap, WhatIf-Ermittlung, Resume-Sicherheit,
Git-Drift, GitHub-Retry, Exitcode-Wahrheit, Windows-Testparitaet,
Toolchain-Gates oder WinGet-Prozesskontrolle verbleibt. Mit der aktuellen
`MergeAndSync`-Authority umfasst der Abschluss den regelkonformen Merge, die
lokale Default-Branch-Synchronisierung und eine abschliessende Git-Inventur.

*The hardening round is complete only when all acceptance criteria pass with
local reproducible evidence and no high-severity finding remains for Python
bootstrap, WhatIf discovery, resume safety, Git drift, GitHub retry, exit-code
truth, Windows test parity, toolchain gates, or WinGet process control. Under
the current MergeAndSync authority, completion includes policy-compliant merge,
local default-branch synchronization, and a final Git inventory.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md Erstelle die Spezifikation ausschliesslich aus diesem Intake und der historischen Feature-009-Baseline. Bewahre WEM-001 bis WEM-013, AC-001 bis AC-016, die Root-Position 1, die TUI-Sperre bis zum Abschluss von Feature 009 und der aktiven Positionen 1 bis 3 sowie alle Sicherheits-, A11Y- und Kompatibilitaetsgrenzen. Implementiere nichts, veraendere keine Remote-Zustaende und starte keinen Autonomous- oder Parallel-Autonomous-Lauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md Fuehre den vollstaendigen Spec-Kit-Lauf gebunden an diesen Intake mit deliveryAuthority=MergeAndSync aus. Bewahre WEM-001 bis WEM-013, AC-001 bis AC-016, die Root-Position 1 und die TUI-Sperre bis zum Abschluss von Feature 009 und der aktiven Positionen 1 bis 3. Implementiere, validiere und liefere bis zum regelkonformen Merge und zur lokalen Default-Branch-Synchronisierung. Stoppe bei fehlender historischer Baseline-Evidence oder einem harten Stopp. Administrative Freigabe ersetzt kein technisches, Sicherheits-, Test- oder Review-Gate. Fuehre nach Abschluss die Git-Inventur in der Reihenfolge Status, Fetch, sichere Pulls, absichtliche Commits und Pushes aus und starte kein Folgefeature.
```

<!-- intake-authoring:end -->
