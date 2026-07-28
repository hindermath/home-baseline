# Contract: Maintenance Mode

Exactly one mode is active.

| Mode | Top-level input | Home sync | Fleet | Mutation |
|---|---|---|---|---|
| CheckOnly | `-CheckOnly` | `-CheckOnly` | `check-only` | No |
| Preview | `-WhatIf` | `-WhatIf` | `dry-run` | No |
| Update | neither | no mode flag | `update` | Yes |

Any attempted combination of CheckOnly and Preview exits `2` before mutation.
