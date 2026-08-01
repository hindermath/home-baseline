# Feature Specification: Registered Documentation Architecture Adoption

**Feature Branch**: `023-registered-doc-architecture-adoption`
**Created**: 2026-08-01
**Status**: Ready for Planning
**Binding Intake**: `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md`
**Delivery Mode**: `MergeAndSync`

## Purpose And Scope

Feature 023 evaluates every active Level-1 and Level-2 target from the current
fleet manifest and adopts only documentation-architecture rules that are both
portable and demonstrably useful for that repository. The feature is a
documentation-governance adoption run. It does not alter product behavior,
public APIs, dependencies, package versions, toolchains, deployment behavior,
or the technical propagation target set.

The merged Feature-022 guide, its bilingual partner, its 17 hash-bound claims,
and the Documentation Impact contract are the source material. They are
decision inputs rather than files to copy wholesale. Each repository retains
its own language, runtime, learning, security, sandbox, non-MSL, generated-file,
and historical-evidence boundaries.

## User Scenarios And Testing

### User Story 1 - Complete Fleet Decision Record (Priority: P1)

As a fleet maintainer, I need one exact and reviewable decision for every
registered target so that no repository is silently skipped or changed merely
because its file names resemble Level 0.

**Why this priority**: Complete inventory and repository ownership are the
primary safety boundary for all later adoption work.

**Independent Test**: Derive the target set from the current manifest, complete
the Remote Freshness preflight, and verify that each active Git target and each
collection target has exactly one primary outcome with repository, branch,
commit, applicability, rationale, evidence, and next action.

**Acceptance Scenarios**:

1. **Given** a clean synchronized repository, **when** its documentation is
   reviewed, **then** it receives an evidence-backed adoption or unchanged
   decision before any edit is proposed.
2. **Given** a dirty, ahead, diverged, detached, non-default, missing-upstream,
   unreachable, or otherwise ambiguous repository, **when** the preflight runs,
   **then** it remains unchanged and receives a blocking reason and next action.
3. **Given** one blocked repository, **when** the remaining inventory runs,
   **then** every other target is still inspected and classified.

---

### User Story 2 - Portable, Repository-Specific Adoption (Priority: P2)

As a learner, application developer, or maintainer, I need documentation that
explains the repository I am actually using instead of imposing Level-0 paths
or terminology that do not apply to it.

**Why this priority**: A copied architecture can be precise but wrong; the
repository-specific reader and source contracts must remain authoritative.

**Independent Test**: For each adoption candidate, trace the proposed statement
to a Feature-022 claim, prove applicability in the target repository, and verify
its source, owner, reader path, language strategy, Documentation Impact decision,
validation, residual risk, and re-evaluation trigger.

**Acceptance Scenarios**:

1. **Given** a portable reader-path or source-of-truth rule, **when** a target
   lacks that information and the rule fits its architecture, **then** a scoped
   documentation update is proposed with repository-specific terminology.
2. **Given** a Level-0-only Home Runtime rule, **when** a target has no equivalent
   runtime copy, **then** the rule is marked not applicable and is not copied.
3. **Given** generated, archived, learning-series, sandbox, or non-MSL content,
   **when** adoption is evaluated, **then** the repository's own source and
   governance boundary remains intact.

---

### User Story 3 - Exact-Head Delivery Without Empty PRs (Priority: P3)

As a repository owner or reviewer, I need each real change delivered in an
independent, non-empty pull request with evidence for its exact reviewed head.

**Why this priority**: Fleet completion must distinguish actual adoption from
unchanged, blocked, and inapplicable repositories without manufacturing work.

**Independent Test**: Verify that every changed repository has one non-empty PR,
its repository-native gates and reviews pass on the exact head, and its local
default branch is clean and synchronized after merge; verify that no unchanged,
blocked, or inapplicable repository receives a PR.

**Acceptance Scenarios**:

1. **Given** a target with a justified documentation change, **when** delivery
   completes, **then** its exact-head gates pass and the merged target returns to
   a clean synchronized default branch.
