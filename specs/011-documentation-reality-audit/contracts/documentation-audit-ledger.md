# Contract: Documentation Audit Ledger

## Inputs

- Current `scripts/config/agentic-workspace-fleet.json`
- Level-0 repository identity
- Read-only Git and documentation evidence from every declared target

## Outputs

- `registry-snapshot.json`
- `documentation-audit.json`
- `autonomous-run-evidence.md`

## Required behavior

1. The registry snapshot binds the fleet manifest hash and exact Level-0 commit.
2. The audit ledger covers Level 0 and every frozen target exactly once.
3. Every documentation area uses one accepted decision.
4. Every supported claim cites exact evidence.
5. Every `DOC###` finding has complete ownership and exactly one handoff.
6. The validator rejects missing, duplicate, contradictory, or privacy-unsafe
   records with a non-zero exit status.
7. Validation never changes the audited repositories.

## Result classes

- `Ready`: complete and internally consistent audit evidence.
- `NeedsRemediationEvidence`: deterministic ledger defect.
- `Blocked`: target, authority, privacy, or provenance prevents a truthful
  complete audit.

`Ready` does not mean all documentation is correct. It means every confirmed
gap is complete, owned, and routed.
