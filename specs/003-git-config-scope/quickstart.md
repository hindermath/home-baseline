# Developer Quickstart: Git Configuration Scope Isolation

**Feature**: `003-git-config-scope` | **Date**: 2026-04-09

## Überblick / Overview

Diese Feature-Branch führt Git-Konfigurations-Scope-Isolierung ein. Nach dem Merge:
- Workspace-spezifische Git-Einstellungen gelten NUR innerhalb des jeweiligen Workspace-Verzeichnisses
- `~/.gitconfig` enthält nur noch minimale globale Defaults + `[includeIf]`-Blöcke
- `~/.gitconfig.d/` enthält eine `.inc`-Datei pro Workspace

*This feature branch introduces git configuration scope isolation. After merge: workspace-specific git settings apply ONLY within the respective workspace directory.*

---

## Was muss ich tun? / What do I need to do?

### 1. Manuelle Einrichtung (einmalig) / Manual setup (once)

```bash
# 1. Sync ausführen — erstellt ~/.gitconfig.d/ automatisch
bash ~/scripts/sync-home.sh --no-pull

# 2. Prüfen ob ~/.gitconfig.d/ existiert
ls ~/.gitconfig.d/
# Erwartet: home-baseline.inc

# 3. Eigene Workspace-Overrides eintragen (optional)
# Beispiel für work@example.com nur in home-baseline-tmp:
echo '[user]
  email = work@example.com' >> ~/.gitconfig.d/home-baseline.inc

# 4. Testen
git -C ~/home-baseline-tmp config user.email    # → work@example.com
git -C ~/MyProjects config user.email           # → globaler Default
```

### 2. Neue Workspaces / New workspaces

Ab sofort setzt `bootstrap-workspace` den `includeIf`-Block automatisch:

```bash
bash ~/scripts/bootstrap-workspace.sh MyNewWorkspace

# Danach:
# ~/.gitconfig enthält [includeIf "gitdir:~/MyNewWorkspace/"]
# ~/.gitconfig.d/my-new-workspace.inc existiert (leer)
```

### 3. Check-Homogeneity

```bash
bash ~/scripts/check-homogeneity.sh
# WARN wenn ~/.gitconfig.d/ fehlt oder kein includeIf für home-baseline-tmp
# → kein Fehler, nur Hinweis
```

---

## Verzeichnisstruktur nach der Einrichtung / Directory structure after setup

```text
~/
├── .gitconfig                        ← minimal global + includeIf blocks
└── .gitconfig.d/                     ← user-owned, NICHT getrackt
    ├── home-baseline.inc             ← workspace: ~/home-baseline-tmp/
    ├── my-projects.inc               ← workspace: ~/MyProjects/ (falls vorhanden)
    └── ...
```

---

## Implementierungs-Checkliste / Implementation Checklist

Für Entwickler die diese Feature-Branch implementieren:

| # | Task | Script(s) | Constitution |
|---|---|---|---|
| 1 | `~/.gitconfig` Template: nur Globals + includeIf für home-baseline-tmp | `.gitconfig` | Principle IV |
| 2 | `sync-home`: `~/.gitconfig.d/` erstellen falls nicht vorhanden | `sync-home.sh` + `.ps1` | Principle II |
| 3 | `bootstrap-workspace`: includeIf + .inc idempotent hinzufügen | `bootstrap-workspace.sh` + `.ps1` | Principle II |
| 4 | `bootstrap-workspace`: `git config --local` für Platform-Settings | `bootstrap-workspace.sh` + `.ps1` | Principle II |
| 5 | `bootstrap-project`: bilinguales Output (NFR-001 — FR-006 bereits erfüllt) | `bootstrap-project.sh` + `.ps1` | Principle II |
| 6 | `pre-push` Hook: Scan `~/.gitconfig.d/` auf Credentials | `scripts/hooks/pre-push` | **Principle I** |
| 7 | `check-homogeneity`: GIT-SCOPE-001/002 Checks hinzufügen | `check-homogeneity.sh` + `.ps1` | Principle II |
| 8 | `README.md`: Scope-Isolation-Abschnitt hinzufügen | `README.md` | Principle IV |
| 9 | Alle Messages bilingual (DE/EN) — NFR-001 | alle geänderten Scripts | Principle II |

**Out of Scope (separate Feature)**:
- `teardown-workspace.sh/.ps1` — kommt mit Lastenheft_Workspace_Teardown.md

---

## Bekannte Lücken bis teardown-workspace / Known gaps until teardown-workspace

`teardown-workspace.sh/.ps1` ist noch nicht implementiert (separates Feature, Lastenheft_Workspace_Teardown.md). Bis dahin gilt:

*`teardown-workspace.sh/.ps1` is not yet implemented (separate feature). Until then:*

Wenn ein Workspace **manuell gelöscht** wird, bleiben zwei Artefakte zurück:
1. Der `[includeIf "gitdir:~/WorkspaceName/"]`-Block in `~/.gitconfig`
2. Die Datei `~/.gitconfig.d/<workspacename>.inc`

Diese Artefakte sind **harmlos** (git ignoriert `includeIf`-Pfade, die nicht existieren), müssen aber manuell bereinigt werden:

```bash
# Manuelles Bereinigen / Manual cleanup
# 1. ~/.gitconfig öffnen und den [includeIf]-Block für den gelöschten Workspace entfernen
nano ~/.gitconfig  # oder editor der Wahl / or editor of choice

# 2. .inc-Datei löschen / Delete .inc file
rm ~/.gitconfig.d/<workspacename>.inc
```

---

## Verifikation / Verification

```bash
# Dry-run Tests
bash ~/scripts/bootstrap-workspace.sh --dry-run TestWorkspace
bash ~/scripts/sync-home.sh --dry-run
bash ~/scripts/check-homogeneity.sh --dry-run

# Security: pre-push hook testen (kein tatsächlicher Push)
echo 'ghp_fake_token = test' > ~/.gitconfig.d/test.inc
# Hook sollte diese Datei beim nächsten Push blockieren
rm ~/.gitconfig.d/test.inc  # aufräumen

# Cross-platform (Windows):
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName TestWorkspace -WhatIf
pwsh ~/scripts/sync-home.ps1 -WhatIf (falls implementiert)
```

---

## PR-Anforderungen / PR requirements

Aus Constitution Principle I und Commit Standards:

1. **Für Hook-Änderungen**: PR beschreibt explizit welche Regel (Principle I) betroffen ist
2. **Scanner-Output**: `bash scripts/scan-agent-secrets.sh --fail-on-high` ausführen und Output anhängen
3. **Manual verification**: `--dry-run` / `-WhatIf` Output für alle geänderten Scripts
4. **Sample console output** für alle neuen Benutzerausgaben
