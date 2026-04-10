# CLI-Vertrag: bootstrap-workspace (v2 — GitLab Support)

**Tool**: `scripts/bootstrap-workspace.sh` / `scripts/bootstrap-workspace.ps1`  
**Zweck**: Neues Projektverzeichnis als privates GitHub- oder GitLab-Repository einrichten  
**Branch**: `006-gitlab-support`  
**Vorgänger**: impliziter v1-Vertrag (nur GitHub)

---

## Synopsis

```bash
# Bash
bootstrap-workspace.sh [--dry-run] <WorkspaceName> [RepoName] [Description]
                       [--platform <github|gitlab>]
                       [--gitlab-url <https://gitlab.example.com>]

# PowerShell
bootstrap-workspace.ps1 -WorkspaceName <String>
                         [-RepoName <String>]
                         [-Description <String>]
                         [-Platform <github|gitlab>]
                         [-GitLabUrl <String>]
                         [-WhatIf]
```

---

## Parameter

| Bash-Flag | PS-Parameter | Typ | Standard | Beschreibung |
|-----------|-------------|------|----------|--------------|
| `<WorkspaceName>` | `-WorkspaceName` | string | **Pflicht** | Name des Workspace-Verzeichnisses |
| `[RepoName]` | `-RepoName` | string | abgeleitet | Name des Remote-Repository |
| `[Description]` | `-Description` | string | abgeleitet | Repository-Beschreibung |
| `--platform` | `-Platform` | `github\|gitlab` | `github` | Zielplattform |
| `--gitlab-url` | `-GitLabUrl` | string (`https://…`) | `https://gitlab.com` | GitLab-Instanz-URL |
| `--dry-run` | `-WhatIf` | switch | off | Zeigt alle geplanten Aktionen, schreibt nichts |

---

## Validierungsregeln / Validation Rules

| Parameter | Regel / Rule |
|-----------|-------------|
| `--platform` | Muss `github` oder `gitlab` sein; ungültige Werte → Exit 1, bilinguale Fehlermeldung |
| `--gitlab-url` | Muss mit `https://` beginnen (nur bei `--platform gitlab`); sonst → Exit 1 |
| `glab` (bei GitLab) | Muss installiert sein; fehlt → Exit 1 + Installationsanleitung |
| `glab auth` (bei GitLab) | Muss authentifiziert sein; sonst → Exit 1 + `glab auth login`-Hinweis |

---

## Exit-Codes

| Code | Bedeutung |
|------|-----------|
| `0` | Bootstrap erfolgreich abgeschlossen |
| `1` | Fehler: ungültige Parameter, fehlende Tools, Auth-Fehler, API-Fehler, Push-Fehler |

---

## Preamble-Ausgabe (Beispiele)

**GitHub** (unverändert):
```text
╔══════════════════════════════════════════════════════════════════╗
║  bootstrap-workspace – Neue Workspace-Einrichtung               ║
╠══════════════════════════════════════════════════════════════════╣
║  Verzeichnis : ~/MyWorkspace                                     ║
║  GitHub-Repo : hindermath/myworkspace-baseline (privat)         ║
║  Beschreibung: Gemeinsame Workspace-Konfiguration für MyWorkspace║
║  Plattform   : GitHub (privat)                                   ║
╚══════════════════════════════════════════════════════════════════╝
```

**GitLab (gitlab.com)**:
```text
╔══════════════════════════════════════════════════════════════════╗
║  bootstrap-workspace – Neue Workspace-Einrichtung               ║
╠══════════════════════════════════════════════════════════════════╣
║  Verzeichnis : ~/MyWorkspace                                     ║
║  GitLab-Repo : hindermath/myworkspace-baseline (privat)         ║
║  Beschreibung: Gemeinsame Workspace-Konfiguration für MyWorkspace║
║  Plattform   : GitLab — https://gitlab.com (privat)             ║
╚══════════════════════════════════════════════════════════════════╝
```

**GitLab (Self-hosted, Name normalisiert)**:
```text
╔══════════════════════════════════════════════════════════════════╗
║  bootstrap-workspace – Neue Workspace-Einrichtung               ║
╠══════════════════════════════════════════════════════════════════╣
║  Verzeichnis : ~/My Workspace                                    ║
║  GitLab-Slug : my-workspace (normalisiert von: My Workspace)    ║
║  GitLab-Repo : hindermath/my-workspace (privat)                 ║
║  Plattform   : GitLab — https://gitlab.example.com (privat)     ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## Abschluss-Ausgabe (Beispiele)

**GitHub** (unverändert):
```text
  Repo   : https://github.com/hindermath/myworkspace-baseline
  Clone  : git clone https://github.com/hindermath/myworkspace-baseline.git ~/MyWorkspace
```

**GitLab**:
```text
  Repo   : https://gitlab.com/hindermath/myworkspace-baseline
  Clone  : git clone https://gitlab.com/hindermath/myworkspace-baseline.git ~/MyWorkspace
```

**GitLab (Self-hosted)**:
```text
  Repo   : https://gitlab.example.com/hindermath/myworkspace-baseline
  Clone  : git clone https://gitlab.example.com/hindermath/myworkspace-baseline.git ~/MyWorkspace
```

---

## Dry-Run-Ausgabe (GitLab)

```text
  [DRY RUN – keine Änderungen werden vorgenommen]
  [dry-run] glab repo create 'myworkspace-baseline' --private --description '...'
  [dry-run] git -C '~/MyWorkspace' remote add origin 'https://gitlab.com/hindermath/myworkspace-baseline.git'
  [dry-run] git -C '~/MyWorkspace' push -u origin HEAD
```

---

## Fehlermeldungen (bilinguale Beispiele)

```text
Fehler: Ungültige Plattform 'bitbucket'. Gültige Werte: github, gitlab.
Error: Invalid platform 'bitbucket'. Valid values: github, gitlab.

Fehler: --gitlab-url muss mit 'https://' beginnen (z. B. https://gitlab.example.com).
Error: --gitlab-url must start with 'https://' (e.g. https://gitlab.example.com).

Fehler: glab (GitLab CLI) ist nicht installiert.
  macOS/Linux: brew install glab
  Windows:     winget install GLabCLI.GlabCLI
Error: glab (GitLab CLI) is not installed.

Fehler: Nicht bei GitLab (gitlab.com) authentifiziert. Bitte 'glab auth login' ausführen.
Error: Not authenticated with GitLab (gitlab.com). Please run 'glab auth login'.

Fehler: Konnte GitLab-Benutzername nicht ermitteln.
Error: Could not retrieve GitLab username.
```

---

## ~/README.md-Eintrag

| Plattform | Eingefügte Zeile |
|-----------|-----------------|
| GitHub | `\| \`~/MyWorkspace/\` \| [myworkspace-baseline](https://github.com/USER/myworkspace-baseline) \| \`bootstrap-workspace\` \|` |
| GitLab | `\| \`~/MyWorkspace/\` \| [myworkspace-baseline](https://gitlab.com/USER/myworkspace-baseline) \| \`bootstrap-workspace\` \|` |
| GitLab (self-hosted) | `\| \`~/MyWorkspace/\` \| [myworkspace-baseline](https://gitlab.example.com/USER/myworkspace-baseline) \| \`bootstrap-workspace\` \|` |

---

## Rückwärtskompatibilität / Backward Compatibility

Alle bestehenden Aufrufe ohne `--platform` funktionieren unverändert.  
*All existing calls without `--platform` continue to work unchanged.*
