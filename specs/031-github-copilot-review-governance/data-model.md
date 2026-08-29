# Datenmodell: GitHub-Copilot-Review-Governance / Data Model: GitHub Copilot Review Governance

Das Modell trennt unveraenderlichen Sollvertrag, frische Providerfakten,
manuell belegte Browserfakten, geplante Aktionen, ausdrueckliche Autoritaet
und terminale Evidence. Providerantworten und UI-Werte sind nicht
vertrauenswuerdige Eingaben und werden vor jeder Entscheidung validiert.

*The model separates the immutable desired-state contract, fresh provider
facts, manually attested browser facts, planned actions, explicit authority,
and terminal evidence. Provider and UI data are untrusted input and are
validated before every decision.*

## Identitaeten / Identities

### DesiredStateTargetSelector

| Feld / Field | Typ | Regel / Rule |
|---|---|---|
| `position` | integer 1..8 | Stabile Sollreihenfolge; `TuiVision` erscheint genau einmal. |
| `slug` | `owner/name` | Unveraenderlicher closed-world GitHub-Slug des Sollvertrags. |
| `defaultBranch` | string | Unveraenderlicher `main`- oder `master`-Wert des Sollvertrags. |

Der versionierte Sollvertrag enthaelt ausschließlich diese drei Selectorfelder.
Er behauptet weder eine Provider-ID noch Sichtbarkeit als statische Wahrheit.

### DesiredReviewSettings

Das getrennte closed-world Einstellungsobjekt enthaelt ausschließlich die
gemeinsamen Sollparameter `personalAccountAutomation=Disabled`,
`rulesetEnforcement=active`, `rulesetTarget=branch`, `reviewEffort=Lite` und
`automaticReview` mit Draft `false`, Push `false` sowie genau dem ersten
Ready-Ereignis. Die Parameter stehen nie im `DesiredStateTargetSelector`.
Per-Target-Abweichungen existieren in Schema `1.0` nicht; eine spaetere
Ausnahme braucht eine neue reviewte closed-world Schemaversion.

### LiveRepositoryIdentity

| Feld / Field | Typ | Regel / Rule |
|---|---|---|
| `repositoryId` | positive integer | Primaere frisch entdeckte Provideridentitaet; unmittelbar vor Apply erneut lesen. |
| `slug` | `owner/name` | Frisch entdeckter Slug; muss zum Target Selector und zur Provider-ID passen. |
| `visibility` | enum | Frisch entdecktes `public`, `private` oder `internal`; Drift blockiert. |
| `defaultBranch` | string | Frisch entdeckter Branch; muss exakt zum Target Selector passen. |
| `observedAt` | date-time | Bindet die Live-Identitaet an den frischen Inventursnapshot. |

### RulesetIdentity

| Feld / Field | Typ | Regel / Rule |
|---|---|---|
| `repositoryId` | positive integer | Bindet das Ruleset an das exakte Repository. |
| `rulesetId` | positive integer | Pflicht fuer Update/Disable/Rollback; Create erhaelt sie erst aus validiertem `201` plus Nachinventur. |
| `sourceType` | enum | Nur `Repository` ist mutierbar; `Organization` und geerbte Quellen blockieren. |
| `target` | enum | G4 akzeptiert fuer den Sollzustand nur `branch`. |
| `name` | string | Anzeige-/Auditwert, niemals alleinige Identitaet. |

### OperationIdentity

`runId`, `operationClass`, `actionId` und `idempotencyId` bilden die gemeinsame
Operationsidentitaet. `AccountSetting` verwendet zusaetzlich ausschließlich
den exakten `accountOwner=hindermath`; alle repositorybezogenen Klassen
verwenden `repositoryId` und, soweit einschlaegig, `rulesetId` oder
`pullRequestId`. Account- und Repositoryidentitaeten duerfen nicht vermischt
oder als Ersatz fuereinander verwendet werden. Die
`operationClass` ist eine von `AccountSetting`, `EffortLevel`,
`RulesetCreate`, `RulesetUpdate`, `RulesetDisable`,
`PRLifecycleAcceptance`, `ManualReviewAcceptance`, `Delivery` oder
`Rollback`. Autoritaet fuer eine Klasse gilt fuer keine andere; insbesondere
sind die drei Rulesetklassen niemals zusammenfassbar.

