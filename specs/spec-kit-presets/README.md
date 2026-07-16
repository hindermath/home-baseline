# Spec Kit Preset Scaffolds

This directory contains local scaffolds for the six standard Spec Kit
governance presets plus one optional autonomous-delivery preset derived from
the `home-baseline` governance work.

Target split:

- `security-governance` — version `0.6.0`
- `architecture-governance` — version `0.5.0`
- `isaqb-architecture-governance` — version `0.2.0`
- `a11y-governance` — version `0.4.0`
- `cross-platform-governance` — version `0.2.0`
- `agent-parity-governance` — version `0.3.0`
- optional `autonomous-run-governance` — version `0.2.1`

The standard six presets require `spec-kit >= 0.8.0`. They depend on the
`wrap` and `append` composition strategies introduced in 0.8.x; older
Spec Kit versions cannot apply them. `autonomous-run-governance` requires
`spec-kit >= 0.8.3` and adds five new commands without replacing core commands.

These scaffolds are intentionally kept as separate repo-shaped
directories so they can later be moved into independent public GitHub
repositories for the Spec Kit community catalog.

Recommended future repository names:

- `hindermath/spec-kit-preset-security-governance`
- `hindermath/spec-kit-preset-isaqb-architecture-governance`
- `hindermath/spec-kit-preset-architecture-governance`
- `hindermath/spec-kit-preset-a11y-governance`
- `hindermath/spec-kit-preset-agent-parity-governance`
- `hindermath/spec-kit-preset-cross-platform-governance`
- `hindermath/spec-kit-preset-autonomous-run-governance`

Source material in `home-baseline`:

- `constitution.md` principles `II`, `VII`, `VIII`, `IX`, `XI`–`XIX`
- `.specify/templates/`
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`
- `.github/copilot-instructions.md`
- `docs/security/`

Coverage by principle:

| Principle | Title | Preset |
|-----------|-------|--------|
| II | Cross-Platform Parity & Documentation | `cross-platform-governance` |
| VII | `Programmierung #include<everyone>` | `a11y-governance` |
| VIII | DE-First / EN-Second Bilingual Delivery | `a11y-governance` |
| IX | Agent Guidance Parity & Template Synchronization | `agent-parity-governance` |
| XI | Memory-Safe Languages (MSL) Preference | `security-governance` (architectural constraint surfaced by `architecture-governance`) |
| XII | Secure Code Generation | `security-governance` |
| General Architecture | iSAQB/CPSA-F and arc42 architecture method | `isaqb-architecture-governance` |
| XIII | Secure Software Architecture | `architecture-governance` |
| XIV | Standards Matrix Applicability | shared (security + architecture) |
| XV | Secure SDLC & Verification Standards | `security-governance` |
| XVI | Supply-Chain Transparency & Build Integrity | `security-governance` |
| XVII | Threat Modeling & Attack Pattern Coverage | `architecture-governance` |
| XVIII | Zero Trust & Security Program Maturity | `architecture-governance` |
| XIX | EU Cyber Resilience Act (CRA) Awareness | `security-governance` |

Principles **not** turned into presets:

- `I. Security-First`, `III. Bootstrap Automation`,
  `IV. Workspace Isolation`, `X. Level-2 Project Environment Addenda`
  are intentionally omitted because they are home-baseline-specific
  (whitelist `.gitignore`, `bootstrap-workspace.*`, level hierarchy)
  rather than generally reusable Spec Kit governance.
- `V. Manual-First Verification` and `VI. Observability & Continuous
  Measurement` are reserved for potential future presets if community
  demand justifies it.

Design goal:

- keep presets small and stackable
- use `append` or `wrap` rather than full replacement
- keep agent guidance shared and agent-agnostic
- split security, general architecture, secure architecture,
  accessibility, agent-parity, and
  cross-platform concerns cleanly

MSL integration:

- `XI. Memory-Safe Languages (MSL)` is treated as primarily a
  `security-governance` concern because it affects implementation-language
  safety defaults and secure-development guidance.
- `isaqb-architecture-governance` covers general software architecture
  and references MSL only if language/runtime choice affects architecture
  constraints.
- `architecture-governance` references MSL where runtime or platform
  decisions are security-relevant architectural constraints.
- `a11y-governance`, `agent-parity-governance`, and
  `cross-platform-governance` do not carry MSL rules.

Current status:

- the six standard presets are published and catalogued
- `autonomous-run-governance` v0.2.2 is the current patch release; it retains
  validated lifecycle state plus explicit status, graceful-stop, and protected
  resume commands, adds a mandatory-rule delta audit for preset drift, provides
  a detailed operating guide, and distinguishes the readable `Deliver` heading
  from canonical `Publish`, `Review`, and `MergeAndSync` run-state stages

Recommended publication order:

1. `security-governance`
2. `isaqb-architecture-governance`
3. `architecture-governance`
4. `a11y-governance`
5. `cross-platform-governance`
6. `agent-parity-governance`
7. optional `autonomous-run-governance`

Recommended install order for stacked use:

```bash
specify preset add security-governance --priority 10
specify preset add architecture-governance --priority 20
specify preset add isaqb-architecture-governance --priority 30
specify preset add a11y-governance --priority 40
specify preset add cross-platform-governance --priority 50
specify preset add agent-parity-governance --priority 60
specify preset add --from https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/archive/refs/tags/v0.2.2.zip --priority 70
```

Notes:

- Lower priority numbers have higher precedence in Spec Kit.
- These presets are designed to complement each other rather than
  compete.
- If stacked, verify effective file resolution with
  `specify preset resolve`.
- Agent guidance is intentionally modelled through standalone
  agent-guidance addendum templates plus wrapped `speckit.*` commands
  because Spec Kit 0.8.x has no core `agent-file-template` base layer to
  append to. The standalone template name follows
  `<preset-prefix>-agent-guidance-addendum-template`; the
  `agent-parity-governance` preset elides the duplicate `agent-` segment
  and uses `agent-parity-guidance-addendum-template`.
