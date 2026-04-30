# update-spec-kit(1)

## Name

`update-spec-kit` — aktualisiert Spec-Kit-Integrationen in allen Level-0/1/2-Repos

*refreshes Spec-Kit integrations across all Level-0/1/2 repositories*

## Synopsis

```bash
bash scripts/update-spec-kit.sh [--dry-run] [--commit] [--push] [--allow-dirty]
```

```powershell
pwsh scripts/update-spec-kit.ps1 -WhatIf
pwsh scripts/update-spec-kit.ps1 -Commit -Push
```

## Beschreibung / Description

`update-spec-kit` findet dynamisch Spec-Kit-Repositories unter dem Home-
Verzeichnis und fuehrt fuer jedes Repository die aktuelle Spec-Kit-
Initialisierung fuer `claude`, `opencode`, `gemini`, `copilot` und `codex` aus.

*`update-spec-kit` dynamically discovers Spec-Kit repositories below the home
directory and refreshes the current Spec-Kit initialization for `claude`,
`opencode`, `gemini`, `copilot`, and `codex`.*

Das Script schuetzt lokale Governance-Anpassungen:

- `.specify/memory/constitution.md` wird vor dem Upgrade gesichert und danach
  wiederhergestellt.
- `spec-template.md`, `plan-template.md` und `tasks-template.md` werden nach
  dem Spec-Kit-Refresh aus der lokalen Governance-Referenz wieder aufgelegt.
- `.opencode/command/*.md` wird in Whitelist-`.gitignore`-Repos trackbar
  gemacht, ohne das ganze `.opencode/`-Root freizugeben.
- Generierte Spec-Kit-Dateien werden von trailing whitespace bereinigt, damit
  `git diff --check` nicht an generierten Command-Dateien scheitert.

*The script protects local governance customizations: it preserves the
constitution memory file, reapplies the local governance templates, allows only
`.opencode/command/*.md` in whitelist repositories, and removes generated
trailing whitespace before optional commits.*

## Repo-Erkennung / Repository Discovery

Standard-Erkennung:

- Level 0: `~/home-baseline-tmp`, sofern `.git` und `.specify/` vorhanden sind
- Level 1: direkte Unterverzeichnisse von `~/` mit `.git` und `.specify/`
- Level 2: direkte Unterverzeichnisse erkannter Level-1-Repos mit `.git` und
  `.specify/`

*Default discovery: Level 0 is `~/home-baseline-tmp`; Level 1 is each direct
child of `~/` with `.git` and `.specify/`; Level 2 is each direct child of a
Level-1 repository with `.git` and `.specify/`.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--dry-run` | `-WhatIf` | Nur anzeigen, keine Schreiboperationen |
| `--home-dir PATH` | `-HomeDir PATH` | Alternatives Home-Verzeichnis |
| `--template-source PATH` | `-TemplateSource PATH` | Governance-Template-Referenz |
| `--agents LIST` | `-Agents LIST` | Integrationen, Standard: alle fuenf |
| `--commit` | `-Commit` | Pro geaendertem Repo committen |
| `--push` | `-Push` | Pro Repo pushen; aktiviert Commit |
| `--allow-dirty` | `-AllowDirty` | Bestehende lokale Aenderungen erlauben |

## Beispiele / Examples

```bash
# Nur pruefen, welche Repos aktualisiert wuerden
bash scripts/update-spec-kit.sh --dry-run

# Aktualisieren und pro Repo committen
bash scripts/update-spec-kit.sh --commit

# Aktualisieren, committen und pushen
bash scripts/update-spec-kit.sh --commit --push
```

```powershell
# Windows / PowerShell
pwsh scripts/update-spec-kit.ps1 -WhatIf
pwsh scripts/update-spec-kit.ps1 -Commit -Push
```

## Sicherheit / Security

Das Script trackt nicht das ganze `.opencode/`-Verzeichnis. Erlaubt wird nur
`.opencode/command/*.md`, weil diese Dateien Spec-Kit-Command-Definitionen
enthalten. Caches, Sitzungen, Logs, Credentials und lokale Abhaengigkeiten
bleiben durch das Whitelist-Modell ausgeschlossen.

*The script does not track the full `.opencode/` directory. Only
`.opencode/command/*.md` is allowed because those files are Spec-Kit command
definitions. Caches, sessions, logs, credentials, and local dependencies remain
blocked by the whitelist model.*
