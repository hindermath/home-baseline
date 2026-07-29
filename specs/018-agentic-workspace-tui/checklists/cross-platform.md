# Cross-Platform Requirements Checklist: Agentic-Workspace-Wartungs-TUI

**Purpose**: Test Bash, PowerShell and platform requirement parity
**Created**: 2026-07-29

## Invocation Parity

- [x] CHK001 Are Bash and PowerShell UI selectors paired and equivalent?
  [Consistency, Spec FR-004]
- [x] CHK002 Is the existing headless contract preserved on both wrappers?
  [Completeness, Spec FR-001–FR-005]
- [x] CHK003 Is the platform-specific equivalent command explanatory only?
  [Clarity, Spec FR-010]

## Platform and Cache Identity

- [x] CHK004 Are operating-system and architecture boundaries part of cache
  identity? [Completeness, Spec FR-019]
- [x] CHK005 Are macOS, Ubuntu and Windows required at acceptance?
  [Coverage, Spec SC-007]
- [x] CHK006 Are Bash 3.2 and PowerShell 7 compatibility included?
  [Dependency, Spec FR-033]

## Help, Preview and Fallback

- [x] CHK007 Are Dry-run and WhatIf semantically equivalent?
  [Consistency, Spec FR-006]
- [x] CHK008 Are Unix manpage and bilingual PowerShell help updates required?
  [Completeness, Spec FR-035 and GR-005]
- [x] CHK009 Does a missing .NET prerequisite preserve a safe platform-native
  plaintext path? [Recovery, Spec FR-020]

## Evidence

- [x] CHK010 Are platform gates required for the exact delivery candidate?
  [Measurability, Spec SC-007 and SC-012]
- [x] CHK011 Are wrapper and Feature 015-017 regressions included?
  [Coverage, Spec FR-033]
- [x] CHK012 Is a missing platform result missing evidence rather than an
  implicit pass? [Governance, Spec GR-005 and SC-007]
