# Dauerhafter Admin-Bypass für Pull Requests

**Documentation Impact**: `UpdateRequired`

## Entscheidung

Das private Governance-Ruleset führt die GitHub-Repository-Rolle `Admin`
dauerhaft als Bypass-Akteur mit `bypass_mode=pull_request`. Damit kann eine
ausdrücklich autorisierte `MergeAndSync`-Lieferung eine ausschließlich formale
Approval-Sperre überwinden, ohne direkte Pushes freizugeben.

`adminBypassNormalPath` bleibt `false`. Vor der Verwendung müssen der aktuelle
PR-Head, alle materiellen technischen Gates und alle Review-Threads konvergiert
sein. Der Bypass ersetzt nur die formale GitHub-Approval-Regel.

## Verteilung und Nachweis

Kanonische Quelle ist
`scripts/templates/ci-budget-governance/private-governance-ruleset.json`;
Schema, Stage-B-Validator, Transaktionsfixture, Tests, Threat Model und ADR-002
werden gemeinsam gepflegt. Die Live-Rulesets von `c64-baseline`,
`clion-baseline`, `rider-baseline` und `container-images` wurden am
2026-09-12 ergänzt und nach dem Schreiben erneut gelesen. Bereits vorhandene
Admin-Bypässe blieben unverändert.

Owner ist der Home-Baseline-Maintainer. Zielgruppen sind Fleet-Maintainer und
Reviewer. Die Änderung ist `sourceOnly`; ein Home-Sync ist nicht erforderlich.
Neu bewertet wird bei Änderungen an GitHub-Rollen-IDs, Bypass-Modi,
Merge-Autorität oder materiellen Gate-Anforderungen.

## English

The private-governance ruleset permanently includes the GitHub repository
`Admin` role with `bypass_mode=pull_request`. This permits an explicitly
authorized `MergeAndSync` delivery to overcome a formal approval requirement
without enabling direct pushes.

`adminBypassNormalPath` remains `false`. The current PR head, all material
technical gates, and all review threads must converge before the bypass is
used. The canonical template, schema v1.1, validator, transaction fixture,
tests, threat model, and ADR-002 carry the same rule. This source-only change
does not require a Home sync.
