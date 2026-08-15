# Research: Feature 028

## Decisions

1. Reuse the merged v0.4.0 candidate unchanged unless field validation exposes
   a reproducible defect. G2B validates promotion; it does not redesign G2A.
2. Exercise the three findings with feature-local temporary repositories and
   structured evidence. Runtime evidence remains ignored or temporary.
3. Treat Resume as a semantic state transition test, not an intentional UI
   interruption. Persist `NeedsRevalidation`, revalidate authority and hashes,
   then accept only trustworthy completion.
4. Publish only after local candidate, cross-shell, composition, security, and
   release gates pass. Public repository delivery precedes tag/ZIP validation.
5. Derive consumers from the current Level-2 registry and preset profiles.
   Never use the historical 32-repository count as rollout logic.
6. Submit one serial catalog update after ZIP proof. Waiting for upstream merge
   does not block local closeout.
7. Restore the pre-G2 32-target/3-root/36-edge Series only after all locally
   authorized delivery and evidence obligations complete.

## Rejected Alternatives

- Self-certifying G2A fixtures without an independent run.
- Publishing before the Resume and lifecycle field proofs.
- Updating every repository regardless of profile applicability.
- Creating empty consumer or retrospective pull requests.
- Committing exact-head provider evidence before merge.
- Starting Position 7 as part of closeout.
