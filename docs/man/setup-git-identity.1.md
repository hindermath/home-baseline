# setup-git-identity(1)

## NAME

`setup-git-identity` — prüft und richtet die globale Git-Identität ein (Name + E-Mail)
*checks and configures the global Git identity (name + email)*

## SYNOPSIS

```text
bash scripts/setup-git-identity.sh [--check-only] [--auto] [--dry-run]

pwsh -NoProfile scripts/setup-git-identity.ps1 [-CheckOnly] [-Auto] [-WhatIf]
```

## BESCHREIBUNG / DESCRIPTION

Git-Commits mit Platzhalter-Autor entstehen, wenn `~/.gitconfig` nach der
Erst-Installation nicht angepasst wurde. Das Skript erkennt die Platzhalter-Werte
`Your Name` und `your@email.example` und hilft beim dauerhaften Beheben.

*Git commits with placeholder author ("Your Name <your@email.example>") occur when
`~/.gitconfig` has not been customised after initial setup. The script detects these
placeholder values and helps fix them permanently.*

**Erkennungsquellen (in Reihenfolge) / Detection sources (in priority order):**

1. **`gh api user`** — GitHub-Profil-Name und E-Mail über GitHub CLI.
   Zuverlässigste Quelle; gibt bei verborgenem E-Mail-Feld automatisch die
   `<id>+<login>@users.noreply.github.com`-Adresse zurück.
   *Most reliable source; falls back to GitHub no-reply address when email is hidden.*

2. **System-Benutzerkonto** — macOS `dscl` (RealName-Feld), Linux `getent`
   (GECOS-Feld), Windows ADSI (FullName).
   *System user account: macOS dscl, Linux getent, Windows ADSI.*

3. **`git log`** — Name und E-Mail aus vorhandenen Commits im Home-Verzeichnis
   (Platzhalter-Werte werden übersprungen).
   *Name and email from existing commits in the home directory (placeholders skipped).*

## OPTIONEN / OPTIONS

### Bash

| Option | Beschreibung / Description |
|---|---|
| `--check-only` | Nur prüfen; Exit 1 wenn Platzhalter erkannt. Kein Dialog. |
| `--auto` | Automatische Erkennung; Fehler wenn unvollständig. |
| `--dry-run` | Vorschau aller Änderungen ohne Schreiben. |
| `--help`, `-h` | Hilfemeldung anzeigen. |

### PowerShell

| Parameter | Beschreibung / Description |
|---|---|
| `-CheckOnly` | Check only; exit 1 if placeholder detected. |
| `-Auto` | Auto-detect; fail if detection is incomplete. |
| `-WhatIf` | Preview all changes without writing. |

## EXIT-CODES / EXIT CODES

| Code | Bedeutung / Meaning |
|---|---|
| `0` | Identität konfiguriert oder Platzhalter-Check bestanden. |
| `1` | Platzhalter erkannt (`--check-only`) oder Einrichtung fehlgeschlagen. |
| `2` | Ungültige Argumente. |

## VERWENDUNG IN SCRIPTS / USAGE IN SCRIPTS

Das Skript im `--check-only`-Modus eignet sich als Gate in anderen Skripten:

*The `--check-only` mode is suitable as a gate in other scripts:*

```bash
# In bootstrap-workspace.sh
if ! bash "$SCRIPTS_SRC/setup-git-identity.sh" --check-only; then
  echo "Fehler: Git-Identität muss vor dem Bootstrap konfiguriert werden." >&2
  echo "  bash ~/scripts/setup-git-identity.sh" >&2
  exit 1
fi
```

## BEISPIELE / EXAMPLES

```bash
# Interaktive Einrichtung mit automatischer Vorschlagserkennung
bash ~/scripts/setup-git-identity.sh

# Prüfung in CI oder anderen Skripten
bash ~/scripts/setup-git-identity.sh --check-only && echo "OK"

# Automatisch ohne Dialog (z. B. in Onboarding-Skripten)
bash ~/scripts/setup-git-identity.sh --auto

# Vorschau: Was würde gesetzt?
bash ~/scripts/setup-git-identity.sh --dry-run
```

```powershell
# Interaktiv
pwsh -NoProfile ~/scripts/setup-git-identity.ps1

# Prüfen
pwsh -NoProfile ~/scripts/setup-git-identity.ps1 -CheckOnly

# Automatisch
pwsh -NoProfile ~/scripts/setup-git-identity.ps1 -Auto

# Vorschau
pwsh -NoProfile ~/scripts/setup-git-identity.ps1 -WhatIf
```

## DATEIEN / FILES

- `scripts/setup-git-identity.sh`
- `scripts/setup-git-identity.ps1`
- `docs/man/setup-git-identity.1.md`
- `~/.gitconfig` (wird gelesen und ggf. geschrieben / read and optionally written)
