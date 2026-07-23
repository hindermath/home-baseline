<!-- intake-authoring:begin -->
# Lastenheft: Agentic-Workspace-Wartungs-TUI

**Repository:** `home-baseline`
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** wartend; Abarbeitung durch hartes Vorgaenger-Gate gesperrt
**Stand:** 2026-07-20
**Verbindliche Vorgaenger / Binding predecessors:**
1. `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`
2. `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md`
3. `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md`
4. `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md`

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
`$speckit-autonomous`-Prompt bereit. Beide unterliegen demselben harten
Vorgaenger-Gate.

*Creating this document starts no Spec Kit run. Copyable staged and autonomous
entry points are provided at the end, and both are subject to the same hard
predecessor gate.*

## 2. Hartes Vorgaenger-Gate / Hard Predecessor Gate

Die fachliche Abarbeitung dieses Lastenhefts DARF erst beginnen, wenn alle vier
in der aktiven Reihenfolge vorangestellten Wartungs- und Haertungsintakes
nachweislich vollstaendig umgesetzt und validiert wurden. Die Existenz der
Vorgaenger-Lastenhefte oder begonnener Feature-Spezifikationen genuegt nicht.

*Processing this intake MUST NOT begin until all four preceding maintenance
and hardening intakes in the active order have demonstrably been implemented
and validated in full. Merely having the predecessor documents or started
feature specifications is insufficient.*

Vor Feature-, Branch- oder Artefakterstellung fuer die TUI muessen alle
folgenden Nachweise gemeinsam vorliegen:

1. Jedes der vier zu den Vorgaengern gehoerenden Features ist eindeutig ueber
   seine `spec.md`-Referenz auf das jeweilige Vorgaenger-Lastenheft
   identifizierbar.
2. Fuer jeden Vorgaenger sind alle verpflichtenden Tasks abgeschlossen;
   Requirements-Checklisten und Analyze enthalten keinen offenen blockierenden
   Befund.
3. Bei einem autonomen Vorgaengerlauf ist dessen
   `autonomous-run-state.json` gueltig und `Completed`. Bei einem schrittweisen
   Lauf belegen die jeweiligen Feature-Artefakte und Abschlussnachweise
   denselben terminalen Zustand.
4. Die Akzeptanznachweise fuer macOS, Linux/Ubuntu und Windows sind vorhanden.
   Dazu gehoeren macOS-Bash 3.2, modernes Bash und PowerShell 7.
5. Desired-State-Fleet-Manifest, sicheres Clone-on-missing, fortsetzbare
   Phasen, optionale Paketklassifikation, fortsetzbare Administratorbefunde,
   leise Git-Ausgabe und kompakter JSON-Abschlussbericht sind implementiert
   und validiert.
6. Der gemaess ausdruecklich erteilter Delivery Authority geschuldete
   Lieferabschluss ist erfolgt. Bei Remote-Auslieferung sind Merge,
   Standardbranch-Synchronisation und die geforderten Paritaetsnachweise
   abgeschlossen.
7. Der Wartungsbaum ist frei von nicht zugeordnetem Drift, der die
   TUI-Schnittstelle oder deren Tests unzuverlaessig machen wuerde.

*The gate requires four identifiable predecessor features, completed tasks
and quality findings, terminal staged or autonomous evidence, all required
platform validation, the complete maintenance-engine contract plus its three
hardening rounds, authorized delivery closeout, and a trustworthy repository
state.*

Fehlt auch nur ein Nachweis, ist das Gate `BLOCKED`. Der TUI-Lauf meldet die
fehlenden Nachweise und stoppt vor Feature-Branch, Specify, Plan, Tasks,
Implementierung oder sonstigen Repository-Aenderungen. Eine Umgehung durch
Adminrechte, manuelle Statusbehauptung oder Ruleset-Bypass ist unzulaessig.

