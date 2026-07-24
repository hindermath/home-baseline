<!-- intake-authoring:begin -->
# Lastenheft: Plattformuebergreifende Ein-Kommando-Wartung

**Repository:** `home-baseline`
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer einen spaeteren Spec-Kit-Lauf
**Stand:** 2026-07-24
**Vorgaenger:** `Lastenheft_agentische-umgebung-pruefen-und-syncen.md`

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt die Weiterentwicklung der vorhandenen
Workspace-Wartung zu einem sicheren, fortsetzbaren und weitgehend
unbeaufsichtigten Ein-Kommando-Ablauf fuer macOS, Linux/Ubuntu und Windows.
Der Ablauf soll den Level-0-Checkout aktualisieren, die lokale Home-Baseline
synchronisieren, fehlende aktive Level-1-/Level-2-Repositories kontrolliert
klonen, vorhandene Repositories per Fast-Forward aktualisieren, die kanonischen
Wartungsartefakte pruefen beziehungsweise propagieren und die passende
Plattform-Toolchain warten.

*This requirements document describes the evolution of the existing workspace
maintenance into a safe, resumable, and largely unattended one-command flow for
macOS, Linux/Ubuntu, and Windows. The flow updates the Level 0 checkout,
synchronizes the local home baseline, safely clones missing active Level 1 and
Level 2 repositories, fast-forwards existing repositories, checks or propagates
the canonical maintenance package, and maintains the matching platform
toolchain.*

Das Lastenheft startet weder einen Spec-Kit-Lauf noch eine Wartung. Es stellt
am Ende zwei alternative, kopierbare Einstiege bereit: einen schrittweisen
`/speckit-specify`-Prompt und einen vollstaendigen `$speckit-autonomous`-Prompt.

*This document starts neither a Spec Kit run nor maintenance. It provides two
alternative copyable entry points at the end: a staged `/speckit-specify`
prompt and a complete `$speckit-autonomous` prompt.*

## 2. Abloesung und Ausgangslage / Supersession and Current State

Dieses Lastenheft loest
`Lastenheft_agentische-umgebung-pruefen-und-syncen.md` als aktiven Intake ab.
Der Vorgaenger bleibt als historischer Nachweis erhalten, verwendet aber noch
den alten Hostpfad `~/home-baseline-tmp`, fokussiert vor allem die Pruefung
vorhandener Repositories und definiert noch keinen belastbaren
Clone-on-missing-, Fortsetzungs- oder Maschinenbericht-Vertrag.

*This document supersedes
`Lastenheft_agentische-umgebung-pruefen-und-syncen.md` as the active intake.
The predecessor remains as historical evidence, but still uses the former host
path `~/home-baseline-tmp`, mainly focuses on inspecting existing repositories,
and does not define a reliable clone-on-missing, continuation, or
machine-reporting contract.*

Die aktuelle Wartungsflaeche besteht insbesondere aus:

- `scripts/maintain-agentic-workspace.sh` und `.ps1`
- `scripts/sync-home.sh` und `.ps1`
- `scripts/propagate-agentic-toolchain-maintenance.sh` und `.ps1`
- `scripts/maintain-agentic-brew-apps.sh`
- `scripts/maintain-agentic-winget-apps.ps1`
- `scripts/maintain-powershell-modules.ps1`
- den Registries unter `scripts/config/`
- dem Preset-Profilkatalog
  `scripts/config/spec-kit-preset-profiles.json`
- dem aktuellen Zehn-Preset-Profil
  `scripts/config/spec-kit-intake-authoring-governance-presets.json`
- der lokalen operativen Registry
  `~/.home-baseline/level2-repository-registry.json`

*The current maintenance surface consists of the cross-platform workspace,
home-sync, propagation, package-manager, PowerShell-module, and registry
scripts listed above.*

Der verifizierte lokale Bestand umfasst derzeit 32 registrierte aktive
Level-1-/Level-2-Ziele: sieben Level-1- und 25 Level-2-Repositories. Unter dem
nicht selbst gitbasierten Sammelordner `~/SpecKitPresetProjects` sind aktuell
drei Git-Repositories ausgecheckt. Das bestehende Profil
`intake-authoring-ten-governance-presets` definiert zehn gewuenschte
Preset-Pakete; die sieben fehlenden Repositories sind nach erfolgreicher
Manifestvalidierung kontrollierte Clone-on-missing-Ziele. Level 0 wird weiterhin
ueber den gemeinsamen Source-Resolver auf `~/home-baseline-source` aufgeloest
und nicht als zweiter Checkout im Fleet-Manifest dupliziert.

*The verified local inventory currently contains 32 active registered Level 1
and Level 2 targets: seven Level 1 and 25 Level 2 repositories. Three Git
repositories are currently checked out below the collection directory
`~/SpecKitPresetProjects`, which is not itself a Git repository. The existing
`intake-authoring-ten-governance-presets` profile defines ten desired preset
packages; the seven missing repositories become controlled clone-on-missing
targets after successful manifest validation. Level 0 continues to resolve
through the shared source resolver to `~/home-baseline-source` and is not
duplicated as a second checkout in the fleet manifest.*

