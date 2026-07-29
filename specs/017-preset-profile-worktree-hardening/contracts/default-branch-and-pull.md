# Contract: Default Branch and Safe Pull

## Default Branch Evidence

Ein gültiger lokaler `origin/HEAD` wird zuerst verwendet. Fehlt er, wird
`origin` read-only nach seinem symbolischen `HEAD` gefragt. Der Ref muss nach
dem Fetch lokal existieren und denselben Commit bezeichnen.

## Pull Decision

`pull --ff-only` ist nur zulässig, wenn alle Bedingungen erfüllt sind:

- sauberer Index und Arbeitsbaum;
- aktueller Branch ist der kanonische Default-Branch;
- eindeutiger Upstream gehört zu `origin`;
- `ahead == 0`;
- `behind > 0`;
- aktueller Fetch ist erfolgreich.

Alle anderen Zustände sind blockierend für Mutation, aber nicht für die
weitere read-only Bestandsaufnahme.

## Failure Classes

`Dirty`, `Ahead`, `Diverged`, `Detached`, `BranchMismatch`,
`MissingUpstream`, `RemoteMismatch`, `RemoteHeadMissing`,
`RemoteHeadAmbiguous`, `FetchFailed`, `FetchTimedOut`, `CommitMismatch`.
