# Workflow-/Ruleset-Vertrag / Workflow and Ruleset Contract

## Zweck und Stufe-A-Grenze / Purpose and Stage A Boundary

Dieser Vertrag definiert die in Stufe A simulierbare Teilmenge von Workflow-
Triggern, Pfadfiltern und Default-Branch-Schutz. Die späteren kanonischen
Templates liegen unter:

- `scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml`
- `scripts/templates/ci-budget-governance/private-governance-ruleset.json`

Sie sind keine aktiven `.github/workflows/`-Dateien und werden nicht an GitHub
gesendet. Stufe A liest Live-Zustand, simuliert Entscheidungen und erzeugt
maschinenlokale Planungsevidence. Sie ändert kein Workflow, Ruleset,
Repository, Konto, Reviewer-Setting oder G4-Artefakt.

*This contract defines the workflow-trigger, path-filter, and default-branch
protection subset that Stage A may simulate. Templates remain inactive Level-0
sources; Stage A performs no GitHub or target-repository mutation.*

## Autoritative Repository-Menge / Authoritative Repository Set

Klassifikation, Inventur und Rolloutplanung verwenden exakt die Vereinigung
aus dem Level-0-Self-Record `home-baseline`, dessen Remote aus dem ausführenden
Level-0-Repository und dessen konfiguriertem `origin` aufgelöst wird, und allen
aktiven `kind=git-repository`-Zielen in
`scripts/config/agentic-workspace-fleet.json`. Das Manifest enthält Level 0
absichtlich nicht. Der aktive Knoten `spec-kit-preset-projects` ist eine
Collection und bleibt ausgeschlossen. Der aktuelle Bestand ist 1 + 47 = 48
Git-Repositories; jede Assignment-, Inventory- und Rollout-ID-Menge muss dieser
Union exakt entsprechen. `home-baseline`, `agent-operations-cockpit` und
`tui-vision` sind verpflichtende Public Canaries.

*Classification, inventory, and rollout planning use exactly the Level-0
`home-baseline` self record plus all active manifest `git-repository` targets.
The collection node is excluded; the current authoritative count is 48.*

## Atomare Snapshot-Quelle / Atomic Snapshot Source

`InventoryRolloutPlan.source` und `InventoryRolloutPlan.sourceRevision` werden
genau einmal an der Wurzel gesetzt und gelten gemeinsam für jeden
`RepositoryInventoryEntry` des Snapshots. `sourceRevision` bindet den
vollständigen Adapterabruf beziehungsweise das vollständige Fixture. Ein
Repository-Eintrag behält `observedAt`, besitzt jedoch weder `source` noch
`sourceRevision`. Fixture-/Live-Mischungen, repositorylokale Revisionen und
partielle Refreshes sind ungültig; nach Drift wird die gesamte autoritative
Menge mit genau einem Adapter und einer neuen gemeinsamen Revision ermittelt.

*The plan root owns one source and one revision for the complete atomic
snapshot. Repository rows retain their observation time but no source fields;
mixed or partially refreshed snapshots fail closed.*

Jeder Repository-Eintrag trägt zusätzlich ein bewusst denormalisiertes
`profileId`. Der Wert wird ausschließlich nach erfolgreicher Assignment- und
Sichtbarkeitsvalidierung aus `CIProfileAssignment.profileId` kopiert und muss
mit Assignment und zugehörigem Rollout-Eintrag übereinstimmen. Abweichung ist
Drift und blockiert vor der Planung.

*Each repository row also carries a deliberately denormalized `profileId`,
copied only after successful assignment and visibility validation. It must
equal the assignment and rollout values; mismatch is pre-planning drift.*

## Kanonische Profile / Canonical Profiles

| Profil / Profile | Sichtbarkeit | PR-Vertrag | Main-/Schedule-Vertrag |
|---|---|---|---|
| `Public Canary` | public | erforderliche öffentliche Standard-Runner-CI erhalten | `home-baseline`, `AgentOperationsCockpit`, `TuiVision` bleiben die drei Canaries |
| `Public Product` | public | erforderliche öffentliche Produkt-CI erhalten | fachlich erforderliche öffentliche Main-/Schedule-Jobs erhalten |
| `Private Product` | private | pfadabhängige Produktprüfung | kein identischer Main-Rebuild ohne getrennten fachlichen Zweck |
| `Private Governance/Scaffold` | private | genau ein schlanker pfadabhängiger Minimal-Gate; vollständige Pflichtprüfungen lokal | keine automatischen vollständigen PR-/Main-Builds |
| `Public Preset` | public | Flottenpipeline oder lokale Evidence | keine neuen repositoriespezifischen Workflows für die zwölf Presets |

