# Implementation Plan: Documentation Impact Governance

**Branch**: `012-documentation-impact-governance` | **Date**: 2026-07-26

## Summary

Establish one normative Documentation-Impact contract, carry it through
workflow and agent surfaces, provide bilingual ownership guidance, validate a
small JSON Evidence contract in Bash and PowerShell, and preserve all D1
fleet findings for D3.

## Technical Context

**Language**: PowerShell 7 plus Bash wrapper
**Dependencies**: Repository scripts only; no new package
**Storage**: Git-tracked Markdown and JSON
**Testing**: PowerShell fixture tests, Bash/PowerShell parity
**Target**: macOS, Linux, Windows
**Constraints**: No product/runtime change; no Level-1/2 write
**Scope**: Level-0 governance and 15 D1 handoffs

## Constitution Check

- MSL: PowerShell is memory-safe; Bash is a narrow wrapper.
- Security: NIST SSDF/CWE evidence integrity applies; runtime standards are
  trigger-based `N/A`.
- A11Y: DE-first/EN-second, CEFR B2, text-first and WCAG 2.2 AA.
- Presets: all eleven reviewed; no new preset is assumed.
- Statistics and all five shared agent surfaces are affected.
- No credentials, logs, caches or private absolute paths are tracked.

## Implementation Slices

1. Evidence schema, positive fixture and failing negative fixtures.
2. Validator implementation and Bash/PowerShell parity.
3. Constitution and workflow integration.
4. Central reference, agent parity and D1 handoff.
5. Full validation, MergeAndSync and causal archival closeout.

## Files

```text
specs/012-documentation-impact-governance/
docs/documentation-governance.md
.specify/templates/documentation-impact-evidence-template.json
scripts/validate-documentation-impact.ps1
scripts/validate-documentation-impact.sh
scripts/test-documentation-impact.ps1
docs/man/validate-documentation-impact.1.md
```
