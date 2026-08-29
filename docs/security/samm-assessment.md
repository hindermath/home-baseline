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

## Feature 030: Stage-B-SAMM-Assessment

| SAMM-Praxis | Evidence | Bewertung |
|---|---|---|
| Strategy and Metrics | fünf serielle Wellen, Budgetprojektion nach jeder Welle, getrennte Actions-/Copilot-Kategorien | Pass locally |
| Policy and Compliance | Zwölf-Preset-Matrix, C3A/C5-/Regulatory-Disposition, Documentation Impact | Pass for local artifacts |
| Threat Assessment | Feature-030 STRIDE+CIA, CAPEC-115/-15/-126/-23, Trust Boundaries | Pass |
| Security Requirements | SBR/AC-SBR/CR-Traceability, ExternalWriteGate, G4-Isolation | Pass locally; live gates pending |
| Secure Architecture | arc42 Abschnitt 8, ADR-002, immutable plan/mutable state, serial transaction | Pass |
| Secure Build | Standardbibliothek, SHA-gepinnte Action, exakter Kandidat, Secret-/Dependency-Gates | Pass locally |
| Security Testing | Contract-/Provider-/Security-/Ruleset-/Bypass-/Resume-/Redaktionsfixtures | Pass locally; T124 full regression pending |
| Operational Management | atomarer Stop, read-only Reconciliation, Resume-Revalidierung, Incident-/Evidence-Handoff | Pass by design |

Die Bewertung gilt nur für dieses Feature und ist weder SAMM-Reifegrad noch
Zertifizierung. Fehlende Live-Gates, offene T124-Regressionen oder ein
Critical-/High-Befund verhindern einen terminalen Pass. Owner: Security
Program Owner. Reviewer: SAMM Reviewer. Re-Evaluation bei Scope-, Provider-,
Authority-, Dependency-, Incident-, Gate- oder Evidence-Drift.

## Feature 031

| SAMM-Funktion | Status | Evidence |
|---|---|---|
| Governance/Strategy | Applicable, lokal erfüllt | Desired State und Traceability |
| Design/Threat Assessment | Applicable, lokal erfüllt | ADR-003 und Threat Model |
| Implementation/Secure Build | Applicable, lokal erfüllt | PSScriptAnalyzer, Bash-/Securitytests |
| Verification/Security Testing | Applicable, lokal erfüllt | positive/negative Matrix |
| Operations/Incident Management | Applicable, lokal erfüllt | Betriebs-, Rollback- und Incidentpfad |

Keine Reifegrad- oder Zertifizierungsbehauptung. Owner: Security Program Owner;
Reviewer: SAMM Reviewer. Restrisiko: Live-/Native-Evidence offen; Follow-up:
Phasen 9–11; Trigger: Scope-, Provider-, Authority- oder Incidentänderung.
