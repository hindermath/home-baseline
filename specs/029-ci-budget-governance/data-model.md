# Datenmodell: CI-Budget-Governance / Data Model: CI Budget Governance

## Modellgrenze / Model Boundary

Das Modell trennt versionierte Level-0-Quellen, read-only Live-Beobachtungen
und maschinenlokale Evidence. Registry und Templates sind Git-getrackt.
Inventory-, Gate- und Rollout-Evidence bleibt außerhalb von Git. Die stabile
`repositoryId` ist der einzige Join-Key. Die autoritative Repository-Menge ist
die Vereinigung aus genau einem Level-0-Self-Record mit `repositoryId` =
`home-baseline`, aufgelöst aus dem ausführenden Level-0-Repository und dessen
konfiguriertem `origin`, und allen aktiven `kind=git-repository`-Zielen aus
`scripts/config/agentic-workspace-fleet.json`. Das Manifest dupliziert Level 0
absichtlich nicht. Ein Collection-Knoten ist nie ein Repository-
Inventareintrag; insbesondere bleibt `spec-kit-preset-projects` ausgeschlossen.
Die aktuelle Menge enthält 1 + 47 = 48 Git-Repositories.

*The model separates versioned Level-0 sources, read-only live observations,
and machine-local evidence. The stable repository ID is the only join key. The
authoritative set is the Level-0 `home-baseline` self record plus every active
manifest `git-repository`; collection nodes never become repository inventory
entries.*

## 1. CIProfile / CI-Profil

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `profileId` | enum | Genau `public-canary`, `public-product`, `private-product`, `private-governance-scaffold`, `public-preset`. |
| `displayName` | enum string | Exakt die fünf Namen aus CBG-002. |
| `requiredVisibility` | `public` oder `private` | Canary/Product/Preset öffentlich; Private Product/Governance privat. |
| `gateSetId` | stable ID | Muss genau ein vorhandenes Gate Set referenzieren. |
| `workflowPolicyId` | stable ID | Muss einen Workflow-/Ruleset-Vertrag referenzieren. |
| `budgetClass` | enum | `public`, `private-recurring`, `private-demand`, `no-repository-workflow`. |

**Eindeutigkeit / Uniqueness**: fünf Profile, jede `profileId` und jeder
`displayName` genau einmal. Reihenfolge ist die oben genannte kanonische
Reihenfolge, nicht Dateireihenfolge.

## 2. CIProfileAssignment / CI-Profilzuordnung

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `repositoryId` | stable ID | Entweder exakt `home-baseline` für den Level-0-Self-Record oder genau eine ID eines aktiven `kind=git-repository`-Manifestziels. |
| `profileId` | CIProfile reference | Muss vorhanden und sichtbarkeitskompatibel sein. |
| `rationale` | non-empty string | Kurze reviewbare fachliche Begründung, keine automatische Heuristik. |

**Mengengrenze / Set boundary**: `assignment.repositoryId` muss exakt der
autoritativen Union aus `home-baseline` und allen aktiven
`kind=git-repository`-Manifest-IDs entsprechen. Aktuell sind dies 48 IDs.
`home-baseline` muss wie `agent-operations-cockpit` und `tui-vision` dem Profil
`public-canary` zugeordnet sein. Unbekannt, fehlend, doppelt, eine Collection-
ID oder eine Manifestduplikation von Level 0 führt vor Inventory-/Kosten-/
Rolloutplanung zu `Blocked`.

## 3. RepositoryInventoryEntry / Repository-Inventareintrag

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `repositoryId` | stable ID | Join auf Assignment; lexikografischer Sortierschlüssel. |
| `profileId` | CIProfile reference | Bewusst denormalisiert; erst nach erfolgreicher Assignment- und Sichtbarkeitsvalidierung aus `CIProfileAssignment.profileId` kopiert und zwingend wertgleich. |
| `remoteIdentity` | normalized owner/name or forge identity | Für `home-baseline` aus konfiguriertem Level-0-`origin`, sonst passend zur Manifest-Remote; Credentials und Querystrings verboten. |
| `visibility` | `public`/`private` | Muss zum Profil passen. |
| `defaultBranch` | string | Nicht leer; Änderung gegenüber Manifest wird als Drift ausgewiesen. |
| `workflows` | ordered WorkflowJobInventoryEntry array | Nach `workflowId`, dann `jobId`; keine Dauer-/Run-Aggregate auf Repository-Ebene. |
| `observedAt` | RFC 3339 UTC | Adapterzeitpunkt; nicht Bestandteil fachlicher Entscheidungshashes. |

