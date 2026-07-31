# bootstrap-project(1)

## NAME

`bootstrap-project.sh`, `bootstrap-project.ps1` - idempotenter Projekt-Bootstrap fuer ein Level-2-Projekt. *Idempotent bootstrap for a level-2 project.*

## SYNOPSIS

```bash
bash scripts/bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [options]
```

```powershell
pwsh -NoProfile -File scripts/bootstrap-project.ps1 -ProjectName <Name> [-TargetWorkspace <dir>] [options]
```

## DESCRIPTION

Das Skript legt ein neues Projekt idempotent an: es kopiert Templates, initialisiert die KI-Agenten, installiert Spec-Kit samt Governance-Presets, richtet optional ein Remote-Repository sowie den Release-Please-Workflow ein und setzt die deklarierte Primaersprache fuer das MSL-Setup. Jedes erzeugte Level-2-Projekt wird unabhaengig vom MSL-Status als GSDB-Ziel registriert. Das Preset-Profil wird in dieser Reihenfolge bestimmt: explizite Option, lokale Registry-Vorgabe, zentraler Katalog-Standard. Genau dieses Profil wird installiert und registriert. Bereits vorhandene Dateien bleiben ohne `--force` unangetastet.

Die Constitution-Version wird ausschließlich aus genau einer Überschrift im Format `# Constitution vX.Y.Z` gelesen. Fehlt sie oder ist sie mehrdeutig, bricht der Bootstrap vor Schreibaktionen ab.

*The script creates a new project idempotently: it copies templates, initializes the AI agents, installs Spec Kit and its governance presets, optionally sets up a remote repository and the Release Please workflow, and applies the declared primary language for the MSL setup. Every generated level-2 project is registered for GSDB scope independently of MSL status. Preset selection follows this precedence: explicit option, local registry default, central catalog default. The same resolved profile is installed and registered. Existing files are left untouched unless `--force` is given.*

*The constitution version is read exclusively from exactly one heading matching `# Constitution vX.Y.Z`. A missing or ambiguous heading stops bootstrap before any write action.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<ProjectName>` | `-ProjectName <Name>` | Projektname (Pflicht) |
| `[TARGET_WORKSPACE]` | `-TargetWorkspace <dir>` | Zielworkspace (Standard: aktuelles Verzeichnis) |
| `--preview`, `--dry-run` | `-Preview`, `-WhatIf` | Geplante Aktionen zeigen, nichts schreiben |
| `--force` | `-Force` | Vorhandene Dateien ueberschreiben |
| `--no-agents` | `-NoAgents` | KI-Agenten-Initialisierung ueberspringen |
| `--no-speckit` | `-NoSpeckit` | Spec-Kit-Installation ueberspringen |
| `--no-governance-presets` | `-NoGovernancePresets` | Governance-Preset-Installation ueberspringen |
| `--preset-profile NAME` | `-PresetProfile NAME` | Installiertes und registriertes Preset-Profil explizit wählen |
| `--no-remote` | `-NoRemote` | Kein Remote-Repo, nur lokales `git init` |
| `--no-release-please` | `-NoReleasePlease` | Release-Please-Workflow ueberspringen |
| `--platform <github\|gitlab\|forgejo\|codeberg>` | `-Platform <github\|gitlab\|forgejo\|codeberg>` | Zielplattform |
| `--gitlab-url <url>` | `-GitLabUrl <url>` | GitLab-Basis-URL (`https://…`) |
| `--forgejo-url <url>` | `-ForgejoUrl <url>` | Pflicht-URL fuer institutionelles Forgejo; bei Codeberg fest vorbelegt |
| `--lang <de\|en>` | `-Lang <de\|en>` | Primaersprache der Templates (Standard: de) |
| `--primary-language <lang>` | `-PrimaryLanguage <lang>` | Deklarierte Implementierungssprache fuer MSL-Setup |

## EXAMPLES

```bash
bash scripts/bootstrap-project.sh MyTool ~/RiderProjects --primary-language csharp --preview
```

```bash
bash scripts/bootstrap-project.sh MyTool ~/RiderProjects --platform codeberg --preview
```

```bash
bash scripts/bootstrap-project.sh MyTool ~/RiderProjects --no-remote --preset-profile intake-sequencing-eleven-governance-presets --preview
```

```powershell
pwsh -NoProfile -File scripts/bootstrap-project.ps1 -ProjectName MyTool -NoRemote -Lang de
```

Für ein später öffentliches Repository wird zuerst mit `--no-remote` beziehungsweise `-NoRemote` lokal initialisiert. Ein öffentliches Remote und der erste Push folgen erst nach der getrennten Public-Readiness-Freigabe. Der eingebaute Remote-Pfad bleibt aus Kompatibilitäts- und Sicherheitsgründen privat.

*For a repository intended to become public, initialize locally with `--no-remote` or `-NoRemote`. Add the public remote and perform the first push only after the separate public-readiness approval. The built-in remote path remains private for compatibility and safety.*

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | teilweiser Erfolg mit Warnungen / partial (warnings) |
| 2 | fataler Fehler / fatal error |

## SEE ALSO

`bootstrap-workspace.1`, `migrate-workspace.1`, `init-stats.1`
