# Repository Delivery Matrix

## Terminale Matrix / Terminal matrix

| Repository | Reviewed head | PR | Merge commit | Local/native/review/product/governance | Default sync | Distribution |
|---|---|---:|---|---|---|---|
| home-baseline | `9d79ce76...` | 280 | `a894fff3...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | `homeRuntime` synchron; Feature-Evidence `sourceOnly` |
| agent-operations-cockpit | `bb757615...` | 46 | `1a643d2d...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync |
| TinyPl0 | `14165e2f...` | 93 | `c4f720f2...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync |
| TinyCalc | `a296552a...` | 75 | `114373e3...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync |
| InventarWorkerService | `740cf153...` | 68 | `cacbd095...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync |
| TuiVision | `932a09c8...` | 172 | `26a09dd7...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync |
| absdd-image-sandbox | `210e48c0...` | 61 | `c069cfcc...` | Pass / Pass / Pass / Pass / Pass | `main` `0/0` | repository-local; kein Home Sync; Feature 003 erhalten |

Alle sieben PRs sind terminal `MERGED`; jeder Merge-Tree entspricht dem
bereits geprüften Kandidaten-Tree. Jede Repositoryzeile besitzt eine validierte
lokale Fünf-Gate-Anforderung und kausale PreMerge-/PostMerge-Evidence. Der
globale Snapshot enthält exakt sieben Reihen und 14 Primary-Gates.

*All seven pull requests are merged, every merge tree equals its reviewed
candidate tree, and every repository row has validated local five-gate and
causal PreMerge/PostMerge evidence. The global snapshot contains exactly seven
rows and fourteen Primary gates.*

## Dokumentations- und Distributionsentscheidung

`GeneratedUpdate`: Kanonische Quellen sind die sieben lokalen Serienmanifeste,
Rendererdeklarationen und expliziten Feature-Abschlussnachweise. Zielgruppen
sind Maintainer, Reviewer, IT-Auszubildende und Trainingsverantwortliche.
Leserpfad: Reihenfolgeansicht → vollständiger Intake-Link → expliziter
Feature-Nachweis → portable Delivery-Evidence.

Nur die gemergte Home-Renderer-Lieferung wurde nach T078 als `homeRuntime`
synchronisiert. Alle Feature-, Governance-, Statistik- und portablen
Evidence-Artefakte sind `sourceOnly`; die anderen sechs Repositories
benötigen keinen Home Sync.

Owner: Delivery Owner. Reviewer: Fleet Acceptance Reviewer. Restrisiko:
Provider- und Default-Branch-Zustand sind zeitpunktgebunden. Re-Evaluation:
Head, PR, Merge, Check, Review, Branchschutz, Distribution oder
Repositoryregister ändert sich.

Portable Evidence: `../evidence/v1/delivery.json` und
`../evidence/v1/final-0-0.json`.
