# Retrospective: Feature 016

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `016-linux-maintenance-hardening` at reviewed head `028383b1312b9e85c8ebd375cf45ad9b3ffb9b67` |
| Immutable evidence | `specs/016-linux-maintenance-hardening/autonomous-run-gate-evidence.json` |
| Delivery evidence | `specs/016-linux-maintenance-hardening/autonomous-run-evidence.md` |
| Delivery mode | `MergeAndSync` |
| Remote result | PR #146, merge `8a12143941a791528f856e6f7cfd77e6af9860d4`, synchronized `main` and Home Runtime |
| Interruptions and resumes | No run interruption; two remote corrective cycles and one concurrent-main integration were completed deterministically |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Provider-neutral target rule | Occurrences | Confidence | Permission and evidence risk | Reproducible synthetic test | Decision |
|---|---|---|---|---|---:|---|---|---|---|
| AR-016-001 | An installer inherited the registry loop's standard input and could consume later entries before they were processed. | script requirement | Homebrew/apt registry names and Home Baseline result fields remain project-specific. | Snapshot ordered input before mutation and give every potentially interactive child its own input source; emit exactly one result per selected item. | 1 | High | Missing items can be silently skipped while a run appears successful. | Run three fake installers where the first drains stdin; assert all three ordered results exist on first and idempotent second runs. | Promote |
| AR-016-002 | Required drift was visible inside the package stage but its non-zero result could be collapsed before parent finalization. | evidence structure | Exit `1`, stage names and the local report schema remain project-specific. | Capture a child result once, classify Required and Optional drift explicitly, and propagate the classified status consistently to process exit, terminal and atomic report. | 1 | High | A false success could authorize later mutation or conceal unresolved required state. | Feed Required-missing, Optional-only and complete fixtures through child and parent processes; compare exit, terminal and final report. | Promote |
| AR-016-003 | Swift fixture overrides inherited from the operator environment escaped the intended fixture boundary and replaced the real local launcher. | checklist | Swiftly paths, versions and local launcher layout are project-specific. | Mutation-capable fixtures must clear ambient destination/configuration overrides or run under an isolated temporary home, and must verify the resolved target before mutation. | 1 | High | Ambient variables can redirect a safe-looking test to real user state; restoration evidence can be incomplete. | Seed hostile destination overrides, run the fixture, and prove only a temporary sentinel changes while the real launcher hash remains constant. | Promote |
| AR-016-004 | Three Linux-contract fixtures passed locally but failed on macOS because portable registry cases declared Linux-only and real Swift provisioning was not platform-gated. | template | GitHub runner labels and Swiftly's Ubuntu matrix remain project-specific. | Portable contract fixtures must declare the executing platform; only genuinely platform-mutating fixtures may skip unsupported systems, with the skip boundary explicit. | 1 | High | A local-only pass can be misrepresented as cross-platform evidence. | Execute one portable and one platform-mutating fixture on Linux and a non-Linux runner; require the former to pass and the latter to skip explicitly. | Promote |
| AR-016-005 | A completely green exact head became unmergeable when `main` advanced concurrently; the run integrated the new baseline and repeated every head-bound gate. | runbook | PR #147 and the two statistics slots are repository-specific. | Never reuse prior exact-head evidence after integrating a new base; reconcile intentional concurrent changes and reconverge the complete gate set. | 1 | High | Reusing stale evidence would detach validation from delivered bytes. | Advance a temporary remote default branch after a candidate passes, merge it into the candidate and prove old evidence is rejected until every gate is rerun. | NoPromotion |
| AR-016-006 | The unchanged repository-wide PSScriptAnalyzer run produced no result after more than five minutes and was stopped; targeted parity checks and the remote matrix remained conclusive. | runbook | Current PowerShell inventory and runner performance are project-specific. | Do not infer success from a silent long-running analyzer; retain targeted evidence and optimize or bound the full scan only after another independent occurrence identifies a safe boundary. | 1 | Medium | A timeout labeled as pass would corrupt gate evidence; premature caching could omit files. | Use a synthetic analyzer that hangs on one file and confirm the harness records no pass while preserving completed targeted results. | ObserveAgain |
| AR-016-007 | Admin bypass was used only after 20 technical checks, zero actionable threads and 8/8 provider-neutral gates passed; it was not reused for package drift or privilege prompts. | evidence structure | GitHub review-rule names are provider-specific. | Administrative delivery authority never substitutes for technical convergence, security gates or operating-system privilege authority. | 1 | High | Treating one bypass as general authority would exceed user permission. | Validate a gate record where review approval is the sole remaining policy gate and reject one containing any failed technical entry. | Superseded |

## Outcome

- Promoted repository-local rules: ordered stdin isolation and per-item
  results, fail-closed Required aggregation, ambient-environment isolation for
  mutation fixtures, and explicit portable/platform-specific test boundaries.
  They are implemented in `scripts/maintain-agentic-brew-apps.sh`,
  `scripts/maintain-agentic-workspace.sh`,
  `scripts/lib/linux-maintenance-hardening.py` and
  `scripts/tests/test_linux_maintenance_hardening.py`.
- Portable handoff: none. The reusable rules are already expressed by the
  reviewed implementation and synthetic tests; this closeout grants no
  authority to publish or modify another repository.
- Pending observation: AR-016-006 needs a second independent full-analyzer
  occurrence before introducing timeout, cache or scan-scope changes.
- No-promotion details: the concurrent ITSE merge, statistics slot numbers,
  local package counts and Home Runtime commit remain project-specific.
- Shared guidance: reviewed with `NoUpdateRequired`; no new permanent agent
  rule was introduced.
- Validation: 13 focused Linux tests, 52 discovered tests, 20 exact-head
  remote checks, zero actionable threads and 8/8 provider-neutral gates.
- Next field gate: a future independent full-repository analyzer run may
  confirm or reject AR-016-006. No successor feature is started here.
- Resume-state quality: `Valid`; state, tasks, gate evidence, merge, series
  archive and fresh review remain hash-bound and attributable.
