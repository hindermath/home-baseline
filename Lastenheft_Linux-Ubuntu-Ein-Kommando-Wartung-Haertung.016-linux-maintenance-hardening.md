<!-- intake-authoring:begin -->
# Lastenheft: Linux-/Ubuntu-Haertung der Ein-Kommando-Wartung

**Status:** ReadyForReview
**Zielgruppe / Audience:** Maintainer der `home-baseline`-Wartung und spaetere Spec-Kit-Ausfuehrende / maintainers of the `home-baseline` maintenance flow and later Spec Kit operators
**Profil / Profile:** `home-baseline-lastenheft`
**Repository:** `home-baseline`
**Dokumenttyp / Document type:** Linux-/Ubuntu-spezifischer Spec-Kit-Intake / Linux-/Ubuntu-specific Spec Kit intake
**Version:** 1.2
**Stand / Date:** 2026-07-28
**Delivery Authority:** `LocalImplementation`

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine eigene Linux-/Ubuntu-Haertungsrunde fuer die
Ein-Kommando-Wartung. Grundlage sind die vier Befunde des ersten realen
Ubuntu-Laufs sowie drei zusaetzliche Befunde des realen Wartungslaufs vom
2026-07-28: Eine Homebrew-Installationsschleife verliert Pakete an den
Standardeingabekanal eines interaktiven Unterprozesses, fehlende
Pflichtwerkzeuge beeinflussen den Exitcode nicht, Swift besitzt unter Linux
keinen automatisierten Installationsweg, das fehlerhafte Zusammenspiel ist
nicht durch einen Regressionstest abgesichert, Admin-Prompt-Autoritaet muss
klar von einem erreichten Sollzustand getrennt bleiben, aufloesbare aber nicht
nutzbare CLI-Launcher benoetigen einen eigenen Fehlerstatus, und ein spaeter
abgebrochener Lauf darf keinen veralteten Erfolgsbericht hinterlassen.

*This intake defines a dedicated Linux and Ubuntu hardening round for
one-command maintenance. It preserves the four findings from the first real
Ubuntu run and adds three findings from the real maintenance run on
2026-07-28: input-consuming package-manager children, non-failing required
drift, the missing automated Swift path, absent regression evidence, the need
to distinguish admin-prompt authority from achieved desired state, a separate
state for resolvable but unusable CLI launchers, and interruption-safe final
reporting.*

Der aktuelle Vergleich meldete Swift und weitere Pflichtwerkzeuge weiterhin als
fehlend. Die erfolgreiche Migration auf `home-baseline-source` und das
Entfernen von `home-baseline-tmp` sind dagegen abgeschlossen und erzeugen keine
offene Linux-Haertungsanforderung. Ein einzelner Maschinenzustand bleibt
grundsaetzlich kein Nachweis fuer die Korrektheit des Skripts. Das Dokument
startet weder Implementierung noch Wartung und erteilt keine Autoritaet fuer
Commit, Push, Pull Request oder Merge.

*The current comparison still reported Swift and other required tools as
missing. Migration to `home-baseline-source` and removal of
`home-baseline-tmp`, however, are complete and add no open Linux-hardening
requirement. A single machine state never proves script correctness. This
document starts neither implementation nor maintenance and grants no authority
to commit, push, open a pull request, or merge.*

## 2. Bindende Vorgaenger und Reihenfolge / Binding Predecessors and Order

Historische fachliche Grundlage ist Feature 009 mit dem archivierten Intake
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`
und der daraus entstandenen Wartungsimplementierung. Feature 009 ist kein
aktiver Knoten der aktuellen Intake-Serie mehr. Dieses Lastenheft praezisiert
Linux-/Ubuntu-Defekte, die erst im realen Paketmanagerlauf sichtbar wurden.

*The historical functional baseline is Feature 009 with the archived intake
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`
and its delivered maintenance implementation. Feature 009 is no longer an
active node in the current intake series. This intake specifies Linux and
Ubuntu defects that became visible only in a real package-manager run.*

Die aktive Abarbeitungsreihenfolge fuehrt diesen Intake als Root auf Position 2
nach der Windows-Haertung. Die Windows-Haertung ist kein technischer
Vorgaenger; die serielle Reihenfolge schuetzt gemeinsame Wartungsdateien.
Danach folgt die Preset-/Profil-/Default-Branch-/Worktree-Haertung auf Position
3. Die Wartungs-TUI folgt auf Position 4 und bleibt gesperrt, bis Feature 009
und die aktiven Positionen 1 bis 3 vollstaendig abgeschlossen sind.

*The active order places this root at position 2 after Windows hardening.
Windows hardening is not a technical dependency; serial delivery protects
shared maintenance files. Preset/profile/default-branch/worktree hardening
follows at position 3. The maintenance TUI at position 4 remains blocked until
Feature 009 and active positions 1 through 3 are closed.*

## 3. Ausgangslage / Current State

### 3.1 Verlorene Homebrew-Pakete

Die Formelinstallation in
`scripts/maintain-agentic-brew-apps.sh` liest die Registry-Eintraege ueber die
Standardeingabe einer `while read`-Schleife. Das darin gestartete
`brew install` erbt denselben Eingabekanal. Beim ersten interaktiven Aufruf kann
Homebrew weitere Paketnamen lesen und verwerfen. Die Schleife sieht diese
Zeilen danach nicht mehr; die restlichen Pakete werden weder installiert noch
eindeutig als uebersprungen gemeldet.

*Formula installation reads registry entries through the standard input of a
`while read` loop. The nested `brew install` inherits that input. During the
first interactive invocation, Homebrew can consume and discard later package
names, so the loop neither installs nor clearly reports them.*

### 3.2 Fehlende Pflichtwerkzeuge ohne Fehlerstatus

