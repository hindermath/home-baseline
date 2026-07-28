# Quickstart: Windows Maintenance Hardening

All commands run from the Level-0 clone on Windows.

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
python scripts/tests/test_windows_maintenance_hardening.py
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

The first two commands are read-only. A real maintenance run is permitted only
after the preview and test gates are green:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -RepairDrift -AllowAdminPrompts
```

`-AllowAdminPrompts` allows visible administrator interaction for this run; it
does not bypass UAC, safety checks, timeouts, tests, or repository review.