## Minimal-Gate-Vertrag / Minimal Gate Contract

Für `Private Governance/Scaffold` muss die Simulation folgende Aussagen
gleichzeitig beweisen:

1. `pull_request` ist der einzige automatische Trigger des Minimal-Gate.
2. Es existiert genau ein erforderlicher Statusname
   `home-baseline/ci-minimal-gate`.
3. Der Gate verwendet einen Standard-Linux-Runner und ausschließlich die durch
   die versionierten Pfadverträge ausgewählten schlanken Prüfungen.
4. Vollständige private PR- und Main-Builds sind nicht geplant.
5. Der Default Branch verlangt einen Pull Request und den erfolgreichen Status.
6. Direkte, Web- und API-Schreibpfade auf den Default Branch sind gesperrt.
7. Admin-Bypass ist weder Voraussetzung noch normaler Pfad.
8. Ein fehlender oder umgangener lokaler Hook verändert keine dieser Regeln.

Ein Template mit null oder mehr als einem erforderlichen Minimal-Gate, einem
ungefilterten Full Build, einem `push`-Main-Trigger oder einem erlaubten
Default-Branch-Bypass ist ungültig.

## Pfadvertrag / Path Contract

`scripts/config/ci-budget-path-contracts.json` ist die einzige Laufzeitquelle
für Pfadverträge. Sie wird gegen
`scripts/config/ci-budget-path-contracts.schema.json` validiert; der
Designvertrag liegt unter
`specs/029-ci-budget-governance/contracts/ci-budget-path-contracts.schema.json`.
Die Profilregistry enthält keine Pfadverträge. Der Engine-Prozess lädt und
validiert Profil- und Pfadregistry jeweils genau einmal. Danach blockiert die
dateiübergreifende Semantikprüfung unbekannte Gate-IDs gegenüber den Gate Sets,
unbekannte Produktjob-IDs gegenüber den Workflow-Templates und jede zweite
eingebettete Pfadvertragsquelle.

*The path-contract registry is the sole runtime owner. The engine loads and
validates each registry exactly once, then rejects unknown gate/product-job
references or any second embedded path-contract source.*

Pfadfilter sind versionierte Prozessanforderungen. Der Simulator normalisiert
Repository-relative Pfade, lehnt absolute Pfade, `..`, NUL und Zeilenumbrüche
ab und bewertet alle passenden Kategorien:

- `build`: Buildskripte, Projekt-/Solution-/Package-Metadaten;
- `security`: Hook, Secret Scan, Security-Konfiguration und Security-Evidence;
- `governance`: Constitution, Spec-Kit-Presets, Agent-/Governance-Verträge;
- `dependency`: Lockfiles, Paket-/Tool-Registries, Dependency-Konfiguration;
- `product`: produktspezifischer Quell-/Testpfad;
- `documentation`: reine Bedien-/Referenzdokumentation.

Mehrfachtreffer bilden die deduplizierte Vereinigung aller Gate-/Job-IDs.
`documentation` unterdrückt niemals einen gleichzeitig getroffenen Security-,
Governance- oder Dependency-Gate. Die Ausgabe wird nach stabiler Job-ID
sortiert.

## Sonderfälle / Special Cases

- **CaseTracker**: Änderungen an allen sechs Sprachrepositories erzeugen
  höchstens je einen passenden Produktjob, insgesamt höchstens sechs.
- **Swift**: Der Pflicht-PR-Nachweis nutzt Linux. macOS ist ausschließlich
  wöchentlich oder manuell ein getrennter Plattformnachweis.
- **Private Release Please**: nur `schedule` (wöchentlich) und
  `workflow_dispatch`; kein PR-/Push-Automatismus.
- **Canaries**: exakt `home-baseline`, `agent-operations-cockpit` und
  `tui-vision`.
- **Public Presets**: keine neuen Einzelworkflow-Diffs; nur `FleetPipeline`
  oder lokale Evidence als Gate-Entscheidung.
- **Reine Dokumentation**: kein Produktbuild, sofern keine verpflichtende
  Security-/Governance-/Dependency-Fläche getroffen wird.

