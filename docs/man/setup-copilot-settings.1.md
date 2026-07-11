# setup-copilot-settings(1)

## NAME

`setup-copilot-settings.sh`, `setup-copilot-settings.ps1` - uebertraegt die GitHub-Copilot-CLI-Einstellungen nach `~/.copilot/config.json`. *Transfers the GitHub Copilot CLI settings into `~/.copilot/config.json`.*

## SYNOPSIS

```bash
bash scripts/setup-copilot-settings.sh [options]
```

```powershell
pwsh -NoProfile -File scripts/setup-copilot-settings.ps1 [options]
```

## DESCRIPTION

Das Skript schreibt die transferierbaren Einstellungen (`effortLevel`, `banner`, `renderMarkdown`, `theme`) nach `~/.copilot/config.json`. Maschinenspezifische Werte wie `logged_in_users`, `trusted_folders` und `firstLaunchAt` werden nicht uebertragen. Eine bestehende Konfiguration bleibt ohne `--force` erhalten; `--dry-run` zeigt nur die geplante Aenderung.

*The script writes the transferable settings (`effortLevel`, `banner`, `renderMarkdown`, `theme`) into `~/.copilot/config.json`. Machine-specific values such as `logged_in_users`, `trusted_folders`, and `firstLaunchAt` are not transferred. An existing configuration is preserved unless `--force` is given; `--dry-run` only previews the planned change.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Vorschau ohne Schreibvorgang |
| `--force` | `-Force` | Bestehende Konfiguration ueberschreiben |
| `--effort=<low\|medium\|high>` | `-EffortLevel <low\|medium\|high>` | Reasoning-Tiefe der Statusline |
| `--theme=<auto\|light\|dark>` | `-Theme <auto\|light\|dark>` | Farbthema |

## EXAMPLES

```bash
bash scripts/setup-copilot-settings.sh --effort=high --theme=dark
```

```powershell
pwsh -NoProfile -File scripts/setup-copilot-settings.ps1 -EffortLevel high -Theme dark
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | Fehler, ungueltiger Wert oder unbekanntes Argument / error, invalid value, or unknown argument |

## SEE ALSO

`setup-claude-settings.1`, `setup-codex-settings.1`, `setup-antigravity-settings.1`
