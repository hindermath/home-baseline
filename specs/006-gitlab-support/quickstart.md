# Quickstart: GitLab Support for Bootstrap Scripts

**Feature**: `006-gitlab-support`  
**Date**: 2026-04-10

---

## Voraussetzungen / Prerequisites

1. **GitLab CLI installieren / Install GitLab CLI**:
   ```bash
   # macOS/Linux
   brew install glab

   # Windows
   winget install GLabCLI.GlabCLI
   ```

2. **GitLab CLI authentifizieren / Authenticate**:
   ```bash
   glab auth login
   # → Wähle gitlab.com oder eine Self-hosted-Instanz
   # → Folge dem Web-Login oder gib einen Token ein
   ```
   Immer in einem **interaktiven Terminal** ausführen — nicht in Background-Prozessen!
   *Always run in an **interactive terminal** — not in background processes!*

---

## Verwendung / Usage

### Workspace auf GitLab erstellen / Create workspace on GitLab

```bash
# Dry-run (Vorschau / preview)
bash ~/scripts/bootstrap-workspace.sh --dry-run MyWorkspace --platform gitlab

# Ausführen / Execute
bash ~/scripts/bootstrap-workspace.sh MyWorkspace --platform gitlab

# Mit Self-hosted GitLab
bash ~/scripts/bootstrap-workspace.sh MyWorkspace --platform gitlab \
  --gitlab-url https://gitlab.example.com
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName MyWorkspace -Platform gitlab
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName MyWorkspace -Platform gitlab `
  -GitLabUrl https://gitlab.example.com
```

### Projekt auf GitLab erstellen / Create project on GitLab

```bash
# Dry-run
bash ~/scripts/bootstrap-project.sh MyProject ~/MyWorkspace --dry-run --platform gitlab

# Ausführen
bash ~/scripts/bootstrap-project.sh MyProject ~/MyWorkspace --platform gitlab

# Ohne Remote
bash ~/scripts/bootstrap-project.sh MyProject ~/MyWorkspace --platform gitlab --no-remote
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MyProject -TargetWorkspace ~/MyWorkspace -Platform gitlab -Preview

pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MyProject -TargetWorkspace ~/MyWorkspace -Platform gitlab

pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MyProject -TargetWorkspace ~/MyWorkspace -Platform gitlab -NoRemote

pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MyProject -TargetWorkspace ~/MyWorkspace -Platform gitlab `
  -GitLabUrl https://gitlab.example.com -Preview
```

---

## Ablauf (GitLab-Pfad) / Flow (GitLab path)

```text
1. Parameter validieren (--platform, --gitlab-url)
2. glab-Installation prüfen          → Fehler + Installationsanleitung wenn fehlt
3. glab-Authentifizierung prüfen     → Fehler + 'glab auth login' wenn nicht eingeloggt
4. GitLab-Benutzernamen ermitteln    → glab api user --hostname ...
5. Repo-Namen normalisieren          → spaces→hyphens, lowercase
6. git init + initialer Commit       → wie bisher
7. glab repo create (privat)         → neues privates GitLab-Repo
8. git remote add origin             → https://gitlab.com/USER/SLUG.git
9. git push -u origin HEAD           → Initial-Push
10. Hooks installieren               → wie bisher
11. ~/README.md aktualisieren        → GitLab-URL im Tabelleneintrag
12. Zusammenfassung ausgeben         → platform-korrekte URLs
```

---

## Fehlerbehebung / Troubleshooting

| Fehler / Error | Lösung / Solution |
|----------------|-------------------|
| `glab nicht installiert` | `brew install glab` (macOS/Linux) oder `winget install GLabCLI.GlabCLI` (Windows) |
| `Nicht authentifiziert` | `glab auth login` in interaktivem Terminal ausführen |
| `--gitlab-url muss mit https:// beginnen` | URL prüfen: `https://gitlab.example.com` (nicht `http://`) |
| `glab repo create fehlgeschlagen` | Prüfen ob Repo-Name bereits existiert; Fehlermeldung von glab lesen |
| `git push fehlgeschlagen` | Netzwerkverbindung prüfen; Skript erneut ausführen (kein automatischer Retry) |

---

## Rückwärtskompatibilität / Backward Compatibility

Alle bisherigen Aufrufe ohne `--platform` funktionieren weiterhin unverändert:

```bash
bash ~/scripts/bootstrap-workspace.sh MyWorkspace    # → GitHub (default, unverändert)
bash ~/scripts/bootstrap-project.sh MyProject ~/WS  # → GitHub (default, unverändert)
```
