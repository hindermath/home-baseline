# teardown-workspace(1)

## NAME

`teardown-workspace.sh`, `teardown-workspace.ps1` - entfernt einen Workspace lokal und optional das Remote-Repository. *Removes a workspace locally and optionally the remote repository.*

## SYNOPSIS

```bash
bash scripts/teardown-workspace.sh <WorkspaceName> [options]
```

```powershell
pwsh -NoProfile -File scripts/teardown-workspace.ps1 -WorkspaceName <Name> [options]
```

## DESCRIPTION

Das Skript baut einen Workspace kontrolliert ab: es entfernt das Verzeichnis, bereinigt `README.md`, `.gitignore` und die `.gitconfig.d/*.inc`-Fragmente und loescht optional das GitHub-, GitLab-, Forgejo- oder Codeberg-Remote. Forgejo-Metadaten werden aus der lokalen `.git/config` gelesen. Der Workspace-Name muss genau ein echtes direktes Unterverzeichnis von Home bezeichnen; absolute Pfade, Trennzeichen, `.`/`..`, symbolische Links und verlinkte Git-Metadaten werden abgelehnt. `home-baseline`, `home-baseline-source` und die ueber den gemeinsamen Resolver erkannte Level-0-Quelle sind geschuetzt. Vorhandene Backup-Pfade einschliesslich nicht aufloesbarer symbolischer Links werden nicht ueberschrieben. Mit `--dry-run` werden alle Aktionen nur angezeigt.

Ohne `--force` wird nur gelöscht, wenn Git-Status, Upstream und ungepushte
Commits fehlerfrei geprüft wurden. Jeder unbestimmte Git-Zustand blockiert.
Forgejo-/Codeberg-Metadaten müssen einen einzelnen HTTPS-Origin ohne
Zugangsdaten, Pfad oder Steuerzeichen bilden und exakt zum Remote passen.
GitHub- und GitLab-Loeschungen binden zudem die jeweilige CLI-Hostvariable an
den strukturell geprueften und exakt bestaetigten Host; geerbte `GH_HOST`- oder
`GITLAB_HOST`-Werte koennen das Ziel nicht umleiten.

*The script tears a workspace down in a controlled way: it removes the directory, cleans up `README.md`, `.gitignore`, and the `.gitconfig.d/*.inc` fragments, and optionally deletes the remote repository. The workspace name must identify exactly one real direct child directory of Home; absolute paths, separators, `.`/`..`, symbolic links, and linked Git metadata are rejected. `home-baseline`, `home-baseline-source`, and the Level 0 source discovered by the shared resolver are protected. Existing backup paths, including dangling symbolic links, are not overwritten. With `--dry-run` all actions are only shown.*

*Without `--force`, deletion proceeds only after Git status, upstream and
unpushed commits were checked successfully. Any indeterminate Git state blocks.
Forgejo/Codeberg metadata must be one HTTPS origin without credentials, a path
or control characters and must exactly match the remote. GitHub and GitLab
deletions also bind the CLI host variable to the structurally validated and
exactly confirmed host, so inherited `GH_HOST` or `GITLAB_HOST` values cannot
redirect the target.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<WorkspaceName>` | `-WorkspaceName <Name>` | Einfacher Name eines echten direkten Home-Unterverzeichnisses (Pflicht) / Simple name of a real direct Home child directory (required) |
| `--backup` | `-Backup` | Vor der Loeschung ein Backup-Archiv erstellen |
| `--keep-remote` | `-KeepRemote` | Remote-Repository nicht loeschen |
| `--recursive` | `-Recursive` | Level-2-Repositories zuerst verarbeiten |
| `--force` | `-Force` | Sicherheitspruefungen ueberspringen |
| `--yes` | `-Yes` | Rueckfrage ueberspringen |
| `--expected-remote <Ziel>` | `-ExpectedRemoteTarget <Ziel>` | Nicht-interaktive Remote-Loeschung an das exakt bestaetigte Ziel binden / Bind non-interactive remote deletion to the exact confirmed target |
| `--dry-run` | `-WhatIf` | Alle Aktionen ohne Ausfuehrung zeigen |

## EXAMPLES

```bash
bash scripts/teardown-workspace.sh WebstormProjects --dry-run
```

```powershell
pwsh -NoProfile -File scripts/teardown-workspace.ps1 -WorkspaceName WebstormProjects -Backup -KeepRemote
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 2 | ungueltige Option, fehlender oder geschuetzter Workspace / invalid option, missing or protected workspace |

## SEE ALSO

`bootstrap-workspace.1`, `bootstrap-project.1`