2. **Given** a target with no applicable change, **when** the run completes,
   **then** its decision is evidenced without creating an empty branch or PR.
3. **Given** the target head changes after review, **when** delivery is attempted,
   **then** stale evidence is rejected and the target is revalidated.

### Edge Cases

- A collection target is inventoried separately and never treated as a Git
  checkout.
- A repository is clean but checked out on a non-default branch; fetch is
  allowed, while pull and mutation remain blocked.
- A repository contains a project-specific exception to a propagated document;
  the exception is preserved and recorded as intentional evidence.
- A portable rule is already adequately covered under different terminology;
  the target is unchanged and the equivalent local contract is cited.
- A target has no English partner because its repository policy is
  single-language; that policy is evaluated rather than overwritten.
- A generated document appears stale; only its canonical source and renderer may
  be changed, and only when that change remains inside this feature's scope.
- Existing maintenance-package propagation drift includes executable scripts;
  it is recorded as a separate operational finding and is not repaired by this
  documentation-only feature.

## Clarification Record

- **Pass 1**: No material ambiguity remains in target derivation, preflight
  blocking, adoption decisions, Documentation Impact, or delivery authority.
- **Pass 2**: The observed maintenance-package drift and the blocked
  `AgentOperationsCockpit` checkout do not change scope. They are explicit
  evidence outcomes rather than implicit repair authority.
- **Result**: No formal clarification question is required. Planning may proceed.

## Requirements

### Fleet And Preflight Requirements

- **FR-001**: The run MUST derive its target set from the current versioned fleet
  manifest and validated local registry rather than a historical count.
- **FR-002**: Level 0 MUST be clean and exactly synchronized with `origin/main`
  before feature creation and after the final fleet closeout.
- **FR-003**: Every reachable Git remote MUST receive a bounded fetch attempt
  before the first target-repository content mutation.
- **FR-004**: The preflight MUST continue across the entire fleet after
  individual failures and MUST separately classify active Git targets,
  collection targets, and local special states.
- **FR-005**: Pull is permitted only as `--ff-only` for a clean canonical
  default branch with an unambiguous upstream, zero ahead commits, and a purely
  behind state.
- **FR-006**: Dirty, ahead, diverged, detached, non-default, missing-upstream,
  unreachable, or ambiguous repositories MUST remain unchanged and receive a
  blocking reason plus an exact next action.
- **FR-007**: Every target MUST receive exactly one primary outcome:
  `Adopted`, `AlreadyAligned`, `NotApplicable`, or `Blocked`.

### Documentation Adoption Requirements

- **FR-008**: Every active Git repository MUST receive a Git-derived
  documentation inventory and an audience/reader-path assessment.
- **FR-009**: Every adoption candidate MUST identify its Feature-022 source
  claim and prove target-specific applicability before any file is edited.
- **FR-010**: Portable rules MUST be separated from project-specific product,
  runtime, build, deployment, language, learning, security, sandbox, and
  evidence content.
- **FR-011**: Root README files, language partners, and navigation MUST change
  only for a repository-specific, evidence-backed finding.
- **FR-012**: Each actual change MUST record exactly one Documentation Impact
  decision: `UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate`, or
  `FollowUp`, with all repository-required fields.
- **FR-013**: `FollowUp` decisions MUST name owner, risk, due date,
  re-evaluation trigger, evidence, and why remediation is outside Feature 023.
- **FR-014**: Generated documents MUST be updated through their canonical source
  and renderer; historical or archived evidence MUST not be rewritten.
- **FR-015**: Shared agent guidance MUST be updated only as the complete set of
  maintained surfaces declared by the target repository.
- **FR-016**: User-facing changes MUST follow the repository's declared language
  policy, CEFR B2, first-use terminology explanations, text-first communication,
  and WCAG 2.2 AA where applicable.
- **FR-017**: Level-0 paths, `homeRuntime`, `sourceOnly`, and `machineLocal` MUST
  not be asserted outside Level 0 unless the target repository proves a
  semantically equivalent local contract.
