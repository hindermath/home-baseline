# Feature Specification: Requirements Intake Consolidation Governance

**Feature Branch**: `014-requirements-intake-consolidation-governance`  
**Binding Intake**: `Lastenheft_Requirements-Intake-Konsolidierungs-Governance.md`  
**Delivery Mode**: `MergeAndSync`

## Purpose and Audience

Learners from the first training year and maintainers need one traceable,
language-aware requirements model that does not treat German artifact names as
universal technical constants. The feature coordinates three existing presets
and proves the resulting contract in seven different repositories.

## User Scenarios

### US1 - Inspect an existing repository read-only

A learner or maintainer receives exactly `Aligned`, `MigrationRequired`,
`NeedsClarification`, or `Blocked`, the resolved artifact roles, and a
text-oriented next action without changing files.

### US2 - Migrate with explicit authority

A maintainer grants bounded update authority. The migration updates all
dependent references atomically and records before/after hashes. A partial
failure rolls back or ends truthfully as `NeedsRepair`.

### US3 - Review and sequence

A reviewer validates language, roles, paths, hashes, receipts, dependencies,
and exactly one `Eligible` candidate. Eligibility expresses order only and
never grants implementation or remote authority.

### US4 - Adopt without changing product meaning

Seven pilot repositories preserve requirements content, product code, history,
default-branch rules, and project-specific constraints while adopting the
portable contract through separate non-empty pull requests.

## Functional Requirements

- **FR-001** Define schema 2.0 at
  `requirements/intake-governance-config.json`.
- **FR-002** Treat `documentationLanguage` as BCP-47 and keep it independent
  from implementation language and operating-system locale.
- **FR-003** Resolve deterministic `de`, `en`, and explicit naming profiles.
- **FR-004** Resolve `requirements-index`, `requirements-intake`,
  `intake-order`, and `requirements-baseline` as language-neutral roles.
- **FR-005** Resolve separate baseline, active, archive, backlog, history, and
  series paths.
- **FR-006** Treat bounded legacy names as aliases, not second canonical
  structures.
- **FR-007** Derive inventory counts from files and manifests.
- **FR-008** Extend existing status with the four accepted read-only outcomes.
- **FR-009** Extend existing update with an authorized atomic migration and
  operations journal.
- **FR-010** Roll back partial migration or persist `NeedsRepair`.
- **FR-011** Extend review with language, role, resolved-path, hash, and
  reference checks.
- **FR-012** Extend series status and next selection with resolved paths and
  exactly one evidenced `Eligible` candidate.
- **FR-013** Preserve the distinction between eligibility and delivery
  authority.
- **FR-014** Preserve historical and archived artifacts without explicit need.
- **FR-015** Upgrade exactly Intake Authoring to `0.3.0`, Intake Review to
  `0.2.0`, and Intake Sequencing to `0.2.0`.
- **FR-016** Preserve existing command IDs and one generated surface per agent.
- **FR-017** Deliver separate non-empty migration PRs for TuiVision, TinyCalc,
  TinyPl0, home-baseline-source, InventarWorkerService, cc65, and
  absdd-image-sandbox.
- **FR-018** Preserve product code, requirements meaning, non-MSL rationale,
  upstream-fork boundaries, and security evidence in the pilots.
- **FR-019** Publish and ZIP-validate the three preset releases.
- **FR-020** Distribute only the preset versions to all other registered
  profiles.
- **FR-021** Submit catalog updates serially and address `@mnriem` at most once.
- **FR-022** Archive Feature 014 after closeout, restore the six prior roots,
  and identify Windows hardening as next without starting it.

## Edge Cases

- Ambiguous or unsupported documentation language blocks writes.
- A target or case-only collision blocks rename.
- Mixed prefixes or duplicate canonical indexes block acceptance.
- Stale hashes, links, prompts, or receipts block migration success.
- Multiple `Eligible` targets block series acceptance.

## Governance Applicability

- Security 0.6.1 applies to input/path validation, secrets, exact-head and
  supply-chain evidence. Product ASVS, SBOM, VEX, SLSA, AI-SBOM and regulatory
  screening are `N/A` unless product scope changes.
- Architecture 0.5.1 and iSAQB 0.2.1 apply to atomicity, rollback, and failure
  quality scenarios. Product/cloud architecture including C3A/C5 is `N/A`.
- A11Y 0.4.2 applies to DE-first/EN-second, CEFR B2, first-use terminology,
  text-first CLI/documentation, and WCAG 2.2 AA.
- Cross-Platform 0.2.1 applies to Bash/PowerShell parity, stable errors,
  manpages, and bilingual PowerShell help.
- Agent Parity 0.4.1 applies to generated commands and shared guidance.
- Intake Authoring, Review, and Sequencing are directly changed.
- Autonomous 0.3.3 applies to authority, state, gates, delivery, and closeout.
- Parallel Autonomous 0.2.4 is composition-tested but not executed.

## Success Criteria

- **SC-001** All 22 requirements have task and evidence coverage.
- **SC-002** Positive and negative fixtures produce equivalent Bash and
  PowerShell outcomes.
- **SC-003** All eleven presets compose and every command/skill appears once.
- **SC-004** Seven pilot PRs merge without product or requirements-content
  drift.
- **SC-005** Three releases install from immutable GitHub ZIPs with checksums.
- **SC-006** Every registered profile resolves the new versions; only seven
  pilots contain a requirements migration.
- **SC-007** No Critical/High finding, actionable thread, ambiguous language,
  partial migration, or multiple-Eligible state remains.
- **SC-008** Feature 014 closes on synchronized `main`, restores six roots,
  names Windows hardening next, and starts no successor.

## Clarifications

No material ambiguity remains after two focused passes. Versions, pilot scope,
language profiles, MergeAndSync authority, bypass limits, and closeout are
explicit.
