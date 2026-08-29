# Implementierungs-Governance / Implementation Governance

**Stable boundary / Stabile Grenze**: `Implement/Active`, 155/168. Aktuelle
Routingphase und naechste Aktion werden nicht hier gecacht, sondern bei jeder
Beobachtung aus `autonomous-run-state.json` gelesen.

**Owner / Reviewer**: Feature Owner / Acceptance and Governance Reviewers

| Bereich / Area | Applicability | Status | Evidence | Owner / Reviewer | Restrisiko / Residual risk | Follow-up / Re-Evaluation |
|---|---|---|---|---|---|---|
| A0 Runner und Vorimplementierung | Applicable | Fulfilled | `pre-implementation-acceptance.md` | Runner Governance Owner / Autonomous Reviewer | Keine lokal | Bei Runnerdrift |
| US1 lokale Inventursemantik | Applicable | Fulfilled locally | `operational/stories/us1-green-macos.json` | Inventory Owner / Privacy Reviewer | Liveinventur fehlt bis Phase 10 | T131; Trigger: Provider/API/UI-Drift |
| US2 lokale Transaktionssemantik | Applicable | Fulfilled locally | `operational/stories/us2-green-macos.json` | Transaction Owner / Security Reviewer | Providerkonvergenz fehlt | Phase 11; Trigger: IDs/Authority/Hash-Drift |
| US3 Reviewsemantik | Applicable | Fulfilled locally | `operational/stories/us3-green-macos.json` | PR Lifecycle Owner / Human Review Owner | Provider-Lifecycle-Proof fehlt | T143-T147; Trigger: Quota/Providerstatus |
| US4 Usage/Privacy | Applicable | Fulfilled locally | `operational/stories/us4-green-macos.json` | Usage Owner / Privacy Reviewer | Frische Billingdaten fehlen | Phase 10; Trigger: Billingowner/Quelle |
| US5 macOS-Paritaet/A11Y | Applicable | Fulfilled locally | `operational/platform/macos.json` | Cross-Platform Owner / A11Y Reviewer | Native Linux/Windows offen | T126-T128; Trigger: Skript-/Runneraenderung |
| Security und Architektur | Applicable | Fulfilled locally | `security.md`, `architecture.md` | Security/Architecture Owners / Reviewers | Live/native proof offen | Phasen 9-11; Trigger: Produkt-/Providerdrift |
| Dokumentation und Agent-Paritaet | Applicable | Fulfilled | `documentation-impact-evidence.json`, `agent-parity.md` | Documentation/Governance Owners / Reviewers | Home Sync nicht ausgefuehrt | Separat autorisieren; Trigger: Guidance/Distribution |
| Provider-/Live-/Native-Evidence | Applicable | Open | Supplemental-Records | Gate Owners / Gate Reviewers | Blockiert Primary/Passed | Phasen 9-11; Trigger: exakte frische Evidence |
| Delivery, Home und Position 7 | Applicable | Open | Run-State und Scopevertrag | Delivery/Intake Owners / Reviewers | Nicht Teil von implement-local | Spaetere geroutete Phasen; keine Vorwegnahme |
| Historische lokale Sanierungen 1–3 | Applicable | Superseded / historical | `implementation-remediation-1.md`, `implementation-remediation-2.md`, `implementation-remediation-3.md`; unveraenderliche Envelope-/Receipt-Bindung `implementation-remediation-supersession-bindings.json`; blockierende Analysen `implementation-analysis-local.md` bis `implementation-analysis-local-4.md` | Remediation Owner / Analyze and Audit Reviewers | Historische Claims und Bindungen erteilen kein aktuelles Gate | Nur Lineage; Trigger: Audit, Hashdrift oder Widerspruch in aktiven Leseflaechen |
| IAL4-001..IAL4-003 lokale Sanierung | Applicable | Fulfilled locally / terminal historical | `implementation-remediation-4.md`, aktueller T121-Record `operational/quality/final-local-macos.json`; `implementation-analysis-local-5.md` bestaetigt die technische Reparatur und ist selbst Blocked | Remediation Evidence, Autonomous Run und Test Harness Owners / Acceptance, Governance and Documentation Reviewers | IAL5-Reader-/Auditbefunde bleiben getrennt | Trigger: Source-, Test-, Runner-, Help-, Reader- oder Evidence-Drift |
| IAL5-001..IAL5-002 lokale Reader-/Audit-Sanierung | Applicable | Status aus kanonischem State beobachten | transition-safe `../autonomous-run-evidence.md`, `implementation-analysis-local-5.md`, `implementation-remediation-supersession-bindings.json`, `implementation-remediation-5.md` | Autonomous Run and Evidence Owners / Governance and Audit Reviewers | Der Outer Runner muss Ergebnis und State abgleichen; kein T123- oder External-Gate-Claim | Nach runnerseitiger Annahme exakt frisches `analyze-local-6`; Trigger: Reader-, Routing-, Receipt-, Result- oder Hashdrift |

