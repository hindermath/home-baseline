# Evidence Index

Feature 032 besitzt einen redigierten, portablen Abschlussnachweis unter
`evidence/v1/`. Rohlogs, Tokens, private absolute Pfade und lokaler Agent-State
sind ausgeschlossen. Jeder Eintrag nennt seine runtime-relative Quelle und
deren SHA-256.

*Feature 032 has a redacted portable closeout record under `evidence/v1/`.
Raw logs, tokens, private absolute paths, and local agent state are excluded.
Every entry binds its runtime-relative source and SHA-256.*

| Evidence | Aussage / Claim | Ergebnis / Result |
|---|---|---|
| `evidence/v1/fleet-acceptance.json` | 14 globale Primary-Gates, exakt sieben Repositoryzeilen | Pass |
| `evidence/v1/repository-acceptance.json` | Tests, Links, UTF-8, A11Y, Statistik, Doku, Security und Agent-Parität je Repository | Pass |
| `evidence/v1/platform-parity.json` | macOS sowie native Linux-/Windows-Nachweise | Pass |
| `evidence/v1/product-boundary.json` | Produktdelta null; vier Versions-Null-Diffs; drei begrenzte Constitution-Korrekturen | Pass |
| `evidence/v1/delivery.json` | kausale Branch-/PR-/Review-/PreMerge-/Merge-/PostMerge-/Sync-Kette | Pass |
| `evidence/v1/final-0-0.json` | sieben Default-Branches lokal/remote `0/0` | Pass |
| `evidence/v1/index.json` | Redaktions-, Owner-, Reviewer-, Risiko- und Re-Evaluationsvertrag | Pass |

Die detaillierte operative Evidence bleibt unter dem ignorierten Runtime-Pfad
`.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/` erhalten. Sie ist für lokale
Nachvollziehbarkeit bestimmt und wird nicht als portable Projekt-Evidence
veröffentlicht.

Owner: Feature Orchestrator. Reviewer: Documentation and Evidence Reviewer.
Restrisiko: Die portable Redaktion reicht nicht zur vollständigen
Incident-Rekonstruktion ohne die lokale Runtime-Evidence. Re-Evaluation:
Quellhash, Scope, Owner, Reviewer, Redaktionsregel oder Repositoryzustand
ändert sich.
