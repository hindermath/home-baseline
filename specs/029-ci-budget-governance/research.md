# Technische Forschung: CI-Budget-Governance / Technical Research: CI Budget Governance

## 1. Gemeinsamer Engine-Prozess / Shared engine process

**Decision / Entscheidung**: Die vorhandenen Bash-/PowerShell-Wrapper leiten
`--ci-gate` beziehungsweise `-CiGate` nach lokaler Optionsprüfung an genau
einen Prozess von `scripts/lib/agentic_workspace_fleet.py` weiter. Der Kern
erhält getrennte Subcommands für lokalen Gate und read-only CI-Budget-Planung;
Gate-Kindprozesse werden innerhalb dieses einen Engine-Prozesses koordiniert.

**Rationale / Begründung**: Der Kern besitzt bereits Manifestvalidierung,
stabile Resultate, begrenzte Netzwerkfehlerklassifikation und atomare
`os.replace`-Publikation. Eine Erweiterung hält Bash und PowerShell fachlich
identisch und macht die Prozesszahl testbar. Executable und Argumente bleiben
getrennte Arrays für `subprocess.run(..., shell=False)`.

**Alternatives considered / Erwogene Alternativen**:

- Je Shell eine eigene Gate-Engine: verworfen wegen Paritäts- und
  Sicherheitsdrift.
- Neue .NET-Engine: verworfen als unnötige Runtime-/Supply-Chain-Erweiterung.
- Mehrere Python-Subcommand-Aufrufe durch den Wrapper: verworfen, weil HEAD,
  Gate-Set und Evidence dann nicht in einer Prozessgrenze atomar beweisbar sind.

## 2. Profilregistry / Profile registry

**Decision / Entscheidung**: Eine versionierte
`scripts/config/ci-budget-profiles.json` definiert einen Level-0-Self-Record
mit der stabilen ID `home-baseline`, referenziert zusätzlich die stabilen IDs
aus `agentic-workspace-fleet.json`, enthält genau fünf benannte Profile,
erwartete Sichtbarkeit, Gate-Set-Referenzen, Budgetparameter und genau eine
Assignment-Zeile je Repository der autoritativen Menge. Diese Menge ist die
Vereinigung aus dem Self-Record, der aus dem ausführenden Level-0-Repository
und dessen konfiguriertem `origin` aufgelöst wird, und allen aktiven
`kind=git-repository`-Manifestzielen. Das Manifest dupliziert Level 0
absichtlich nicht; `spec-kit-preset-projects` und alle anderen
Collection-Knoten sind verboten. Aktuell ergibt die Union 1 + 47 = 48
Git-Repositories. JSON Schema prüft Struktur; der Kern prüft Eindeutigkeit,
vollständige Mengengleichheit, Referenzen und Sichtbarkeitskompatibilität. Die
Registry besitzt ausschließlich Profile, Assignments, Gate Sets und
Budgetannahmen; Pfadverträge sind weder eingebettet noch durch ihr Schema
zugelassen.

**Rationale / Begründung**: Eine explizite Eins-zu-eins-Zuordnung ist
reviewbar und verhindert stille Heuristiken. `repositoryId` bleibt der einzige
Join-Key: für Level 0 ist er normativ `home-baseline`, für Ziele stammt er aus
dem Manifest. Name, Pfad und aktuelle Anzahl sind keine Klassifikatoren.
`home-baseline`, `agent-operations-cockpit` und `tui-vision` sind verpflichtende
Public Canaries. Live-Zahlen werden nach erfolgreicher Zuordnung berechnet.

**Alternatives considered / Erwogene Alternativen**:

- Profil aus Repository-Name/Pfad ableiten: verworfen, weil Drift unbemerkt
  Sicherheits- und Budgetentscheidungen ändern könnte.
- Profilfelder direkt ins Fleet Manifest mischen: verworfen, weil
  Wartungsinventar und CI-Governance unterschiedliche Versionszyklen besitzen.
- Snapshot `3/6/6/21/12` als Soll erzwingen: verworfen; er bleibt nur datierte
  Vergleichsevidence.

## 3. Kanonische Pfadregistry / Canonical path registry

