# Spec Kit Preset Scaffolds

This directory contains local scaffolds for the thirteen-preset standard,
workflow, routing, and optional assurance profiles derived from the
`home-baseline` governance work. Projects opt into the assurance and intake
profiles explicitly.

Target split:

- `security-governance` — version `0.6.2`
- `secure-development-assurance-governance` — version `0.1.0`, optional priority `15`
- `architecture-governance` — version `0.5.2`
- `isaqb-architecture-governance` — version `0.2.2`
- `a11y-governance` — version `0.4.3`
- `cross-platform-governance` — version `0.2.2`
- `agent-parity-governance` — version `0.4.2`
- `model-routing-governance` — version `0.1.4`, priority `61`
- `intake-authoring-governance` — version `0.3.1`, optional priority `64`
- `intake-review-governance` — version `0.2.1`, optional priority `65`
- `intake-sequencing-governance` — version `0.2.3`, optional priority `66`
- `autonomous-run-governance` — version `0.4.1`
- `parallel-autonomous-run-governance` — version `0.2.6`

The standard eight-preset profile requires `spec-kit >= 0.8.3`.
The original six presets depend on the `wrap` and `append` composition
strategies introduced in 0.8.x. `autonomous-run-governance` adds five new
commands without replacing core commands. `parallel-autonomous-run-governance`
adds bounded multi-worker campaign orchestration on top of autonomous-run
governance.

These scaffolds are intentionally kept as separate repo-shaped
directories so they can later be moved into independent public GitHub
repositories for the Spec Kit community catalog.

Recommended future repository names:

- `hindermath/spec-kit-preset-security-governance`
- `hindermath/spec-kit-preset-secure-development-assurance-governance`
- `hindermath/spec-kit-preset-isaqb-architecture-governance`
- `hindermath/spec-kit-preset-architecture-governance`
- `hindermath/spec-kit-preset-a11y-governance`
- `hindermath/spec-kit-preset-agent-parity-governance`
- `hindermath/spec-kit-preset-intake-authoring-governance`
- `hindermath/spec-kit-preset-intake-review-governance`
- `hindermath/spec-kit-preset-intake-sequencing-governance`
- `hindermath/spec-kit-preset-model-routing-governance`
- `hindermath/spec-kit-preset-cross-platform-governance`
- `hindermath/spec-kit-preset-autonomous-run-governance`
- `hindermath/spec-kit-preset-parallel-autonomous-run-governance`

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
- `parallel-autonomous-run-governance` inherits MSL and secure-development
  expectations from the target repositories and installed governance stack; it
  governs campaign isolation, concurrency, stop/resume, and consolidation.

Current status:

