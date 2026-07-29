# Security Requirements Checklist: Agentic-Workspace-Wartungs-TUI

**Purpose**: Test security requirement completeness before planning
**Created**: 2026-07-29

## Trust and Input Boundaries

- [x] CHK001 Is the ownership boundary between presentation and maintenance
  operations explicit? [Clarity, Spec FR-009]
- [x] CHK002 Are typed process arguments and prohibited dynamic evaluation
  stated consistently? [Completeness, Spec FR-010]
- [x] CHK003 Are paths, remotes and untrusted messages covered by a markup
  sanitization requirement? [Coverage, Spec FR-028]
- [x] CHK004 Are canonical engine path checks preserved without a weaker
  parallel validator? [Consistency, Spec FR-029]

## Data, Secrets and Local Evidence

- [x] CHK005 Are prohibited secret and credential inputs named?
  [Completeness, Spec FR-027]
- [x] CHK006 Are event, cache and temporary file access boundaries explicit?
  [Completeness, Spec FR-028]
- [x] CHK007 Are environment inheritance and sensitive diagnostic output
  bounded? [Coverage, Spec FR-027–FR-029]
- [x] CHK008 Is append-only event evidence separated from canonical atomic
  completion evidence? [Consistency, Spec FR-011–FR-017]

## Dependencies and Supply Chain

- [x] CHK009 Are package versions, lock enforcement, license, source and
  vulnerability evidence specified? [Completeness, Spec FR-021]
- [x] CHK010 Are SBOM and VEX applicability distinguished from AI-SBOM and
  release-only controls? [Clarity, Spec GR-001]
- [x] CHK011 Is later dependency updating outside this feature's implicit
  authority? [Scope, Spec Assumptions and FR-021]

## Authority and Recovery

- [x] CHK012 Is confirmation separated from repository, provider, cleanup and
  administrator authority? [Clarity, Spec FR-034]
- [x] CHK013 Are first and second cancellation boundaries non-destructive?
  [Coverage, Spec FR-030]
- [x] CHK014 Is implicit retry after engine failure prohibited?
  [Recovery, Spec FR-032]
- [x] CHK015 Are STRIDE/CIA/CAPEC and applicable trust boundaries declared?
  [Completeness, Spec GR-002]
