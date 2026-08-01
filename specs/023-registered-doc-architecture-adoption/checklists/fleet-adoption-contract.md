# Fleet Adoption Contract Checklist

**Purpose**: Unit-test D7 fleet and delivery requirements before planning
**Created**: 2026-08-01
**Feature**: [spec.md](../spec.md)

## Fleet Identity And Preflight

- [x] CHK001 Does the target set come from the current manifest and validated registry?
- [x] CHK002 Must every reachable remote be fetched before the first target mutation?
- [x] CHK003 Does one target failure leave the remaining inventory running?
- [x] CHK004 Are Git and collection targets classified separately?
- [x] CHK005 Are all unsafe branch/worktree/upstream states mutation-blocking?
- [x] CHK006 Is safe pull limited to an unambiguous clean behind-only default branch?

## Adoption Decisions

- [x] CHK007 Does every target receive exactly one primary final decision?
- [x] CHK008 Is every adoption linked to one Feature-022 claim?
- [x] CHK009 Is target-specific applicability required before editing?
- [x] CHK010 Are already-aligned and not-applicable decisions distinct?
- [x] CHK011 Is project-specific terminology allowed to satisfy an equivalent rule?
- [x] CHK012 Are blocked targets given a reason and exact next action?

## Documentation Boundaries

- [x] CHK013 Are Level-0 paths and Home Runtime classes forbidden without semantic equivalence?
- [x] CHK014 Are reader-path counts repository-specific rather than fixed at four?
- [x] CHK015 Are root README and language changes finding-driven?
- [x] CHK016 Are generated files changed only through canonical sources?
- [x] CHK017 Are archived and historical evidence contents read-only?
- [x] CHK018 Are learning, sandbox, non-MSL and product boundaries preserved?
- [x] CHK019 Is technical propagation scope explicitly unchanged?
- [x] CHK020 Is maintenance-package runtime drift excluded from automatic repair?

## Evidence And Delivery

- [x] CHK021 Does every changed target require one complete Documentation Impact record?
- [x] CHK022 Are shared fleet evidence writers serialized?
- [x] CHK023 Are non-empty target branches and PRs required only for real changes?
- [x] CHK024 Does exact-head drift invalidate earlier review evidence?
- [x] CHK025 Are command and runner tokens required beyond provider check names?
- [x] CHK026 Is admin bypass limited to the accepted Human-Approval condition?
- [x] CHK027 Does final reporting distinguish all four target outcomes?
- [x] CHK028 Is preset promotion evidence reproducibility-gated?

## Accessibility And Completion

- [x] CHK029 Are language, CEFR B2, terminology and WCAG rules repository-aware?
- [x] CHK030 Do status, decisions and dependencies remain text-first?
- [x] CHK031 Must all changed repositories return clean and synchronized?
- [x] CHK032 Must Level 0 finish clean at `HEAD == origin/main`?
- [x] CHK033 Is automatic successor-intake execution prohibited?

## Result

All 33 contract checks pass. The live preflight findings fit the defined
`Blocked` and out-of-scope evidence boundaries and do not require scope change.
