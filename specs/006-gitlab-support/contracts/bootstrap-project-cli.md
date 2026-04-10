# CLI-Vertrag: bootstrap-project (v2 — GitLab Support)

**Tool**: `scripts/bootstrap-project.sh` / `scripts/bootstrap-project.ps1`  
**Zweck**: Vollständiger Projekt-Bootstrap in einem einzigen idempotenten Aufruf  
**Branch**: `006-gitlab-support`  
**Vorgänger**: `specs/001-workspace-homogeneity-guardian/contracts/bootstrap-project-cli.md`

---

## Synopsis

```bash
# Bash
bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]
  Options (new):
    --platform <github|gitlab>            Zielplattform (Standard: github)
    --gitlab-url <https://gitlab.example.com>  Self-hosted GitLab URL

# PowerShell
bootstrap-project.ps1 -ProjectName <String> [[-TargetWorkspace] <String>] [OPTIONS]
  Parameters (new):
    -Platform <github|gitlab>
    -GitLabUrl <String>
```

---

## Alle Optionen / All Options

| Bash-Flag | PS-Parameter | Typ | Standard | Beschreibung |
|-----------|-------------|------|----------|--------------|
| `<ProjectName>` | `-ProjectName` | string | **Pflicht** | Name des neuen Projekts |
| `[TARGET_WORKSPACE]` | `-TargetWorkspace` | string | `$PWD` | Ziel-Workspace-Pfad |
| `--preview` / `--dry-run` | `-Preview` / `-WhatIf` | switch | off | Zeigt alle Aktionen, schreibt nichts |
| `--force` | `-Force` | switch | off | Überschreibt bestehende Dateien |
| `--no-agents` | `-NoAgents` | switch | off | Überspringt KI-Agenten-Init |
| `--no-speckit` | `-NoSpeckit` | switch | off | Überspringt Spec-kit-Installation |
| `--no-remote` | `-NoRemote` | switch | off | Kein Remote-Repo (nur lokales git init) |
| `--lang` | `-Lang` | `de\|en` | `de` | Primärsprache für Templates |
| **`--platform`** | **`-Platform`** | **`github\|gitlab`** | **`github`** | **Zielplattform** |
| **`--gitlab-url`** | **`-GitLabUrl`** | **string** | **`https://gitlab.com`** | **Self-hosted GitLab URL** |

---

## Validierungsregeln / Validation Rules

| Parameter | Regel / Rule |
|-----------|-------------|
| `--platform` | Muss `github` oder `gitlab` sein; ungültige Werte → Exit 2, bilinguale Fehlermeldung |
| `--gitlab-url` | Muss mit `https://` beginnen (nur bei `--platform gitlab`); sonst → Exit 2 |
| `glab` (bei GitLab) | Muss installiert sein; fehlt → Exit 2 + Installationsanleitung |
| `glab auth` (bei GitLab) | Muss authentifiziert sein; sonst → Exit 2 + Hinweis |
| `--no-remote` | Übersteuert `--platform`-Remote-Aktionen; lokales git init bleibt erhalten |

---

## Exit-Codes

| Code | Bedeutung |
|------|-----------|
| `0` | Bootstrap erfolgreich abgeschlossen |
| `1` | Teilfehler (Warnungen vorhanden — Projekt nutzbar) |
| `2` | Fataler Fehler (fehlende Tools, Auth-Fehler, ungültige Parameter) |

---

## Bootstrap-Sequenz (idempotent, Schritte 1–21 + neue GitLab-Logik)

```text
Schritt  Beschreibung                                    Änderung durch 006
──────────────────────────────────────────────────────────────────────────────
1        Verzeichnis anlegen                             —
2        git init                                        —
2b       Lokale git-Einstellungen                        —
3        AGENTS.md erzeugen                              —
4        CLAUDE.md erzeugen                              —
5        GEMINI.md erzeugen                              —
6        copilot-instructions.md erzeugen                —
7        README.md erzeugen                              —
7b       constitution.md kopieren                        —
7c       homogeneity-check.yml erzeugen                  —
8        STATS.md (initial) erzeugen                     —
9        .gitignore erzeugen                             —
10       scripts/ kopieren                               —
11       pre-push Hook installieren                      —
12       Initialer git-Commit                            —
13       Repo erstellen (gh / glab)              ← GEÄNDERT: platform-aware
14       git push                                        — (bereits separat)
15       Claude init                                     —
16       Codex (interaktiv)                              —
17       Gemini (interaktiv)                             —
18       Copilot prüfen                                  —
19       Spec-kit installieren                           —
20       Compliance-Check + STATS-Baseline               —
21       ~/README.md aktualisieren               ← GEÄNDERT: platform-aware URL
```

**Schritt 13 — neue GitLab-Logik**:

```bash
# Wenn --platform gitlab und --no-remote nicht gesetzt:
if ! $OPT_NO_REMOTE; then
  if ! command -v glab >/dev/null 2>&1; then
    step_warn "glab nicht installiert / glab not installed (brew install glab / winget install GLabCLI.GlabCLI)"
  elif ! GITLAB_HOST="$GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1; then
    step_warn "Nicht bei GitLab authentifiziert. Bitte 'glab auth login' ausführen. / Not authenticated with GitLab. Please run 'glab auth login'."
  else
    repo_slug=$(normalize_name "$PROJECT_NAME")
    if GITLAB_HOST="$GITLAB_HOSTNAME" glab repo create "$repo_slug" --private >/dev/null 2>&1; then
      git -C "$TARGET_DIR" remote add origin "https://${GITLAB_HOSTNAME}/${GITLAB_USER}/${repo_slug}.git"
      step_done "$repo_slug"
    else
      step_warn "glab repo create fehlgeschlagen / glab repo create failed"
    fi
  fi
fi
```

If the normalized GitLab slug differs from the original `ProjectName`, the resulting slug is surfaced in the final summary output.

---

## Preview-Ausgabe (GitLab)

```text
[PREVIEW] Folgende Aktionen würden ausgeführt:
  ...
  EXEC    glab repo create my-project --private       (optional)
  EXEC    git remote add origin https://gitlab.com/USER/my-project.git  (optional)
  EXEC    git push -u origin HEAD                     (optional)
  UPDATE  ~/README.md  (Zeile nach <!-- workspace-table-end -->)
  [Keine Dateien wurden geschrieben]
```

---

## Abschluss-Ausgabe (GitLab)

```text
  Repo   : https://gitlab.com/USER/my-project
  Clone  : git clone https://gitlab.com/USER/my-project.git <TargetWorkspace>/MyProject
```

Wenn der Projektname normalisiert wurde:

```text
  GitLab-Slug : my-project (normalisiert von: My Project)
  Repo        : https://gitlab.com/USER/my-project
```

---

## Rückwärtskompatibilität / Backward Compatibility

- `--no-remote` bleibt vollständig funktionsfähig unabhängig von `--platform`.
- Alle bestehenden Aufrufe ohne `--platform` funktionieren unverändert (GitHub-Default).
