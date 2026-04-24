# Spec Kit Issue 2362 Response Playbook

## Purpose

This note contains short response templates for possible maintainer replies to
`github/spec-kit` issue `#2362`.

Issue:
- https://github.com/github/spec-kit/issues/2362

Comment:
- https://github.com/github/spec-kit/issues/2362#issuecomment-4316686990

## Template A: Positive Interest

Use this when maintainers signal that the direction is interesting and they are
open to a follow-up PR.

```md
Thanks, that helps.

I will keep the follow-up intentionally small and reviewable.

Based on your feedback, I’ll prepare a reduced proposal with:

- one small constitution/guidance addition
- one compact shared agent-guidance block
- one or two starter templates only

I’ll also include a concrete file list and manual validation notes aligned to
`CONTRIBUTING.md` so the scope stays easy to evaluate.
```

## Template B: Positive but Preset/Extension-Oriented

Use this when maintainers like the idea but prefer it outside the default core
distribution.

```md
That makes sense.

I agree this seems better aligned with the preset/template-catalog direction
than with default core behavior.

In that case, I’ll treat this as an opt-in package and narrow the next proposal
accordingly:

- minimal shared guidance only
- a very small starter template set
- no assumption that this should become the default workflow

If useful, I can come back with a preset-shaped proposal rather than a broader
core change.
```

## Template C: Narrow It Further

Use this when maintainers ask for a smaller first step or a more concrete
starting point.

```md
Understood.

I’ll reduce the proposal to the smallest useful slice first.

A reasonable first step from my side would be one of:

- a single `threat-model` starter template
- a single `security-checklist` starter template
- one compact shared guidance addition without extra templates

I’ll pick one narrow option and keep the PR focused on that single step.
```

## Template D: Documentation-First

Use this when maintainers want guidance or documentation before any new
templates or behavior.

```md
That sounds reasonable.

I can frame this as documentation/guidance first and avoid introducing a larger
template bundle up front.

If I follow up, I’ll bias toward:

- a small documentation-oriented change
- minimal agent guidance
- no broad policy expansion unless it proves clearly useful
```

## Template E: Not a Fit for Core

Use this when maintainers indicate the idea is too opinionated or not a good
match for the main project.

```md
Thanks for the clear guidance.

That makes sense, and I won’t push this as a core change.

I’ll keep the broader governance bundle external and, if appropriate, shape it
as an independent preset or organizational add-on instead of continuing in the
main repository.

Appreciate the feedback.
```

## Template F: Link to Existing Work

Use this when maintainers redirect the discussion to another issue, especially a
preset/template-catalog thread.

```md
Thanks, that pointer is helpful.

I’ll continue the discussion in the linked thread so the design conversation
stays in one place.

I’ll also adapt the proposal to that context and keep the scope aligned with the
existing preset/template direction rather than treating it as a standalone core
request.
```

## Notes

- Prefer short comments over long restatements.
- Do not argue for a broad core merge if maintainers explicitly steer toward
  presets, extensions, or external solutions.
- If maintainers show interest, propose the smallest evaluable slice first.
- If they ask for a PR, reference `CONTRIBUTING.md` and include manual test
  coverage expectations in the next step.
