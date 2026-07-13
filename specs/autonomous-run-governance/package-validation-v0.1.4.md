# Autonomous Run Governance v0.1.4 Package Validation

## Package

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Spec Kit | `0.12.11`; preset requires `>=0.8.3` |
| Priority | `70` |
| Change | Installer-stable explicit Bash and PowerShell invocation |
| Contributions | 14: 10 templates, 2 JSON templates, and 2 commands |
| Validator behavior | Unchanged from v0.1.3 |

## Field Finding

The v0.1.3 source tracks the Bash validator with mode `100755`, but installation
from the versioned GitHub ZIP into TuiVision produced a non-executable copied
file. Direct path invocation failed with `permission denied`; explicit
`bash <validator.sh>` and `pwsh -NoProfile -File <validator.ps1>` invocations
both passed the same two-gate fixture. Executable mode is therefore not treated
as a portable installed contract.

## Local Results

| Check | Result | Evidence boundary |
|---|---|---|
| Canonical/publication parity | Pass | Recursive payload diff is empty |
| Manifest development install | Pass | v0.1.4 reports 14 contributions at priority 70 |
| Seven-preset composition | Pass | Baseline presets and priorities remain unchanged; v0.1.4 resolves at 70 |
| Local release-shaped ZIP | Pass | Loopback install reports v0.1.4/70 and copies the Bash script as non-executable `0644` |
| Bash syntax | Pass | `bash -n` accepts the validator |
| PowerShell syntax | Pass | PowerShell 7 parser accepts the validator |
| Installed-mode reproduction | Pass | TuiVision v0.1.3 tag-ZIP install copied the script without executable mode |
| Direct-path negative | Pass | Expected `permission denied` proves the non-portable assumption |
| Explicit Bash invocation | Pass | Two requirements, two Primary rows, exact reviewed head |
| Explicit PowerShell invocation | Pass | Equivalent result for the same fixture |
| Guidance propagation | Pass | README, command, agent addendum, runbook, tasks, help, and man page require explicit interpreters |
| Authority boundary | Pass | Interpreter choice changes no commit, push, PR, merge, bypass, or provider authority |

## Release-dependent Results

| Check | State | Completion evidence |
|---|---|---|
| Home-Baseline package PR | Open | PR checks, reviews, merge, and synchronized main |
| Public repository patch | Open | Publication copy pushed and reviewed in the standalone repository |
| Tag and release | Open | `v0.1.4` |
| GitHub ZIP checksum/install | Open | Versioned archive checksum and temporary-project installation |
| TuiVision adoption | Open | Exact tag-ZIP install, unique skills, seven-preset parity, documentation gates |
| Upstream issue update | Open | Concise evidence comment on `github/spec-kit#3499` |

Feature 028 remains blocked until the v0.1.4 public ZIP and TuiVision adoption
are complete. An external catalog update is not a local completion dependency.
