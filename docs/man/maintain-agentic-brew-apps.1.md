# maintain-agentic-brew-apps(1)

## Name

`maintain-agentic-brew-apps` - pflegt die Homebrew-/apt-Toolchain fuer agentische Entwicklung

*maintains the Homebrew/apt toolchain for agentic development*

## Synopsis

```bash
bash scripts/maintain-agentic-brew-apps.sh [--dry-run] [--compare-only] [--skip-upgrade] [--include-optional]
```

## Beschreibung / Description

Das Werkzeug liest
`scripts/config/brew-apps-registry.json` und gleicht die lokale macOS-/Linux-
Toolchain fuer agentische Entwicklung ab. Auf Systemen mit Homebrew fuehrt ein
normaler Lauf `brew update`, `brew upgrade` und die Installation fehlender
Required-Formulae aus. Auf macOS werden zusaetzlich Required-Casks gepflegt.

*The tool reads `scripts/config/brew-apps-registry.json` and reconciles the
local macOS/Linux toolchain for agentic development. On systems with Homebrew, a
normal run executes `brew update`, `brew upgrade`, and installs missing required
formulae. On macOS it also maintains required casks.*

Wenn Linux kein `brew`, aber `apt` bereitstellt, nutzt das Skript den explizit
dokumentierten apt-Fallback aus der Registry: `sudo apt update`,
`sudo apt upgrade` und nur die dort gemappten Pakete. Die Homebrew-Registry
enthaelt Top-Level-Pakete (`brew leaves --installed-on-request`) und macOS-Casks,
keine transitiven Abhaengigkeiten. `xquartz` ist bewusst ausgeschlossen.

*When Linux has no `brew` but provides `apt`, the script uses the explicitly
documented apt fallback from the registry: `sudo apt update`,
`sudo apt upgrade`, and only the mapped packages. The Homebrew registry contains
top-level packages (`brew leaves --installed-on-request`) and macOS casks, not
transitive dependencies. `xquartz` is intentionally excluded.*

## Optionen / Options

| Option | Bedeutung / Meaning |
|---|---|
| `--dry-run` | Paketmanager-Aktionen anzeigen, nicht ausfuehren |
| `--compare-only` | Nur Registry-Drift melden, nichts installieren oder upgraden |
| `--registry PATH` | Alternative Registry-Datei verwenden |
| `--skip-upgrade` | `brew update`/`brew upgrade` bzw. apt-Update/Upgrade ueberspringen |
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
- `--compare-only` meldet keine fehlenden Required-Tools.
- `python3 -m json.tool scripts/config/brew-apps-registry.json` ist erfolgreich.
- Neue bewusst installierte Top-Level-Tools werden in der Registry nachgetragen.

*`gitleaks version` works, `--compare-only` reports no missing required tools,
the registry is valid JSON, and intentional new top-level tools are added to the
registry.*

## Sicherheit / Security

Die Registry enthaelt nur Paketnamen und Zwecke, keine Secrets, lokalen Tokens
oder privaten Pfade. Paketmanager-Laeufe schreiben ausserhalb des Repositories
und sollen vorab mit `--dry-run` geprueft werden.

*The registry contains only package names and purposes, not secrets, local
tokens, or private paths. Package-manager runs write outside the repository and
should be previewed with `--dry-run` first.*
