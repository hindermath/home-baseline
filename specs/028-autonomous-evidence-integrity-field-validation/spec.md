# Feature Specification: Autonomous Evidence Integrity Field Validation and Rollout

**Feature Branch**: `028-autonomous-evidence-integrity-field-validation`
**Created**: 2026-08-16
**Status**: Ready
**Binding Intake**: `Lastenheft_Autonomous-Evidence-Integrity-Field-Validation-and-Rollout.md`

## Purpose

Independently validate the merged `autonomous-run-governance` v0.4.0 candidate
against real field boundaries for intended delivery sets, semantic phase
completion, Resume, and lifecycle evidence. Publish and roll out the preset
only after every synthetic and field gate passes, then close the G2 Series
without starting Position 7.

## User Scenarios and Testing

### User Story 1 - Prove evidence integrity in a real run (Priority: P1)

As an autonomous-run operator, I need the three Feature-038 findings exercised
outside the implementation feature so candidate self-tests cannot promote
themselves.

**Independent Test**: Controlled field fixtures reject a whitespace-invalid
untracked delivery file, reject exit-zero `Blocked` phase evidence, preserve a
trustworthy completed result across Resume, and validate distinct PreMerge and
PostMerge snapshots.

### User Story 2 - Install a trustworthy release (Priority: P1)

As a preset user, I need v0.4.0 installable from an immutable GitHub release
ZIP with unchanged command names and compatible composition.

**Independent Test**: A fresh temporary Spec Kit project installs the tagged
ZIP, composes all active presets, exercises add/list/info/resolve/disable/
enable/remove/reinstall, and exposes every command and skill exactly once.

### User Story 3 - Update applicable consumers safely (Priority: P1)

As a fleet maintainer, I need every currently registered Git repository whose
active profile contains the autonomous preset inventoried and either updated
through an exact-head-reviewed PR or reported with a blocking reason.

**Independent Test**: Fleet evidence names every registered target, collection
boundary, applicability decision, PR/head/check/review/merge/sync result, and
contains no fixed historical target count as control logic.

### User Story 4 - Restore the delivery Series (Priority: P2)

As a maintainer, I need the completed G2 gates archived so normal delivery can
continue with Position 7 as the sole preferred candidate, without starting it.

**Independent Test**: The final Series validator reports 32 targets, three
roots, 36 dependencies, and only Position 7 as declared `Eligible`.

## Edge Cases

- A field fixture exits zero while declaring `Blocked` or incomplete tasks.
- Resume receives stale authority, changed artifacts, changed tasks, or an
  already trustworthy complete result.
- A PreMerge snapshot claims merge facts or a PostMerge snapshot binds the
  wrong head, requirements hash, predecessor hash, or merge commit.
- A registered target is a collection, unreachable, dirty, ahead, diverged,
  on a non-default branch, or does not install the autonomous preset.
- A consumer already contains v0.4.0 and would produce an empty PR.
- A technical gate is missing, stale, duplicated, or only inferred from a job
  name rather than its executed command.
- Community catalog processing remains pending after local completion.

## Functional Requirements

- **FR-001 / AEV-001**: Feature 028 MUST have independent state, tasks,
  evidence, review, and exact-head delivery facts after the G2A merge.
- **FR-002 / AEV-002**: The field run MUST reject then accept the same intended
  untracked delivery file after an explicit whitespace correction while
  excluding ignored and unrelated files.
- **FR-003 / AEV-003**: Exit zero plus `Blocked` or incomplete tasks MUST never
  produce `Completed`.
- **FR-004 / AEV-004**: Explicit Resume MUST revalidate authority, phase,
  tasks, hashes, Git state, and completion evidence without manual repair or
  unnecessary repetition.
- **FR-005 / AEV-005**: Exact-head PreMerge and causal PostMerge evidence MUST
  form one validated, non-recursive lifecycle chain.
- **FR-006 / AEV-006**: Release MUST remain blocked until all candidate,
  field, repository, review, and exact-head gates pass with no Critical/High
  finding.
- **FR-007 / AEV-007**: Canonical scaffold and publication copy MUST remain
  byte-identical; the public repository MUST deliver tag and release v0.4.0,
  a versioned ZIP, checksum, and release evidence.
- **FR-008 / AEV-008**: The complete active preset matrix MUST pass add, list,
  info, resolve, disable, enable, remove, reinstall, and command/skill parity.
- **FR-009 / AEV-009**: Consumer scope MUST be derived dynamically from the
  current registry and active profiles; collections remain separate.
- **FR-010 / AEV-010**: Consumer diffs MUST contain only preset adoption,
  generated parity, and required evidence, never product behavior changes.
- **FR-011 / AEV-011**: Every changed repository MUST converge technical
  checks and actionable threads at the exact head. The authorized narrow
  bypass may replace only Human Approval.
