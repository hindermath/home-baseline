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

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| 1 | `.git/hooks/` nicht gefunden / `.git/hooks/` not found |

## SEE ALSO

`bootstrap-workspace.1`, `bootstrap-project.1`
