# Agent Parity Governance Preset

Version: `0.1.0`
Requires: `spec-kit >= 0.8.0` (uses the `wrap` and `append` composition
strategies introduced in 0.8.x).

Purpose:

- prevent silent process drift between AI-agent guidance files
- enforce that shared rules land atomically across `AGENTS.md`,
  `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`

Primary source chapter from `home-baseline` constitution:

- `IX. Four-Agent Guidance Parity & Template Synchronization`

What it covers:

- mandatory list of maintained agent surfaces (extensible per project)
- atomic-change discipline (one change → all surfaces)
- propagation into project templates and `.specify/memory/constitution.md`
- explicit documentation of intentional deviations
- parity-verification artefact (`agent-parity-checklist-template`)

Preset strategy:

- append parity governance to `constitution-template`, `spec-template`,
  `plan-template`, `tasks-template`, and `agent-file-template`
- wrap `speckit.specify`, `speckit.plan`, and `speckit.tasks` with a
  shared parity workflow
- provide a parity checklist starter

When to use:

- any project that maintains more than one AI-agent guidance file
- any team that wants atomic, auditable changes to shared agent
  instructions
- any project where AI-agent surfaces are part of the contributor
  contract

When not to use:

- projects with only one agent guidance file and no plans to add another
- one-off prototypes without long-term agent contributors

Recommended standalone install priority:

- `40`