## 3. Erkenntnisse aus dem fehlgeschlagenen Wartungslauf / Failed-Run Findings

Der Lauf
`~/.home-baseline/logs/agentic-workspace-20260720-143502.log` endete im echten
No-op-Pfad von `sync-home.sh` mit:

```text
sync-home.sh: line 238: changed_paths[@]: unbound variable
```

Die Ursache ist ein leerer `changed_paths`-Array unter dem auf macOS
vorinstallierten Bash 3.2 in Verbindung mit `set -u`. Der Fehler trat erst nach
erfolgreicher Level-0-Pruefung und inhaltlich erfolgreichem Home-Sync-No-op auf.
Durch den sofortigen Prozessabbruch wurden Repository-Flotte, Propagation und
Toolchain in diesem Lauf nicht mehr bewertet.

*The run failed in the real `sync-home.sh` no-op path because an empty
`changed_paths` array is unsafe with the macOS system Bash 3.2 and `set -u`.
Level 0 and the semantic home-sync no-op had already succeeded, but the abrupt
process termination prevented evaluation of the repository fleet,
propagation, and toolchain.*

Die konkrete Empty-Array-Korrektur und ihre Regressionstests wurden mit PR #90
bereits ausgeliefert und sind fuer dieses Feature verbindliche Baseline. Der
spaetere Wartungslauf darf sie nicht erneut als offene Produktkorrektur
implementieren, sondern MUSS sie in den erweiterten Orchestrator integrieren,
erneut pruefen und vor Regression schuetzen.

*The concrete empty-array correction and its regression tests were already
delivered through PR #90 and are a binding baseline for this feature. The later
maintenance run must not implement them again as open product work; it must
integrate, revalidate, and preserve them within the broader orchestrator.*

Daraus folgen verbindlich:

- Jeder Wartungsabschnitt MUSS seinen Exitcode und Status erfassen, bevor die
  Orchestrierung ueber Fortsetzung oder Abbruch entscheidet.
- Ein Fehler DARF nur abhaengige Folgeschritte sperren. Unabhaengige
  Read-only-Pruefungen und sicher fortsetzbare Wartungsschritte SOLLEN
  weiterlaufen.
- Ein unerwarteter Unterprozessfehler DARF den finalen JSON-Bericht und den
  Hinweis auf die vollstaendige Logdatei nicht verhindern.
- Das Abschlussresultat MUSS zwischen `SUCCESS`, `SUCCESS_WITH_WARNINGS`,
  `DRIFT`, `PARTIAL` und `FAILED` unterscheiden.
- Der sichtbare Terminalfehler MUSS Abschnitt, Ziel, Exitcode, Kurzursache und
  Logpfad nennen.
- No-op-Pfade sind eigenstaendige Regressionstests und duerfen nicht nur
  indirekt durch Aenderungslaeufe abgedeckt werden.

*Each stage must capture its result before orchestration decides whether to
continue. A failed stage blocks only its dependants, final JSON and log
references remain available, terminal status is explicit, and no-op paths are
first-class regression scenarios.*

## 4. Zielbild und Scope / Target State and Scope

### In Scope

- Funktionsparitaet unter macOS, Linux/Ubuntu und Windows
- Bash-3.2- und modernes-Bash-Vertraeglichkeit der Unix-Einstiege
- PowerShell-7-Paritaet der Windows-Einstiege
- ein versioniertes Desired-State-Fleet-Manifest
- Nutzung des vorhandenen Preset-Profilkatalogs und des aktuellen
  Zehn-Preset-Profils als verbindliche Eingabe
- kontrolliertes Clone-on-missing fuer aktive Git-Ziele
- nicht-gitbasierte Sammelordner mit expliziter Mitgliedschaft
- `fetch` und ausschliesslich sichere `pull --ff-only`-Aktualisierungen
- Home-Sync, Registry-Pruefung und kanonische Wartungspaket-Propagation
- Toolchain-Wartung mit Required-/Optional-Klassifikation
- fortsetzbare Administratorbefunde
- kompakte Terminalausgabe, vollstaendige Logdatei und JSON-Abschlussbericht
- idempotente Check-, Dry-Run-/WhatIf- und Update-Modi

*In scope are cross-platform parity, Bash 3.2 compatibility, PowerShell 7
parity, desired-state discovery, safe cloning and fast-forward updates,
home-sync and propagation, required versus optional toolchain maintenance,
continuable administrator findings, and concise human plus complete
machine-readable reporting.*

### Out of Scope

- kein automatisches Committen oder Pushen fachlicher Aenderungen in
  gewarteten Ziel-Repositories
