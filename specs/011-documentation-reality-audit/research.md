# Research: Registered Documentation Reality Audit

## Decision 1: Freeze the target set from the fleet manifest

**Decision:** Use `scripts/config/agentic-workspace-fleet.json` plus Level 0 as
the binding audit scope and record exact commits at audit start.

**Rationale:** A moving registry cannot support exact cardinalities or
reproducible handoffs.

**Rejected:** Discovering arbitrary Git directories under `~/`; this would mix
registered scope with unrelated and private repositories.

## Decision 2: Review documentation families, not every line

**Decision:** One review area represents one repository-owned documentation
family or named flow. Every area receives one primary decision.

**Rationale:** This preserves complete surface coverage while keeping evidence
reviewable. Claims and findings still cite exact files and commits.

**Rejected:** One row per Markdown line or one row per repository only; the
first is unreviewable and the second hides distinct ownership and generation
contracts.

## Decision 3: Feature-local deterministic validator

**Decision:** Use a Python 3 standard-library validator and `unittest` fixtures
inside the feature directory.

**Rationale:** Structured JSON validation is safer and more portable than
ad-hoc text parsing. Feature-local placement prevents an audit-only contract
from becoming an unsupported public tool.

**Rejected:** New Bash and PowerShell product wrappers; D1 has no public CLI and
would create unnecessary parity and maintenance scope.

## Decision 4: Evidence minimization

**Decision:** Store repository-relative paths, public remote URLs, commits,
counts, classifications, and concise claim evidence. Never store private
absolute paths, logs, credentials, or machine-local configuration.

**Rationale:** The audit must be publishable and reproducible without exposing
the workstation.

## Decision 5: No inferred remediation

**Decision:** Findings receive D2, D3, or non-remediation handoffs, but D1 does
not edit downstream intakes or repositories.

**Rationale:** Audit evidence and remediation authority remain separate.

## Clarification Outcome

No material ambiguity remains. The current Series review is `Ready`, its root
is D1, and D2/D3 dependencies are explicit.
