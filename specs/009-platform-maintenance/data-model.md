# Data Model: Platformübergreifende Ein-Kommando-Wartung

## FleetManifest

- `schemaVersion`: unterstützte Manifestversion.
- `targets`: geordnete, eindeutige `FleetTarget`-Liste.
- `collections`: durch `kind: collection` innerhalb der Zielmenge dargestellt.

Validierung: Schema und semantische Regeln müssen vor jeder Mutation bestehen.

## FleetTarget

- `id`: stabil und eindeutig.
- `kind`: `git-repository` oder `collection`.
- `level`: `1` oder `2`.
- `path`: HOME-relativ, ohne Traversal.
- `active`: steuert Wartungsanwendbarkeit.
- `maintenanceClass`: `canonical-fleet` oder `preset`.
- `remote`, `forge`, `defaultBranch`: nur beziehungsweise zwingend für Git-Ziele.
- `memberDiscovery`: nur für Collections, zunächst `declared-targets`.

Zustände: `Missing`, `Current`, `Behind`, `Ahead`, `Diverged`, `Dirty`,
`Detached`, `PathConflict`, `Invalid`, `Unavailable`.

Aktionen: `None`, `WouldClone`, `Clone`, `WouldPull`, `Pull`, `Block`.

## MaintenanceStage

- `stageId`, `name`, `dependencies`.
- `status`: `Pending`, `Running`, `Passed`, `Warning`, `Blocked`, `Failed`,
  `Skipped`.
- `exitCode`, `startedAt`, `durationMs`.
- `summary`, `nextAction`.

Übergänge: `Pending -> Running -> terminal`. Ein abhängiger Schritt darf nur
starten, wenn seine Pflichtabhängigkeiten `Passed` oder zulässig `Warning` sind.

## TargetResult

- Referenz auf genau ein `FleetTarget`.
- ermittelter Zustand, geplante/ausgeführte Aktion und Ergebnis.
- Branch, Upstream, Ahead/Behind und sicher redigierte Remote-Identität.
- Finding-Referenzen und sichere nächste Aktion.

## Finding

- stabile `findingId`, `targetId` oder `stageId`.
- `severity`: `Info`, `Warning`, `Blocking`, `Fatal`.
- `code`, bilinguale Kurzursache, `nextAction`.
- keine Secrets, absoluten persönlichen Fremdpfade oder vollständigen
  Unterprozessausgaben.

## RunReport

- `schemaVersion`, `runId`, Plattform, Modus, Start/Ende.
- `overallStatus`: `SUCCESS`, `SUCCESS_WITH_WARNINGS`, `DRIFT`, `PARTIAL`,
  `FAILED`.
- Stufen-, Ziel-, Toolchain- und Finding-Listen.
- lokale Log- und Reportpfade.
- Aggregatzahlen und finaler Exitcode.

Konsistenz: Jede aktive Ziel-ID erscheint genau einmal. Gesamtstatus und
Exitcode werden ausschließlich aus terminalen Ergebnisobjekten abgeleitet.
