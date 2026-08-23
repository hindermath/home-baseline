# Datenmodell: Stage-B-Rollout / Data Model: Stage-B Rollout

## Modellgrenze / Model Boundary

Stage B liest die abgeschlossenen Stage-A-Verträge und -Evidence unverändert.
Neue Entscheidungen werden ausschließlich durch die Verträge in
`contracts/` beschrieben. Vollständiger operativer Zustand ist
`machineLocal`; nur redigierte, schema-validierte Abschlussdaten dürfen
`sourceOnly` werden. Alle Pfade in versionierter Evidence sind
repository-relativ. Credentials, Token, private lokale Pfade, ungefilterte
Providerantworten und unnötige Personendaten sind `restricted` und verboten.

Der eine kanonische Stage-B-Evidence-Root ist
`.specify/runtime/autonomous-routing/<run-id>/stage-b/evidence/v1/`. Darunter
enthält `operational/` die kausale Betriebswahrheit und `primary/` nur
temporäre AC-SBR-Snapshots. Interne Spec-Kit-Routingresultate bleiben getrennt
unter `.specify/runtime/autonomous-routing/<run-id>/`; eine spätere redigierte
`sourceOnly`-Auswahl liegt unter `specs/030-stage-b-rollout/evidence/v1/` und
bewahrt Quellpfad und Quellhash.

Jedes eigenständige normative operative Result-/Evidence-JSON trägt
`planSha256` direkt auf der obersten Ebene. Das gilt für Repository- und
Wellenresultate, Budgetprojektionen, PreMerge-/PostMerge-Evidence,
Terminal-Evidence und Closeout; Run-State- oder Aggregathüllen dürfen diese
Bindung nur wiederholen, niemals ersetzen.

## 1. AuthoritativeFleetSnapshot / Autoritativer Flottensnapshot

**Felder / Fields**:

- `snapshotId`: UUID;
- `capturedAt`: RFC-3339-UTC;
- `level0Head`, `g3ReviewedHead`, `g3MergeCommit`;
- `g3PostMergeEvidenceSha256`;
- `fleetManifestHash`, `profileRegistryHash`, `pathContractHash`,
  `environmentRegistryHash`, `gateSetHash`, `authorityHash`;
- `source` und `sourceRevision` genau einmal für den atomaren Snapshot;
- `repositoryIds[]`: sortierte stabile IDs;
- `repositories[]`: gebundene `FleetRepositoryIdentity`;
- `inputSetHash`: kanonischer Hash aller nicht volatilen Eingaben.

**Validierung / Validation**: ID-Menge ist exakt die Union aus
`home-baseline` und aktiven `kind=git-repository`-Zielen. Collection-Knoten,
Duplikate und unbekannte Assignments sind verboten. Manifest, Assignments,
Inventory und Rolloutplan besitzen dieselbe Menge. Zeitstempel gehört nicht
zum `inputSetHash`, zur `sourceRevision` oder zum `fleetSnapshotHash`; Preview
und Publikation mit denselben fachlichen Providerfakten erzeugen deshalb
denselben semantischen Planhash, auch wenn ihre Beobachtungszeiten abweichen.

## 2. FleetRepositoryIdentity / Flotten-Repository-Identität

**Felder / Fields**:

- `repositoryId`: stabile Registry-ID;
- `profileId`: eines der fünf Stage-A-Profile;
- `visibility`: `public` oder `private`;
- `expectedRemoteIdentity`: normalisierte Registry-/Manifestidentität;
- `providerRepositoryId`: positive numerische GitHub-ID als String;
- `providerSlug`: kanonisches `owner/name` ohne Credentials;
- `defaultBranch`, `defaultHead`, `defaultTree`;
- `localRepositoryRootHash`: Hash des redigierten, aufgelösten Registry-
  Eintrags, niemals der absolute Pfad;
- `environmentRegistryEntryHash`;
- `observedAt`.

**Validierung / Validation**: Stable ID, erwartete Remote, numerische
Provider-ID, Slug, Sichtbarkeit und Default Branch müssen zusammenpassen.
Rename, Fork-/Archivstatus oder Mehrfachremote blockiert. Absolute lokale
Pfade werden nur im machine-local State gehalten und beim Evidence-Schreiben
durch `repositoryId` ersetzt.

