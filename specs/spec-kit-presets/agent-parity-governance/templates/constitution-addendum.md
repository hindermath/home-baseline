## Four-Agent Guidance Parity

### Mandate

Shared AI-agent guidance is only valid when all maintained agent surfaces
stay aligned. Divergent agent instructions create silent process drift
where one tool follows a rule another tool ignores.

### Maintained agent surfaces

The four standard surfaces are:

- `AGENTS.md` — for Codex and Codex-like agents
- `CLAUDE.md` — for Claude Code
- `GEMINI.md` — for Gemini Code Assist
- `.github/copilot-instructions.md` — for GitHub Copilot

A project MAY maintain additional agent surfaces (e.g. `.cursorrules`,
`.windsurfrules`, `JUNIE.md`). Any additional surface MUST be listed in
the local constitution as part of the parity set.

### Mandatory rules

- Shared operational rules MUST NOT be updated in only one of the
  maintained agent files.
- Any intentional deviation between surfaces MUST be documented
  explicitly in the same change that introduces it (where it deviates
  and why).
- Shared rules MUST also be propagated to:
  - the relevant project templates under `.specify/templates/`
  - `.specify/memory/constitution.md`
- Runtime guidance text MUST name all maintained agent surfaces — never
  list only one or two.

### Atomic change discipline

A single pull request or commit that touches shared agent guidance MUST
include all maintained surfaces. Splitting parity changes across multiple
commits is allowed only if the splitting itself is part of an explicit
migration plan recorded in the change.

### Evidence

- Default location for parity-evidence artefacts: project root
  (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md`).
- A `agent-parity-checklist` SHOULD be filed for changes that touch
  shared guidance — see `agent-parity-checklist-template`.
