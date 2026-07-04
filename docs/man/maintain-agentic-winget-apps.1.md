# maintain-agentic-winget-apps(1)

## Name

`maintain-agentic-winget-apps` - pflegt die WinGet-Toolchain fuer agentische Entwicklung

*maintains the WinGet toolchain for agentic development*

## Synopsis

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 [-WhatIf] [-CompareOnly] [-SkipUpgrade] [-SkipVSCodeExtensions] [-IncludeOptional]
```

## Beschreibung / Description

Das Werkzeug liest
`scripts/config/winget-apps-registry.json` und gleicht die Windows-Toolchain fuer
agentische Entwicklung ab. Zusaetzlich liest es
`scripts/config/vscode-extensions-registry.json` und pflegt die Required-VS-
Code-Extensions fuer die sechs MSL-Pfade C#, Go, Java, Python, Rust und Swift
sowie Microsoft Container Tools fuer Docker-/Podman-Workflows.
Ein normaler Lauf aktualisiert WinGet-Quellen, fuehrt `winget upgrade --all`
aus und installiert fehlende Required-Pakete per `winget install --id <Id>
--exact`.

*The tool reads `scripts/config/winget-apps-registry.json` and reconciles the
Windows toolchain for agentic development. It additionally reads
`scripts/config/vscode-extensions-registry.json` and maintains the required VS
Code extensions for the six MSL paths C#, Go, Java, Python, Rust, and Swift
plus Microsoft Container Tools for Docker/Podman workflows. A
normal run refreshes WinGet sources, runs `winget upgrade --all`, and installs
missing required packages via `winget install --id <Id> --exact`.*

Das Skript versucht zuerst `winget update`. Wenn diese Unterfunktion auf der
installierten WinGet-Version nicht verfuegbar ist, nutzt es
`winget source update` als kompatiblen Fallback. Paket-IDs werden vor der
Installation mit `winget search --id <Id> --exact` geprueft.

*The script tries `winget update` first. If that subcommand is not available on
the installed WinGet version, it uses `winget source update` as a compatible
fallback. Package IDs are checked with `winget search --id <Id> --exact` before
installation.*

## Optionen / Options

| Option | Bedeutung / Meaning |
|---|---|
| `-WhatIf` | Paketmanager-Aktionen anzeigen, nicht ausfuehren |
| `-CompareOnly` | Nur Registry-Drift melden, nichts installieren oder upgraden |
| `-Registry PATH` | Alternative Registry-Datei verwenden |
| `-VSCodeRegistry PATH` | Alternative VS-Code-Extension-Registry verwenden |
| `-SkipUpgrade` | WinGet-Update und `winget upgrade --all` ueberspringen |
| `-SkipVSCodeExtensions` | VS-Code-Extensions weder installieren noch vergleichen |
| `-IncludeOptional` | Auch optionale Registry-Eintraege installieren |

## Beispiele / Examples

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -CompareOnly
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1
```

## Abschlusskriterien / Closeout Criteria

- `gitleaks version` funktioniert.
- `code --version` und `hx --version` funktionieren.
- `-CompareOnly` meldet keine fehlenden Required-Tools.
- `python3 -m json.tool scripts/config/winget-apps-registry.json` ist erfolgreich.
- `python3 -m json.tool scripts/config/vscode-extensions-registry.json` ist erfolgreich.
- Neue bewusst installierte WinGet-Top-Level-Tools werden in der Registry
  nachgetragen.

*`gitleaks version`, `code --version`, and `hx --version` work, `-CompareOnly`
reports no missing required tools, the registries are valid JSON, and
intentional new WinGet top-level tools are added to the registry.*

## Sicherheit / Security

Die Registry enthaelt nur Paket-IDs und Zwecke, keine Secrets, lokalen Tokens
oder privaten Pfade. WinGet-Laeufe schreiben ausserhalb des Repositories und
sollen vorab mit `-WhatIf` geprueft werden.

*The registry contains only package IDs and purposes, not secrets, local tokens,
or private paths. WinGet runs write outside the repository and should be
previewed with `-WhatIf` first.*
