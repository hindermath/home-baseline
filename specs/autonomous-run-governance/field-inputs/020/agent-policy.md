# Causal Remote Evidence Field Policy

This rule was synchronized across `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
`.github/copilot-instructions.md`, and
`.github/agents/copilot-instructions.md` at TuiVision main commit
`26cf842118b97b133bfe99e4c82759db9c2b40f2`.

> Aktuelle Check-/Review-Fakten werden vor dem Merge geprüft, aber in genau
> einen benannten Closeout-Evidence-Pfad verschoben, wenn ihr Commit den
> geprüften Feature-Head und damit die Aussage selbst entwerten würde.

> Route self-invalidating reviewed-head facts to one named closeout path after
> verifying them before merge.

Portable preset work must preserve both halves of the invariant: remote gates
are actually verified before merge, and evidence is not committed onto the
same reviewed head when that commit would make the statement stale. The rule
does not grant remote write, merge, or bypass authority.