## 3. StageBRolloutPlan / Stage-B-Rolloutplan

**Felder / Fields**:

- `schemaVersion`, `planId`, `runId`, `createdAt`;
- `stageAReference`: Featurepfad, Reviewed Head, Merge Commit und
  PostMerge-Evidence-Hash;
- `fleetSnapshotHash`, `inputSetHash`;
- `deliveryMode`: exakt `MergeAndSync`;
- `firstMutation`: Repository-ID, Action Kind und Baseline Head oder `N/A`;
- `waves[]`: fünf geordnete, statische `RolloutWave`-Zuordnungen;
- `targets[]`: ein `TargetChangePlan` je autoritativer ID;
- `planHash`: Hash über kanonischen Payload ohne `createdAt` und `planHash`.

**Validierung / Validation**: Fleet-, Wave- und Target-ID-Mengen sind gleich.
Jede ID kommt genau einmal vor. Canaries sind exakt die drei bindenden IDs;
alle weiteren IDs gehören genau einer Profilwelle an. Authority, Gate-Status,
Fortschritt, Resultate, Budgets, Terminalnachweis und Closeout sind verboten,
weil sie ausschließlich zum veränderlichen `StageBRunState` gehören.
`firstMutation=N/A` ist nur zulässig, wenn alle Ziele `NoOpCandidate` sind und
keine Ruleset-Mutation erfordern; vor jeder tatsächlichen Mutation sind ein
konkretes `firstMutation`-Objekt und ein offenes Gate im Run-State Pflicht.

## 4. RolloutWave / Rolloutwelle

**Felder / Fields**:

- `waveId`: `public-canaries`, `public-products`, `private-products`,
  `private-governance-scaffold`, `public-presets`;
- `order`: `1..5`;
- `repositoryIds[]`: lexikografisch sortiert.

**Validierung / Validation**: Der Plan enthält ausschließlich Identität,
Reihenfolge und Zielmenge. Status, Vorgängerresultat, Budget, Blocker und
nächste Aktion stehen im passenden `waveResults[]`-Eintrag des Run-State. Eine
Welle wird dort erst `Converged`, wenn jedes Zielresultat `Converged` oder
`NoOpConverged` ist und die aktuelle Budgetprojektion `<500/3000` belegt.

## 5. TargetChangePlan / Zieländerungsplan

**Felder / Fields**:

- `transactionId`, `repositoryId`, `waveId`, `sequence`;
- `baselineHead`, `baselineTree`, `defaultBranch`;
- `profileId`, `stageAPlanHash`, `gateSetHash`, `pathContractHash`;
- `changes[]`: sortierte `PlannedBlobChange`;
- `plannedDiffHash`, `candidateTree`;
- `workflowAction`: `Preserve`, `Add`, `Update`, `RemoveDuplicate`, `N/A`;
- `rulesetPlanHash` oder `N/A`;
- `mergeMethod`: `merge`, `squash`, `rebase` oder `N/A` bei leerem Git-Diff;
- `branchName`: deterministisch oder `N/A`;
- `requiredLocalGates[]`, `requiredRemoteGates[]`;
- `idempotencyKeys[]`;
- `decision`: `PullRequest`, `NoOpCandidate`, `Blocked`;
- `blockers[]`.

**Validierung / Validation**: Änderungen sind nach Pfad sortiert; jeder Pfad
kommt einmal vor. `plannedDiffHash` ist der kanonische Hash über Path, Action,
ModeBefore/After und BlobBefore/After. Ein Pull Request benötigt mindestens
eine Änderung, Branch und Mergeverfahren. Ein No-op-Kandidat hat null
Änderungen, wird aber erst nach Providersemantikprüfung konvergent.

## 6. PlannedBlobChange / Geplante Blobänderung

**Felder / Fields**:

- `path`: normalisierter repository-relativer POSIX-Pfad;
- `action`: `Add`, `Modify`, `Delete`, `Rename`;
- `modeBefore`, `modeAfter`: Git-Modus oder `N/A`;
- `blobBefore`, `blobAfter`: vollständige Git-Objekt-ID oder `N/A`;
- `sourceTemplateHash` oder `N/A`;
- `semanticContractIds[]`.

