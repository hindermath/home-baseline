# Evidence Schema 2.0 Lifecycle

## PreMerge

`PreMerge` is a machine-local, untracked snapshot created only after the exact
candidate head has passed its applicable gates. For serial repository delivery,
it is validated against that repository's pre-named local requirements artifact
from `contracts/fleet-evidence-and-delivery.md`, never against the global fleet
requirements. It contains the reviewed
`head`, gate IDs, command arrays, runner/platform, exit codes, write counts,
normalized payload hashes, decisions, owners, and timestamps. It is validated
with:

```bash
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.sh --requirements REPOSITORY_LOCAL_REQUIREMENTS_PATH --evidence PREMERGE_PATH --head EXACT_REVIEWED_HEAD
```

`REPOSITORY_LOCAL_REQUIREMENTS_PATH` is created and reviewed by the repository's
existing base task before mutation. Its schema-1.0 gate list contains exactly
the five Applicable local IDs and exact scopes/evidence/command/runner tokens
defined by the fleet-evidence contract. The installed validator has no
repository filter and therefore requires every declared ID exactly once with
matching scope and `Pass`. `PREMERGE_PATH` and `EXACT_REVIEWED_HEAD` are
lifecycle values resolved by the later repository task; they are not predicted
evidence. The normalized hash
follows the installed autonomous-evidence core exactly: remove one UTF-8 BOM
when present, decode as strict UTF-8, reject NUL, and normalize CRLF and CR to
LF before hashing the resulting UTF-8 bytes. JSON key order and whitespace
remain significant; neither is sorted or removed. Because the snapshot is
ignored and untracked, recording it cannot change its own reviewed head.

## PostMerge

`PostMerge` is created only after an actual merge. It repeats the same local
requirements hash and actual reviewed-head binding and adds
`acceptedPreMergePath`, `acceptedPreMergeSha256`, the actual `mergeCommit`,
default-branch verification, and distribution result. Validate it with the same
local requirements and reviewed head plus the actual merge commit. A planned PR,
predicted SHA, stale job name, or cross-repository result is invalid.

After all seven repository PostMerge/default-sync records exist, T153–T155
materialize and validate the terminal fleet snapshot against the unchanged
`specs/032-linked-intake-evidence/autonomous-run-gate-requirements.json`. That
global validation covers all fourteen `AC-LAF` IDs and all seven actual rows;
future repository work is neither `N/A` nor a local `Pass` before it occurs.

## Supersession and failure

Any candidate bytes, head, command, platform, gate set, decision, or output hash
change supersedes the affected PreMerge evidence. Partial, historical, or
syntactic-only observations remain audit records and cannot authorize merge.
Missing native Linux/Windows evidence stays `Open`. Publication failure records
the rollback and never advances the lifecycle.
