# Documentation Impact Contract

Each entry has one unique `changeId` and exactly one decision:
`UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate`, or `FollowUp`.

- `UpdateRequired` names at least one document and current evidence.
- `NoUpdateRequired` has a non-empty rationale and reviewed scope.
- `GeneratedUpdate` names source, renderer and generated documents.
- `FollowUp` names owner, risk, due date, trigger and scope reason.

Security, usage and breaking-change documentation cannot use `FollowUp`
without explicit accepted-risk evidence.
