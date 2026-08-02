# Implementation Plan: Mitgeltende Dokumente und Spec-Kit-Verzahnung

**Branch:** `024-mitgeltende-dokumente-verzahnung` | **Date:** 2026-08-02

## Summary

Feature 024 prueft die bestehende Secure-Development-Dokumentfamilie, haertet
die vorhandene Mapping-Datei auf das Acht-plus-drei-Modell und liefert einen
feature-lokalen Python-Validator samt Ledger. Es aendert keine Runtime und zieht
die spaetere Assurance-Kette nicht vor.

## Technical Context

- Python 3 Standardbibliothek, Markdown und JSON; keine neue Dependency.
- Inputs: Baseline-Manifest, 12 Checklisten, 15 mitgeltende Dokumente, 11 installierte Presets.
- Outputs: aktualisiertes Mapping, text-first Review-Ledger und Feature-Evidence.
- Tests: `unittest`, positive/negative Fixtures, Secure-Development-Build,
  Homogeneity, PSScriptAnalyzer, Secret Scan und Provider-Matrix.

## Constitution Check

Security, A11Y und Documentation Impact sind anwendbar. Architektur/iSAQB
pruefen nur bestehende Zuordnungen. Supply Chain, AI-SBOM, Cloud, Runtime-
Threat-Model, Agent-Parity-Aenderung und operative Cross-Platform-Skripte sind
mit den Triggern aus `spec.md` `N/A`. Python ist MSL. Ergebnis: `PASS`.

## Structure

```text
specs/024-mitgeltende-dokumente-verzahnung/
├── spec.md, plan.md, research.md, data-model.md, quickstart.md, tasks.md
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── pr-evidence.md
├── contracts/mapping-acceptance.md
├── checklists/requirements.md, plan-review.md
├── tools/validate_mapping.py
├── tests/test_mapping.py
└── mapping-review.json
```

## Execution

1. Bind Intake, Review, Series and installed preset versions.
2. Write negative tests and validator before accepting the mapping update.
3. Inventory every managed document and checklist; record both status axes.
4. Update the existing mapping and its index entry only where findings require.
5. Run local gates, then commit, provider validation, review and merge.
6. Archive Position 5 and update Series only in a causal closeout if required.

## Documentation Impact

`UpdateRequired`: learners, trainers, maintainers and reviewers; canonical owner
is Secure-Development Governance. Mapping and its index are source-only,
bilingual, text-first, remote-published, and need no Home Sync.
