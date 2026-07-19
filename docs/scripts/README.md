# Skripte / Scripts

Dieser Ordner ist der zentrale Einstiegspunkt fuer alle ausfuehrbaren
Werkzeuge der Home Baseline. Die Referenz ist bilingual, aus dem Git-Index
generiert und unterscheidet kanonische Werkzeuge von eingebetteten Kopien.

*This directory is the central entry point for all executable Home Baseline
tools. The reference is bilingual, generated from the Git index, and separates
canonical tools from embedded copies.*

## Einstieg / Start here

- [Vollstaendige Referenz / Complete reference](reference.md)
- [Eingebettete Skripte / Embedded scripts](embedded-scripts.md)
- [Manpages](../man/)
- Maschinenlesbarer Katalog: `scripts/config/script-catalog.json`

## Sichere Reihenfolge / Safe sequence

1. Hilfe lesen: `bash scripts/<name>.sh --help` oder
   `Get-Help ./scripts/<name>.ps1 -Full`.
2. Zuerst `--check-only`, `--dry-run` oder `-WhatIf` verwenden, falls angeboten.
3. Ausgabe und Zielpfade pruefen.
4. Erst danach einen schreibenden Lauf starten.

*Read help first, use a check or preview mode when available, review output and
target paths, and only then run a writing operation.*

## Referenz pruefen / Check the reference

```bash
bash scripts/render-script-reference.sh --repo . --check-only
bash scripts/render-script-reference.sh --repo . --dry-run
```

```powershell
pwsh -NoProfile -File scripts/render-script-reference.ps1 -Repo . -CheckOnly
pwsh -NoProfile -File scripts/render-script-reference.ps1 -Repo . -WhatIf
```
