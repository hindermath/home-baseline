# Governance Requirements Checklist: Feature 017

**Purpose**: Test whether the specification states every governance decision
clearly enough for planning and acceptance.
**Created**: 2026-07-29
**Feature**: [spec.md](../spec.md)

## Security and Architecture

- [x] Are Remote, Git, process, path and lease trust boundaries explicitly
  defined? [Completeness, Spec GR-001/GR-002]
- [x] Are fail-closed outcomes and prohibited checkout mutations stated without
  relying on an implementation assumption? [Clarity, Spec FR-004/FR-018]
- [x] Are security, supply-chain, regulatory, cloud and web applicability
  decisions accompanied by rationale and re-evaluation triggers?
  [Completeness, Spec GR-001/GR-002]
- [x] Are runtime sequence, quality attributes, error boundaries and
  architecture evidence required for planning? [Coverage, Spec GR-003]

## Cross-Platform and Accessibility

- [x] Are Bash and PowerShell parity requirements defined for behavior,
  preview, recovery, status classes and exit codes? [Completeness, Spec FR-008]
- [x] Are manpage, PowerShell help and preview-mode expectations explicit?
  [Coverage, Spec GR-005]
- [x] Are German-first/English-second, CEFR B2, WCAG 2.2 AA and text-first
  evidence requirements defined? [Completeness, Spec GR-004]
- [x] Are private-path and color-independence boundaries stated?
  [Clarity, Spec SC-005]

## Preset and Agent Composition

- [x] Is the dynamic profile catalog distinguished from the current count of
  eleven presets? [Clarity, Spec FR-016]
- [x] Are Authoring, Review and Sequencing treated as binding evidence without
  expanding their preset scope? [Consistency, Spec GR-007]
- [x] Is Parallel Autonomous explicitly non-applicable because no campaign is
  requested? [Applicability, Spec GR-007]
- [x] Are shared agent surfaces updated together only if the shared contract
  changes? [Consistency, Spec GR-006]

## Delivery Authority

- [x] Is `MergeAndSync` limited to Feature 017 rather than target repositories?
  [Clarity, Spec FR-020/GR-008]
- [x] Is the narrow bypass limited to green technical gates, zero actionable
  threads and Human Approval as the sole remaining rule? [Security, Spec GR-008]
- [x] Are changed-head invalidation and full exact-head revalidation measurable?
  [Acceptance, Spec SC-010]
- [x] Is automatic execution of Position 4 excluded? [Scope, Spec SC-012]

## Result

All governance requirements are complete. No formal clarification is needed.