**Decision / Entscheidung**:
`scripts/config/ci-budget-path-contracts.json` ist die einzige Laufzeitquelle
für Build-, Security-, Governance-, Dependency-, Product- und Documentation-
Include-/Exclude-Muster sowie deren Gate- und Produktjob-Referenzen. Der
Designvertrag ist
`contracts/ci-budget-path-contracts.schema.json`; in der Implementierung wird
er als `scripts/config/ci-budget-path-contracts.schema.json` installierbar
abgeleitet. Der eine Engine-Prozess lädt und schema-validiert Profilregistry
und Pfadregistry jeweils genau einmal. Anschließend prüft ein dateiübergreifender
semantischer Validator Gate-IDs gegen die Gate Sets der Profilregistry und
Produktjob-IDs gegen die stabilen Job-IDs der Workflow-Templates. Unbekannte
Referenzen oder ein zweites eingebettetes `pathContracts`-Feld blockieren vor
Klassifikation und Planung.

`profileRegistryHash` und `pathContractHash` entstehen getrennt aus dem
kanonischen JSON der jeweiligen vollständig validierten Quelldatei. Beide
bleiben eigenständige Felder und gehen als getrennte Eingaben in deterministische
Plan-/Simulationsentscheidungen ein.

**Rationale / Begründung**: Ein einziger Eigentümer verhindert konkurrierende
Sicherheits- und Jobentscheidungen. Getrennte Schema- und Hashgrenzen machen
sichtbar, ob Profilzuordnung oder Pfadsemantik gedriftet ist, ohne beide
Vertragsfamilien künstlich zu koppeln.

**Alternatives considered / Erwogene Alternativen**:

- `pathContracts` zusätzlich in der Profilregistry: verworfen als zweite
  Laufzeitwahrheit mit widersprüchlicher Hash- und Update-Semantik.
- Nur strukturelle Einzeldateiprüfung: verworfen, weil JSON Schema keine
  Gate-/Produktjob-Referenzen über Dateigrenzen zuverlässig auflösen kann.
- Einen kombinierten Registry-Hash verwenden: verworfen, weil Profil- und
  Pfadvertragsdrift getrennt auditierbar bleiben müssen.

## 4. Read-only Live-Inventur / Read-only live inventory

**Decision / Entscheidung**: Zwei Adapter liefern dieselbe normalisierte
Entität für jedes Mitglied der autoritativen Repository-Union. Der
Level-0-Self-Record wird aus der ausführenden Repositorywurzel und ihrem
konfigurierten `origin` ermittelt; Manifest-Targets werden nach `active=true`
und `kind=git-repository` gefiltert. `fixture` liest strikt validierte lokale
JSON-Fixtures.
`github-read-only` ruft `gh api --method GET` ausschließlich gegen REST-
Leseendpunkte und
Argument-Arrays auf, um Repository-Sichtbarkeit, Default Branch, Workflow-
Trigger, Runner-/Jobmetadaten, abgeschlossene Laufdauern und geplante Auslöser
zu ermitteln. Der Adapter enthält keine mutationstauglichen Verben oder
Endpunkte. Rohantworten werden nicht als Evidence gespeichert; nur minimierte,
schema-validierte Felder und ein Snapshot-Hash werden übernommen. Der Adapter
liefert `source` und `sourceRevision` genau einmal an der Wurzel des gesamten
`InventoryRolloutPlan`. `sourceRevision` bindet den vollständigen Snapshot;
Repository-Einträge behalten nur `observedAt`. Ein Mix aus Fixture- und
GitHub-Daten oder eine partielle Aktualisierung unter einer alten Revision ist
ungültig und blockiert den gesamten Snapshot.

**Rationale / Begründung**: Die bestehende authentifizierte `gh` CLI vermeidet
eine neue HTTP-/Auth-Abhängigkeit. Adapterinjektion macht Tests vollständig
offline und beweist durch einen Spy, dass Stufe A nur liest. Nicht verfügbare,
unvollständige oder zeitlich inkonsistente Antworten blockieren den aktuellen
Snapshot.

**Alternatives considered / Erwogene Alternativen**:

- Lokale Clones/Fetched Refs als Live-Wahrheit: verworfen; sie belegen keine
  aktuellen Workflow-, Sichtbarkeits- oder Runnerdaten und könnten Zielclones
  mutieren.
