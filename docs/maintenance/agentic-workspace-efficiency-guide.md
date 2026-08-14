# Agentischer Workspace und Ein-Kommando-Wartung

[English version](agentic-workspace-efficiency-guide.en.md)

## Zweck und Zielgruppen

Dieser Leitfaden erklärt, wie der agentische Workspace und die
Ein-Kommando-Wartung sicher, nachvollziehbar und effizient verwendet werden.
**Agentisch** bedeutet: Ein KI-Agent bearbeitet eine klar begrenzte Aufgabe mit
ausdrücklicher Berechtigung, überprüfbarer Evidence und menschlicher
Verantwortung. **Evidence** ist ein nachvollziehbarer Nachweis, zum Beispiel ein
Report, ein Exitcode oder ein geprüfter Commit.

Der Leitfaden richtet sich an Lernende ab dem ersten Ausbildungsjahr, tägliche
Nutzende, Maintainer, KI-Agenten sowie Reviewer. Spec-Kit-Vorwissen ist nicht
erforderlich. Geschwindigkeit ist nur ein Sekundärindikator. Maßgeblich ist
mehr überprüfbare Arbeit pro vollständigem Qualitätszyklus.

## Vier Leserpfade

| Ziel | Einstieg | Ergebnis |
|---|---|---|
| Erster sicherer Lauf | [Prüfung ohne Wartungsmutation](#erster-sicherer-lauf--first-safe-run) | Befehl, Nebenwirkung, Exitcode und nächste Aktion verstehen |
| Regelmäßiger Betrieb | [Flottenstatus und Vorschau](#regelmaessiger-betrieb--regular-operation) | erlaubte und gesperrte Aktionen unterscheiden |
| Maintainer und KI-Agenten | [Quelle, Authority und Handoff](#maintainer-und-ki-agenten--maintainers-and-ai-agents) | richtigen Änderungs-, Sync- und Lieferweg wählen |
| Fehleranalyse und Audit | [Evidence und Wiederanlauf](#fehleranalyse-und-audit--troubleshooting-and-audit) | einen Lauf ohne Erfolgsannahme rekonstruieren |

## Begriffe beim ersten Auftreten

| Begriff | Erklärung |
|---|---|
| Level-0-Quelle | Dauerhafter Git-Checkout, in dem gemeinsame Änderungen versioniert, geprüft und geliefert werden |
| Home Runtime | Manifestgesteuerte Auswahl betrieblicher Dateien unter `~/`; nicht das gesamte Home-Verzeichnis |
| Remote-Freshness-Barriere | Vollständiger Fetch-Preflight aller deklarierten Git-Ziele vor fachlichen Mutationen |
| Arbeitsbaum | Getrackte und ungetrackte Dateien eines lokalen Git-Checkouts |
| Vorschau | Zeigt geplante Mutationen, führt sie aber nicht aus |
| Run-ID | Eindeutige Kennung, die Terminal, Log, Eventstream und Abschlussreport verbindet |
| JSONL | Textformat mit genau einem JSON-Objekt pro Zeile; hier nur für Live-Ereignisse |
| Authority | Aktuelle ausdrückliche Berechtigung für lokale oder entfernte Aktionen |

<a id="erster-sicherer-lauf--first-safe-run"></a>
<a id="erster-sicherer-lauf-first-safe-run"></a>
## Erster sicherer Lauf / First safe run

### 1. Kanonische Quelle öffnen

Arbeiten an der gemeinsamen Baseline beginnen im versionierten Checkout:

```bash
cd ~/home-baseline-source
git status --short --branch
```

Ein sauberer Arbeitsbaum ist Voraussetzung für einen kontrollierten
Fast-forward-Pull. Ein schmutziger Arbeitsbaum darf gefetcht und geprüft, aber
nicht automatisch gepullt oder bereinigt werden.

### 2. Betriebssystem erkennen

- macOS oder Linux: Bash-Variante verwenden.
- Windows: PowerShell 7 mit `-NoProfile` verwenden.
- Varianten nicht mischen. Sie besitzen denselben Fachvertrag, aber
  plattformspezifische Parameternamen.

### 3. Hilfe lesen

```bash
bash scripts/maintain-agentic-workspace.sh --help
```

```powershell
Get-Help ./scripts/maintain-agentic-workspace.ps1 -Full
```

Die Hilfe ist der öffentliche Kurzvertrag. Die ausführliche Quelle ist die
[Manpage](../man/maintain-agentic-workspace.1.md). Die
[generierte Skriptreferenz](../scripts/reference.md) beweist, welche Skripte zum
Repository gehören; sie wird nicht manuell gepflegt.

### 4. Schreibfreien Check ausführen

Auf macOS oder Linux:

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
```

Auf Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
```

Check-only darf sichere `fetch --prune`-Versuche ausführen. Der Modus führt
keine Pulls, Dateiupdates oder Paketinstallationen aus. Deshalb kann er dennoch
Netzwerkzugriffe auslösen und Exitcode `1` melden, wenn Drift oder eine Sperre
gefunden wird.

### 5. Ergebnis richtig lesen

| Exitcode | Bedeutung | Sichere nächste Aktion |
|---:|---|---|
| `0` | Zustand aktuell oder Lauf erfolgreich | Report auf erwartete Run-ID und finalisierten Status prüfen |
| `1` | Drift, Blocker oder nicht synchroner Zustand | vollständige Restmenge und genaue nächste Aktion im Report lesen |
| `2` | Parameter-, Betriebs- oder Sicherheitsfehler | Lauf nicht wiederholen, bevor Ursache und Evidence geprüft sind |
| `3` | Drift lokal repariert | geänderte Dateien separat prüfen und über Branch/PR liefern |
| `130` | durch `Ctrl+C` beziehungsweise `INT` abgebrochen | finalisierten Report und Prozessende prüfen; Erfolg nicht annehmen |
| `143` | Linux-Lauf durch `TERM` beendet | Abschlussstatus und Restmenge prüfen; Erfolg nicht annehmen |

Ein nicht-null Exitcode ist nicht automatisch ein Programmfehler. `1` ist ein
fachlicher Befund. Umgekehrt beweist Exitcode `0` allein keinen vollständigen
Lauf: erwarteter Abschlussreport, Run-ID und Finalisierungsstatus müssen dazu
passen.

### 6. Vorschau vor Mutation

```bash
bash scripts/maintain-agentic-workspace.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

Die Vorschau zeigt erlaubte Änderungen. Sie ist kein Ersatz für Check-only:
Zuerst wird der Flottenzustand vollständig geprüft, danach werden geplante
Mutationen bewertet. Ein interaktiver argumentloser Start wählt die Vorschau
standardmäßig. Umgeleitete Aufrufe bleiben aus Kompatibilitätsgründen headless.

### Erstlauf-Checkliste

- [ ] Richtige Plattformvariante gewählt.
- [ ] Im kanonischen Checkout gearbeitet.
- [ ] Hilfe gelesen.
- [ ] Check-only ausgeführt und Exitcode notiert.
- [ ] Reportpfad und Run-ID notiert.
- [ ] Blocker und nächste Aktion als Text verstanden.
- [ ] Vor einer Mutation eine Vorschau ausgeführt.
- [ ] Keine Remote-, Admin- oder Secret-Berechtigung angenommen.

<a id="regelmaessiger-betrieb--regular-operation"></a>
<a id="regelmäßiger-betrieb-regular-operation"></a>
## Regelmäßiger Betrieb / Regular operation

### Verbindliche Reihenfolge

```text
Quelle und aktuelle Berechtigung prüfen
  -> Lock, Log und atomaren Report anlegen
  -> alle deklarierten Git-Ziele inventarisieren und fetchen
  -> Pull- und Sperrklassen bestimmen
  -> erst danach Home-Sync, Registry, Propagation und Profile prüfen
  -> Toolchain nur bei erfüllter Mutationsbarriere pflegen
  -> Endzustand erneut prüfen und Report finalisieren
```

Kontroll-Evidence wie Lock, Log und Report darf vor der
Remote-Freshness-Barriere entstehen. Fachliche Mutationen bleiben gesperrt, bis
alle Fetch-Versuche abgeschlossen und alle Pflichtziele sicher klassifiziert
sind. Ein Fehler im ersten Repository darf die read-only Inventur der übrigen
Flotte nicht abbrechen.

### Git-Zustände und Entscheidungen

| Zustand | Fetch | Automatischer Pull | Fachliche Mutationen |
|---|---|---|---|
| Clean, Default-Branch, nur Behind | erlaubt | `pull --ff-only` erlaubt | nach vollständiger Barriere möglich |
| Clean und synchron | erlaubt | nicht nötig | nach vollständiger Barriere möglich |
| Dirty | erlaubt | gesperrt | gesperrt |
| Ahead | erlaubt | gesperrt | gesperrt |
| Diverged | erlaubt | gesperrt | gesperrt |
| Detached HEAD | erlaubt | gesperrt | gesperrt |
| Non-Default-Branch | erlaubt | gesperrt | gesperrt |
| Upstream fehlt oder ist mehrdeutig | soweit möglich | gesperrt | gesperrt |
| Remote nicht erreichbar | Versuch mit Grenze | gesperrt | gesperrt |

Der Default-Branch wird aus gültigem `origin/HEAD` oder
`git ls-remote --symref origin HEAD` abgeleitet. Namen wie `main`, `master` oder
`trunk` werden nicht geraten. Fetch- und Pull-Versuche erhalten Versuchszahl,
Dauer, finalen Status und nächste Aktion. Timeout oder stille Ausgabe sind nie
ein impliziter Erfolg.

### Enhanced, Plain und Headless

| Modus | Aufruf | Zweck |
|---|---|---|
| Enhanced TUI | `--tui` / `-Tui` | interaktive Terminaloberfläche mit kopierbarem Textstatus |
| Plain UI | `--plain-ui` / `-PlainUi` | linearer textorientierter Assistent |
| Headless | `--no-tui` / `-NoTui` oder andere Wartungsoption | Automation ohne interaktive Auswahl |

Die drei UI-Schalter schließen sich gegenseitig aus. Fehlende Terminalfähigkeit,
fehlendes .NET-10-SDK oder ein unsicherer Buildcache darf vor Engine-Start zum
Plain-Fallback führen. Nach Engine-Start wird nie ein zweiter Engine-Prozess
gestartet. Ein Fallback darf Darstellung reduzieren, aber keine Bestätigung,
Sperre oder Berechtigung umgehen.

### Fachoptionen und Grenzen

| Bash | PowerShell | Wirkung und Grenze |
|---|---|---|
| `--check-only` | `-CheckOnly` | prüfen und fetchen; keine Pulls oder Updates |
| `--dry-run` | `-WhatIf` | geplante Mutationen anzeigen |
| `--scripts-only` | `-ScriptsOnly` | Maschinenpakete auslassen |
| `--repair-drift` | `-RepairDrift` | Wartungspaket lokal reparieren; nie committen oder pushen |
| `--include-optional` | `-IncludeOptional` | optionale Maschinenpakete in aktuelle Autorisierung aufnehmen |
| `--allow-admin-prompts` | `-AllowAdminPrompts` | Adminabfragen nur für diesen Prozess erlauben |
| `--cleanup-profile safe\|deep\|none` | `-CleanupProfile Safe\|Deep\|None` | verifizierte Storage-Bereinigung; Standard Safe |
| `--confirm-deep-cleanup` | `-ConfirmDeepCleanup` | echten Deep-Lauf separat bestätigen |
| `--manifest PATH` | `-ManifestPath PATH` | alternatives Flottenmanifest für einen kontrollierten Lauf |
| `--home-dir PATH` | `-HomeDir PATH` | alternatives Home für Tests oder ein zweites Profil |

PowerShell bietet zusätzlich begrenzte Git- und WinGet-Timeoutparameter. Das ist
eine bewusste Plattformgrenze, keine Funktionsparitätslücke. Adminfreigabe
speichert keine Zugangsdaten, umgeht weder UAC noch Timeouts und ist kein
GitHub-Admin-Bypass.

`Safe` bewahrt Buildausgaben normalerweise sieben Tage und wechselt unter 15
Prozent freiem Speicher in Pressure Mode. Jeder Repo-Kandidat muss enthalten,
ignoriert, nicht getrackt und symlinkfrei sein. `scripts-only` erzwingt `None`.
`Deep` ergänzt wiederherstellbare Dependency-Caches. Die kuratierten Non-MSL-
Adapter für `cc65` und `tvision` übernehmen deren dokumentierte Begründung und
schützen Sample-, Targettest- und CMake-Provenienz-Evidence. Containerpflege
ist auf dangling Images ohne Volumes begrenzt.

### Report, Log und Live-Ereignisse

Pro Lauf entstehen unter `~/.home-baseline/`:

- ein Lock gegen parallele Wartung;
- ein vollständiges Log;
- ein atomar finalisierter JSON-Report;
- ein eingebetteter privater Storage-Detailbericht, sofern die Stufe aktiv ist;
- bei TUI-Nutzung ein interner JSONL-Eventstream.

Alle Artefakte verwenden dieselbe Run-ID. Der Eventstream dient nur der
Live-Anzeige. Der kanonische Abschluss entsteht aus finalisiertem Report und
Prozess-Exitcode. Ein vorhandenes Abschlussereignis muss dazu passen.
`EVENT_STREAM_DEGRADED` bedeutet, dass Events fehlen, beschädigt oder ungeordnet
sind. Die Oberfläche wechselt dann dauerhaft zu einer linearen Darstellung und
darf aus Events keinen Erfolg ableiten.

### Regelmäßiger Abschluss

1. Prozess-Exitcode notieren.
2. Reportpfad und Run-ID mit der Terminalausgabe vergleichen.
3. `finalized`, Gesamtstatus, letzte Stufe und nächste Aktion lesen.
4. Blockierte Restmenge vollständig behandeln; einzelne grüne Ziele reichen
   nicht als Gesamtbeweis.
5. Bei reparierter Drift den Wartungslauf beenden und Änderungen separat
   inventarisieren.
6. Erst nach Review einen eigenen Branch und PR verwenden.

<a id="maintainer-und-ki-agenten--maintainers-and-ai-agents"></a>
<a id="maintainer-und-ki-agenten-maintainers-and-ai-agents"></a>
## Maintainer und KI-Agenten / Maintainers and AI agents

### Source, Runtime und lokaler Zustand

| Klasse | Kanonischer Änderungsort | Lese- und Sync-Regel | Remote-Grenze |
|---|---|---|---|
| Level-0-Quelle | versionierter Checkout | direkt lesen und über Branch/PR ändern | besitzt nur ausdrücklich erteilte Remote-Autorität |
| `homeRuntime` | zuerst Level-0-Quelle | nach Merge per `sync-home.*` prüfen und lokal verteilen | Runtime-Kopie nie direkt pushen |
| `sourceOnly` | Level-0-Quelle | direkt aus Checkout lesen; kein Home-Sync | normaler Source-PR |
| `machineLocal` | lokale Maschine nach Zustandsvertrag | nicht aus Source überschreiben | keine implizite Veröffentlichung |

Die aktuelle Home-Runtime-Menge steht im
[`home-sync-manifest.json`](../../scripts/config/home-sync-manifest.json). Die
Flottenklassen stehen im
[`agentic-workspace-fleet.json`](../../scripts/config/agentic-workspace-fleet.json).
Dokumentation pflegt keine zweite vollständige Dateiliste.

Direkte Reparaturen unter `~/` sind nicht kanonisch. Ein lokaler Home-Commit
dokumentiert Runtime-Sync, ersetzt aber keinen Source-Commit oder PR. Der
allgemeine schreibende Home-Sync läuft nur auf dem Host. Eine Sandbox liest die
eingebundene Level-0-Referenz und schreibt nicht in die Host-Runtime. Nur ein
ausdrücklich angeforderter `--runtime-only`-/`-RuntimeOnly`-Lauf darf
manifestgebundene `homeRuntime` in die Container-Betriebskopie verteilen; Pull,
Commit und Git-Identitätsänderungen bleiben dabei ausgeschlossen.

### Delivery Authority

| Modus | Erlaubt | Nicht automatisch erlaubt |
|---|---|---|
| `LocalImplementation` | lokal ändern und validieren | Commit, Push, PR, Merge |
| `PublishPR` | zusätzlich committen, pushen und PR erstellen/aktualisieren | Merge oder Admin-Bypass |
| `MergeAndSync` | zusätzlich Reviews konvergieren, regelkonform mergen und Default-Branch synchronisieren | Secrets, Provider-Admin oder allgemeiner Bypass |

Authority ist aktuell und auftragsbezogen. Sie wird weder aus einem früheren
Chat noch aus dem Wort „autonom“ abgeleitet. Ein Wartungslauf selbst erhält
keine Berechtigung, Änderungen in Ziel-Repositories zu committen oder zu pushen.

### Wiederverwendbarer Agenten-Prompt

```text
Ziel: <konkretes Wartungs- oder Dokumentationsziel>
Repository und Branch: <exakte lokale und logische Identität>
Scope: <erlaubte Dateien und Verhalten>
Nicht-Ziele: <ausdrücklich gesperrte Änderungen>
Delivery Authority: <LocalImplementation | PublishPR | MergeAndSync>
Evidence: <Report, Run-ID, Intake, Review und erwartete Gates>
Sichere Reihenfolge: Check -> Vorschau -> ausdrückliche Mutation
Stop-Grenzen: Dirty/Ahead/Diverged, fehlende Authority, unklare Evidence,
              fehlgeschlagener Pflichtcheck oder umsetzbarer Review-Thread
Abschluss: <erwarteter Branch-, PR-, Merge- und Sync-Zustand>
Kein Folgefeature automatisch starten.
```

Der Agent prüft vorhandene Evidence, statt sie blind zu wiederholen. Große Logs
werden über Run-ID und Pfad referenziert, nicht vollständig in Prompts kopiert.

### Seriell oder parallel

Parallel ist nur sicher, wenn Aufgaben keine gemeinsamen Writer besitzen.
Folgende Flächen werden serialisiert:

- Evidence und autonome Run-State-Dateien;
- Registry und Desired-State-Manifeste;
- Preset-Profile und Publikationskopien;
- Agenten-Guidance und Spec-Kit-Templates;
- Projektstatistik und Versionsdateien;
- dieselben Source- oder Dokumentationsdateien.

Read-only Inventuren verschiedener Repositories dürfen gebündelt werden. Ein
Fehler stoppt nicht die übrige Bestandsaufnahme. Schreibende Reparaturen werden
danach repositoryweise über getrennte Branches und nicht leere PRs geliefert.

### Drift-Reparatur und Handoff

1. Exakten Drift und Owner aus dem kanonischen Report ermitteln.
2. Nach jeder Zustandsänderung die Kandidatenmenge neu inventarisieren.
3. Kein breites `git clean`, Reset, Stash oder rekursives Löschen in
   Nutzer-Checkouts verwenden.
4. Nur manifest- oder leasegebundene eigene Pfade ändern oder bereinigen.
5. Ziel-Repository auf aktuellem Default-Branch in einen eigenen Branch
   überführen.
6. Änderungen und Tests repositorylokal prüfen.
7. Commit, Push, Review und Merge nur mit aktueller Authority ausführen.
8. Danach Default-Branch per Fast-forward synchronisieren und `(0 0)` belegen.

<a id="fehleranalyse-und-audit--troubleshooting-and-audit"></a>
<a id="fehleranalyse-und-audit-troubleshooting-and-audit"></a>
## Fehleranalyse und Audit / Troubleshooting and audit

### Diagnose-Reihenfolge

1. Repository, Branch und aktuelles Commit bestimmen.
2. Prozesszustand und Lock-Owner prüfen.
3. Run-ID aus Terminal oder Reportpfad bestimmen.
4. Finalisierten Report lesen.
5. Prozess-Exitcode und Report-Exitcode vergleichen.
6. Log und letzte abgeschlossene Stufe prüfen.
7. JSONL nur ergänzend verwenden.
8. Arbeitsbaum und eigene Lease-Evidence erneut inventarisieren.
9. Erst dann Wiederholung, Resume oder manuelle Reparatur wählen.

### Lock und Lease

Ein Lock verhindert parallele Läufe im selben Home-Kontext. Ein temporärer
Preset-Worktree besitzt einen Lease, also einen Eigentumsnachweis mit Run,
Prozessstart, Repository, Commit und reservierten Pfaden. Entfernt werden nur
weiterhin saubere, Git-registrierte und eindeutig eigene Worktrees. Aktive,
manipulierte, fremde oder wegen PID-Wiederverwendung mehrdeutige Evidence
bleibt erhalten und blockiert Mutationen.

### Unterbrechung und Wiederanlauf

Das erste `Ctrl+C` wird genau einmal an die laufende Engine weitergegeben.
Weitere Signale starten keinen zweiten Prozess und lösen keine pauschale
Bereinigung aus. Ein kontrollierter Abbruch wartet auf den kanonischen
Abschlusszustand und endet mit `130`; `TERM` unter Linux endet mit `143`.

Nach unerwarteter Unterbrechung gilt ein alter `Active`-Status nicht als
laufender oder erfolgreicher Beweis. Vor Wiederaufnahme werden Prozess,
Arbeitsbaum, Report, Taskstand, Hashes und letzte Operation geprüft. Eine
Operation ohne vertrauenswürdiges Ergebnis benötigt Revalidierung. Bereits
sicher abgeschlossene Arbeit wird nicht blind wiederholt.

### Typische Befunde

| Befund | Bedeutung | Nächste Aktion |
|---|---|---|
| `EVENT_STREAM_DEGRADED` | Live-Anzeige ist unvollständig | finalisierten Report und Prozess-Exitcode verwenden |
| `DEFERRED_ADMIN_REQUIRED` | erforderliche Adminaktion war nicht aktuell autorisiert | Restmenge prüfen und neuen Lauf ausdrücklich autorisieren |
| Dirty/Ahead/Diverged | automatische Aktualisierung wäre nicht sicher | Repository separat inventarisieren und menschlich entscheiden |
| Report fehlt | Abschluss kann nicht bewiesen werden | nicht als Pass werten; Log, Prozess und Run-ID prüfen |
| Report/Exitcode widersprechen sich | Abschluss-Evidence ist inkonsistent | Lauf blockieren und Ursache rekonstruieren |
| Remote-Timeout | Aktualität ist nicht bewiesen | als blockierend behandeln; begrenzten Retry dokumentieren |
| Preset-Drift im detached Worktree | kanonischer Default-Branch weicht ab | separaten Repository-Branch und PR vorbereiten |

### Audit und Aufbewahrung

Publishbare Evidence nennt Repository, Commit, Run-ID, Befehlsklasse, Ergebnis,
Proof-Grenze und nächste Aktion. Maschinenlokale Logs bleiben lokal. Secrets,
private absolute Pfade und Zugangsdaten werden nicht übernommen. Ein grüner
Jobname beweist nur den tatsächlich ausgeführten Befehl und Runner. Exact-Head-
Evidence wird unmittelbar vor dem Merge gegen den aktuellen PR-Head erneuert.

### Quellenrangfolge

1. aktuelle Wrapper-, Parameter- und Runtime-Verträge;
2. aktuelle Manpage und generierte Skriptreferenz;
3. strukturierte Reports und reproduzierbare Tests;
4. gemergte Feature-Evidence;
5. historische Migrationsdokumente nur als historische Grenze.

Die maschinenlesbare
[Quellenmatrix](agentic-workspace-efficiency-source-matrix.json) bindet jede
Option, Statusklasse, Evidence-Datei und nächste Aktion an genau eine aktuelle
Quelle oder eine ausdrücklich nicht normative historische Grenze.

## Effizienz ohne Qualitätsverlust

- Erst inventarisieren, dann schreiben.
- Bestehende sichere Skripte und Check-Modi verwenden.
- Gültige Evidence verifizieren und nicht blind neu erzeugen.
- Gemeinsame Writer serialisieren; unabhängige read-only Prüfungen bündeln.
- Reports über Run-ID referenzieren.
- Fehlerklassen und nächste Aktionen statt vollständiger Logs übergeben.
- Keine leeren PRs und keine spekulativen Follow-up-Intakes erzeugen.
- Geschwindigkeit nie gegen Tests, Reviews, A11Y oder langfristige Wartbarkeit
  ausspielen.

### GitHub-Actions-Runnerprofil

Die kontinuierlichen, kopierten Workflows `Maintenance TUI` und
`PowerShell Static Analysis` verwenden außerhalb der drei öffentlichen
Referenz-Repositories nur `ubuntu-22.04`. Die vollständige
Linux-/macOS-/Windows-Matrix bleibt auf `hindermath/home-baseline`,
`hindermath/agent-operations-cockpit` und `hindermath/TuiVision` als
plattformübergreifender Canary erhalten. Dadurch prüfen private
Fleet-Repositories weiterhin jeden Push und Pull Request, vervielfachen aber
nicht zwei generische Wartungsgates auf kostenpflichtigen Windows- und
macOS-Runnern.

Produktspezifische Workflows bleiben davon unabhängig. Ein Swift-, Windows-,
.NET-Framework- oder anderer plattformgebundener Build behält den Runner, den
sein tatsächlicher Produktvertrag benötigt. Die Runnerreduktion ist deshalb
keine pauschale Abschaltung plattformspezifischer Produktprüfungen.

## Weiterführende Quellen

- [Betrieb und Wartung](README.md)
- [Source und Home Runtime](../architecture/source-and-home-runtime.md)
- [Prüfung und Fehleranalyse](../troubleshooting/README.md)
- [Wartungs-Manpage](../man/maintain-agentic-workspace.1.md)
- [Wartungs-TUI-Architektur](../architecture/maintenance-tui.md)
- [Wartungs-TUI-A11Y](../accessibility/maintenance-tui.md)
- [Skriptreferenz](../scripts/reference.md)