**Validierung / Validation**: kein absoluter Pfad, `..`, NUL, CR/LF oder
Symlink-Escape. Renames besitzen alte und neue Identität im kanonischen
Change-Record. Nur geplante Blobs dürfen im Kandidatenindex erscheinen.

## 7. StageBRunState / Stage-B-Laufzustand

**Felder / Fields**:

- `schemaVersion`, `runId`, `featurePath`;
- `status`: `Prepared`, `Preflighted`, `SliceValidated`, `Delivering`,
  `Stopped`, `Completed`, `Blocked`;
- `deliveryMode`, `rolloutPlanBinding`: Plan-ID, repository-relativer Planpfad
  und unveränderlicher `planSha256`;
- `authorityBinding` mit demselben `planSha256`;
- `stageAReference`, `fleetSnapshotHash`;
- `evidenceLayout`: `schemaVersion=v1`, kanonischer Stage-B-Evidence-Root,
  `operational`-/`primary`-Namespaces, interner Routing-Root und späterer
  Feature-Evidence-Root;
- `currentWaveId`, `currentRepositoryId`, `currentAction`;
- `lastSafeBoundary`, `nextAction`;
- `waveResults[]`: Wellen-ID, `planSha256`, Status, aktueller Resultpfad/-hash
  und kausaler Vorgängerhash;
- `targetResults[]`: Repository-ID, `planSha256`, operativer Resultpfad/-hash
  und Outcome;
- `budgetProjections[]`: Wellen-ID, `planSha256`, operativer
  Projektionspfad/-hash und Ergebnis;
- `terminalEvidence` und `closeout`: jeweils `planSha256`, Status, exakter
  operativer Pfad und Hash oder bis zur Erzeugung jeweils `N/A`;
- `stop`: Grund, Kategorie, Zeitpunkt, in-flight Operation und
  `requiresExplicitResume`;
- `resumeCount`, `lastRevalidatedAt`, `stateHash`.

**Validierung / Validation**: Featurepfad und Run-ID sind unveränderlich.
Plan-, Authority-, Evidence- und Resultpfade müssen repository-relativ dieselbe
Run-ID tragen; Authority und jedes Result-/Evidence-Dokument binden den
unveränderlichen `planSha256`. `Completed` verlangt fünf konvergierte Wellen,
fünf bestandene Budgetprojektionen, validierte Terminal-Evidence und
validierten Closeout mit aktuellen Hashes. Ein bewusster Stop setzt
`requiresExplicitResume=true`. Der Flottensnapshot bleibt beim Preflight im
Speicher. Der vorab schema- und semantikvalidierte Plan wird zuerst atomar
ersetzt, danach der vorab validierte State als Commit-Marker. State wird im
gleichen Parent-Verzeichnis atomar geschrieben und vor/nach jedem Übergang
validiert. Ein State ist nur mit vorhandenem hashgleichem Plan gültig; ein
verwaister Plan ohne State ist nicht autoritativ und wird beim nächsten
Preflight ignoriert und ersetzt.

## 8. AuthorityBinding / Autoritätsbindung

**Felder / Fields**:

- `status`: `Pending` oder `Authorized`;
- `deliveryMode`: geplanter Liefermodus `MergeAndSync`;
- `source`: bei `Pending` exakt `N/A`, bei `Authorized` die aktuelle
  Benutzer-/Run-Autoritätsquelle ohne Prompt-Rohtext;
- `authorizedAt`, `validatedAt`: bei `Pending` exakt `N/A`, bei `Authorized`
  echte UTC-Zeitstempel;
- `runId`, unveränderlicher `planSha256`, `scopeHash`, `repositoryIdsHash`;
- `externalWriteGate`: `Open` oder `Closed`;
- `adminBypass`: `AuthorizedException` oder `NotAuthorized`;
- `authorityHash`.

**Validierung / Validation**: Ein vorbereiteter Preflight-State ist zwingend
`Pending`, `externalWriteGate=Closed` und `adminBypass=NotAuthorized`. Nur eine
frisch erteilte und revalidierte Authority darf `Authorized` mit echter Quelle
und echten Zeitstempeln setzen. Scope-, Run- oder Planbindungsdrift schließt das
Gate, ändert aber den unveränderlichen Plan nicht.
`AuthorizedException` erlaubt keine Aktion ohne konkrete
`AdminBypassEvidence`.

