# Spec Kit Preset Repository Scaffolds

This directory contains repo-shaped release candidates for the five
home-baseline-derived Spec Kit governance presets.

Each subdirectory is intended to become a standalone GitHub repository:

- `spec-kit-preset-security-governance`
- `spec-kit-preset-architecture-governance`
- `spec-kit-preset-a11y-governance`
- `spec-kit-preset-agent-parity-governance`
- `spec-kit-preset-cross-platform-governance`

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

For agent guidance addenda, resolve the preset-specific standalone
template, for example:

```bash
specify preset resolve security-agent-guidance-addendum-template
```