`compare_cli_scope` sammelt und druckt fehlende CLI-Werkzeuge, liefert fuer
eine nicht leere Required-Menge aber weiterhin Erfolg. Dadurch kann auch die
uebergeordnete Wartung mit Exitcode 0 enden, obwohl der dokumentierte
Required-Sollzustand nicht erreicht ist. Sichtbarer Text und Prozessstatus
widersprechen sich.

*`compare_cli_scope` collects and prints missing CLI tools but still succeeds
for a non-empty required set. The parent maintenance flow can therefore return
exit code 0 even though the required desired state was not reached. Human
output and process status contradict each other.*

### 3.3 Swift ohne automatisierten Linux-Pfad

Swift ist in `scripts/config/required-cli-tools-registry.json` fuer Linux als
Pflichtwerkzeug registriert. Der Registry-Eintrag beschreibt jedoch nur, dass
Linux eine separat konfigurierte Swift-Toolchain benoetigt. Das aktuelle
Installationsmodell bietet dafuer keinen automatisierten Weg. Eine frische
unterstuetzte Ubuntu-Umgebung kann deshalb den versprochenen Ein-Kommando-Zustand
nicht allein durch den Wartungsaufruf erreichen.

*Swift is registered as a required Linux tool, but its registry entry only
states that Linux needs a separately configured toolchain. The current
installation model provides no automated route. A fresh supported Ubuntu
environment therefore cannot reach the promised one-command state through the
maintenance invocation alone.*

### 3.4 Fehlende Regressionsevidence

Die vorhandenen Pruefungen simulieren keinen Homebrew-Prozess, der waehrend der
ersten Installation seine Standardeingabe liest. Ein normaler nicht
interaktiver Mock kann den Fehler deshalb nicht sichtbar machen.

*Existing checks do not simulate a Homebrew process that reads standard input
during the first installation. A normal non-interactive mock therefore cannot
expose the defect.*

### 3.5 Explizite Admin-Prompt-Grenze

Der Unix-Orchestrator besitzt inzwischen `--allow-admin-prompts`. Ohne diese
aktuelle Autoritaet wird die Linux-Toolchain-Mutation als
`DEFERRED_ADMIN_REQUIRED` verschoben und es wird kein `sudo` erzwungen. Diese
Schutzgrenze ist ein erledigter Sicherheitsfortschritt, aber kein Nachweis,
dass der Required-Sollzustand erreicht ist. Der strukturierte Bericht muss
Deferred-Zustand, verbleibenden Drift und konkrete naechste Aktion dauerhaft
auseinanderhalten.

*The Unix orchestrator now provides `--allow-admin-prompts`. Without that
current authority, Linux toolchain mutation is deferred as
`DEFERRED_ADMIN_REQUIRED` and does not force `sudo`. This boundary is a
completed security improvement, but it does not prove the required desired
state. Structured reporting must keep deferral, remaining drift, and the exact
next action distinct.*

### 3.6 Aufloesbare, aber nicht nutzbare CLI und veralteter Erfolgsbericht

Im realen Lauf wurde `pwsh` per Befehlsaufloesung gefunden, der Snap-Launcher
scheiterte im Container jedoch an einer fehlenden `cap_dac_override`-Capability
von `snap-confine`. Eine reine `command -v`-Pruefung unterscheidet diesen Zustand
nicht verlaesslich von einem nutzbaren Werkzeug. Der ungefangene spaetere
Fehlerabbruch liess zudem einen zuvor geschriebenen JSON-Bericht mit
`overallStatus: SUCCESS`, Exitcode 0 und nur den frueher abgeschlossenen Stufen
zurueck. Terminal, Log, Prozessstatus und Bericht konnten dadurch verschiedene
Wahrheiten anzeigen.

*During the real run, command resolution found `pwsh`, but the Snap launcher
failed in the container because `snap-confine` lacked the
`cap_dac_override` capability. Command presence alone cannot reliably
distinguish this from a usable tool. The uncaught late failure also left an
earlier JSON report at `overallStatus: SUCCESS`, exit code 0, and only the
previously completed stages. Terminal, log, process status, and report could
therefore tell different stories.*

## 4. Zielzustand / Target State

Ein Lauf auf einer unterstuetzten Linux-/Ubuntu-Umgebung verarbeitet jeden
ausgewaehlten Registry-Eintrag genau einmal und unabhaengig vom Eingabeverhalten
eines Paketmanager-Unterprozesses. Der Abschluss verifiziert den
Required-Sollzustand. Bleibt ein Pflichtwerkzeug fehlen, melden Skript und
Gesamtwartung einen dokumentierten Nicht-Erfolgsstatus und einen von 0
verschiedenen Exitcode.

*On a supported Linux or Ubuntu environment, one run processes every selected
registry entry exactly once regardless of a package-manager child's input
behavior. Final verification checks the required desired state. If a required
tool remains missing, both the script and the overall maintenance flow report
a documented non-success status and a non-zero exit code.*

Swift besitzt einen sicheren, versionierbaren und automatisierten
Linux-/Ubuntu-Installationsweg. Ein fehlendes Swift wird im selben freigegebenen
Wartungsaufruf installiert und anschliessend erfolgreich geprueft. Nicht
unterstuetzte Distributionen oder Architekturen sowie Installationsfehler
scheitern sichtbar und koennen nicht als erfolgreiche Ein-Kommando-Wartung
gelten.

*Swift has a secure, versionable, automated Linux and Ubuntu installation
route. When Swift is missing, the same authorized maintenance invocation
installs and then verifies it. Unsupported distributions or architectures and
installation failures are explicit failures rather than successful
one-command maintenance.*

