# Data Model: Wartungs-TUI- und Wrapper-Regressionshaertung

## MaintenanceEvent

- `schemaVersion`: existing value `1`
- `runId`: identifies exactly one maintenance run
- `sequence`: positive, contiguous persisted-record number
- `type`: existing stable event type
- `status`: existing semantic status
- `messageDe` / `messageEn`: text-first learner-facing explanation
- `details`: JSON object; never a quoted object or malformed fragment

**Invariant**: A sequence number becomes observable only with a successfully
persisted event record.

## ProcessInvocation

- `executable`: platform wrapper executable
- `arguments`: typed argument vector
- `displayCommand`: explanatory rendering only
- `eventStreamPath`: user-private advisory event path
- `reportPath`: deterministic expected atomic report path
- `runId`: shared ownership key

**Invariant**: Paths are derived before process start and correlated to the
same run ID. They are not discovered by scanning mutable directories.

## AtomicRunReport

- existing schema and finalization marker
- run ID, overall status and canonical engine exit code
- report and log evidence paths

**Invariant**: Only a readable, finalized report for the expected run is
accepted.

## CompletionEvent

An optional `MaintenanceEvent` of type `run-completed` that may corroborate the
report path, log path, status and exit code.

**Invariant**: If present, contradictions are errors. If absent after an event
degradation, it does not erase valid report and process evidence.

## ReconciledRunResult

- process exit code
- accepted report or explicit absence reason
- optional completion event
- event-stream degradation reason
- overall result class
- text-first next action

**Result classes**: Existing success, warning, partial, blocked, failed,
cancelled and `RESULT_MISMATCH` values remain unchanged.

## HomeRuntimeDelegation

- canonical source script
- original ordered argument vector
- argument count
- one `exec` transition

**Invariant**: Zero arguments use no empty-array expansion. Non-zero arguments
are forwarded as quoted array elements without shell re-evaluation.

