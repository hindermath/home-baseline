# Intake Authoring Preset v0.2.0 Fleet Rollout Evidence

## Status

`Completed`

## Release Baseline

| Field | Value |
|---|---|
| Level-0 implementation | [PR #107](https://github.com/hindermath/home-baseline/pull/107), merge `acb187c5d857887cc88a65b022dd946927a0e87e` |
| Preset | `intake-authoring-governance` v0.2.0 |
| Public preset PR | [PR #2](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/2), merge `4429fa2` |
| Public release | [v0.2.0](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.2.0) |
| Versioned ZIP SHA-256 | `d4b4e5f614e3b2e2c92d6278f0802a48dc371f69fb2c25eb1392c3eb1fb52dc3` |
| Versioned ZIP size | `61216` bytes |
| Priority | `64` |
| Managed profile | `intake-authoring-ten-governance-presets` |
| Repositories | 33/33 |
| Learning-series repositories | 21/21 across 3/3 families |

## Capability Baseline

Version 0.2.0 provides explicit Create, Read, Update, Delete, and Create Status
commands. It keeps receipt schemas 1.0 and 1.1 readable while adding schema 2.0
with stable intake identity, operation history, URL provenance, archive paths,
series bindings, and tombstones.

Public URL ingestion is restricted to explicit HTTPS sources. Redirects,
content type, size, UTF-8 decoding, normalized SHA-256 provenance, and secret or
personal-data boundaries remain reviewable. Multi-intake output is permitted
only when an explicit series contract proves that splitting one source set is
more accurate than silently truncating or forcing unrelated requirements into
one intake.

No command automatically starts Intake Review, Specify, Autonomous, or Parallel
Autonomous. The required next action after a ready Create or Update remains
`$speckit-intake-review`.

## Repository Results

Level 0 was delivered through PR #107. The following table records the 32
Level-1 and Level-2 rollout repositories.

| Repository | PR | Exact head | Merge | Result |
|---|---:|---|---|---|
| `c64-baseline` | [#14](https://github.com/hindermath/c64-baseline/pull/14) | `463fff8ebab6` | `0dddca9bca9e` | Merged |
| `cc65` | [#14](https://github.com/hindermath/cc65/pull/14) | `c9e04a596bab` | `5b7274b1d91b` | Merged |
| `datagrip-baseline` | [#15](https://github.com/hindermath/datagrip-baseline/pull/15) | `6e2a972f7191` | `dddea07e1dc3` | Merged |
| `InventarDb` | [#14](https://github.com/hindermath/InventarDb/pull/14) | `ffb8957f66ee` | `3b590e6cffe2` | Merged |
| `rider-baseline` | [#14](https://github.com/hindermath/rider-baseline/pull/14) | `50605350b47a` | `82b6f03fd705` | Merged |
| `InventarWorkerService` | [#38](https://github.com/hindermath/InventarWorkerService/pull/38) | `e002385954b3` | `3eb2eb6b6247` | Merged |
| `TinyCalc` | [#32](https://github.com/hindermath/TinyCalc/pull/32) | `7dfab593dc36` | `e4844698dd98` | Merged |
| `TinyPl0` | [#44](https://github.com/hindermath/TinyPl0/pull/44) | `828cf3f587d4` | `2039f19f8a3f` | Merged |
| `TuiVision` | [#118](https://github.com/hindermath/TuiVision/pull/118) | `663db9ee1036` | `f2050150787d` | Merged |
| `secure-orderdesk-baseline` | [#12](https://github.com/hindermath/secure-orderdesk-baseline/pull/12) | `ec536b367765` | `1bdb60f2cf5f` | Merged |
| `secureorderdesk-csharp` | [#13](https://github.com/hindermath/secureorderdesk-csharp/pull/13) | `5160af031f25` | `36f40c996ac6` | Merged |
| `secureorderdesk-go` | [#12](https://github.com/hindermath/secureorderdesk-go/pull/12) | `c9b749118830` | `07ad5200746e` | Merged |
| `secureorderdesk-java` | [#12](https://github.com/hindermath/secureorderdesk-java/pull/12) | `6188c39900de` | `547be6244698` | Merged |
| `secureorderdesk-python` | [#12](https://github.com/hindermath/secureorderdesk-python/pull/12) | `662672fd25a2` | `e9b166ae8967` | Merged |
| `secureorderdesk-rust` | [#12](https://github.com/hindermath/secureorderdesk-rust/pull/12) | `e6049d5c1f8e` | `287c0ae7357b` | Merged |
| `secureorderdesk-swift` | [#12](https://github.com/hindermath/secureorderdesk-swift/pull/12) | `c77f215cf495` | `81a97dc75f6d` | Merged |
| `secure-serviceharvester` | [#12](https://github.com/hindermath/secure-serviceharvester/pull/12) | `0fe9f6993093` | `5627700976d9` | Merged |
| `secureserviceharvester-csharp` | [#13](https://github.com/hindermath/secureserviceharvester-csharp/pull/13) | `cda3f5ef7741` | `6376d809e72e` | Merged |
| `secureserviceharvester-go` | [#12](https://github.com/hindermath/secureserviceharvester-go/pull/12) | `0caf0b4824c8` | `842f9b9d3c02` | Merged |
| `secureserviceharvester-java` | [#12](https://github.com/hindermath/secureserviceharvester-java/pull/12) | `2cf66f283b1a` | `7446f4dc24b1` | Merged |
| `secureserviceharvester-python` | [#12](https://github.com/hindermath/secureserviceharvester-python/pull/12) | `25a566e2c8f2` | `17eb16e2c351` | Merged |
| `secureserviceharvester-rust` | [#12](https://github.com/hindermath/secureserviceharvester-rust/pull/12) | `555f2d2f8129` | `374bff70a6de` | Merged |
| `secureserviceharvester-swift` | [#12](https://github.com/hindermath/secureserviceharvester-swift/pull/12) | `51393cd8aed7` | `8fb9e7a4b7dc` | Merged |
| `container-images` | [#12](https://github.com/hindermath/container-images/pull/12) | `1934cd90cee2` | `e9468d286ae4` | Merged |
| `absdd-image-sandbox` | [#20](https://github.com/hindermath/absdd-image-sandbox/pull/20) | `f47bac951c1c` | `a88275dd34f2` | Merged |
| `secure-casetracker-baseline` | [#12](https://github.com/hindermath/secure-casetracker-baseline/pull/12) | `77ccc9c37388` | `a05a67cb2261` | Merged |
| `securecasetracker-csharp` | [#18](https://github.com/hindermath/securecasetracker-csharp/pull/18) | `93d456267d4b` | `dfa646b4c3ec` | Merged |
| `securecasetracker-go` | [#17](https://github.com/hindermath/securecasetracker-go/pull/17) | `4954df9a7690` | `e1e94a469d26` | Merged |
| `securecasetracker-java` | [#17](https://github.com/hindermath/securecasetracker-java/pull/17) | `08db97f741e0` | `b5ae501fda20` | Merged |
| `securecasetracker-python` | [#18](https://github.com/hindermath/securecasetracker-python/pull/18) | `398625f79f2c` | `84dfbbb2f0af` | Merged |
| `securecasetracker-rust` | [#17](https://github.com/hindermath/securecasetracker-rust/pull/17) | `5c344888ddaa` | `4037ac5bd82d` | Merged |
| `securecasetracker-swift` | [#17](https://github.com/hindermath/securecasetracker-swift/pull/17) | `8dabc891efaa` | `d6e795d8f4d8` | Merged |

## Validation

| Check | Result |
|---|---|
| Bootstrap Authoring and Review | `Ready`, zero open material decisions |
| Release ZIP | Exact v0.2.0 archive, size, and SHA-256 verified |
| Temporary ten-preset composition | Add, List, Info, Resolve, Disable, Enable, Remove, and Reinstall `PASS` |
| Exact fleet matrix | 33/33 repositories with 10/10 presets |
| Package validators | Receipt and lifecycle Bash/PowerShell parity suites `PASS` in 33/33 repositories |
| Generated agent surfaces | Exactly one Create, Read, Update, Delete, and Create Status command per configured surface |
| Remote default-branch verification | Intake Authoring v0.2.0 at priority 64 in 33/33 repositories |
| Statistics | Reproducible project-statistics render completed where configured |
| Secret and whitespace checks | No high secret finding and no remaining whitespace error in any rollout diff |
| Review threads | Zero actionable or unresolved threads across all 32 fleet PRs |
| Executed remote gates | 119 successful checks; cc65 Linux and Windows product builds passed |
| Provider evidence | 119 failed workflow runs containing 229 jobs had zero executed steps |
| Provider classification | 229/229 annotations reported GitHub Billing or Spending unavailability |
| Fleet delivery | 33/33 repositories merged, including Level 0 |
| Learner boundary | 21/21 learning repositories updated; no learner Spec-Kit command was started |

The initial three-way installation wave exposed download timeouts and two
rollout-harness assumptions about OpenCode directory naming and generated EOF
normalization. Failed attempts stopped before commit, push, or PR creation.
They were repeated serially with bounded download retries, support for both
`.opencode/command` and `.opencode/commands`, and deterministic normalization
of the two reported generated skill files. Product, intake, and learner content
remained unchanged.

The 229 provider failures were not counted as technical passes. Every affected
job was bound to the reviewed PR head, had zero steps, and carried the GitHub
Billing or Spending annotation. The owner-authorized narrow admin bypass was
used only after local package validation, exact matrix and command-parity
checks, zero actionable review threads, and either successful remote execution
or this explicit provider-unavailability evidence.

The original DataGrip and cc65 worktrees were not used for rollout changes.
Fresh temporary clones preserved their existing local branches and files.

## Community Handoff

The accepted v0.1.1 submission
[github/spec-kit#3676](https://github.com/github/spec-kit/issues/3676) and
catalog PR [#3678](https://github.com/github/spec-kit/pull/3678) remain the
history for this preset.

The v0.2.0 update was accepted through
[github/spec-kit#3720](https://github.com/github/spec-kit/issues/3720) and
generated catalog PR [#3721](https://github.com/github/spec-kit/pull/3721).
The issue is closed with `preset-submission` and `validation-passed`. PR #3721
was approved by `mnriem` and merged as
`b0850c97e648dfd6b6ef253e91b503a030a17532` after 14 successful checks and
one planned skipped matrix job. No correction request or unresolved review
thread remained. The final maintainer response was `Thank you!`.
