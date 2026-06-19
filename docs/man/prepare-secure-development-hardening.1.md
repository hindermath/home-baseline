# prepare-secure-development-hardening(1)

## Name

`prepare-secure-development-hardening` — bereitet MSL-Level-2-Repositories fuer spaetere Secure-Development-Haertung vor

*prepares MSL level-2 repositories for later secure-development hardening*

## Synopsis

```bash
bash scripts/prepare-secure-development-hardening.sh [--dry-run] [--commit] [--push] [--allow-dirty]
```

```powershell
pwsh scripts/prepare-secure-development-hardening.ps1 -WhatIf
pwsh scripts/prepare-secure-development-hardening.ps1 -Commit -Push
```

## Beschreibung / Description

`prepare-secure-development-hardening` findet Level-2-Repositories unter dem
Home-Verzeichnis, prueft die Primaersprache gegen die MSL-Allowlist aus der
Workspace-Constitution und bereitet passende Repositories fuer spaetere
Spec-Kit-Haertungslaeufe vor.

*`prepare-secure-development-hardening` discovers level-2 repositories below the
home directory, checks the primary language against the MSL allow-list from the
workspace constitution, and prepares matching repositories for later Spec Kit
hardening runs.*

Bei MSL-Repositories werden:

- `docs/secure-development/` aus der zentralen Baseline synchronisiert,
- `Lastenheft_Secure-Development-Hardening.md` erzeugt, wenn es fehlt,
- `Lastenheft_Abarbeitungsreihenfolge.md` anhand von `Lastenheft*.md` gepflegt.

*For MSL repositories, the script synchronizes `docs/secure-development/`, creates
`Lastenheft_Secure-Development-Hardening.md` when missing, and maintains
`Lastenheft_Abarbeitungsreihenfolge.md` from `Lastenheft*.md`.*

Das Skript startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und
befuellt keine projektspezifischen `docs/security/`-Nachweise. Diese Schritte
bleiben separate, explizit gestartete Haertungslaeufe.

*The script does not start a Spec Kit run, does not create a feature branch, and
does not populate project-specific `docs/security/` evidence. Those steps remain
separate hardening runs started explicitly.*

## Repo-Erkennung / Repository Discovery

Standard-Erkennung:

- Level 1: direkte Unterverzeichnisse von `~/` mit `.git`
- Level 2: direkte Unterverzeichnisse erkannter Level-1-Repos mit `.git` und
  `.specify/` oder Agenten-Dateien

*Default discovery: level 1 is each direct child of `~/` with `.git`; level 2 is
each direct child of those repositories with `.git` plus `.specify/` or agent
guidance files.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Nur anzeigen, keine Schreiboperationen |
| `--home-dir PATH` | `-HomeDir PATH` | Alternatives Home-Verzeichnis |
| `--primary-language LANG` | `-PrimaryLanguage LANG` | Primaersprache explizit setzen |
| `--commit` | `-Commit` | Pro geaendertem Repo committen |
| `--push` | `-Push` | Pro Repo pushen; aktiviert Commit |
| `--allow-dirty` | `-AllowDirty` | Bestehende lokale Aenderungen erlauben |

## Beispiele / Examples

```bash
# Nur pruefen, welche Repos vorbereitet wuerden
bash scripts/prepare-secure-development-hardening.sh --dry-run

# Sprache fuer neue/leere Repos explizit setzen
bash scripts/prepare-secure-development-hardening.sh --dry-run --primary-language C#

# Vorbereiten, committen und pushen
bash scripts/prepare-secure-development-hardening.sh --commit --push
```

```powershell
# Windows / PowerShell
pwsh scripts/prepare-secure-development-hardening.ps1 -WhatIf
pwsh scripts/prepare-secure-development-hardening.ps1 -PrimaryLanguage C# -WhatIf
pwsh scripts/prepare-secure-development-hardening.ps1 -Commit -Push
```

## Sicherheit / Security

Nicht-MSL- oder unklare Repositories werden uebersprungen und melden eine
Begruendung. Eine explizite Sprache kann mit `--primary-language` /
`-PrimaryLanguage` gesetzt werden. `docs/security/` bleibt der projektspezifische
Evidenzpfad und wird nicht automatisch befuellt.

*Non-MSL or unclear repositories are skipped with a rationale. An explicit
language can be provided with `--primary-language` / `-PrimaryLanguage`.
`docs/security/` remains the project-specific evidence path and is not populated
automatically.*
