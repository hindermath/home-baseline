# Quickstart: Feature 019 Verification

## Preconditions

- Work on `019-agentic-workspace-regression-hardening`.
- Use the repository tool versions and locked .NET restore.
- Do not run mutating fleet maintenance for a regression test.
- Keep generated events, reports, logs and caches outside Git.

## Focused proof order

1. Run the event-emission regression fixture and verify valid JSON plus a
   contiguous sequence.
2. Run report-reconciliation tests with a missing completion event, a valid
   report and exit code 0.
3. Run foreign, unfinished and contradictory report fixtures.
4. Run Home Runtime delegation under `/bin/bash` with zero, one and multiple
   arguments.
5. Run the complete TUI, wrapper and maintenance regression suites.

## Required closeout

- Validate Bash and PowerShell autonomous run state.
- Record commands, results and skipped governance triggers in
  `autonomous-run-evidence.md`.
- Confirm no event/report schema, dependency or target-repository change.
- Obtain exact-head macOS, Ubuntu and Windows evidence before merge.
- After merge, synchronize `main`; archive R-TUI and update D4 only in the
  separately reviewed causal closeout.