- kein automatisches Aufloesen lokaler Dirty-, Ahead- oder Diverged-Zustaende
- kein Force-Push, kein Reset, kein rekursives Loeschen kollidierender Pfade
- keine automatische Anmeldung an GitHub, GitLab oder anderen Forges
- keine Secret-Erfassung oder Ausgabe von Zugangsdaten in Log oder JSON
- keine Aenderung von Branch-Protection, Rulesets, Repository-Sichtbarkeit oder
  Provider-Abrechnung
- kein implizites Mergen von Release-Please- oder fremden Pull Requests
- keine pauschale Installation optionaler Werkzeuge ohne den bestehenden
  Optional-Schalter

*The flow does not commit or push domain changes, resolve dirty or diverged
repositories destructively, force-push, delete path conflicts, authenticate to
providers, expose secrets, alter provider governance, merge unrelated pull
requests, or install optional tools without the existing opt-in.*

## 5. Desired-State-Fleet-Manifest / Desired-State Fleet Manifest

Die versionierte Sollquelle wird als
`scripts/config/agentic-workspace-fleet.json` mit zugehoerigem Schema
`scripts/config/agentic-workspace-fleet.schema.json` eingefuehrt. Sie ersetzt
nicht den lokalen Zustandsnachweis, sondern ist dessen kanonische, portable
Sollvorgabe. Die lokale
`~/.home-baseline/level2-repository-registry.json` bleibt der operative
Ist-Nachweis und darf aus dem Manifest kontrolliert ergaenzt werden.

*The versioned desired-state source is introduced as
`scripts/config/agentic-workspace-fleet.json` with a matching JSON schema. It
does not replace local evidence; it is the canonical portable desired state
from which the operational local registry may be safely completed.*

Das Manifest verwendet HOME-relative Pfade mit `/` als portablem Trenner und
enthaelt ein geordnetes `targets`-Array. Jeder Eintrag hat:

| Feld / Field | Vertrag / Contract |
|---|---|
| `id` | stabiler, eindeutiger Bezeichner / stable unique identifier |
| `kind` | `git-repository` oder `collection` |
| `level` | `1` oder `2`; Level 0 bleibt Source-Resolver-Verantwortung |
| `path` | HOME-relativer Zielpfad ohne `..` |
| `active` | nur `true`-Ziele werden erzeugt oder gewartet |
| `maintenanceClass` | `canonical-fleet` oder `preset` |
| `remote` | Pflicht fuer Git-Ziele, fuer Collections unzulaessig |
| `forge` | `github`, `gitlab`, `codeberg`, `forgejo` oder `generic-git` |
| `defaultBranch` | Pflicht fuer Git-Ziele |
| `memberDiscovery` | nur fuer Collections; zunaechst `declared-targets` |

*Git entries require a remote, forge, and default branch. Collection entries
represent a directory boundary only; their Git children are separate declared
targets. Paths are HOME-relative, portable, unique, and traversal-safe.*

Verbindliche Schema- und Konsistenzregeln:

- `path` und normalisierte `remote` duerfen bei aktiven Git-Zielen nicht
  doppelt vorkommen.
- Ein Level-2-Ziel MUSS unter einem aktiven Level-1- oder Collection-Pfad
  liegen.
- `collection`-Eintraege werden nie als Git-Repository behandelt.
- `~/SpecKitPresetProjects` wird als Collection eingetragen; die zehn
  gewuenschten Preset-Repositories werden als eigene aktive Git-Ziele der
  `maintenanceClass: preset` eingetragen. Drei sind aktuell vorhanden, sieben
  sind kontrollierte Clone-on-missing-Ziele.
- Die 32 bisherigen Level-1-/Level-2-Ziele werden als
  `maintenanceClass: canonical-fleet` uebernommen.
- Inaktive Eintraege bleiben dokumentierbar, werden aber weder geklont noch
  gepullt noch propagiert.
- Manifest- oder Schemafehler sperren mutierende Flottenaktionen, werden aber
  mit genauer JSON-Pointer- beziehungsweise Zielangabe berichtet.

*The schema rejects duplicate paths and remotes, orphan Level 2 targets,
repository fields on collections, and unsafe paths. The 32 operational targets
are canonical fleet members; the collection plus ten desired preset
repositories are maintained separately.*

## 6. Repository-Wartungsvertrag / Repository Maintenance Contract

### Clone-on-missing

Fuer ein aktives fehlendes Git-Ziel gilt:

1. Zielpfad, Elternbeziehung, Remote, Forge und Standardbranch aus dem
   validierten Manifest ermitteln.
2. Existiert der Zielpfad als Datei, Symlink oder nicht passendes Verzeichnis,
   mit `PathConflict` abbrechen und nichts entfernen.
3. Zunaechst in ein eindeutig benanntes temporaeres Geschwisterverzeichnis
   klonen.
4. Git-Checkout, normalisiertes `origin`, Standardbranch und erwarteter
   Remote-HEAD pruefen.
