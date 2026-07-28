# Research: Windows Maintenance Hardening

## Decision 1: Canonical maintenance mode

Use one internal mode value (`CheckOnly`, `Preview`, `Update`) and derive every
nested parameter set from it. This prevents PowerShell common `-WhatIf` state
from being combined with explicit check switches.

## Decision 2: Python launcher probing

Probe `python3`, then `python`, then `py -3` with a bounded child process and a
small Python expression that returns the major version. Command discovery
alone is rejected because Microsoft Store aliases can resolve but fail.

## Decision 3: Early prerequisites

Read-only and preview modes report prerequisite state without installation.
An update run checks the Python contract and pinned PSScriptAnalyzer before its
first mutation. Missing prerequisites produce a correlated terminal report and
an exact next action.

## Decision 4: Resume evidence

Persist one atomically replaced JSON document under the local state directory.
Only repository-relative paths and SHA-256 before/after values are accepted.
Resume compares every current hash; partial or unknown matches fail closed.

## Decision 5: Retry classification

Retry only bounded network/transient diagnostics such as timeout, connection
reset and temporary name resolution. Authentication, authorization, not found,
dirty, ahead and diverged states are terminal. Use small capped exponential
backoff plus jitter.

## Decision 6: WinGet process boundary

Use `System.Diagnostics.Process` with argument lists and a hard timeout.
Timeout kills the complete tree, waits for cleanup and returns a structured
result. Admin-required or interactive outcomes are deferred, not reported as
success and not technically bypassed.

## Decision 7: Package status precedence

Normalize IDs case-insensitively and reduce observations to one final state:
`CONFLICT` > `FAILED` > `DEFERRED_ADMIN_REQUIRED` > `MISSING` > `OK`.
Detection and summary consume the same installed-ID set.

## Decision 8: Report and process status

The run-correlated report is the canonical terminal result. The orchestrator
finalizes it, reads back the same Run ID and exits with its canonical exitcode.
Older reports are never considered.