Jede `Open`-Zeile besitzt Owner, Follow-up und Re-Evaluation-Trigger. Lokal
bestandene Fixturetests werden nie als Primary-, Live-, Native- oder Delivery-
Pass ausgegeben.

*Every Open row has an owner, follow-up, and re-evaluation trigger. Passing
local fixture tests are never reported as primary, live, native, or delivery
evidence.*

## Implement-Provider Resume T124 / Wiederaufnahme T124

Die runnerseitige Nachfolgeanalyse `analyze-local-6` ist der aktuelle,
schema- und hashgueltige Abschluss von T123. Ihr Resultat-SHA-256 ist
`ebcc85bea4f827afd7a6818f697e0929b6258c209a91b20987d57fcaf73af9f7`,
der Payload-SHA-256 ist
`1a986a1d8b52f9186daeedaa6bd3b9e5bcf2276a54bc862b473b7b3e999db178`.
Der kanonische State und beide State-Validatoren bestaetigen
`Implement/Active 123/168`; der aktuelle Tasks-SHA-256 ist
`49fe565defbfbb24a47e31d630d909a04e0ebbe039e7f5ffe785d165a95513fe`.
Alle zehn akzeptierten Artefakte sind normalisiert hash-exakt.

Die historische T121-Evidence bleibt unveraendert bei ihrer damaligen
`122/168`-Grenze und ihrem damaligen Volltesthash. T124 ersetzt oder
ueberschreibt diesen Beleg nicht. Der frische Nachfolger bindet zwei vollstaendige
71/71-Laeufe mit 29 unabhaengigen Vertraegen, 42 Aggregaten, null Fehlern,
`liveProviderWrites=0` und `networkWrites=0`; der aktuelle Runtime-Beleg hat
SHA-256
`b20c3be52bb34c526916a9b9b57b9def56131603e854287c1ca9ebb4d5c206d5`.
Beide aktuellen isolierten Runnerflaechen bestehen 18/18. PSScriptAnalyzer
prueft 173 Dateien ohne Error/Warning; Documentation Impact, generierte
Skriptreferenz, Script-Referenztests, Secret Scan und Diff-Pruefungen bestehen.

*The historical T121 record remains immutable at its original 122/168
boundary. T124 binds the fresh successor evidence after the runner-owned T123
closure and grants no native, provider-write, merge, bypass, or final-delivery
authority.*

## Safe Boundary A2-Checkpoint T125

Status: `Reached` fuer die begrenzte Checkpoint-Lieferung an native CI.

- Beabsichtigte versionierte Pfadmenge: der vollstaendige reviewte G4-
  Implementierungs-, Spezifikations-, Dokumentations- und Evidence-Stand samt
  bereits autorisierten Intake-Series-Sequencing-Aenderungen; private Runtime,
  lokale Konfiguration, Caches und fremde Daten sind ausgeschlossen.
