# Data Model: Preset Profile and Worktree Hardening

## FleetTargetResult

- `targetId`
- `path`: HOME-relativer, validierter Zielpfad
- `kind`: `git-repository | collection`
- `maintenanceClass`: `canonical-fleet | preset`
- `branch`
- `upstream`
- `remoteRef`
- `headCommit`
- `remoteCommit`
- `ahead`
- `behind`
- `status`
- `action`
- `result`: `Pass | Warning | Blocked | Failed`
- `findingCode`
- `nextAction`
- `freshnessAttempt`: `NetworkAttempt | N/A`

Invarianten:

- Jedes aktive Manifestziel erzeugt genau ein Ergebnis.
- Ein Git-Ergebnis ohne erfolgreichen aktuellen Fetch kann nicht `Pass` sein.
- Die Collection besitzt keinen Git-, Fetch- oder Pull-Nachweis.

## NetworkAttempt

- `operation`: `fetch | pull | ls-remote | clone`
- `attemptCount`
- `timeoutSeconds`
- `durationMs`
- `exitCode`
- `status`: `Succeeded | Failed | TimedOut`
- `sanitizedEvidence`
- `nextAction`

Invariant: Stille Ausgabe oder Timeout erzeugt niemals `Succeeded`.

## DefaultBranchEvidence

- `source`: `LocalSymbolicHead | RemoteSymbolicHead`
- `symbolicRef`
- `trackingRef`
- `remoteCommit`
- `trackingCommit`
- `fetchAttempt`
- `validatedAt`

Invariant: Symbolischer Ref, Tracking-Ref und Commit stimmen nach dem aktuellen
Fetch exakt überein.

## MutationBarrier

- `runId`
- `expectedGitTargets`
- `completedGitTargets`
- `collectionTargets`
- `blockingTargets[]`
- `allFetchAttemptsCompleted`
- `domainMutationAllowed`
- `decidedAt`
- `nextAction`

Invarianten:

- `domainMutationAllowed` ist nur wahr, wenn alle erwarteten Git-Ziele
  vollständig und erfolgreich klassifiziert sind.
- Ein früher Befund darf `completedGitTargets` späterer Ziele nicht verhindern.

## WorktreeLease

- `schemaVersion`
- `runId`
- `ownerPid`
- `ownerProcessStartedAt`
- `repository`
- `remoteRef`
- `commit`
- `worktreePath`
- `leasePath`
- `createdAt`
- `state`: `Active | Orphaned | Ambiguous | Released`

Invarianten:

- Lease und Worktree liegen im reservierten State-Bereich.
- Cleanup benötigt übereinstimmende Prozess-, Repository-, Pfad- und
  Git-Registrierungs-Evidence.
- `Ambiguous` wird nie automatisch entfernt.

## CleanupAuthorization

- `runId`
- `inventoryRevision`
- `observedAt`
- `authorizedPaths[]`
- `ownershipEvidence[]`
- `invalidatedBy`: Zustandswechsel oder `N/A`

Invariant: Nach einem relevanten Zustandswechsel ist die Autorisierung
ungültig, bis eine neue exakte Inventur abgeschlossen ist.

## PresetProfileResolution

- `profileName`
- `catalogPath`
- `presetConfigPath`
- `presetIds[]`
- `presetCount`
- `catalogSha256`

Invariant: `presetCount` wird aus `presetIds` abgeleitet und ist keine
festgelegte Codekonstante.

## RegistryConsistencyFinding

- `repositoryId`
- `primaryLanguage`
- `declaredMslStatus`
- `knownLanguageClass`
- `result`: `Pass | Conflict | JustifiedException`
- `registrySha256Before`
- `registrySha256After`
- `nextAction`

Invariant: Prüfung und Bericht ändern den Registry-Hash nicht.

## FleetRunReport

- bestehende Feature-009/015/016-Felder
- `operations[]`: geordnete `NetworkAttempt`- und Stufenereignisse
- `mutationBarrier`: `MutationBarrier`
- `targets[]`: `FleetTargetResult`
- `leaseRecovery[]`
- `profileSummary`
- `registryFindings[]`
- `overallStatus`
- `exitCode`

Invariant: Der Report kann keinen erfolgreichen Abschluss enthalten, wenn die
Barriere geschlossen, ein Pflichtziel unvollständig oder ein Retry/Timeout
fälschlich als erfolgreich klassifiziert ist.
