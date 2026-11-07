# scan-agent-secrets(1)

## Name

`scan-agent-secrets` - prueft Repositories und Agenten-Dateien auf moegliche Secrets

*checks repositories and agent files for possible secrets*

## Synopsis

```bash
bash scripts/scan-agent-secrets.sh [--fail-on-high] [WORKSPACE_ROOT]
```

```powershell
pwsh -NoProfile -File scripts/scan-agent-secrets.ps1 [-FailOnHigh] [-WorkspaceRoot PATH]
```

## Beschreibung / Description

Das Werkzeug ist die manuelle Secret-Scan-Schicht der Workspace-Baseline. Wenn
`gitleaks` installiert ist, prueft es zuerst den aktuellen Git-Diff mit
`gitleaks git --pre-commit --redact`. Danach bleiben die bestehenden
Regex-Pruefungen aktiv. Der Bash-Scanner bewertet zusaetzlich bekannte
KI-Agenten-Verzeichnisse. Beide Varianten pruefen außerdem alle
git-getrackten Dateien repositoryweit; die Bash-Variante liest die von Git
NUL-getrennt gelieferten Namen literal und benoetigt dafuer Python 3. Ein
sauberer Checkout ohne lokalen Diff bleibt damit nicht ungeprueft.

*This tool is the manual secret scanning layer of the workspace baseline. When
`gitleaks` is installed, it first checks the current git diff with
`gitleaks git --pre-commit --redact`. The existing regex checks remain active
afterwards. The Bash scanner additionally evaluates known AI agent directories,
and both variants scan every Git-tracked file across the repository. Bash
consumes Git's NUL-delimited names literally through Python 3, so a clean
checkout without a local diff is still covered.*

Getrackte Inhalte werden nur aus regulaeren, nicht verlinkten Dateien gelesen.
Symbolische Links, Reparse Points, Spezialdateien und Dateien ueber 8 MiB gelten
als unvollstaendig pruefbar und erzeugen einen HIGH-Befund, ohne Zielinhalt
auszugeben. *Tracked content is read only from regular, unlinked files.
Symbolic links, reparse points, special files, and files larger than 8 MiB are
treated as incomplete scans and produce a HIGH finding without printing target
content.*

Der gemeinsame `pre-push`-Hook nutzt `gitleaks` separat fuer die zu pushenden
Commit-Ranges. Fehlt `gitleaks`, prueft der Regex-Fallback auch die Blob-Inhalte
und Dateinamen jedes ausgehenden Commits, einschliesslich spaeter geloeschter
Dateien. Bei neuen Refs werden nur Commits ausgenommen, die auf dem
tatsaechlichen Ziel-Remote nachweisbar sind. Die aktuellen getrackten Dateien
werden zusaetzlich geprueft.

*The shared `pre-push` hook uses `gitleaks` separately for the commit ranges
being pushed. Without `gitleaks`, the regex fallback also checks blob contents
and filenames in every outgoing commit, including files deleted later. For new
refs, it excludes only commits verified on the actual destination remote. It
additionally checks currently tracked files.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--fail-on-high` | `-FailOnHigh` | Exit-Code 2 bei HIGH-Befund / exit 2 on HIGH finding |
| `WORKSPACE_ROOT` | `-WorkspaceRoot PATH` | Zu pruefendes Repository / repository to scan |
| `--help` | `Get-Help` | Hilfe anzeigen / show help |

## Beispiele / Examples

```bash
bash scripts/scan-agent-secrets.sh --fail-on-high .
```

```powershell
pwsh -NoProfile -File scripts/scan-agent-secrets.ps1 -FailOnHigh
```

## Sicherheit / Security

`gitleaks` wird mit `--redact` ausgefuehrt, damit Befunde keine Roh-Secrets in
Terminalausgaben schreiben. Bei einem echten Treffer muss das Secret sofort
rotiert und die Ursache bereinigt werden.

*`gitleaks` runs with `--redact` so findings do not print raw secrets to the
terminal. On a real finding, rotate the secret immediately and fix the cause.*
