# Preset Follow-up: 020 Mouse Support and Interaction

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `020-mouse-support-interaction` |
| Feature PR | `hindermath/TuiVision#48` |
| Feature merge | `b52d90f1e6a57ac090e124fa4ba1014a7cddc1dc` |
| Evidence closeout PR | `hindermath/TuiVision#49` |
| Closeout merge | `5aca8c1798ebc7bec91ea1d7825b27144c76d910` |
| Retrospective PR | `hindermath/TuiVision#50` |
| Retrospective merge/final source main | `26cf842118b97b133bfe99e4c82759db9c2b40f2` |
| Delivery mode | `MergeAndSync` |
| Required checks | Passed on feature, closeout, and retrospective PRs |
| Review state | Claude passed; GraphQL reported zero threads/comments; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the otherwise sole human-approval rule after green checks and zero actionable threads |
| Field-input snapshot | `specs/autonomous-run-governance/field-inputs/020/` |

## Workitem AR-020-01: Causal Closeout for Self-invalidating Remote Facts

| Field | Value |
|---|---|
| Observation | A feature-branch commit recorded the PR URL and current check/thread state. The commit changed the reviewed head, made those facts historical immediately, and retriggered the complete required-check matrix. |
| Artifact kind | Runbook clarification, skill correction, tasks/evidence-template correction, agent-policy correction, readiness-checklist rule |
| TuiVision-specific exclusions | Do not prescribe GitHub, PR numbers, merge commits, Claude/Copilot, admin bypass, DocFX, numbered branches, or `pr-evidence.md`. |
| Generic target rule | Verify every required check and actionable-thread gate before merge. If committing those current-head facts would change the reviewed revision and invalidate the claim, route them and true post-merge facts to exactly one pre-named causal closeout evidence path. |
| Occurrence count | Reproduced on Feature 020: the reviewed-head evidence push caused a second full remote gate cycle; the same causal post-merge boundary already existed in Features 018 and 019. |
| Confidence | High. The revision identity changed deterministically and the remote platform reran the gates against the new head. |
| Permission risk | High if closeout wording is mistaken for merge authority. The preset must keep `LocalImplementation` as the safe default and require explicit current authority for every remote write, merge, or bypass. |
| Reproducible test | Use a synthetic `MergeAndSync` repository whose check result is keyed to the head hash. Verify head H, then attempt to commit “H passed” onto H. The readiness rule must reject that self-invalidating feature commit, require a named closeout path, still verify H before merge, and record merge/sync facts only afterward. |
| Decision | `Promote` |

### Candidate Package Surfaces

- `speckit.autonomous` command and generated agent skill
- tasks addendum and autonomous readiness checklist
- evidence and closeout templates
- runbook remote-closeout section
- agent addendum for shared policy parity
- `speckit.autonomous-retrospective` metrics for redundant gate cycles

## Workitem AR-020-02: Compile-Surface Gate Confirmed

| Field | Value |
|---|---|
| Observation | Before the first Driver red batch, Feature 020 reviewed imports, public documentation, harness helpers, focus/ownership assertions, and shared-source identity applicability. Later failures stayed inside the named parser implementation boundary. |
| Artifact kind | Field validation of AR-019-02 |
| TuiVision-specific exclusions | Do not prescribe C#, XML docs, MSTest, Driver/Controls projects, or TuiVision focus APIs. |
| Generic target rule | Preserve AR-019-02: complete the target stack's compile surface before the first red command without implementing the missing domain behavior. |
| Occurrence count | 2 consecutive field runs after correction: Feature 019 exposed the need and Feature 020 followed the corrected gate. |
| Confidence | High. The 020 red/green sequence retained explicit domain failures without avoidable missing-import, documentation, or harness setup cycles. |
| Permission risk | None; the readiness check is local and read-only until normal task execution. |
| Reproducible test | Reuse AR-019-02's synthetic typed project and require the readiness gate to pass before the domain-red command while the intended behavior remains unimplemented. |
| Decision | `Promote` |
| Confirms | AR-019-02 |

## Workitem AR-020-03: Bounded Red Matrix Confirmed Again

