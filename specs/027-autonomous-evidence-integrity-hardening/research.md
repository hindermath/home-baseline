# Research Decisions

## R1 - Explicit delivery set, not repository-wide inference

Decision: require explicit intended untracked paths while deriving tracked
changes from Git. Unrelated untracked paths are reported but excluded. This
prevents accidental delivery classification and avoids staging side effects.

## R2 - Structured result beside human output

Decision: keep human-readable runner output separate from a versioned JSON
phase result. Exit code remains necessary but the JSON completion predicate is
authoritative for phase state.

## R3 - Two lifecycle snapshots

Decision: use separate pre- and post-merge documents. A single mutable record
cannot truthfully prove both moments without invalidating its own head.

## R4 - Historical compatibility is audit-only

Decision: schema 1.0 remains readable with an explicit historical switch but
cannot authorize a new merge. Silent downgrade would recreate the defect.

## R5 - No release in G2A

Decision: version the candidate as 0.4.0 in source while withholding public
publication until independent G2B field validation.
