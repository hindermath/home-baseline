# Parallel Autonomous Run Governance v0.2.2 Package Validation

## Release Identity

| Field | Value |
|---|---|
| Preset | `parallel-autonomous-run-governance` |
| Version and priority | `v0.2.2`, priority `80` |
| Required worker preset | `autonomous-run-governance >=0.2.2`, enabled at priority `70` |
| Public PR | [hindermath/spec-kit-preset-parallel-autonomous-run-governance#5](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/5) |
| Public merge commit | `65a7b71932e308f122ea9bb5f2c60db1bd631aa4` |
| Release | [v0.2.2](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.2) |
| Tag and `main` commit | `65a7b71932e308f122ea9bb5f2c60db1bd631aa4` |
| GitHub source archive | `https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/archive/refs/tags/v0.2.2.zip` |
| ZIP size | `99447` bytes |
| ZIP SHA-256 | `cd0767e2cecd96b7d36d79b82e25970c31854da1996b06e89c3a7be3147f36a1` |
| Validation platform | macOS |
| Spec Kit CLI | `specify 0.12.11` |

## Patch Contract

Version `0.2.2` is a documentation patch over `v0.2.1`. It adds a compact
bilingual README, a detailed CEFR-B2 campaign manual, nine Mermaid diagrams,
and an index for unchanged historical field evidence. The release documents
and tests the existing production dependency on Preset 7 without inventing an
unsupported manifest dependency field. Coordinator, campaign schema,
consolidation, and authority behavior are unchanged.

## Dependency Contract

- Every real worker repository requires installed and enabled
  `autonomous-run-governance >=0.2.2`.
- Priority `70` supplies worker lifecycle, evidence, and authority rules before
  priority `80` supplies campaign coordination.
- Missing, disabled, and outdated Preset 7 configurations fail preflight before
  worker start.
- `requireAutonomousPreset: false` is valid only in isolated internal fixtures,
  never as a production mode.

## Validation

| Check | Result |
|---|---|
| Canonical scaffold and publication copy | Recursive comparison passed |
| Public PR head and merge | Exact candidate head `bcbcc940fce172ee1ae9796b379b7d4da17cfa97` merged as the recorded commit |
| GitHub tag and `main` | Both resolve to the recorded merge commit |
| ZIP integrity | `unzip -t` passed |
| Extracted ZIP parity | No difference from the publication copy |
| Mermaid syntax | Nine of nine diagrams rendered with Mermaid CLI `11.12.0` |
| GitHub rendering | Overview diagram rendered at desktop width in light and emulated dark theme without horizontal overflow |
| Accessibility | Every diagram is followed by a complete DE/EN text alternative |
| Dependency fixtures | Missing, disabled, `0.2.1`, minimum `0.2.2`, and current `0.3.1` cases passed |
| Existing coordinator tests | Coordinator and schema-1.1 consolidation fixtures passed |
| Markdown and links | Pandoc reading order and offline Lychee validation passed |
| PowerShell analysis | Dependency test passed PSScriptAnalyzer |
| Isolated eight-preset stack | Eight enabled presets with priorities `10` through `80`; Preset 8 reported version `0.2.2` and 14 contributions |
| Template resolution | `parallel-autonomous-agent-guidance-addendum-template` resolved from `v0.2.2` |
| Idempotent installer | A second complete installer run was unchanged; aggregate installed-file hash stayed `ea6fffeb4b2dfa98bc0fa0fb576ad076778859329a5082421314e1be52261ac9` |
| Remove and reinstall | Preset 8 removed cleanly, reinstalled after Preset 7 at priority `80`, and its installed directory matched the tagged archive |

The repositories require one human code-owner approval. GitHub Copilot review
was configured but had not produced a review or thread. After all local,
rendering, exact-head, dependency, and archive checks passed with no review
thread, the public PR was merged with the established owner admin bypass. The
bypass is recorded as delivery authority, not as technical evidence.

## Boundaries

- No coordinator, state-schema, provider, merge, or post-merge behavior changed.
- The fixture-only opt-out is not a production campaign mode.
- No agent vendor, model, reasoning level, or secret is prescribed.
- Starting a campaign remains expressly delegable work.