*If any evidence is missing, the gate is `BLOCKED`. The TUI run reports the
missing evidence and stops before feature creation or repository changes. It
cannot be bypassed through administrative rights or an unsupported status
claim.*

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

Der JSON-Abschlussbericht aus dem Vorgaenger bleibt der kanonische
Maschinenabschluss. `run-completed` nennt dessen Pfad, Logpfad, Gesamtstatus
und Exitcode. Widersprechen sich Ereignis und Prozess-Exitcode, hat der
Prozess-Exitcode Vorrang und die TUI meldet `RESULT_MISMATCH`.

*The predecessor's JSON closeout report remains canonical. The process exit
code wins over contradictory event data and produces a visible mismatch
finding.*

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

Spectre.Console und Spectre.Console.Testing werden auf `0.55.0` festgelegt.
`RestorePackagesWithLockFile` und Locked Restore sind verpflichtend.
Abhaengigkeitsaktualisierungen erfolgen nur als eigene nachvollziehbare
Aenderung mit Lizenz-, Wartungs- und Schwachstellenpruefung.

*Spectre.Console dependencies are pinned to 0.55.0 with locked restore.
Dependency upgrades require a separate supply-chain review.*

Der Plaintext-Assistent besitzt denselben Auswahl-, Konflikt-, Vorschau- und
Bestaetigungsvertrag wie die TUI. Er verwendet nur zeilenorientierte Prompts
und ASCII-Status. Er ist kein vereinfachter unsicherer Ausfuehrungspfad.

*The plain assistant implements the same selection and safety contract through
line-oriented ASCII prompts.*

## 9. Live-Dashboard / Live Dashboard

Die normale Spectre-Ansicht zeigt:

- Laufmodus, Plattform, Quelle und Home-Verzeichnis
- aktuelle Phase und textuellen Status
- Anzahl geplanter, laufender, erfolgreicher, uebersprungener und
  fehlgeschlagener Repository-Ziele
- Anzahl Warnungen, Drift-, Admin- und Betriebsbefunde
- zuletzt abgeschlossenes Ziel beziehungsweise letzte sichere Aktion
- Log- und Berichtspfade nach Abschluss

*The normal view shows the run context, current phase, repository counts,
findings, latest safe action, and final evidence paths.*

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
- Maschinenstatus wird mit ASCII-Text wie `RUNNING`, `OK`, `WARNING`,
  `DEFERRED`, `FAILED` und `SKIPPED` ergaenzt.
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

*The TUI never requests secrets or administrator credentials, preserves
deferred administrator findings, sanitizes markup, restricts local evidence,
and delegates path security to the canonical engine.*

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
- Drift mit Exitcode `1`
- Betriebsfehler mit Exitcode `2`
- reparierten Drift mit Exitcode `3`
- `DEFERRED_ADMIN_REQUIRED`
- partiellen Lauf mit unabhaengiger Fortsetzung
- ungueltiges JSONL, Sequenzluecke und unbekannte Schema-Version
- Widerspruch zwischen `run-completed` und Prozess-Exitcode
- langsame Ausgabe und `Ctrl+C`

*A deterministic fake engine covers all terminal results, resumable findings,
malformed events, result mismatch, slow output, and interruption.*

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
  Implementierungsaenderung, solange der Vorgaenger nicht abgeschlossen ist.

*Acceptance preserves headless behavior, delegates all maintenance, proves the
event and fallback contracts, covers accessibility and all platforms, and
enforces the predecessor gate before any TUI feature work.*

## 15. Nicht-Ziele / Non-Goals

- keine grafische Desktopoberflaeche und kein Web-Dashboard
- keine Ablösung der Bash- oder PowerShell-Engine
- keine zweite Implementierung von Wartungsphasen
- kein automatisches Committen oder Pushen gewarteter Repositories
- kein automatischer Admin-Elevations- oder Passwortdialog
- kein Einchecken erzeugter Binaerdateien
- keine Mauspflicht
- keine Spec-Kit-Abarbeitung vor Abschluss des Vorgaengers