Ein Lauf ohne aktuelle Admin-Prompt-Autoritaet veraendert keine
administratorgeschuetzte Toolchain und meldet `DEFERRED_ADMIN_REQUIRED` als
offenen, nicht erfuellten Zustand. Ein vorhandener Befehlsname gilt erst nach
einer begrenzten Funktionsprobe als nutzbar. Jeder normale, fehlerhafte oder
unterbrochene Abschluss finalisiert Bericht und Log atomar mit dem tatsaechlichen
Gesamtstatus; ein alter Erfolgsstatus darf keinen spaeteren Fehler ueberleben.

*A run without current admin-prompt authority changes no administrator-protected
toolchain and reports `DEFERRED_ADMIN_REQUIRED` as an open, unmet state. A
resolved command name counts as usable only after a bounded functional probe.
Every normal, failed, or interrupted completion atomically finalizes report and
log with the actual aggregate status; an earlier success state cannot survive a
later failure.*

## 5. Betroffene Flaechen / Affected Surfaces

Primaer betroffen sind:

- `scripts/maintain-agentic-brew-apps.sh`
- `scripts/config/required-cli-tools-registry.json`
- `scripts/maintain-agentic-workspace.sh`, soweit der Toolchain-Exitcode und
  der Admin-Prompt-, Toolchain-, Abbruch- und Abschlussstatus propagiert werden
- `scripts/lib/agentic_workspace_fleet.py`, soweit Stufen- und Gesamtberichte
  atomar fortgeschrieben oder finalisiert werden
- der Aufruf von `scripts/maintain-powershell-modules.ps1` aus dem Unix-Pfad,
  soweit ein aufloesbares, aber nicht ausfuehrbares `pwsh` begrenzt behandelt
  werden muss
- die vorhandene Linux-Testflaeche und ein isoliertes Homebrew-/CLI-Registry-
  Fixture
- `docs/man/maintain-agentic-brew-apps.1.md`, README und Skriptinventur, soweit
  Installations-, Status- oder Exitcodevertrag geaendert werden
- die plattformuebergreifende Wartungspaket-Propagation, falls kanonische
  Wartungsdateien geaendert werden

*Primary surfaces are the Linux and macOS package-maintenance script, the
required CLI registry, parent status and interruption propagation, atomic fleet
report finalization, bounded invocation of the PowerShell-module step, isolated
Linux regression fixtures, affected documentation, and propagation of changed
canonical maintenance files.*

Gemeinsam genutzte Registry-Felder und Statusvertraege sind auf
PowerShell-/Windows-Paritaet zu pruefen. Die konkrete Linux-Installation und
der stdin-sichere Homebrew-Pfad bleiben in Bash. Eine Anpassung der
PowerShell-Implementierung ist nur erforderlich, wenn ein gemeinsames Schema
oder ein gemeinsamer Statusvertrag betroffen ist.

*Shared registry fields and status contracts require PowerShell and Windows
parity review. The concrete Linux installation and input-safe Homebrew path
remain in Bash. PowerShell changes are required only when a shared schema or
status contract changes.*

## 6. Scope und Nicht-Ziele / Scope and Non-Goals

### In Scope

- stdin-sichere Verarbeitung aller ausgewaehlten Homebrew-Formeln und Casks
- eindeutige Erfassung von Versuch, Erfolg, Fehler und verbleibendem Drift je
  Registry-Eintrag
- fail-closed Required-Pruefung mit konsistentem Skript- und Gesamt-Exitcode
- nicht blockierende, aber sichtbare Meldung optionaler fehlender Werkzeuge
- automatisierter Swift-Installationsweg fuer die unterstuetzten
  Linux-/Ubuntu-Zielprofile
- sichere Herkunfts-, Integritaets- und Versionspruefung des Swift-Pfads
- erneute Verfuegbarkeitspruefung im selben Lauf und idempotenter Zweitlauf
- isolierter Regressionstest mit einem stdin-lesenden, interaktiv simulierten
  Homebrew-Aufruf
- kompatible Check-, Compare- und Dry-run-Ausgabe ohne reale Paketmutation
- explizite und unveraenderte Admin-Prompt-Grenze: ohne
  `--allow-admin-prompts` keine privilegierte Toolchain-Mutation und kein
  vorgetaeuschter Sollzustand
- begrenzte Nutzbarkeitspruefung fuer externe CLI-Launcher mit getrennten
  Zustaenden fuer fehlend, nicht nutzbar, Timeout und Capability-Sperre
- abbruchfeste, atomare Finalisierung von Terminalstatus, Log, Exitcode und
  strukturiertem Bericht

*In scope are input-safe package iteration, per-item result accounting,
fail-closed required checks, non-fatal optional drift, automated and verified
Swift installation on supported Linux targets, same-run verification,
idempotence, an interactive input-consuming Homebrew regression fixture, and
safe check or preview behavior. It also preserves the explicit admin boundary,
distinguishes unusable launchers from missing commands, and finalizes reports
correctly after late failures or interruption.*

### Non-Goals

- keine Neuentwicklung der gesamten Paketmanager- oder Wartungsarchitektur
- keine automatische Installation optionaler Werkzeuge ohne Opt-in
- keine Unterstuetzung jeder beliebigen Linux-Distribution oder Architektur
- kein ungeprueftes `curl | sh` und keine Deaktivierung von TLS-, Signatur-
  oder Pruefsummenpruefungen
- kein Umgehen von `sudo`, Paketmanager-Sperren oder anderen
  Administratorgrenzen
- keine Veraenderung fremder lokaler Dateien, Shell-Profile oder Toolchains
  ausserhalb eines dokumentierten, minimalen Installationsvertrags
- keine Implementierung der Wartungs-TUI
- keine Loesung des separaten Preset-/Profil-/Default-Branch-/Worktree-Intakes
  auf Position 3; dessen exakte Profilmatrix und Retry-Vertrag bleiben dort
- keine Commits, Pushes, Pull Requests oder Merges im Rahmen dieses Authorings