**Datenminimierung / Data minimization**: keine Tokens, Personen-/Actor-Namen,
Logtexte, private Billingdetails oder Workflow-Secrets. Rohantworten werden
nicht in das Rolloutmodell übernommen.

`RepositoryInventoryEntry` besitzt ausdrücklich weder `source` noch
`sourceRevision`. Quellenidentität und Frische gehören ausschließlich zum
atomaren Snapshotvertrag des `InventoryRolloutPlan`.

`profileId` ist dagegen eine absichtliche Denormalisierung für eigenständig
prüfbare Inventory-Evidence. Der Adapter darf den Wert nicht aus Name, Pfad,
Sichtbarkeit oder Live-Daten ableiten. Erst nachdem genau eine
`CIProfileAssignment` für `repositoryId` existiert und deren Profil sowie
Sichtbarkeit erfolgreich validiert wurden, kopiert der Planer deren
`profileId`. Ein fehlender oder abweichender Wert ist Drift und blockiert vor
Inventory-/Rolloutplanung. Dasselbe gilt für eine Abweichung zwischen dem
Inventory-Eintrag und dem zugehörigen `RolloutPlanEntry`.

### 3.1 WorkflowJobInventoryEntry / Workflow-/Job-Inventareintrag

Jeder verschachtelte Eintrag beschreibt genau einen stabil identifizierten Job
innerhalb eines Workflows. Workflow- und Jobebene werden nicht in getrennte,
inkonsistente Zwischenformen aufgeteilt.

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `workflowId` | stable ID | Erforderlich; stabil über Live- und Fixture-Adapter. |
| `jobId` | stable ID | Erforderlich und innerhalb `workflowId` eindeutig. |
| `triggers` | ordered enum array | Nur `pull_request`, `push`, `schedule`, `workflow_dispatch`; dedupliziert. |
| `runners` | ordered non-empty string array | Normalisierte tatsächliche oder geplante Runnerbezeichnungen; dedupliziert. |
| `averageDurationSeconds` | non-negative decimal string or `null` | `null` ist sichtbarer Budgetblocker, nie stillschweigend 0. |
| `plannedRuns` | non-negative decimal string or `null` | Quelle/Zeitraum erforderlich; `null` blockiert betroffene Kostenabnahme. |

Das `workflows`-Array eines Repository-Inventareintrags wird zuerst nach
`workflowId`, dann nach `jobId` sortiert. Budgetberechnungen aggregieren Dauer
und geplante Läufe aus diesen Job-Einträgen; Repository-Einträge besitzen
keine konkurrierenden Felder `averageDurationSeconds` oder `plannedRuns`.

## 4. PathContract / Pfadvertrag

Die einzige Laufzeitquelle dieser Entitäten ist
`scripts/config/ci-budget-path-contracts.json`; ihr Designvertrag ist
`contracts/ci-budget-path-contracts.schema.json`, der installierbare
Laufzeitvertrag wird als
`scripts/config/ci-budget-path-contracts.schema.json` geplant. Die
Profilregistry enthält keine eingebetteten `pathContracts` und besitzt nur
Profile, Assignments, Gate Sets und Budgetannahmen. Der Engine-Prozess lädt und
schema-validiert Profil- und Pfadregistry jeweils genau einmal. Ein zweiter
eingebetteter Pfadvertragseigentümer blockiert.

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `pathContractId` | stable ID | Eindeutig und versioniert. |
| `category` | enum | `build`, `security`, `governance`, `dependency`, `product`, `documentation`. |
| `includePatterns` | ordered glob array | Repository-relative, kein absoluter Pfad, kein `..`, kein NUL. |
| `excludePatterns` | ordered glob array | Gleiche Pfadvalidierung; darf Pflichtflächen nicht neutralisieren. |
| `gateIds` | ordered unique references | Mehrfachtreffer werden per Union kombiniert, nicht first-match. |
| `productJobId` | conditional stable ID | Für `product` erforderlich und eindeutig je Produkt/Runtime; für alle anderen Kategorien verboten. |

**Auswertung / Evaluation**: Normalisierte geänderte Pfade werden sortiert.
Alle passenden Contracts werden gesammelt; Gate-/Job-IDs werden dedupliziert
und nach Registry-Reihenfolge ausgegeben. Reine Dokumentation darf nur dann
ohne Produktjob bleiben, wenn kein Security-/Governance-/Dependency-Contract
trifft.

