# CLI-Vertrag: bootstrap-project.sh / .ps1
# CLI Contract: bootstrap-project.sh / .ps1

**FR-REV-B02** | **FR-REV-B05** | **FR-REV-D01** | **FR-REV-D02**

---

## Aufruf / Invocation

```bash
# Bash
bash scripts/bootstrap-project.sh <project-name> [repo-name] [description] [--dry-run]

# PowerShell
pwsh scripts/bootstrap-project.ps1 -ProjectName <string> [-RepoName <string>] [-Description <string>] [-WhatIf]
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `project-name` / `-ProjectName` | **Ja** | Name des neuen Projektverzeichnisses |
| `repo-name` / `-RepoName` | Nein | GitHub-Repo-Name (Standard: project-name) |
| `description` / `-Description` | Nein | GitHub-Repo-Beschreibung |
| `--dry-run` / `-WhatIf` | Nein | Preview-Modus — keine Änderungen |

## Prozessablauf / Process Flow

```
1. Vorprüfung: Verzeichnis existiert bereits?
   → WARN: already bootstrapped — use --force to re-apply
2. Verzeichnis erstellen
3. README.md aus readme-template.md erstellen (FR-REV-B02)
4. constitution.md von ~/constitution.md kopieren (FR-REV-B02)
5. .github/workflows/homogeneity-check.yml erstellen (FR-REV-B02)
6. spec-kit initialisieren:
   a. .specify/ Verzeichnis anlegen
   b. create-new-feature.sh installieren
   c. AGENTS.md — SDD-Workflow-Verweis einfügen (FR-REV-B05)
7. Agenten-CLIs initialisieren (FR-REV-D01, D02):
   a. claude /init (falls verfügbar)
   b. gh extension exec github/gh-copilot (falls verfügbar)
   c. codex: WARN (interaktiv — manuell ausführen)
   d. gemini: WARN (interaktiv — manuell ausführen)
   e. speckit specify init --here --ai {claude|gemini|copilot|codex}
8. git init + initaler Commit
9. gh repo create (privat) + push
   → Falls Remote bereits konfiguriert: INFO: remote already configured — skipping
10. install-hooks.sh ausführen
11. init-stats.sh automatisch aufrufen (FR-REV-B02, SC-REV-03)
```

## Fehlerbehandlung / Error Handling

| Fehlerfall | Verhalten |
|---|---|
| `readme-template.md` fehlt | `ERROR: template not found: scripts/templates/readme-template.md` + Abbruch |
| `~/constitution.md` fehlt | `ERROR: root constitution.md not found at ~/constitution.md` + Abbruch |
| Verzeichnis bereits vorhanden | `WARN: already bootstrapped — use --force to re-apply` |
| CLI nicht verfügbar | `WARN: {agent} CLI not found — install manually` (kein Abbruch) |
| `speckit` nicht verfügbar | `WARN: speckit not found — run manually: speckit specify init --here --ai {agent}` (kein Abbruch) |

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Erfolgreich (inkl. --dry-run) |
| `1` | Fehler (Template oder constitution.md fehlt) |

## Seiteneffekte / Side Effects

- Neues Verzeichnis mit vollständiger Dateistruktur
- Privates GitHub-Repo erstellt
- Git-Init + initialer Commit + Push
- Pre-Push-Hook installiert
- STATS.md-Baseline erstellt
