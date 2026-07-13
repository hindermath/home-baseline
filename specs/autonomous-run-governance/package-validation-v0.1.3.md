# Autonomous Run Governance v0.1.3 Package Validation

## Candidate

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Spec Kit | `0.12.11`; preset requires `>=0.8.3` |
| Priority | `70` |
| Change | Machine-checkable exact-head acceptance-gate requirements and execution evidence |
| Contributions | 14: 10 templates, 2 JSON templates, and 2 commands |
| Payload scripts | Read-only Bash and PowerShell gate-evidence validators |

## Local Results

| Check | Result | Evidence boundary |
|---|---|---|
| Bash syntax | Pass | `bash -n` accepted the validator |
| PowerShell syntax | Pass | PowerShell 7 parser accepted the validator |
| PowerShell Cmdlet surface | Pass | Dot-sourcing exposes `Test-AutonomousGateEvidence` as an Advanced Function with valid Verb-Noun naming |
| Positive parity | Pass | Both variants accepted two gates with one Applicable runtime proof and one governed `N/A` |
| Tooling-only negative | Pass | Both variants rejected a platform-named row whose command lacked the required `dotnet` and `test` tokens |
| Stale-head negative | Pass | Both variants rejected evidence for a different 40-character reviewed head |
| N/A negative | Pass | Both variants rejected an `N/A` requirement without a re-evaluation trigger |
| Primary uniqueness | Pass | Both variants rejected duplicate Primary rows for one gate |
| Empty starter | Pass | Both variants rejected an empty evidence array |
| Supplemental relation | Pass | Both variants accepted one explicitly linked Supplemental row |
| Manifest development install | Pass | v0.1.3 reported 14 contributions at priority 70 |
| Installed payload | Pass | Both validators, both JSON templates, and the man page were installed with the preset |
| Seven-preset composition | Pass | Baseline versions and priorities remained 0.6.0/10 through 0.3.0/60; v0.1.3 resolved at 70 |
| Template resolution | Pass | Both new JSON templates resolved uniquely to v0.1.3 |
| Disable and enable | Pass | Resolution state changed without widening authority |
| Remove and reinstall | Pass | Installed payload and generated autonomous skills were removed and restored |
| Local release-shaped ZIP | Pass | Outer-directory ZIP installed over loopback HTTP, reported v0.1.3/70, preserved both validators, and generated both Codex skills |
| Codex generation | Pass | Exactly one autonomous skill and one retrospective skill |
| Claude generation | Pass | Exactly one autonomous skill and one retrospective skill |
| Antigravity generation | Pass | Exactly one autonomous skill and one retrospective skill |
| Copilot generation | Pass | Exactly one skill-mode autonomous skill and one retrospective skill |
| OpenCode generation | Pass | Exactly one autonomous command and one retrospective command |
| Synthetic LocalImplementation through Analyze | Pass | 3/3 buildable requirements mapped, Critical/High/Medium 0, prerequisites passed, and no remote was configured |
| Permission boundary | Pass | `LocalImplementation` remains default; validator success grants no remote authority |
| Self-reference boundary | Pass | Exact-head evidence stays temporary before merge; durable post-delivery facts use causal closeout |

The validator checks a provider-neutral evidence contract. It does not query a
provider or prove that a human or agent copied truthful data. Workflow
definitions or immutable job logs remain the source for `executedCommand`,
`runnerOrPlatform`, and `EvidenceReference`; a reviewer can inspect those
references independently.

## Release-dependent Results

| Check | State | Completion evidence |
|---|---|---|
| Home-Baseline package PR | Open | PR checks, reviews, merge, and synchronized main |
| Public repository patch | Open | publication copy pushed to the standalone repository |
| Tag and release | Open | `v0.1.3` |
| GitHub ZIP checksum/install | Open | versioned archive checksum and temporary-project install |
| TuiVision adoption | Open | tag-ZIP install, no duplicate skills, seven-preset parity |
| Upstream issue update | Open | concise evidence comment on `github/spec-kit#3499` |

Release-dependent facts remain open until the corresponding provider or
consumer state exists. Feature 028 starts only after the tag-ZIP and TuiVision
adoption gates pass.
