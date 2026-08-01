# Contract: Event and Result Reconciliation

## Event persistence

1. The writer receives a JSON object for `details`.
2. Sequence starts at 1 and represents persisted record order.
3. A failed write is reported as event-stream degradation and does not reserve
   a public sequence number.
4. A normal run has exactly one matching start and completion record.

## Report ownership

1. The expected report path is derived from Home directory and run ID before
   process start.
2. The report must be finalized and carry the expected run ID.
3. A completion event may provide the same report path; a foreign or
   contradictory path is rejected.
4. No directory search, newest-file selection or cross-run fallback is allowed.

## Reconciliation

| Process | Final report | Completion event | Outcome |
|---|---|---|---|
| Matches | Valid and matching | Matching | Canonical result |
| Matches | Valid and matching | Missing after degradation | Canonical result plus degradation notice |
| Matches | Missing or unfinished | Any | Missing evidence; never implicit success |
| Any | Contradictory canonical values | Any | `RESULT_MISMATCH` |
| Any | Valid report | Contradictory event | `RESULT_MISMATCH` |

## Accessibility

Every outcome exposes status, reason and next action as stable text. Color,
animation and column position are optional enhancements only.

