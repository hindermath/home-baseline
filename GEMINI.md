# Workspace Context: home-baseline (Root)

Dieses Repository ist die **oberste Ebene** der Workspace-Infrastruktur von Thorsten Hindermann. Es dient als "Baseline" für die gesamte Entwicklungsumgebung und bietet Automatisierungswerkzeuge, um neue Projektverzeichnisse (Workspaces) standardisiert einzurichten.

## 🛠 Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.gemini`, `.claude`, `.vscode`, etc.).

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

### Sicherheit & Wartung
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`

## 📁 Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/RiderProjects/`: C# / .NET Entwicklung (Primäre IDE: JetBrains Rider).
- `~/C64Projects/`: C64 & Atari 8-Bit Entwicklung (Toolchain: cc65, VICE).
- `~/VST_SDK/`: Entwicklung von VST3-Audio-Plugins (CLion/Xcode).
- `~/DataGripProjects/`: Datenbank-Projekte (SQLite, PostgreSQL, MongoDB).
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

## 📏 Development Conventions

- **Plattformunabhängigkeit:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der Secret-Scanning in Agenten-Verzeichnissen durchführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

## 👤 User Profile: Thorsten Hindermann

- **Rolle:** Betriebsratvorsitzender, Mentor für Fachinformatiker.
- **Sprache:** Deutsch (bevorzugt informelles "du").
- **Primäre Tech-Stacks:** C# (.NET Framework), C (cc65/C64), VST3-Entwicklung, PowerShell.
- **Interessen:** US-Navy Geschichte (Flugzeugträger ab 1950), Musikproduktion (HTMAN), Retro-Computing (C64, Atari, HP/TI Taschenrechner).
- **Hardware/OS:** macOS (Darwin), Xbox Series S, Commodore 64 (Ultimate 64).
