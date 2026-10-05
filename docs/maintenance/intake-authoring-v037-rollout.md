# Intake Authoring v0.3.7: begrenzte Lieferung / Bounded delivery

Stand / Date: 2026-10-05. Owner: Thorsten Hindermann.
Documentation Impact: `UpdateRequired`.

## Auftrag und Grenzen / Authority and boundaries

DE: Der Auftrag umfasst Home Baseline, manifestgebundene Home Runtime sowie
Show-CommandTui400 und TinyCalc. MergeAndSync mit Admin-Bypass ist nur nach
erfolgreichen technischen Checks freigegeben. TinyCalc darf seine technischen
GSDB-Versions-/Hashbindungen erneuern; bestehende Findings, Statuswerte und
menschliche Entscheidungen bleiben erhalten. Kein Produktlauf, keine neue
Produkt-, Risiko- oder Releasefreigabe und kein weiterer Flotten-Rollout.

EN: Scope is Home Baseline, manifest-bound Home Runtime and exactly two pilots.
Admin delivery requires successful technical checks. TinyCalc may refresh
technical GSDB version/hash bindings, preserving findings, states and human
decisions. No product run, new acceptance decision or wider fleet rollout.

## Unveraenderliche Quelle / Immutable source

- Release: [v0.3.7](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.7), regular and non-draft.
- Source: [PR #14](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/14), commit `dbf135e89ba583fb27294f84e487cf1a5826604f`.
- Tag-ZIP SHA-256: `fc20a010c2124977249f926677d1bb2b03b81e7cd2a549bc4c7489de837e1427`.
- [Native source CI](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/actions/runs/37322753324): macOS, Linux and Windows successful.

DE: Das Patch korrigiert den direkt auswertbaren README-Installationsbefehl,
versioniert Metadaten und bewahrt bekannte historische v0.3.6-Receipts.
Unbekannte Generatoren und Schemafehler blockieren weiterhin. Prioritaet 64,
Schemas und Commands bleiben unveraendert. Die anderen 13 Presets behalten
ihre Versionen, Prioritaeten und Inhalte. Historische Berichte bleiben erhalten.

EN: This patch fixes the directly evaluable README command, updates metadata
and accepts known historical v0.3.6 receipts. Unknown generators and invalid
schemas remain blocked. Priority 64, schemas, commands and other presets stay
unchanged. Historical reports are not rewritten.

## Pruefung und Lieferung / Validation and delivery

DE: Zentrale Quellenbindung, fuenf betroffene Profile, aktuelle Guidance und
Vorlagen werden gemeinsam aktualisiert. Nur Authoring wird neu installiert;
anschliessend wird das vollstaendige 14er-Profil in Bash und PowerShell geprueft.
Quellen-/Kompositionstests, installierte Tests, Homogeneity, Dokumentations- und
Statistikpruefung sowie native PR-Checks liefern den technischen Nachweis.
Die exakten Merge- und Lauf-Links werden beim Lieferabschluss festgehalten.

EN: Update provenance, affected profiles, current guidance and templates together.
Reinstall only Authoring, then check the full fourteen-preset profile in both
shells. Source/composition, installed-package, documentation, statistics and
native CI checks establish technical proof; exact merge/run links are recorded
at closeout.

## Dokumentationsvertrag / Documentation contract

Zielgruppe / Audience: Maintainer, KI-Agenten, Pilot-Reviewer.
Leserpfad / Reader path: README DE/EN -> this report -> source lock and pilot PRs.
Kanonische Quelle / Canonical source: standalone preset tag; central matrices
and `preset-source-lock.json` bind integration. Owner: repository maintainer.
Dokumentklasse / Class: integration evidence, not product assurance.
Sprachpartner / Language partner: inline DE-first/EN-second; README pair aligned.
Navigation: current README links this report; historical reports retained.
Distribution: source evidence stays `sourceOnly`; guidance, matrices and selected
generated surfaces follow `homeRuntime`. Home sync uses preview/check-only.
Plattformgrenze / Platform boundary: local macOS proof and separate native CI;
unavailable platforms are not claimed as locally tested.
Re-Evaluation: next preset patch, changed source hash or delivery-gate failure.
Statistics use unchanged methodology and are rendered after source commits;
visible Git activity is not measured AI productivity.
