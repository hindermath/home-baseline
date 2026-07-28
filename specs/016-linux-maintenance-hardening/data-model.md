# Data Model: Linux Maintenance Hardening

## RegistryItemResult

- `sequence`: positive Registry-Position
- `itemId`: validierte Registry-ID
- `scope`: `required | optional`
- `attempted`: boolean
- `finalStatus`: `Present | Installed | Planned | Failed | StillMissing`
- `probeStatus`: optionaler Verweis auf `CliProbeResult.status`
- `sanitizedEvidence`: begrenzter, secret-freier Text
- `nextAction`: text-first DE/EN

Invariant: Pro ausgewählter `sequence` existiert genau ein finales Resultat und
die Ausgabereihenfolge entspricht der Registry.

## CliProbeResult

- `toolId`
- `commandLabel`
- `status`: `Available | Missing | Unusable | TimedOut | CapabilityBlocked`
- `exitCode`
- `durationMs`
- `timedOut`
- `processTreeCleaned`
- `sanitizedEvidence`
- `nextAction`

Invariant: Ein per `PATH` gefundener Name wird nur mit erfolgreicher
Funktionsprobe `Available`.

## SwiftInstallContract

- `contractVersion`
- `swiftlyVersion`: `1.1.2`
- `swiftVersion`: `6.3.3`
- `distributionId`: `ubuntu`
- `distributionVersions`: `22.04 | 24.04`
- `swiftlyPlatform`: `ubuntu2204 | ubuntu2404`
- `architecture`: `x86_64 | aarch64`
- `archiveUrl`
- `archiveSha256`
- `profileMutationAllowed`: immer `false`
- `adminPromptRequired`: boolean für Post-Install

Invariant: Distribution, Version, Architektur, URL und Hash müssen gemeinsam
auf genau einen Vertrag zeigen. Unbekannte Kombinationen mutieren nichts.

## MaintenanceStageResult

- `stageId`
- `status`: `Passed | Warning | Blocked | Failed | DeferredAdminRequired |
  Interrupted | Skipped`
- `exitCode`
- `durationMs`
- `remainingRequired[]`
- `nextAction`

## RunReport

- bestehende Feature-009-Felder
- `runId`
- `overallStatus`
- `exitCode`
- `lastStage`
- `signal`: `N/A | INT | TERM`
- `finalized`: boolean
- `finalizedAt`
- `stages[]`
- `toolchain[]`: `RegistryItemResult`
- `findings[]`

Invarianten:

- Der Prozess-Exitcode entspricht dem Report-Exitcode desselben Run ID.
- Finalisierung erfolgt genau einmal.
- `SUCCESS`/`0` ist unmöglich, solange Required-Drift besteht oder eine Stage
  fehlgeschlagen beziehungsweise unterbrochen ist.
- Reportupdates verwenden eine temporäre Schwesterdatei und atomaren Ersatz.