## Ruleset-Simulationsfelder / Ruleset Simulation Fields

Das Ruleset-Template muss mindestens enthalten:

| Feld / Field | Verbindlicher Wert / Binding value |
|---|---|
| `target` | `default_branch` |
| `enforcement` | simuliert `active`; Stufe A markiert `applied=false` |
| `pullRequestRequired` | `true` |
| `requiredStatusChecks` | exakt `home-baseline/ci-minimal-gate` für Private Governance |
| `requireStatusChecksToPass` | `true` |
| `blockedWritePaths` | `direct`, `web`, `api` |
| `adminBypassNormalPath` | `false` |
| `remoteConverged` | `false` |

Der Simulator akzeptiert nur diese deklarative Teilmenge. Unbekannte
schutzrelevante Eigenschaften führen zu `Blocked`, nicht zu einer Annahme über
Providerverhalten.

## Workflow-Simulationsfelder / Workflow Simulation Fields

Der Workflow-Parser akzeptiert nur:

- Trigger: `pull_request`, `push`, `schedule`, `workflow_dispatch`;
- positive/negative Pfadmuster aus der Pfadregistry;
- stabile Workflow- und Job-ID, `runs-on`, referenzierte Gate-ID und deklarierte
  Schedule-Frequenz;
- ein optionales `businessPurpose` für einen getrennten Main-Nachweis.

Expressions, dynamische Matrixerzeugung, externe schreibende Actions und
unbekannte Trigger sind in der Stage-A-Vertragssimulation fail-closed. Das
bedeutet nicht, dass GitHub diese Syntax allgemein nicht unterstützt; sie liegt
nur außerhalb der beweisbaren Teilmenge dieses Features.

## Deterministische Simulation / Deterministic Simulation

Eingabe ist `(source, sourceRevision, profileRegistryHash, pathContractHash,
inventorySnapshotHash, repositoryId, profileId, defaultBranch, changedPaths,
simulatedEvent, fixtureClock)`. `profileRegistryHash` und `pathContractHash`
stammen aus getrennt kanonisierten, jeweils genau einmal geladenen und
schema-validierten Quellen und bleiben eigenständige Felder. `source` und
`sourceRevision` stammen aus der
Wurzel desselben vollständig validierten Snapshots; eine repositorylokale
Abweichung ist nicht darstellbar. Ausgabe ist:

```text
repositoryId
profileId
matchedPathContractIds[]
plannedJobIds[]
requiredStatusChecks[]
gateDecision
blockers[]
remoteConverged=false
```

Arrays werden nach den Regeln aus `data-model.md` geordnet. Zeitstempel gehört
nicht zum Entscheidungshash. Gleiche Eingaben erzeugen gleiche normalisierte
Ausgabe und denselben Exitcode. Vor der Simulation muss
`RepositoryInventoryEntry.profileId` exakt der validierten
`CIProfileAssignment.profileId` entsprechen; eine Abweichung blockiert.

Inventory-Evidence stellt jeden beobachteten Job als genau einen
`WorkflowJobInventoryEntry` mit `workflowId`, `jobId`, Triggern, Runnern,
`averageDurationSeconds` und `plannedRuns` dar. Die Einträge werden nach
`workflowId`, dann `jobId` geordnet; Dauer und geplante Läufe liegen nicht auf
Repository-Ebene.

## Sicherheits- und Mutationsbarriere / Security and Mutation Barrier

Der read-only Adapter darf nur REST-GET-Leseoperationen beobachten. Tests
injizieren einen Transport-Spy und schlagen bei POST, PUT, PATCH, DELETE,
Ruleset-/Account-/Reviewer-Schreibpfaden oder Zielrepository-Dateizugriffen
fehl. Der Git-Diff der Stufe A darf keine aktive Ruleset-, Copilot-Reviewer-
oder G4-Fläche enthalten. Ein grüner lokaler Hook ersetzt niemals die
serverseitige PR-/Statuspflicht.

## Abnahme / Acceptance

Der Vertrag gilt erst als implementiert, wenn positive und negative Fixtures
für alle fünf Profile, alle Pfadkategorien, Hook-Bypass, CaseTracker, Swift,
Release Please, Canaries, Public Presets und direkte/Web/API-Schreibpfade grün
sind. Eine aktive GitHub-Änderung ist kein zulässiger Abnahmenachweis in
Stufe A.
