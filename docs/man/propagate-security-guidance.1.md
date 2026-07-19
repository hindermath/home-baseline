# propagate-security-guidance(1)

## NAME

`propagate-security-guidance` — propagiert Security-Guidance-Updates aus Level-0 auf alle Level-1/Level-2-Repos
*propagates security guidance updates from Level-0 to all Level-1/Level-2 repos*

## SYNOPSIS

```text
bash scripts/propagate-security-guidance.sh [--dry-run] [--verbose]
                                             [--only-level1] [--only-constitution]
                                             [--only-environment-registry]

pwsh -NoProfile scripts/propagate-security-guidance.ps1 [-DryRun] [-OnlyLevel1]
                                                         [-OnlyConstitution]
                                                         [-OnlyEnvironmentRegistry]
```

## BESCHREIBUNG / DESCRIPTION

Das Script erkennt automatisch alle Level-1- und Level-2-Repos unter `~/` und
propagiert aktuelle Security-Guidance-Inhalte aus `~/home-baseline-source` (Level-0).

*The script automatically discovers all Level-1 and Level-2 repos under `~/` and
propagates the current security guidance content from `~/home-baseline-source` (Level-0).*

### Kernprinzipien / Core principles

**Dynamische Erkennung / Dynamic discovery** — keine hartcodierten Pfade. Neue
Workspaces (`bootstrap-workspace.*`) und neue Projekte werden beim nächsten Lauf
automatisch erfasst.

*No hardcoded paths. New workspaces and projects are automatically discovered on the
next run.*

**Canonical-Content-Quellen zur Laufzeit / Runtime canonical source** — Abschnitte
werden direkt aus den Level-0-Dateien gelesen (`CLAUDE.md`, `AGENTS.md`, `GEMINI.md`,
`constitution.md`). Wenn Level-0 aktualisiert wird, propagiert der nächste Lauf
automatisch den neuen Inhalt — ohne Skript-Änderung.

*Sections are read at runtime from Level-0 files. Updating Level-0 automatically
propagates new content on the next run — no script changes required.*

**Idempotent** — prüft per Fingerprint-String vor jeder Änderung. Mehrfaches Ausführen
ist sicher.

*Checks for fingerprint strings before any change. Multiple runs are safe.*

### Was propagiert wird / What is propagated

| # | Was / What | Zieldateien / Target files |
|---|---|---|
| 1 | `Sicherheitsdokumentation`-Sektion (XII–XVIII Extensions, alle 10 Templates) | AGENTS.md, CLAUDE.md, GEMINI.md, copilot-instructions.md |
| 2 | `Sicherheitsstandards`-Sektion (inkl. Prinzip XIX / CRA-Referenz) | AGENTS.md, CLAUDE.md |
| 3 | `setup-git-identity` Known-Pitfall-Eintrag | CLAUDE.md |
| 4 | Prinzip XVI (SBOM auf allen Levels + automatisierte Tools) | `.specify/memory/constitution.md` |
| 5 | Prinzip XVII (CIA-Matrix als Pflicht im Threat-Modeling) | `.specify/memory/constitution.md` |
| 6 | Prinzip XIX (EU Cyber Resilience Act) | `.specify/memory/constitution.md` |
| 7 | Kanonisches Level-2-Umgebungsregister | `constitution.md`, `.specify/memory/constitution.md` |

## OPTIONEN / OPTIONS

| Option | Beschreibung / Description |
|---|---|
| `--dry-run` | Vorschau aller Änderungen ohne Schreiben / Preview all changes without writing |
| `--verbose`, `-v` | Auch unveränderte Dateien ausgeben / Also output unchanged files |
| `--only-level1` | Nur Level-1-Repos; Level-2-Projekte überspringen |
| `--only-constitution` | Nur `.specify/memory/constitution.md`-Dateien aktualisieren |
| `--only-environment-registry` | Nur das kanonische Level-2-Umgebungsregister in beiden Constitution-Dateien synchronisieren |
| `--help`, `-h` | Hilfemeldung anzeigen / Show help |

## REPO-ERKENNUNG / REPO DISCOVERY

Das Script erkennt:
- **Level-1**: direkte Unterverzeichnisse von `~/` mit `.git` + mindestens einer Agent-Datei
  (`AGENTS.md` oder `CLAUDE.md`), ausgenommen `~/home-baseline-source`
- **Level-2**: Unterverzeichnisse von Level-1-Repos mit `.git` + Agent-Dateien

*The script discovers: Level-1 = direct subdirs of `~/` with `.git` + agent files,
excluding `~/home-baseline-source`; Level-2 = subdirs of Level-1 repos with `.git` + agent files.*

## VORAUSSETZUNGEN / PREREQUISITES

- `python3` (auf macOS vorinstalliert / pre-installed on macOS)
- `~/home-baseline-source` muss vorhanden und aktuell sein / must exist and be up to date
- PowerShell-Wrapper: WSL2 mit Ubuntu erforderlich / PowerShell wrapper requires WSL2 with Ubuntu

## BEISPIELE / EXAMPLES

```bash
# Vorschau: was würde geändert?
bash ~/scripts/propagate-security-guidance.sh --dry-run

# Alle Repos aktualisieren
bash ~/scripts/propagate-security-guidance.sh

# Nur constitution.md-Dateien aktualisieren
bash ~/scripts/propagate-security-guidance.sh --only-constitution

# Nur das gemeinsame Level-2-Umgebungsregister aktualisieren
bash ~/scripts/propagate-security-guidance.sh --only-environment-registry

# Nur Level-1, kein Level-2
bash ~/scripts/propagate-security-guidance.sh --only-level1

# Verbose: auch unveränderte Dateien anzeigen
bash ~/scripts/propagate-security-guidance.sh --verbose --dry-run
```

```powershell
# Windows (erfordert WSL2)
pwsh -NoProfile ~/scripts/propagate-security-guidance.ps1 -DryRun

pwsh -NoProfile ~/scripts/propagate-security-guidance.ps1 -OnlyEnvironmentRegistry
```

## NACH DEM LAUF / AFTER A RUN

Das Script schreibt Dateien in den betroffenen Repos — diese Repos haben eigene
Git-Remotes. Änderungen müssen dort separat committet und gepusht werden:

*The script writes files in the affected repos — each has its own Git remote. Changes
must be committed and pushed separately there:*

```bash
cd ~/RiderProjects  # oder das betroffene Repo
git diff
git add -p
git commit -m "chore: propagate security guidance updates from home-baseline v1.12.0"
git push
```

## DATEIEN / FILES

- `scripts/propagate-security-guidance.sh`
- `scripts/propagate-security-guidance.ps1`
- `docs/man/propagate-security-guidance.1.md`
- Canonical sources: `~/home-baseline-source/CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, `constitution.md`
