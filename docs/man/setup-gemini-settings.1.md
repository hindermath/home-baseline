# setup-gemini-settings(1)

## NAME

`setup-gemini-settings.sh`, `setup-gemini-settings.ps1` - richtet die Gemini-CLI-`status_line` in `~/.gemini/config.toml` ein. *Sets up the Gemini CLI `status_line` in `~/.gemini/config.toml`.*

## SYNOPSIS

```bash
bash scripts/setup-gemini-settings.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/setup-gemini-settings.ps1 [options]
```

## DESCRIPTION

Das Skript schreibt die transferierbare `status_line`-Konfiguration in `~/.gemini/config.toml`. Eine bestehende Konfiguration bleibt ohne `--force` erhalten; `--dry-run` zeigt nur die geplante Aenderung.

*The script writes the transferable `status_line` configuration into `~/.gemini/config.toml`. An existing configuration is preserved unless `--force` is given; `--dry-run` only previews the planned change.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Vorschau ohne Schreibvorgang |
| `--force` | `-Force` | Bestehende Konfiguration ueberschreiben |

## EXAMPLES

```bash
bash scripts/setup-gemini-settings.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/setup-gemini-settings.ps1 -Force
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler oder unbekanntes Argument / error or unknown argument |

## SEE ALSO

`setup-claude-settings.1`, `setup-codex-settings.1`, `setup-copilot-settings.1`
