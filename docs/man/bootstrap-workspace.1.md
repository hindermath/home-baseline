# bootstrap-workspace(1)

## NAME

`bootstrap-workspace.sh`, `bootstrap-workspace.ps1` - richtet ein neues Workspace-Verzeichnis als privates GitHub- oder GitLab-Repo ein. *Sets up a new workspace directory as a private GitHub or GitLab repository.*

## SYNOPSIS

```bash
bash scripts/bootstrap-workspace.sh [options] <Verzeichnisname> [Repo-Name] [Beschreibung]
```

```powershell
pwsh -NoProfile -File scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-Description <d>] [options]
```

## DESCRIPTION

Das Skript initialisiert ein Workspace-Verzeichnis: `git init`, `.gitignore`, Kopieren der Standard-Skripte, Anlegen eines privaten Repos ueber `gh repo create` (GitHub) oder `glab repo create` (GitLab), Push und Installation der Git-Hooks. Mit `--teardown` delegiert das Skript an `teardown-workspace`.

*The script initializes a workspace directory: `git init`, `.gitignore`, copying the standard scripts, creating a private repository via `gh repo create` (GitHub) or `glab repo create` (GitLab), pushing, and installing the git hooks. With `--teardown` the script delegates to `teardown-workspace`.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<Verzeichnisname>` | `-WorkspaceName <Name>` | Workspace-Verzeichnis (Pflicht) |
| `[Repo-Name]` | `-RepoName <r>` | Name des Remote-Repos |
| `[Beschreibung]` | `-Description <d>` | Repo-Beschreibung |
| `--dry-run` | `-WhatIf` | Alle Schritte ohne Ausfuehrung zeigen |
| `--platform <github\|gitlab>` | `-Platform <github\|gitlab>` | Zielplattform |
| `--gitlab-url <url>` | `-GitLabUrl <url>` | GitLab-Basis-URL (`https://…`) |
| `--teardown` | `-Teardown` | An `teardown-workspace` delegieren |

## EXAMPLES

```bash
bash scripts/bootstrap-workspace.sh WebstormProjects webstorm-baseline "Workspace fuer WebStorm-Projekte"
```

```bash
bash scripts/bootstrap-workspace.sh --dry-run WebstormProjects
```

```powershell
pwsh -NoProfile -File scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects -Platform gitlab
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | fehlende Argumente oder Ausfuehrungsfehler / missing arguments or execution error |

## SEE ALSO

`bootstrap-project.1`, `teardown-workspace.1`, `install-hooks.1`
