# prepare-rl-se-checklist-selbstpruefung(1)

## Name

`prepare-rl-se-checklist-selbstpruefung` — bereitet Repositories fuer spaetere RL-SE-/Checklist-Selbstpruefung vor

*prepares repositories for later RL-SE / checklist self-assessment*

## Synopsis

```bash
bash scripts/prepare-rl-se-checklist-selbstpruefung.sh [--repo PATH] [--dry-run] [--commit] [--push] [--allow-dirty]
```

```powershell
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -WhatIf
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -Repo PATH -WhatIf
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -Commit -Push
```

## Beschreibung / Description

`prepare-rl-se-checklist-selbstpruefung` findet Repositories unter dem
Home-Verzeichnis oder nutzt explizite `--repo`-/`-Repo`-Ziele. Es synchronisiert
die zentrale Secure-Development-Basis, erzeugt bei Bedarf
`Lastenheft_RL-SE-Checklist-Selbstpruefung.md` und pflegt die sichtbare
`Lastenheft_Abarbeitungsreihenfolge.md`.

*`prepare-rl-se-checklist-selbstpruefung` discovers repositories below the home
directory or uses explicit `--repo` / `-Repo` targets. It synchronizes the
central secure-development baseline, creates
`Lastenheft_RL-SE-Checklist-Selbstpruefung.md` when missing, and maintains the
visible `Lastenheft_Abarbeitungsreihenfolge.md`.*

Die Vorbereitung ist nicht auf Memory-Safe Languages beschraenkt. MSL-Status ist
ein Pruefpunkt des spaeteren Spec-Kit-Laufs, aber keine Voraussetzung fuer diese
Vorbereitung.

*The preparation is not limited to memory-safe languages. MSL status is a
checkpoint of the later Spec Kit run, but not a prerequisite for this
preparation.*

Das Skript startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und
befuellt keine projektspezifischen `docs/security/`-Nachweise.

*The script does not start a Spec Kit run, does not create a feature branch, and
does not populate project-specific `docs/security/` evidence.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Nur anzeigen, keine Schreiboperationen |
| `--home-dir PATH` | `-HomeDir PATH` | Alternatives Home-Verzeichnis |
| `--repo PATH` | `-Repo PATH` | Explizites Repository vorbereiten; wiederholbar |
| `--primary-language LANG` | `-PrimaryLanguage LANG` | Optionale Sprachinformation, blockiert nicht |
| `--commit` | `-Commit` | Pro geaendertem Repo committen |
| `--push` | `-Push` | Pro Repo pushen; aktiviert Commit |
| `--allow-dirty` | `-AllowDirty` | Bestehende lokale Aenderungen erlauben |

## Beispiele / Examples

```bash
bash scripts/prepare-rl-se-checklist-selbstpruefung.sh --dry-run
bash scripts/prepare-rl-se-checklist-selbstpruefung.sh --repo ~/RiderProjects/TuiVision --dry-run
bash scripts/prepare-rl-se-checklist-selbstpruefung.sh --repo ~/RiderProjects/TinyCalc --commit --push
```

```powershell
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -WhatIf
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -Repo ~/RiderProjects/TuiVision -WhatIf
pwsh scripts/prepare-rl-se-checklist-selbstpruefung.ps1 -Repo ~/RiderProjects/TinyCalc -Commit -Push
```

## Sicherheit / Security

Das erzeugte Lastenheft verlangt `Applicable`, `AlreadySatisfied`, `N/A`,
`Open` und `FollowUp` mit Begruendung, Evidenzpfad, Owner, Follow-up,
Re-Evaluation-Trigger und Restrisiko. Human-only-Punkte wie formale Freigabe,
QISMS-Eintraege, Branch-Protection, Secrets, Provider und Modellfreigaben
duerfen nicht als erledigt behauptet werden.

*The generated intake requires `Applicable`, `AlreadySatisfied`, `N/A`, `Open`,
and `FollowUp` with rationale, evidence path, owner, follow-up, re-evaluation
trigger, and residual risk. Human-only points such as formal approval, QISMS
entries, branch protection, secrets, providers, and model approvals must not be
claimed as done.*
