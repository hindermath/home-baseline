# install-hooks(1)

## NAME

`install-hooks.sh`, `install-hooks.ps1` - installiert die Git-Hooks aus `scripts/hooks/` nach `.git/hooks/`. *Installs the git hooks from `scripts/hooks/` into `.git/hooks/`.*

## SYNOPSIS

```bash
bash scripts/install-hooks.sh
```

```powershell
pwsh -NoProfile -File scripts/install-hooks.ps1 [-HookSourcePath <path>]
```

## DESCRIPTION

Das Skript kopiert alle Hooks aus `scripts/hooks/` nach `.git/hooks/` und macht sie ausfuehrbar. Es ist einmalig auf jedem neuen Geraet nach dem Klonen auszufuehren. Fehlt das Verzeichnis `.git/hooks/`, bricht das Skript mit einem Fehler ab.

*The script copies all hooks from `scripts/hooks/` into `.git/hooks/` and makes them executable. Run it once on every new machine after cloning. If `.git/hooks/` is missing, the script aborts with an error.*

Nach jeder Änderung an `scripts/hooks/pre-push` muss der passende Installer
unmittelbar erneut ausgeführt werden. Danach sind Quelle und installierter Hook
byteweise und per SHA-256 zu vergleichen. Der installierte Hook wird direkt,
ohne `git push`, einmal mit passender sicherer Fixture-Evidence und einmal mit
fehlender oder inkonsistenter Evidence aufgerufen. Der Passfall muss `0`, der
Blockfall einen Wert ungleich `0` liefern.

*After every source-hook change, reinstall immediately, compare source and
installed bytes plus SHA-256, then invoke the installed hook directly with one
safe pass fixture and one blocking fixture. Do not use `git push` for this
verification.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| — (keine / none) | `-HookSourcePath <path>` | Alternativer Quellordner der Hooks |

## EXAMPLES

```bash
bash scripts/install-hooks.sh
```

```powershell
pwsh -NoProfile -File scripts/install-hooks.ps1
```

```bash
cmp scripts/hooks/pre-push .git/hooks/pre-push
shasum -a 256 scripts/hooks/pre-push .git/hooks/pre-push
printf '%s\n' '<fixture ref update>' | .git/hooks/pre-push fixture-remote fixture-url
```

Der direkte Aufruf benötigt ausschließlich temporäre, nicht sensible
Fixture-Pfade über die dokumentierten `HB_CI_*`-Umgebungsvariablen. Seine
Argumente sind keine Remote-Autorität; es findet kein Netzwerk-Push statt.

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | `.git/hooks/` nicht gefunden / `.git/hooks/` not found |

## SEE ALSO

`bootstrap-workspace.1`, `bootstrap-project.1`
