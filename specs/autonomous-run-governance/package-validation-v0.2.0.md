# Autonomous Run Governance v0.2.0 Package Validation

## Package

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Required Spec Kit | `>=0.8.3` |
| Priority | `70` |
| Change | Validated lifecycle state plus explicit status, graceful-stop, and protected-resume commands |
| Contributions | 18: 13 templates and 5 commands |
| Scripts | Four: equivalent Bash and PowerShell gate-evidence and run-state validators |

## Field Finding

Feature 028 reached a clean committed Tasks checkpoint and entered read-only
Analyze before the user explicitly paused further work. Version 0.1.4 could
describe the intended resume action, but it had no durable status contract and
could not distinguish a deliberate pause from an unexpected interruption. The
v0.2.0 contract fails closed for `PausedByUser`, requires explicit resume, and
marks uncertain operations `NeedsRevalidation`.

## Local Results

| Check | Result | Evidence boundary |
|---|---|---|
| Canonical/publication parity | Pass | Recursive payload diff is empty |
| Manifest development install | Pass | v0.2.0 resolves at priority 70 with 18 contributions |
| Seven-preset composition | Pass | Standard six versions/priorities unchanged; autonomous preset resolves at 70 |
| State Bash syntax and fixtures | Pass | Active, StopRequested, PausedByUser, Interrupted, Blocked, and Completed pass; interrupted-completed contradiction fails |
| State PowerShell syntax and fixtures | Pass | Equivalent positive and negative results, including PowerShell JSON timestamp materialization |
| Gate-evidence regression | Pass | Existing one-gate `N/A` fixture passes in Bash and PowerShell |
| Generated agent commands | Pass | Exactly one of five autonomous commands for Codex, Claude, Copilot skill mode, and Antigravity |
| Remove, reinstall, disable, enable | Pass | Generated autonomous skills move between five and zero without duplicates |
| Authority boundary | Pass | Command and validator review confirms stop/status/resume grant no commit, push, PR, merge, process-kill, or provider rights |
| Feature 028 reconstruction | Pass | Read-only Git/artifact review reconstructs `PausedByUser`, Analyze, checkpoint lineage `5550fbf`, clean tree, and no implementation |
| Workspace homogeneity | Pass | Read-only dry-run reports 28/28 checks and 100 percent |
| Secret scan | Pass | Gitleaks reports zero high findings; known local agent configuration remains outside the candidate |

## Release-dependent Results

| Check | State | Completion evidence |
|---|---|---|
| Home-Baseline package PR | Open | PR and merge |
| Public repository update | Open | PR and merge |
| Tag and release | Open | Public `v0.2.0` release |
| GitHub ZIP checksum/install | Open | Exact tag archive and temporary install |
| TuiVision adoption | Open | Separate adoption PR; Feature 028 remains paused |
| Feature 028 real resume | Deferred | Requires separate explicit user release |
| Community catalog update | Deferred | New structured update issue after real 028 field validation |
