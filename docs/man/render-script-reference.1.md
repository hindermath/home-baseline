# render-script-reference(1)

## NAME

`render-script-reference` - validate and render the complete Home Baseline
script inventory.

## SYNOPSIS

```text
bash scripts/render-script-reference.sh --repo PATH [--check-only|--dry-run] [--json]
pwsh -NoProfile -File scripts/render-script-reference.ps1 -Repo PATH [-CheckOnly|-WhatIf] [-Json]
```

## DESCRIPTION

The command validates `scripts/config/script-catalog.json` against its JSON
schema, requires every canonical script to match exactly one category, and
renders `docs/scripts/reference.md` plus `docs/scripts/embedded-scripts.md`.

Der Befehl validiert den Katalog, verlangt fuer jedes kanonische Skript genau
eine Kategorie und erzeugt die zentrale Referenz sowie die Liste eingebetteter
Skripte.

## EXIT STATUS

- `0`: current, previewed, or written successfully
- `1`: documentation drift in check mode
- `2`: usage, schema, coverage, Git, or tooling error
