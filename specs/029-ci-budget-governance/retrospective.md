# Autonomous Run Retrospective

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | Feature `029-ci-budget-governance`; accepted feature HEAD `e1ff2a0b5146604b2a71a20576dbd4341d618121`; merge commit `b6a0d81760e9ef68a058e5d9578073b5e78b61b8`; run `eca02c0f-5399-49c0-8de4-b21233834254` |
| Delivery evidence | `specs/029-ci-budget-governance/autonomous-run-gate-evidence-premerge.json`, normalized SHA-256 `10af4b8e40a88452c3309ccb9a873d375672bb10eac7739ba4f8a96c03f34ba4`; and `specs/029-ci-budget-governance/autonomous-run-gate-evidence-postmerge.json`, normalized SHA-256 `e795e07fa0ff8c55d9e63d1826230d2e7171bdc9af036e903c8f04d1cc766637` |
| Delivery mode | `MergeAndSync` for the completed Stage A implementation and one causal closeout |
| Remote result | PR `#247` merged as `b6a0d81760e9ef68a058e5d9578073b5e78b61b8` after `26/26` successful jobs; the explicitly authorized admin bypass replaced only the missing review approval. `main` then synchronized to `0 0`, and Home sync completed as local Home-repository commit `b5e5f70`. No target-repository mutation, Stage B rollout, or G4 start occurred. |
| Interruptions and resumes | `PausedByUser` / `Blocked` resumed at `2026-08-20T16:53:49Z`; Tasks and Analyze were revalidated; T025 used the scoped `implementationRecovery`; completion used `implementationCompletionRecovery` after the unexpected rename commit |

## Evidence Basis

- The run-state accepted-artifact audit and a fresh local hash comparison cover
  `20/20` accepted feature artifacts. The known commit-time trailing-whitespace
  normalization in `spec.md` and `checklists/requirements.md` remains the
  already accepted non-semantic drift recorded by the resume audit.
- `specs/029-ci-budget-governance/tasks.md` contains `93/93` checked tasks and
  has SHA-256
  `859a4daf4138e072b0b0ea595a76f556c047e06e24552ba0f171771e2080d684`.
  The implementation phase result reports `expectedTasks=93`,
  `completedTasks=93`, `gatesSatisfied=true`, and has normalized SHA-256
  `c0ae8be8fb540c412b48937c28c0772da10f6b885e4ca091af0811e1de0b9125`.
- The accepted schema-2.0 `PreMerge` snapshot contains exactly one passing
  `Primary` entry for each of `AC-CBG-001` through `AC-CBG-010`, no
  `Supplemental` entry, and exact reviewed HEAD `e1ff2a0b5146604b2a71a20576dbd4341d618121`.
  Fresh Bash and PowerShell validation returned `Pass` with
  `mergeAuthorized=false`.
- The separate schema-2.0 `PostMerge` snapshot binds normalized PreMerge hash
  `10af4b8e40a88452c3309ccb9a873d375672bb10eac7739ba4f8a96c03f34ba4`
  to actual merge commit `b6a0d81760e9ef68a058e5d9578073b5e78b61b8`, adds no
  product delta, and passed both validators with `mergeAuthorized=true`.
- The repository-local autonomous state records merge/publication,
  default-branch synchronization, post-merge actions, and final validation as
  `Completed`. The causal closeout carries only terminal evidence and state;
  its own provider merge and final synchronization are verified externally to
  avoid a recursive closeout PR.

## Observations

| ID | Boundary | Artifact kind | Occurrences | Confidence | Decision |
|---|---|---|---:|---|---|
| AR-001 | Permission and correctness | Script requirement | 1 | High | `Promote` |
| AR-002 | Evidence integrity | Evidence structure | 1 | High | `Promote` |
| AR-003 | Permission and evidence integrity | Runbook | 1 | High | `Promote` |
| AR-004 | Correctness and evidence integrity | Project-specific implementation | 1 | High | `Promote` |
| AR-005 | Correctness, permission, and evidence integrity | Checklist | 1 | High | `Promote` |
| AR-006 | Efficiency preference | Command | 1 | Medium | `ObserveAgain` |

Correctness, permission, and evidence-integrity defects AR-001 through AR-005
are promoted after one deterministic occurrence. AR-006 is deliberately kept
separate: it proposes an efficiency optimization, not a correctness repair,
and therefore needs a second independent field observation.

### AR-001 — A no-commit delivery mode was violated by a helper script

