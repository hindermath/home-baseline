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

## Storage cleanup

Full maintenance selects `Safe` by default. This stage inventories registered
Level-2 repositories, removes only repository-contained, ignored, untracked
build outputs during an update run, and maintains selected caches through
their native providers. It runs after model-routing status and before final
verification. Once the Level-2 registry is valid, unrelated fleet or
toolchain findings do not suppress it; its own safety barriers decide each
repository and provider action.

- Normal retention is seven days; below 15 percent free space the report
  activates pressure mode.
- `Deep` includes additional recoverable dependency caches and requires a
  separate confirmation for an update run.
- `None` disables the stage; `scripts-only` selects it automatically.
- Container cleanup removes dangling images only, never volumes and never with
  `--all` or `system prune`.
- Curated adapters handle the constitutionally justified non-MSL `cc65` and
  `tvision` repositories. Unknown non-MSL profiles are never processed by
  generic deletion rules.

```bash
bash scripts/maintain-workspace-storage.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run --cleanup-profile safe
```

The private storage report records profile, pressure mode, candidates,
protected evidence, bytes, and provider warnings. Provider warnings do not
block unrelated maintenance stages; policy, path, and operational failures do.

## Evidence and exit codes

The live JSONL stream reports events. The canonical final report and process
exit code jointly determine success, drift, repaired drift, or operational
failure. `EVENT_STREAM_DEGRADED` means live evidence is incomplete; completion
must not be inferred from the stream alone.

## Further reading

- [Detailed efficiency guide](agentic-workspace-efficiency-guide.en.md#regelmäßiger-betrieb-regular-operation)
- [One-command maintenance manpage](../man/maintain-agentic-workspace.1.md)
- [Storage cleanup manpage](../man/maintain-workspace-storage.1.md)
- [Maintenance TUI architecture](../architecture/maintenance-tui.md)
- [Maintenance TUI accessibility](../accessibility/maintenance-tui.md)
- [Script reference](../scripts/reference.md)
- [Preset and fleet lessons](Preset-and-Fleet-Operations-Lessons-Learned.md)

**Next action:** Run the matching check or preview mode first and read its
text-oriented next action.
