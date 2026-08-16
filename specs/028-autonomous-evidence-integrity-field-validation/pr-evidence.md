# PR Evidence: Feature 028

## Scope and Authority

Independent G2B field validation, `autonomous-run-governance` v0.4.1 release,
dynamic consumer rollout, community update, workitem closure,
and G2 Series restoration. Delivery authority is `MergeAndSync`. The narrow
admin bypass may replace only Human Approval after technical gates are green
and actionable review threads are zero.

Position 7 and every later feature remain outside authority and will not start.

## Accepted Inputs

| Artifact | SHA-256 | Result |
|---|---|---|
| Binding G2B intake | `df5169721e184597001ae3e1f2860e87ca462d1ccfd8c9b75ffa46e52c45aff4` | Accepted |
| G2B intake review | `2a2d3f98799082be48af74632bf37273506b05b98b3b1e32d1f54b1c47e91f37` | `Ready` |
| Feature-038 workitem | `18cc6a131269f590b2a5bb0f8ccc78e25bfbc7283781cb812d70af6cf3a8d996` | `Promote` x3 |
| G2A completed state | `ea5fa44c4b66df49f107b3bfce5e1cd219408542e5385667d840eac8564c28c4` | `Retrospective`, `Completed`, `65/65` |
| G2A closeout evidence | `c9cc0ad8d8768aa27c83200cc433a67fe14ac613ad676cf42e6bddaa0264b6a5` | PR #241 and lifecycle chain bound |

## Execution Ledger

| Phase | Evidence | Result | Boundary |
|---|---|---|---|
| Preflight | main, Series, G2B review, model routing | Pass | No implementation mutation |
| Specify through Analyze | feature artifacts and checklists | Pass | No material ambiguity or High finding |
| Candidate static validation | Bash syntax, PSScriptAnalyzer 1.25.0, Homogeneity, secret and script-reference checks | Pass | Homogeneity 100%; no High secret finding |
| Candidate regressions | `python3 -m unittest discover -s scripts/tests -p 'test_*.py'` | Pass | 124 tests; 12 planned skips |
| Twelve-preset composition | fresh temporary Spec Kit project | Pass | Add, list, info, resolve, disable, enable, remove and reinstall; five autonomous skills exactly once |

## Field Results

`field-evidence/field-validation-evidence.json` records all three independent
field proofs:

- AR-038-01: ordinary `git diff --check` returned `0`; Bash and PowerShell both
  rejected the intended untracked file with `AEI007` and exit `2`, then passed
  the corrected identical delivery set with exit `0`. Both validations were
  read-only; ignored evidence was excluded and the unrelated path reported.
- AR-038-02: process exit `0` plus `Blocked` and `3/4` tasks returned semantic
  exit `3` in both shells and never became `Completed`. Exactly one explicit
  Resume revalidated authority, phase, tasks, hashes, and Git, accepted a
  trustworthy complete result, performed no manual repair, and did not repeat
  completed work.
- AR-038-03: exact field head `396036e57bf0fbac09df3288b2b051b630ac7bdd`
  produced PreMerge hash
  `d55a5678336de3162dd05fa4ba6809ab0b68837246ba52dc068752a97bc23798`.
  Actual merge `1c8ec9fd66cdbe87ccbc9ede6014490bc601a8ce` produced
  PostMerge hash
  `f016a011156f51543e342fc92cd030f3ffeaaef427f51fccfb4918f52f028a92`.
  Both shells passed; premature merge evidence failed and the causal snapshot
  added zero changed paths.

## Release and Fleet Results

The independent field evidence and candidate regression gates supported the
explicit v0.4.0 release decision. A release-documentation defect was found
before consumer mutation, so v0.4.0 remains an immutable historical tag and
the corrected v0.4.1 patch is the sole rollout version.

The registered public checkout was clean and synchronized at v0.3.6 before a
non-empty `codex/autonomous-run-governance-v0.4.0` branch received the
byte-identical publication candidate. Bash and PowerShell package tests,
PSScriptAnalyzer, metadata and inventory checks, diff checks, and the secret
scan pass. Python cache output was excluded from the package.

