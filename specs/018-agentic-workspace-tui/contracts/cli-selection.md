# Contract: CLI Routing and Maintenance Selection

## Public Wrapper Routes

| Input | Route |
|---|---|
| No arguments; interactive stdin and stdout | Enhanced TUI, Dry-run selected |
| No arguments; either stream non-interactive | Existing unattended full maintenance |
| Any existing maintenance option | Existing headless path |
| `--tui` / `-Tui` | Enhanced TUI or visible Plain fallback |
| `--plain-ui` / `-PlainUi` | Plain line-oriented assistant |
| `--no-tui` / `-NoTui` | Headless engine |

The three UI selectors are mutually exclusive. Enhanced and Plain may carry
only the Home override. No-TUI may accompany existing engine options. Invalid
syntax exits `2`.

## Selection Rules

- Modes: Check-only, Dry-run/WhatIf, Update.
- Dry-run is the initial selection.
- Check-only and Dry-run are mutually exclusive.
- Repair drift is valid only in Update.
- Include optional is invalid with Scripts-only.
- Update confirmation defaults to No.
- Cancellation before process start exits `130` without maintenance mutation.

## Engine Invocation

The selected platform wrapper is invoked once through an executable plus
ordered argument list. The displayed command is escaped explanatory text and
must never be executed.

UI confirmation grants no target-repository publication, provider, cleanup,
secret or administrator authority.
