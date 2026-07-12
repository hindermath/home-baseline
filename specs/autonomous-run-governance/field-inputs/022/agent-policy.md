# Autonomous Closeout and Duplicate-run Field Policy

Feature 022 synchronized the following policy across `AGENTS.md`, `CLAUDE.md`,
`GEMINI.md`, `.github/copilot-instructions.md`, and
`.github/agents/copilot-instructions.md` at TuiVision main commit
`3329e59f222e05141f464f75a6fcf2c01ad83448`.

> Keep a causal closeout evidence-only and single-commit-capable: do not require
> its own PR URL, reviewed-head result, or merge commit inside that same
> repository file; verify terminal facts externally without recursive closeout.

> When push and pull-request events create equivalent workflow sets, use
> pull-request-context checks as the gate and record duplicate runs as noise;
> cancel them only under an explicit safe workflow/concurrency contract.

The 022 closeout proved the first rule with one commit. Feature, closeout, and
retrospective PRs exposed equivalent push/PR workflow sets and used the PR
context as the gate without cancelling required evidence. Portable preset work
must preserve both rules without granting remote write, cancellation, merge, or
bypass authority.
