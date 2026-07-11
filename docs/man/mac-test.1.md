# mac-test(1)

## NAME

`mac-test.sh` - sammelt System- und Tool-Informationen auf macOS und pusht die Ausgabe. *Collects system and tool information on macOS and pushes the output.*

## SYNOPSIS

```bash
bash scripts/mac-test.sh
```

## DESCRIPTION

Das Skript sammelt die macOS-Version, Homebrew-Formulae und -Casks, den Vergleich mit der agentischen Brew-Registry sowie Tool-Informationen fuer VS Code, Helix, die sechs MSL-Pfade, `syft`, GitHub Spec Kit (`specify`) und die Required-Agenten-CLIs `codex`, `claude`, `agy` und `copilot` und schreibt sie nach `~/home-baseline-tmp/mac-test-output.txt`. Anschliessend committet und pusht es die Ausgabe, damit sie von anderen Geraeten gelesen werden kann. Ein PowerShell-Pendant fuer macOS gibt es nicht; das Windows-Gegenstueck ist `windows-test.ps1`.

*The script collects the macOS version, Homebrew formulae and casks, the comparison against the agentic Brew registry, and tool information for VS Code, Helix, the six MSL paths, `syft`, GitHub Spec Kit (`specify`), and the required agent CLIs `codex`, `claude`, `agy`, and `copilot`, and writes it to `~/home-baseline-tmp/mac-test-output.txt`. It then commits and pushes the output so it can be read from other machines. There is no PowerShell counterpart for macOS; the Windows counterpart is `windows-test.ps1`.*

## OPTIONS

keine / none

## EXAMPLES

```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh
```

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Erfolg / success |
| ungleich 0 | Sammel-, Commit- oder Push-Fehler / collection, commit, or push error |

## SEE ALSO

`linux-test.1`
