# Retrospective: Feature 027

## Decision

`PresetFollowUp`

## Observation

The three reported evidence-integrity gaps were reproducible and could be
closed provider-neutrally with one shared validation core, thin Bash and
PowerShell entrypoints, structured phase results, and lifecycle-bound gate
snapshots. The explicit delivery-set validator found one real trailing-
whitespace defect in this feature before staging.

## Portable Learning

- Exit code zero is process evidence, not semantic completion evidence.
- Intended untracked files must be named before staging; unrelated untracked
  files remain visible but outside the delivery set.
- A merge decision requires exact-head PreMerge evidence. PostMerge facts are
  causal evidence and must not be projected backward into the reviewed head.
- Historical schemas need an explicit audit-only mode so compatibility cannot
  silently grant current delivery authority.

## Promotion Boundary

The source candidate is ready for independent field validation, not release.
G2B owns real-run validation, publication repository delivery, tag and ZIP
checks, consumer adoption, fleet rollout, catalog follow-up, and the final
promotion decision. No empty retrospective branch or separate PR is required.

## Project-Specific Exclusions

Home Baseline statistics rendering, repository branch rules, the current
admin-bypass authority, and the active intake Series are field evidence, not
portable preset defaults.
