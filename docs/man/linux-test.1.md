# linux-test(1)

## NAME

`linux-test.sh` - sammelt System- und Tool-Informationen auf Linux und pusht die Ausgabe. *Collects system and tool information on Linux and pushes the output.*

## SYNOPSIS

```bash
bash scripts/linux-test.sh
```

## DESCRIPTION

Das Skript sammelt OS-Version, Architektur, Paketmanager- und Tool-Versionen fuer VS Code, Helix, die sechs MSL-Pfade, `syft`, GitHub Spec Kit (`specify`) und die Required-Agenten-CLIs `codex`, `claude`, `agy` und `copilot` sowie Compliance-Ergebnisse und schreibt sie nach `~/home-baseline-tmp/linux-test-output.txt`. Antigravity wird auf Linux ueber den pruefsummengeprueften offiziellen Installer verwaltet. Anschliessend committet und pusht das Skript die Ausgabe, damit sie von anderen Geraeten gelesen werden kann. Ein PowerShell-Pendant fuer Linux gibt es nicht; das Windows-Gegenstueck ist `windows-test.ps1`.

*The script collects the OS version, architecture, package-manager and tool versions for VS Code, Helix, the six MSL paths, `syft`, GitHub Spec Kit (`specify`), and the required agent CLIs `codex`, `claude`, `agy`, and `copilot`, plus compliance results, and writes them to `~/home-baseline-tmp/linux-test-output.txt`. Antigravity is maintained on Linux through the checksum-verified official installer. The script then commits and pushes the output so it can be read from other machines. There is no PowerShell counterpart for Linux; the Windows counterpart is `windows-test.ps1`.*

## OPTIONS

keine / none

## EXAMPLES

```bash
bash ~/home-baseline-tmp/scripts/linux-test.sh
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| ungleich 0 | Sammel-, Commit- oder Push-Fehler / collection, commit, or push error |

## SEE ALSO

`mac-test.1`