## 9. RepositoryRolloutResult / Repository-Rolloutresultat

**Felder / Fields**:

- Identität: `resultId`, `runId`, `planId`, `transactionId`, `repositoryId`,
  `waveId`, `sequence`;
- Bindung: unveränderlicher `planSha256`, `fleetSnapshotHash`,
  `targetPlanHash`, `baselineHead`,
  `candidateHead`, `plannedDiffHash`;
- `outcome`: `Converged`, `NoOpConverged`, `Stopped`, `Blocked`;
- `lifecycle`: Branch, Commit, PR, Local Gates, Remote Gates, Review,
  Merge Method, Merge Commit, Default-Sync und Provider-Endprüfung;
- `ruleset`: Planhash, vorherige/nachherige Ruleset-ID/-Hash, Action ID,
  Restore-Status;
- `adminBypass`: Evidence oder begründetes `N/A`;
- `noOp`: Hash-/Zeit-/Semantikbeleg oder `N/A`;
- `preMergeEvidenceSha256`, `postMergeEvidenceSha256`;
- `redaction`: Scanstatus und verbotene Klassen `0`;
- `resultHash`.

**Validierung / Validation**: `planSha256` muss direkt im Resultdokument stehen
und exakt `StageBRunState.rolloutPlanBinding.planSha256` entsprechen; eine
äußere State- oder Terminal-Evidence-Hülle ersetzt diese Bindung nicht.
`Converged` mit nichtleerem Diff benötigt alle Lifecycle-Felder, bestandene
Gates, reguläre Review, Merge-Commit und Sync. `NoOpConverged` benötigt null
Diff, keinen Branch/Commit/PR und gültige Git-/Providersemantik. Bypass kann
nur zusätzlich zu vollständiger Review- und Gate-Evidence auftreten.

## 10. PullRequestLifecycle / Pull-Request-Lebenszyklus

**Felder / Fields**:

- `branchName`, `commitSha`, `commitTree`, `pushRemoteHead`;
- `pullRequestNumber`, `pullRequestNodeId`, `pullRequestHead`;
- `localGateEvidence[]`, `remoteGateEvidence[]`;
- `reviewDecision`, `reviewedHead`, `reviewEvidenceHash`;
- `regularMergeAttempt`: Zeitpunkt, Action ID, Ergebnis;
- `mergeMethod`, `mergeCommit`;
- `defaultBranchRemoteHead`, `defaultBranchLocalHead`, `synchronized`;
- `finalProviderObservedAt`, `finalProviderHash`.

**Validierung / Validation**: Commit, Push, PR, Gate und Review binden denselben
Kandidaten. Review am falschen Head ist ungültig. Billing/Quota-Ablehnung,
technisches Gateversagen und Pass sind disjunkte Zustände.

## 11. GateEvidence / Gate-Evidence

**Felder / Fields**:

- `gateId`, `provider`, `workflow`, `job`, `runnerOrPlatform`;
- `executedCommand`, `headSha`, `runId`, `result`;
- `classification`: `Passed`, `TechnicalFailure`, `ProviderRefusal`,
  `BillingOrQuotaRefusal`;
- `evidenceReference`, `observedAt`.

**Validierung / Validation**: Ein grüner Anzeigename reicht nicht. Workflow,
Job, Runner/Plattform, konkreter Befehl und exakter Head sind Pflicht.
Providerfehler dürfen nicht als technischer Testausgang umgedeutet werden.

## 12. AdminBypassEvidence / Admin-Bypass-Evidence

**Felder / Fields**:

- `authorityHash`, `repositoryId`, `pullRequestHead`, `boundAt`, `expiresAt`;
- `reason`, `scope`, `regularAttemptActionId`, `regularAttemptResult`;
- `acceptanceEvidenceHash`, `securityEvidenceHash`, `reviewEvidenceHash`,
  `gateEvidenceHash`;
- `providerActionId`, `result`, `postWriteVerificationHash`.