Public preset PR #16 was merged as `074935006fb717c6ae769617712cad5c5aa3f78c`.
The exact PR head had all local technical gates green and zero actionable
review threads. GitHub exposed no repository workflow checks; Human Approval
was the sole remaining rule, so the authorized narrow admin bypass was used.
The public checkout is clean and `(0 0)` on `main`.

The first v0.4.0 ZIP was technically valid with SHA-256
`f13da808a884555ac21a9d0b640749c8fadf96fd2dfd5dfffff43f927a8b690a`,
but its release documentation still described 0.4.0 as unpublished and linked
to v0.3.6. Fleet rollout stopped before any consumer mutation. The immutable
v0.4.0 tag remains historical; a documentation-corrected v0.4.1 patch is the
only rollout candidate.

Corrective public preset PR #17 merged as
`27b309147f32844b76f7255f573544a5c46e1242`. Release `v0.4.1` is published;
its GitHub ZIP SHA-256 is
`3b12b0415ff5da5187620f4f420689c7cb2d6421527dc0d56fcae6a600519f6e`.
Archive integrity, fresh URL installation, all twelve presets, resolution, and
exactly five autonomous skills pass. This v0.4.1 ZIP is the sole consumer
rollout source.

The dynamic inventory contained 47 active Git targets plus one collection
target. Profile resolution selected exactly 36 consumers: Home Baseline and 35
registered Level-1/2 repositories. All 35 external consumers received non-empty
preset-only PRs and were merged. Thirty-four primary checkouts are clean and
`(0 0)`; the pre-existing dirty `absdd-image-sandbox` checkout was preserved
unchanged while its rollout was delivered from an isolated worktree. The
complete no-omission table and permission classification are recorded in
`fleet-rollout-evidence.md`.

GitHub provider jobs that ran completed normally, except for a real `tvision`
OpenCode parity failure. That defect and its generated statistics drift were
corrected before all technical checks passed. Other non-green provider jobs
executed zero steps and reported GitHub's payment or spending-limit rejection.
The narrow admin bypass was used only after local exact-head gates passed and
actionable review-thread count was zero.

The official serial community update is
[github/spec-kit#4153](https://github.com/github/spec-kit/issues/4153). It uses
the current submission template, mentions `@mnriem` once, identifies 15
templates, five commands and 11 scripts, and records all three field findings,
the v0.4.1 tag, ZIP checksum and compatibility boundary. External catalog
processing remains non-blocking for local Feature 028 completion.

Home Baseline Feature PR
[#243](https://github.com/hindermath/home-baseline/pull/243) contains the
validated non-empty package, adoption, feature evidence, workitem closeout and
generated documentation. Exact reviewed head
`525fbf90a0810a1cd46abc9c4e48fb757c68318c` passed all technical checks and
had zero actionable review threads. Human Approval was the sole remaining
rule, so the authorized narrow bypass merged it as
`4c8185aae6988957c94ddc4de104ea1eb4472ca1`.

## Causal Closeout

- Schema-2.0 PreMerge evidence passed in Bash and PowerShell with normalized
  SHA-256 `f21976dc041ce878657fc7045c225cad011f1504725fd34bf926effc0d5b6825`.
- Causal PostMerge evidence binds that snapshot to merge commit
  `4c8185aae6988957c94ddc4de104ea1eb4472ca1`, reports zero changed paths and
  passed both validators with normalized SHA-256
  `29bfce2d19965c78e2e161b4203d73ad2427f6541e1ed032f07979c01f0d44d0`.
- The G2A and G2B lifecycle state was archived. The active Series is restored
  to 32 targets, three roots and 36 dependencies; item 7 is the sole declared
  `Eligible` candidate and was not started.
- The restored manifest, receipt and renewed schema-1.1 Series review passed
  in Bash and PowerShell with zero findings.
- Non-empty causal closeout PR
  [#244](https://github.com/hindermath/home-baseline/pull/244) carries only
  post-merge evidence, Series restoration, archived intake names and generated
  statistics. It grants no successor authority.
- Its exact causal head passed every Ubuntu, macOS and Windows technical gate
  with zero actionable review threads. The terminal state becomes true when
  that same reviewed head is merged and the primary checkout is synchronized;
  no recursive closeout PR is created.

## Documentation Impact

`UpdateRequired` plus `GeneratedUpdate`; see `spec.md`.