*The work does not redesign all maintenance, install optional tools without
opt-in, promise every Linux distribution or architecture, use unverified
download execution, bypass administrative boundaries, modify unrelated local
state, implement the TUI, solve the separate position-3 preset/profile intake,
or perform Git or remote delivery actions.*

## 7. Atomare Anforderungen / Atomic Requirements

### LUM-001 - Eingabekanal-sichere Registry-Iteration

Die Homebrew-Formel- und Cask-Iteration MUSS die vollstaendige geordnete
Registry-Menge von der Standardeingabe jedes gestarteten Unterprozesses
entkoppeln. Ein `brew install`, das bis EOF von stdin liest, DARF keine spaeteren
Registry-Eintraege konsumieren. Die Loesung DARF nicht davon abhaengen, dass
eine bestimmte Homebrew-Version stdin unangetastet laesst.

*Formula and cask iteration must isolate the complete ordered registry set from
the standard input of every child process. A `brew install` that reads to EOF
must not consume later registry entries. The solution cannot depend on a
particular Homebrew version leaving input untouched.*

### LUM-002 - Vollstaendige Ergebniszuordnung

Fuer jeden ausgewaehlten Registry-Eintrag MUSS genau ein nachvollziehbarer
Endstatus entstehen: bereits vorhanden, erfolgreich installiert, im Dry-run
vorgesehen, fehlgeschlagen oder nach Abschluss weiterhin fehlend. Ein Eintrag
DARF weder lautlos verschwinden noch doppelt installiert werden. Registry-
Reihenfolge und Required-/Optional-Scope bleiben erhalten.

*Every selected registry item must receive exactly one traceable final status:
already present, installed, planned in preview, failed, or still missing after
completion. Items cannot silently disappear or be installed twice. Registry
order and required or optional scope remain stable.*

### LUM-003 - Fail-closed Required-Vergleich

`compare_cli_scope` oder seine klar benannte Nachfolgelogik MUSS bei einer
nicht leeren Missing-Menge fuer `required` einen Fehlerstatus liefern. Die
vollstaendige Missing-Liste wird trotzdem ausgegeben. Eine leere Required-Menge
liefert Erfolg; fehlende optionale Werkzeuge bleiben sichtbar, aber fuer sich
allein nicht fatal.

*The required CLI comparison must fail when its missing set is non-empty while
still printing the complete set. An empty required set succeeds. Missing
optional tools remain visible but are not fatal by themselves.*

### LUM-004 - Konsistente Aggregation und Exitcodes

Der Wartungslauf MUSS Einzelstatus so aggregieren, dass ein nach allen
Installationsversuchen fehlendes Pflichtwerkzeug einen von 0 verschiedenen
Exitcode von `maintain-agentic-brew-apps.sh` erzeugt. Der aufrufende
`maintain-agentic-workspace.sh` MUSS diesen Zustand als Nicht-Erfolg in
Terminalausgabe, Log und strukturiertem Abschlussbericht bewahren und ebenfalls
nicht mit Exitcode 0 enden. Unabhaengige sichere Pruefungen duerfen vor dem
finalen Fehlerabschluss weiterlaufen.

*After all installation attempts, any missing required tool must make the
package script return non-zero. The parent workspace maintenance flow must
preserve that non-success in terminal output, logs, structured summary, and
its own exit code. Independent safe checks may continue before final failure.*

### LUM-005 - Automatisierter Swift-Pfad fuer Linux/Ubuntu

Die Required-CLI-Registry MUSS fuer Swift einen automatisierten
Linux-/Ubuntu-Installationsvertrag enthalten oder auf eine versionierte,
repositoryverwaltete Installationslogik verweisen. Der Pfad MUSS die
unterstuetzte Distribution, Version und Architektur vor Mutation pruefen,
Artefaktherkunft und Integritaet verifizieren, Fehler begrenzen und im selben
Lauf ein nutzbares `swift --version` ermoeglichen. Notwendige
Umgebungsaktivierung darf nicht stillschweigend erst fuer eine neue Shell
wirksam werden.

*The required CLI registry must define an automated Linux and Ubuntu Swift
installation contract or reference versioned repository-managed logic. Before
mutation it validates supported distribution, version, and architecture; it
verifies artifact provenance and integrity, bounds failures, and makes a
working `swift --version` available in the same run. Required environment
activation cannot silently wait for a new shell.*

### LUM-006 - Eindeutige Nicht-Unterstuetzung und Fehlerbehandlung

Ist das erkannte Linux-Profil nicht unterstuetzt oder scheitert der sichere
Swift-Installationspfad, MUSS der Lauf Swift weiterhin als fehlendes
Pflichtwerkzeug melden, eine konkrete naechste Aktion nennen und mit
Nicht-Erfolg enden. Er DARF keine manuelle Vorinstallation als implizite
Voraussetzung eines erfolgreichen Ein-Kommando-Laufs behandeln.

*If the Linux profile is unsupported or secure Swift installation fails, the
run must keep Swift in the missing-required result, name a concrete next
action, and end unsuccessfully. A successful one-command run cannot silently
depend on manual preinstallation.*

### LUM-007 - Interaktiver Homebrew-Regressionstest

Ein isolierter Test MUSS ein kontrolliertes `brew` bereitstellen, dessen erster
`install`-Aufruf stdin bis EOF liest und damit das beobachtete interaktive
Verhalten simuliert. Das Fixture verwendet eine temporaere Registry und
temporaere Befehlsauflosung, veraendert keine reale Homebrew-Installation und
benoetigt kein Netzwerk. Der Test MUSS vor der Korrektur reproduzierbar
fehlschlagen und danach alle Registry-Eintraege und Exitcodes pruefen.