- **Source and evidence**: Feature 029 task T093 in
  `specs/029-ci-budget-governance/tasks.md`;
  `specs/029-ci-budget-governance/autonomous-run-state.json` at
  `implementationCompletionRecovery`; and
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/rename-commit-recovery.json`
  (SHA-256
  `341442bce5cd85fd5af58e8c242c9a3beb63f6c222ea2d05c35c9c5b5bf6815c`).
- **Observation and boundary**: `scripts/rename-lastenheft.sh` performed the
  requested rename and also created commit
  `e3b5cd097c62c877b4b0e6f59bc139089375f9fa`, although the active authority
  allowed local implementation but prohibited commits and remote writes. The
  root orchestrator removed only that commit with
  `git reset --mixed 039784a55ae3c06e206035c9b850de3c8490311f`, preserved the
  working-tree rename, restored `ahead=0` and `behind=0`, and did not push.
  This is a deterministic permission-boundary and script-requirement defect,
  not an efficiency preference.
- **Artifact kind**: `script requirement`.
- **Project-specific exclusions**: The Lastenheft filenames, T093, the branch
  name, both commit IDs, the commit message and co-author, and
  `scripts/rename-lastenheft.sh` are evidence of this occurrence, not parts of
  the portable rule. This retrospective authorizes no change to that script.
- **Provider-neutral target rule**: A workflow helper invoked under authority
  that excludes commits MUST NOT create a commit. Working-tree mutation and
  commit publication MUST be separate operations; the commit operation MUST
  require explicit current authority and fail closed when it is absent.
- **Occurrence count and confidence**: `1`; `High`, because the unexpected
  commit, its two paths, the exact recovery command, the preserved rename, the
  final HEAD, and zero push are recorded together.
- **Permission risk**: `High`; an implicit commit changes repository history
  outside the active delivery authority and can accidentally include more
  staged content than the helper's named mutation.
- **Evidence risk**: `Medium`; without before/after HEAD, changed-path, index,
  and status evidence, a later reset could either lose intended work or hide
  unrelated history changes.
- **Reproducible test**: In a temporary Git repository, commit a fixture file,
  invoke a rename helper under a synthetic `allowWorkingTree=true,
  allowCommit=false` authority, and assert that HEAD and index are unchanged
  while only the requested working-tree rename appears. A second case with
  explicit commit authority may exercise a separately named commit operation
  and assert its exact path set.
- **Decision**: `Promote`.

### AR-002 — Narrative capture overwrote the first structured Tasks result

- **Source and evidence**:
  `specs/029-ci-budget-governance/autonomous-run-state.json` at
  `resumeAudit.rerunGates.tasksResult`, plus the recovered
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/tasks.result.json`
  (normalized SHA-256
  `bcfa79842ed4a4b0005d3f895fd2b4c3a822120a012528f026b905d2d16b7381`).
- **Observation and boundary**: The first Tasks payload completed, but the
  runner's final narrative replaced the transient structured result. Strict
  JSON validation then failed closed with AEI002. A result-only retry using
  attempt `0d0772ba-3faf-4b2a-a5bc-45d8be2b3e03` published the valid result
  for the 93-task payload. This is an evidence-integrity boundary: a successful
  payload is not a completed phase until its machine result is independently
  and durably valid.
- **Artifact kind**: `evidence structure`.
- **Project-specific exclusions**: The Tasks command, task count, attempt ID,
  AEI002 label, local runner executable, and its final-message option are
  occurrence details. The portable rule does not require a particular model,
  CLI, provider, or error-code vocabulary.
- **Provider-neutral target rule**: A phase runner MUST use distinct sinks for
  human narrative and machine result publication. The machine result MUST be
  written atomically to a dedicated path, validated after the phase process
  exits, and never be the destination of generic final-message capture.
  Narrative capture MUST remain diagnostic only and MUST NOT establish or
  overwrite phase completion.
- **Occurrence count and confidence**: `1`; `High`, because the resume audit
  records the initial disposition, fail-closed boundary, retry attempt,
  payload hash, result hash, task count, and passing revalidation.
- **Permission risk**: `Low`; separation changes evidence plumbing, not
  delivery authority, provided neither sink grants additional write scope.
- **Evidence risk**: `High`; sink aliasing can replace valid structured proof
  with unparseable or semantically incomplete prose and can misreport a
  completed phase as either passed or failed.
- **Reproducible test**: Use a synthetic runner whose phase writes valid JSON
  and whose final response emits narrative. Bind narrative and result to
  distinct temporary files; assert that the result remains byte-stable and
  validates. A negative fixture intentionally aliases both paths and MUST fail
  before publication with an explicit sink-collision error.
- **Decision**: `Promote`.

### AR-003 — A nested sandbox correctly blocked a Git-metadata write

