# maintain-agentic-brew-apps(1)

## Name

`maintain-agentic-brew-apps` - pflegt die Homebrew-/apt-Toolchain fuer agentische Entwicklung

*maintains the Homebrew/apt toolchain for agentic development*

## Synopsis

```bash
bash scripts/maintain-agentic-brew-apps.sh [--dry-run] [--compare-only] [--skip-upgrade] [--skip-vscode-extensions] [--include-optional]
```

## Beschreibung / Description

Das Werkzeug liest
`scripts/config/brew-apps-registry.json` und gleicht die lokale macOS-/Linux-
Toolchain fuer agentische Entwicklung ab. Zusaetzlich liest es
`scripts/config/vscode-extensions-registry.json` und pflegt die Required-VS-
Code-Extensions fuer die sechs MSL-Pfade C#, Go, Java, Python, Rust und Swift
sowie Microsoft Container Tools fuer Docker-/Podman-Workflows.
Auf Systemen mit Homebrew fuehrt ein normaler Lauf `brew update`,
`brew upgrade` und die Installation fehlender Required-Formulae aus. Auf macOS
werden zusaetzlich Required-Casks gepflegt.
Ein bereits vorhandenes App-Bundle fuer Visual Studio Code unter
`/Applications/Visual Studio Code.app` oder `~/Applications/Visual Studio Code.app`
gilt als erfuellter Required-Cask, auch wenn VS Code nicht von Homebrew
installiert wurde.

*The tool reads `scripts/config/brew-apps-registry.json` and reconciles the
local macOS/Linux toolchain for agentic development. It additionally reads
`scripts/config/vscode-extensions-registry.json` and maintains the required VS
Code extensions for the six MSL paths C#, Go, Java, Python, Rust, and Swift
plus Microsoft Container Tools for Docker/Podman workflows. On
systems with Homebrew, a normal run executes `brew update`, `brew upgrade`, and
installs missing required formulae. On macOS it also maintains required casks.
An existing Visual Studio Code app bundle under `/Applications/Visual Studio Code.app`
or `~/Applications/Visual Studio Code.app` satisfies the required cask even when
VS Code was not installed by Homebrew.*

Wenn Linux kein `brew`, aber `apt` bereitstellt, nutzt das Skript den explizit
dokumentierten apt-Fallback aus der Registry: `sudo apt update`,
`sudo apt upgrade` und nur die dort gemappten Pakete. `code` und `helix` werden
im apt-Fallback nur installiert, wenn sie in den bereits konfigurierten apt-
Quellen verfuegbar sind. Die Homebrew-Registry enthaelt Top-Level-Pakete
(`brew leaves --installed-on-request`) und macOS-Casks, keine transitiven
Abhaengigkeiten. `xquartz` ist bewusst ausgeschlossen.

*When Linux has no `brew` but provides `apt`, the script uses the explicitly
documented apt fallback from the registry: `sudo apt update`,
`sudo apt upgrade`, and only the mapped packages. In the apt fallback, `code`
and `helix` are installed only when available from the already configured apt
sources. The Homebrew registry contains top-level packages
(`brew leaves --installed-on-request`) and macOS casks, not transitive
dependencies. `xquartz` is intentionally excluded.*

## Optionen / Options

| Option | Bedeutung / Meaning |
|---|---|
| `--dry-run` | Paketmanager-Aktionen anzeigen, nicht ausfuehren |
| `--compare-only` | Registry-Drift nach Required/Optional getrennt melden, nichts installieren oder upgraden |
| `--registry PATH` | Alternative Registry-Datei verwenden |
| `--vscode-registry PATH` | Alternative VS-Code-Extension-Registry verwenden |
| `--skip-upgrade` | `brew update`/`brew upgrade` bzw. apt-Update/Upgrade ueberspringen |
| `--skip-vscode-extensions` | VS-Code-Extensions weder installieren noch vergleichen |
| `--include-optional` | Auch optionale Registry-Eintraege installieren |
| `-h`, `--help` | Hilfe anzeigen |

## Beispiele / Examples

```bash
bash scripts/maintain-agentic-brew-apps.sh --dry-run
bash scripts/maintain-agentic-brew-apps.sh --compare-only
bash scripts/maintain-agentic-brew-apps.sh
```

## Abschlusskriterien / Closeout Criteria

- `gitleaks version` funktioniert.
- `code --version` und `hx --version` funktionieren, sofern die Plattform die grafische bzw. TUI-Editor-Basis installieren konnte.
- `--compare-only` meldet `missing_on_machine.required.*: none`.
- `python3 -m json.tool scripts/config/brew-apps-registry.json` ist erfolgreich.
- `python3 -m json.tool scripts/config/vscode-extensions-registry.json` ist erfolgreich.
- Neue bewusst installierte Top-Level-Tools werden in der Registry nachgetragen.

*`gitleaks version` works, `code --version` and `hx --version` work where the
platform could install the graphical/TUI editor baseline, `--compare-only`
reports `missing_on_machine.required.*: none`, the registries are valid JSON, and
intentional new top-level tools are added to the registry.*

## Sicherheit / Security

Die Registry enthaelt nur Paketnamen und Zwecke, keine Secrets, lokalen Tokens
oder privaten Pfade. Paketmanager-Laeufe schreiben ausserhalb des Repositories
und sollen vorab mit `--dry-run` geprueft werden.

*The registry contains only package names and purposes, not secrets, local
tokens, or private paths. Package-manager runs write outside the repository and
should be previewed with `--dry-run` first.*
