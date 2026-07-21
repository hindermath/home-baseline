# Intake Authoring Preset Fleet Rollout

## Goal

Install `intake-authoring-governance` v0.1.0 as an optional preset in Thorsten's
managed Level-0, Level-1, Level-2, and learning-series fleet without changing
the public eight-preset default.

## Binding Scope

- One Level-0 repository: `home-baseline-source`.
- Seven registered Level-1 and 25 registered Level-2 repositories.
- Three learning-series families: Secure OrderDesk, Secure ServiceHarvester,
  and Secure CaseTracker, each with one coordinator and six language repos.
- Exact opt-in profile: `intake-authoring-ten-governance-presets`.
- Published source: `spec-kit-preset-intake-authoring-governance` tag `v0.1.0`.
- Preset priority: 64, directly before Intake Review at priority 65.

## Requirements

1. Preserve the public eight-preset default and existing nine-preset profile.
2. Install exactly ten presets in all 33 managed repositories through the
   explicit fleet profile.
3. Generate exactly one Create and one Create Status command or skill on every
   maintained agent surface without duplicate entries.
4. Preserve repository-specific OpenCode directory conventions.
5. Start no intake review, repair, Specify, Autonomous, Parallel Autonomous,
   learner feature, product build, or remote delivery as a side effect.
6. Validate the package's Bash and PowerShell receipt implementations with the
   same positive and negative fixture suite in every target repository.
7. Keep product code, dependencies, runtime behavior, and learner content
   unchanged; only preset installation, shared workflow guidance, and
   reproducible project statistics are in scope.
8. Deliver non-empty PRs, resolve all actionable review findings, classify
   provider failures explicitly, and synchronize local default branches after
   merge.

## Quality And Governance

- Treat provider Billing or Spending failures as unavailable evidence, never
  as a technical pass.
- Use the narrow owner-authorized admin path only after equivalent exact-head
  validation, zero non-provider failures, and zero actionable review threads.
- Preserve the dirty `cc65` user worktree by using an isolated worktree based
  on `origin/master`.
- Keep the learner hosting and sandbox policies unchanged.

## Acceptance Criteria

- 33/33 repositories match the exact ten-preset matrix.
- 21/21 learning-series repositories across 3/3 families are covered.
- Both receipt validators and the complete fixture suite pass in 32 target
  worktrees plus the Level-0 package source.
- Each supported agent surface exposes exactly two Authoring entries.
- Every PR is merged with a merge commit and has zero unresolved review
  threads.
- Level 0 and 31 normal targets are clean and synchronized; `cc65` has a
  validated `origin/master` while its pre-existing dirty user branch remains
  untouched.

## Delivery Authority

Repository changes, commits, pushes, PR creation, review follow-up, merges, and
local synchronization are authorized for Thorsten's repositories. The known
narrow admin bypass is authorized only for green effective technical gates,
zero actionable threads, and Human Approval or provider-unavailable evidence
as the sole remaining repository rule.