- **Source and evidence**:
  `specs/029-ci-budget-governance/autonomous-run-state.json` at
  `implementationRecovery`, and
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`
  (SHA-256
  `561c8ff651b93f1c53fb3a30843e0e346c9942c0ec992c7c0aeaa93372c4330f`).
  The latter is hash-bound from the final `AC-CBG-007` and `AC-CBG-008`
  evidence.
- **Observation and boundary**: The nested implementation sandbox completed
  T001 through T024 but could not write `.git/hooks/pre-push` at T025. The root
  orchestrator rechecked the current `LocalImplementation` scope,
  syntax-checked the installer, performed only the explicitly required local
  hook installation, and returned control. The sandbox then verified source
  and installed hashes, byte parity, executable state, a passing fixture, a
  blocking fixture, and zero push. The denial was a valid permission boundary;
  the reusable learning is the scoped recovery and independent revalidation.
- **Artifact kind**: `runbook`.
- **Project-specific exclusions**: T025, `.git/hooks/pre-push`, macOS, Unix
  modes, the installer name, hook hash, and AC-CBG identifiers are excluded
  from the generic rule. They remain immutable occurrence evidence only.
- **Provider-neutral target rule**: When a delegated worker cannot perform an
  explicitly required repository-metadata mutation, it MUST stop and report
  the exact blocked target and completed boundary. A coordinator MAY perform
  only that mutation after revalidating current authority and inputs. The
  delegated worker or an independent validator MUST then revalidate content
  identity and required pass/block behavior. The recovery MUST NOT widen the
  worker sandbox, imply remote authority, or silently mark the task complete.
- **Occurrence count and confidence**: `1`; `High`, because blocker, scoped
  resolution, matching source/target hashes, byte comparison, executable mode,
  both behavioral fixtures, and `pushPerformed=false` are recorded.
- **Permission risk**: `High`; repository metadata can alter later Git
  behavior, and an unscoped coordinator recovery could bypass the very
  isolation that correctly stopped the worker.
- **Evidence risk**: `High`; installation success alone does not prove byte
  identity or behavior, while worker-only evidence cannot prove a write that
  the worker was unable to perform.
- **Reproducible test**: Create a temporary repository and inject a metadata
  adapter that denies the delegated hook write. Assert a blocked handoff with
  no task completion. Let a coordinator with synthetic, narrowly scoped local
  authority install one fixture hook, then have the delegated validator prove
  source/target hash equality, executable state, one pass fixture, one block
  fixture, and no network or push call.
- **Decision**: `Promote`.

### AR-004 — Synthetic process identity masked a host capability

- **Source and evidence**:
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/retrospective.prompt.md`
  (SHA-256
  `33d73c67e5eea24254895fc6a114b044d809e5e14d6e1a093faa43bec8b99d86`),
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/regression-macos.json`
  (SHA-256
  `896367560143251d1bbe4a036281dfd87d444614453876b7b7200529e234afde`),
  and the corrected, evidence-bound
  `scripts/tests/test_agentic_workspace_maintenance.py` (SHA-256
  `f86e967eba512c41ee8d530c8dbb0dc78be7eb6063669648b7c052c0612fcd28`).
- **Observation and boundary**: Final independent validation found that the
  test helper supplied a synthetic owner-process identity even when the host
  could query the real identity. The mismatch produced a false
  `AMBIGUOUS_PID_REUSE`. The test-only correction probes the capability and
  supplies the synthetic creation fallback only when the capability is absent;
  capability-dependent recovery tests are skipped when their prerequisite is
  unavailable. The validation history records three consecutive focused
  passes, followed by the persisted full 30-test suite with zero failures and
  zero skips on the capable macOS host. The persisted regression record binds
  the corrected test-file hash.
- **Artifact kind**: `project-specific implementation`.
- **Project-specific exclusions**: The lease format, maintenance test module,
  process-query commands, `AMBIGUOUS_PID_REUSE` token, macOS, test names, and
  exact helper functions are excluded from promotion.
- **Provider-neutral target rule**: A test helper MUST NOT inject a synthetic
  capability value when the system under test can obtain the real value.
  Synthetic fallback MUST be conditional on demonstrated capability absence,
  and tests whose semantics require the real capability MUST declare and
  enforce that prerequisite rather than converting a real observation into a
  synthetic mismatch.
- **Occurrence count and confidence**: `1`; `High`, because the defect and
  correction are deterministic, the corrected file is hash-bound, the focused
  test passed three consecutive times, and the full 30-test suite passed.
- **Permission risk**: `Low`; the correction is test-only and does not expand
  runtime or repository authority.
- **Evidence risk**: `High`; unconditional synthetic values can create false
  safety failures or false recovery evidence, depending on whether they differ
  from or accidentally match the host value.
- **Reproducible test**: Parameterize a temporary lease fixture with a process
  identity capability probe. When capability is present, assert no override is
  passed, an active matching lease remains active, and a deliberately forged
  identity remains ambiguous. When capability is absent, assert that only the
  creation path receives a deterministic synthetic value and that tests
  requiring a real identity report the unmet prerequisite instead of a false
  product failure.
- **Decision**: `Promote`.

### AR-005 — Dirty-worktree statistics need an exact temporary candidate index

- **Source and evidence**:
  `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md`
  (SHA-256
  `4b695079e8916eb1723e86a4bd344d0390afd55aefe49e815f52205453999fc1`),
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/exact-candidate-local.json`
  (SHA-256
  `4013de7bd8721c11b998a64c1124305c3eeb9a344072adbf33a67ac69f028c28`),
  and the `AC-CBG-008` `Primary` entry in
  `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/final-gate-evidence.json`.