- Intended-path-set: 137 versioned checkpoint paths, sorted with `LC_ALL=C`.
- Intended-path-set SHA-256: `15af95b2cf2af3c3a09b3b51d8d36ad88889dc05a85f0b213bb538ffd6c35413`.
- Kanonischer State bei A2: `Implement/Active 123/168`; T124/T125-Fakten
  werden dem Outer Runner zur spaeteren ausschliesslich runner-owned
  Reconciliation geliefert und hier nicht vorweggenommen.
- Lokale Gates: macOS-first Semantik 71/71, direkte/wrapperbasierte Runner-
  Matrix je 18/18, Security, Architecture, A11Y, Documentation Impact,
  Parser/Analyzer, Generated Reference, Secret Scan und Diff-Checks gruen.
- Provider-Gates: geschlossen; kein `operational/provider-gates`-Record mit
  `Authorized`, Live-Provider-/Account-/Ruleset-/Billingwrites jeweils `0`.
- Delivery: Checkpoint-Commit, Branch-Push und genau ein regulaerer PR sind nur
  fuer den automatischen Linux-/Windows-Nachweis erlaubt. Merge, finaler
  Delivery-Abschluss, Home-Sync und Admin-Bypass bleiben `Open`.
- Re-Evaluation: jede Pfad-, Blob-, State-, Tasks-, Gate-, Workflow-,
  Authority- oder Providerdrift invalidiert diese A2-Bindung.

*A2 permits only the bounded checkpoint commit, push, regular PR, and exact-head
native CI proof. Provider writes and final delivery remain closed.*

## Primaerer Delivery Set T156 / Primary Delivery Set T156

**Review status**: `Reviewed / Bound for PreMerge`

**Owner / Reviewer**: Delivery Owner / Authority Reviewer

Die primaere Liefermenge umfasst exakt die folgenden `141` versionierten
Pfade. Sie ist relativ zum Merge-Base von `origin/main`, dem aktuellen Branch
und dem T155-Worktree gebildet, mit `LC_ALL=C` sortiert und besitzt den
Mengen-SHA-256
`b3c33d3328b9212e2c652965c5443d3a12a21c7b25c639f09c2561ff19dd7c79`.
Private Runtime, lokale Konfiguration, Caches und fremde Pfade sind
ausgeschlossen.

