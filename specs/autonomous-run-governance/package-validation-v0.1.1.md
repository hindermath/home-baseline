# Autonomous Run Governance v0.1.1 Package Validation

## Candidate

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Spec Kit requirement | `>=0.8.3` |
| Priority | `70` |
| Change | Discover executable validator consumers before evidence-only test skips |
| Payload scripts | None |

## Local Results

| Check | Result | Evidence boundary |
|---|---|---|
| Canonical/publication parity | Pass | recursive directory diff has no difference |
| Manifest development install | Pass | v0.1.1 reported 12 contributions at priority 70 |
| Seven-preset composition | Pass | versions and priorities remained 0.6.0/10 through 0.1.1/70 |
| Template resolution | Pass | Constitution, Spec, Plan, and Tasks chains each include v0.1.1 |
| Generated commands | Pass | exactly one Codex autonomous skill and one retrospective skill |
| Patch rule propagation | Pass | generated autonomous skill contains the executable-validator dependency search |
| Disable and enable | Pass | registration state changed without widening authority |
| Remove and reinstall | Pass | both generated skills disappeared and returned exactly once |
| Permission boundary | Pass | `LocalImplementation` remains the default; no remote authority changed |
| Script boundary | Pass | the deterministic rule needs no new preset-owned executable |

## Release-dependent Results

| Check | State | Completion evidence |
|---|---|---|
| Home-Baseline package PR | Open | PR checks, reviews, merge, and synchronized main |
| Public repository patch | Open | publication copy pushed to the standalone repository |
| Tag and release | Open | `v0.1.1` |
| GitHub ZIP checksum/install | Open | versioned archive checksum and temporary-project install |
| Upstream issue update | Open | comment on `github/spec-kit#3479` after published ZIP proof |

Release-dependent facts remain open until provider state exists. The TuiVision
closeout remains blocked until the triggering validator fix and this package
follow-up both converge.
