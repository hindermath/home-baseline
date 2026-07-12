# Preset Follow-up: 019 Wave-3 Visual Component Porting

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `019-wave3-visual-component-porting` |
| Feature PR | `hindermath/TuiVision#45` |
| Feature merge | `60f59511f0e546f9ddde169bb3cee87c27dc6b30` |
| Evidence closeout PR | `hindermath/TuiVision#46` |
| Closeout merge | `d699d429d4a519d9913853341daf79e4ce0b0e11` |
| Retrospective PR | `hindermath/TuiVision#47` |
| Final source main | `c7964ab88b73184347d30e34813fcb6680d2307a` |
| Delivery mode | `MergeAndSync` |
| Required checks | Passed on feature, closeout, and retrospective PRs |
| Review state | Claude passed; GraphQL reported zero threads and comments; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the otherwise sole human-approval rule after green checks and zero threads |
| Field-input snapshot | `specs/autonomous-run-governance/field-inputs/019/` |

## Workitem AR-019-01: Complete Project-local Red Matrices

| Field | Value |
|---|---|
| Observation | Grouped Help and I18n/TvHc red batches each exposed the expected missing implementation boundary with one command and each converged with one green command. This is the second field run supporting the 018 candidate. |
| Artifact kind | Task-shaping rule, skill correction, runbook clarification, task-template correction, readiness-checklist candidate |
| TuiVision-specific exclusions | Do not prescribe .NET projects, MSTest filters, manual build counters, Wave examples, or TuiVision evidence tables. |
| Generic target rule | Independent negative cases may form one complete project-local red matrix when every expected failure stays explicit and source, test, evidence, and repair ownership remain bounded. Test-first order is unchanged. |
| Occurrence count | 2 field runs: Feature 018 and Feature 019; two successful grouped slices in 019 |
| Confidence | High. The repeated pattern reduced administrative validation commands while preserving observable red boundaries. |
| Permission risk | None. The primary risk is proof ambiguity; the rule forbids grouping when ownership or expected failures cannot remain explicit. |
| Reproducible test | Generate tasks for three independent negative cases in one bounded project. Require one pre-implementation red batch, three named expected failures, no cross-project shared writer, then one bounded implementation and green batch. Fail if any case lacks a distinct acceptance result. |
| Decision | `Promote` |
| Supersedes | The `ObserveAgain` part of AR-018-02 |

### Candidate Package Surfaces

- `speckit.autonomous` command and generated agent skill
- tasks addendum and readiness checklist
- plan addendum for proof ownership
- runbook task-shaping section

## Workitem AR-019-02: Compile-Surface Review Before Red Execution

| Field | Value |
|---|---|
| Observation | The TvEdit slice reached its first red/green boundary before imports, public XML documentation, harness helpers, focus assertions, and ownership assertions were complete. Several later commands repaired compile or harness gaps rather than testing new behavior. |
| Artifact kind | Skill correction, task-template correction, readiness-checklist rule, validation-efficiency rule |
| TuiVision-specific exclusions | Do not require C# XML documentation, MSTest helper names, focus APIs, `Directory.Build.props`, or the exact TvEdit ownership model in other stacks. |
| Generic target rule | Before the first red command, review the complete compile surface for the target stack: imports/modules, public documentation or lint obligations, harness helpers, state/ownership assertions, fixture ownership, and generated/shared source identity. The review completes the planned failing contract; it must not implement behavior. |
| Occurrence count | 1 field run with multiple independently observed compile/harness repair cycles |
| Confidence | High for correctness and deterministic evidence. This is an immediate correction, not only an efficiency preference. |
| Permission risk | None. The check is read-only until normal test/source tasks execute. |
| Reproducible test | Use a synthetic typed project whose planned failing tests omit one required import, one public-doc requirement, and one harness helper. The readiness check must fail before any test command, then pass after scaffolding-only corrections while the domain test remains red. |
| Decision | `Promote` |

### Candidate Package Surfaces

- autonomous readiness-checklist template
- tasks addendum before the first red batch
- plan addendum for stack-specific compile obligations
- retrospective metrics for avoidable validation commands

## Workitem AR-019-03: Linked Source Does Not Imply Shared Type Identity

