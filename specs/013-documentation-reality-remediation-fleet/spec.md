# Feature Specification: Documentation Reality Remediation Fleet

**Feature Branch**: `013-documentation-reality-remediation-fleet`
**Binding Intake**: `Lastenheft_Registrierte-Level-1-2-Dokumentations-Wirklichkeitsabgleich-Flotte.md`
**Delivery Mode**: `MergeAndSync`

## Scope

Feature 013 applies the merged Level-0 Documentation Impact baseline to every
currently registered Level-1 and Level-2 repository. Each repository is
evaluated against its own language, runtime, role, learner context, and
documentation. Only proven documentation and governance drift may be changed.

Product behavior, APIs, dependencies, and unregistered repositories are out of
scope. An unsafe repository is recorded and not modified. Each changed
repository receives one non-empty pull request; unchanged repositories receive
central evidence only.

## Functional Requirements

- **FR-001** Revalidate Level 0 and inventory all registered Level-1/2 targets.
- **FR-002** Enforce fetch-first Remote Freshness and safe mutation rules.
- **FR-003** Record one impact decision for every repository delivery unit.
- **FR-004** Propagate the D2 governance package without overwriting
  project-specific content.
- **FR-005** Revalidate exactly `DOC001` through `DOC015` after propagation.
- **FR-006** Preserve learner, A11Y, MSL, native-platform, and agent-parity
  boundaries of each repository.
- **FR-007** Create separate, non-empty PRs for every changed repository.
- **FR-008** Bind technical gates and review state to each exact PR head.
- **FR-009** Consolidate repository, finding, PR, merge, and synchronization
  outcomes in Level-0 evidence.
- **FR-010** Revalidate Level 0 after fleet delivery and release the documented
  successor roots only after truthful completion.

## Success Criteria

- **SC-001** Level 0, eight Level-1 repositories, and 36 Level-2 repositories
  have explicit outcomes.
- **SC-002** All 32 registry-controlled repositories receive the current
  Documentation Impact package or a truthful blocker.
- **SC-003** Exactly 15 inherited findings have one final disposition each.
- **SC-004** No unsafe, dirty, ahead, diverged, detached, or ambiguous checkout
  is modified.
- **SC-005** Every changed repository has a merged non-empty PR, green required
  technical gates, and zero actionable review threads.
- **SC-006** All changed local repositories end clean and synchronized on their
  default branch.
- **SC-007** Level 0 remains the reviewed governance baseline apart from
  feature evidence, intake closeout, and statistics.

## Clarifications

No material ambiguity remains. The currently observed 32-package drift is the
expected D2-to-D3 propagation delta. Existing D1 bilingual findings are
revalidated after installing the current checker and are not blindly edited.
