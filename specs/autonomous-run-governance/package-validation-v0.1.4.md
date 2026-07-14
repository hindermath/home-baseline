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
| Home-Baseline package PR | Pass | PR `hindermath/home-baseline#63`; implementation `ed61e65`; merge `9322fad9ba689d516da2c1391f12db7ef1818652`; all technical checks passed and local `main` was synchronized |
| Public repository patch | Pass | PR `hindermath/spec-kit-preset-autonomous-run-governance#4`; implementation `72bcdf4`; merge `0ab22e3262ea0e44faf87408ae3a9c7366277e8b` |
| Tag and release | Pass | Public release `v0.1.4`: <https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.1.4> |
| GitHub ZIP checksum/install | Pass | Exact tag ZIP installed in a temporary project; SHA-256 `da667e2fd3fc5ccf0a29f7fd078d9f030f50ba267f659fc5b31bc000b59767e0`; explicit Bash and PowerShell fixture paths passed |
| TuiVision adoption | Pass | PR `hindermath/TuiVision#76`; merge `9cc6f463916643d82c27392d32c96361e49366a8`; exact tag-ZIP payload, unique skills, seven-preset parity, exact-head validator proof, DocFX, A11Y, and text checks passed |
| Upstream issue update | Pass | Patch-release evidence recorded in `github/spec-kit#3499`: <https://github.com/github/spec-kit/issues/3499#issuecomment-4964168467> |

All local v0.1.4 release and adoption gates are complete. Feature 028 may start
with the published preset; this closeout does not start that autonomous run.
The merged Community Catalog contribution `github/spec-kit#3501` is additional
upstream evidence and was not required for local completion.
