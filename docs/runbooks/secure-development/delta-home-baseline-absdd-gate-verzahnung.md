# Runbook: Delta-Gate

Kontext: home-baseline-absdd-gate-verzahnung
Modi: training, mixed, development

1. Vergleiche Issue #263 und den Draft-PR mit dem gebundenen Ausgangscommit.
2. Prüfe ausschließlich geänderte Verträge, Intakes, Receipts und Serienhashes.
3. Bestätige, dass Zielzahl, Rootzahl, Kanten, Reihenfolge und Lifecycle-Status
   der aktiven Serie unverändert sind.
4. Prüfe GeneratedUpdate und bestätige NoHomeSync.
5. Stoppe bei unbeabsichtigter Scope-Ausweitung.

## English

Review only the authorized handoff delta and preserved series invariants.
Documentation is generated from canonical sources and does not require Home
sync.
