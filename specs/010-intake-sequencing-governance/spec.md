# Feature Specification: Intake Sequencing Governance

**Feature Branch:** `010-intake-sequencing-governance`
**Created:** 2026-07-25
**Status:** Ready for Planning
**Binding Intake:** `Lastenheft_Spec-Kit-Intake-Sequencing-Governance.md`

## User Scenarios

### User Story 1 - Create and understand an intake series (Priority: P1)

As a learner or maintainer, I can create one traceable series from explicitly
named existing intakes and read its order, roots, dependencies, blockers, and
next candidates without graph-theory knowledge.

**Independent Test:** Create a three-target fixture, validate it in Bash and
PowerShell, read it text-first, and confirm one root and two dependencies.

### User Story 2 - Maintain series lifecycle safely (Priority: P1)

As a maintainer, I can update or logically delete a series only with explicit
authority, preserving prior evidence and never deleting the intake documents.

**Independent Test:** Update a fixture with a superseding receipt, then archive
and tombstone it; prove the previous state remains byte-identical.

### User Story 3 - Select executable work without starting it (Priority: P1)

As an operator or downstream agent, I can inspect status and obtain all
currently eligible targets or exact blockers without changing files or
starting another Spec Kit command.

**Independent Test:** Run read, status, and next against mixed lifecycle states
and prove unchanged hashes and worktree.

### User Story 4 - Compose and distribute the optional preset (Priority: P2)

As a repository owner, I can install the preset at priority 66 with the other
ten optional governance presets and see each command exactly once on every
supported agent surface.

**Independent Test:** Exercise add, list, info, resolve, disable/enable,
remove/reinstall, agent generation, and ZIP installation in a temporary project.

## Requirements

### Functional Requirements

- **FR-001:** The preset MUST provide exactly the six canonical commands named
  in the binding intake.
- **FR-002:** Create MUST refuse existing active series and publish no partial
  multi-file state.
- **FR-003:** Read MUST produce a CEFR-B2 text-first summary without writes.
- **FR-004:** Update MUST require current explicit authority, archive the prior
  state, and bind the successor through `supersedes`.
- **FR-005:** Delete MUST archive and tombstone the series without deleting
  intake content.
- **FR-006:** Status MUST validate current manifest, receipt, targets, graph,
  and lifecycle evidence without writes.
- **FR-007:** Next MUST return every eligible target or exact blockers and MUST
  NOT execute a downstream command.
- **FR-008:** Targets MUST be unique repository-relative paths.
- **FR-009:** Roots MUST equal the zero-indegree target set for binding edges.
- **FR-010:** Edges MUST use an accepted type, reference distinct known
  targets, be unique, respect declared order, and form an acyclic graph.
- **FR-011:** Ambiguous dependencies or lifecycle facts MUST yield
  `NeedsClarification`; they MUST NOT be inferred.
- **FR-012:** Bash and PowerShell validators MUST share error classes and exit
  behavior.
- **FR-013:** The Home Baseline 13-target, 6-root, 15-edge series MUST pass as
  read-only Legacy Adoption evidence.
- **FR-014:** Existing eight-, nine-, and ten-preset profiles MUST remain
  unchanged; a separate optional eleven-preset profile MUST use priority 66.
- **FR-015:** No command MAY author intake content, perform Intake Review, or
  start Specify, Autonomous, or Parallel Autonomous implicitly.
- **FR-016:** Shared agent guidance MUST remain synchronized across maintained
  agent surfaces.
- **FR-017:** Release and fleet installation MUST remain optional and MUST NOT
  infer bypass or provider authority.

### Governance Applicability

- Security, architecture, iSAQB, A11Y, cross-platform, and agent-parity
  governance apply to the package and validation surfaces.
- Supply-chain evidence applies to the new public package and release.
- Threat-model and cloud controls are `N/A` for product runtime because no
  service, deployment topology, trust boundary, or provider dependency changes.
- Bash/PowerShell parity, text-first output, UTF-8 handling, secret scanning,
  least authority, and accessible documentation are applicable.

## Success Criteria

- **SC-001:** Positive three-target and 13-target field fixtures pass both
  validators.
- **SC-002:** Every defined malformed graph and lifecycle fixture fails with
  equivalent Bash/PowerShell classification.
- **SC-003:** Read, status, and next leave all tracked and evidence hashes
  unchanged.
- **SC-004:** All six commands appear exactly once on every supported surface.
- **SC-005:** Eleven-preset composition and versioned ZIP installation pass.
- **SC-006:** Existing supported preset profiles remain byte-for-byte unchanged.
- **SC-007:** Fleet registration marks the new preset optional.
- **SC-008:** No Critical or High finding remains before delivery.

## Assumptions

- `origin` is the publication remote name.
- The new preset consumes existing intake paths but does not own their content.
- Community catalog merge is not a local completion condition.
- MergeAndSync authority covers this feature, its owned publication repository,
  and optional fleet delivery; no admin bypass is granted.

## Out of Scope

Runtime product changes, intake content creation, automatic review, automatic
feature execution, cloud deployment, secrets, and changes to existing default
preset profiles.
