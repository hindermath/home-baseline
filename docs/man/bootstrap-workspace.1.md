# bootstrap-workspace(1)

## NAME

`bootstrap-workspace.sh`, `bootstrap-workspace.ps1` - richtet ein neues Workspace-Verzeichnis lokal oder als privates GitHub-, GitLab-, Forgejo- oder Codeberg-Repo ein. *Sets up a new workspace directory locally or as a private GitHub, GitLab, Forgejo, or Codeberg repository.*

## SYNOPSIS

```bash
bash scripts/bootstrap-workspace.sh [options] <Verzeichnisname> [Repo-Name] [Beschreibung]
```

```powershell
pwsh -NoProfile -File scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-Description <d>] [options]
```

## DESCRIPTION

Das Skript initialisiert ein Workspace-Verzeichnis: `git init`, `.gitignore`, Kopieren der Standard-Skripte, optionales Anlegen eines privaten Repos ueber `gh`, `glab` oder die Forgejo-API, Push und Installation der Git-Hooks. Mit `--teardown` delegiert das Skript an `teardown-workspace`.

*The script initializes a workspace directory: `git init`, `.gitignore`, copying the standard scripts, optionally creating a private repository through `gh`, `glab`, or the Forgejo API, pushing, and installing the git hooks. With `--teardown` the script delegates to `teardown-workspace`.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<Verzeichnisname>` | `-WorkspaceName <Name>` | Workspace-Verzeichnis (Pflicht) |
| `[Repo-Name]` | `-RepoName <r>` | Name des Remote-Repos |
| `[Beschreibung]` | `-Description <d>` | Repo-Beschreibung |
| `--dry-run` | `-WhatIf` | Alle Schritte ohne Ausfuehrung zeigen |
| `--platform <github\|gitlab\|forgejo\|codeberg>` | `-Platform <github\|gitlab\|forgejo\|codeberg>` | Zielplattform |
| `--gitlab-url <url>` | `-GitLabUrl <url>` | GitLab-Basis-URL (`https://…`) |
| `--forgejo-url <url>` | `-ForgejoUrl <url>` | Pflicht-URL fuer institutionelles Forgejo; bei Codeberg fest vorbelegt |
| `--no-remote` | `-NoRemote` | Kein Remote-Repo, nur lokales `git init` |
| `--teardown` | `-Teardown` | An `teardown-workspace` delegieren |

## EXAMPLES

```bash
bash scripts/bootstrap-workspace.sh WebstormProjects webstorm-baseline "Workspace fuer WebStorm-Projekte"
```

```bash
bash scripts/bootstrap-workspace.sh --dry-run WebstormProjects
```

```bash
bash scripts/bootstrap-workspace.sh Ausbildung --platform forgejo --forgejo-url https://git.institution.example
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