## Fachobjekte / Domain Objects

### DesiredStateContract

- `schemaVersion`, `contractId`, `owner` und `generatedFromSpec`;
- genau ein `desiredSettings`-Objekt mit `personalAccountAutomation =
  Disabled`, `reviewEffort = Lite` als Browserzustand getrennt vom API-Payload,
  `rulesetEnforcement=active`, `rulesetTarget=branch` und `automaticReview`
  mit `reviewDraftPullRequests=false`, `reviewOnPush=false`,
  `readyOpenOrFirstDraftToReadyOnly=true`;
- exakt acht eindeutige `DesiredStateTargetSelector`-Eintraege;
- `contractSha256` ueber die kanonische Nutzlast ohne das Hashfeld.

Die Sollmenge ist statisch und versioniert. Repository-IDs und Sichtbarkeit
existieren nur in frisch entdeckten `LiveRepositoryIdentity`-Records. Slug und
Default Branch werden zwischen Selector und Live-Record verglichen; alle vier
Livefelder werden vor einer Mutation erneut bestaetigt. Historische
`22/6/2/16`-Werte gehoeren nicht in den Vertrag.

### CurrentInventorySnapshot

- `snapshotId`, `runId`, `observedAt`, `expiresAt`, API-Version und
  vollstaendige Paginationzaehler;
- Billing-/Usage-Fakten fuer `aiCredits` und `actionsMinutes` als getrennte
  Kategorien mit Accounttyp, Zeitraum, Einheit, Quelle und `Known/Unknown`;
- persoenliche Accountautomation als eigener Browser-Evidence-Verweis;
- jedes aktuell besessene Repository mit ID, Sichtbarkeit, Default Branch;
- jedes gefundene aktive oder deaktivierte Rulesetdetail einschliesslich
  Source, Conditions, Enforcement und `copilot_code_review`-Parametern;
- acht Repository-Effort-Records sowie Stichproben fuer manuelle
  Reviewverfuegbarkeit;
- automatische, manuelle und unbekannte Trigger als drei getrennte Zaehler;
- `snapshotSha256`, `sourceFresh=true`, `complete=true` und
  `redactionFindings=0` als Planvoraussetzung.

Ein Snapshot ist unbrauchbar, wenn eine Seite, Detail-ID, Browserflaeche,
Zeitzone, Einheit oder Billingzuordnung unklar ist. Fehlende Usagewerte werden
`Unknown`, niemals `0`.

### BrowserEvidenceRecord

| Feld / Field | Bedeutung / Meaning |
|---|---|
| `surface` | `PersonalAccountAutomation`, `RepositoryEffort` oder `ManualReviewAvailability`. |
| `repositoryId` | Nur bei Repositoryflaechen; exakt live bestaetigt. |
| `observedState` | Closed-world Wert wie `Disabled`, `Lite`, `Available`, `Unavailable`, `Unknown`. |
| `observedAt` / `reviewedAt` | UTC-Zeitpunkte fuer Frische und Vier-Augen-Pruefung. |
| `operatorRole` / `reviewerRole` | Rollen statt personenbezogener Rohdaten. |
| `uiPathClass` | Stabile semantische Flaeche, kein fragiler DOM-Selektor. |
| `evidenceSha256` | Hash des redigierten Records; keine Cookies, Tokens, HTML oder Browserprofile. |

### CopilotRulesetState

Der kanonische Zustand umfasst Repository-/Rulesetidentitaet, `active` oder
`disabled`, exakte Default-Branch-Condition, genau eine
`copilot_code_review`-Regel sowie beide Booleschen Parameter. Andere Regeln
werden vollstaendig erhalten. Ein Ruleset mit Copilot- und weiteren
Schutzregeln ist `mixedPurpose=true` und darf nicht pauschal deaktiviert
werden.

