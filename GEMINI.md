# Workspace Context: home-baseline (Root)

Dieses Repository ist die **oberste Ebene** der Workspace-Infrastruktur. Es dient als "Baseline" für die gesamte Entwicklungsumgebung und bietet Automatisierungswerkzeuge, um neue Projektverzeichnisse (Workspaces) standardisiert einzurichten.

## 🛠 Überblick / Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.gemini`, `.claude`, `.vscode`, etc.).

## 📂 Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-tmp   # ← start Gemini CLI here
gemini
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

## 🚀 Key Workflows & Commands

### Einen neuen Workspace einrichten
Um ein neues Projektverzeichnis als standardisierten Workspace mit GitHub-Anbindung zu initialisieren:
```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Windows (PowerShell Core)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>
```
*Dieser Vorgang erstellt das Verzeichnis, initialisiert Git, kopiert die Baseline-Skripte, erstellt ein privates GitHub-Repo und installiert die Hooks.*

### Einen Workspace entfernen
Workspace sicher entfernen (Remote, lokales Verzeichnis, Artefakte):
```bash
# macOS / Linux
bash ~/scripts/teardown-workspace.sh <WorkspaceName>
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --backup      # Archiv vor Löschung
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --keep-remote # Remote behalten
bash ~/scripts/teardown-workspace.sh -- <WorkspaceName>            # Name beginnt mit -
```
```powershell
# Windows
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name>
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -Backup
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -KeepRemote
```

### Sicherheit & Wartung
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`

### Plattform-Test / Platform test
Falls Terminal-Output nicht zwischen Maschinen copy-pastebaar ist, passende Test-Scripts verwenden:
```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh     # macOS
bash ~/home-baseline-tmp/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1  # Windows
```
Ergebnisse landen als `mac-test-output.txt`, `linux-test-output.txt` bzw. `windows-test-output.txt` im Repo und können von jedem Gerät gelesen werden.

*Use the matching platform test script to collect results, commit and push them. Output files are in the repo and readable from any device.*

## 🖥 OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

Zu Beginn jeder Session das Betriebssystem ermitteln und die passende Skript-Variante aufrufen:

| Betriebssystem | Shell | Endung | Erkennung |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Regel:** Auf Windows immer `pwsh scripts/xyz.ps1` aufrufen, auf macOS/Linux immer `bash scripts/xyz.sh`. Beide Varianten sind funktional äquivalent — nie mischen.

## ⚠️ Bekannte Fallstricke / Known Pitfalls

| Problem | Ursache | Fix |
|---|---|---|
| `gh auth login --web` bleibt hängen | Browser-Callback kommt in Hintergrundprozessen nicht an | In **interaktivem Terminal** ausführen |
| `glab auth login --web` bleibt hängen | Browser-Callback kommt in Hintergrundprozessen nicht an | In **interaktivem Terminal** ausführen |
| `gh` keyring invalid (Windows) | Windows Credential Store korrupt | `gh auth logout` + neu anmelden; dann `gh auth setup-git` |
| `ssh-agent` startet nicht (Windows) | Service deaktiviert, Admin nötig | HTTPS + `gh auth setup-git` verwenden |
| `CursorPosition`-Fehler in PS-Subprocess | PowerShell-Profil (Oh-My-Posh) lädt im Subprocess | `-NoProfile` zu `pwsh -File` Aufrufen hinzufügen |
| `git pull` "divergent branches" (Linux) | Kein globales rebase-Config | `git config --global pull.rebase true` |
| Push rejected: `fetch first` | Remote ist neuer als local | `git pull --rebase --autostash && git push` |
| Test-Script: unstaged changes blockieren pull | Output-Datei wird vor pull geschrieben | `git pull --rebase --autostash origin main` |
| Lastenheft nach Feature-Abschluss nicht umbenannt | `tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben) | `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` (macOS/Linux) · `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>` (Windows) |

## 📁 Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/`: Weitere Workspace-Verzeichnisse werden per `bootstrap-workspace` angelegt und hier eingetragen.
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

## 📏 Development Conventions

- **Plattformunabhängigkeit:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der Secret-Scanning in Agenten-Verzeichnissen durchführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

## 📦 Projektstatus

- **Sichtbarkeit:** Öffentliches **Template-Repo** — über „Use this template" nutzbar; kein Fork, keine History-Übertragung
- **Lizenz:** MIT
- **Branch-Schutz:** PR-Pflicht auf `main`; Admin (Eigentümer) kann direkt pushen (`enforce_admins: false`)
- **CI:** ✅ Ubuntu 22.04 · macOS 14 · Windows 2022
- **Compliance-Score:** 100 % (25/25 Checks)

## ⚠️ Bekannte Fallstricke

### Windows: `$env:HOME` ist leer, nicht `$null`
```powershell
# Falsch (??-Operator fängt '' nicht ab):
$home = $env:HOME ?? $env:USERPROFILE
# Richtig:
$home = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
```

### CI: Scanner-Verzeichnis
```bash
# Falsch (CWD = Repo-Root, Dateien nicht gefunden):
bash scripts/check-homogeneity.sh home-baseline
# Richtig (aus dem Parent heraus):
cd "$(dirname "$GITHUB_WORKSPACE")"
bash "$(basename "$GITHUB_WORKSPACE")/scripts/check-homogeneity.sh" "$(basename "$GITHUB_WORKSPACE")"
```

### `.gitignore`-Whitelist
Jede neue Datei muss explizit als `!DATEINAME` in `.gitignore` eingetragen werden, sonst wird `git add` lautlos ignoriert (z. B. `LICENSE`).

### `bootstrap-workspace`: GitHub-Username
Früher hardcodiert. Jetzt dynamisch:
```bash
GH_USER=$(gh api user --jq '.login')
```

### Doppelte Überschriften in TOC / Duplicate heading anchors
Gleiche Heading-Texte → GitHub hängt `-1`, `-2` an. TOC-Links für zweite Vorkommen müssen den Suffix enthalten.

### Bilinguale Headings Pflicht
Format: `## DE / EN` — immer. Nur-Deutsch verletzt WCAG 2.4.6 und bilinguales Konsistenzgebot.
Ausnahme: Eigennamen wie `### Homogeneity Guardian` oder `### Compliance-Check`.

### Code-Blöcke immer mit Sprach-Tag (WCAG 4.1.1)
Bare ` ``` ` ohne Sprache ist ein A11Y-Fehler. Für ASCII/Dialog/Verzeichnisse: ` ```text `.

### CHANGELOG.md hinzugefügt
Dokumentiert Versionen v0.1.0–v0.3.0. Muss in `.gitignore`-Whitelist (`!CHANGELOG.md`) eingetragen sein.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen: PowerShell `$line.Length` oder `wc -m` (Bash) für jede Rahmen-Zeile.

### Spec-Kit-Verzeichnis initialisieren
Nie manuell aus `~/home-baseline-tmp/` kopieren. Stattdessen:
`specify init --here --ai {agent}` — `--ai-skill` ist **nur für Codex** erforderlich.

<!-- EN: GEMINI.md placeholder
[DE-Zusammenfassung: GEMINI.md enthält Anweisungen für den Gemini CLI Agenten im home-baseline Repository.]
-->

## Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)

## Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf` in `~/.gitconfig`, `~/.gitconfig.d/` als workspace-spezifische Include-Fragmente; bootstrap-workspace, sync-home, check-homogeneity und pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: Added GitLab CLI support, self-hosted GitLab URL handling, and `glab auth login` pitfall guidance