- Cache als Fallback: verworfen für aktuelle Evidence; ein alter Snapshot darf
  nur als historischer Vergleich sichtbar sein.
- Direkte REST-Bibliothek: verworfen, da sie Abhängigkeit und Tokenhandling
  erweitert.

## 5. Evidence-Atomizität und Hash-Bindung / Evidence atomicity and hash binding

**Decision / Entscheidung**: Der Gate-Kern liest `H0`, bildet aus der
normalisierten, geordneten Gate-Definition einen SHA-256, entwertet vor einem
echten Wiederholungslauf eine vorhandene finale Erfolgsdatei für denselben
Zielpfad, führt alle Gates aus, liest `H1` und berechnet den Gate-Set-Hash
erneut. Nur wenn `H0 == H1`, beide Hashes gleich und alle Einzelergebnisse
`Passed` sind, schreibt er UTF-8-JSON in eine exklusive temporäre Datei im
finalen Verzeichnis, setzt restriktive Rechte, flush/fsynct, validiert das
Schema und publiziert mit `os.replace`; anschließend wird das Verzeichnis
bestmöglich fsynct. Signal und Fehler entfernen die temporäre Datei. Preview
ändert weder alte noch neue Evidence.

**Rationale / Begründung**: Gleicher Parent und `os.replace` liefern die
portabelste vorhandene atomare Publikationsgrenze. Doppeltes Lesen bindet
Evidence an die tatsächlich geprüften Bytes. Die finale Datei enthält nur
Erfolg und kann daher vom Hook ohne Interpretation partieller Zustände gelesen
werden. Der Hash verwendet kanonisches JSON: UTF-8 ohne BOM, LF,
`sort_keys=True`, kompakte Separatoren; Timestamp und Laufdauer liegen
außerhalb des Gate-Set-Hashs.

Profil- und Pfadregistry werden davor jeweils genau einmal separat kanonisiert,
validiert und gehasht. `profileRegistryHash` und `pathContractHash` werden nicht
zusammengelegt. Der Entscheidungskontext führt beide Hashes getrennt; so ändert
Pfadmusterdrift den `pathContractHash`, selbst wenn eine Contract-ID gleich
bleibt.

**Alternatives considered / Erwogene Alternativen**:

- Direkt in die finale Datei schreiben: verworfen wegen Teildateien bei
  Abbruch.
- Nur HEAD vor dem Lauf lesen: verworfen wegen Concurrent-Change-Risiko.
- stdout oder Log als Evidence: verworfen, weil unstrukturiert, nicht
  hashgebunden und potenziell sensitiv.
- Erfolg und Fehler im selben finalen Pfad speichern: verworfen; nur Erfolg
  darf push-freigebende Evidence sein.

## 6. Workflow-/Ruleset-Simulation / Workflow and ruleset simulation

**Decision / Entscheidung**: Inaktive Templates unter
`scripts/templates/ci-budget-governance/` modellieren genau einen schlanken,
pfadabhängigen PR-Minimal-Gate und einen Ruleset-Vertrag mit PR-Pflicht,
erforderlichem Status und gesperrten direkten/Web/API-Default-Branch-Pfaden.
Der Simulator parst eine minimierte, versionsgebundene Teilmenge, kombiniert
alle zutreffenden Build-, Security-, Governance-, Dependency- und
Product-Pfadklassen per Set-Union und sortiert Jobs nach stabiler ID. Öffentliche
CI/Canaries bleiben erhalten; Public Presets erhalten keine Einzelworkflows.

**Rationale / Begründung**: Templates in `scripts/templates/` sind klar von
aktiven `.github/workflows/` und Remote-Rulesets getrennt. Eine geschlossene
Teilmenge ist deterministisch testbar und verhindert, dass der Simulator die
gesamte Providersemantik vortäuscht. Hook und Serververtrag bilden zwei
unabhängige Grenzen.

**Alternatives considered / Erwogene Alternativen**:

- Template direkt unter `.github/workflows/`: verworfen, weil dies einen
  aktiven Level-0-Workflow auslösen könnte.
