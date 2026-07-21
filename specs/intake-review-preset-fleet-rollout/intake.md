# Intake Review Preset Fleet Rollout

## Goal

Install `intake-review-governance` v0.1.0 at priority 65 in Thorsten's managed
Level-0/Level-1/Level-2 fleet while keeping the public standard matrix at eight
presets.

## Binding Scope

- One Level-0 repository: `home-baseline-source`.
- Seven registered Level-1 and 25 registered Level-2 repositories.
- Three learning-series families: Secure OrderDesk, Secure ServiceHarvester,
  and Secure CaseTracker, each with one coordinator and six language repos.
- Exact profile: `intake-review-nine-governance-presets`.
- Published source: `spec-kit-preset-intake-review-governance` tag `v0.1.0`.

## Requirements

1. Preserve `spec-kit-governance-presets.json` as the public eight-preset
   default and use the separate nine-preset matrix only through explicit fleet
   profile selection.
2. Make the registry default inheritable for future managed repositories and
   fail closed on unknown profiles.
3. Propagate the optional matrix and validate the exact selected profile in
   Bash and PowerShell maintenance flows.
4. Install the nine-preset profile in all 33 repositories without product,
   runtime, dependency, or learner-feature changes.
5. Preserve explicit authority boundaries: installation starts no intake
   review, repair, learner Spec-Kit run, commit, push, PR, merge, or bypass.
6. Keep portable preset/policy/guidance files in learning packages while
   excluding local review result/report evidence, Git data, and remotes.
7. Use non-empty PRs, exact-head validation, current review checks, merge
   commits, branch cleanup, and clean synchronized local `main` branches.

## Acceptance

- 33/33 repositories match the exact nine-preset matrix.
- 21/21 learning-series repositories and 3/3 learning-series families pass.
- `speckit-intake-review`, `speckit-intake-repair`, and
  `speckit-intake-review-status` appear exactly once on each supported agent
  surface.
- Bash/PowerShell syntax and profile behavior agree.
- No empty PR, hidden learner run, product change, dependency change, or
  unreported provider failure occurs.
- Final evidence records every repository, PR, merge, validation, exception,
  and local synchronization result.

## Delivery Authority

Repository changes, commits, pushes, PR creation, review follow-up, merges, and
local synchronization are authorized for Thorsten's repositories. Provider
failures are not technical passes. Any admin bypass remains limited to the
existing exact-head policy and requires no actionable review thread or other
open technical gate.
