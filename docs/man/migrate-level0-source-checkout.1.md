# migrate-level0-source-checkout(1)

## NAME

`migrate-level0-source-checkout` - migrate the permanent Level 0 source clone
to a stable cross-platform location.

## SYNOPSIS

```text
bash scripts/migrate-level0-source-checkout.sh [--check-only|--dry-run] [--json]
pwsh -NoProfile -File scripts/migrate-level0-source-checkout.ps1 [-CheckOnly|-WhatIf] [-Json]
```

## DESCRIPTION

The command requires a clean `main` checkout with `HEAD == origin/main`, one
worktree, the expected remote, and an absent target. It moves the checkout to
`~/home-baseline-source`, writes `~/.home-baseline/source-repository.json`,
updates local path-scoped configuration, and retains a temporary legacy link.

Der Befehl verlangt einen sauberen, synchronen `main`-Checkout, genau einen
Worktree, das erwartete Remote und ein freies Ziel. Danach schreibt er einen
lokalen, geheimnisfreien Zustandsnachweis und behaelt voruebergehend einen
Kompatibilitaetslink.

Use `--finalize` or `-Finalize` only after every local tool has been validated
at the new path. Finalization is idempotent: an already absent compatibility
link or legacy Git `includeIf` is accepted as the completed state.

## EXIT STATUS

- `0`: ready, previewed, migrated, or finalized
- `2`: preflight, usage, Git, filesystem, or configuration error