**Querverweise / Cross-file references**: Nach der jeweiligen einmaligen
Schemavalidierung prüft der semantische Validator jede `gateId` gegen die
Gate-Definitionen der Profilregistry und jede `productJobId` gegen die stabilen
Job-IDs der Workflow-Templates. Unbekannte Referenzen blockieren vor
Pfadauswertung oder Planung. `profileRegistryHash` und `pathContractHash`
werden aus den separat kanonisierten Quelldateien gebildet und bleiben zwei
eigenständige SHA-256-Felder.

## 5. GateSet und GateDefinition / Gate Set and gate definition

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `gateSetId` | stable ID | Eindeutig und vom Profil referenziert. |
| `version` | semantic version | Änderung der Gate-Semantik erhöht Version und Hash. |
| `gates` | ordered non-empty array | Stabile `order`-Werte ohne Lücke und eindeutige `gateId`. |
| `gateId` | stable ID | Referenzziel für Ergebnis und Pfadvertrag. |
| `executable` | repository-relative or approved tool name | Keine Shell-Zeichenfolge; Allowlist/Existenzprüfung. |
| `arguments` | ordered string array | Jedes Argument eigener Wert; kein `eval`, keine Shellinterpolation. |
| `workingDirectory` | repository-relative path | Muss innerhalb des geprüften Repositorys bleiben und darf kein Symlink-Escape erlauben. |
| `timeoutSeconds` | bounded integer | Positiv, mit zentraler Obergrenze. |

**Gate-Set-Hash / Gate-set hash**: SHA-256 über kanonisches JSON aus
`schemaVersion`, `gateSetId`, `version`, geordneten Gate-Feldern und den
ausgelösten Path-Contract-IDs. Ausgeschlossen sind Timestamp, Dauer, Ausgabe,
Home-Pfad und Plattformdarstellung.

## 6. IndividualGateResult / Einzelgate-Ergebnis

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `order` | integer | Muss der Gate-Set-Reihenfolge entsprechen. |
| `gateId` | reference | Genau einmal für jedes ausgewählte Gate. |
| `commandDigest` | lowercase SHA-256 | Hash der Argument-Array-Darstellung, nicht eines Shellstrings. |
| `status` | enum | In finaler Erfolgsevidence ausschließlich `Passed`. Intern außerdem `Failed`, `Interrupted`, `TimedOut`, `Missing`. |
| `exitCode` | integer or `null` | Final `Passed` verlangt `0`; `null` nur intern bei Nichtstart/Abbruch. |
| `durationMs` | non-negative integer | Beobachtung, nicht Teil des Gate-Set-Hashs. |

stdout/stderr werden nur gekürzt und sanitisiert in lokale Diagnoseausgabe
gegeben und sind kein Pflichtfeld erfolgreicher Evidence.

## 7. CIGateEvidence / CI-Gate-Evidence

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `schemaVersion` | const `1.0` | Muss dem Vertrag entsprechen. |
| `repositoryId` | stable ID | Muss aktuell zum Repository und Profil passen. |
| `headCommit` | 40/64 lowercase hex | Start- und End-HEAD müssen identisch sein. |
| `ciProfile` | profile display name | Aus aktueller Assignment-Registry. |
| `gateSetHash` | lowercase SHA-256 | Muss aus dem aktuellen Gate Set neu berechnet stimmen. |
| `platform` | `macos`/`linux`/`windows` | Normalisierte Plattform, keine freie Anzeige. |
| `generatedAt` | RFC 3339 UTC | Darf variieren; nicht Teil von Gate-Set-/Entscheidungshash. |
| `hookVersion` | semantic version | Pre-push vergleicht Mindest-/exakte Vertragsversion. |
| `status` | const `Passed` | Finale Datei ist ausschließlich Erfolgsevidence. |
| `results` | ordered IndividualGateResult array | Vollständig, keine fehlenden/übersprungenen/fehlgeschlagenen Gates. |

**Pfad / Path**:
`~/.home-baseline/evidence/ci-gates/<repositoryId>/<headCommit>.json`. Jede
Komponente wird vor Pfadbildung validiert; Symlink-/Traversal- oder unsicherer
Parent blockiert. Datei und temporäre Datei sind maschinenlokal und nicht
Git-getrackt.

