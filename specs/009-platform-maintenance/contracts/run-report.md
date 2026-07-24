# Contract: Maintenance Run Report

Der JSON-Bericht wird lokal unter
`~/.home-baseline/reports/agentic-workspace-<run-id>.json` gespeichert und mit
der Logdatei derselben Run-ID verbunden.

Pflichtfelder:

- `schemaVersion`, `runId`, `platform`, `mode`, `startedAt`, `completedAt`;
- `overallStatus`, `exitCode`;
- `stages`, `targets`, `toolchain`, `findings`;
- `artifacts.logPath`, `artifacts.reportPath`;
- Aggregatzahlen für passierte, gewarnte, blockierte und fehlgeschlagene
  Einheiten.

Jede Stufe und jedes aktive Ziel erscheint genau einmal. Pfade und Remotes
werden nur soweit ausgegeben, wie Diagnose und Zielidentität es erfordern.
Secrets und vollständige Unterprozessausgaben sind verboten. Auch nach einem
isolierten Unterprozessfehler muss ein bestmöglicher terminaler Bericht
geschrieben werden.
