# setup-claude-settings(1)

## NAME

`setup-claude-settings.sh`, `setup-claude-settings.ps1` - richtet die Claude-Code-statusLine in `~/.claude/settings.json` ein. *Sets up the Claude Code statusLine in `~/.claude/settings.json`.*

## SYNOPSIS

```bash
bash scripts/setup-claude-settings.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/setup-claude-settings.ps1 [options]
```

## DESCRIPTION

Das Skript schreibt die transferierbare `statusLine`-Konfiguration in `~/.claude/settings.json`. Eine bestehende Konfiguration bleibt ohne `--force` erhalten; `--dry-run` zeigt nur die geplante Aenderung.

*The script writes the transferable `statusLine` configuration into `~/.claude/settings.json`. An existing configuration is preserved unless `--force` is given; `--dry-run` only previews the planned change.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Vorschau ohne Schreibvorgang |
| `--force` | `-Force` | Bestehende Konfiguration ueberschreiben |

## EXAMPLES

```bash
bash scripts/setup-claude-settings.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/setup-claude-settings.ps1 -Force
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler oder unbekanntes Argument / error or unknown argument |

## SEE ALSO

`setup-codex-settings.1`, `setup-copilot-settings.1`, `setup-gemini-settings.1`
