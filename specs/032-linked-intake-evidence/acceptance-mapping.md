# Acceptance Mapping

Every accepted identifier is listed exactly by name below. Task ranges refer
to the unchanged 169-task plan; evidence paths are repository-relative or the
declared ignored runtime root. A group mapping means every identifier in that
cell maps to every stated task/evidence family as applicable.

## Functional requirements

| Identifiers | Following tasks | Evidence paths |
|---|---|---|
| LAF-001, LAF-002, LAF-003, LAF-004, LAF-005 | T026–T033, T042–T049, T084–T145 | `scripts/tests/linked-intake-evidence/`, generated root/series views, `evidence/v1/repositories/*/local-gates.json` |
| LAF-006, LAF-007, LAF-008, LAF-009, LAF-010 | T027–T033, T039–T049, T050–T061, T084–T145 | feature-proof fixtures, canonical delta and per-repository local gates |
| LAF-011, LAF-012, LAF-013, LAF-014, LAF-015 | T028–T049, T063–T066, T070–T076, T084–T145 | link/security/A11Y/parity/idempotence evidence below `evidence/v1/` |
| LAF-016, LAF-017, LAF-018, LAF-019, LAF-020 | T033–T049, T077–T145 | renderer help/manpages, serial repository outputs and local gate records |
| LAF-021, LAF-022, LAF-023, LAF-024, LAF-025 | T050–T065, T070–T076, T084–T145 | TuiVision exact fixtures, governance docs, scope diffs, statistics evidence |
| LAF-026, LAF-027, LAF-028, LAF-029, LAF-030 | T052–T061, T063–T066, T070–T076, T084–T145 | backlog fixture, native platform records, negative fixture results |
| LAF-031, LAF-032, LAF-033, LAF-034, LAF-035 | T062–T069, T084–T145, T147–T169 | security/A11Y/language/dependency reviews and final fleet evidence |

## Constitution requirements

| Identifiers | Following tasks | Evidence paths |
|---|---|---|
| CR-001, CR-002, CR-003, CR-004 | T062–T076, T084–T145 | repository constitutions, A11Y/language checks, statistics and agent-parity decisions |
| CR-005, CR-006, CR-007, CR-008 | T062–T065, T084–T145 | `docs/security/linked-intake-evidence.md`, architecture and dependency evidence |
| CR-009, CR-010, CR-011, CR-012 | T062–T069, T084–T145 | product-AI N/A, path-boundary tests, governance matrices |
| CR-013, CR-014 | T070–T076, T084–T145, T147–T169 | documentation-impact records and exact-head native platform evidence |

## Success criteria

| Identifiers | Following tasks | Evidence paths |
|---|---|---|
| SC-001, SC-002, SC-003, SC-004, SC-005 | T026–T049, T084–T145 | seven-repository view/link/edge/feature/idempotence results |
| SC-006, SC-007, SC-008, SC-009, SC-010 | T050–T076, T084–T169 | TuiVision exact result, canonical/product deltas, acceptance rows, linearisation and parity evidence |

## Acceptance gates

| Identifiers | Following tasks | Primary evidence paths |
|---|---|---|
| AC-LAF-001, AC-LAF-002, AC-LAF-003, AC-LAF-004 | T026–T049, T084–T145 | `evidence/v1/fleet/scope.json`, `row-shape.json`, `links.json`, `dependencies.json` |
| AC-LAF-005, AC-LAF-006, AC-LAF-007, AC-LAF-008 | T026–T049, T070–T076, T084–T145 | `features.json`, `fleet/canonical-delta.json`, `idempotence.json`, `platform/home-parity.json` |
| AC-LAF-009 | T050–T056, T126–T138 | Primary: `evidence/v1/preflight/tuivision-contract.json#checks/mappings`; exactly `10/10`, independently failing on any mapping/count component |
| AC-LAF-010 | T050–T056, T126–T138 | Primary: `evidence/v1/preflight/tuivision-contract.json#checks/edges` and `#checks/latestCompletion`; exactly `6/6` plus `1/1`, with four binding and two advisory edges |
| AC-LAF-011 | T050–T056, T126–T138 | Primary: `evidence/v1/preflight/tuivision-contract.json#checks/backlog`; exactly `1/1` separate `DeferredOptional` backlog item |
| AC-LAF-012, AC-LAF-013, AC-LAF-014 | T084–T169 | `fleet/repository-acceptance.json`, `delivery/fleet-postmerge.json`, `fleet/product-boundary.json` |

The full Primary paths and executable token contracts are canonical in
`autonomous-run-gate-requirements.json`.

These three Primary decisions remain independent. An aggregate success count
cannot conceal a failed mapping, edge/latest-completion, or backlog component.

## Acceptance-readiness checklist

| Identifiers | Following tasks | Evidence paths |
|---|---|---|
| CHK001, CHK002, CHK003, CHK004 | T026–T033, T084–T145 | row projection and repository gate evidence |
| CHK005, CHK006, CHK007, CHK008 | T027–T033, T063–T069, T084–T145 | feature proof, canonical delta and linearised A11Y evidence |
| CHK009, CHK010, CHK011, CHK012 | T028–T049, T070–T076 | recovery, idempotence, parity, help and manpage evidence |
| CHK013, CHK014, CHK015, CHK016 | T033–T065, T077–T145 | repository adoption and exact TuiVision mapping/edge evidence |
| CHK017, CHK018, CHK019, CHK020 | T050–T061, T063–T066 | TuiVision counts/latest/backlog and path-boundary evidence |
| CHK021, CHK022, CHK023, CHK024 | T027–T049, T063–T066 | negative diagnostics, feature proofs, redaction and rollback evidence |
| CHK025, CHK026, CHK027, CHK028 | T063–T069, T084–T145 | platform, bilingual, WCAG and didactic-comment review evidence |
| CHK029, CHK030, CHK031, CHK032 | T070–T076, T084–T145 | dependency/product diffs, documentation impact and objective gate counters |
| CHK033, CHK034, CHK035, CHK036 | T050–T061, T070–T076, T084–T169 | parity/TuiVision/seven-row/delivery lifecycle evidence |
| CHK037, CHK038, CHK039, CHK040 | T077–T145 | scenario execution, sandbox base proof, serial order and position-39 proof |
| CHK041, CHK042, CHK043, CHK044 | T084–T169 | exact-head schema-2.0 evidence, phase results, and bounded MergeAndSync records |

Checklist items remain open until those later tasks execute. This mapping does
not convert planned commands or historical observations into current results.