*An isolated test must provide a controlled `brew` whose first install call
reads standard input to EOF, simulating the observed interactive behavior. It
uses a temporary registry and command path, changes no real Homebrew state, and
needs no network. The test must reproduce the old failure and then verify all
registry entries and exit codes after the fix.*

### LUM-008 - Modus-, Plattform- und Dokumentationsvertrag

`--compare-only` und `--dry-run` duerfen keine Pakete installieren. Beide Modi
MUESSEN fehlende Required-Werkzeuge semantisch als Drift beziehungsweise
Nicht-Erfolg sichtbar machen, ohne einen erfolgreichen Istzustand
vorzutaeuschen. Die konkrete Exitcode-Matrix MUSS in Hilfe und Manpage stehen.
Die Korrektur DARF die funktionierende macOS-Formel-/Cask-Verarbeitung nicht
regressieren; gemeinsam geaenderte Vertraege benoetigen Bash-/PowerShell-
Paritaetsevidence.

*Compare-only and dry-run modes install no packages. Both must make missing
required tools visible as drift or non-success without pretending the desired
state is met. Help and the manual document the exact exit-code matrix. The fix
must not regress macOS formula or cask processing, and shared contract changes
need Bash and PowerShell parity evidence.*

### LUM-009 - Admin-Prompt-Autoritaet ist kein Sollzustand

Auf Linux DARF der Orchestrator eine administratorgeschuetzte Toolchain-Mutation
nur nach aktueller, ausdruecklicher `--allow-admin-prompts`-Autoritaet starten.
Fehlt sie, MUSS die Stufe ohne Privilegieneskalation als
`DEFERRED_ADMIN_REQUIRED` enden, verbleibende Required-Werkzeuge und eine
konkrete naechste Aktion nennen und im strukturierten Bericht als offen
erkennbar bleiben. Der Deferred-Zustand DARF weder als installierter Sollzustand
noch als vollstaendig erfolgreiche Ein-Kommando-Wartung gezaehlt werden.

*On Linux, the orchestrator may start administrator-protected toolchain mutation
only with current explicit `--allow-admin-prompts` authority. Without it, the
stage must avoid privilege escalation, end as `DEFERRED_ADMIN_REQUIRED`, name
remaining required tools and an exact next action, and remain visibly open in
the structured report. Deferral cannot count as installed desired state or as
fully successful one-command maintenance.*

### LUM-010 - Begrenzte CLI-Nutzbarkeits- und Capability-Pruefung

Externe Pflichtwerkzeuge MUESSEN mindestens die Zustaende `Missing`,
`Unusable`, `TimedOut` und `CapabilityBlocked` unterscheidbar machen, wenn eine
begrenzte, seiteneffektarme Funktionsprobe dies belegen kann. Ein per
`command -v` gefundener Launcher DARF nicht allein deshalb als nutzbar gelten.
Fehlertext wird begrenzt und secret-frei erfasst; der Fehler eines optionalen
Folgeschritts DARF den Abschlussbericht nicht ungefangen abschneiden. Fuer
`pwsh` MUSS ein Snap-/Container-Capability-Fehler als nicht nutzbare Toolchain
mit naechster Aktion erscheinen.

*Required external tools must distinguish at least `Missing`, `Unusable`,
`TimedOut`, and `CapabilityBlocked` when a bounded, low-side-effect functional
probe can establish that state. A launcher found by `command -v` is not usable
by presence alone. Error evidence is bounded and secret-free, and failure of an
optional follow-up step cannot truncate final reporting. For `pwsh`, a Snap or
container capability failure must become an unusable-toolchain result with a
next action.*

### LUM-011 - Abbruchfeste und atomare Berichtsfinalisierung

Jeder nicht gefangene Stufenfehler, jedes relevante Signal und jeder normale
Abschluss MUSS genau eine Finalisierung ausloesen. Der strukturierte Bericht
MUSS die letzte gestartete beziehungsweise fehlgeschlagene Stufe, den
tatsaechlichen Gesamtstatus, den Prozess-Exitcode und die naechste Aktion
enthalten. Ein Bericht mit `SUCCESS` und Exitcode 0 DARF nach einem spaeteren
Fehler nicht bestehen bleiben. Aktualisierungen verwenden temporaere Dateien
und atomaren Ersatz; Terminal, Log, Report und Prozessstatus MUESSEN denselben
Abschluss abbilden.

*Every uncaught stage error, relevant signal, and normal completion must trigger
exactly one finalization. The structured report must identify the last started
or failed stage, actual aggregate status, process exit code, and next action. A
report at `SUCCESS` and exit code 0 cannot remain after a later failure.
Updates use temporary files and atomic replacement, and terminal, log, report,
and process status must describe the same outcome.*

## 8. Qualitaet und Governance / Quality and Governance

### Sicherheit und Supply Chain / Security and Supply Chain

- Alle Registry- und Plattformwerte werden als Daten behandelt und nicht mit
  `eval` ausgefuehrt.
- Variablen und Pfade bleiben in Bash korrekt gequotet; externe Argumente
  verwenden, wo anwendbar, `--` als Optionsende.
- Downloads verwenden TLS und einen versionierten Integritaetsnachweis wie
  eine gepflegte SHA-256-Pruefsumme oder eine verifizierte Signatur.
- Eine geaenderte Pruefsumme oder unklare Plattformzuordnung scheitert vor
  Ausfuehrung fail-closed.
- Administratorrechte werden weder impliziert noch erzwungen; aktuelle
  Autoritaet, tatsaechliche Privilegien und erreichter Sollzustand bleiben drei
  getrennte Nachweise.
- Funktionsproben externer CLI-Launcher sind zeitlich begrenzt, vermeiden
  Mutation und begrenzen uebernommene Fehlerausgabe.
- Logs, Fixtures und Abschlussberichte enthalten keine Tokens, Zugangsdaten
  oder privaten absoluten Pfade.
