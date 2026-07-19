# Autonomous Run Governance v0.3.1 Package Validation

## Release Identity

| Field | Value |
|---|---|
| Preset | `autonomous-run-governance` |
| Version and priority | `v0.3.1`, priority `70` |
| Public PR | [hindermath/spec-kit-preset-autonomous-run-governance#10](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/10) |
| Public merge commit | `c30accf377512d130010b3ae42f58df066f5ea45` |
| Release | [v0.3.1](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.3.1) |
| Tag and `main` commit | `c30accf377512d130010b3ae42f58df066f5ea45` |
| GitHub source archive | `https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/archive/refs/tags/v0.3.1.zip` |
| ZIP size | `66144` bytes |
| ZIP SHA-256 | `2d939a0942fc3b1dadb7c1824e491bdb2c410802e79a70308b44192473055dc7` |
| Validation platform | macOS |
| Spec Kit CLI | `specify 0.12.11` |

## Patch Contract

Version `0.3.1` is a documentation patch over `v0.3.0`. It adds a compact
bilingual README, a detailed CEFR-B2 operating manual, and five Mermaid
diagrams with equivalent German and English text alternatives. Commands,
validators, lifecycle states, evidence contracts, and authority boundaries are
unchanged.

## Validation

| Check | Result |
|---|---|
| Canonical scaffold and publication copy | Recursive comparison passed |
| Public PR head and merge | Exact candidate head `39064b9953942234144bc2e1f23fbbbf139cddb6` merged as the recorded commit |
| GitHub tag and `main` | Both resolve to the recorded merge commit |
| ZIP integrity | `unzip -t` passed |
| Extracted ZIP parity | No difference from the publication copy |
| Mermaid syntax | Five of five diagrams rendered with Mermaid CLI `11.12.0` |
| GitHub rendering | Overview diagram rendered at desktop width in light and emulated dark theme without horizontal overflow |
| Accessibility | Every diagram is followed by a complete DE/EN text alternative |
| Markdown and links | Pandoc reading order and offline Lychee validation passed |
| PowerShell analysis | Relevant test additions and scripts passed PSScriptAnalyzer |
| Isolated eight-preset stack | Eight enabled presets with priorities `10` through `80`; Preset 7 reported version `0.3.1` and 18 contributions |
| Template resolution | `autonomous-run-agent-guidance-addendum-template` resolved from `v0.3.1` |
| Idempotent installer | A second complete installer run was unchanged; aggregate installed-file hash stayed `ea6fffeb4b2dfa98bc0fa0fb576ad076778859329a5082421314e1be52261ac9` |
| Remove and reinstall | Preset 7 removed cleanly, reinstalled at priority `70`, and its installed directory matched the tagged archive |

The repositories require one human code-owner approval. GitHub Copilot review
was configured but had not produced a review or thread. After all local,
rendering, exact-head, and archive checks passed with no review thread, the
public PR was merged with the established owner admin bypass. The bypass is
recorded as delivery authority, not as technical evidence.

## Boundaries

- No runtime or validator behavior changed.
- No provider, model, secret, remote-write, merge, or bypass authority was
  added.
- Preset 7 remains sufficient for one explicitly delegated autonomous run.
- Preset 8 remains the separate coordinator for multiple workers.
