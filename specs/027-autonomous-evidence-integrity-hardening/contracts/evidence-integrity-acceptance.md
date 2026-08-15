# Evidence Integrity Acceptance Contract

The candidate is accepted only when:

1. Delivery-set validation covers tracked and explicitly intended untracked
   files without mutating repository state.
2. Exit zero without complete semantic evidence never yields `Completed`.
3. Pre-merge evidence cannot contain merge facts.
4. Post-merge evidence binds the immutable pre-merge hash and merge commit.
5. Schema 1.0 is audit-only for new runs.
6. Bash and PowerShell classifications and exit codes match.
7. Canonical and publication trees are byte-identical.
8. No tag, release, catalog, consumer, fleet, G2B, or Position-7 action occurs.