| Field | Value |
|---|---|
| Observation | One shared presentation source was linked into five executable assemblies. A cross-project proof helper initially treated the five compiled copies as one CLR type and failed at compile time. |
| Artifact kind | Skill correction, runbook clarification, plan/task-template rule, architecture-boundary checklist candidate |
| TuiVision-specific exclusions | Do not prescribe CLR, C#, linked `.cs` files, example projects, or the eventual delegate-based test helper. Other stacks may expose equivalent copied-source or generated-code identities. |
| Generic target rule | When the same source is compiled into multiple artifacts, tests must not assume one runtime type/module identity across those artifacts. Use public artifact contracts, neutral state delegates/adapters, or one intentionally shared compiled artifact when the accepted architecture owns that decision. |
| Occurrence count | 1 field run; correctness boundary reproduced by the compiler and resolved without architecture expansion |
| Confidence | High. The rule follows artifact identity semantics and prevents a concrete invalid proof assumption. |
| Permission risk | Low. Automatically creating a shared package or assembly would expand architecture; the preset must require an accepted architecture decision before doing so. |
| Reproducible test | Compile one source file into two isolated artifacts and attempt a matrix helper constrained to the source-defined type. The readiness test must reject the shared-identity assumption and accept a public-contract/delegate proof. |
| Decision | `Promote` |

### Candidate Package Surfaces

- plan addendum for artifact identity and shared-source composition
- tasks/readiness checklist
- autonomous skill task-shaping rules
- no script until a stack-neutral deterministic detector is proven

## Workitem AR-019-04: Exact Delivery Evidence Paths Confirmed

| Field | Value |
|---|---|
| Observation | Every 019 push, PR, review, merge, cleanup, and sync task named the exact feature evidence path. Analyze found no delivery mapping gap, resume stayed deterministic, and the closeout facts were recorded without ambiguity. |
| Artifact kind | Field validation of AR-018-01 |
| TuiVision-specific exclusions | Do not prescribe the path name `pr-evidence.md`, GitHub, merge commits, or numbered branches. |
| Generic target rule | Preserve AR-018-01 unchanged: every remote or delivery task names the exact repository evidence path that receives its acceptance result. |
| Occurrence count | 2 field runs; Feature 019 is the first post-correction confirmation |
| Confidence | High. The corrected rule survived Specify through MergeAndSync and closeout. |
| Permission risk | None from the evidence rule; evidence must describe authority but cannot grant it. |
| Reproducible test | Generate a synthetic `MergeAndSync` task set and require every remote task to map to one exact repository evidence path. Resume from each remote checkpoint and verify that no inferred path is needed. |
| Decision | `Promote` |
| Confirms | AR-018-01 |

## Workitem AR-019-05: Missing Reviewer and Bounded Approval Bypass

| Field | Value |
|---|---|
| Observation | Copilot review was unavailable because of requester quota on feature, closeout, and retrospective PRs. Required checks and Claude passed, GraphQL had zero threads/comments, and only Human Approval blocked each merge. |
| Artifact kind | Permission-boundary field validation |
| TuiVision-specific exclusions | Do not require Copilot, Claude, GitHub branch rules, admin bypass, or merge commits in the portable preset. |
| Generic target rule | An unavailable reviewer remains missing. Remote merge and any bypass require current explicit authority, all required checks green, zero actionable threads, and a named residual rule. The safe default remains `LocalImplementation`. |
| Occurrence count | Repeated across Features 018 and 019 plus their evidence/retrospective PRs |
| Confidence | High for the safety invariant; provider-specific quota wording may vary. |
| Permission risk | High if authority is inferred. Preset commands must refuse `PublishPR` or `MergeAndSync` without explicit current delegation and must never generalize admin rights. |
| Reproducible test | Run synthetic delivery without remote authority and with reviewer failure: expect stop plus evidence. Repeat with explicit bounded authority, green checks, zero threads, and one named approval rule: permit only that rule's bypass. |
| Decision | `Promote` |
| Provider-specific follow-up | `ObserveAgain` for quota/error classification wording |

## Snapshot Coverage

The 019 snapshot includes the field-used orchestration skill, OpenAI UI
metadata, runbook, retrospective ledger, evidence template, task template, and
the synchronized agent-policy delta. It intentionally proposes no new script:
the two new checks are currently stack-sensitive review rules, so a script
would need a later deterministic cross-stack contract and Bash/PowerShell
parity before promotion.

## Next Field Gate

Feature 020 must prove that the compile-surface review occurs before the first
red command and that grouped negative cases keep distinct failures and bounded
ownership. It must classify linked-source identity as triggered or `N/A` and
record whether any deterministic script requirement emerges.
