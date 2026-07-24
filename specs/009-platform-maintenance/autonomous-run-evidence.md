# Autonomous Run Evidence

## Identity

- Run ID: `8e7a473b-e9b9-414a-9e93-006a98b81b61`
- Feature: `009-platform-maintenance`
- Delivery mode: `MergeAndSync`
- Base checkpoint: `459c8d6a99e3bd9b14321252c947be7733649df7`
- Binding intake: `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md` (archived after implementation)

## Accepted input

| Artifact | Evidence |
|---|---|
| Intake | SHA-256 `8cc50f591e9b73db85070413395099d73fbaaf526ee89a1666aa9b679915a839` |
| Authoring receipt | `ee971b7c-65b3-4160-932d-0657e4e73fa8`, valid |
| Series review | `5ce575e0-90a0-4946-b183-b8c3e1d83a71`, `Ready` |
| Review result | SHA-256 `0b45cf38e4f79aa15bc8245a0dd81c3e466abcdb01b9d1a8c06481a3cd0c9f6f` |

## Phase ledger

| Phase | Result | Evidence / boundary |
|---|---|---|
| Preflight | Pass | Clean synchronized `main`; `specify check`; ten presets |
| Specify | Pass | `spec.md`; requirements checklist complete |
| Clarify | Pass | No material ambiguity that changes planning |
| Plan | Pass | Plan, research, model, contracts, quickstart and checklists |
| Tasks | Pending | Generated after plan convergence |
| Analyze | Pending | Read-only consistency pass after tasks |
| Implement | Pending | No implementation edit before this evidence file |
| Validate | Pending | Commands and results appended during implementation |
| Publish/Review/Merge | Pending | Current repository only; no fleet repository writes |
| Retrospective | Pending | Promotion only for reproducible provider-neutral learning |

## Scope guard

Feature 009 may change Level-0 scripts, contracts, tests and documentation. It
must not commit, push or repair any of the 32 target repositories. The later
Position-4 remote-freshness, arbitrary-default-branch and hard-abort cleanup
scope remains outside this feature.

## Validation ledger

| Command / proof | Result | Boundary |
|---|---|---|
| `python3 -m unittest scripts.tests.test_maintenance_contracts scripts.tests.test_agentic_workspace_maintenance` | Pass, 17 tests | Local bare remotes and temporary HOME only |
| `bash -n scripts/maintain-agentic-workspace.sh` | Pass | Bash syntax |
| PowerShell parser | Pass | `maintain-agentic-workspace.ps1` |
| `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1` | Pass, 114 files, zero findings | Repository-owned PowerShell |
| Bash real-home `--dry-run --scripts-only` | Expected `1`, complete 43-target report | No clone or pull; six `WOULD_CLONE`, one `PathConflict`, one `BranchMismatch` |
| PowerShell isolated-HOME `-ScriptsOnly -WhatIf` | Expected `1`, complete 43-target report | No target checkout created |

The deliberately invalid manifest fixtures return the fatal contract boundary
and make the negative path red; the complete unit suite passes because those
failures are asserted. The first integrated green run contained 17 tests.

## Design and behavior evidence

- Exact manifest cardinality: 42 active Git targets plus one collection.
- Maintenance classes: 32 `canonical-fleet`, ten `preset`.
- Clone proof: sibling clone, remote/branch/clean verification, atomic move,
  cleanup after failure and idempotent second run.
- Blocker proof: Dirty, Ahead, Diverged, Detached, BranchMismatch,
  RemoteMismatch, MissingUpstream and PathConflict preserve the checkout.
- Continuation proof: failed clone does not hide the independent collection
  result and still writes a terminal JSON report.
- Preview proof: Check-only and Dry-run/WhatIf do not create missing targets.
- Exit proof: required drift is `1`; fatal contract failure is `2`; the
  compatible repair-only `3` remains documented.
- PR #90 proof boundary: existing `sync-home` no-op tests remain part of the
  full repository validation; Feature 009 does not reimplement that fix.

## Comment review

| Area | Decision | Rationale |
|---|---|---|
| Manifest parent semantics | CommentNeeded | Explains why declared parents are a security boundary |
| Transactional clone | CommentNeeded | Explains why the sibling path is required |
| Atomic report replacement | CommentNeeded | Explains the evidence-preservation boundary |
| Bash wrapper option and stage wiring | NoCommentNeeded | Names and native control flow are direct |
| PowerShell wrapper option and stage wiring | NoCommentNeeded | Cmdlet names and structured calls are direct |

All three new didactic blocks are German-first/English-second and contain two
lines. No longer block is required.

## Governance evidence

| Checkpoint | Applicability | Result and re-evaluation trigger |
|---|---|---|
| NIST SSDF / CWE Top 25 | Applicable | Path, argument, subprocess and output boundaries have positive and negative tests |
| STRIDE / CIA / CAPEC | Applicable | Spoofed remotes, path tampering, unsafe state mutation and evidence loss are fail-closed |
| OWASP SAMM | Applicable | Repeatable maintenance tests and machine evidence improve verification maturity |
| OpenSSF Scorecard | Applicable | Exact-head CI and secret scanning remain merge gates |
| OWASP ASVS | N/A | No web, API, auth or session surface; reconsider on such a scope |
| SBOM / VEX / SLSA | N/A | No dependency, binary package or release pipeline; reconsider when one changes |
| AI-SBOM | N/A | AI is a development tool only; reconsider for model or inference delivery |
| Zero Trust | N/A | No new remote service or identity plane; reconsider for managed service scope |
| BSI C3A / BSI C5 | N/A | No cloud selection or cloud operation; reconsider when a provider boundary changes |
| NIS2 / CRA / EU AI Act / DORA | N/A | No market product, AI runtime or regulated financial ICT delivery; reconsider on changed operating scope |
| A11Y | Applicable | Stable text order, bilingual help, color-independent status and JSON evidence |
| Agent parity | Applicable, unchanged | No durable agent rule changed; all five surfaces were reviewed together |
| Parallel Autonomous | N/A | One serialized Feature 009 run; reconsider for a separately authorized fleet campaign |

## Current residual findings

The real dry-run truthfully reports local fleet state outside Feature 009:

- `cc65` is intentionally on `upstream/noexec-bsd-find`, not declared `master`.
- The Intake Authoring preset path exists as a non-Git directory.
- Six other declared preset repositories are currently missing.

Feature 009 does not repair these host states or create target-repository PRs.
They are safe next-run findings, not implementation failures.