- Temporaere Test- und Downloadartefakte werden eng begrenzt und sicher
  bereinigt; vorbestehende Installationen bleiben unangetastet.

*Registry values are data rather than evaluated code. Bash quoting and option
boundaries remain safe. Downloads use TLS plus versioned integrity evidence.
Unknown platforms or changed integrity values fail closed. Admin authority,
actual privileges, and achieved state remain separate evidence; CLI probes are
bounded and low-side-effect. Logs expose no credentials or private paths, and
temporary artifacts remain isolated.*

### Barrierefreiheit und Sprache / Accessibility and Language

Nutzerseitige CLI-Ausgabe folgt WCAG 2.2 AA, soweit auf Textterminals
anwendbar. Erfolg, Warnung, fehlendes Required-Werkzeug und Fehler werden durch
Text und Exitcode vermittelt, nicht nur durch Farbe. Deutsche Meldungen stehen
zuerst; englische Erlaeuterungen folgen in der Dokumentation. Fortschritt darf
Screenreader-Ausgabe nicht laufend ueberschreiben.

*User-facing CLI output follows WCAG 2.2 AA where applicable to text terminals.
Success, warnings, missing required tools, and failures are conveyed by text
and exit status rather than color alone. German comes first, with English
documentation following. Progress must not continuously overwrite screen-reader
output.*

### Kompatibilitaet und Wartbarkeit / Compatibility and Maintainability

- Primaerprofil ist die vom Repository unterstuetzte Ubuntu-Umgebung mit Bash;
  macOS bleibt fuer gemeinsam genutzte Homebrew-Logik im Testumfang.
- Die Implementierung nutzt bestehende Registry- und Wartungsschnittstellen,
  soweit sie den korrigierten Vertrag tragen koennen.
- Neue nicht triviale Schleifen-, Status- und Installationslogik erhaelt kurze
  didaktische Kommentare zum stdin-Risiko, zur Fail-closed-Grenze und zur
  Integritaetsentscheidung.
- Falls ein neues ausfuehrbares Repository-Skript erforderlich ist, gelten
  Skriptkatalog, Manpage, Bash-Stil und vorhandene Distributionsregeln.

*The primary profile is the repository-supported Ubuntu environment with Bash,
while macOS remains in scope for shared Homebrew logic. Existing interfaces are
preferred, non-trivial logic documents its rationale, and any new executable
script follows catalog, manual, style, and distribution rules.*

## 9. Abhaengigkeiten, Risiken und harte Stopps / Dependencies, Risks, and Hard Stops

Abhaengigkeiten sind Bash, Python 3 fuer die vorhandene Registry-Auswertung,
Homebrew oder der bestehende apt-Fallback, die Required-CLI-Registry und der
uebergeordnete Unix-Wartungsorchestrator. Reale Downloads oder Paketinstallationen
sind fuer Regressionstests nicht erforderlich und muessen dort simuliert werden.

*Dependencies are Bash, Python 3 for existing registry parsing, Homebrew or the
existing apt fallback, the required CLI registry, and the parent Unix
maintenance orchestrator. Regression tests require no real downloads or package
installations and must simulate them.*

Harte Stopps gelten bei ungueltiger Registry, unbekanntem Required-Installer,
nicht verifizierbarer Swift-Herkunft oder Integritaet, nicht unterstuetzter
Plattform vor einer Mutation, fehlender Admin-Prompt-Autoritaet vor
privilegierter Mutation, einem Capability-gesperrten Pflichtwerkzeug und bei
einem weiterhin fehlenden Pflichtwerkzeug nach Abschluss der
Installationsphase. Ein harter Stopp verhindert abhaengige Mutation, aber nicht
vollstaendige Fehlerausgabe, Berichtsfinalisierung und sichere read-only
Evidence.

*Hard stops apply to invalid registry data, unknown required installers,
unverifiable Swift provenance or integrity, unsupported platforms before
mutation, absent admin-prompt authority before privileged mutation,
capability-blocked required tools, and required tools still missing after
installation. A hard stop blocks dependent mutation but not complete reporting,
report finalization, or safe read-only evidence.*

Wesentliche Risiken sind ein unbeabsichtigter Eingabekanal zur echten
Terminalsession, eine zu fruehe Fehlerbeendigung ohne vollstaendige Missing-
Liste, ein Exitcodeverlust im Orchestrator, ein als Erfolg stehenbleibender
Teilbericht, ein nur syntaktisch vorhandener CLI-Launcher, veraltete
Swift-Downloadmetadaten und eine PATH-Aenderung, die erst in einer neuen Shell
wirkt. Isolierte Positiv-, Negativ-, Signal-, Timeout- und Idempotenztests
muessen diese Risiken abdecken.

*Main risks are accidental attachment to the real terminal input, early exit
without the complete missing list, parent exit-code loss, a partial report left
at success, a launcher that is present but unusable, stale Swift download
metadata, and PATH activation that works only in a new shell. Isolated positive,
negative, signal, timeout, and idempotence tests must cover these risks.*

## 10. Erwartete Artefakte und Evidence / Expected Artifacts and Evidence

Die spaetere Implementierung liefert mindestens:

- eine fokussierte stdin-sichere Korrektur der Formel- und, soweit betroffen,
  Cask-Iteration in `scripts/maintain-agentic-brew-apps.sh`
- eine fail-closed Required-Statusaggregation bis zum Exitcode von
  `scripts/maintain-agentic-workspace.sh`
- einen versionierten und integritaetsgeprueften Swift-Installationsvertrag fuer
  die unterstuetzten Linux-/Ubuntu-Profile
- ein isoliertes Regressionstest-Fixture mit stdin-lesendem Homebrew-Mock und
  mehreren aufeinanderfolgenden Paketen