5. Nur den vollstaendig validierten Checkout an den freien Zielpfad verschieben.
6. Bei Teilfehlern nur das vom aktuellen Lauf erzeugte temporaere Verzeichnis
   bereinigen; niemals einen vorbestehenden Zielpfad.

*Missing active repositories are cloned through a validated temporary sibling
directory and moved into place only after remote and branch verification.
Conflicting pre-existing paths are never deleted or repurposed.*

Im Check-Modus wird `CLONE_REQUIRED`, im Dry-Run beziehungsweise WhatIf-Modus
`WOULD_CLONE` berichtet. Beide Modi veraendern weder Zielpfade noch Registry.

*Check mode reports `CLONE_REQUIRED`; preview mode reports `WOULD_CLONE`.
Neither mode changes paths or local state.*

### Vorhandene Repositories

Vor einem Pull MUSS der Ablauf mindestens pruefen:

- der Pfad ist ein Git-Worktree,
- `origin` entspricht dem normalisierten Manifest-Remote,
- der erwartete Standardbranch ist ausgecheckt,
- der Arbeitsbaum und Index sind sauber,
- kein Rebase, Merge, Cherry-pick oder Bisect ist aktiv,
- Ahead/Behind wurde nach `fetch --prune` neu bestimmt.

Nur `clean`, `behind > 0`, `ahead = 0` darf mit `pull --ff-only` aktualisiert
werden. Dirty-, Ahead-, Diverged-, Detached-HEAD-, Remote- oder Branch-
Abweichungen werden zielbezogen als Blocker erfasst; andere unabhaengige Ziele
laufen weiter.

*Only a clean default-branch checkout that is behind but not ahead may be
fast-forwarded. Dirty, ahead, diverged, detached, remote-mismatch, and
branch-mismatch states become per-target blockers while independent targets
continue.*

### Collections und Propagation

Collections werden bei Bedarf nur als Verzeichnis angelegt. Ihre Mitglieder
werden ausschliesslich ueber eigene Manifestziele gewartet. Die kanonische
Wartungspaket-Propagation richtet sich an die 32
`canonical-fleet`-Repositories. Die zehn `preset`-Repositories werden per
Fetch und sicherem Fast-Forward aktualisiert und mit ihren eigenen Tests
geprueft, erhalten aber keine kanonischen Propagationsaenderungen.

*Collections are directory boundaries. Canonical maintenance files propagate
to the 32 canonical fleet repositories only. The ten preset repositories are
updated and tested under their own contracts but are excluded from canonical
propagation.*

## 7. Plattform- und Modusvertrag / Platform and Mode Contract