| Field | Value |
|---|---|
| Observation | One Driver-owned red matrix kept malformed syntax, length, number, range, button, phase, recovery, and click-boundary cases individually named while sharing one project and one repair owner. |
| Artifact kind | Field validation of AR-019-01 and AR-018-02 |
| TuiVision-specific exclusions | Do not prescribe SGR 1006, mouse protocols, .NET test filters, or manual build counters. |
| Generic target rule | Preserve the complete project-local red-matrix rule only when every expected failure and ownership boundary remains explicit. |
| Occurrence count | 3 field runs: candidate in 018, promotion in 019, confirmation in 020. |
| Confidence | High. Grouping reduced command churn without hiding any individual rejection or recovery boundary. |
| Permission risk | None; proof ambiguity remains the reason to reject grouping across owners or projects. |
| Reproducible test | Run the AR-019-01 synthetic matrix and add recovery cases that must remain independently asserted after one malformed input. |
| Decision | `Promote` |
| Confirms | AR-019-01 |

## Workitem AR-020-04: Honest Physical-host Evidence Boundary

| Field | Value |
|---|---|
| Observation | The execution host was macOS, but stdin/stdout were not interactive and `TERM=dumb`; deterministic host and protocol contracts passed while physical terminal behavior remained `NotRun`. |
| Artifact kind | Evidence-classification candidate, cross-platform readiness-checklist input |
| TuiVision-specific exclusions | Do not prescribe terminal mouse protocols, macOS/Linux/WSL, TTY variables, or the exact host matrix. |
| Generic target rule | A platform label is not physical-runtime evidence. Record deterministic injection, remote CI, and physical observation as separate evidence classes; unavailable physical conditions remain `NotRun`, never Pass. |
| Occurrence count | 1 field run with a concrete headless-versus-physical distinction. |
| Confidence | High for evidence honesty, medium for a general preset field shape. |
| Permission risk | Low. The main risk is an autonomous agent overstating environmental coverage. |
| Reproducible test | Execute a host-sensitive synthetic feature with redirected I/O. Require deterministic contract evidence to pass while the physical-observation row remains `NotRun` and names its re-evaluation trigger. |
| Decision | `ObserveAgain` |

## Workitem AR-020-05: Missing Reviewer Classification Reconfirmed

| Field | Value |
|---|---|
| Observation | Copilot requester quota was exhausted on feature, closeout, and retrospective PRs. Claude and required checks passed, GraphQL had zero actionable threads, and only the named human-approval rule remained. |
| Artifact kind | Permission-boundary field validation |
| TuiVision-specific exclusions | Do not require Copilot, Claude, GitHub branch protection, admin bypass, or any provider-specific quota text. |
| Generic target rule | Preserve AR-019-05: an unavailable reviewer is missing, not successful; a bypass requires explicit current authority, green required gates, zero actionable threads, and one named residual rule. |
| Occurrence count | 3 feature runs plus their closeout/retrospective PRs. |
| Confidence | High for the safety invariant; provider error taxonomy remains pluggable. |
| Permission risk | High if remote authority is inferred from autonomy or prior runs. The preset must refuse unauthorized `PublishPR` and `MergeAndSync`. |
| Reproducible test | Reuse AR-019-05 and add three provider failures with quota, unavailable, and timeout classifications; none may count as approval. |
| Decision | `Promote` for the invariant; `ObserveAgain` for provider taxonomy |

## Snapshot Coverage

The 020 snapshot includes the field-used orchestration skill, OpenAI UI
metadata, runbook, retrospective ledger, task/evidence templates, and the exact
agent-policy delta. It proposes no script: hash-aware closeout validation is a
candidate requirement, but no stack-neutral implementation and no Bash/
PowerShell parity contract have been proven yet.

## Next Field Gate

Feature 021 must generate remote tasks that name one causal closeout evidence
path before delivery. It must verify gates before merge without committing
current-head facts onto that same feature revision. It should re-evaluate the
physical-host evidence classification for terminal/charset scope and record
whether a deterministic cross-provider detector is now justified.