### UsageEvidence

`aiCredits`, `actionsMinutes` und `reviewTriggers` sind Geschwisterobjekte,
nicht addierbare Summanden. Jede Messung traegt `status`, `unit`, `period`,
`source`, `observedAt` und optional einen nichtnegativen Wert. Trigger werden
in `automatic`, `manual` und `unknown` getrennt. Das Modell enthaelt weder
Fixpreise noch eine vorab behauptete Modellwahl.

### MutationPlan

Ein Plan bindet `desiredStateSha256`, `inventorySha256`, `apiVersion`,
`createdAt`, `expiresAt`, die sortierte Aktionsliste und `planSha256`.
Sortierung: Operationsklasse, Repository-ID, Ruleset-ID, Aktion. Eine Aktion
ist genau eine von:

- `NoOp`: Soll und Ist stimmen; `writeIntent=false`;
- `Update`: exakte dedizierte Ziel-ID wird auf Soll gebracht;
- `Create`: vollstaendige Inventur beweist das Fehlen am Ziel;
- `Disable`: exakte dedizierte aktive Nichtziel-/Ueberschuss-ID wird erhalten,
  aber deaktiviert;
- `Blocked`: Unsicherheit, Drift oder unzureichender Rollback verhindert Apply.

`Delete` ist kein gueltiger Wert. Jede schreibende Aktion enthaelt
`beforeSha256`, `desiredSha256`, `rollbackSha256`, erlaubte HTTP-Methode,
exakte IDs, kanonischen Payloadpfad und Begruendung.

Eine `AccountSetting`-Aktion MUSS `accountOwner=hindermath` enthalten und darf
keine Repository-, Ruleset- oder PR-Identitaet tragen. Dieser Wert stammt aus
dem Sollvertrag und muss mit der frisch reviewten ausdruecklichen
Autoritaetsquelle uebereinstimmen; ein angemeldetes Credential, der
Delivery-Modus oder ein Merge-Bypass ist keine Accountidentitaet und keine
Accountautoritaet.

Fuer schreibende Rulesetaktionen ist die Zuordnung closed-world:
`Create` = `RulesetCreate` + `POST`, `Update` = `RulesetUpdate` + `PUT` und
`Disable` = `RulesetDisable` + `PUT`. `NoOp` oder `Blocked` kann die fachlich
gepruefte Klasse tragen, besitzt aber `writeIntent=false` und keine Methode.
Ein External-Write-Gate darf immer nur eine dieser drei Klassen autorisieren.

### ExternalWriteGate

Der Gate-Datensatz ist providerneutral und enthaelt:

- eindeutige Gate-/Run-/Operationsidentitaet und ausdruecklichen
  Authority-Record;
- fuer `AccountSetting` den verpflichtenden exakten
  `accountOwner=hindermath`; fuer alle anderen direkten Operationsklassen ist
  `accountOwner` verboten;
- exakte Repository-/Ruleset-/PR-IDs und erlaubte Aktions-IDs; alle drei
  ID-Arrays sind bei `AccountSetting` verpflichtend leer;
- Snapshot-, Plan-, Before-, Desired- und Rollback-Hashes;
- Scope, Berechtigungsminimum, `notBefore`, `expiresAt` und Freshnessgrenze;
- Acceptance-, Security-, Review- und technische Gate-Evidence;
- Rollbackbefehl/-plan, Secretbehandlung und Approver-/Reviewerrollen.

