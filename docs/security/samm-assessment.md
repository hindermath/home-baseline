# SAMM-Assessment / SAMM Assessment: home-baseline

**Stand / State**: 2026-07-29
**Scope**: Wartungs-TUI

| SAMM-Praxis | Evidence | Bewertung |
|---|---|---|
| Strategy and Metrics | Spec, Erfolgskriterien, Dokumentations-Impact | Pass |
| Threat Assessment | STRIDE/CIA/CAPEC in `threat-model.md` | Pass |
| Security Requirements | FR-027 bis FR-034 und Negativtests | Pass |
| Secure Architecture | S-ADR und arc42-Konzept | Pass |
| Secure Build | Locked Restore, drei Plattformen, Exact Head | Pass |
| Security Testing | MSTest, Python, PSScriptAnalyzer, Secret-Scan | Pass |
| Defect Management | `RESULT_MISMATCH`, Evidence und Follow-up-Grenze | Pass |

Das Assessment belegt die Feature-Praxis und behauptet weder
Organisationsreife noch Zertifizierung. Bei einem offenen High- oder
Critical-Befund ist die Bewertung nicht mehr `Pass`.

*This assessment demonstrates the feature practice; it claims neither
organization-wide maturity nor certification. Any open High or Critical
finding invalidates the Pass result.*

<!-- EN: docs/security/samm-assessment.md
[DE-Zusammenfassung: SAMM-Evidence für die Wartungs-TUI.]
-->

## Feature 029: CI-Budget-Governance

| SAMM-Praxis | Evidence | Bewertung |
|---|---|---|
| Strategy and Metrics | getrennte Actions-/Copilot-Kosten, `<500/3000` | Pass |
| Threat Assessment | STRIDE+CIA/CAPEC und Trust Boundaries | Pass |
| Security Requirements | CBG-001–021, zehn ACs, fail-closed Tests | Pass |
| Secure Architecture | ADR-002, lokaler Hook plus Serververtrag | Pass |
| Secure Build | sichere Argument-Arrays, PSScriptAnalyzer, Secret-Scan | Pass |
| Security Testing | Contract-, Hook-, Workflow-, Mutation- und Paritätsfixtures | Pass |
| Defect Management | Blocker, nächste Aktion, Evidence und Re-Evaluation | Pass |

Dies ist eine Feature-Bewertung, keine Aussage zur Organisationsreife. Owner:
Security Owner; Reviewer: SAMM Reviewer. Jeder offene High/Critical-Befund,
neue Dependency oder Authority-Änderung löst eine Neubewertung aus.
