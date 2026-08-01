# Contract: Fleet Documentation Adoption Acceptance

## Binding Inputs

- D7 intake and current authoring/review receipts
- active Series manifest, receipt and Ready review
- Feature 022 PR #199, reviewed head and merge commit
- bilingual D6 guide and 17-claim source matrix
- current versioned fleet manifest and operational registry
- repository-native governance, agent guidance and validation surfaces

## Required Outputs

- complete fleet preflight evidence
- one validated `FleetAdoptionMatrix`
- one final decision per active target
- repository-specific Documentation Impact evidence
- non-empty exact-head target PR evidence only where a change is adopted
- Level-0 feature evidence, run state, gate requirements and retrospective
- updated statistics and Series closeout evidence

## Acceptance Rules

1. The target cardinality exactly matches the current active manifest.
2. Every Git target has a completed fetch result before the first target edit.
3. Every target has exactly one allowed final decision.
4. Every adoption traces to one D6 claim and proves local applicability.
5. Every changed target has complete Documentation Impact and delivery evidence.
6. Every unchanged, inapplicable or blocked target has no feature-created PR.
7. Level-0-only paths and runtime terms appear only as explicit `N/A` or
   repository-proven semantic equivalents.
8. Generated, historical, learning, sandbox, non-MSL and product boundaries are
   preserved.
9. The propagation target set and executable behavior remain unchanged.
10. Exact-head provider evidence and zero actionable threads precede every merge.
11. Level 0 and every changed target end clean on synchronized default branches.

## Rejection Rules

- Missing, duplicate or unknown target
- More than one primary decision for a target
- Adopted target without a real non-empty change and exact-head PR evidence
- Aligned, inapplicable or blocked target with a feature-created PR
- Blocked target changed despite its ownership state
- Claim copied without repository-specific evidence
- Private absolute path in publishable evidence
- Product, runtime, dependency, package, workflow, toolchain or propagation-set
  change
- Completion asserted with an open Critical/High finding or actionable review
  thread
- Stale target head or gate evidence
