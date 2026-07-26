# Data Model

## DocumentationImpactEntry

- `changeId`: stable unique identifier
- `scope`: changed path or named change area
- `decision`: one of the four exact outcomes
- `rationale`: why this outcome is correct
- `documents`: affected or reviewed documents
- `owner`: accountable role
- `evidence`: repository-relative evidence path
- `risk`: residual risk or `N/A`
- `dueDate`: required for `FollowUp`
- `reevaluationTrigger`: required for `FollowUp`
- `generatedSource`: required for `GeneratedUpdate`

## D1FindingDisposition

- `findingId`, `decision`, `owner`, `evidenceHash`, `handoff`, `trigger`

Every D1 finding has exactly one disposition. D2 accepts only `D3Handoff` for
the 15 repository-specific findings discovered by Feature 011.
