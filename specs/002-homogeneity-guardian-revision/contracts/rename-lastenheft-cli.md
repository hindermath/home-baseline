# CLI-Vertrag: rename-lastenheft.sh / .ps1
# CLI Contract: rename-lastenheft.sh / .ps1

**FR-REV-B03**

---

## Aufruf / Invocation

```bash
# Bash
bash scripts/rename-lastenheft.sh <lh-file> <branch-name>

# PowerShell
pwsh scripts/rename-lastenheft.ps1 -File <string> -BranchName <string>
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `lh-file` / `-File` | **Ja** | Pfad zur Lastenheft-Datei (z.B. `Lastenheft_foo.md`) |
| `branch-name` / `-BranchName` | **Ja** | Aktueller Feature-Branch-Name (z.B. `002-bar`) |

## Namensformel / Naming Formula

```
{original-stem}.{branch-name}.md

Beispiel:
  Eingabe:  Lastenheft_workspace-homogeneity-guardian.md  +  002-homogeneity-guardian-revision
  Ausgabe:  Lastenheft_workspace-homogeneity-guardian.002-homogeneity-guardian-revision.md
```

## Prozessablauf / Process Flow

```
1. Stem aus Dateiname extrahieren (ohne .md-Endung)
2. Neuen Namen berechnen: {stem}.{branch}.md
3. git mv {original} {new-name}
4. git commit -m "chore: rename Lastenheft to {new-name}"
```

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Erfolgreich |
| `1` | Datei nicht gefunden oder git mv fehlgeschlagen |