## 8. WorkflowRulesetPolicy / Workflow-/Ruleset-Richtlinie

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `policyId` | stable ID | Vom Profil referenziert. |
| `pullRequestRequired` | boolean | Für private Governance `true`. |
| `requiredStatusChecks` | ordered IDs | Private Governance exakt ein Minimal-Gate. |
| `blockedDefaultBranchWritePaths` | enum array | `direct`, `web`, `api` vollständig. |
| `adminBypassNormalPath` | const `false` | Admin-Bypass weder Voraussetzung noch Normalpfad. |
| `triggers` | normalized set | Profilabhängige PR/main/schedule/manual-Regeln. |
| `pathContractIds` | ordered references | Jede relevante Fläche versioniert. |

Stufe A erzeugt nur Template-/Simulationsergebnisse. Es existiert kein Zustand
`Applied` oder `RemoteConverged` in diesem Modell.

## 9. CostProjection / Kostenprojektion

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `recurringPrivateJobsPerWeek` | Decimal | Wiederkehrende Schedules; Abweichung von ungefähr 22 braucht Textbegründung. |
| `demandMinimalGateRuns` | Decimal or `null` | Eigene Kategorie, getrennte Annahme und Zeitraum. |
| `privateActionsMinutesPerMonth` | Decimal | Nur private Actions, Ziel `<500`, Bezugsbudget `3000`. |
| `copilotReviewRunnerMinutes` | Decimal or `null` | Separat; niemals in Actions-Summe. |
| `weeksPerMonth` | rational `52/12` | Kanonischer Faktor, keine binäre Float-Entscheidung. |
| `assumptions` | ordered non-empty strings | Quelle, Zeitraum, fehlende Daten und Abweichungen. |

Jede fehlende benötigte Dauer oder Run-Annahme macht die entsprechende
Budgetentscheidung `Blocked`; sie wird nicht als 0 summiert.

## 10. RolloutPlanEntry und InventoryRolloutPlan

### RolloutPlanEntry

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `repositoryId` | stable ID | Genau ein Eintrag je live ermitteltem Git-Repository. |
| `profileId` | CIProfile reference | Muss zur validierten Assignment-Zeile und zum gleichnamigen Pflichtfeld des Inventory-Eintrags wertgleich sein. |
| `plannedDiff` | ordered change descriptors | Nur geplante Level-0-/spätere Stage-B-Ziele; keine angewandte Änderung. |
| `gateDecision` | `LocalGate`, `ProductPRGate`, `PublicCI`, `FleetPipeline`, `Blocked` | Aus Profil und Path Contracts. |
| `blockers` | ordered stable codes | Leer nur bei vollständig belegter Planung; unbekannte Daten blockieren. |
| `nextAction` | DE-first/EN-second string | Darf keine nicht autorisierte Mutation anweisen. |
| `remoteConverged` | const `false` | Stufe A behauptet nie Remote-Konvergenz. |

### InventoryRolloutPlan

| Feld / Field | Typ / Type | Validierung / Validation |
|---|---|---|
| `source` | `GitHubReadOnly`/`Fixture` | Genau einmal an der Planwurzel; gilt für alle Repository-Einträge. |
| `sourceRevision` | non-empty string | Genau ein ETag-/Query-Snapshot-, Fixture-Hash- oder gleichwertiger Frischetoken, der den vollständigen Snapshot atomar bindet. |

Zusätzlich enthält der Plan `stage="A"`,
`deliveryMode="LocalImplementation"`, `mutationsPerformed=false`, Registry-/
Inventory-/Path-Contract-Hashes, `generatedAt`, die nach `repositoryId`
geordneten Inventory- und Rollout-Arrays, Profilkardinalitäten und eine
`CostProjection`. Inventory- und Rollout-ID-Mengen müssen identisch sein.

`source` und `sourceRevision` werden gemeinsam genau einmal für den
vollständigen Snapshot bestimmt. Alle Repository-Einträge müssen aus dieser
einen Quellenrevision stammen. Gemischte Quellen, repositorylokale Revisionen,
Teilaktualisierungen oder das Weiterverwenden einzelner alter Einträge unter
einer neuen Wurzelrevision sind verboten und führen zu `Blocked`. Ein Refresh
ermittelt immer den gesamten Snapshot neu.

