# Retrospective: Feature 015

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `015-windows-maintenance-hardening` at reviewed head `7d2e6981a183905510699988898bacf40d9d5623` |
| Delivery evidence | `specs/015-windows-maintenance-hardening/autonomous-run-evidence.md` |
| Delivery mode | `MergeAndSync` |
| Remote result | PR #142, merge `82e7ba62a53024d4c949c394adb0cbb34d080a0a`, synchronized `main` |
| Interruptions and resumes | No run interruption; three complete field attempts produced deterministic corrective evidence |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Generic target rule | Occurrences | Confidence | Permission risk | Reproducible test | Decision |
|---|---|---|---|---|---:|---|---|---|---|
| AR-015-001 | `rename-lastenheft.ps1` passed an empty parent to `Join-Path` when the documented root filename had no `.\` prefix. The same boundary was recorded in the 2026-07-18 native field evidence. | script requirement | Git commit text and the German Lastenheft naming profile remain repository-specific. | Treat an empty parent of an explicitly supplied repository-root filename as `.` before path composition. | 2 | High | The fix must not broaden rename scope or bypass Git status and commit evidence. | In a temporary Git repository, invoke the PowerShell script with `Lastenheft_Foo.md` and prove the exact rename commit. | Promote |
| AR-015-002 | Parent `WhatIf` preference leaked into nested read-only invocations and mode-independent lock/transcript evidence. | script requirement | The concrete Home Sync and maintenance stage names are project-specific. | Nested contracts must receive an explicit preview value, and control evidence required in every mode must opt out of inherited `WhatIf`. | 1 | High | An overbroad opt-out could mutate in preview mode; tests must enumerate allowed control writes. | Use mocked nested functions plus a temporary lock/transcript directory and assert preview performs only declared control writes. | ObserveAgain |
| AR-015-003 | A handled Home Sync drift exit was evaluated a second time as an operational failure. | checklist | Exit code `1` and the Home Sync stage are project-specific. | Capture one child result once, classify it once, and propagate only the classified result. | 1 | High | Double evaluation can falsely authorize repair or hide a real failure. | Feed success, accepted drift, and fatal exit fixtures through a temporary stage classifier. | ObserveAgain |
| AR-015-004 | Complete fleet CheckOnly and WhatIf proofs take about nine minutes because many target and content hashes are intentionally recomputed. | runbook | The 44-target Home Baseline topology is project-specific. | Preserve complete evidence; consider optimization only after a second independent run proves the same safe cache boundary. | 1 | Medium | Caching can make evidence stale or omit a target. | Compare uncached and synthetic cached reports over a temporary multi-repository fleet with one injected late drift. | ObserveAgain |
| AR-015-005 | The narrow admin merge was used only after every technical check passed and zero actionable threads remained. | evidence structure | GitHub branch-protection labels are provider-specific. | Administrative merge authority never substitutes for technical convergence or review-thread resolution. | 1 | High | Treating admin authority as general bypass would exceed user permission. | Validate a provider-neutral gate record where approval is the sole remaining policy gate. | Superseded |

## Outcome

- Local non-empty correction:
  `scripts/rename-lastenheft.ps1` and
  `scripts/tests/test_maintenance_contracts.py`.
- Portable handoff: none; AR-015-001 is corrected locally and the other
  candidates need another independent field observation.
- Pending observations: AR-015-002, AR-015-003 and AR-015-004.
- Rejected project details: concrete Home Baseline paths, stage names, package
  drift counts and the 44-target topology are not promoted.
- Next field gate: the next independent PowerShell autonomous closeout and its
  synthetic root-filename fixture; no successor feature is started here.
- Resume-state quality: `Valid`; state, tasks, exact-head gate evidence, merge,
  series archive and fresh review remain hash-bound and attributable.