- **FR-018**: Learning-series, sandbox, non-MSL, product, generated, and
  historical boundaries MUST remain repository-owned and explicitly preserved.
- **FR-019**: The feature MUST NOT expand the propagation manifest, the Home
  Runtime set, package/toolchain behavior, or deployment behavior.

### Delivery And Evidence Requirements

- **FR-020**: Shared fleet evidence and Level-0 feature artifacts MUST have one
  serialized writer.
- **FR-021**: Every changed target MUST use an independent non-empty branch and
  pull request; unchanged, blocked, and inapplicable targets MUST receive no PR.
- **FR-022**: Before each target commit, push, and merge, its current head,
  worktree, staged inventory, validation evidence, and review state MUST be
  rechecked.
- **FR-023**: Every target change MUST pass `git diff --check`, internal-link and
  language-partner checks, Documentation Impact validation, applicable native
  documentation/A11Y/security/homogeneity gates, and shared-agent parity.
- **FR-024**: Provider check names alone MUST NOT be treated as proof; acceptance
  evidence MUST identify the command and runner or platform that actually ran.
- **FR-025**: Admin bypass is allowed only when all technical gates are green,
  no actionable review thread remains, and Human Approval is the sole open rule.
- **FR-026**: The completion report MUST distinguish changed, already aligned,
  not applicable, and blocked targets and MUST give every inventoried target
  exactly one final decision.
- **FR-027**: A preset follow-up requires a reproducible provider-neutral defect
  in more than one suitable repository or an immediate correctness/security
  defect; otherwise the retrospective MUST record `NoPromotion`.
- **FR-028**: Feature 023 MUST make no product, API, dependency, package,
  toolchain, workflow, or runtime behavior change and MUST start no successor
  intake automatically.

### Binding Intake Traceability

| Intake requirements | Specification coverage |
|---|---|
| DFA-001..DFA-003, DFA-025 | FR-001..FR-006 |
| DFA-004..DFA-011, DFA-023..DFA-024 | FR-008..FR-018 |
| DFA-012..DFA-016, DFA-026..DFA-028 | FR-020..FR-028 |
| DFA-017..DFA-022 | FR-009..FR-019 |
| AC-DFA-001..AC-DFA-004 | SC-001..SC-004 |
| AC-DFA-005..AC-DFA-008 | SC-005..SC-007 |
| AC-DFA-009..AC-DFA-014 | SC-004, SC-008, SC-009 |
| AC-DFA-015..AC-DFA-018 | SC-001..SC-009 |

### Constitution And Governance Requirements

- **CR-001**: Each Level-2 target MUST use its Level-2 Project Environment
  Registry entry as binding context for runtime, validation, A11Y, statistics,
  and agent surfaces.
- **CR-002**: The repository audience contract applies: German first, English
  second where required, CEFR B2, first-use terminology, no prior Spec-Kit
  knowledge, text-first status and decision evidence, and WCAG 2.2 AA where
  applicable.
- **CR-003**: Documentation Impact is `UpdateRequired` for Feature-023 fleet
  evidence and any adopted target documentation. It is `NoUpdateRequired` for
  unchanged target repositories. The feature MUST record the decision per
  target rather than one global shortcut.
- **CR-004**: Statistics and shared agent guidance require a final impact review.
  Statistics change only after a completed Level-0 feature; agent guidance
  changes only when the shared contract itself changes.
- **CR-005**: No implementation language is introduced. Repository-native
  validators remain authoritative; non-MSL repositories retain their documented
  justification.
- **CR-006**: Security Governance, Architecture Governance, iSAQB Architecture
  Governance, A11Y Governance, Cross-Platform Governance, and Agent Parity
  Governance apply to evidence and boundaries. Intake Authoring, Intake Review,
  Intake Sequencing, Autonomous Run, and Parallel Autonomous are process
  governance; Parallel Autonomous is `N/A` because writes are serialized.