- Positiv-, Negativ-, Dry-run-, Compare-, Fehlerpropagations- und
  Idempotenztests ohne reale Paketmutation
- ein Linux-Fixture fuer fehlende Admin-Prompt-Autoritaet, das keine
  Privilegieneskalation zulaesst und `DEFERRED_ADMIN_REQUIRED` als offenen
  Zustand prueft
- ein `pwsh`-/Snap-Fixture fuer aufloesbare, aber Capability-gesperrte Launcher
  sowie Timeout- und Nicht-Nutzbar-Status
- Fehler- und Signal-Fixtures, die einen Abbruch nach frueheren erfolgreichen
  Stufen erzwingen und die atomare Nicht-Erfolgsfinalisierung pruefen
- aktualisierte Hilfe, Manpage, README-, Registry- und Skriptinventurtexte,
  soweit der oeffentliche Vertrag betroffen ist
- bei kanonischen Wartungsdateien eine Vorschau, Anwendung und abschliessende
  Homogenitaetspruefung der vorgesehenen Propagation ohne implizite Commits
  oder Pushes
- die gemaess Repository-Guidance aktualisierte Projektstatistik

*Later implementation provides a focused input-safe loop fix, fail-closed
required status propagation, a versioned and integrity-checked Swift installer
contract, an isolated stdin-consuming Homebrew fixture, admin-boundary and
unusable-launcher fixtures, interruption-safe report tests, positive and
negative mode or idempotence tests, synchronized public documentation, safe
propagation evidence where applicable, and updated project statistics.*

## 11. Abnahmekriterien / Acceptance Criteria

- **AC-001:** Eine temporaere Registry enthaelt mindestens drei fehlende
  Required-Formeln in bekannter Reihenfolge. Der erste simulierte interaktive
  `brew install`-Aufruf liest stdin bis EOF. Trotzdem wird jede der drei
  Formeln genau einmal und in Registry-Reihenfolge aufgerufen.
- **AC-002:** Das Homebrew-Fixture protokolliert fuer jeden Eintrag genau einen
  Endstatus. Kein Name verschwindet; ein zweiter idempotenter Lauf meldet alle
  zuvor erfolgreichen Eintraege als vorhanden und startet keine Installation.
- **AC-003:** Ein Fixture mit zwei fehlenden Required-CLI-Werkzeugen gibt beide
  IDs aus und laesst den Required-Vergleich fehlschlagen. Eine leere
  Required-Menge liefert Erfolg.
- **AC-004:** Bleibt nach simulierten Installationsversuchen ein
  Pflichtwerkzeug fehlen, enden `maintain-agentic-brew-apps.sh` und der
  aufrufende Wartungsorchestrator mit einem dokumentierten Nicht-Null-Exitcode.
  Terminal, Log und strukturierter Bericht nennen denselben Nicht-Erfolgsstatus.
- **AC-005:** Ein ausschliesslich fehlendes optionales Werkzeug wird sichtbar
  gemeldet, fuehrt ohne weiteren Fehler aber nicht zum Required-Fehlerstatus.
- **AC-006:** Auf einem unterstuetzten Ubuntu-Fixture ohne Swift waehlt der
  freigegebene Wartungslauf den automatisierten Swift-Pfad. Herkunft und
  Integritaet werden vor Ausfuehrung geprueft; danach besteht `swift --version`
  noch im selben Prozesskontext.
- **AC-007:** Ein nicht unterstuetztes Linux-/Architektur-Fixture, eine
  veraenderte Swift-Pruefsumme und ein fehlgeschlagener Swift-Installer enden
  jeweils vor unsicherer Folgeausfuehrung mit sichtbarer naechster Aktion und
  Nicht-Null-Exitcode.
- **AC-008:** `--compare-only` und `--dry-run` veraendern weder Paketbestand
  noch Benutzerprofile. Fehlende Required-Werkzeuge bleiben in Ausgabe und
  dokumentiertem Status erkennbar; die Exitcode-Matrix stimmt mit Hilfe und
  Manpage ueberein.
- **AC-009:** Der interaktive Regressionstest verwendet nur temporaere
  Registry-, PATH- und Logpfade, greift nicht auf Netzwerk oder echtes Brew zu
  und kann in Linux-CI deterministisch wiederholt werden.
- **AC-010:** Die passenden macOS-Fixtures verarbeiten Formeln und Casks
  weiterhin vollstaendig. Gemeinsam geaenderte Registry- oder Berichtsschemas
  bestehen die vorhandenen Bash-/PowerShell-Paritaetspruefungen.
- **AC-011:** `bash -n` fuer alle geaenderten Bash-Dateien, die fokussierten
  Regressionstests, der Intake-Receipt-Validator und betroffene
  Homogenitaetspruefungen sind erfolgreich.
- **AC-012:** Keine Ausgabe oder Evidence enthaelt Secrets oder private
  absolute Pfade. Status bleiben ohne Farbe und in linearer Screenreader-Ausgabe
  unterscheidbar.
- **AC-013:** Ein Linux-Fixture ohne `--allow-admin-prompts` bietet einen
  installierbaren Required-Tool-Drift an. Es erfolgt kein `sudo`- oder anderer
  privilegierter Aufruf; Stufe, Abschlussbericht und naechste Aktion enthalten
  `DEFERRED_ADMIN_REQUIRED`, und der Sollzustand bleibt ausdruecklich offen.
- **AC-014:** Ein temporaerer `pwsh`-Launcher ist per `command -v` auffindbar,
  scheitert aber mit einer simulierten `snap-confine`-/Capability-Meldung. Der
  Lauf klassifiziert ihn begrenzt und secret-frei als `CapabilityBlocked`
  beziehungsweise `Unusable`, startet keine abhaengige PowerShell-Mutation und
  finalisiert den Bericht. Ein haengender Launcher wird deterministisch als
  `TimedOut` begrenzt.