- **Observation and boundary**: Generated statistics in the dirty
  `LocalImplementation` worktree had to be checked against the complete
  delivery candidate, including new untracked files, without staging the real
  index. T091 built a temporary candidate index and temporary object
  directory, ran `git add -A`, checked the cached diff, compared all 55
  candidate paths with the Stage A allowlist, reconciled status, and restored
  the original index hash exactly. AC-CBG-008 independently requires and
  reports passing statistics checks. This is a correctness, permission, and
  evidence-integrity rule, not a request to stage or commit the feature.
- **Artifact kind**: `checklist`.
- **Project-specific exclusions**: The 55 Feature 029 paths, Profile 2
  statistics renderer, Stage A label, T075/T091, current index and diff hashes,
  macOS, and AC-CBG-008 are occurrence details, not the portable rule.
- **Provider-neutral target rule**: When generated output depends on the exact
  contents of a dirty delivery candidate, validation MUST construct that
  candidate in an isolated temporary index and object directory. It MUST
  include intended tracked modifications, deletions, and untracked delivery
  files, run generated-output and whitespace checks against that candidate,
  and prove that the real index and worktree status are unchanged afterward.
- **Occurrence count and confidence**: `1`; `High`, because the evidence
  records every candidate-index command, 55 resolved paths, zero allowlist
  violations, identical original/restored index hashes, reconciled status, and
  no commit or push.
- **Permission risk**: `Medium`; staging the real index would mutate user state
  and could cross a no-commit delivery boundary even if no commit followed.
- **Evidence risk**: `High`; validating only tracked or already staged files
  can make generated statistics appear reproducible while silently excluding
  new delivery artifacts.
- **Reproducible test**: In a temporary repository, commit a statistics source
  and generated ledger, then modify a tracked source, delete another tracked
  input, and add an untracked delivery file that changes the expected totals.
  Validate through a separate `GIT_INDEX_FILE` and temporary object directory;
  assert the generated check sees all three changes, an omitted untracked file
  fails the expected totals, and the real index tree plus porcelain status are
  byte-identical before and after.
- **Decision**: `Promote`.

### AR-006 — Capability preflight might avoid one blocked worker attempt

- **Source and evidence**:
  `specs/029-ci-budget-governance/autonomous-run-state.json` at
  `implementationRecovery`, and the hash-bound hook installation evidence
  used by AR-003.
- **Observation and boundary**: A runner could potentially test whether a
  delegated sandbox can write the one required repository-metadata target
  before assigning that task, avoiding the T025 block-and-resume cycle. This is
  only a scheduling-efficiency preference. It does not change the promoted
  AR-003 requirement to stop, revalidate authority, scope coordinator action,
  and independently verify the result.
- **Artifact kind**: `command`.
- **Project-specific exclusions**: T025, hook installation, the current nested
  sandbox, the runner profile, and `.git/hooks/pre-push` are excluded from any
  future generic optimization.
- **Provider-neutral target rule**: After a second independent observation, a
  runner MAY use a read-only or synthetic capability preflight to choose an
  authorized execution boundary before starting a task. The preflight MUST NOT
  write the target, widen authority, suppress a later real denial, or replace
  post-mutation evidence.
- **Occurrence count and confidence**: `1`; `Medium`, because one deterministic
  denial proves the recovery rule but not that preflight is broadly cheaper or
  reliable across execution environments.
- **Permission risk**: `Medium`; an active write probe could itself mutate
  repository metadata or be misread as authority.
- **Evidence risk**: `Medium`; capability may change between preflight and
  execution, so preflight cannot establish completion or replace revalidation.
