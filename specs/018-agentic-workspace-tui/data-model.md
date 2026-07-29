# Data Model: Agentic-Workspace-Wartungs-TUI

## Invocation Context

| Field | Type | Rules |
|---|---|---|
| `platform` | enum | `macos`, `linux`, `windows` |
| `architecture` | enum | `arm64`, `x64` |
| `standardInputInteractive` | boolean | Direct terminal fact |
| `standardOutputInteractive` | boolean | Direct terminal fact |
| `terminalCapabilities` | value object | Color, interactivity and width; never grants safety authority |
| `explicitUiMode` | enum | `Auto`, `Enhanced`, `Plain`, `Headless` |
| `homeDirectory` | normalized path | Validated by canonical engine before use |
| `existingArguments` | string list | Existing argument implies Headless unless only allowed UI/home arguments |

**Invariant**: Auto launches the enhanced path only when input and output are
interactive. Explicit Enhanced may fall back to Plain; non-interactive Auto is
Headless.

## Maintenance Selection

| Field | Type | Rules |
|---|---|---|
| `mode` | enum | `CheckOnly`, `DryRun`, `Update` |
| `scriptsOnly` | boolean | Excludes optional packages |
| `includeOptional` | boolean | Invalid when `scriptsOnly` |
| `repairDrift` | boolean | Valid only with `Update` |
| `homeDirectory` | normalized path | Optional override |
| `confirmed` | boolean | Required only for `Update`; default false |

**State transitions**:

```text
Draft -> Validated -> Summarized -> Confirmed -> Started
                         |             |
                         +-> Cancelled <-+
```

`CheckOnly` and `DryRun` move from Summarized directly to Started. `Update`
requires Confirmed. Any invalid combination remains Draft with a textual error.

## Process Invocation

| Field | Type | Rules |
|---|---|---|
| `executable` | path/token | `bash` or `pwsh` selected by platform |
| `arguments` | ordered string list | Typed arguments, never a shell command string |
| `displayCommand` | string | Escaped explanation only |
| `eventStreamPath` | user-private path | Unique per run |
| `environment` | key/value subset | Minimal inherited environment |
| `runId` | UUID | Matches events and final report |

## Maintenance Event v1

| Field | Type | Rules |
|---|---|---|
| `schemaVersion` | integer | Exactly `1` |
| `runId` | UUID | Same for all records in one run |
| `sequence` | positive integer | Starts at 1 and strictly increases by 1 |
| `timestampUtc` | RFC 3339 UTC | Ends in `Z` |
| `eventType` | enum | `run-started`, `phase-started`, `phase-progress`, `finding`, `phase-completed`, `run-completed` |
| `status` | enum | `RUNNING`, `PASSED`, `PARTIAL`, `BLOCKED`, `WARNING`, `SKIPPED`, `FAILED` |
| `phaseId` | nullable enum | `fleet`, `level0`, `home-sync`, `registry`, `propagation`, `preset-profiles`, `toolchain`, `final` |
| `targetId` | nullable stable string | Never derived from free display text |
| `messageDe` | string | Short, secret-free, CEFR B2 |
| `messageEn` | string | Semantic English counterpart |
| `details` | object | Event-specific, secret-free |

**Lifecycle**:

```text
run-started
  -> (phase-started -> phase-progress/finding* -> phase-completed)*
  -> run-completed
```

Missing or invalid event transitions degrade presentation. They do not change
the engine lifecycle or process exit.

## Event Reader State

| Field | Type | Rules |
|---|---|---|
| `byteOffset` | non-negative integer | Advances only through complete lines |
| `expectedSequence` | positive integer | Starts at 1 |
| `presentationMode` | enum | `Enhanced`, `Compact`, `Linear`, `Degraded` |
| `degradationReason` | nullable enum | Invalid JSON, sequence gap, schema, run mismatch |
| `lastEvent` | nullable event | Advisory only |

An incomplete final line is retained for the next read. Once degraded, the
reader continues linear log presentation and never recovers a false enhanced
state for the same run.

## Atomic Run Report Reference

| Field | Type | Rules |
|---|---|---|
| `path` | user-private path | Supplied by `run-completed` or known wrapper contract |
| `runId` | UUID | Must equal invocation run |
| `finalized` | boolean | Must be true for canonical report use |
| `overallStatus` | canonical status | Existing engine vocabulary |
| `exitCode` | integer | `0`, `1`, `2`, `3`, or `130` |
| `logPath` | path | Display-only evidence path |

## Reconciled Run Result

| Field | Type | Rules |
|---|---|---|
| `processExitCode` | integer | Canonical on contradiction |
| `report` | nullable atomic report | Valid only after identity/finalization checks |
| `completionEvent` | nullable event | Advisory |
| `displayStatus` | enum | Canonical status or `RESULT_MISMATCH` |
| `mismatchReasons` | string list | Textual and secret-free |
| `nextAction` | string | Copiable DE-first/EN-second guidance |

**Decision order**:

1. Validate process termination and exit code.
2. Validate report identity and finalization.
3. Validate completion event identity and references.
4. If all agree, show canonical report status.
5. If any disagree, show `RESULT_MISMATCH` and retain the process exit code.

## UI Build Descriptor

| Field | Type | Rules |
|---|---|---|
| `sourceFingerprint` | SHA-256 | Sorted relative paths and raw bytes plus UI version |
| `platformId` | enum | `macos-arm64`, `macos-x64`, `linux-arm64`, `linux-x64`, `windows-arm64`, `windows-x64` |
| `cacheDirectory` | path | Below `~/.home-baseline/cache/maintenance-tui/` |
| `entryAssembly` | path | Must exist inside complete cache directory |
| `publishedAtomically` | boolean | Partial temporary build is never eligible |

**Transitions**:

```text
Missing -> BuildingTemporary -> Validated -> Published
   |              |                |
   +-----------> PlainFallback <----+
```

## Dashboard State

Dashboard state is a projection, not authoritative business data. It includes
the current phase, mutation barrier, planned/running/passed/skipped/failed
target counts, pull/block classes, finding counts, lease/profile summaries,
latest safe action and final evidence paths.

Unknown totals remain unknown. Refresh is rate-limited to 10 per second.
