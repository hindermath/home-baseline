# Accessibility Requirements Checklist: Agentic-Workspace-Wartungs-TUI

**Purpose**: Test learner and WCAG-oriented terminal requirements
**Created**: 2026-07-29

## Perceivable and Text-First

- [x] CHK001 Is every status required as ASCII text rather than color,
  position, animation or progress alone? [Completeness, Spec FR-025]
- [x] CHK002 Are unknown totals prohibited from appearing as invented
  percentages? [Clarity, Spec FR-023]
- [x] CHK003 Are compact and linear layouts required without information loss?
  [Coverage, Spec User Story 5]
- [x] CHK004 Are final evidence paths and next actions required to remain
  copyable? [Completeness, Spec FR-022–FR-026]

## Operable

- [x] CHK005 Is complete keyboard operation required for every selection and
  confirmation? [Coverage, Spec FR-024]
- [x] CHK006 Is safe cancellation specified before and during execution?
  [Coverage, Spec FR-008 and FR-030]
- [x] CHK007 Are animations optional and bounded by readable status?
  [Consistency, Spec FR-023–FR-025]

## Understandable

- [x] CHK008 Are German-first/English-second messages and CEFR B2 explicit?
  [Clarity, Spec FR-026]
- [x] CHK009 Must first-use technical terms be explained for learners without
  Spec-Kit experience? [Completeness, Spec FR-026 and Assumptions]
- [x] CHK010 Are focus, selection, blocking reason and next action textually
  named? [Coverage, Spec User Story 5]
- [x] CHK011 Are partial, warning, blocked and failed outcomes explicitly
  distinguishable? [Clarity, Spec FR-017 and FR-031]

## Robust and Assistive Technology

- [x] CHK012 Are `NO_COLOR` and `TERM=dumb` requirements explicit?
  [Completeness, Spec FR-024]
- [x] CHK013 Is stable linear screenreader reading order specified?
  [Clarity, Spec FR-024]
- [x] CHK014 Are narrow terminals and unsupported capabilities covered by a
  safe fallback? [Coverage, Spec FR-005 and FR-024]
- [x] CHK015 Does the spec require reasoned `N/A` decisions for WCAG criteria
  that do not apply to terminal software? [Governance, Spec GR-004]