*The feature is not a desktop or web UI, does not replace or duplicate the
maintenance engines, does not add repository publication or privilege
escalation, and cannot start before its predecessor is complete.*

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

Pruefe vor Feature-Erstellung oder Artefaktaenderung das harte Vorgaenger-Gate aus Abschnitt 2. Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md, Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md, Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md und Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md muessen jeweils nachweislich vollstaendig implementiert, fuer ihren Scope validiert und gemaess ihrer Delivery Authority abgeschlossen sein. Fehlt ein Nachweis, stoppe ohne Feature, Branch, Specify-Artefakt oder Repository-Aenderung und berichte die fehlenden Gate-Nachweise.

Wenn das Gate erfuellt ist, erstelle eine Feature-Spezifikation fuer eine plattformuebergreifende, barrierearme Spectre.Console-TUI fuer maintain-agentic-workspace.*. Uebernimm alle Aufruf-, Kompatibilitaets-, Ereignis-, Cache-, Fallback-, Sicherheits-, Barrierefreiheits-, Test- und Abnahmeanforderungen dieses Lastenhefts.

Verbindlich:
- Keine Argumente plus interaktives TTY startet die TUI mit Dry-run als Anfangsauswahl.
- Keine Argumente ohne TTY und alle bestehenden Wartungsparameter behalten den Headless-Vertrag.
- Bash und PowerShell bleiben die alleinigen Wartungs-Engines; keine Wartungslogik wird in C# dupliziert.
- Das interne net10.0-Hilfsprogramm verwendet Spectre.Console 0.55.0 mit Locked Restore und content-adressiertem Home-Cache.
- Ein linearer Plaintext-Assistent ist der sichere Fallback bei ungeeignetem Terminal oder nicht verfuegbarem Build.
- Live-Status verwendet den versionierten JSONL-Ereigniskanal und parst keine freien Konsolentexte.
- Exitcodes, Ctrl+C, ungueltige Ereignisse und widerspruechliche Abschlussdaten folgen dem Lastenheft.
- Tastatur, NO_COLOR, TERM=dumb, Screenreader-Lesereihenfolge, ASCII-Status und schmale Terminals sind verpflichtend.
- Plane Tests und exakte Gate-Evidenz fuer macOS inklusive Bash 3.2, Ubuntu und Windows mit PowerShell 7.

Starte noch keine Implementierung oder Remote-Schreibaktion.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Agentic-Workspace-Maintenance-TUI.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Pruefe vor Feature-Erstellung das harte Gate fuer die aktiven Vorgaengerpositionen 1 bis 4 und stoppe ohne Aenderung, falls auch nur ein Abschlussnachweis fehlt. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```
## 18. Abnahme dieses Lastenhefts / Acceptance of This Intake

- Das Lastenheft ist DE zuerst und EN danach aufgebaut.
- Der Status nennt das harte Vorgaenger-Gate sichtbar.
- Die Abarbeitungsreihenfolge fuehrt den TUI-Intake auf Position 5 nach allen
  vier Wartungs- und Haertungsintakes und markiert das harte Gate.
- Aufruf-, Engine-, Ereignis-, Cache-, Fallback-, Barrierefreiheits-,
  Sicherheits- und Testvertraege sind entscheidungsvollstaendig.
- Specify- und Autonomous-Prompt nennen den exakten Dateinamen und pruefen das
  Gate vor jeder Feature- oder Repository-Aenderung.
- Das Anlegen des Lastenhefts startet weder Feature-Branch noch Spec-Kit-Lauf,
  Implementierung, Commit, Push, Pull Request oder Merge.

*This bilingual intake visibly records its predecessor gate, provides
decision-complete behavioral and quality contracts, includes exact staged and
autonomous prompts, and starts no implementation or delivery action.*

<!-- intake-authoring:end -->