**Validierung / Validation**: Bei `used=true` müssen `repositoryId` und
`pullRequestHead` direkt im Bypass-Objekt stehen. Der Semantikvalidator fordert
`adminBypass.repositoryId == RepositoryRolloutResult.repositoryId` sowie
`adminBypass.pullRequestHead == lifecycle.pullRequestHead == candidateHead`.
`authorityHash` muss die aktuelle, plan- und scopegebundene Authority treffen;
`boundAt` muss vor der Aktion und diese vor `expiresAt` liegen, und `scope` und
`reason` müssen genau das gebundene Repository und diesen PR-Head rechtfertigen.
Der normale Versuch muss stattgefunden und ausschließlich an Schutzregeln
gescheitert sein. Alle vier unabhängigen Acceptance-, Security-, Review- und
Gate-Evidence-Hashes bleiben Pflicht und dürfen nie durch den Bypass ersetzt
werden. Bei `used=false` sind alle übrigen Bypass-Felder exakt `N/A`. Keine
Personennamen oder Rohantworten.

## 13. StageBRulesetPlan / Stage-B-Rulesetplan

**Felder / Fields**:

- `rulesetPlanId`, `repositoryId`, `providerRepositoryId`, `defaultBranch`;
- `rulesetName`: `home-baseline/private-governance-default`;
- `previousRulesetId`, `previousRulesetHash`;
- `desiredRulesetHash`, `action`: `Create`, `Update`, `NoChange`;
- `pullRequestRequired=true`, `requiredApprovingReviews=1`;
- `requiredStatusChecks=[home-baseline/ci-minimal-gate]`;
- `strictStatusChecks=true`, `bypassActors=[]`;
- `blockedWritePaths=[direct,web,api]`;
- `restoreRequestHash`, `planHash`.

**Validierung / Validation**: Nur Private Governance/Scaffold darf diesen
Plan besitzen. Genau ein Status, keine Bypass-Akteure, Default-Branch-Ziel und
gebundener Vorzustand sind Pflicht. Unbekannte schutzrelevante Providerfelder
blockieren.

## 14. BudgetProjection / Budgetprojektion

**Felder / Fields**:

- `projectionId`, `waveId`, `capturedAt`;
- `fleetSnapshotHash`, unveränderlicher `planSha256`, `waveResultHash`;
- `recurringPrivateJobsPerWeek`, `demandMinimalGateRuns`;
- `privateActionsMinutesPerMonth`, `privateMonthlyBudgetMinutes=3000`,
  `stageBMaximumMinutes=500`;
- getrennte `copilotReviewRunnerMinutes` und weitere Copilot-Kategorien;
- `sourceFreshness`, `assumptions[]`, `result`: `Pass` oder `Blocked`;
- `projectionHash`.

**Validierung / Validation**: Decimal-Strings, Faktor `52/12`, keine frühen
Rundungen. Fehlende Daten sind kein Nullwert. Pass verlangt `<500`.

## 15. FleetTerminalEvidence / Terminale Flotten-Evidence

**Felder / Fields**:

- `terminalEvidenceId`, `runId`, `planId`, unveränderlicher `planSha256`,
  `capturedAt`;
- `authoritativeRepositoryIds[]`, `fleetSnapshotHash`;
- `repositoryResults[]`: jeweils `planSha256`, ID, Result-Pfad/Hash und Outcome;
- `waveResults[]` und fünf `budgetProjectionHashes[]`: jeweils mit
  `planSha256`;
- `convergedRepositoryCount`, `authoritativeRepositoryCount`;
- `preMergeEvidenceHash`, `postMergeEvidenceHash` für Level-0-Control-Plane;
- `g4Isolation`: G4, Intake-Serie, Copilot, Account und Subscription jeweils
  `Unchanged`, plus zulässige nächste Aktion;
- `redaction`, `terminalHash`.

**Validierung / Validation**: Das Dokument und jeder eingebettete Resultverweis
binden direkt denselben `planSha256` wie der Run-State und die referenzierten
operativen Dokumente. Jede autoritative ID kommt genau einmal vor, die
Reihenfolge ist lexikografisch, Counts sind gleich und Outcomes nur
`Converged` oder `NoOpConverged`. Fünf Budgetprojektionen müssen Pass sein.
Restricted Treffer müssen `0` sein. Nächste Aktion ist ausschließlich das
getrennte Sequencing-Gate.

## Beziehungen / Relationships