Jede der neun Operationsklassen besitzt eine closed-world Bindung aus
zulässigen Methoden, Identitätsfeldern und minimalen Scopes. `AccountSetting`
erlaubt genau `BrowserManual` und `PersonalCopilotSettings:write` und bindet
den `authorityRecordId` samt `authoritySha256` des aktuellen ausdruecklichen
Account-Authority-Records. Ein `Rollback` mit
`rollbackSourceOperationClass=AccountSetting` bindet denselben
`accountOwner`; andere Rollbackquellen duerfen ihn nicht tragen. `Delivery`
erlaubt nur `GitPush` und `GitHubMerge`, exakte Repository-/PR-IDs sowie
`Contents:write`/`PullRequests:write`; es erlaubt weder `POST`/`PUT` noch
Ruleset-IDs oder Provider-Settings-Scope. `Rollback` bindet zusaetzlich die
Quelloperationsklasse und darf deren Methoden-/ID-/Scopegrenze nicht
ueberschreiten. `MergeAndSync` und Admin-Bypass sind keine Provider-Admin-/
Secretautoritaet. Ein Gate ist einmalig konsumierbar und kann nicht ueber
Scope oder Zeit erweitert werden.

### MutationResult

Pro Aktion werden Start/Ende, exakte Argumentform, Exitklasse, Providerstatus,
Preflight-/After-State-/Post-Inventur-Hash, Anzahl Writes und Outcome
gespeichert. Ein `AccountSetting`-Resultat MUSS denselben
`accountOwner=hindermath` wie Plan und Gate enthalten. `RulesetUpdate` und
`RulesetDisable` verlangen stets exakte
`repositoryId` und `rulesetId`. Ein schreibendes oder erfolgreich
reconciliertes `RulesetCreate` verlangt dieselben Felder; seine `rulesetId`
stammt ausschließlich aus der exakten Übereinstimmung von validierter
Providerantwort und frischer Post-Inventur. Synthetische Write-Resultate ohne
diese IDs sind ungueltig. Erlaubte Outcomes: `NoOp`, `Applied`, `Verified`,
`Blocked`, `Failed`, `Reconciled`, `RolledBack`. Bei unklarer Providerantwort
folgt nur read-only Reconciliation. Ein zweiter konvergenter Lauf muss
`writes=0` liefern.

### RollbackPlan und RollbackRecord

Der Plan entsteht vor Apply und bindet exakte ID, Quell-Mutationsergebnishash,
Post-Inventurhash, Vorzustand, fehlgeschlagenen Nachzustand, sichere
Rueckkehrnutzlast und die `sourceOperationClass`.
Ein Account-Rollback verwendet `targetKind=Account`, bindet denselben
`accountOwner=hindermath` wie Account-Plan, Gate und Resultat und darf keine
Repository-, Ruleset- oder PR-Identitaet als Ersatz verwenden.
`RulesetCreate`, `RulesetUpdate` und `RulesetDisable` bleiben dadurch auch im
Rollback getrennt nachvollziehbar. Rollback benoetigt ein eigenes frisches
External-Write-Gate der Klasse `Rollback`; dieses uebernimmt keine erneute
Quellklassenautoritaet. Er ist nur zulaessig, wenn der aktuelle Hash noch dem
gebundenen fehlgeschlagenen Zustand entspricht; neuere legitime Aenderung
blockiert. Create-Rollback deaktiviert die frisch erzeugte exakte ID mit einem
eng gebundenen Rollback und loescht nie. Das Record dokumentiert Apply,
Verifikation oder Blockierung.

### TerminalEvidence

Terminale Evidence aggregiert die zehn AC-Gates, exakte Acht-Mengengleichheit,
Account-/Effort-/Rulesetkonvergenz, automatischen und manuellen Reviewproof,
getrennte Usagekategorien, Plattformparitaet, Regression/Security/A11Y,
Delivery- und Default-Sync-Nachweis sowie Position-7-Isolation. Jeder Verweis
hat relativen Pfad und SHA-256. `providerMutationsOutsideAuthorizedScope=0`,
`secretFindings=0`, `position7Mutations=0` und komplette Gate-Mengengleichheit
sind terminale Bedingungen. Die Schemareihenfolge ist closed-world und bindet
genau einmal `macOS`, `Linux`, `Windows` sowie genau einmal `AC-CRG-001` bis
`AC-CRG-010`; ein semantischer Validator prueft dieselben Mengengleichheiten.
Duplicate-only Evidence ist auch bei unterschiedlichen Pfaden oder Hashes
ungueltig.

