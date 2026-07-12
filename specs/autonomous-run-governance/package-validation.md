# Autonomous Run Governance v0.1.0 Package Validation

## Candidate

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Spec Kit requirement | `>=0.8.3` |
| Priority | `70` |
| Commands | `speckit.autonomous`, `speckit.autonomous-retrospective` |
| Payload scripts | None; current rules need no preset-owned executable |

## Local Package Results

| Check | Result | Evidence boundary |
|---|---|---|
| Manifest development install | Pass | `specify preset add --dev ... --priority 70` reported v0.1.0 and 12 contributions |
| Seven-preset list/info | Pass | Existing six versions/priorities remained 10-60; optional preset resolved at 70 |
| Template composition | Pass | Constitution, Spec, Plan, and Tasks chains contained core, autonomous, and all six governance layers |
| Standalone agent addendum | Pass | `autonomous-run-agent-guidance-addendum-template` resolved without a missing-base warning |
| Remove and reinstall | Pass | Generated autonomous skills disappeared on remove and returned once after reinstall |
| Disable and enable | Pass | Resolution state changed while registered commands remained available as documented by Spec Kit |
| Codex skills | Pass | exactly one `speckit-autonomous` and one retrospective skill |
| Claude skills | Pass | exactly one `speckit-autonomous` and one retrospective skill |
| Copilot skills | Pass | exactly one of each under `.github/skills/` with `--integration-options="--skills"` |
| Gemini commands | Pass | exactly one TOML command per autonomous command |
| Synthetic LocalImplementation through Analyze | Pass | 3/3 requirements and 1/1 success criterion mapped; Critical/High/Medium 0; no git remote; working state unchanged by read-only analysis |
| Unauthorized remote actions | Pass | generated command defaults to `LocalImplementation` and explicitly refuses inferred PR, merge, bypass, cancellation, secret, and provider-admin authority |
| Resume contract | Pass | command requires repository, feature, governance, authority, task, evidence, and last-gate recheck before continuation |
| No-empty-PR contract | Pass | command and readiness checklist reject empty feature, retrospective, and closeout PRs |
| Canonical/publication parity | Pass | recursive diff has no difference |
| Local release-shaped ZIP | Pass | outer-directory ZIP installed over loopback HTTP, reported v0.1.0/priority 70, and generated both Codex skills |

## Release-dependent Checks

| Check | State | Completion evidence |
|---|---|---|
| Home-Baseline package PR | Open | PR URL, required checks, reviews, merge, and local-main sync |
| Public repository | Open | `hindermath/spec-kit-preset-autonomous-run-governance` |
| Tag and release | Open | `v0.1.0` |
| GitHub ZIP checksum/install | Open | SHA-256 plus temporary-project install |
| TuiVision dogfooding | Open | tag-ZIP install at priority 70, no duplicate skills, six-preset parity |
| Upstream issue | Open | new `github/spec-kit` issue after ZIP smoke |

Release-dependent facts are intentionally not written as passes before they
exist. They will be verified from the provider and summarized in release notes,
the upstream issue, and TuiVision adoption evidence without creating a recursive
package-evidence loop.
