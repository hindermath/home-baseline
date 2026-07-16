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

Für MSL-Level-2-Projekte werden Spec-Kit-Governance-Presets aus der zentralen
Matrix `scripts/config/spec-kit-governance-presets.json` installiert. Das
Standard-Set dieser Workspace-Familie ist:

| Preset-ID | Name | Version | Priorität |
|---|---|---:|---:|
| `security-governance` | Security Governance | `v0.6.0` | `10` |
| `architecture-governance` | Architecture Governance | `v0.5.0` | `20` |
| `isaqb-architecture-governance` | iSAQB Architecture Governance | `v0.2.0` | `30` |
| `a11y-governance` | A11Y Governance | `v0.4.0` | `40` |
| `cross-platform-governance` | Cross-Platform Governance | `v0.2.0` | `50` |
| `agent-parity-governance` | Agent Parity Governance | `v0.3.0` | `60` |

Für ausdrücklich delegierte vollständige Läufe kann optional
`autonomous-run-governance` v0.2.2 mit Priorität `70` über
`scripts/config/spec-kit-autonomous-governance-presets.json` ergänzt werden.
Die Standard-Sechsermatrix bleibt unverändert. `LocalImplementation` ist der
sichere Default; Installation erteilt keine Remote-, Merge- oder Bypass-Rechte.
`speckit.autonomous-status` prueft einen Lauf read-only,
`speckit.autonomous-stop` pausiert kooperativ am naechsten sicheren Grenzpunkt,
und `speckit.autonomous-resume` ist fuer `PausedByUser` verpflichtend. Ein
gespeicherter Delivery-Modus ist keine aktuelle Berechtigung. Nach Preset- oder
Governance-Drift werden neue zwingende Korrektheits-, Sicherheits-,
Berechtigungs- und Evidenzregeln minimal mit akzeptierten Plan-, Task- und
Checklist-Artefakten abgeglichen; Effizienzpraeferenzen loesen keine
rueckwirkende Neugenerierung aus.

Alle sechs Presets sind seit 2026-05-04 im `github/spec-kit`
Community-Katalog enthalten. C#/.NET- und Lern-Level-2-Projekte verwenden
standardmäßig alle sechs Presets, sofern keine begründete Ausnahme dokumentiert
ist. Nach Installation oder Update prüfen: `specify preset list`,
`specify preset info <id>` und bei Template-Fragen `specify preset resolve
<template>`. `.specify/presets/` wird committed, `.specify/presets/.cache/`
nicht. Alle sechs Presets erzeugen oder verlangen audit-ready Spec-Kit-Run-Evidenz mit `Applicable` / `N/A` / `Open`, Begruendung, Evidenzpfad, Reviewer, Restrisiko und Follow-up.
Bei jeder Preset-Version oder Prioritätsänderung zuerst die zentrale Matrix
aktualisieren und danach README-Tabellen, Constitution, Agenten-Dateien und
Templates gemeinsam prüfen.

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

MSL level-2 projects install Spec Kit governance presets from the central matrix
`scripts/config/spec-kit-governance-presets.json`. The standard set for this
workspace family is:

| Preset ID | Name | Version | Priority |
|---|---|---:|---:|
| `security-governance` | Security Governance | `v0.6.0` | `10` |
| `architecture-governance` | Architecture Governance | `v0.5.0` | `20` |
| `isaqb-architecture-governance` | iSAQB Architecture Governance | `v0.2.0` | `30` |
| `a11y-governance` | A11Y Governance | `v0.4.0` | `40` |
| `cross-platform-governance` | Cross-Platform Governance | `v0.2.0` | `50` |
| `agent-parity-governance` | Agent Parity Governance | `v0.3.0` | `60` |

For explicitly delegated complete runs, optionally add
`autonomous-run-governance` v0.2.2 at priority `70` through
`scripts/config/spec-kit-autonomous-governance-presets.json`. The standard
six-preset matrix remains unchanged. `LocalImplementation` is the safe default;
installation grants no remote, merge, or bypass authority.
`speckit.autonomous-status` inspects a run read-only,
`speckit.autonomous-stop` pauses cooperatively at the next safe boundary, and
`speckit.autonomous-resume` is mandatory for `PausedByUser`. A recorded delivery
mode is not current authority.
After preset or governance drift, new mandatory correctness, security,
permission, and evidence-integrity rules are minimally reconciled with accepted
Plan, Tasks, and checklist artifacts; efficiency preferences do not trigger
retroactive regeneration.

All six presets are included in the `github/spec-kit` community catalog as of
2026-05-04. C#/.NET and learning level-2 projects default to all six presets
unless a justified exception is documented. After install or update, verify with
`specify preset list`, `specify preset info <id>`, and for template questions
`specify preset resolve <template>`. Commit `.specify/presets/`, but not
`.specify/presets/.cache/`. All six presets produce or require audit-ready Spec-Kit run evidence with `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up.
For every preset version or priority change, update the central matrix first,
then review README tables, constitution, agent guidance files, and templates
together.
