# Audit Governance Checklist: Documentation Information Architecture Audit

| Checkpoint | Applicability | Result | Evidence | Re-evaluation trigger |
|---|---|---|---|---|
| NIST SSDF and CWE Top 25 | Applicable | Pass | Fail-closed path, hash, secret and negative-fixture validation | Input or validation boundary changes |
| OWASP ASVS | N/A | Pass | No web, API, authentication, or authorization behavior | Web/API/auth scope appears |
| SBOM, VEX, SLSA, OpenSSF Scorecard | N/A | Pass | No dependency, binary, package, or release artifact | Distributable or dependency scope appears |
| AI-SBOM | N/A | Pass | AI is an audit aid, not an operated component | AI runtime, model, service, or dataset ships |
| NIS2, CRA, EU AI Act, DORA | N/A | Pass | No regulated product or operating boundary changes | Product or regulatory trigger changes |
| STRIDE, CIA, CAPEC, Zero Trust, SAMM | N/A | Pass | Existing boundary is documented; no runtime trust flow changes | Architecture or trust boundary changes |
| S-ADR and arc42 update | N/A | Pass | No architecturally significant product decision | Product architecture changes |
| BSI C3A and BSI C5 | N/A | Pass | No cloud service or provider-dependent deployment | Cloud or provider dependency changes |
| WCAG 2.2 AA and learner policy | Applicable | Pass | Text-first bilingual report, reader paths, language and depth review | User-facing evidence format changes |
| Cross-platform audit proof | Applicable | Pass | Python standard-library fixtures plus provider discovery bridge | Test-tool path or normalization changes |
| Cross-platform product scripts | N/A | Pass | No product or maintenance script changed | Operational script-shaped tool changes |
| Agent parity | Applicable as audited content | Pass | All maintained surfaces inventoried; no shared guidance changed | Accepted shared-guidance finding |
| Intake Authoring/Review/Sequencing | Applicable | Pass | Accepted hashes and current Bash/PowerShell validators | Intake or Series drift |
| Autonomous Run | Applicable | Pass | State, gates, exact-head evidence, retrospective | Delivery mode or authority changes |
| Parallel Autonomous | N/A | Pass | Serialized shared evidence writers | Audit is partitioned safely in a later run |

Every `N/A` is fail-closed: if its trigger changes, implementation stops for
replanning rather than silently retaining the disposition.
