# Operation and maintenance

[Deutsche Fassung](README.md)

## Safe default sequence

1. Detect the operating system and select the matching script variant.
2. Read help and the safe inspection mode.
3. Complete the fleet-wide Remote Freshness preflight.
4. Review blockers and next actions.
5. Run mutations only with explicit authority.
6. Evaluate result, exit code, and evidence together.

On macOS/Linux:

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
```

On Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

`--check-only` and `-CheckOnly` inspect state and may perform safe fetches.
`--dry-run` and `-WhatIf` preview mutations. An interactive launch selects
preview by default; redirected invocations remain headless.

## Remote Freshness Barrier

All registered repositories are inventoried and safely fetched first. One
finding does not end the read-only fleet audit. Pull is allowed only for a clean
default branch with an unambiguous upstream, `ahead=0`, and a purely behind
state. Dirty, Ahead, Diverged, Detached, Non-Default, missing upstream, or remote
failure blocks mutation.

## Enhanced, plain, and headless modes

- Enhanced TUI: interactive surface with text status.
- Plain UI: linear text-oriented selection.
- Headless: explicit options for automation and CI.

All modes use the same maintenance engine and safety boundaries. A fallback may
reduce capability, but it cannot bypass confirmation or blockers. `Ctrl+C`
produces exactly one traceable interruption path.

## Evidence and exit codes

The live JSONL stream reports events. The canonical final report and process
exit code jointly determine success, drift, repaired drift, or operational
failure. `EVENT_STREAM_DEGRADED` means live evidence is incomplete; completion
must not be inferred from the stream alone.

## Further reading

- [Detailed efficiency guide](agentic-workspace-efficiency-guide.en.md#regelmäßiger-betrieb-regular-operation)
- [One-command maintenance manpage](../man/maintain-agentic-workspace.1.md)
- [Maintenance TUI architecture](../architecture/maintenance-tui.md)
- [Maintenance TUI accessibility](../accessibility/maintenance-tui.md)
- [Script reference](../scripts/reference.md)
- [Preset and fleet lessons](Preset-and-Fleet-Operations-Lessons-Learned.md)

**Next action:** Run the matching check or preview mode first and read its
text-oriented next action.