Die vorhandenen Haupteinstiege bleiben:

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
bash scripts/maintain-agentic-workspace.sh
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1
```

macOS und Linux/Ubuntu verwenden den Bash-Einstieg, Windows verwendet
PowerShell 7. Gemeinsame Optionen erhalten funktional gleiche Semantik.

*macOS and Linux/Ubuntu use Bash; Windows uses PowerShell 7. Matching options
have equivalent behavior and reporting.*

### Check-only

- darf fetchten und lesen, aber keine Repositories klonen oder pullen,
  Registry schreiben, Home-Dateien synchronisieren, propagieren oder Pakete
  aktualisieren;
- liefert die vollstaendige Soll-/Ist- und Toolchain-Bewertung;
- endet bei handlungsbeduerftigem Drift mit Exitcode `1`.

### Dry-run / WhatIf

- simuliert alle erlaubten Aktionen ohne persistente Aenderung;
- laeuft nach Registry-Drift weiter und zeigt auch Clone-, Pull-, Homogeneity-,
  Propagations-, Home-Sync- und Toolchain-Prognosen;
- endet bei vorhergesagten Aenderungen mit Exitcode `1`, bei einer reinen
  No-op-Vorschau mit `0`.

### Update

- fuehrt nur validierte, nicht-destruktive Aktionen aus;
- isoliert Zielblocker und setzt unabhaengige Abschnitte fort;
- beendet einen vollstaendig erfolgreichen Lauf mit `0`;
- darf `SUCCESS_WITH_WARNINGS` mit `0` liefern, wenn ausschliesslich optionale
  oder administratorpflichtige Aktionen uebersprungen wurden;
- liefert `PARTIAL` mit `1`, sobald mindestens ein erforderliches Ziel oder
  eine erforderliche Aktion blockiert blieb.

### Fatale Fehler

Aufruf-, Schema-, Source-Resolver- oder unverletzbare
Orchestrierungsfehler liefern `FAILED` mit Exitcode `2`. Die finalen
Berichtsartefakte werden soweit technisch moeglich trotzdem geschrieben.

*Check and preview use exit code 1 for actionable or predicted drift. Update
uses 0 for success, including optional-only warnings, 1 for partial required
work, and 2 for fatal invocation, schema, source, or orchestration failures.*

## 8. Bash-3.2-Kompatibilitaet / Bash 3.2 Compatibility

Der bereits korrigierte echte No-op-Pfad von `sync-home.sh` MUSS unter
`set -euo pipefail` ohne Zugriff auf ein ungebundenes leeres Array funktionieren.
Der spaetere Orchestrator integriert die mit PR #90 ausgelieferte Baseline und
MUSS ihr Aenderungs-, Commit-, Check-only-, Dry-run- und Force-Verhalten
unveraendert erhalten.

*The already corrected real `sync-home.sh` no-op path must work under
`set -euo pipefail` without dereferencing an unbound empty array. The later
orchestrator integrates the baseline delivered through PR #90 and must preserve
its change, commit, check-only, preview, and force behavior.*

Ein deterministischer Test-Harness MUSS mindestens ausfuehren:

- echter No-op unter macOS-System-Bash 3.2,
- derselbe No-op unter aktuellem Bash 5,
- ein Lauf mit genau einem geaenderten verwalteten Pfad,
- mehrere geaenderte Pfade,
- Check-only und Dry-run ohne Schreibzugriff,
- Home-Git vorhanden und nicht vorhanden,
- Dateinamen mit Leerzeichen innerhalb des erlaubten Testmanifests,
- unveraenderte Exitcodes und keine `unbound variable`-Diagnose.

*The deterministic harness covers Bash 3.2 and Bash 5 no-op behavior, one and
multiple changes, read-only modes, optional home Git state, safe paths with
spaces, stable exits, and the absence of unbound-variable diagnostics.*

Neue Testskripte werden in `scripts/config/script-catalog.json` eingeordnet und
erhalten gemaess Repository-Regel eine Unix-Manpage. Die PowerShell-Paritaet
wird mit isolierten Fixtures und `PSScriptAnalyzer` geprueft.

*Any new test script is catalogued and documented with a Unix man page.
PowerShell parity uses isolated fixtures and PSScriptAnalyzer.*

## 9. Toolchain-Klassifikation / Toolchain Classification

Required-Eintraege bleiben blockierende Baseline-Anforderungen. Optional-
Eintraege werden nur mit `--include-optional` beziehungsweise
`-IncludeOptional` installiert oder aktualisiert; ihr Fehlen blockiert die
Workspace-Wartung nicht.

*Required entries remain baseline requirements. Optional entries are installed
or upgraded only through the existing opt-in and never block workspace
maintenance when absent.*

Die folgenden bereits installierten Homebrew-Formeln sind in der aktuellen
Baseline als optional klassifiziert. Der spaetere Lauf MUSS diese Einordnung
verifizieren und vor Regression schuetzen:

| Homebrew-Formel | Scope | Plattformhinweis |
|---|---|---|
| `mongodb-community@8.0` | `optional` | tap-qualifiziert als `mongodb/brew/mongodb-community@8.0` pflegen |
| `mono` | `optional` | auf Linux nur mit verifiziertem Distributionspaket |
| `sqlite` | `optional` | Linux-Aequivalent `sqlite3`, sofern Registry-Modell es abbildet |
| `telnet` | `optional` | Diagnosewerkzeug; nicht automatisch als Windows-Feature aktivieren |

*The installed `mongodb-community@8.0`, `mono`, `sqlite`, and `telnet`
formulae are explicitly optional in the current baseline. The later run must
verify and preserve this classification. Provider-specific equivalents are
added only when their package identifiers are verified; Windows Telnet is not
automatically enabled.*

Der Wartungslauf MUSS installierte, aber unregistrierte Top-Level-Pakete
weiterhin als Drift melden. Nach dieser Klassifikation duerfen die vier
Eintraege nicht mehr als unklassifizierte Drift erscheinen.

*Installed but unregistered top-level packages remain visible drift. After
classification, these four entries no longer appear as unclassified.*

## 10. Administratorpflichtige Aktualisierungen / Administrator-Required Updates

Der Standardlauf ist unbeaufsichtigt und fordert kein Administratorpasswort
an. Eine Cask- oder Paketaktualisierung, die Administratorinteraktion verlangt,
wird als `DEFERRED_ADMIN_REQUIRED` erfasst, uebersprungen und blockiert keine
unabhaengigen Repository-, Registry-, Home-Sync- oder Toolchain-Schritte.

*The default run is unattended and never prompts for administrator
credentials. A package or cask upgrade requiring elevation is recorded as
`DEFERRED_ADMIN_REQUIRED`, skipped, and does not block independent work.*

Eine explizite Option `--allow-admin-prompts` beziehungsweise
`-AllowAdminPrompts` darf interaktive Administratorabfragen fuer den aktuellen
Lauf freigeben. Sie erteilt keine Berechtigung zur Speicherung, Weitergabe oder
Protokollierung von Zugangsdaten. Im Check- und Vorschau-Modus bleibt sie
wirkungslos.

*An explicit per-run option may allow interactive administrator prompts. It
never authorizes storing or logging credentials and has no effect in read-only
or preview modes.*

## 11. Ausgabe-, Log- und JSON-Vertrag / Output, Log, and JSON Contract

Die Terminalausgabe bleibt kompakt:

- eine Startzeile mit Modus, Plattform, Run-ID und Level-0-Quelle,
- hoechstens eine Ergebniszeile je Ziel und Abschnitt,
- keine normalen Fetch-/Pull-Fortschrittszeilen,
- eine Abschlusszusammenfassung mit Zaehlern, Exitcode, JSON- und Logpfad.

*Terminal output contains one start line, at most one result line per target
and stage, and one final summary. Normal Git progress is suppressed.*

Vollstaendige Befehlsausgaben werden in
`~/.home-baseline/logs/agentic-workspace-<timestamp>.log` abgelegt. Der
maschinenlesbare Bericht wird unabhaengig vom Gesamtergebnis unter
`~/.home-baseline/reports/agentic-workspace-<timestamp>.json` geschrieben.
Beide Artefakte teilen dieselbe Run-ID.

*Complete command output is retained in the timestamped log. A matching JSON
report is written for success, partial completion, and failure, and both share
the same run identifier.*

Der JSON-Bericht enthaelt mindestens:

- `schemaVersion`, `runId`, `startedAt`, `finishedAt`, `durationSeconds`
- `platform`, `mode`, `sourceRoot`, `manifestPath`
- `overallStatus` und `exitCode`
- Zaehler fuer gepruefte, geklonte, aktualisierte, unveraenderte,
  uebersprungene, blockierte und fehlgeschlagene Ziele
- `stages[]` mit Name, Status, Dauer, Exitcode und Abhaengigkeiten
- `targets[]` mit ID, Level, Klasse, Pfad, Branch, Ahead/Behind,
  geplanter/ausgefuehrter Aktion und Ergebnis
- `toolchain[]` mit Paketmanager, Paket, Scope, Aktion und Ergebnis
- `findings[]` mit stabilem Code, Schweregrad, Ziel, Kurztext und
  Wiedereinstiegshinweis
- `artifacts.logPath` und `artifacts.reportPath`

*The JSON contract includes run metadata, stage and target results, counts,
toolchain actions, stable findings, resume guidance, and artifact paths.*

Absolute lokale Benutzerdaten werden auf notwendige Pfade begrenzt. Remotes
duerfen keine eingebetteten Zugangsdaten enthalten. Token, Passwoerter,
Environment-Secrets und vollstaendige personenbezogene Kontakt- oder
Zahlungsdaten duerfen weder Terminal, Log noch JSON erreichen.

*Reports minimize local personal data and never contain embedded credentials,
tokens, passwords, environment secrets, or direct personal contact or payment
data.*

## 12. Sicherheits- und Fortsetzungsvertrag / Safety and Continuation Contract

Die Orchestrierung bildet ihre Schritte als Abhaengigkeitsgraph ab:

- Level-0-Preflight und Manifestvalidierung sind harte Voraussetzungen.
- Home-Sync haengt vom validierten Level-0-Stand ab.
- Flottenermittlung und Repository-Statuspruefung duerfen nach einem
  Home-Sync-Fehler weiterlaufen.
- Propagation haengt von gueltigem Manifest, sauberem kanonischem Paket und
  geeignetem Zielzustand ab.
- Toolchain-Pruefung darf weiterlaufen, wenn ihre kanonischen Registries
  lesbar sind.
- Der finale Report haengt von keinem fachlichen Wartungsschritt ab.

*The dependency graph blocks only unsafe dependants. Repository inspection and
toolchain checks may continue after an isolated home-sync failure, while final
reporting remains unconditional.*

Wiederholte Laeufe muessen idempotent sein. Ein nach Teilabschluss erneut
gestarteter Lauf erkennt bereits geklonte oder aktualisierte Ziele, validiert
sie erneut und wiederholt keine abgeschlossenen Mutationen. Der Bericht nennt
pro Blocker den sicheren Wiedereinstieg.

*Repeated runs are idempotent, revalidate completed targets, avoid duplicate
mutations, and provide a safe resume action for every blocker.*

Dieses Lastenheft auf Position 1 fuehrt Manifest, Orchestrierung,
Clone-on-missing und Abschlussbericht ein. Das spaetere
`Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` auf Position 4
haertet darauf aufbauend insbesondere die flottenweite
Remote-Freshness-Barriere, beliebige Default-Branches sowie Worktree- und
Hard-Abort-Bereinigung. Position 1 MUSS kompatible Schnittstellen und Evidence
bereitstellen, darf diese spaetere Haertung aber weder vorwegnehmen noch als
abgeschlossen ausweisen.

*This position-1 intake introduces the manifest, orchestration,
clone-on-missing, and final reporting. The later
`Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` at position 4
builds on it to harden the fleet-wide remote-freshness barrier, arbitrary
default branches, and worktree and hard-abort cleanup. Position 1 must provide
compatible interfaces and evidence but must neither pre-empt nor claim
completion of that later hardening.*

## 13. Akzeptanzszenarien / Acceptance Scenarios

### AC-001: Vollstaendiger No-op

Bei sauberem Level 0, synchroner Home-Baseline, vorhandenen sauberen
Repositories und aktueller Toolchain endet der Update-Lauf unter macOS,
Linux/Ubuntu und Windows mit Exitcode `0`, `SUCCESS`, kompaktem Terminaloutput
und gueltigem JSON-Bericht.

### AC-002: Bash-3.2-No-op

Der macOS-System-Bash-3.2-Test durchlaeuft den leeren `changed_paths`-Fall ohne
Fehler, ohne Home-Commit und ohne Drift.

### AC-003: Fehlendes Repository

Check-only meldet `CLONE_REQUIRED`, Dry-run/WhatIf `WOULD_CLONE`, und Update
erzeugt einen validierten Checkout mit korrektem Remote und Standardbranch.
Kein Vorschau-Modus schreibt.

### AC-004: Pfadkonflikt

Ein vorhandener Nicht-Git-Pfad am Repositoryziel wird nicht geloescht oder
umbenannt. Das Ziel wird `BLOCKED`, andere unabhaengige Ziele laufen weiter.

### AC-005: Dirty oder divergiertes Repository

Der Ablauf fuehrt keinen Pull aus, protokolliert den Zustand samt sicherem
Wiedereinstieg und setzt andere Ziele fort.

### AC-006: Registry-Drift im Dry-run

Die Vorschau meldet Registry-Drift und zeigt danach trotzdem alle
vorhergesagten Clone-, Pull-, Home-Sync-, Homogeneity-, Propagations- und
Toolchain-Aktionen.

### AC-007: Administratorpflichtiger Cask

Ohne explizite Admin-Option wird die Aktualisierung als
`DEFERRED_ADMIN_REQUIRED` erfasst. Der Lauf fordert kein Passwort an und setzt
alle unabhaengigen Schritte fort.

### AC-008: Optionale Formeln

`mongodb-community@8.0`, `mono`, `sqlite` und `telnet` erscheinen als
klassifizierte optionale Eintraege. Ihr Fehlen oder Ueberspringen blockiert den
Lauf nicht.

### AC-009: Unterprozessfehler

Ein isolierter Home-Sync- oder Paketmanagerfehler erzeugt weiterhin einen
vollstaendigen JSON-Bericht, eine Logreferenz und Ergebnisse der unabhaengigen
Abschnitte.

### AC-010: Geraeuscharme grosse Flotte

Die Terminalausgabe bleibt auf eine kompakte Ergebniszeile je Ziel und
Abschnitt begrenzt. Vollstaendige Git-Ausgaben stehen ausschliesslich im
Logartefakt.

### AC-011: Sollflotte

Der Abschlussbericht unterscheidet 32 aktive `canonical-fleet`-Repositories,
zehn gewuenschte `preset`-Repositories und die Collection
`SpecKitPresetProjects`. Er weist aus, welche drei Preset-Repositories bereits
vorhanden und welche sieben Clone-on-missing-Ziele sind. Presets werden nicht
propagiert.

### AC-012: Plattformparitaet

Fixture-basierte Bash- und PowerShell-Laeufe erzeugen fuer denselben
Soll-/Ist-Zustand dieselben Zielstatus, Aktionsklassen, Exitcodes und
semantisch aequivalente JSON-Felder.

*The acceptance suite covers no-op behavior, Bash 3.2, clone and conflict
handling, dirty and diverged repositories, full preview continuation,
administrator deferral, optional formulae, failure-resilient reporting, quiet
large-fleet output, target-class boundaries, and Bash/PowerShell parity.*

## 14. Erwartete Ergebnisartefakte / Expected Result Artefacts

| Artefakt | Erwartung |
|---|---|
| Fleet-Manifest und Schema | portable Sollquelle fuer Collections und Git-Ziele |
| Unix-/Windows-Orchestrator | funktionsgleiche sichere Wartungsablaeufe |
| Home-Sync-Baseline | Schutz des mit PR #90 korrigierten Bash-3.2-No-op |
| Test-Harness | isolierte No-op-, Clone-, Drift-, Fehler- und Paritaetsfixtures |
| Toolchain-Registries | Regressionsevidence fuer vier bereits optionale Formeln |
| Manpages und Help | neue Optionen, Exitcodes, JSON und Sicherheitsgrenzen |
| JSON-Abschlussbericht | kompakter stabiler Maschinenvertrag |
| Vollstaendiges Log | leise Git-Ausgabe im Terminal, Details im Artefakt |
| Statistikpflege | aktualisiertes Ledger und reproduzierbarer Profil-2-Block |

## 15. Auslieferungsreihenfolge fuer die spaetere Umsetzung / Later Delivery Order

1. Feature im Level-0-Repository spezifizieren, planen, implementieren und
   plattformuebergreifend validieren.
2. Level-0-Aenderungen ueber fokussierten Feature-Branch und Pull Request
   ausliefern.
3. Erst nach Squash-Merge und lokaler `main...origin/main`-Paritaet den
   gemergten kanonischen Wartungsstand als Propagationsquelle verwenden.
4. Die notwendigen kanonischen Aenderungen in die 32 aktiven
   `canonical-fleet`-Repositories propagieren und dort jeweils die lokalen
   Governance-, Branch-, Test- und PR-Regeln beachten.
5. Die zehn Preset-Repositories separat warten und testen, aber nicht durch die
   kanonische Wartungspaket-Propagation veraendern.
6. Am Ende alle betroffenen Standardbranches synchronisieren und saubere
   Arbeitsbaeume sowie Divergenz `0 0` belegen.

*Level 0 is implemented, reviewed, squash-merged, and synchronized first. Only
the merged canonical state may then propagate to the 32 canonical fleet
repositories. Presets remain separate, and final clean-tree plus remote parity
is proven everywhere.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md als verbindliche Eingabedatei.

Erstelle eine Feature-Spezifikation fuer eine unbeaufsichtigte, fortsetzbare und plattformuebergreifende Ein-Kommando-Wartung der Level-0-/Level-1-/Level-2-Flotte unter macOS, Linux/Ubuntu und Windows. Uebernimm alle funktionalen Anforderungen, Sicherheitsgrenzen, Plattformanforderungen, Fehlerfaelle und Akzeptanzszenarien des Lastenhefts.

Verbindlich:
- Behandle das versionierte Desired-State-Fleet-Manifest mit Zielpfad, Remote, Ebene, Forge, Standardbranch, Aktivstatus, Zielart und Wartungsklasse als kanonische Sollquelle.
- Unterstuetze sicheres Clone-on-missing fuer aktive Git-Ziele und nicht-gitbasierte Collections wie SpecKitPresetProjects.
- Integriere und pruefe die mit PR #90 bereits korrigierte sync-home-No-op-Baseline unter macOS-Bash 3.2 und Bash 5, ohne sie als neue Produktkorrektur zu behandeln.
- Setze den Dry-run nach Registry-Drift fort und prognostiziere alle weiteren sicheren Aktionen.
- Behandle administratorpflichtige Aktualisierungen als DEFERRED_ADMIN_REQUIRED und setze unabhaengige Schritte fort.
- Verifiziere und erhalte die bestehende optionale Klassifikation von mongodb-community@8.0, mono, sqlite und telnet.
- Definiere leise Git-Ausgabe, vollstaendige Logdateien und den kompakten JSON-Abschlussbericht.
- Erhalte die Trennung zwischen 32 canonical-fleet-Repositories, zehn gewuenschten preset-Repositories und dem Collection-Pfad SpecKitPresetProjects; drei Preset-Repositories sind vorhanden, sieben bleiben kontrollierte Clone-on-missing-Ziele.
- Nutze den vorhandenen Preset-Profilkatalog und das Profil intake-authoring-ten-governance-presets als verbindliche Eingabe.
- Liefere kompatible Schnittstellen und Evidence fuer die spaetere Position-4-Haertung, ohne Remote-Freshness-, Default-Branch-, Worktree- oder Hard-Abort-Hardening vorwegzunehmen.
- Plane Bash-/PowerShell-Paritaet, Manpages, comment-based help, Skriptkatalog, Sicherheitspruefungen und Projektstatistik ein.

Starte noch keine Implementierung, keinen Flottenrollout und keine Remote-Schreibaktion.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```
## 16. Abnahme dieses Lastenhefts / Acceptance of This Intake

- Das Dokument ist DE zuerst und EN danach aufgebaut.
- Der alte Intake ist sichtbar als abgeloest gekennzeichnet, bleibt aber
  historisch lesbar.
- Die Abarbeitungsreihenfolge verweist aktiv nur auf dieses neue Lastenheft.
- Beide Prompt-Bloecke nennen exakt diesen Dateinamen.
- Der normalisierte autonome Prompt verwendet `LocalImplementation` und
  erteilt keinen Bypass, keine Secrets, keine Provider-Administration und
  keine Remote-Schreibrechte.
- Das Anlegen des Lastenhefts startet keinen Spec-Kit-Lauf, Feature-Branch,
  Commit, Push, Pull Request oder Flottenrollout.

*The intake is bilingual, discoverable, explicitly supersedes the old active
entry, contains exact staged and autonomous prompts, grants only the bounded
autonomous delivery authority, and starts no implementation or remote action.*

<!-- intake-authoring:end -->
