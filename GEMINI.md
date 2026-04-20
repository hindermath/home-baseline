# Workspace Context: home-baseline (Root)

Dieses Repository ist die **oberste Ebene** der Workspace-Infrastruktur. Es dient als "Baseline" für die gesamte Entwicklungsumgebung und bietet Automatisierungswerkzeuge, um neue Projektverzeichnisse (Workspaces) standardisiert einzurichten.

## Überblick & Architektur / Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.gemini`, `.claude`, `.vscode`, etc.).

## Arbeitsverzeichnis / Working Directory

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

## Zentrale Abläufe & Befehle / Key Workflows & Commands

### Neuen Workspace einrichten / Create a New Workspace
Um ein neues Projektverzeichnis als standardisierten Workspace mit GitHub-Anbindung zu initialisieren:
```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Windows (PowerShell Core)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>
```
*Dieser Vorgang erstellt das Verzeichnis, initialisiert Git, kopiert die Baseline-Skripte, erstellt ein privates GitHub-Repo und installiert die Hooks.*

### Workspace entfernen / Remove a Workspace
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

### Sicherheit & Wartung / Security & Maintenance
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`
- **Lokales Agent-Audit fuer spaetere Herkunftsspur:**
  `bash scripts/audit-agent-changes.sh snapshot`
  `bash scripts/audit-agent-changes.sh report`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report`

Das Agent-Audit speichert eine lokale Baseline unter `~/.home-baseline/agent-audit/` und vergleicht spaetere Aenderungen in agentverwalteten Dateien gegen diese Baseline. Die Zuordnung zu Codex, Claude, Copilot oder Continue ist bewusst heuristisch und dient der lokalen Nachvollziehbarkeit, nicht als manipulationssicherer Beweis.

### Plattform-Test / Platform Test
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

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

Zu Beginn jeder Session das Betriebssystem ermitteln und die passende Skript-Variante aufrufen:

| Betriebssystem | Shell | Endung | Erkennung |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Regel:** Auf Windows immer `pwsh scripts/xyz.ps1` aufrufen, auf macOS/Linux immer `bash scripts/xyz.sh`. Beide Varianten sind funktional äquivalent — nie mischen.

## Statistik-Pflege / Statistics Maintenance

- `docs/project-statistics.md` ist das lebende Statistik-Ledger dieses Repositories.
- Nach jedem abgeschlossenen Feature/Lastenheft, nach jeder abgeschlossenen Spec-Kit-Phase und auf explizite Anforderung aktualisieren.
- `## Fortschreibungsprotokoll` chronologisch halten: ältester Eintrag oben, neuester unten.
- `## Gesamtstatistik` bleibt immer der letzte Top-Level-Abschnitt.
- Direkt unter der Kennzahlen-Tabelle in `## Gesamtstatistik` kompakte ASCII-only-Diagramme pflegen: mindestens Artefaktmix, Phasenvolumen, konservative Referenz-Balken, Beschleunigungsfaktoren und Vergleich Erfahren/Thorsten-Solo/KI-sichtbar.
- Jedes ASCII-Diagramm bekommt eine kurze CEFR-B2-Erklärung in DE zuerst, EN danach.
- Textfreundlich bleiben: keine farbabhängigen Signale und keine Symbole, die auf Braille-Zeilen oder mit Screenreadern schlecht lesbar sind.
- Für dieses Repository gelten `80` Zeilen/Arbeitstag als konservative Referenz und `100` Zeilen/Arbeitstag als Thorsten-Solo-Basis für Scripting-Infrastruktur.
- Gemeinsame Default-Basis für C#/.NET-Repositories: `125` Zeilen/Arbeitstag, sofern das jeweilige Repo keinen abweichenden, begründeten Wert dokumentiert.
- TVöD-Basis: `7.8 h` pro Arbeitstag, `21.5` Arbeitstage pro Monat, 30 Urlaubstage bis Ende 2026 und 31 ab 2027.
- Änderungen an Statistikmethodik oder gemeinsamer Guidance immer gleichzeitig in `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` pflegen.

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` gilt repo-weit als verbindlicher Leitsatz.
- Alle nutzerseitigen Artefakte müssen barrierefrei gedacht und geprüft werden: CLI-Ausgaben, Dokumentation, HTML, UI und generierte Templates.
- WCAG 2.2 Level AA ist die praktische Standard-Basis, sobald die Kriterien auf das Artefakt anwendbar sind.
- Inhalte müssen in textorientierten Assistenz-Setups nutzbar bleiben, besonders mit Tastatur, Screenreadern, Braille-Zeilen und Textbrowsern.
- Gemeinsame Guidance und lernrelevante Doku folgen DE zuerst, EN danach; bei großen normativen Dokumenten ist eine synchron gepflegte `.EN.md`-Parallelfassung zulässig.
- Shared guidance nie nur hier ändern: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` werden gemeinsam gepflegt; Abweichungen müssen in derselben Änderung begründet werden.

## Zentrale Verzeichnisse / Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/`: Weitere Workspace-Verzeichnisse werden per `bootstrap-workspace` angelegt und hier eingetragen.
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

## Entwicklungskonventionen / Development Conventions

- **Plattformunabhängigkeit & Dokumentation:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen. Jedes Skript erfordert eine Unix man-Page (`.sh`, in `docs/man/`), eine vollständige PowerShell-Hilfe (`.ps1`) und muss zusätzlich als PowerShell Cmdlet (Advanced Function) im `Verb-Noun` Format verfügbar sein.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der Secret-Scanning in Agenten-Verzeichnissen durchführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

