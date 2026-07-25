# Implementation Plan: Intake Sequencing Governance

## Summary

Build an optional, portable Spec Kit preset at priority 66 that manages the
ordering and lifecycle of existing intake files. The implementation uses
agent-authored commands and deterministic Bash/PowerShell validation. It is
packaged in canonical and publication trees, proven against synthetic fixtures
and the current Home Baseline series, released independently, then installed as
an optional fleet profile.

## Technical Context

- **Languages:** Markdown, JSON, YAML, Bash, PowerShell 7
- **Product shape:** Spec Kit preset; scripts validate persisted contracts
- **Testing:** PowerShell fixture runner invokes both shell validators
- **Storage:** Repository-owned JSON/Markdown; archive plus tombstone lifecycle
- **Platform:** macOS, Linux, Windows with Bash/PowerShell parity
- **Performance:** Linear graph validation for normal intake-series sizes
- **Accessibility:** Text-first, German-first/English-second, CEFR B2
- **Authority:** MergeAndSync; no inferred admin bypass

## Constitution Check

- Secure coding: strict UTF-8, safe path handling, no `eval`, no source execution.
- Secure architecture: fail-closed validation and explicit write authority.
- A11Y: text alternatives communicate order, roots, blockers, and next actions.
- Cross-platform: Bash and PowerShell validators plus shared fixtures.
- Agent parity: all maintained surfaces receive exactly one generated command.
- Statistics and evidence: update after implementation and release.

## Project Structure

```text
specs/spec-kit-presets/intake-sequencing-governance/
specs/spec-kit-preset-repos/spec-kit-preset-intake-sequencing-governance/
specs/010-intake-sequencing-governance/
scripts/config/spec-kit-intake-sequencing-governance-presets.json
```

## Implementation Slices

1. Establish accepted schemas, error classes, and field evidence.
2. Implement validators test-first with positive and malformed fixtures.
3. Add commands, templates, runbook, checklist, agent guidance, and README.
4. Synchronize publication copy and optional eleven-preset profile.
5. Validate local package, temporary composition, agent parity, and ZIP.
6. Deliver Home Baseline, publication release, fleet profile, and submission.

## Validation Strategy

- Receipt and review validators for the bootstrap intake.
- Bash syntax and PSScriptAnalyzer.
- Positive and negative sequencing fixtures in both shells.
- Legacy-Adoption field proof without modifying active intake evidence.
- `specify check`, preset add/list/info/resolve/disable/enable/remove/reinstall.
- Agent command/skill cardinality, homogeneity, secret scan, and diff checks.
- Release ZIP SHA-256 and clean checkout validation.

## Stop Boundaries

Stop on ambiguous graph decisions, path escape, validator disagreement,
unexpected changes to existing profiles, package drift, failed mandatory gate,
or need for authority beyond MergeAndSync.
