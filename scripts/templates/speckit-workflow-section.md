## Spec-kit-Workflow

Neue Features in diesem Workspace werden nach dem **Specification-Driven Development (SDD)**-Workflow entwickelt.
Der Workflow verwendet das `speckit`-CLI-Tool (GitHub Copilot Skill).

Schritte für ein neues Feature:

1. **Spezifikation erstellen** — `speckit specify "Feature-Name"` → `specs/{branch}/spec.md`
2. **Klärungsfragen** — `speckit clarify` → offene Fragen in `spec.md` beantworten
3. **Implementierungsplan** — `speckit plan` → `specs/{branch}/plan.md`
4. **Aufgabenliste** — `speckit tasks` → `specs/{branch}/tasks.md`
5. **Implementieren** — `speckit implement` → Aufgaben aus `tasks.md` abarbeiten
6. **Validieren** — `bash scripts/check-homogeneity.sh` → Compliance-Score prüfen

Alle Spec-Artefakte werden im Branch-Verzeichnis `specs/{branch}/` gespeichert und versioniert.

### Governance-Presets

Für Level-2-Projekte können Spec-Kit-Governance-Presets installiert werden.
Das Standard-Set dieser Workspace-Familie ist:

- `security-governance` v0.3.0, Priority 10
- `architecture-governance` v0.2.0, Priority 20
- `isaqb-architecture-governance` v0.1.0, Priority 30
- `a11y-governance` v0.2.0, Priority 40
- `cross-platform-governance` v0.1.0, Priority 50
- `agent-parity-governance` v0.1.0, Priority 60

Alle sechs Presets sind seit 2026-05-04 im `github/spec-kit`
Community-Katalog enthalten. C#/.NET-Level-2-Projekte verwenden
standardmäßig alle sechs Presets, sofern keine begründete Ausnahme dokumentiert
ist. Nach Installation oder Update prüfen: `specify preset list`,
`specify preset info <id>` und bei Template-Fragen `specify preset resolve
<template>`. `.specify/presets/` wird committed, `.specify/presets/.cache/`
nicht.

---

## Spec-kit Workflow

New features in this workspace are developed following the **Specification-Driven Development (SDD)** workflow.
The workflow uses the `speckit` CLI tool (GitHub Copilot Skill).

Steps for a new feature:

1. **Create specification** — `speckit specify "Feature Name"` → `specs/{branch}/spec.md`
2. **Clarification questions** — `speckit clarify` → answer open questions in `spec.md`
3. **Implementation plan** — `speckit plan` → `specs/{branch}/plan.md`
4. **Task list** — `speckit tasks` → `specs/{branch}/tasks.md`
5. **Implement** — `speckit implement` → work through tasks in `tasks.md`
6. **Validate** — `bash scripts/check-homogeneity.sh` → check compliance score

All spec artefacts are stored and versioned in the branch directory `specs/{branch}/`.

### Governance Presets

Level-2 projects can install Spec-Kit governance presets. The standard set for
this workspace family is:

- `security-governance` v0.3.0, priority 10
- `architecture-governance` v0.2.0, priority 20
- `isaqb-architecture-governance` v0.1.0, priority 30
- `a11y-governance` v0.2.0, priority 40
- `cross-platform-governance` v0.1.0, priority 50
- `agent-parity-governance` v0.1.0, priority 60

All six presets are included in the `github/spec-kit` community catalog as of
2026-05-04. C#/.NET Level-2 projects default to all six presets unless a
justified exception is documented. After install or update, verify with
`specify preset list`, `specify preset info <id>`, and for template questions
`specify preset resolve <template>`. Commit `.specify/presets/`, but not
`.specify/presets/.cache/`.
