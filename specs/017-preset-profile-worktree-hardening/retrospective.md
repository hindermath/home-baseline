# Retrospective: Feature 017

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `017-preset-profile-worktree-hardening` at reviewed head `7c46069b40cce595091440de18741d59ca48a3d1` |
| Immutable evidence | `specs/017-preset-profile-worktree-hardening/autonomous-run-gate-evidence.json` |
| Delivery evidence | `specs/017-preset-profile-worktree-hardening/autonomous-run-evidence.md` |
| Delivery mode | `MergeAndSync` |
| Remote result | PR #153, merge `9ae8ecbe9cd19d9f7d7cfab9ce960361082f872a`, synchronized `main` and Home Runtime |
| Interruptions and resumes | No interruption or resume |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Provider-neutral target rule | Occurrences | Confidence | Permission and evidence risk | Reproducible synthetic test | Decision |
|---|---|---|---|---|---:|---|---|---|---|
| AR-017-001 | Dirty, behind and otherwise blocked repositories still require bounded fetch evidence before mutation is refused. | script requirement | The 44 Git targets, Collection and current fleet paths remain Home-Baseline-specific. | Complete safe remote inspection for every declared target before allowing any downstream mutation; continue inventory after individual findings. | 1 | High | Early exit can hide later blocking repositories and produce incomplete authority evidence. | Use multiple bare remotes with the first target blocked; assert every later target receives one bounded fetch result before the barrier decision. | NoPromotion |
| AR-017-002 | Temporary preset validation must bind repository, canonical ref, exact commit, process identity and owned state paths so hard-abort cleanup cannot touch foreign worktrees. | script requirement | The local lease directories and preset profile names remain project-specific. | Recover only exact owned leases whose process identity is stale and whose worktree remains clean, registered, contained and commit-matched. | 1 | High | Broad cleanup could delete user work or a live process's state. | Exercise active, PID-reused, foreign, tampered, escaped, untracked and safe-orphan leases twice and compare retained/removed paths. | NoPromotion |
| AR-017-003 | A profile's observed preset count is evidence, not a code constant. | architecture rule | The current eleven-preset profile and repository registry remain project-specific. | Resolve expected components from a versioned profile catalog and validate a synthetic extension without implementation changes. | 1 | High | Fixed cardinalities turn an optional extension into false fleet drift. | Validate current and one-component-extended fixtures through the same resolver. | NoPromotion |
| AR-017-004 | The real check-only run can correctly end non-zero while still proving complete inventory, lease cleanup, profile parity and zero mutation. | evidence structure | Current behind states and maintenance-package drift are transient fleet facts. | Preserve per-stage results and final fail-closed status; never relabel partial success as complete success. | 1 | High | Collapsing partial evidence could authorize mutation despite unresolved fleet state. | Combine one blocked freshness target, clean profile checks and optional toolchain drift; require complete stage evidence and non-zero final status. | NoPromotion |
| AR-017-005 | Exact-head technical convergence preceded the narrow admin bypass; unavailable human review remained missing rather than Pass. | runbook | GitHub rule names and PR #153 are provider-specific. | Administrative authority may satisfy only the final human-approval policy gate after every technical gate and actionable thread has converged. | 1 | High | A broad bypass would replace quality evidence with repository privilege. | Reject a candidate with any failed gate or thread; accept only a candidate whose sole remaining rule is Human Approval. | NoPromotion |

## Outcome

- Decision: `NoPromotion`.
- The provider-neutral safety rules are already implemented in the repository
  contracts, tests and operator documentation. No defect was found in
  `autonomous-run-governance`, `parallel-autonomous-governance` or the Intake
  presets.
- Shared agent guidance and `.specify/templates/` remain
  `NoUpdateRequired`; this run changes maintenance behavior and evidence, not
  the durable agent workflow contract.
- The real fleet findings remain outside Feature 017. This closeout grants no
  authority to update, commit, push or merge target repositories.
- Resume-state quality: `Valid`. Tasks, accepted hashes, exact-head evidence,
  feature merge, Home Runtime sync, Series archive and fresh review remain
  attributable.
- Position 4 is now `Eligible`, but no successor feature, branch or Spec Kit
  run is started.
