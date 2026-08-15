# Feature Specification: Autonomous Evidence Integrity Hardening

**Feature Branch**: `027-autonomous-evidence-integrity-hardening`
**Created**: 2026-08-15
**Status**: Ready
**Binding Intake**: `Lastenheft_Autonomous-Evidence-Integrity-Hardening.md`

## Purpose

Create and validate an unreleased `autonomous-run-governance` v0.4.0 candidate
that closes `AR-038-01` through `AR-038-03`. The candidate must determine an
explicit delivery set, require semantic phase completion, and separate
pre-merge from post-merge gate evidence. Feature 027 must not publish, tag,
release, roll out, or start another feature.

## User Scenarios and Testing

### User Story 1 - Validate the intended delivery set (Priority: P1)

As an autonomous-run operator, I need a read-only validator to inspect tracked
changes and explicitly named untracked delivery files so whitespace or scope
defects cannot escape merely because a file is not yet tracked.

**Independent Test**: A temporary repository proves valid tracked and named
untracked paths, rejects whitespace and repository escapes, excludes ignored
runtime evidence, reports unrelated files, and leaves index and worktree hashes
unchanged.

### User Story 2 - Complete phases semantically (Priority: P1)

As an operator resuming a run, I need process success and structured phase
evidence to agree before a phase becomes `Completed`, preventing a zero exit
code from hiding a blocked or incomplete result.

**Independent Test**: The phase wrapper accepts one complete bound result and
rejects or reclassifies blocked, incomplete, absent, truncated, schema-drifted,
phase-mismatched, or hash-mismatched results.

### User Story 3 - Bind delivery evidence to lifecycle (Priority: P1)

As a reviewer, I need separate `PreMerge` and `PostMerge` snapshots so the
reviewed head is proven before merge while later provider facts remain causal
and cannot rewrite the product delta.

**Independent Test**: Schema 2.0 fixtures prove both snapshots, reject merge
claims before merge, and require the post-merge snapshot to bind the accepted
pre-merge hash and actual merge commit.

### User Story 4 - Preserve existing users and history (Priority: P2)

As a preset user, I need existing commands, stop/status/resume behavior, agent
surfaces, and historical schema-1.0 evidence to remain usable without allowing
legacy evidence to authorize a new merge.

**Independent Test**: Existing regression suites pass; schema 1.0 validates
only under an explicit historical mode; all commands and skills occur once per
maintained agent surface.

## Edge Cases

- An intended path is missing, duplicated, absolute, outside the repository,
  ignored, a directory, a symlink escape, or ambiguously normalized.
- Unrelated untracked files coexist with the intended delivery set.
- A phase process exits zero but reports `Blocked`, incomplete task counts, a
  false gate, or a result for another phase.
- A result file is absent, empty, truncated, malformed, replaced after hashing,
  or valid but stale after interruption.
- A pre-merge snapshot claims merge facts, or post-merge evidence binds the
  wrong head, requirements hash, pre-merge hash, or merge commit.
- CRLF and UTF-8 BOM inputs must normalize identically to LF without weakening
  strict UTF-8 handling.

## Functional Requirements

- **FR-001**: Provide Bash and PowerShell entry points for a read-only intended
  delivery-set validator.
- **FR-002**: The validator MUST cover tracked changes plus explicitly named
  untracked files and MUST NOT infer unrelated files as intended delivery.
- **FR-003**: The validator MUST fail closed for missing, ambiguous, escaping,
  ignored, or whitespace-invalid intended paths without changing Git state.
- **FR-004**: Define a versioned structured phase-result contract containing
  phase identity, outcome, expected/completed tasks, blocked reason, gate
  assertion, payload hash, and normalized document hash.
- **FR-005**: A phase is `Completed` only when exit code, schema, identity,
  outcome, task counts, gate assertion, and hashes all pass.
- **FR-006**: Missing or contradictory phase evidence MUST produce
  `NeedsRevalidation` or `Blocked`, never inferred success.
- **FR-007**: Resume MUST revalidate authority and evidence and MUST avoid
  repeating work whose completion is already trustworthy.
- **FR-008**: Gate Evidence schema 2.0 MUST distinguish `PreMerge` and
  `PostMerge` snapshots.
- **FR-009**: `PreMerge` MUST bind reviewed head and requirements but MUST NOT
  claim or authorize merge.
- **FR-010**: `PostMerge` MUST bind the accepted pre-merge normalized hash and
  actual merge commit while adding no product delta.
