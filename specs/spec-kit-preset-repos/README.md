# Spec Kit Preset Repository Scaffolds

This directory contains repo-shaped release candidates for the eight standard
and optional home-baseline-derived Spec Kit governance presets.

Each subdirectory is intended to become a standalone GitHub repository:

- `spec-kit-preset-security-governance`
- `spec-kit-preset-isaqb-architecture-governance`
- `spec-kit-preset-architecture-governance`
- `spec-kit-preset-a11y-governance`
- `spec-kit-preset-agent-parity-governance`
- `spec-kit-preset-cross-platform-governance`
- `spec-kit-preset-autonomous-run-governance`
- `spec-kit-preset-parallel-autonomous-run-governance`

The scaffolds intentionally do not contain nested `.git/` directories.
Create standalone repositories outside this root workspace before
publishing.

## Smoke Test

Run this from a temporary Spec Kit project:

```bash
specify init --here --integration codex --script sh
specify preset add --dev /path/to/spec-kit-preset-security-governance --priority 10
specify preset list
specify preset resolve constitution-template
specify preset resolve spec-template
specify preset resolve plan-template
specify preset resolve tasks-template
```

For the full stacked smoke test, install all eight presets in their
recommended priority order:

```bash
specify preset add --dev /path/to/spec-kit-preset-security-governance --priority 10
specify preset add --dev /path/to/spec-kit-preset-architecture-governance --priority 20
specify preset add --dev /path/to/spec-kit-preset-isaqb-architecture-governance --priority 30
specify preset add --dev /path/to/spec-kit-preset-a11y-governance --priority 40
specify preset add --dev /path/to/spec-kit-preset-cross-platform-governance --priority 50
specify preset add --dev /path/to/spec-kit-preset-agent-parity-governance --priority 60
specify preset add --dev /path/to/spec-kit-preset-autonomous-run-governance --priority 70
specify preset add --dev /path/to/spec-kit-preset-parallel-autonomous-run-governance --priority 80
specify preset list
specify preset resolve constitution-template
```

For agent guidance addenda, resolve the preset-specific standalone
template. Each preset names its standalone template
`<preset-prefix>-agent-guidance-addendum-template` (the
`agent-parity-governance` preset elides the duplicate `agent-` segment):

```bash
specify preset resolve security-agent-guidance-addendum-template
specify preset resolve isaqb-architecture-agent-guidance-addendum-template
specify preset resolve architecture-agent-guidance-addendum-template
specify preset resolve cross-platform-agent-guidance-addendum-template
specify preset resolve a11y-agent-guidance-addendum-template
specify preset resolve agent-parity-guidance-addendum-template
specify preset resolve autonomous-run-agent-guidance-addendum-template
specify preset resolve parallel-autonomous-agent-guidance-addendum-template
```

Each preset also registers three wrap commands (`speckit.specify`,
`speckit.plan`, `speckit.tasks`). `specify preset resolve` operates on
templates only; verify the wrap commands per preset with `preset info`:

```bash
specify preset info security-governance
specify preset info isaqb-architecture-governance
specify preset info architecture-governance
specify preset info cross-platform-governance
specify preset info a11y-governance
specify preset info agent-parity-governance
specify preset info autonomous-run-governance
specify preset info parallel-autonomous-run-governance
```
