# propagate-agentic-toolchain-maintenance(1)

## Name

`propagate-agentic-toolchain-maintenance` - synchronisiert das kanonische
Toolchain-Wartungspaket in bestehende Level-1-/Level-2-Repositories

*synchronizes the canonical toolchain maintenance package into existing
Level-1/Level-2 repositories*

## Synopsis

```bash
bash scripts/propagate-agentic-toolchain-maintenance.sh [OPTIONEN]
```

```powershell
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1 [-DryRun] [-CheckOnly]
```

## Beschreibung / Description

Level-0 unter `~/home-baseline-tmp` ist die kanonische Quelle fuer die beiden
Toolchain-Wartungsskripte, deren fuenf JSON-Registries und die beiden
Wartungs-Manpages. Die verwaltete Dateiliste steht in
`scripts/config/agentic-toolchain-maintenance-files.json`.

Das Werkzeug vereinigt die dynamische Repository-Erkennung mit der lokalen
Level-2-Registry. Es kopiert nur fehlende oder abweichende Dateien und loescht
nichts. Wenn eine verwaltete Zieldatei lokal veraendert oder als abweichende
unversionierte Datei vorhanden ist, wird das gesamte Repository uebersprungen.
Andere lokale Aenderungen bleiben unberuehrt.

*Level-0 under `~/home-baseline-tmp` is the canonical source for both toolchain
maintenance scripts, their five JSON registries, and both maintenance man
pages. The managed file list lives in
`scripts/config/agentic-toolchain-maintenance-files.json`.*

*The tool combines dynamic repository discovery with the local Level-2
registry. It copies only missing or different files and deletes nothing. If a
managed target file has a local modification or exists as a different
untracked file, the complete repository is skipped. Other local changes remain
untouched.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-DryRun` oder `-WhatIf` | Vorschau ohne Schreiben / Preview without writing |
| `--check-only` | `-CheckOnly` | Drift pruefen; Exit 1 bei Abweichungen / Check drift; exit 1 on differences |
| `--only-level1` | `-OnlyLevel1` | Nur Level-1 / Level-1 only |
| `--only-level2` | `-OnlyLevel2` | Nur Level-2 / Level-2 only |
| `--repo PATH` | `-Repo PATH` | Einzelnes Repository / Single repository |
| `--home-dir PATH` | `-HomeDir PATH` | Alternative Erkennungsbasis / Alternative discovery root |
| `--registry PATH` | `-Registry PATH` | Alternative Level-2-Registry |
| `--manifest PATH` | `-Manifest PATH` | Alternative kanonische Dateiliste / Alternative canonical file manifest |
| `--verbose` | `-Verbose` | Unveraenderte Dateien anzeigen / Show unchanged files |

## Sicherer Ablauf / Safe Workflow

```bash
bash scripts/propagate-agentic-toolchain-maintenance.sh --dry-run
bash scripts/propagate-agentic-toolchain-maintenance.sh
bash scripts/propagate-agentic-toolchain-maintenance.sh --check-only
```

```powershell
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1 -WhatIf
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1 -CheckOnly
```

Das Werkzeug fuehrt absichtlich keine Git-Commits oder Pushes aus. Nach der
Propagation werden ausschliesslich die im Manifest genannten Dateien geprueft,
gestaged, commitet und gepusht.

*The tool intentionally performs no Git commits or pushes. After propagation,
only files named by the manifest are reviewed, staged, committed, and pushed.*

## Exitcodes / Exit Codes

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | Erfolgreich; im Check-Modus kein Drift / Success; no drift in check mode |
| `1` | Check-Modus hat Drift gefunden / Check mode found drift |
| `2` | Eingabe-, Manifest-, Erkennungs- oder Schutzfehler / Input, manifest, discovery, or protection error |

## Dateien / Files

- `scripts/config/agentic-toolchain-maintenance-files.json`
- `~/.home-baseline/level2-repository-registry.json`
- `scripts/maintain-agentic-brew-apps.sh`
- `scripts/maintain-agentic-winget-apps.ps1`
