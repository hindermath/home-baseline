# Validierungsgrenze / Validation boundary

Die Ausgangserhebung vom 10. September 2026 liest öffentliche GitHub-Quellen
direkt und bestätigt 93/93/92. Die neun Repository-Identitäten, gepinnten
Quellen und acht historischen ergänzenden PRs stehen im Snapshot. Feature 030
wird ausdrücklich nicht als terminal abgeschlossen gezählt.

*The initial 10 September 2026 collection reads public GitHub sources directly
and confirms 93/93/92. Nine repository identities, pinned sources and eight
historical supplemental PRs are in the snapshot. Feature 030 is explicitly not
counted as terminally completed.*

## Reproduzierbare Prüfungen / Reproducible checks

```bash
bash -n scripts/update-public-speckit-statistics.sh
pwsh -NoProfile -File scripts/tests/test-public-speckit-statistics.ps1
bash scripts/update-public-speckit-statistics.sh --action Validate
bash scripts/update-public-speckit-statistics.sh --action Render --check-only
bash scripts/render-script-reference.sh --check-only
bash scripts/validate-documentation-impact.sh --evidence docs/spec-kit-runs/documentation-impact.json
git diff --check
```

Die Fixture-Suite läuft zuerst auf macOS. Der Workflow `Public Spec Kit statistics`
prüft dieselben Tests und den unveränderten Renderer auf nativen macOS-, Ubuntu-
und Windows-Runnern. Ein erfolgreiches lokales Ergebnis behauptet diese CI-
Ergebnisse nicht vorab; maßgeblich sind die Checks des jeweiligen PR-Heads.

*The fixture suite runs on macOS first. The CI workflow runs the same tests and
renderer check on native macOS, Ubuntu and Windows runners. Local success does
not preclaim CI results; inspect the checks attached to the actual PR head.*

Der monatliche Sammler schreibt ausschließlich über den dafür vorgesehenen PR.
Die Profilübernahme besitzt eigene Offline-Tests für Hashabweichungen, fehlende/
doppelte/vertauschte Markierungen, Idempotenz und unveränderte MOTD-/Randtexte.
Die erstmalige Profiländerung hängt von der Lieferung des Level-0-Exports ab.
Home-Sync, Merges und tatsächliche monatliche Planläufe sind getrennte
Liefer-/Betriebsnachweise und werden nicht durch Fixture-Tests behauptet.

*The monthly collector publishes only through its designated PR. Profile import
has separate offline tests for hash failures, invalid markers, idempotency and
MOTD/surrounding-text preservation. Initial profile delivery depends on the
merged Level-0 export. Home sync, merges and real scheduled executions remain
separate delivery/operational evidence, not fixture-test claims.*