- the six original governance presets are published and catalogued
- `intake-authoring-governance` v0.3.0 is published and catalogued through
  [submission #3720](https://github.com/github/spec-kit/issues/3720) and
  [catalog PR #3721](https://github.com/github/spec-kit/pull/3721); its five
  commands provide explicit Create, Read, Update, Delete, and Status boundaries
  without implicitly starting Intake Review, Specify, or autonomous delivery
- `autonomous-run-governance` v0.3.3 is the current patch release; it retains
  validated lifecycle state plus explicit status, graceful-stop, and protected
  resume commands, adds a mandatory-rule delta audit for preset drift, provides
  a detailed bilingual operating guide with five Mermaid diagrams, and
  distinguishes the readable `Deliver` heading from canonical `Publish`,
  `Review`, and `MergeAndSync` run-state stages
- `parallel-autonomous-run-governance` v0.2.4 is the validated eighth standard
  preset with a bilingual campaign manual and nine Mermaid diagrams; starting
  a parallel campaign remains explicitly delegable
- real Preset 8 campaigns require enabled
  `autonomous-run-governance >=0.2.2` in every worker repository; priority `70`
  provides the worker lifecycle before priority `80` coordinates the campaign

Recommended publication order:

1. `security-governance`
2. optional `secure-development-assurance-governance`
3. `architecture-governance`
4. `isaqb-architecture-governance`
5. `a11y-governance`
6. `cross-platform-governance`
7. `agent-parity-governance`
8. optional `model-routing-governance`
9. optional `intake-authoring-governance`
10. optional `intake-review-governance`
11. optional `intake-sequencing-governance`
12. `autonomous-run-governance`
13. `parallel-autonomous-run-governance`

Recommended install order for stacked use:

```bash
specify preset add --from https://github.com/hindermath/spec-kit-preset-security-governance/archive/refs/tags/v0.6.2.zip --priority 10
# Optional assurance extension; omit for the standard eight-preset profile.
specify preset add --from https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.0.zip --priority 15
specify preset add --from https://github.com/hindermath/spec-kit-preset-architecture-governance/archive/refs/tags/v0.5.2.zip --priority 20
specify preset add --from https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/archive/refs/tags/v0.2.2.zip --priority 30
specify preset add --from https://github.com/hindermath/spec-kit-preset-a11y-governance/archive/refs/tags/v0.4.3.zip --priority 40
specify preset add --from https://github.com/hindermath/spec-kit-preset-cross-platform-governance/archive/refs/tags/v0.2.2.zip --priority 50
specify preset add --from https://github.com/hindermath/spec-kit-preset-agent-parity-governance/archive/refs/tags/v0.4.2.zip --priority 60
# Optional routing/intake extensions; omit the next four lines for the standard eight-preset profile.
specify preset add --from https://github.com/hindermath/spec-kit-preset-model-routing-governance/archive/refs/tags/v0.1.4.zip --priority 61
specify preset add --from https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/archive/refs/tags/v0.3.1.zip --priority 64
specify preset add --from https://github.com/hindermath/spec-kit-preset-intake-review-governance/archive/refs/tags/v0.2.1.zip --priority 65
specify preset add --from https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/archive/refs/tags/v0.2.3.zip --priority 66
specify preset add --from https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/archive/refs/tags/v0.4.1.zip --priority 70
specify preset add --from https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/archive/refs/tags/v0.2.6.zip --priority 80
```

### How priority resolution works

A preset priority is a positive integer used to order enabled presets during
template and command resolution. Lower numbers have higher precedence:

```text
10 → 15 → 20 → 30 → 40 → 50 → 60 → 61 → 64 → 65 → 66 → 70 → 80
```

Priority is relevant only where names overlap. It works together with the
component strategy:

| Strategy | Resolution behaviour |
|---|---|
| `replace` | The highest-precedence layer wins completely. |
| `prepend` | The layer is placed before lower-precedence content. |
| `append` | The layer is placed after lower-precedence content. |
| `wrap` | The layer surrounds lower-precedence or core content at its placeholder. |

Project-local overrides are resolved before installed presets. Equal preset
priorities are ordered deterministically by preset ID, but distinct values are
preferred because they document the intended stack. Number gaps are
intentional: priorities `64` and `65` fit between Agent Parity at `60` and
Autonomous Run at `70` without renumbering the established stack.

Priority does not install, enable, or execute a preset. It grants no commit,
push, PR, merge, bypass, secret, or provider authority. The ordering from
Intake Authoring through Parallel Autonomous describes conceptual layering,
not an automatically executed workflow.

### How the four workflow presets cooperate

The optional workflow stack can turn explicit source material into a reviewed
and hash-bound execution basis:

```text
Sources
  -> speckit.intake-create
  -> intake + receipt (`ReadyForReview`)
  -> speckit.intake-review
  -> current `Ready` or human-approved `ReadyWithAcceptedRisks`
  -> speckit.autonomous or speckit.parallel-autonomous
```

These arrows are manual handoffs. Authoring never starts Review, Review never
starts Specify, and neither autonomous preset starts merely because it is
installed or has a later priority.

- Preset 10 records ordered sources, normalized hashes, decisions, authority,
  and the target hash. `ReadyForReview` proves authoring consistency only.
- Preset 9 reviews the target independently and produces the acceptance result
  consumed by enabled downstream policy gates.
- Preset 7 v0.3.3 validates one current result and the binding intake hash
  before branch, feature, or Specify creation. Accepted hashes become
  autonomous `acceptedArtifacts`.
- Preset 8 v0.2.4 validates campaign review coverage before worktree creation,
  checks one semantic review per unique intake plus one applicability row per
  worker, aligns the review with the campaign DAG, and revalidates the stored
  result hash on resume. Preset 7 still governs each worker lifecycle.

Missing evidence, target drift, unanswered material questions, Critical/High
findings, or an unaccepted risk blocks an enabled gate. When repository policy
does not require Intake Review, Preset 7 records `N/A`; campaigns can likewise
declare the optional schema-1.2 gate inactive. No gate grants delivery or
administrative authority.

For a beginner-oriented bilingual explanation, examples, diagnostics, and safe
reprioritisation guidance, see
[Spec Kit Preset Priorities](../../docs/maintenance/Spec-Kit-Preset-Priorities.md).

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