- **CR-007**: NIST SSDF and CWE Top 25 receive an applicability record. OWASP
  ASVS, SBOM, VEX, SLSA, AI-SBOM, CRA, NIS2, EU AI Act, DORA, STRIDE, CAPEC,
  Zero Trust, SAMM, BSI C3A, and BSI C5 default to `N/A` because this feature
  changes documentation governance only; each `N/A` MUST name a re-evaluation
  trigger.
- **CR-008**: AI is used only as a development tool. No AI runtime, model,
  dataset, inference service, or released AI component is added; AI-SBOM is
  therefore `N/A` unless the actual target scope changes.
- **CR-009**: No public web, API, HTTP, authentication, trust boundary,
  distributed architecture, cloud provider, deployment topology, or releasable
  product artifact changes. Related product/security gates remain trigger-based
  `N/A`.

## Key Entities

- **FleetTarget**: One manifest-declared Level-1/2 Git repository or collection,
  including identity, path class, level, remote, default branch, preflight state,
  exact commit, and final decision.
- **DocumentationInventory**: Repository-derived set of reader entrances,
  canonical sources, language partners, generated documents, historical
  evidence, agent surfaces, and repository-native validation commands.
- **AdoptionCandidate**: A Feature-022 claim considered for one target, including
  applicability, target terminology, source/owner, intended path, and proof.
- **TargetDecision**: Exactly one `Adopted`, `AlreadyAligned`, `NotApplicable`, or
  `Blocked` result with rationale, evidence, residual risk, and next action.
- **DocumentationImpactRecord**: The target-specific impact decision and its
  source, owner, audiences, reader paths, language, distribution, validation,
  evidence, and re-evaluation trigger.
- **TargetDelivery**: Non-empty branch and PR evidence for an adopted target,
  including exact head, gates, reviews, merge commit, and local synchronization.

## Success Criteria

- **SC-001**: 100% of active manifest targets receive exactly one final primary
  decision, including a separate decision for every collection target.
- **SC-002**: 100% of active Git targets have a completed fetch attempt and
  preflight classification before the first target content mutation.
- **SC-003**: 100% of adopted rules are traceable to one Feature-022 claim and
  one target-specific applicability plus Documentation Impact record.
- **SC-004**: Zero Level-0-only source paths or runtime classes are copied into a
  target without proof of semantic equivalence.
- **SC-005**: 100% of changed repositories have a non-empty exact-head-validated
  PR and return to a clean synchronized default branch after merge.
- **SC-006**: Zero unchanged, inapplicable, or blocked repository receives an
  empty branch or PR.
- **SC-007**: Zero open Critical/High documentation finding remains in a target
  reported as completed; blocked findings remain explicitly outside completion.
- **SC-008**: The technical propagation target set is byte-identical before and
  after Feature 023 unless a separately authorized follow-up changes it.
- **SC-009**: Level 0 finishes clean on `main` with `HEAD == origin/main`, all
  feature gates complete, and no successor intake started.

## Assumptions

- `origin` is the canonical remote name declared by the fleet contract.
- The current manifest, rather than the intake's historic count, defines scope.
- Existing repository-specific documentation rules outrank similarly named
  Level-0 files when they intentionally differ.
- Fetching a dirty worktree is allowed; pulling or modifying it is not.
- Existing maintenance-package drift is inventory evidence, not implicit
  authority to propagate executable files during this documentation-only run.
- A repository may be correctly completed as `AlreadyAligned`, `NotApplicable`,
  or `Blocked` without receiving a PR.
- Current `MergeAndSync` and the narrowly authorized Human-Approval bypass apply
  only to non-empty pull requests created by this feature.

## Out Of Scope

- Product, API, runtime, dependency, package, workflow, toolchain, deployment,
  example, or learning-content feature changes.
- Broad README rewrites, mandatory bilingual conversion, or identical reader
  path counts across repositories.
- Repairing unrelated maintenance-package propagation drift.
- Rewriting archived or historical evidence.
- Releasing a preset or starting the next intake.
