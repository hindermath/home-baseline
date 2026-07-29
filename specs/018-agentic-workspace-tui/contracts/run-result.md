# Contract: Run Result Reconciliation

## Inputs

1. Terminal process exit code.
2. Atomically finalized JSON report for the same run.
3. Optional `run-completed` event for the same run.

## Decision

1. The process must have terminated.
2. A report is canonical only when its run ID matches and finalization is
   complete.
3. A completion event is advisory and must match run ID, report path, status
   and exit code.
4. Agreement produces the report's canonical status and process exit.
5. Any contradiction produces visible `RESULT_MISMATCH`; process exit remains
   the returned exit code.
6. Missing or malformed live events may produce `EVENT_STREAM_DEGRADED` but do
   not modify the engine result.
7. An engine failure is never automatically retried through a UI fallback.

## Exit Codes

| Exit | Meaning |
|---:|---|
| 0 | Current or successful |
| 1 | Drift, blocked or partial result |
| 2 | Parameter, operational or safety failure |
| 3 | Local repair completed; separate review required |
| 130 | User cancellation |
