# Assurance: unabhängige Korrekturen / Independent Corrections

DE: Neuer Kontext für Baseline 3.4.3; historische Evidence unverändert.
[Prüfbericht](../../../maintenance/gsdb-independent-fixes-2026-10-20.md),
[Quellen](../../../maintenance/gsdb-source-review-independent-fixes-2026-10-20.json),
[Inventar](../../../maintenance/gsdb-inventory-independent-fixes-2026-10-20.json).
Technische Bindung ersetzt weder semantischen Review noch menschliche Freigabe.
EN: New context for baseline 3.4.3; historical evidence unchanged. Technical
binding replaces neither semantic review nor human approval.

| Gate | Ergebnis / Outcome | Evidence |
|---|---|---|
| Baseline | Ready, begrenzte Dokumentbindung / bounded document binding | [Binding](baseline.json) |
| Delta | Ready, begrenzte Reviewkorrekturen / scoped corrections | [Delta](deltas/001-independent-fixes.json) |
| Closure | Blocked, vier menschliche Entscheidungen Open / four human decisions Open | [Decisions](closure.json) |
| Image impact | Ready; N/A, kein Image geändert / no image changed | [Impact](image-impact.json) |

DE: Der zusätzliche Generatorcheck prüft aktive Metadaten strenger als das
installierte Assurance-Paket 0.1.4. Paketkorrektur ist getrennt; kein Merge,
Home-Sync oder Rollout. / EN: The additional generator gate validates active
metadata more strictly than installed Assurance 0.1.4. Package correction is
separate; no merge, Home sync or rollout.
