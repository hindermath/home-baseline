# register-level2-repository(1)

## Name

`register-level2-repository` - registriert ein Level-1-/Level-2-Repository in der GSDB-Registry

*registers a level-1/level-2 repository in the GSDB registry*

## Synopsis

```bash
bash scripts/register-level2-repository.sh --repo PATH [--dry-run]
bash scripts/register-level2-repository.sh --scan-root PATH [--dry-run]
```

```powershell
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo PATH -WhatIf
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -ScanRoot PATH -WhatIf
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

Mit `--scan-root` / `-ScanRoot` kann die Wartungsrunde bekannte Workspace-
Wurzeln nach Git-Repositories durchsuchen. Das ist fuer Registry-Drift gedacht:
neu hinzugekommene Level-2-Repositories werden sichtbar und koennen idempotent
in die lokale GSDB-Registry uebernommen werden. Level-2-Repositories sind
standardmaessig unabhaengig vom MSL-Status GSDB-pflichtig und verwenden das
Sieben-Preset-Profil. Begruendete Ausnahmen werden explizit gesetzt.
Eindeutige Sprachsuffixe wie `-CSharp`, `-Go` oder `-Rust` dokumentieren bei
vorbereiteten Lernrepos die Zielsprache bereits vor dem Runtime-Scaffold.
Wartungsscans bewahren staerkere vorhandene Metadaten und stufen sie nicht auf
`unknown`, `false` oder `none` herab.

*With `--scan-root` / `-ScanRoot`, the maintenance round can scan known
workspace roots for Git repositories. This is intended for registry drift:
newly added level-2 repositories become visible and can be idempotently added
to the local GSDB registry. Level-2 repositories default to GSDB-required with
the seven-preset profile independently of MSL status; justified exceptions are
explicit. Unambiguous suffixes such as `-CSharp`, `-Go`, or `-Rust` provide the
target language for prepared learning repositories before a runtime scaffold
exists. Maintenance scans preserve stronger existing metadata instead of
downgrading it to `unknown`, `false`, or `none`.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--repo PATH` | `-Repo PATH` | Repository eintragen |
| `--scan-root PATH` | `-ScanRoot PATH` | Workspace-Wurzel nach Git-Repositories scannen |
| `--registry PATH` | `-Registry PATH` | Alternative Registry-Datei |
| `--level 1\|2` | `-Level 1\|2` | Level explizit setzen |
| `--primary-language LANG` | `-PrimaryLanguage LANG` | Primaersprache explizit setzen |
| `--msl-status STATUS` | `-MslStatus STATUS` | MSL-Klassifikation explizit setzen |
| `--gsdb-required true\|false` | `-GsdbRequired true\|false` | GSDB-Pflicht explizit setzen |
| `--preset-profile NAME` | `-PresetProfile NAME` | Preset-Profil dokumentieren |
| `--role NAME` | `-Role NAME` | Rolle im Repo-Bestand dokumentieren |
| `--source NAME` | `-Source NAME` | Quelle der Registrierung dokumentieren |
| `--dry-run` | `-WhatIf` | Nur anzeigen, nicht schreiben |

## Beispiele / Examples

```bash
bash scripts/register-level2-repository.sh --repo ~/RiderProjects/TuiVision --dry-run
bash scripts/register-level2-repository.sh --repo ~/SecureCaseTrackerProjects/SecureCaseTracker-Rust --primary-language Rust
bash scripts/register-level2-repository.sh --repo ~/C64Projects/cc65 --primary-language cc65 --msl-status non-msl --gsdb-required true
bash scripts/register-level2-repository.sh --scan-root ~/RiderProjects --dry-run
bash scripts/register-level2-repository.sh --scan-root ~/SecureCaseTrackerProjects --source maintenance-discovery
```

```powershell
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/RiderProjects/TuiVision -WhatIf
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/SecureCaseTrackerProjects/SecureCaseTracker-Rust -PrimaryLanguage Rust
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/C64Projects/cc65 -PrimaryLanguage cc65 -MslStatus non-msl -GsdbRequired true
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -ScanRoot ~/RiderProjects -WhatIf
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -ScanRoot ~/SecureCaseTrackerProjects -Source maintenance-discovery
```

## Sicherheit / Security

Die Registry ist ein Zielregister, kein Sicherheitsnachweis. Projektspezifische
Nachweise bleiben im jeweiligen Repository, bevorzugt unter `docs/security/`.
`gsdbRequired=true` startet keinen Spec-Kit-Lauf und ist keine formale Freigabe.

*The registry is a target registry, not security evidence. Project-specific
evidence remains in the respective repository, preferably under
`docs/security/`. `gsdbRequired=true` neither starts a Spec Kit run nor records
a formal approval.*