- `.github/workflows/copilot-review-governance-native-proof.yml`
- `.specify/feature.json`
- `.specify/presets/autonomous-run-governance/docs/man/invoke-autonomous-model-phase.1`
- `.specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1`
- `.specify/presets/autonomous-run-governance/tests/fixture-model-runner.ps1`
- `.specify/presets/autonomous-run-governance/tests/test-model-routing.ps1`
- `.specify/presets/autonomous-run-governance/tests/test-model-routing.sh`
- `CHANGELOG.md`
- `Lastenheft_Abarbeitungsreihenfolge.md`
- `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.031-github-copilot-review-governance.md`
- `README.md`
- `docs/README.md`
- `docs/accessibility/copilot-review-governance.md`
- `docs/architecture/copilot-review-governance.md`
- `docs/man/manage-copilot-review-governance.1.md`
- `docs/operations/copilot-review-governance.md`
- `docs/project-statistics.config.json`
- `docs/project-statistics.md`
- `docs/scripts/README.md`
- `docs/scripts/reference.md`
- `docs/security/adr/ADR-003-copilot-review-governance-boundaries.md`
- `docs/security/arc42-security.md`
- `docs/security/asvs-verification.md`
- `docs/security/cloud-autonomy-applicability.md`
- `docs/security/cloud-compliance-assurance.md`
- `docs/security/dependency-audit.md`
- `docs/security/regulatory-applicability.md`
- `docs/security/samm-assessment.md`
- `docs/security/security-checklist.md`
- `docs/security/security-quality-scenarios.md`
- `docs/security/supply-chain-evidence.md`
- `docs/security/threat-model.md`
- `docs/security/zero-trust-applicability.md`
- `requirements/intakes/series/home-baseline-delivery/history/ee66e610-c764-43bc-90e1-f9b1256156b0/manifest.json`
- `requirements/intakes/series/home-baseline-delivery/history/ee66e610-c764-43bc-90e1-f9b1256156b0/receipt.json`
- `requirements/intakes/series/home-baseline-delivery/manifest.json`
- `requirements/intakes/series/home-baseline-delivery/operations/ee66e610-c764-43bc-90e1-f9b1256156b0.json`
- `requirements/intakes/series/home-baseline-delivery/receipt.json`
- `scripts/config/copilot-review-governance-desired-state.json`
- `scripts/config/script-catalog.json`
- `scripts/manage-copilot-review-governance.ps1`
- `scripts/manage-copilot-review-governance.sh`
- `scripts/modules/CopilotReviewGovernance.psm1`
- `scripts/test-script-reference.ps1`
- `scripts/tests/copilot-review-governance/fixtures/a11y/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/browser/valid-before.json`
- `scripts/tests/copilot-review-governance/fixtures/contracts/negative/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/contracts/positive/account-setting-record-set.json`
- `scripts/tests/copilot-review-governance/fixtures/inventory/negative/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/inventory/positive/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/manual-review/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/planner/negative/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/planner/positive/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/platform-parity/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/pr-lifecycle/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/provider/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/redaction/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/usage/cases.json`
- `scripts/tests/copilot-review-governance/fixtures/vertical-slice/home-baseline-green.json`
- `scripts/tests/run_copilot_review_governance_acceptance.py`
- `scripts/tests/test_copilot_review_governance.py`
- `specs/031-github-copilot-review-governance/autonomous-run-evidence.md`
- `specs/031-github-copilot-review-governance/autonomous-run-gate-requirements.json`
- `specs/031-github-copilot-review-governance/autonomous-run-state.json`
- `specs/031-github-copilot-review-governance/checklists/a11y.md`
- `specs/031-github-copilot-review-governance/checklists/agent-parity.md`
- `specs/031-github-copilot-review-governance/checklists/architecture.md`
- `specs/031-github-copilot-review-governance/checklists/autonomous-readiness.md`
- `specs/031-github-copilot-review-governance/checklists/clarifications.md`
- `specs/031-github-copilot-review-governance/checklists/governance.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local-2.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local-3.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local-4.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local-5.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local-6.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-analysis-local.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-governance.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-provider.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-1.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-2.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-3.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-4.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-5.md`
- `specs/031-github-copilot-review-governance/checklists/implementation-remediation-supersession-bindings.json`
- `specs/031-github-copilot-review-governance/checklists/plan-review-2.md`
- `specs/031-github-copilot-review-governance/checklists/plan-review-3.md`
- `specs/031-github-copilot-review-governance/checklists/plan-review.md`
- `specs/031-github-copilot-review-governance/checklists/pre-implementation-acceptance.md`
- `specs/031-github-copilot-review-governance/checklists/requirements.md`
- `specs/031-github-copilot-review-governance/checklists/script-parity.md`
- `specs/031-github-copilot-review-governance/checklists/security.md`
- `specs/031-github-copilot-review-governance/checklists/tasks-analysis.md`
- `specs/031-github-copilot-review-governance/contracts/desired-state.schema.json`
- `specs/031-github-copilot-review-governance/contracts/external-write-gate.schema.json`
- `specs/031-github-copilot-review-governance/contracts/inventory.schema.json`
- `specs/031-github-copilot-review-governance/contracts/mutation-plan.schema.json`
- `specs/031-github-copilot-review-governance/contracts/mutation-result.schema.json`
- `specs/031-github-copilot-review-governance/contracts/provider-workflow-contract.md`
- `specs/031-github-copilot-review-governance/contracts/rollback.schema.json`
- `specs/031-github-copilot-review-governance/contracts/terminal-evidence.schema.json`
- `specs/031-github-copilot-review-governance/data-model.md`
- `specs/031-github-copilot-review-governance/documentation-impact-evidence.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-001-inventory.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-002-exact-target-set.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-003-disable-retain-rollback.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-004-review-parameters.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-005-pr-lifecycle.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-006-manual-review-preserved.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-007-gate-map.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-008-usage-redaction.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-009-idempotency-platform.json`
- `specs/031-github-copilot-review-governance/evidence/v1/ac-crg-010-position-7-isolation.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-001-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-002-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-003-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-004-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-005-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-006-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-007-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-008-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-009-fixtures.json`
- `specs/031-github-copilot-review-governance/evidence/v1/supplemental/AC-CRG-010-fixtures.json`
- `specs/031-github-copilot-review-governance/plan.md`
- `specs/031-github-copilot-review-governance/quickstart.md`
- `specs/031-github-copilot-review-governance/research.md`
- `specs/031-github-copilot-review-governance/retrospective.md`
- `specs/031-github-copilot-review-governance/spec.md`
- `specs/031-github-copilot-review-governance/tasks.md`
- `specs/flottenweite-github-copilot-review-governance-und-kostenbegrenzung-intake-review/intake-review-report.md`
- `specs/flottenweite-github-copilot-review-governance-und-kostenbegrenzung-intake-review/intake-review-request.json`
- `specs/flottenweite-github-copilot-review-governance-und-kostenbegrenzung-intake-review/intake-review-result.json`
- `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/docs/man/invoke-autonomous-model-phase.1`
- `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1`
- `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/tests/fixture-model-runner.ps1`
- `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/tests/test-model-routing.ps1`
- `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/tests/test-model-routing.sh`
- `specs/spec-kit-presets/autonomous-run-governance/docs/man/invoke-autonomous-model-phase.1`
- `specs/spec-kit-presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1`
- `specs/spec-kit-presets/autonomous-run-governance/tests/fixture-model-runner.ps1`
- `specs/spec-kit-presets/autonomous-run-governance/tests/test-model-routing.ps1`
- `specs/spec-kit-presets/autonomous-run-governance/tests/test-model-routing.sh`