Vor dem Zustand `Planned` gilt für jede `repositoryId`:
`RepositoryInventoryEntry.profileId == CIProfileAssignment.profileId ==
RolloutPlanEntry.profileId`. Der Inventory-Wert wird ausschließlich nach
erfolgreicher Assignment-Validierung kopiert. Jede Abweichung ist Drift und
blockiert, bevor ein Plan oder eine Kostenprojektion als gültig ausgegeben
wird.

## Beziehungen / Relationships

```text
AuthoritativeRepositorySet  1 --- * (Level0Self + FleetManifest GitRepository)
Authoritative Repository     1 --- 1 CIProfileAssignment
CIProfileAssignment          * --- 1 CIProfile
CIProfile                    1 --- 1 GateSet
CIProfile                    1 --- 1 WorkflowRulesetPolicy
RepositoryInventoryEntry     1 --- 1 CIProfileAssignment (profileId equal)
RepositoryInventoryEntry     1 --- * WorkflowJobInventoryEntry
PathContract                 * --- * GateDefinition (validated cross-file)
PathContract                 * --- 0..1 ProductJob (validated cross-file)
GateSet                      1 --- * IndividualGateResult
CIGateEvidence               1 --- * IndividualGateResult
RepositoryInventoryEntry     1 --- 1 RolloutPlanEntry
InventoryRolloutPlan         1 --- * RepositoryInventoryEntry/RolloutPlanEntry
InventoryRolloutPlan         1 --- 1 CostProjection
InventoryRolloutPlan         1 --- 1 AtomicSourceRevision
```

## Deterministische Ordnung / Deterministic Ordering

1. Repositorys: Unicode-Codepoint-/ASCII-kompatibel nach `repositoryId`.
2. Profile: feste Registry-Reihenfolge der fünf normativen Profile.
3. Pfadverträge: `category`, danach `pathContractId`.
4. Gates: numerisches `order`, danach `gateId` als Validierungs-Tiebreaker;
   doppelte `order` ist dennoch Fehler.
5. Workflow-/Job-Einträge: `workflowId`, dann `jobId`; Blocker und Diffs nach
   stabiler ID, niemals API-Antwortreihenfolge.
6. Quellhashes: Profilregistry und Pfadregistry jeweils genau einmal separat
   kanonisieren und hashen; `profileRegistryHash` und `pathContractHash` werden
   weder zusammengelegt noch aus einer zweiten eingebetteten Quelle berechnet.
7. JSON-Hashmaterial: UTF-8 ohne BOM, LF, sortierte Objektkeys, kompakte
   Separatoren; Arrayreihenfolge bleibt fachlich definiert.

## Zustandsübergänge / State Transitions

### Inventory und Rollout

```text
Unloaded
  -> ProfileRegistryValidatedOnce
  -> PathRegistryValidatedOnce
  -> CrossFileReferencesValidated
  -> AssignmentsValidated
  -> LiveObserved
  -> ProfileIdCopiedAndMatched
  -> Classified
  -> Simulated
  -> Planned

Jeder Fehler -> Blocked
Drift nach LiveObserved -> Stale -> Blocked -> vollständige atomare Neuermittlung
```

`Blocked` hat keinen automatischen Übergang zu `Planned`; erst korrigierte,
neu geladene und vollständig revalidierte Eingaben dürfen einen neuen Lauf
starten. Partieller Refresh und Quellenmix sind keine Übergänge; sie bleiben
`Blocked`.

### Lokaler CI-Gate

```text
Requested
  -> InputsValidated
  -> HeadBound(H0)
  -> GateSetBound(hash0)
  -> Running
  -> Revalidated(H1, hash1)
  -> Published(Passed)

Requested/InputsValidated -> Previewed (keine Evidence)
Jeder Fehler/Signal/Timeout/Drift -> FailedClosed (keine finale Erfolgsevidence)
```

Nur `Revalidated` mit `H0 == H1`, `hash0 == hash1` und allen Gates `Passed`
darf `Published` erreichen. Eine vorhandene finale Datei für denselben Zielpfad
wird vor einem echten Wiederholungslauf entwertet, damit ein fehlgeschlagener
Rerun keine erfolgreiche Restdatei hinterlässt.

### Pre-push

```text
EvidenceMissing/Stale/Failed/HookStale -> Blocked
EvidenceMatched + private profile      -> AllowedLocally
HookBypassed                            -> ServerContractStillRequired
```

`AllowedLocally` ist keine Remote- oder Merge-Autorität. Der unabhängige
serverseitige PR-/Statusvertrag bleibt zwingend.
