# Autonomous Validation Field Policy

Feature 023 synchronized the following policy across `AGENTS.md`, `CLAUDE.md`,
`GEMINI.md`, `.github/copilot-instructions.md`, and
`.github/agents/copilot-instructions.md` at TuiVision main commit
`47d64599f1e65f40aa1c830f51f7b97d85235637`.

> One manual build-counter increment covers exactly one explicit build or test
> invocation. Multiple invocations must not be chained behind one increment.

> Repository validation helpers receive an explicit repository root. A pass
> requires the expected exit status and an error channel without PowerShell
> error records, command-not-found messages, or equivalent fatal signatures.

The TuiVision build-counter implementation is project-specific. The portable
rule is the one-to-one relationship between a mutable validation token and the
operation it authorizes. The helper rule is provider-neutral: orchestration
must inspect structured failure signals instead of trusting one nominal exit
code. Neither rule grants permission to run, publish, or merge work.
