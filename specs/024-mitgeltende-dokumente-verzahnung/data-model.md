# Data Model: Mapping Review

## Review Row

`path`, `kind`, `applicability`, `implementation`, `rationale`, `evidence`,
`owner`, `reviewer`, `residualRisk`, `followUp`, and `reevaluationTrigger` are
mandatory. Paths are repository-relative and unique. Checklist and preset
assignments remain in the hash-bound canonical mapping instead of being
duplicated in the review ledger.

## Profile

`publicStandard` contains exactly eight governance preset IDs. `managedOptional`
contains exactly the three intake preset IDs. Membership is disjoint.

## Finding

Stable `MDV-###`, severity, owner, evidence, disposition and follow-up boundary.
An empty finding list is valid only after complete cardinality proof.
