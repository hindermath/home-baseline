<!-- intake-authoring:begin -->
# Lastenheft: Agentic-Workspace-Wartungs-TUI

**Repository:** `home-baseline`
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit; Vorgaenger-Gate erfuellt und Position 4 `Eligible`
**Stand:** 2026-07-29
**Historische Gate-Evidence / Historical gate evidence:** Feature 009 mit
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`

**Abgeschlossene bindende Vorgaenger / Completed binding predecessors:**

1. Feature 015 mit
   `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.015-windows-maintenance-hardening.md`
   und PR #142
2. Feature 016 mit
   `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.016-linux-maintenance-hardening.md`
   sowie PRs #146 und #148
3. Feature 017 mit
   `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.017-preset-profile-worktree-hardening.md`
   sowie PRs #153 und #154

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine plattformuebergreifende, barrierearme
Terminaloberflaeche fuer die vorhandene Ein-Kommando-Wartung
`maintain-agentic-workspace.*`. Die TUI soll einen sicheren interaktiven
Einstieg, eine kontrollierte Auswahl der vorhandenen Wartungsmodi und eine
laufende Phasenanzeige anbieten, ohne die Wartungslogik aus Bash und
PowerShell zu duplizieren.

*This requirements document describes a cross-platform, accessibility-oriented
terminal interface for the existing `maintain-agentic-workspace.*`
one-command maintenance flow. The TUI provides a safe interactive entry point,
controlled selection of existing maintenance modes, and live phase status
without duplicating the Bash and PowerShell maintenance logic.*

Das Anlegen dieses Dokuments startet keinen Spec-Kit-Lauf. Am Ende stehen ein
kopierbarer `$speckit-specify`-Prompt und ein kopierbarer
`$speckit-autonomous`-Prompt bereit. Beide pruefen den aktuell erfuellten
Vorgaengerabschluss vor jeder Feature-Erstellung erneut.

*Creating this document starts no Spec Kit run. Copyable staged and autonomous
entry points are provided at the end, and both revalidate the currently
satisfied predecessor closeout before feature creation.*

## 2. Hartes Vorgaenger-Gate / Hard Predecessor Gate

Feature 009 sowie die Wartungshaertungen 015, 016 und 017 sind vollstaendig
umgesetzt, validiert, gemergt und archiviert. Der aktuelle Schema-1.1-
Series-Review fuehrt dieses Lastenheft als einzigen bevorzugten
`Eligible`-Kandidaten. Feature 009 bleibt historische Gate-Evidence und ist
kein aktiver Serienknoten.

*Feature 009 and maintenance hardening Features 015, 016, and 017 are
implemented, validated, merged, and archived. The current schema-1.1 series
review identifies this intake as the single preferred `Eligible` candidate.
Feature 009 remains historical gate evidence, not an active series node.*

Vor Feature-, Branch- oder Specify-Artefakterstellung wird dieser Abschluss
erneut fail-closed geprueft:

1. Die archivierten Lastenhefte und die Feature-Verzeichnisse `009`, `015`,
   `016` und `017` sind eindeutig zugeordnet.
2. `autonomous-run-state.json` der Features 015 bis 017 ist gueltig,
   `Completed`, und alle verpflichtenden Tasks sind abgeschlossen.
3. Requirements-, Analyze-, Plattform-, Sicherheits-, A11Y- und
   Exact-Head-Nachweise enthalten keinen offenen blockierenden Befund.
4. Die Merge- und Closeout-Evidence fuer PRs #142, #146, #148, #153 und #154
   ist vorhanden; `main` und `origin/main` sind synchron.
5. Der aktive Series-Vertrag ist hashkonsistent, besitzt 38 Ziele, drei Roots,
   45 Abhaengigkeiten und genau diesen Intake als bevorzugten
   `Eligible`-Kandidaten.
6. Der Wartungsbaum enthaelt keinen nicht zugeordneten Drift, der den
   Maschinenvertrag oder die TUI-Tests unzuverlaessig machen wuerde.

*Before feature, branch, or Specify artifact creation, the run revalidates the
archived predecessor identities, completed autonomous states and tasks,
quality and platform evidence, merge closeouts, exact repository state, and
the hash-bound 38-target series contract.*

Fehlt ein Nachweis oder ist er gedriftet, wird das Gate erneut `BLOCKED`. Der
Lauf stoppt vor Feature-Erstellung oder Repository-Aenderung und nennt den
fehlenden Nachweis sowie die naechste sichere Aktion. Adminrechte, manuelle
Statusbehauptungen oder Ruleset-Bypass duerfen dieses fachliche Gate nicht
ersetzen.

*Missing or drifted evidence returns the gate to `BLOCKED`. The run stops
before feature creation or repository changes and names the evidence gap and
next safe action. Administrative rights or ruleset bypass cannot replace this
domain gate.*

## 3. Ausgangslage und Zielbild / Current State and Target State

Die vorhandenen Bash- und PowerShell-Einstiege fuehren ohne Parameter die
vollstaendige Wartung aus. Sie stellen ausserdem Check-only, Dry-run/WhatIf,
Scripts-only, Drift-Reparatur, optionale Pakete und ein alternatives
Home-Verzeichnis bereit. Diese Engine und ihre Sicherheitsgrenzen bleiben
kanonisch.

*The existing Bash and PowerShell entry points perform full maintenance without
parameters and expose check-only, preview, scripts-only, drift repair, optional
packages, and an alternative home directory. That engine and its safety
boundaries remain canonical.*

Die abgeschlossenen Features 015 bis 017 erweitern diesen kanonischen Vertrag.
Die TUI muss insbesondere folgende bereits vorhandene Ergebnisse abbilden,
nicht neu implementieren:

- genau einen Wartungsmodus je Lauf und eine einmalige terminale
  Ergebnisbewertung;
- atomare, hashgebundene Resume- und Abschluss-Evidence;
- begrenzte Prozess-, Netzwerk- und Tool-Probes mit Versuchszahl, Dauer,
  Endstatus und sicherer Prozessbaumbeendigung;
- stdin- und umgebungsisolierte Registry- und Toolchain-Verarbeitung;
- wahrheitsgetreue Required-/Optional-Aggregation, einschliesslich
  `PARTIAL` mit Exitcode `1`;
- die Remote-Freshness-Barriere vor jeder Fachmutation;
- sichere Pull-Freigabe nur fuer saubere, eindeutig zugeordnete und
  ausschliesslich zurueckliegende Default-Branches;
- Worktree-Leases mit Besitz-, Prozessstart-, Pfad- und Commit-Bindung;
- dynamisch aufgeloeste Preset-Profile statt fest eingebauter Anzahl;
- keine Commit-, Push-, PR- oder Merge-Autoritaet fuer gewartete
  Ziel-Repositories.

*Features 015 through 017 added canonical single-mode finalization, atomic
resume evidence, bounded processes and network attempts, isolated input and
environment handling, truthful partial results, the fleet freshness and
mutation barriers, safe pull classification, owned worktree leases, dynamic
preset profiles, and a strict no-publication boundary for maintenance targets.
The TUI presents these outcomes and does not reimplement them.*

Die neue Oberflaeche wird als internes `.NET 10`-Hilfsprogramm mit
Spectre.Console umgesetzt. C# ist hier gegenueber zusaetzlicher Bash- oder
PowerShell-Dialoglogik begruendet, weil typisierte Modellierung, testbare
Terminalausgabe und eine gemeinsame UI-Implementierung fuer alle drei
Plattformen benoetigt werden. Spectre.Console stellt die erforderlichen
Prompts, Tabellen, Live-Anzeigen, Terminalfaehigkeiten und Testunterstuetzung
bereit:

- [Spectre.Console](https://spectreconsole.net/console/)
- [Terminal capabilities](https://spectreconsole.net/console/reference/capabilities-reference/)
- [Testing console output](https://spectreconsole.net/console/how-to/testing-console-output/)

*The UI is an internal .NET 10 helper using Spectre.Console. A shared typed and
testable implementation is justified for the three supported platforms, while
all operational maintenance remains in the existing engines.*

## 4. Aufruf- und Kompatibilitaetsvertrag / Invocation and Compatibility Contract

Die Wrapper erkennen TTY und Parameter vor dem Start der Engine:

| Aufruf / Invocation | Verbindliches Verhalten / Required behavior |
|---|---|
| Keine Argumente, `stdin` und `stdout` interaktives TTY | TUI starten; Dry-run ist vorausgewaehlt |
| Keine Argumente, kein vollstaendiges interaktives TTY | Bisherigen unbeaufsichtigten Komplettlauf unveraendert starten |
| Mindestens ein bestehender Wartungsparameter | Bisherigen Headless-Pfad ohne TUI verwenden |
| `--tui` / `-Tui` | Spectre-TUI ausdruecklich anfordern |
| `--plain-ui` / `-PlainUi` | Linearen interaktiven Plaintext-Assistenten erzwingen |
| `--no-tui` / `-NoTui` | Headless-Ausfuehrung erzwingen; ohne weitere Parameter vollstaendige Wartung |

*No arguments on an interactive standard input and output open the TUI with
dry-run selected. Non-interactive no-argument use preserves unattended full
maintenance. Existing maintenance arguments remain headless.*

Die drei Oberflaechenschalter sind gegenseitig exklusiv. `--tui` und
`--plain-ui` duerfen nur mit `--home-dir PATH` beziehungsweise `-HomeDir PATH`
kombiniert werden; alle Wartungsmodi werden danach im Assistenten gewaehlt.
`--no-tui` darf mit den vorhandenen Wartungsparametern kombiniert werden.
Unzulaessige Kombinationen enden wie bisher als Parameterfehler mit Exitcode
`2`.

*The three UI selectors are mutually exclusive. TUI and plain-wizard requests
may only carry the alternative home setting because maintenance modes are
selected inside the assistant. No-TUI may accompany existing maintenance
arguments. Invalid combinations remain exit code 2 errors.*

`TERM=dumb`, nicht interaktive Ein-/Ausgabe oder eine nicht unterstuetzte
Terminalfaehigkeit duerfen niemals zu einem haengenden Prompt fuehren. Ein
explizites `--tui` faellt in diesem Fall mit sichtbarem Hinweis auf den
Plaintext-Assistenten zurueck. Ohne ausdruecklichen UI-Schalter bleibt der
Headless-Vertrag massgeblich.

*Unsupported terminal capabilities never cause a hanging prompt. An explicit
TUI request falls back to the plain assistant; implicit non-interactive use
stays headless.*

## 5. Interaktiver Ablauf / Interactive Flow

Die Oberflaeche fuehrt in fester Reihenfolge durch:

1. Anzeige von Quelle, Plattform, Home-Verzeichnis und erkanntem
   Wartungsvertrag.
2. Auswahl des Wartungsmodus; `Dry-run / WhatIf` ist initial markiert.
3. Optionale Auswahl von `Scripts-only`, `Include optional` und
   `Repair drift`, soweit die Engine-Kombination zulaessig ist.
4. Anzeige der normalisierten Auswahl und des aequivalenten Bash- oder
   PowerShell-Aufrufs.
5. Ausdrueckliche Bestaetigung vor jedem echten schreibenden Lauf.
6. Start der vorhandenen Engine als Kindprozess.
7. Live-Phasenanzeige und anschliessender Abschluss mit Exitstatus, Befunden,
   Logpfad und JSON-Berichtspfad.

*The assistant shows its environment, starts with preview selected, validates
the engine's option combinations, displays the equivalent command, confirms
mutating runs, starts the existing engine, and presents live and final status.*

Verbindliche Auswahlregeln:

- `Check-only` und `Dry-run/WhatIf` sind gegenseitig exklusiv.
- `Repair drift` ist nur in einem echten Lauf moeglich.
- `Include optional` ist bei `Scripts-only` deaktiviert.
- Die Oberflaeche darf keine Kombination erzeugen, die der direkte CLI-Aufruf
  ablehnt.
- Dry-run und Check-only brauchen keine zweite Schreibbestaetigung.
- Die Bestaetigung fuer echte Laeufe ist standardmaessig `Nein`.
- Abbruch vor Engine-Start veraendert keine Wartungsdaten und endet mit
  Exitcode `130`.

*The UI mirrors every existing option conflict, defaults mutating confirmation
to no, and never constructs a command rejected by the direct CLI.*

## 6. Architektur und Verantwortungsgrenzen / Architecture and Boundaries

Das interne Hilfsprogramm liegt unter
`scripts/lib/maintenance-tui/` und zielt auf `net10.0`. Es enthaelt
Darstellungs-, Auswahl-, Ereignis- und Prozessadapter, aber keine Git-, Sync-,
Clone-, Registry-, Propagations- oder Paketmanagerimplementierung.

*The internal `net10.0` helper contains presentation, selection, event, and
process adapters only. It contains no maintenance implementation.*

Die Wrapper bleiben die oeffentlichen plattformspezifischen Einstiegspunkte:

- macOS/Linux: `bash scripts/maintain-agentic-workspace.sh`
- Windows: `pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1`

Nach der UI-Auswahl startet die TUI exakt den zum Betriebssystem passenden
Wrapper in einem internen Headless-Modus. Argumente werden ueber typisierte
Prozessargumentlisten uebergeben. Shell-Interpolation, `eval`,
`Invoke-Expression` oder das Zusammensetzen eines ausfuehrbaren
Befehlsstrings sind unzulaessig.

*The UI invokes the platform-matching wrapper through typed process argument
lists in an internal headless mode. Executable shell command strings and
dynamic evaluation are forbidden.*

Die angezeigte aequivalente Befehlszeile dient nur der nachvollziehbaren
Darstellung. Sie wird mit plattformgerechtem Escaping erzeugt, aber niemals
erneut als Shelltext ausgefuehrt.

*The displayed equivalent command is explanatory only and is never executed as
shell text.*

## 7. Strukturierter Ereigniskanal / Structured Event Channel

Die gehaertete Wartungs-Engine erhaelt einen additiven, versionierten
JSONL-Ereigniskanal. Die internen Parameter lauten
`--event-stream PATH` und `-EventStream PATH`. Bestehende Aufrufe ohne diesen
Parameter behalten ihre Konsolenausgabe und Exitcodes.

*The hardened engine gains additive internal event-stream parameters. Existing
invocations without the parameter preserve their console and exit-code
contracts.*

Jede UTF-8-Zeile ist ein eigenstaendiges JSON-Objekt mit mindestens:

| Feld / Field | Vertrag / Contract |
|---|---|
| `schemaVersion` | zunaechst exakt `1` |
| `runId` | pro Lauf eindeutige UUID |
| `sequence` | bei `1` beginnende, streng steigende Ganzzahl |
| `timestampUtc` | RFC-3339-Zeitpunkt in UTC |
| `eventType` | definierter Ereignistyp |
| `status` | definierter Maschinenstatus |
| `phaseId` | stabiler Phasenbezeichner, sofern anwendbar |
| `targetId` | Fleet-Ziel, sofern anwendbar; keine direkte Ableitung aus freiem Text |
| `messageDe` / `messageEn` | kurze barrierearme Menschenmeldung |
| `details` | ereignisspezifisches Objekt ohne Secrets |

Zulaessige initiale Ereignistypen sind:

- `run-started`
- `phase-started`
- `phase-progress`
- `finding`
- `phase-completed`
- `run-completed`

*Version 1 defines ordered run, phase, progress, finding, and completion events
with stable identifiers and bilingual text.*

`phaseId` verwendet die vorhandenen stabilen Wartungsphasen `fleet`, `level0`,
`home-sync`, `registry`, `propagation`, `preset-profiles`, `toolchain` und
`final`. Der Ereignisstatus wird auf die kanonischen Maschinenzustaende der
Engine abgebildet, darunter `RUNNING`, `PASSED`, `PARTIAL`, `BLOCKED`,
`WARNING`, `SKIPPED` und `FAILED`. Weder die TUI noch der Ereigniskanal
erfinden aus stiller Ausgabe einen erfolgreichen Zustand.

*Phase identifiers and status values reuse the engine's canonical vocabulary.
Silence or missing progress never implies success.*

Die Engine schreibt abgeschlossene Zeilen append-only in eine nur fuer den
aktuellen Benutzer zugaengliche Datei. Die TUI liest diese Datei fortlaufend,
wertet aber niemals freie Standardausgabe als Statusprotokoll aus.
Unvollstaendige Schlusszeilen werden bis zur Vervollstaendigung ignoriert.
Sequenzluecken, ungueltiges JSON oder eine nicht unterstuetzte Schema-Version
erzeugen einen sichtbaren `EVENT_STREAM_DEGRADED`-Befund und schalten auf die
lineare Loganzeige um. Der Engineprozess wird deshalb weder beendet noch sein
Exitcode veraendert.

*The engine appends complete records to a user-private file. Malformed or
unsupported event data degrades presentation to linear logs without changing
the engine process or result.*

Der atomar finalisierte JSON-Abschlussbericht bleibt die kanonische
Maschinenwahrheit. `run-completed` nennt dessen Pfad, Logpfad, Lauf-ID,
Gesamtstatus und Exitcode. Die TUI prueft Lauf-ID, Finalisierungsstatus,
Gesamtstatus und Exitcode gegeneinander. Widersprechen sich Ereignis,
Abschlussbericht oder Prozess-Exitcode, hat der Prozess-Exitcode Vorrang und
die TUI meldet `RESULT_MISMATCH`.

*The atomically finalized JSON report remains canonical. Run identity,
finalization, result, and process exit are reconciled; the process exit wins
over contradictory data and produces a visible mismatch finding.*

## 8. Build-Cache und Plaintext-Fallback / Build Cache and Plain Fallback

Es werden keine erzeugten Binaerdateien eingecheckt. Projektdateien,
Quelltexte, Tests, `packages.lock.json` und die verifizierte
Paketquellenkonfiguration bleiben Git-getrackt.

*Generated binaries are not committed; sources, tests, lock file, and verified
package-source configuration are tracked.*

Der Wrapper verwendet folgende Reihenfolge:

1. Passenden vorhandenen Cache unter
   `~/.home-baseline/cache/maintenance-tui/<Quellfingerabdruck>/<OS-Arch>/`
   verwenden.
2. Bei vorhandenem `.NET 10` SDK einen frameworkabhaengigen Build mit Locked
   Restore in ein temporaeres Verzeichnis publizieren.
3. Den vollstaendigen Build erst nach Erfolg atomar in den Cache verschieben.
4. Bei fehlendem SDK, fehlgeschlagenem Restore/Build oder nicht schreibbarem
   Cache den linearen Plaintext-Assistenten verwenden.

*A matching cached framework-dependent build is preferred. A new build uses
locked restore and becomes visible atomically; any unavailable prerequisite
falls back to the plain assistant.*

Der Quellfingerabdruck ist ein SHA-256 ueber die sortierten relativen Pfade und
Inhalte des TUI-Projekts, seiner Lockdatei sowie der Wrapper-UI-Version. Dadurch
werden auch noch nicht committete, aber bewusst getestete Quellaenderungen
nicht mit einem veralteten Build ausgefuehrt. `OS-Arch` wird auf
`macos-arm64`, `macos-x64`, `linux-arm64`, `linux-x64`, `windows-arm64` oder
`windows-x64` normalisiert.

*The source fingerprint covers sorted paths and contents plus the wrapper UI
version, preventing stale cache reuse. Platform and architecture names are
normalized.*

Spectre.Console und Spectre.Console.Testing werden auf `0.57.2` festgelegt.
`RestorePackagesWithLockFile` und Locked Restore sind verpflichtend.
Die Aktualisierung ist durch die offizielle NuGet-Metadatenquelle, MIT-Lizenz,
den Upstream-Commit und einen Schwachstellennachweis zu belegen. Spaetere
Abhaengigkeitsaktualisierungen erfolgen nur als eigene nachvollziehbare
Aenderung mit Lizenz-, Wartungs- und Schwachstellenpruefung.

*Spectre.Console dependencies are pinned to 0.57.2 with locked restore and
supply-chain evidence. Later dependency upgrades require a separate review.*

Der Plaintext-Assistent besitzt denselben Auswahl-, Konflikt-, Vorschau- und
Bestaetigungsvertrag wie die TUI. Er verwendet nur zeilenorientierte Prompts
und ASCII-Status. Er ist kein vereinfachter unsicherer Ausfuehrungspfad.

*The plain assistant implements the same selection and safety contract through
line-oriented ASCII prompts.*

## 9. Live-Dashboard / Live Dashboard

Die normale Spectre-Ansicht zeigt:

- Laufmodus, Plattform, Quelle und Home-Verzeichnis
- aktuelle Phase, textuellen Status und Zustand der Mutation Barrier
- Anzahl geplanter, laufender, erfolgreicher, uebersprungener und
  fehlgeschlagener Repository-Ziele
- sichere Pull-Kandidaten und gesperrte Dirty-, Ahead-, Diverged-, Detached-,
  Non-Default-, Upstream- oder Remote-Zustaende
- Anzahl Warnungen, Required-/Optional-Drift-, Admin- und Betriebsbefunde
- Worktree-Lease- und dynamisch aufgeloesten Preset-Profilstatus
- zuletzt abgeschlossenes Ziel beziehungsweise letzte sichere Aktion
- Log- und Berichtspfade nach Abschluss

*The normal view shows run context, phase and mutation barrier, repository and
pull classifications, required and optional findings, lease and profile
status, the latest safe action, and final evidence paths.*

Live-Anzeigen duerfen hoechstens zehnmal pro Sekunde aktualisiert werden.
Fortschritt ohne belastbaren Nenner wird nicht als erfundener Prozentwert
dargestellt. Animationen koennen entfallen; textueller Phasenstatus bleibt
immer vorhanden. Bei weniger als 80 Spalten wird automatisch auf eine lineare
Kompaktansicht gewechselt.

*Refresh is bounded, unknown totals never become invented percentages, and
narrow terminals automatically use a compact linear view.*

## 10. Barrierefreiheit / Accessibility

- Alle Funktionen sind vollstaendig per Tastatur bedienbar.
- Farbe, Position, Fortschrittsbalken oder Animation sind nie der einzige
  Informationstraeger.
- Maschinenstatus wird mit ASCII-Text wie `RUNNING`, `PASSED`, `PARTIAL`,
  `BLOCKED`, `WARNING`, `FAILED` und `SKIPPED` ergaenzt.
- `NO_COLOR` wird respektiert.
- `TERM=dumb`, schmale Terminals und Screenreader erhalten lineare Ausgabe in
  stabiler Lesereihenfolge.
- Fokus und Auswahl werden textuell benannt.
- Laufende Animationen werden bei reduzierter Darstellung deaktiviert.
- Alle Abschlussinformationen bleiben kopierbar und ohne Farbe verstaendlich.
- Deutsch steht bei nutzerseitigen Meldungen zuerst, Englisch danach.

*The interface is keyboard-complete, never color-only, compatible with
`NO_COLOR`, linear terminals, narrow layouts, and screen-reader-oriented
reading order. Status and closeout evidence remain textually copyable.*

Die anwendbaren Kriterien von WCAG 2.2 Level AA werden als
Requirements-Checkliste behandelt. Nicht auf Terminalsoftware uebertragbare
Kriterien werden mit Begruendung und erneutem Pruefausloeser als `N/A`
dokumentiert.

*Applicable WCAG 2.2 AA criteria become checklist items; non-applicable criteria
require rationale and a re-evaluation trigger.*

## 11. Sicherheit und Datenschutz / Security and Privacy

- Die TUI fordert keine Administratorpasswoerter, API-Schluessel, Tokens oder
  sonstigen Secrets an.
- Administratorpflichtige Paketaktionen bleiben strukturierte
  `DEFERRED_ADMIN_REQUIRED`-Befunde der Engine.
- Die Bestaetigung eines echten TUI-Laufs erteilt keine
  Zielrepository-Publikations-, Provider- oder Administratorautoritaet.
- Pfade, Remotes und Meldungen werden vor Spectre-Markup maskiert.
- Ereignisstrom, Cache und temporaere Dateien sind nur fuer den aktuellen
  Benutzer zugaenglich.
- Event- und Fehlerdaten enthalten keine Umgebungsvariablen-Dumps,
  Verbindungszeichenketten oder direkten personenbezogenen Kontakt- und
  Zahlungsdaten.
- Relative und alternative Home-Pfade werden durch die vorhandenen
  Engine-Pruefungen normalisiert; die TUI fuehrt keine schwaechere
  Parallelvalidierung ein.
- Kindprozesse erben nur die fuer den Wartungslauf benoetigte Umgebung.
- Abbruch sendet zuerst ein kontrolliertes Interruptsignal und verwendet
  keine rekursive Prozess- oder Dateiloeschung.
- Die TUI bietet weder breites `git clean`, Reset, Stash noch rekursives
  Loeschen in Nutzer-Checkouts an.

*The TUI never requests secrets or administrator credentials, preserves
deferred administrator findings, sanitizes markup, restricts local evidence,
delegates path security to the canonical engine, and grants no publication,
provider, cleanup, or elevation authority.*

## 12. Exitcodes, Abbruch und Fehlerfaelle / Exit Codes, Cancellation, and Failures

Die Enginecodes bleiben unveraendert:

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | aktuell oder erfolgreich / current or successful |
| `1` | Drift oder nicht synchroner Zustand / drift or unsynchronized state |
| `2` | Parameter-, Betriebs- oder Sicherheitsfehler / parameter, operational, or safety error |
| `3` | Drift lokal repariert; separate Pruefung erforderlich / drift repaired; separate review required |
| `130` | Benutzerabbruch vor oder waehrend der Ausfuehrung / user cancellation |

*The UI propagates the engine result unchanged and reserves 130 for user
cancellation.*

`Ctrl+C` vor Engine-Start beendet direkt mit `130`. Nach Engine-Start wird das
Signal einmal kontrolliert weitergereicht. Die TUI wartet auf den terminalen
Prozessstatus und zeigt vorhandene Log-/Berichtspfade. Ein zweiter Abbruch darf
die Darstellung beenden, aber keine unbestaetigte destruktive Bereinigung
ausloesen.

*Cancellation is forwarded cooperatively and never triggers unconfirmed
destructive cleanup.*

Fehler in TUI-Build oder -Darstellung duerfen den Plaintext-Assistenten
aktivieren. Fehler der Wartungs-Engine duerfen dagegen nicht als UI-Fallback
neu gestartet werden, weil dies Wartungsaktionen doppelt ausfuehren koennte.

*UI startup failures may fall back before the engine starts. Engine failures
are never retried implicitly.*

## 13. Teststrategie / Test Strategy

### 13.1 Komponenten- und Konsolentests

Spectre.Console.Testing prueft mindestens:

- Dry-run als Anfangsauswahl
- jeden Wartungsmodus und jede zulaessige Kombination
- deaktivierte und abgelehnte Konfliktkombinationen
- Bestaetigung mit Default `Nein`
- Abbruch vor Engine-Start
- Markup-Escaping fuer fremde Pfade und Meldungen
- `NO_COLOR`, schmale Ansicht und ASCII-only-Status
- stabile lineare Lesereihenfolge

*Console tests cover selection, conflicts, safe confirmation, cancellation,
markup sanitization, no-color, narrow, and linear output.*

### 13.2 Fake-Engine-Integration

Eine deterministische Fake-Engine erzeugt Ereignisse und Exitcodes fuer:

- vollstaendigen Erfolg
- `SUCCESS_WITH_WARNINGS`
- wahrheitsgetreues `PARTIAL` mit Exitcode `1` und vollstaendiger Evidence
- blockierte Mutation Barrier nach vollstaendiger Fleet-Inventur
- sicheren Pull-Kandidaten sowie Dirty-, Ahead-, Diverged-, Detached- und
  Non-Default-Zustand
- Betriebsfehler mit Exitcode `2`
- reparierten Drift mit Exitcode `3`
- `DEFERRED_ADMIN_REQUIRED`
- partiellen Lauf mit unabhaengiger Fortsetzung
- gueltige, verwaiste, fremde und manipulierte Worktree-Leases
- aktuelles Elf-Preset-Profil und ein synthetisch erweitertes Profil
- ungueltiges JSONL, Sequenzluecke und unbekannte Schema-Version
- Widerspruch zwischen `run-completed`, Abschlussbericht und Prozess-Exitcode
- langsame Ausgabe und `Ctrl+C`

*A deterministic fake engine covers terminal results, fleet and barrier
classification, leases, dynamic profiles, resumable findings, malformed
events, result mismatch, slow output, and interruption.*

### 13.3 Wrapper- und Kompatibilitaetstests

- Keine Argumente mit TTY startet die TUI.
- Keine Argumente ohne TTY startet den bisherigen Komplettlauf.
- Jeder bestehende Parameter umgeht die TUI.
- Explizite TUI-, Plaintext- und No-TUI-Modi folgen dem Kombinationsvertrag.
- Fehlendes `.NET 10`, Offline-Restore, beschaedigter Cache und nicht
  schreibbarer Cache fallen sicher zurueck.
- Ein erfolgreicher Cache wird wiederverwendet; ein veraenderter
  Quellfingerabdruck nicht.
- Bash 3.2, Bash 5 oder neuer und PowerShell 7 erzeugen dieselbe fachliche
  Auswahl.
- Headless-Ausgabe und Exitcodes bestehender Aufrufe bleiben unveraendert.
- Die Windows-Vertraege fuer Preview, Timeout, atomare Resume-Evidence und
  einmalige Abschlussbewertung bleiben gruen.
- Die Linux-Vertraege fuer stdin-Isolation, Required-Aggregation,
  Umgebungsisolation und atomare Finalisierung bleiben gruen.
- Die Fleet-Vertraege fuer Freshness Barrier, sichere Pull-Entscheidung,
  Worktree-Leases und dynamische Profile bleiben gruen.

*Wrapper tests prove TTY routing, backward compatibility, safe fallback,
fingerprinted caching, and Bash/PowerShell parity.*

### 13.4 Plattform- und Lieferkettenmatrix

Verpflichtende Plattformen:

- macOS mit System-Bash 3.2 und PowerShell 7
- Ubuntu mit aktuellem Bash und PowerShell 7
- Windows mit PowerShell 7

Verpflichtende .NET-Pruefungen:

```text
dotnet restore --locked-mode
dotnet build --no-restore
dotnet test --no-restore
dotnet list package --include-transitive
dotnet list package --vulnerable --include-transitive
```

Die tatsaechlichen Projektpfade werden im Spec-Kit-Plan explizit eingesetzt.
Fehlende Runner- oder Plattformnachweise gelten nicht als bestanden und
blockieren eine Remote-Auslieferung, die diese Gates voraussetzt.

*The exact candidate is restored in locked mode, built, tested, and audited on
macOS, Ubuntu, and Windows. Missing required platform evidence is not a pass.*

## 14. Funktionale Abnahmekriterien / Functional Acceptance Criteria

- **AC-01:** Interaktiver argumentloser Aufruf startet die TUI mit
  vorausgewaehltem Dry-run.
- **AC-02:** Nicht interaktiver argumentloser Aufruf behaelt den bisherigen
  unbeaufsichtigten Komplettlauf.
- **AC-03:** Bestehende Parameter bleiben headless und kompatibel.
- **AC-04:** Die TUI bildet alle erlaubten Modi ab und erzeugt keine
  unzulaessige Kombination.
- **AC-05:** Vor echten Aenderungen werden Modus, Ziel und aequivalenter Befehl
  gezeigt und mit Default `Nein` bestaetigt.
- **AC-06:** Git-, Sync-, Clone-, Registry-, Propagations- und Paketaktionen
  werden ausschliesslich durch die vorhandene Engine ausgefuehrt.
- **AC-07:** Live-Status stammt ausschliesslich aus dem versionierten
  Ereigniskanal.
- **AC-08:** Fehlerhafter Ereignisstrom degradiert die Darstellung, nicht den
  Engineprozess.
- **AC-09:** Exitcodes `0`, `1`, `2`, `3` und `130` folgen dem definierten
  Vertrag.
- **AC-10:** Cache, Offline- und Plaintext-Fallback sind deterministisch
  getestet.
- **AC-11:** Die Oberflaeche bleibt per Tastatur, ohne Farbe und linear
  benutzbar.
- **AC-12:** macOS-, Ubuntu- und Windows-Nachweise bestehen fuer den exakten
  Lieferkandidaten.
- **AC-13:** Das Vorgaenger-Gate stoppt nachweislich vor jeder TUI-Feature- oder
  Implementierungsaenderung, wenn einer der aktuell abgeschlossenen
  Vorgaengernachweise fehlt oder gedriftet ist.
- **AC-14:** Das aktuelle Gate bestaetigt Feature 009 sowie Features 015 bis
  017 und gibt Position 4 als einzigen bevorzugten `Eligible`-Kandidaten frei.
- **AC-15:** `PARTIAL` mit Exitcode `1` und vollstaendiger Evidence wird weder
  als UI-Absturz noch als Erfolg dargestellt.
- **AC-16:** Ereignisstrom, atomarer Abschlussbericht und Prozess-Exitcode
  werden laufgebunden abgeglichen; Widerspruch ergibt `RESULT_MISMATCH`.
- **AC-17:** Alle Fetch-Versuche sind vor der ersten Fachmutation sichtbar
  abgeschlossen; ein Einzelbefund beendet die Bestandsaufnahme nicht.
- **AC-18:** Mutation Barrier, Pull-Freigaben und blockierte
  Repository-Zustaende bleiben ohne Farbe und ohne Checkout-Mutation
  nachvollziehbar.
- **AC-19:** Eigene, fremde, aktive, verwaiste und manipulierte
  Worktree-Leases werden mit der kanonischen Engine-Entscheidung dargestellt.
- **AC-20:** Das aktuelle Elf-Preset-Profil und ein synthetisch erweitertes
  Profil funktionieren ohne TUI-Codeaenderung.
- **AC-21:** Preview-, Resume-, Eingabe-, Umgebungs- und Abschlussvertraege
  aus Features 015 und 016 bleiben gruen.
- **AC-22:** TUI-Bestaetigung oder Delivery Authority fuer dieses Feature
  erteilt der Wartungs-Engine keine Commit-, Push-, PR-, Merge-, Provider-
  oder Administratorautoritaet fuer Ziel-Repositories.

*Acceptance preserves headless behavior, delegates all maintenance, proves the
event and fallback contracts, covers accessibility and all platforms, and
revalidates predecessor evidence, truthful partial and barrier states, leases,
dynamic profiles, and strict target-repository authority boundaries.*

## 15. Nicht-Ziele / Non-Goals

- keine grafische Desktopoberflaeche und kein Web-Dashboard
- keine Ablösung der Bash- oder PowerShell-Engine
- keine zweite Implementierung von Wartungsphasen
- kein automatisches Committen oder Pushen gewarteter Repositories
- kein automatischer Admin-Elevations- oder Passwortdialog
- kein Einchecken erzeugter Binaerdateien
- keine Mauspflicht
- keine erneute Umsetzung der bereits abgeschlossenen Features 015 bis 017
- keine Spec-Kit-Abarbeitung bei gedriftetem Vorgaenger- oder Series-Nachweis

*The feature is not a desktop or web UI, does not replace or duplicate the
maintenance engines, does not redo predecessor hardening, does not add
repository publication or privilege escalation, and cannot start with drifted
predecessor evidence.*

## 16. Dokumentation und Statistik / Documentation and Statistics

Die Implementierung aktualisiert die vorhandene Manpage und die bilinguale
README-Bedienung fuer die neuen UI-Schalter. Das interne .NET-Hilfsprogramm
erhaelt eine kurze Architektur- und Testbeschreibung. Wird waehrend der
Implementierung ein neues eigenstaendiges Skript eingefuehrt, gelten
Skriptkatalog, Unix-Manpage beziehungsweise vollstaendige
PowerShell-Comment-Based-Help zusaetzlich.

*Implementation updates the existing man page and bilingual README. Any newly
introduced standalone script also follows the repository's catalog and help
requirements.*

Nach abgeschlossenem Feature wird `docs/project-statistics.md` mit dem
vorhandenen Renderer aktualisiert. Statistik- und Abarbeitungsnachweise werden
serialisiert geschrieben und nicht parallel aus mehreren Agentenlaeufen
veraendert.

*The completed feature updates the statistics ledger through its canonical
renderer, with shared evidence writers serialized.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Agentic-Workspace-Maintenance-TUI.md als verbindliche Eingabedatei.

Pruefe vor Feature-Erstellung oder Artefaktaenderung das aktuell erfuellte Vorgaenger-Gate aus Abschnitt 2 erneut. Feature 009 sowie Features 015, 016 und 017 muessen anhand ihrer archivierten Lastenhefte, vollstaendigen Tasks, Completed-Run-States, Plattform- und Exact-Head-Evidence, Merge-/Closeout-Nachweise und des aktuellen Schema-1.1-Series-Reviews weiterhin konsistent abgeschlossen sein. Der Series-Vertrag muss 38 Ziele, drei Roots, 45 Abhaengigkeiten und dieses Lastenheft als einzigen bevorzugten Eligible-Kandidaten ausweisen. Fehlt ein Nachweis oder ist er gedriftet, stoppe ohne Feature, Branch, Specify-Artefakt oder Repository-Aenderung und berichte den fehlenden Nachweis sowie die naechste sichere Aktion.

Wenn das Gate erfuellt ist, erstelle eine Feature-Spezifikation fuer eine plattformuebergreifende, barrierearme Spectre.Console-TUI fuer maintain-agentic-workspace.*. Uebernimm alle Aufruf-, Kompatibilitaets-, Ereignis-, Cache-, Fallback-, Sicherheits-, Barrierefreiheits-, Test- und Abnahmeanforderungen dieses Lastenhefts.

Verbindlich:
- Keine Argumente plus interaktives TTY startet die TUI mit Dry-run als Anfangsauswahl.
- Keine Argumente ohne TTY und alle bestehenden Wartungsparameter behalten den Headless-Vertrag.
- Bash und PowerShell bleiben die alleinigen Wartungs-Engines; keine Wartungslogik wird in C# dupliziert.
- Das interne net10.0-Hilfsprogramm verwendet Spectre.Console und Spectre.Console.Testing 0.57.2 mit Locked Restore, Supply-Chain-Nachweis und content-adressiertem Home-Cache.
- Ein linearer Plaintext-Assistent ist der sichere Fallback bei ungeeignetem Terminal oder nicht verfuegbarem Build.
- Live-Status verwendet den versionierten JSONL-Ereigniskanal, parst keine freien Konsolentexte und leitet Erfolg nie aus stiller Ausgabe ab.
- Der atomare JSON-Abschlussbericht und der Prozess-Exitcode bleiben kanonisch; Widersprueche ergeben RESULT_MISMATCH.
- Die TUI bildet Remote Freshness, Mutation Barrier, sichere Pull-Entscheidungen, Worktree-Leases, dynamische Preset-Profile und wahrheitsgetreues PARTIAL/1 ab.
- Die Windows-, Linux- und Fleet-Vertraege aus Features 015 bis 017 duerfen nicht regressieren.
- Weder die TUI noch dieser Feature-Lauf erteilen der Wartungs-Engine Remote-, Provider-, Bereinigungs- oder Administratorautoritaet fuer Ziel-Repositories.
- Tastatur, NO_COLOR, TERM=dumb, Screenreader-Lesereihenfolge, ASCII-Status und schmale Terminals sind verpflichtend.
- Plane Tests und exakte Gate-Evidenz fuer macOS inklusive Bash 3.2, Ubuntu und Windows mit PowerShell 7.

Starte noch keine Implementierung oder Remote-Schreibaktion.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete autonomous Spec Kit run for Lastenheft_Agentic-Workspace-Maintenance-TUI.md with deliveryAuthority=MergeAndSync.

Use this intake as the binding source and preserve all scope, non-goals, security, accessibility, platform, evidence, and acceptance boundaries. Before feature creation, revalidate Feature 009 and completed Features 015, 016, and 017 through their archived intakes, completed tasks and run states, exact-head and platform evidence, merged closeouts, and the current schema-1.1 Series review. Require 38 targets, three roots, 45 dependencies, and this intake as the single preferred Eligible candidate. Stop without repository changes if any evidence is missing or drifted.

Execute Specify, repeated Clarify, useful checklists, Plan, plan review, Tasks, repeated Analyze, Implement, validation, delivery, and retrospective until their convergence criteria are met. Implement only the cross-platform maintenance TUI and its additive event contract. Keep Bash and PowerShell as the sole maintenance engines. Preserve the Windows, Linux, Remote-Freshness, Mutation-Barrier, safe-pull, Worktree-Lease, dynamic-profile, result, resume, input-isolation, and target-repository authority contracts from Features 015 through 017.

Use .NET 10 with Spectre.Console and Spectre.Console.Testing 0.57.2, locked restore, content-addressed cache, supply-chain evidence, and the specified plaintext fallback. Validate keyboard-only use, NO_COLOR, TERM=dumb, narrow and linear terminals, screen-reader reading order, ASCII status, truthful PARTIAL/1, RESULT_MISMATCH, cancellation, cache failure, malformed events, and exact macOS, Ubuntu, and Windows gates.

Commit, push, create and converge a non-empty PR, merge, remove obsolete feature branches, return locally to main, fetch/prune, pull with fast-forward only, and prove a clean HEAD == origin/main. The narrow admin bypass is authorized only when every technical gate is green, zero actionable review threads remain, and Human Approval is the sole open rule. This authority applies only to delivery of the Level-0 feature; the maintenance engine receives no commit, push, PR, merge, provider, cleanup, secret, or administrator authority for target repositories. Do not start a successor feature.
```
## 18. Abnahme dieses Lastenhefts / Acceptance of This Intake

- Das Lastenheft ist DE zuerst und EN danach aufgebaut.
- Der Status nennt das aktuell erfuellte und vor Laufstart erneut zu pruefende
  Vorgaenger-Gate sichtbar.
- Die Abarbeitungsreihenfolge fuehrt den TUI-Intake auf Position 4 nach den
  abgeschlossenen Features 015 bis 017 und markiert Feature 009 als
  historische Gate-Evidence.
- Aufruf-, Engine-, Ereignis-, Cache-, Fallback-, Barrierefreiheits-,
  Sicherheits- und Testvertraege sind entscheidungsvollstaendig.
- Specify- und Autonomous-Prompt nennen den exakten Dateinamen, pruefen das
  Gate vor jeder Feature- oder Repository-Aenderung und trennen
  Feature-Delivery von Zielrepository-Autoritaet.
- Das Anlegen des Lastenhefts startet weder Feature-Branch noch Spec-Kit-Lauf,
  Implementierung, Commit, Push, Pull Request oder Merge.

*This bilingual intake visibly records its predecessor gate, provides
decision-complete behavioral and quality contracts, includes exact staged and
autonomous prompts, and starts no implementation or delivery action.*

<!-- intake-authoring:end -->