- Ein `AuthoritativeFleetSnapshot` besitzt genau einen
  `StageBRolloutPlan` je gültigem Inputset.
- Ein Plan besitzt fünf `RolloutWave` und genau einen `TargetChangePlan` je
  `FleetRepositoryIdentity`.
- Genau ein veränderlicher `StageBRunState` bindet den unveränderlichen
  Planhash an aktuelle Authority, Wellen-/Repositoryresultate, Budgets,
  Terminalnachweis und Closeout.
- Ein Target Plan erzeugt höchstens ein `RepositoryRolloutResult` pro
  Planrevision; Resume referenziert das bestehende Resultat über Transaction-
  und Idempotency-Key.
- Ein nichtleerer Target Plan besitzt genau einen
  `PullRequestLifecycle`; ein leerer Plan besitzt genau einen No-op-Beleg.
- Private Governance/Scaffold besitzt zusätzlich genau einen
  `StageBRulesetPlan`.
- Jede konvergierte Welle besitzt eine `BudgetProjection`.
- `FleetTerminalEvidence` aggregiert exakt alle Resultathashes und alle fünf
  Budgethashes; der Run-State bindet anschließend ihren `terminalHash` und den
  davon abhängigen Closeout-Hash.

## Deterministische Ordnung und Hashes / Deterministic Ordering and Hashes

- Wave-Reihenfolge ist fest; Repository-IDs innerhalb jeder Welle sind
  lexikografisch nach Unicode-Codepoint der validierten ASCII-ID.
- Changes sortieren nach `path`, dann `action`; Gates nach `gateId`; Provider-
  Aktionen nach `sequence`.
- JSON wird UTF-8 ohne BOM, LF, sortierte Keys und kompakte Separatoren
  kanonisiert. Normalisierte Textdateihashes ersetzen CRLF/CR durch LF.
- Entscheidungshashes schließen volatile Zeitstempel und den eigenen Hash aus.
  Evidence-Dateihashes schließen Zeitstempel ein und verwenden die vollständige
  normalisierte Datei.
- Der unveränderliche `StageBRolloutPlan.planHash` wird in allen abhängigen
  Dokumenten als `planSha256` gebunden und schließt alle Authority-, Gate-, Fortschritts-,
  Resultat-, Budget-, Terminal- und Closeout-Felder aus. Der mutable State
  nimmt den Planhash als kausale Wurzel und hashbindet jeden aktuellen
  operativen Evidence-Verweis.
- `preMergeEvidenceSha256` wird unverändert in PostMerge-Evidence übernommen;
  PostMerge bindet zusätzlich Merge-Commit und beobachteten Default-Head.

## Zustandsübergänge / State Transitions

```text
Prepared -> Preflighted -> SliceValidated -> Delivering
Delivering -> Stopped -> Delivering
Delivering -> Blocked
Delivering -> Completed
```

Zulässige Zielübergänge:

```text
Planned -> Validated -> Committed -> Pushed -> PullRequestOpen
PullRequestOpen -> GatesPassed -> Reviewed -> Merged -> Synchronized -> Converged
Planned -> NoOpValidated -> NoOpConverged
any nonterminal -> Stopped
```

`Stopped` ist nur nach vollständiger Revalidierung und explizitem Resume
verlassbar. `Converged`, `NoOpConverged` und `Completed` sind terminal für die
gebundene Planrevision; Inputdrift erzeugt eine neue Planrevision und macht den
alten Erfolg historisch, nicht stillschweigend aktuell.

## Redaktionsgrenzen / Redaction Boundaries

**Public / Öffentlich**: stabile öffentliche IDs, Schema-/Contract-IDs,
Workflow-/Statusnamen, normalisierte Hashes.

**Internal / Intern**: private Sichtbarkeit, minimierte PR-/Review-/Ruleset-
Metadaten, Budgetdetails; nur soweit für Audit erforderlich.

**Restricted / Verboten in versionierter Evidence**: Token, Credentials,
Authorization Header, unbereinigte Providerantworten, absolute lokale Pfade,
Home-Verzeichnisse, E-Mail-Adressen und unnötige Personenbezeichner. Der
Redaction-Validator läuft vor atomarer Publikation und erneut im Secret Scan.