- **FR-011**: Schema 1.0 remains readable only in explicit historical mode and
  cannot authorize new v0.4.0 delivery.
- **FR-012**: Canonical scaffold and publication copy MUST remain byte-identical
  for all candidate files.
- **FR-013**: Existing five commands, generated skills, stop/status/resume,
  delivery modes, and permission boundaries MUST remain compatible.
- **FR-014**: Documentation MUST explain the new contracts DE-first/EN-second,
  at CEFR B2, text-first, and with applicable WCAG 2.2 AA considerations.
- **FR-015**: Feature 027 MUST end with a merged unreleased candidate and MUST
  NOT create a tag, release, catalog update, fleet update, or G2B run.

## Governance Applicability

- **Security Governance**: Applicable to fail-closed path, integrity, and
  permission controls. NIST SSDF and CWE Top 25 inform validation; ASVS,
  SBOM/VEX/SLSA, AI-SBOM, NIS2, CRA, EU AI Act, and DORA are `N/A` because no
  service, runtime AI component, package, or release is delivered. Re-evaluate
  if G2B publishes the candidate.
- **Architecture and iSAQB**: Applicable to lifecycle and trust-boundary
  contracts. Cloud autonomy/compliance, BSI C3A/C5, CAPEC, Zero Trust, arc42,
  S-ADR, SAMM, STRIDE/CIA, and distributed CAP concerns are `N/A` because no
  cloud, deployment, provider, or service boundary changes. Re-evaluate on
  provider or deployment changes.
- **A11Y**: Applicable to CLI errors, documentation, text-first status, DE-first
  and EN-second guidance, CEFR B2, and terminology for learners.
- **Cross-Platform**: Applicable because Bash and PowerShell contracts change;
  parity is mandatory.
- **Agent Parity**: Applicable to commands, skills, addenda, and all maintained
  agent surfaces. No command is added.
- **Intake Authoring, Review, and Sequencing**: Applicable as accepted input,
  review, and G2 gate evidence; their implementation is unchanged.
- **Autonomous and Parallel Autonomous**: Autonomous is the product under
  change. Parallel behavior is regression-only and gains no new authority.
- **Model Routing**: Applicable to the phase-result wrapper and local routing
  preflight; concrete model names remain machine-local.

## Key Entities

- **Delivery Set**: Explicit repository-relative paths intended for delivery,
  separated from unrelated or ignored runtime files.
- **Phase Result**: Versioned semantic result for one routed phase and attempt.
- **Completion Predicate**: Deterministic rule combining process and evidence.
- **Lifecycle Snapshot**: `PreMerge` or `PostMerge` gate-evidence record.
- **Historical Evidence**: Schema-1.0 record accepted for audit only.

## Success Criteria

- **SC-001**: All positive and negative delivery-set fixtures pass identically
  in Bash and PowerShell without changing index or worktree state.
- **SC-002**: No combination of exit zero with `Blocked`, incomplete tasks,
  false gates, or invalid hashes can produce `Completed`.
- **SC-003**: Pre-/post-merge schema-2.0 fixtures and all binding failures have
  deterministic matching cross-shell classifications.
- **SC-004**: Historical schema 1.0 remains audit-readable but fails any new
  merge-authorization path.
- **SC-005**: Existing autonomous, routing, stop/status/resume, permission, and
  agent-parity regressions pass.
- **SC-006**: Canonical and publication candidate trees are byte-identical and
  identify version 0.4.0 without any corresponding tag or release.
- **SC-007**: Final Git evidence contains no fleet-consumer or product-runtime
  change and no G2B execution artifacts.

## Documentation Impact

Decision: `UpdateRequired`. Canonical owner is the autonomous preset
maintainer. Affected readers are operators, preset maintainers, runner authors,
learners, and application developers. Update README, lifecycle, evidence,
recovery, authority, runbook, checklist, manpages, templates, field-validation
summary, and agent addendum. Language is DE-first/EN-second; distribution is
`sourceOnly` during G2A, so no Home Runtime sync or consumer rollout occurs.
Re-evaluate at G2B release validation or whenever phase, gate, or delivery
contracts change.

## Assumptions and Boundaries

- PowerShell 7 and Python remain existing supported validator dependencies; no
  new package dependency is introduced.
- Current provider-neutral Git object IDs are 40 or 64 hexadecimal characters.
- G2B independently validates and decides release; G2A cannot self-promote.
- The current bounded admin-bypass authorization applies only where all
  technical gates pass, no actionable review thread remains, and Human
  Approval is the sole blocking rule.
- No material ambiguity remains that would change planning or validation.