- **FR-012 / AEV-012**: The official community update MUST be submitted
  serially after ZIP proof, use a friendly English description, and mention
  `@mnriem` at most once. External merge is not a local completion gate.
- **FR-013 / AEV-013**: The Feature-038 workitem MUST become `Implemented` and
  bind feature, field, preset, release, ZIP, fleet, and community evidence.
- **FR-014 / AEV-014**: Successful closeout MUST archive G2A/G2B, restore the
  previous Series topology, and mark Position 7 as the sole preferred
  candidate without starting it.

## Governance Applicability

- **Security Governance**: Applicable to integrity, path, permission, release,
  supply-chain, and secret boundaries. NIST SSDF and CWE Top 25 apply. SBOM,
  VEX, SLSA/OpenSSF, and regulatory applicability are documented for the
  released preset. ASVS and AI-SBOM are `N/A`: no web/auth service or runtime
  AI component is shipped. Re-evaluate on runtime/service scope.
- **Architecture and iSAQB**: Applicable to evidence lifecycle and distribution
  boundaries. STRIDE/CIA applies to integrity and authority. CAPEC, Zero Trust,
  arc42 runtime views, BSI C3A/C5, cloud deployment, and distributed CAP are
  `N/A`; re-evaluate on service/provider topology changes.
- **A11Y**: Applicable to bilingual DE-first/EN-second documentation, CEFR B2,
  explained terminology, text-first evidence, and WCAG 2.2 AA where relevant.
- **Cross-Platform**: Applicable; Bash and PowerShell parity is mandatory on
  Ubuntu, macOS, and Windows.
- **Agent Parity**: Applicable to generated commands/skills and consumer
  guidance. Existing command count remains five.
- **Intake Authoring, Review, and Sequencing**: Applicable to accepted G2B
  input and final Series closeout; no preset implementation changes.
- **Autonomous Run**: Product under validation and release.
- **Parallel Autonomous**: Regression/composition only; no campaign authority.
- **Model Routing**: Applicable to semantic phase and Resume field evidence;
  concrete model names remain machine-local.

## Key Entities

- **Field Attempt**: One controlled invocation and its immutable inputs,
  outcome, task totals, hashes, and proof boundary.
- **Release Artifact**: Tagged preset source, GitHub ZIP, checksum, release
  metadata, and composition result.
- **Consumer Record**: Registered target, profile applicability, exact head,
  PR/check/review/merge/sync state, or explicit exclusion/blocker.
- **Lifecycle Chain**: Exact-head PreMerge evidence plus causal PostMerge proof.
- **Series Closeout**: Archived G2 manifests and restored 32/3/36 topology.

## Success Criteria

- **SC-001 / AC-AEV-001**: All three AR-038 findings are independently
  reproduced and closed without product behavior changes.
- **SC-002 / AC-AEV-002**: No exit-zero `Blocked` or incomplete result is ever
  represented as `Completed`.
- **SC-003 / AC-AEV-003**: Exactly one authority- and hash-bound Resume path
  succeeds without manual state repair or repeated trustworthy work.
- **SC-004 / AC-AEV-004**: PreMerge and PostMerge snapshots pass Bash and
  PowerShell validation as one non-recursive chain.
- **SC-005 / AC-AEV-005**: v0.4.0 and its versioned ZIP install successfully;
  checksum and release metadata are recorded.
- **SC-006 / AC-AEV-006**: Every dynamically applicable consumer has a merged
  update or an explicit blocker; no registered target is silently omitted.
- **SC-007 / AC-AEV-007**: Every reported merge has green technical gates,
  zero actionable threads, and exact-head evidence.
- **SC-008 / AC-AEV-008**: The workitem is `Implemented`; G2A/G2B are archived;
  Position 7 is sole preferred `Eligible`; no follow-up run starts.

## Documentation Impact

Decision: `UpdateRequired` plus `GeneratedUpdate`. Update the preset release
documentation, field-validation summary, workitem, fleet evidence, Series,
repository statistics, and generated consumer agent surfaces. Audiences are
operators, maintainers, learners, and application developers. Canonical owner
is the autonomous preset maintainer. Language is DE-first/EN-second; public
release documents may use synchronized English sections. Distribution changes
from `sourceOnly` to tagged preset, applicable consumers, and public catalog
submission. Home Runtime sync is required only if manifest-bound installed
surfaces change. Re-evaluate on contract, profile, provider, or consumer drift.

## Assumptions and Boundaries

- G2A PR #241 and causal closeout PR #242 are merged and current.
- Current explicit authority is `MergeAndSync` with narrow Human-Approval-only
  bypass after all technical gates and actionable threads converge.
- Existing scripts, package managers, GitHub CLI authentication, and repository
  rulesets remain available; no secret is copied into evidence.
- A consumer with no applicable diff receives no empty PR.
- External catalog merge is not required for local completion.
- Position 7 is reported but never started by Feature 028.