Die spaetere T166-Allowlist ist absichtlich enger und gehoert nicht zum
primaeren T158-Set. Nach T158 duerfen ausschliesslich diese Pfade fortgeschrieben
oder, fuer die beiden Receipts, neu erzeugt werden:

- `specs/031-github-copilot-review-governance/autonomous-run-state.json`
- `specs/031-github-copilot-review-governance/autonomous-run-evidence.md`
- `specs/031-github-copilot-review-governance/tasks.md`
- `specs/031-github-copilot-review-governance/evidence/v1/finalization/primary-delivery.json`
- `specs/031-github-copilot-review-governance/evidence/v1/finalization/completion-delivery.json`

PostMerge-, Default-Sync-, Home-Sync-, finale Serien- und `Completed`-Fakten
sind `Open`. Jede Abweichung von der 141-Pfad-Menge vor T158 oder von der
fuenfpfadigen Finalization-Allowlist danach erzwingt Re-Evaluation.

## Bidirektionale Traceability / Bidirectional traceability

| Bereich | Aufgaben | Evidence |
|---|---|---|
| CRG-001..002, 013..017 / SC-001 | T026–T041 | Inventur-, Browser- und US1-Records |
| CRG-003..012, 015..017 / SC-002..006 | T042–T060 | Plan-, Gate-, Transaktions- und US2-Records |
| CRG-007..012 / SC-005..008 | T061–T073 | Lifecycle-, Manual- und Gate-Map-Records |
| CRG-013..014, 017 / SC-009,012 | T074–T082 | Usage-, Attribution- und Redaction-Records |
| CRG-015..018 / SC-010..011 | T083–T096 | Plattform-, A11Y-, Help- und Paritätsrecords |
| CR-001..010 und Governance | T097–T122 | Architektur, Security, Docs, Reviews und Supplemental-Matrix |

AC-CRG-001..010 besitzen jeweils einen versionierten Scopevertrag, einen
Supplemental/Open-Record und einen späteren Primary-Befehl. Kein Requirement,
Success Criterion oder Governancebereich bleibt ohne Aufgabe und Evidence.
