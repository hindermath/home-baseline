# Contract: Owned Worktree Lease

## Creation

Vor `git worktree add` wird ein atomarer Lease mit Lauf-ID, PID,
Prozessstartzeit, Repository, Remote-Ref, Commit, Lease-Pfad, Worktree-Pfad
und UTC-Zeit im reservierten Home-Baseline-State angelegt.

## Normal Release

Der Worktree wird über sein Repository entfernt, die Git-Registrierung wird
geprüft und erst danach werden ausdrücklich eigene Lease-/State-Pfade
entfernt. Der zweite Release ist ein No-op.

## Recovery

Ein Startaudit darf nur einen eigenen, verwaisten und vollständig konsistenten
Lease bereinigen. Aktive Prozesse, PID-Wiederverwendung, fremde Repositories,
Pfadabweichung, State-Path-Escape, fehlende Felder oder widersprüchliche
Git-Registrierung ergeben `Ambiguous` und bleiben erhalten.

## Cleanup Boundary

Es gibt kein globales `git worktree prune`, kein `git clean`, keinen Reset,
Stash oder rekursives Löschen in Nutzer-Checkouts. Nach Zustandsänderungen
bedarf es einer neuen exakten Inventur.