- GitHub-Ruleset in Stufe A anwenden: verboten durch Delivery Authority.
- Nur Hook prüfen: verworfen als Single Point of Bypass.
- Ersten passenden Pfadfilter wählen: verworfen; Mehrfachtreffer müssen alle
  relevanten Gates auslösen.

## 7. Budgetmodell / Budget model

**Decision / Entscheidung**: Das Modell führt vier Kategorien getrennt:
`recurringPrivateJobsPerWeek`, `demandMinimalGateRuns`,
`privateActionsMinutesPerMonth` und `copilotReviewRunnerMinutes`. Geplante
Läufe, gemessene durchschnittliche Dauer und deklarierte, reviewbare
Billable-Minute-Annahmen sind Eingaben; Python `Decimal` und der rationale
Faktor `52/12` vermeiden binäre Rundungsdrift. Summen werden erst für die
Anzeige auf zwei Dezimalstellen gerundet. Copilot-Werte fließen niemals in den
Actions-Minutenwert ein. Fehlende Werte bleiben Blocker, nicht Null.

**Rationale / Begründung**: Die Trennung erfüllt CBG-016 und verhindert eine
irreführende Mischsumme. Ein explizites Annahmenfeld erklärt jede Abweichung
vom Planwert von ungefähr 22 Jobs/Woche und macht die `<500/3000`-Prüfung
reproduzierbar, ohne providerabhängige Billingregeln zu erraten.

**Alternatives considered / Erwogene Alternativen**:

- Fließkomma und frühe Rundung: verworfen wegen Plattformdrift.
- Copilot-Zeit zu Actions addieren: normativ verboten.
- Fehlende Dauer als Null behandeln: verworfen, weil dies das Budget künstlich
  grün machen würde.
- Harte Snapshot-Kardinalitäten: verworfen zugunsten validierter Live-Zahlen.

## 8. Retry, Backoff und Abbruch / Retry, backoff, and interruption

**Decision / Entscheidung**: Der vorhandene bounded-retry-Stil wird auf
Live-Abfragen übertragen: standardmäßig maximal drei Versuche, exponentielle
Verzögerung 0,25/0,5/1,0 Sekunden plus begrenzter Jitter; serverseitiges
`Retry-After` wird bis zu einer festen Obergrenze berücksichtigt. Nur Timeout,
Connection Reset, DNS- und HTTP-502/503/504-/explizite Rate-Limit-Antworten
gelten als transient. Authentifizierung, Autorisierung, 404, Schema-,
Profil-, Sichtbarkeits-, HEAD- und Evidence-Fehler werden nie wiederholt.
Tests injizieren Sleeper/Uhr/Jitter. `Ctrl+C` endet mit 130 und ohne neue
Erfolgsevidence.

**Rationale / Begründung**: Begrenzter Retry erhöht Verfügbarkeit, ohne
Berechtigungs- oder Vertragsfehler zu verschleiern. Injektion hält Tests schnell
und deterministisch. Der Lauf nutzt keinen Cache als aktuellen Ersatz.

**Alternatives considered / Erwogene Alternativen**:

- Unbegrenzter Retry: verworfen wegen Hängen und Rate-Limit-Verstärkung.
- Jeder Fehler transient: verworfen, weil Auth-/Schemafehler nicht durch Zeit
  heilen.
- Kein Retry: verworfen, weil kurze Transportfehler unnötig alle aktuell 48 Einträge
  blockieren würden.

## 9. Acceptance-Aggregation / Acceptance aggregation

**Decision / Entscheidung**: Jedes `AC-CBG-001` bis `AC-CBG-010` erhält genau
einen Primary-Einstieg:
`python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-NNN
--repository-root . --evidence-root
.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence`.
`NNN` ist die jeweilige Gate-ID `001` bis `010`; damit ist jeder tatsächliche
Aufruf vollständig bestimmt. Der Aggregator
führt den kompletten Gate-Scope aus oder validiert alle zugehörigen Nachweise
fail-closed. Bash-, PowerShell-, manuelle und Fixture-Nachweise sind interne,
maschinenlokale Eingabedateien des Aggregators. Er prüft Vollständigkeit,
Schema, erwarteten Inhalt und Hashdrift und nimmt jeden normalisierten
SHA-256-Wert in sein eigenes Ergebnis auf. Interne Inputs sind keine autonomen
Gate-Evidence-Zeilen und enthalten kein `supplementalFor`.

