# Rollback-Plan / Rollback Plan

## Sichere Grenzen / Safe boundaries

1. Before commit: restore only renderer-owned outputs from the captured
   `beforeHashes`; keep canonical source and user work intact.
2. After commit, before merge: create a focused correction commit on the same
   feature branch. Do not reset, rebase, force-push, or rewrite history.
3. After merge: open a focused reviewed revert pull request, regenerate all
   owned outputs from the restored canonical source, and rerun check and
   idempotence evidence.
4. Home Runtime: sync back only after the source revert has merged and only
   through the authorised check/apply/check sequence. No Home Sync is part of
   this foundation phase.
5. Stop the serial fleet at the affected repository. Never use one target's
   rollback to change another target.

The preserved Feature 003 history of `absdd-image-sandbox`, including commits
`91ad1f06fc93c75c98e3c6c7c2a8cf54777b1964` and
`d1c713246c4e5306d41d39bec82a13ef9cfbcaa8`, is outside Feature 032 rollback
scope. No reset, rebase, switch, cherry-pick, delete, or force procedure is
permitted against it.
