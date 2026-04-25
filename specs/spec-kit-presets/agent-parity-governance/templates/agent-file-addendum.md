## Agent Parity Governance Agent Guidance

- Treat shared agent guidance as a single logical document with multiple
  physical surfaces (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md`, plus any project-specific
  surfaces).
- Never update one of these files in isolation when the change affects
  shared rules. If you find yourself editing only one, stop and update
  the others in the same change.
- When propagating a shared rule, also update the relevant project
  templates under `.specify/templates/` and `.specify/memory/constitution.md`.
- Document every intentional deviation: which surface deviates, what it
  deviates from, why, and the expected lifetime of the deviation.
- Document every `N/A` decision with rationale; never silently omit.
- Use `agent-parity-checklist-template` as the standard verification
  artefact for shared-guidance changes.
