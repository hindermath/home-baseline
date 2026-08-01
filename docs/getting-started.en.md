# Getting started with home-baseline

[Deutsche Fassung](getting-started.md)

## Purpose and model

`home-baseline` separates three layers: the versioned Level 0 source,
operational files distributed from that source, and machine-local state. This
separation protects private data and keeps changes auditable.

## Install prerequisites

1. Install Git and configure your identity.
2. Use PowerShell 7 on Windows and Bash on macOS/Linux.
3. Optionally install `gh` or `glab` for the hosting platform you use.
4. Install Python, `uv`, and `specify-cli` when the project requires Spec Kit.
5. Provide `rg`, Python 3, and `pwsh` for complete validation.

A GitHub account is required only for the GitHub route or optional Copilot
sign-in. GitLab, Codeberg, Forgejo, and institutional Git services are also
supported models.

## Set up Level 0

```bash
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-source
cd ~/home-baseline-source
bash scripts/bootstrap-workspace.sh --dry-run Ausbildung
```

On Windows:

```powershell
git clone https://github.com/hindermath/home-baseline.git "$HOME/home-baseline-source"
Set-Location "$HOME/home-baseline-source"
pwsh -NoProfile -File scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung -WhatIf
```

The preview reports side effects before creating files or installing tools. Run
the same command without the preview option only after reviewing the result.

## Classify existing projects

- Level 0 contains shared workspace governance and reusable scripts.
- Level 1 groups projects, such as `RiderProjects` or `C64Projects`.
- Level 2 is one product, learning, or preset repository.

Run registration and migration in inspection mode first. Never silently
overwrite a newer remote README or existing user changes.

## Start with Spec Kit

Spec Kit supports Specification-Driven Development: development from a reviewed
specification. The normal sequence is:

1. Create or update an intake.
2. Review the intake independently.
3. Specify the feature and clarify material ambiguity.
4. Converge plan, tasks, and analysis.
5. Implement, validate, and deliver only with appropriate authority.

Installed governance presets enrich these steps. Priority controls composition
order, not importance. See
[Spec Kit preset priorities](maintenance/Spec-Kit-Preset-Priorities.md).

For a first maintenance run, the
[efficiency guide](maintenance/agentic-workspace-efficiency-guide.en.md#erster-sicherer-lauf-first-safe-run)
leads from help through check-only and preview to the safe next action.

## Next action

Learners open [START-HERE](learning-units/START-HERE-FUER-LERNENDE.md). Maintainers read
[Source and Home Runtime](architecture/source-and-home-runtime.en.md) before
editing or synchronizing files.