Das finale Schema-2.0-Acceptance-Artefakt dieses Laufs besitzt genau zehn
`Primary`-Zeilen, eine je AC, und null `Supplemental`-Zeilen. Jede Primary-
Zeile enthält den real ausgeführten Aggregatorbefehl mit ihrer AC-ID und
`runnerOrPlatform="macOS"`.

`AC-CBG-008` orchestriert Bash-Syntax, PowerShell/PSScriptAnalyzer,
Paritätsfixtures, Secret Scan, A11Y, Dokumentation, Workflow und Statistik.
`AC-CBG-009` kombiniert Mutation-Spy und exakte Stufe-A-Git-Diff-Allowlist.
`AC-CBG-010` kombiniert Fixture-Vollständigkeit mit dem getrennt
kontrollierten read-only Live-Inventurergebnis. Bash und PowerShell werden je
mindestens auf einem Ziel-OS manuell ausgeführt; aktuell belegt macOS beide
Varianten. Fixtures belegen die semantische macOS-/Linux-/Windows-
Normalisierung, ohne eine nicht ausgeführte Runner-Plattform zu behaupten.

**Rationale / Begründung**: Ein einzelner tatsächlich ausgeführter Einstieg
ist eindeutig gegen `executedCommand` und `runnerOrPlatform` prüfbar. Interne
hashgebundene Eingaben erhalten die vollständige Cross-Platform- und manuelle
Evidence, ohne zusätzliche oder semantisch widersprüchliche Gate-Zeilen zu
erzeugen.

**Alternatives considered / Erwogene Alternativen**:

- Mehrere getrennte Primary-Kommandos je AC: verworfen, weil genau ein Primary
  pro Gate erforderlich ist.
- macOS, Linux und Windows in jeder Primary-Zeile verlangen: verworfen, weil
  nur tatsächlich ausgeführte Runner behauptet werden dürfen.
- Interne Plattform-/Manualrecords als autonome Evidence-Zeilen veröffentlichen:
  verworfen, weil der aktuelle Lauf ausschließlich die zehn Aggregator-
  Primaries als finale Gate-Zeilen zulässt.

## 10. Teststrategie / Test strategy

**Decision / Entscheidung**: Eine neue `unittest`-Datei verwendet denselben
`tempfile`-/Subprocess-Stil wie die bestehenden Maintenance-Tests. Gemeinsame
JSON-Fixtures decken fünf Profile, Sichtbarkeits-/Mappingdrift, Null/eins/
mehrere Repositories einschließlich der aktuellen 1+47-Union,
Shell-Metazeichen, Pfadmehrfachtreffer, Swift,
Release-Please, sechs CaseTracker-Produkte, Canaries, Presets, Budget,
HEAD-/Gate-Set-Wechsel, atomare Abbrüche, Hook-Bypass und read-only Adapter ab.
Ein Fake-Engine-Launcher zählt Prozesse. Normalisierte Bash-/PowerShell-
Resultate werden feldweise und per Exitcode verglichen. Echte manuelle
Verifikation erfolgt je Variante auf mindestens einem Ziel-OS. In diesem Lauf
werden Bash und PowerShell 7 beide unter macOS manuell ausgeführt; portable
Fixtures beweisen die semantische macOS-/Linux-/Windows-Normalisierung. Keine
Teststufe schreibt zu GitHub oder in Zielrepositories.

**Rationale / Begründung**: Deterministische Fixtures isolieren fachliche
Entscheidungen von Netz- und Uhrdrift. Bestehende Regressionen schützen die
großen Wrapper. Negative Mutation-Spies beweisen die Stage-A-Grenze stärker
als reine Dokumentation.

**Alternatives considered / Erwogene Alternativen**:

- Nur End-to-End gegen GitHub: verworfen wegen Nichtdeterminismus, Rate Limits
  und möglicher Mutation.
- Shell-Goldenfiles ohne semantische Normalisierung: verworfen wegen
  plattformspezifischem Whitespace.
- Nur Unit Tests des Kerns: verworfen, weil Wrapper, Hook, Prozesszahl und
  Plattformvertrag sonst unbelegt blieben.
