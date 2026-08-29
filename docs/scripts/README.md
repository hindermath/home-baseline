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
- [Stage-B-Betrieb / Stage B operation](../../specs/030-stage-b-rollout/quickstart.md)
- [Copilot-Review-Governance: sichere Vorschau / safe preview](../../specs/031-github-copilot-review-governance/quickstart.md)

## Sichere Reihenfolge / Safe sequence

1. Hilfe lesen: `bash scripts/<name>.sh --help` oder
   `Get-Help ./scripts/<name>.ps1 -Full`.
2. Zuerst `--check-only`, `--dry-run` oder `-WhatIf` verwenden, falls angeboten.
3. Ausgabe und Zielpfade pruefen.
4. Erst danach einen schreibenden Lauf starten.

*Read help first, use a check or preview mode when available, review output and
target paths, and only then run a writing operation.*

Für Stage B zuerst `maintain-agentic-workspace.*` mit `Preflight` und Preview
aufrufen. Reale Flottenwrites benötigen aktuelle `MergeAndSync`-Autorität;
Details zu Stop/Resume, Evidence und Sicherheitsgrenzen stehen in der
[Manpage](../man/maintain-agentic-workspace.1.md#stage-b-flottenrollout--stage-b-fleet-rollout).

*For Stage B, start with a Preflight preview. Real fleet writes need current
MergeAndSync authority; the manpage explains stop/resume, evidence, and safety
boundaries.*

## Referenz pruefen / Check the reference

```bash
bash scripts/render-script-reference.sh --repo . --check-only
bash scripts/render-script-reference.sh --repo . --dry-run
```

```powershell
pwsh -NoProfile -File scripts/render-script-reference.ps1 -Repo . -CheckOnly
pwsh -NoProfile -File scripts/render-script-reference.ps1 -Repo . -WhatIf
```