- **AC-015:** Ein Fixture erzwingt nach mindestens zwei erfolgreichen Stufen
  einen spaeten Stufenfehler sowie separat `INT` und `TERM`. In keinem Fall
  bleibt `overallStatus: SUCCESS` mit Exitcode 0 bestehen. JSON-Bericht, Log,
  Terminalstatus und Prozess-Exitcode nennen konsistent die letzte
  fehlgeschlagene oder unterbrochene Stufe; es bleibt keine teilweise
  geschriebene JSON-Datei.

*Acceptance proves complete ordered processing despite a stdin-consuming first
install, exact per-item accounting, fail-closed required checks and parent exit
codes, non-fatal optional drift, safe same-run Swift installation, clear
unsupported or integrity failures, mutation-free preview modes, an explicit
non-privileged deferral path, bounded unusable-launcher classification,
interruption-safe atomic final reporting, isolated CI fixtures, macOS and
shared-contract parity, syntax and regression checks, and accessible
secret-free evidence.*

## 12. Annahmen und offene Fragen / Assumptions and Open Questions

Annahmen:

- Die Befunde stammen aus einem Ubuntu-Lauf; andere Linux-Profile sind nur
  verpflichtend, wenn der bestehende Plattformvertrag sie ausdruecklich als
  unterstuetzt ausweist.
- Die aktuellen Quellstellen liegen beim Authoring in
  `scripts/maintain-agentic-brew-apps.sh` im Bereich von
  `compare_cli_scope` und `install_brew_items`; Anforderungen binden an das
  Verhalten und bleiben auch nach Zeilenverschiebungen gueltig.
- Der aktuelle Rechner meldet Swift und weitere Required-Werkzeuge als fehlend;
  dieser Zustand darf fuer Tests weder als feste Vorbedingung noch als
  Abschlussnachweis verwendet werden. Fixtures bilden fehlende, nutzbare und
  Capability-gesperrte Ausgangszustaende isoliert nach.
- Der heutige `DEFERRED_ADMIN_REQUIRED`-Pfad bestaetigt die Schutzgrenze, nicht
  die vollstaendige Erfuellung des Toolchain-Sollzustands.
- Der Preset-Profil-Drift und dessen Netzwerkwiederholung bleiben bindender
  Kontext des separaten Position-3-Intakes und werden hier nicht dupliziert.
- `LocalImplementation` erlaubt nur lokale Implementierung und Validierung im
  aktuellen Repository.

*Assumptions are that the findings originate on Ubuntu, source line numbers are
evidence rather than permanent interfaces, tests must not rely on the current
machine state, admin deferral proves only the security boundary, preset-profile
drift remains in the position-3 intake, and LocalImplementation permits only
local work in this repository.*

Offene materielle Fragen: keine.

*Open material questions: none.*

## 13. Abschlussgrenze / Completion Boundary

Die Linux-/Ubuntu-Haertungsrunde ist erst abgeschlossen, wenn alle
Abnahmekriterien mit lokaler, reproduzierbarer Evidence bestanden sind und kein
offener High-Severity-Befund fuer stdin-sichere Paketiteration, Required-
Exitcodepropagation, den Swift-Installationsweg, die Admin-Prompt-Grenze,
CLI-Nutzbarkeit oder die abbruchfeste Berichtsfinalisierung verbleibt. Weder
`DEFERRED_ADMIN_REQUIRED` noch ein zufaellig reparierter oder defekter
Maschinenzustand zaehlen ohne isolierte Regressionstests als
Abschlussnachweis. Die Migration nach `home-baseline-source` und das Entfernen
von `home-baseline-tmp` sind abgeschlossen und gehoeren nicht zu den offenen
Abnahmepunkten. Mit der aktuellen `LocalImplementation`-Authority endet ein
spaeterer Autonomous-Lauf vor Commit, Push, Pull Request oder Merge.

*The Linux and Ubuntu hardening round is complete only when every acceptance
criterion passes with local reproducible evidence and no high-severity finding
remains for input-safe iteration, required exit-code propagation, automated
Swift installation, the admin boundary, CLI usability, or interruption-safe
report finalization. Neither `DEFERRED_ADMIN_REQUIRED` nor an accidentally
repaired or broken machine state is completion evidence without isolated
regression tests. The source migration and temporary-link removal are complete
and not open acceptance items. Under LocalImplementation authority, a later
Autonomous run stops before commit, push, pull request, or merge.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md Erstelle die Spezifikation ausschliesslich aus diesem Intake und der historischen Feature-009-Baseline. Bewahre LUM-001 bis LUM-011, AC-001 bis AC-015, die Root-Position 2, die nachfolgende Position-3-Haertung, die TUI-Sperre bis zum Abschluss von Feature 009 und der aktiven Positionen 1 bis 3 sowie alle Sicherheits-, Admin-Autoritaets-, Capability-, Supply-Chain-, A11Y-, Exitcode-, Berichts- und Plattformgrenzen. Implementiere nichts, veraendere keine Remote-Zustaende und starte keinen Autonomous- oder Parallel-Autonomous-Lauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md Fuehre den vollstaendigen Spec-Kit-Lauf gebunden an diesen Intake mit deliveryAuthority=LocalImplementation aus. Bewahre LUM-001 bis LUM-011, AC-001 bis AC-015, die Root-Position 2, die separate nachfolgende Position-3-Haertung und die TUI-Sperre bis zum Abschluss von Feature 009 und der aktiven Positionen 1 bis 3. Implementiere und validiere lokal bis zur definierten Abschlussgrenze einschliesslich Admin-Autoritaets-, Capability- und abbruchfester Berichtstests. Stoppe bei fehlender historischer Baseline-Evidence oder einem harten Stopp. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
