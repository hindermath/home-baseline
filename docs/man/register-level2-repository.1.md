# register-level2-repository(1)

## Name

`register-level2-repository` - registriert ein Level-1-/Level-2-Repository in der GSDB-Registry

*registers a level-1/level-2 repository in the GSDB registry*

## Synopsis

```bash
bash scripts/register-level2-repository.sh --repo PATH [--dry-run]
```

```powershell
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo PATH -WhatIf
```

## Beschreibung / Description

Das Werkzeug aktualisiert standardmaessig
`~/.home-baseline/level2-repository-registry.json` idempotent. Die lokale
Registry ist die operative Merkliste fuer Repositories, die die Generische
Secure-Development Basis (GSDB) fuehren oder pruefen sollen. Das Repository
enthaelt mit `scripts/config/level2-repository-registry.example.json` nur eine
public-safe Vorlage.

*By default, the tool updates
`~/.home-baseline/level2-repository-registry.json` idempotently. The local
registry is the operational memory list for repositories that should carry or
check the Generic Secure Development Baseline (GSDB). The repository only keeps
`scripts/config/level2-repository-registry.example.json` as a public-safe seed.*

Wenn das Skript aus `~/scripts` gestartet wird, bleibt der Default ebenfalls die
lokale Registry unter `~/.home-baseline/`. Dadurch werden rechner- und
personenbezogene Repository-Pfade nicht in das oeffentliche Repository
geschrieben.

*When the script is started from `~/scripts`, the default still points to the
local registry under `~/.home-baseline/`. This keeps machine- and
person-specific repository paths out of the public repository.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--repo PATH` | `-Repo PATH` | Repository eintragen |
| `--registry PATH` | `-Registry PATH` | Alternative Registry-Datei |
| `--level 1\|2` | `-Level 1\|2` | Level explizit setzen |
| `--primary-language LANG` | `-PrimaryLanguage LANG` | Primaersprache explizit setzen |
| `--gsdb-required true\|false` | `-GsdbRequired true\|false` | GSDB-Pflicht explizit setzen |
| `--preset-profile NAME` | `-PresetProfile NAME` | Preset-Profil dokumentieren |
| `--role NAME` | `-Role NAME` | Rolle im Repo-Bestand dokumentieren |
| `--source NAME` | `-Source NAME` | Quelle der Registrierung dokumentieren |
| `--dry-run` | `-WhatIf` | Nur anzeigen, nicht schreiben |

## Beispiele / Examples

```bash
bash scripts/register-level2-repository.sh --repo ~/RiderProjects/TuiVision --dry-run
bash scripts/register-level2-repository.sh --repo ~/SecureCaseTrackerProjects/SecureCaseTracker-Rust --primary-language Rust
```

```powershell
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/RiderProjects/TuiVision -WhatIf
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/SecureCaseTrackerProjects/SecureCaseTracker-Rust -PrimaryLanguage Rust
```

## Sicherheit / Security

Die Registry ist ein Zielregister, kein Sicherheitsnachweis. Projektspezifische
Nachweise bleiben im jeweiligen Repository, bevorzugt unter `docs/security/`.

*The registry is a target registry, not security evidence. Project-specific
evidence remains in the respective repository, preferably under
`docs/security/`.*
