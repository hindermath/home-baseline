# setup-gitlab-release(1)

## NAME

`setup-gitlab-release` - install generic GitLab release automation into an existing repository

## SYNOPSIS

```text
bash scripts/setup-gitlab-release.sh [TARGET_REPO] [--gitlab-url URL] [--skip-project-settings] [--force]
pwsh scripts/setup-gitlab-release.ps1 [-TargetRepository PATH] [-GitLabUrl URL] [-SkipProjectSettings] [-Force]
```

## DESCRIPTION

The command anchors a reusable GitLab release baseline inside an existing repository.

It performs these actions:

- copies `scripts/release-gitlab.sh`
- creates `CHANGELOG.md` if missing
- ensures `.gitlab-ci.yml` contains a `release` stage
- appends a manual GitLab `release` job if missing
- optionally enables `ci_push_repository_for_job_token_allowed` through the GitLab API

The generated release job is designed as a GitLab-native replacement for GitHub `release-please`:

- it derives SemVer from Conventional Commits
- updates `CHANGELOG.md`
- pushes the changelog commit back to the default branch
- creates a GitLab tag and Release through the GitLab API

## OPTIONS

### Bash

- `TARGET_REPO`: target repository path, defaults to current directory
- `--gitlab-url URL`: explicit GitLab base URL, for example `https://gitlab-ce.gwdg.de`
- `--skip-project-settings`: do not modify GitLab project settings
- `--force`: overwrite `CHANGELOG.md` and `scripts/release-gitlab.sh`

### PowerShell

- `-TargetRepository`: target repository path, defaults to current directory
- `-GitLabUrl`: explicit GitLab base URL
- `-SkipProjectSettings`: do not modify GitLab project settings
- `-Force`: overwrite `CHANGELOG.md` and `scripts/release-gitlab.sh`

## EXAMPLES

```bash
bash ~/home-baseline-tmp/scripts/setup-gitlab-release.sh ~/RiderProjects/inventarworkerservice2 --gitlab-url https://gitlab-ce.gwdg.de
```

```powershell
pwsh ~/home-baseline-tmp/scripts/setup-gitlab-release.ps1 -TargetRepository ~/RiderProjects/inventarworkerservice2 -GitLabUrl https://gitlab-ce.gwdg.de
```

## FILES

- `scripts/setup-gitlab-release.sh`
- `scripts/setup-gitlab-release.ps1`
- `scripts/templates/release-gitlab.sh.tmpl`
- `scripts/templates/gitlab-release-job.yml.tmpl`
- `scripts/templates/changelog-template.md`
