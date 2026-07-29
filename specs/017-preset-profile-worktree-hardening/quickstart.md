# Quickstart: Preset Profile and Worktree Hardening

Alle lokalen Prüfungen laufen aus dem dauerhaften Level-0-Klon. Die ersten
Befehle verändern weder Ziel-Checkouts noch Home-Runtime oder Toolchain:

```bash
bash -n scripts/maintain-agentic-workspace.sh
python3 -m unittest scripts.tests.test_agentic_workspace_maintenance
python3 -m unittest scripts.tests.test_maintenance_contracts
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
```

PowerShell-Parität:

```powershell
pwsh -NoProfile -Command {
    [void][System.Management.Automation.Language.Parser]::ParseFile(
        'scripts/maintain-agentic-workspace.ps1',
        [ref]$null,
        [ref]$null
    )
}
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

`--check-only` und `-CheckOnly` dürfen sichere Fetches und read-only
Bestandsaufnahme ausführen, aber keinen Pull und keine Domainmutation.
`--dry-run` und `-WhatIf` zeigen sichere Folgeaktionen nur als Vorschau.

Ein echter Wartungslauf ist erst nach grünen Fixture-, Preview- und
Freshness-Gates zulässig:

```bash
bash scripts/maintain-agentic-workspace.sh
```

Der Lauf darf sichere Behind-only-Default-Branches per Fast-forward
aktualisieren. Er commitet, pusht oder mergt niemals in Ziel-Repositories.
Admin-Prompts für optionale oder privilegierte Toolchain-Schritte benötigen
weiterhin eine getrennte, aktuelle Laufautorität.