## Zustaende und Uebergaenge / States and Transitions

```text
Inventory: Requested -> Captured -> Validated
                              \-> Stale | Blocked

Plan:      Prepared -> Reviewed -> AwaitingAuthority
                   \-> Blocked | Superseded

Gate:      Closed -> Authorized -> Consumed
                              \-> Expired | Revoked

Action:    Planned -> Preflighted -> Applied -> Verified
                    \-> Blocked       \-> Reconcile -> Verified | Failed
                                                Failed -> RollbackPending
Rollback:  Prepared -> Authorized -> Applied -> Verified
                                  \-> Blocked

Run:       Prepared -> Previewed -> AwaitingAuthority -> Applying
          -> Validating -> Completed
          \-> Blocked | Stopped
```

Nur `Validated` plus frischer Sollhash erzeugt einen Plan. Nur `Reviewed` plus
passendes `Authorized`-Gate erreicht `Preflighted`. Jede Hashabweichung fuehrt
zu `Blocked` oder einem neuen Preview, nie zu stiller Neuberechnung innerhalb
eines konsumierten Gates.

## Hash-, Frische- und Redaktionsregeln / Hash, Freshness, and Redaction Rules

- JSON wird UTF-8, sortierte Schluessel, kompakte Trenner, LF und ohne BOM
  kanonisiert; SHA-256 ist lowercase hex.
- Entscheidungshashes schliessen volatile Zeitfelder und das eigene Hashfeld
  aus; Evidencehashes schliessen Zeitfelder ein.
- API- und Browserquellen besitzen getrennte Frischegrenzen. Ein neuerer
  Providerzustand invalidiert Before-Hash, Plan und Autoritaet.
- Relative Evidencepfade muessen unter dem erlaubten Root bleiben;
  absolute Pfade, `..`, Symlinks und offene Rechte blockieren.
- Tokens, Cookies, Authorization-Header, personenbezogene Billingdetails,
  Browserprofile, rohe HTML-Seiten und Query-Secrets werden nie persistiert.
- Redaction erfolgt vor Hash und atomischer Veroeffentlichung. Ein Secretscan-
  Treffer oder nicht klassifiziertes sensibles Feld ist ein Hard Stop.

## Validierungsinvarianten / Validation Invariants

1. Sollzielmenge und live bestaetigte Zielmenge sind exakt gleich und haben
   Kardinalitaet acht.
2. Jedes Ziel besitzt genau ein aktives dediziertes Copilot-Ruleset fuer den
   exakten Default Branch; Draft und Push sind `false`; Effort ist `Lite`.
3. Persoenliche Accountautomation ist `Disabled`; kein aktives dediziertes
   Copilot-Ruleset bleibt ausserhalb der Acht.
4. Kein Schema, Plan oder Adapter akzeptiert `Delete`.
5. Jede Mutation hat exakte IDs, frischen Before-Hash, eigenen Rollback und
   operationsspezifische Autoritaet.
6. `RulesetCreate`, `RulesetUpdate` und `RulesetDisable` besitzen getrennte
   Gates, Methodenbindungen, Resultate und Rollback-Quellklassen.
7. API- und Browser-Evidence koennen einander nicht ersetzen.
8. AI Credits, Actions-Minuten und Triggerzahlen bleiben getrennt.
9. Copilotbefund ist advisory; Acceptance, Security, Human Review und Gates
   bleiben eigenstaendige terminale Nachweise.
10. Ein Protection-only-Bypass folgt nur einem belegten regulaeren Refusal und
   ersetzt keinen Nachweis.
11. Position 7, Subscription, Budget und Home bleiben unveraendert, sofern
    nicht spaeter eine eigene explizite Autoritaet erteilt wird.
12. `AccountSetting` ist in Plan, Gate, Resultat und Rollback exakt auf
    `accountOwner=hindermath` gebunden; Missing/Mismatch oder eine
    Repository-/Ruleset-/PR-ID im Account-Gate blockiert vor dem Write.
