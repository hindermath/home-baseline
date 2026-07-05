# rename-lastenheft(1)

## NAME

`rename-lastenheft.sh`, `rename-lastenheft.ps1` - benennt eine Lastenheft-Datei nach Feature-Abschluss um. *Renames a Lastenheft file after feature completion.*

## SYNOPSIS

```bash
bash scripts/rename-lastenheft.sh <lh-file> <branch-name>
```

```powershell
pwsh -NoProfile -File scripts/rename-lastenheft.ps1 -File <lh-file> -BranchName <branch-name>
```

## DESCRIPTION

Das Skript haengt an eine vorhandene `Lastenheft_*.md`-Datei den Feature-Branch-Namen als Suffix an, zum Beispiel `Lastenheft_Foo.md` mit Branch `003-feature` zu `Lastenheft_Foo.003-feature.md`. Es ist der letzte Task der Polish-Phase und kennzeichnet ein Lastenheft als abgeschlossen.

*The script appends the feature-branch name as a suffix to an existing `Lastenheft_*.md` file, for example `Lastenheft_Foo.md` with branch `003-feature` becomes `Lastenheft_Foo.003-feature.md`. It is the final task of the polish phase and marks a Lastenheft as completed.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `<lh-file>` | `-File <lh-file>` | Umzubenennende Lastenheft-Datei (Pflicht) |
| `<branch-name>` | `-BranchName <branch-name>` | Feature-Branch-Name als Suffix (Pflicht) |

## EXAMPLES

```bash
bash scripts/rename-lastenheft.sh Lastenheft_Foo.md 003-feature
```

```powershell
pwsh -NoProfile -File scripts/rename-lastenheft.ps1 -File Lastenheft_Foo.md -BranchName 003-feature
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | fehlende Argumente oder Datei nicht gefunden / missing arguments or file not found |

## SEE ALSO

`bootstrap-project.1`
