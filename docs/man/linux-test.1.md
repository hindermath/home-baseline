# linux-test(1)

## NAME

`linux-test.sh` - sammelt System- und Tool-Informationen auf Linux und pusht die Ausgabe. *Collects system and tool information on Linux and pushes the output.*

## SYNOPSIS

```bash
bash scripts/linux-test.sh
```

## DESCRIPTION

Das Skript sammelt OS-Version, Architektur, Paketmanager- und Tool-Versionen fuer VS Code, Helix, die sechs MSL-Pfade, `syft`, GitHub Spec Kit (`specify`) und die Required-Agenten-CLIs `codex`, `claude`, `agy` und `copilot`, den read-only-orientierten Workspace-Orchestrator-Check sowie Compliance-Ergebnisse und schreibt sie nach `~/home-baseline-source/linux-test-output.txt`. Antigravity wird auf Linux ueber den pruefsummengeprueften offiziellen Installer verwaltet. Die Veroeffentlichung setzt einen vollstaendig sauberen `main`-Checkout voraus, der exakt auf `origin/main` basiert. Verknuepfte Ausgabedateien, abweichende Push-URLs, lokale Ahead-/Diverged-Commits und waehrend der Sammlung geaenderte Remote-Staende werden abgelehnt. Die Ausgabe entsteht zuerst in einer temporaeren Datei, wird atomar eingesetzt und als einziger Pfad committet; Commit-Eltern und -Pfade werden vor dem Push geprueft. Der Push verwendet den verifizierten Commit-SHA und bindet den erwarteten Remote-Stand per Lease. Ein PowerShell-Pendant fuer Linux gibt es nicht; das Windows-Gegenstueck ist `windows-test.ps1`.

*The script collects the OS version, architecture, package-manager and tool versions for VS Code, Helix, the six MSL paths, `syft`, GitHub Spec Kit (`specify`), the required agent CLIs `codex`, `claude`, `agy`, and `copilot`, the read-oriented workspace orchestrator check, plus compliance results, and writes them to `~/home-baseline-source/linux-test-output.txt`. Antigravity is maintained on Linux through the checksum-verified official installer. Publication requires a completely clean `main` checkout based exactly on `origin/main`. Linked output files, differing push URLs, local ahead/diverged commits, and remote changes during collection are rejected. Output is collected in a temporary file, installed atomically, and committed as the only path; commit parent and paths are verified before push. The push uses the verified commit SHA and binds the expected remote tip with a lease. There is no PowerShell counterpart for Linux; the Windows counterpart is `windows-test.ps1`.*

## OPTIONS

keine / none

## EXAMPLES

```bash
bash ~/home-baseline-source/scripts/linux-test.sh
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| ungleich 0 | Sammel-, Commit- oder Push-Fehler / collection, commit, or push error |

## SEE ALSO

`mac-test.1`
