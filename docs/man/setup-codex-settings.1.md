# setup-codex-settings(1)

## NAME

`setup-codex-settings.sh`, `setup-codex-settings.ps1` - richtet die Codex-CLI-`status_line` in `~/.codex/config.toml` ein. *Sets up the Codex CLI `status_line` in `~/.codex/config.toml`.*

## SYNOPSIS

```bash
bash scripts/setup-codex-settings.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/setup-codex-settings.ps1 [options]
```

## DESCRIPTION

Das Skript schreibt die transferierbare `status_line`-Konfiguration in `~/.codex/config.toml`. Eine bestehende Konfiguration bleibt ohne `--force` erhalten; `--dry-run` zeigt nur die geplante Aenderung.

*The script writes the transferable `status_line` configuration into `~/.codex/config.toml`. An existing configuration is preserved unless `--force` is given; `--dry-run` only previews the planned change.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Vorschau ohne Schreibvorgang |
| `--force` | `-Force` | Bestehende Konfiguration ueberschreiben |

## EXAMPLES

```bash
bash scripts/setup-codex-settings.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/setup-codex-settings.ps1 -Force
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler oder unbekanntes Argument / error or unknown argument |

## SEE ALSO

`setup-claude-settings.1`, `setup-copilot-settings.1`, `setup-gemini-settings.1`