## Projektstatus / Repository Status

- **Sichtbarkeit:** Öffentliches **Template-Repo** — über „Use this template" nutzbar; kein Fork, keine History-Übertragung
- **Lizenz:** MIT
- **Branch-Schutz:** PR-Pflicht auf `main`; Admin (Eigentümer) kann direkt pushen (`enforce_admins: false`)
- **CI:** ✅ Ubuntu 22.04 · macOS 14 · Windows 2022
- **Compliance-Score:** 100 % (25/25 Checks)

## Bekannte Fallstricke / Known Pitfalls

### `gh auth login --web` bleibt hängen / `gh auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `glab auth login --web` bleibt hängen / `glab auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `gh`-Keyring ungültig (Windows) / `gh` Keyring Invalid (Windows)
Windows Credential Store korrupt.
`gh auth logout` + neu anmelden; danach `gh auth setup-git`.

### `ssh-agent` startet nicht (Windows) / `ssh-agent` Does Not Start (Windows)
Service deaktiviert, Admin nötig.
HTTPS + `gh auth setup-git` verwenden.

### `CursorPosition`-Fehler in PS-Subprocess / `CursorPosition` Error in PowerShell Subprocess
PowerShell-Profil (Oh-My-Posh) lädt im Subprozess.
`-NoProfile` zu `pwsh -File`-Aufrufen hinzufügen.

### `git pull` meldet divergierende Branches (Linux) / `git pull` Reports Divergent Branches (Linux)
Kein globales Rebase-Setup.
`git config --global pull.rebase true`.

### Push rejected: `fetch first` / Push Rejected: `fetch first`
Remote ist neuer als lokal.
`git pull --rebase --autostash && git push`.

### Test-Skript blockiert Pull / Test Script Blocks Pull
Output-Datei wird vor `pull` geschrieben.
`git pull --rebase --autostash origin main`.

### Lastenheft nach Feature-Abschluss nicht umbenannt / Lastenheft Not Renamed After Feature Completion
`tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben).
`bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` oder `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>`.

### Windows: `$env:HOME` ist leer, nicht `$null` / Windows: `$env:HOME` Is Empty, Not `$null`
```powershell
# Falsch (??-Operator fängt '' nicht ab):
$home = $env:HOME ?? $env:USERPROFILE
# Richtig:
$home = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
```

### CI: Scanner-Verzeichnis / CI: Scanner Directory
```bash
# Falsch (CWD = Repo-Root, Dateien nicht gefunden):
bash scripts/check-homogeneity.sh home-baseline
# Richtig (aus dem Parent heraus):
cd "$(dirname "$GITHUB_WORKSPACE")"
bash "$(basename "$GITHUB_WORKSPACE")/scripts/check-homogeneity.sh" "$(basename "$GITHUB_WORKSPACE")"
```

### `.gitignore`-Whitelist / `.gitignore` Whitelist
Jede neue Datei muss explizit als `!DATEINAME` in `.gitignore` eingetragen werden, sonst wird `git add` lautlos ignoriert (z. B. `LICENSE`).

### `bootstrap-workspace`: GitHub-Username / `bootstrap-workspace`: GitHub Username
Früher hardcodiert. Jetzt dynamisch:
```bash
GH_USER=$(gh api user --jq '.login')
```

### Doppelte Überschriften in TOC / Duplicate heading anchors
Gleiche Heading-Texte → GitHub hängt `-1`, `-2` an. TOC-Links für zweite Vorkommen müssen den Suffix enthalten.

### Pflicht für bilinguale Headings / Bilingual Heading Requirement
Format: `## DE / EN` — immer. Nur-Deutsch verletzt WCAG 2.4.6 und bilinguales Konsistenzgebot.
Ausnahme: Eigennamen wie `### Homogeneity Guardian` oder `### Compliance-Check`.

### Code-Blöcke immer mit Sprach-Tag (WCAG 4.1.1) / Code Blocks Must Always Have a Language Tag (WCAG 4.1.1)
Bare ` ``` ` ohne Sprache ist ein A11Y-Fehler. Für ASCII/Dialog/Verzeichnisse: ` ```text `.

### CHANGELOG.md hinzugefügt / CHANGELOG.md Added
Dokumentiert Versionen v0.1.0–v0.3.0. Muss in `.gitignore`-Whitelist (`!CHANGELOG.md`) eingetragen sein.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen: PowerShell `$line.Length` oder `wc -m` (Bash) für jede Rahmen-Zeile.

### Spec-Kit-Verzeichnis initialisieren / Initialize the Spec-Kit Directory
Nie manuell aus `~/home-baseline-tmp/` kopieren. Stattdessen:
`specify init --here --ai {agent}` — `--ai-skill` ist **nur für Codex** erforderlich.

<!-- EN: GEMINI.md placeholder
[DE-Zusammenfassung: GEMINI.md enthält Anweisungen für den Gemini CLI Agenten im home-baseline Repository.]
-->

## Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf` in `~/.gitconfig`, `~/.gitconfig.d/` als workspace-spezifische Include-Fragmente; bootstrap-workspace, sync-home, check-homogeneity und pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: Added GitLab CLI support, self-hosted GitLab URL handling, and `glab auth login` pitfall guidance
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