- **Reproducible test**: Use two synthetic worker profiles, one allowing and
  one denying repository-metadata writes, and a no-write capability adapter.
  Compare task attempts and elapsed orchestration steps with and without
  pre-routing while asserting identical final permission and evidence gates.
  Repeat in a second independent real field run before promotion.
- **Decision**: `ObserveAgain`.

## Promoted Rules

1. Separate working-tree mutation from commit creation and require current,
   explicit commit authority.
2. Separate narrative capture from atomic machine-result publication and
   validate only the dedicated result sink.
3. Recover denied metadata writes only through a narrowly authorized
   coordinator action followed by independent content and behavior validation.
4. Use synthetic capability values only when the real capability is proved
   unavailable.
5. Validate dirty-worktree generated output through an isolated exact
   candidate index that includes intended untracked files and preserves the
   real index and status.

These are provider-neutral promotion proposals. This retrospective is their
portable handoff; it is not authority to modify a shared preset, script,
another repository, branch, pull request, remote, or user environment.

## Observations Still Pending

- `AR-006` remains pending until a second independent field occurrence shows
  that a non-mutating capability preflight improves scheduling without
  weakening AR-003.
- No correctness, security, permission, or evidence-integrity observation is
  being withheld merely to collect an efficiency-style second occurrence.

## Rejected Project Details

- Exact Feature 029 paths, task and AC identifiers, hashes, commit IDs, fixture
  identities, macOS commands, runner/model settings, Lastenheft naming, hook
  layout, process-lease implementation, and statistics Profile 2 mechanics are
  excluded from the promoted rules.
- No project-specific behavior is rejected as defective beyond the five
  evidence-backed boundaries above. No observation authorizes retroactive
  changes to accepted feature artifacts.

## Changed Surfaces

- The causal closeout adds the tracked schema-2.0 PreMerge and PostMerge
  evidence, updates this retrospective and the autonomous run state, and
  refreshes the generated project-statistics ledger.
- Feature behavior, accepted implementation artifacts, scripts, tests, shared
  guidance, and target repositories are unchanged by the evidence-only
  closeout. Home Runtime changed only through the separately completed,
  manifest-bound Home sync of the merged Feature 029 implementation.
- Documentation impact decision: `GeneratedUpdate`; the canonical Git history
  changed through Feature 029 delivery and the repository statistics renderer
  refreshes `docs/project-statistics.md`. No additional user procedure,
  navigation, or accepted feature contract changes.

## Validation

- Accepted feature artifacts: `20/20` current hashes match the run-state audit.
- Autonomous state validator: `Pass`; run ID and branch match, stage is
  `Retrospective`, status is `Active`, and tasks are `93/93`.
- Implementation phase result: strict schema `1.0`, `Completed`, `93/93`,
  gates satisfied, task payload hash matched.
- Gate evidence validators: schema `2.0` PreMerge and PostMerge each returned
  `Pass` in Bash and PowerShell. The normalized hashes are
  `10af4b8e40a88452c3309ccb9a873d375672bb10eac7739ba4f8a96c03f34ba4`
  and `e795e07fa0ff8c55d9e63d1826230d2e7171bdc9af036e903c8f04d1cc766637`;
  the PostMerge snapshot authorizes the recorded merge fact.
- Remote validation: all `26/26` observed PR/push jobs passed before PR `#247`
  merged. The feature branch was deleted, synchronized `main` was clean and
  `0 0`, and the follow-up Home-sync check reported all managed files current.
- Retrospective checks: strict UTF-8 text, no trailing whitespace, all required
  observation fields and exactly one allowed decision per observation, and
  autonomous phase-result validation against the final normalized payload
  hash.

## Outcome

- Local non-empty correction: `None`; AR-004's test-only correction belongs to
  the already completed Feature 029 implementation, not this retrospective.
- Portable handoff: `specs/029-ci-budget-governance/retrospective.md`.
- Pending observations: `AR-006`.
- Rejected project details: Exact provider, platform, repository, path, hash,
  task, AC, fixture, and implementation mechanics listed above.
- Next field gate: Run provider-neutral synthetic tests for AR-001 through
  AR-005 when a separately authorized workflow change is proposed, and require
  a second independent field occurrence before deciding AR-006. No next
  feature, branch, or pull request is started here.
- Delivery boundary: Stage B fleet rollout and G4 were not started; any such
  execution requires a separate explicit instruction.
- Resume-state quality: `NeedsImprovement`; the state captured the pause,
  authority revalidation, Tasks retry, implementation recovery, and completion
  recovery well enough to resume safely, but AR-002 proves that narrative and
  machine-result publication still need structural separation.
