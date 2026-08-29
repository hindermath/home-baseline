# Spezifikations-Qualitätscheckliste: Flottenweite GitHub-Copilot-Review-Governance / Specification Quality Checklist: Fleet-Wide GitHub Copilot Review Governance

**Purpose / Zweck**: Vollständigkeit und Qualität der Spezifikation vor der Planung validieren / Validate specification completeness and quality before planning
**Created / Erstellt**: 2026-08-28
**Feature**: [spec.md](../spec.md)

## Inhaltsqualität / Content Quality

- [x] Keine unnötigen Implementierungsdetails; verbindliche Sprach-, Plattform-, Cmdlet-, Evidence- und Governanceangaben sind ausschließlich durch Constitution/Preset geforderte Constraints. / No unnecessary implementation details; language, platform, Cmdlet, evidence, and governance specifics are constitution/preset-mandated constraints only.
- [x] Auf Nutzerwert und fachliche Anforderungen fokussiert. / Focused on user value and business needs.
- [x] Für nicht technische Stakeholder auf CEFR B2 verständlich; Fachbegriffe werden im Kontext erklärt. / Understandable to non-technical stakeholders at CEFR B2; domain terms are explained in context.
- [x] Alle Pflicht- und alle anwendbaren Governanceabschnitte sind ausgefüllt. / All mandatory and applicable governance sections are complete.
- [x] Deutsch steht zuerst, Englisch danach; Zielgruppe Maintainer, Flotten-Operator*innen und Reviewer ist erklärt. / German comes first, English second; maintainers, fleet operators, and reviewers are declared.

## Anforderungsvollständigkeit / Requirement Completeness

- [x] Keine ungelösten Klarstellungsmarker oder Templateplatzhalter verbleiben. / No unresolved clarification markers or template placeholders remain.
- [x] Anforderungen sind testbar und eindeutig. / Requirements are testable and unambiguous.
- [x] Erfolgskriterien sind messbar. / Success criteria are measurable.
- [x] Erfolgskriterien sind technologieagnostisch; Providerfeldnamen erscheinen nur dort, wo der bindende Fachvertrag sie verlangt. / Success criteria are technology-agnostic; provider field names appear only where the binding business contract requires them.
- [x] Alle Abnahmeszenarien sind definiert. / All acceptance scenarios are defined.
- [x] Randfälle sind identifiziert. / Edge cases are identified.
- [x] Scope und Nicht-Ziele sind klar begrenzt. / Scope and non-goals are clearly bounded.
- [x] Abhängigkeiten und Annahmen sind identifiziert. / Dependencies and assumptions are identified.
- [x] `CRG-001` bis `CRG-018` sind ohne Lücke und Umnummerierung vorhanden. / `CRG-001` through `CRG-018` are present without gaps or renumbering.
- [x] `AC-CRG-001` bis `AC-CRG-010` sind ohne Lücke und Umnummerierung vorhanden. / `AC-CRG-001` through `AC-CRG-010` are present without gaps or renumbering.
- [x] Requirement- und Acceptance-Traceability ist explizit. / Requirement and acceptance traceability is explicit.
- [x] `22/6/2/16` ist nur als Planungssnapshot gekennzeichnet; CRG-001 erzwingt frische Ermittlung vor Mutation. / `22/6/2/16` is marked as planning snapshot only; CRG-001 requires fresh recomputation before mutation.

## Feature-Bereitschaft / Feature Readiness

- [x] Alle funktionalen Anforderungen besitzen klare Acceptance-Zuordnung. / All functional requirements have clear acceptance mapping.
- [x] Nutzerstories decken Primärabläufe ab. / User scenarios cover primary flows.
- [x] Das Feature erfüllt die messbaren Ergebnisse im Erfolgsabschnitt, sobald die zugeordneten Gates bestehen. / The feature meets the measurable outcomes once mapped gates pass.
- [x] Der External-Write-Gate bindet aktuelle operationsspezifische Providerautorität, Exact IDs, Vorzustand, Rollback, Secretscope und Drift. / The External Write Gate binds current operation-specific provider authority, exact IDs, before state, rollback, secret scope, and drift.
- [x] Der reviewte Pre-Implementation-Acceptance-Gate-Vertrag enthält stabile IDs, Scope, Befehl-/Runner-Token, Evidence und Re-Evaluation Trigger. / The reviewed pre-implementation acceptance-gate contract contains stable IDs, scope, command/runner tokens, evidence, and re-evaluation triggers.
- [x] Admin-Bypass bleibt Ausnahme nach regulärem protection-only Refusal und ersetzt keine Acceptance-, Security-, Review- oder Gate-Evidence. / Admin bypass remains an exception after regular protection-only refusal and replaces no acceptance, security, review, or gate evidence.
- [x] Provider-Admin-, Secret-, Subscription-, Budgetkauf-, Cancellation- und Position-7-Autorität werden nicht abgeleitet. / Provider-admin, secret, subscription, budget-purchase, cancellation, and Position-7 authority are not inferred.
- [x] Browsergebundene Accountsettings werden nicht durch Repository-API-Evidence vorgetäuscht. / Browser-only account settings are not falsely proven by repository API evidence.

## Governance- und Auditbereitschaft / Governance and Audit Readiness

- [x] Security, Architecture, iSAQB, A11Y, Cross-Platform, Agent Parity, Intake Sequencing und Autonomous Run sind mit `Applicable` oder `N/A`, Begründung, Status, Evidence und Re-Evaluation Trigger bewertet. / All required governance areas have applicability, rationale, status, evidence, and re-evaluation triggers.
- [x] NIST SSDF, CWE Top 25, OWASP ASVS, SBOM, VEX, AI-SBOM, SLSA, OpenSSF Scorecard, CAPEC, Zero Trust, SAMM, BSI C3A/C5 und regulatorische Scopes sind ausdrücklich bewertet. / Required security standards and regulatory scopes are explicitly assessed.
- [x] Primäre MSL, Bash-Adapter, sichere Codinggrenzen und Re-Evaluation sind erklärt. / Primary memory-safe language, Bash adapter, secure-coding boundaries, and re-evaluation are documented.
- [x] WCAG 2.2 AA, lineare text-first Evidence, CEFR B2 und didaktische Kommentarprüfung sind enthalten. / WCAG 2.2 AA, linear text-first evidence, CEFR B2, and didactic comment review are included.
- [x] Bash-/PowerShell-Parität, Unix-Manpage, bilinguale PowerShell-Hilfe, genehmigter Cmdlet-Name, `--dry-run` und `-WhatIf` sind enthalten. / Cross-platform script governance requirements are included.
- [x] Agenten-Paritätsflächen und die Bedingung für atomare Updates sind vollständig benannt. / Agent parity surfaces and the atomic-update condition are complete.
- [x] Intake Sequencing stimmt mit `Primary/Eligible`, terminaler Stage B und blockierter Position 7 überein. / Intake sequencing matches `Primary/Eligible`, terminal Stage B, and blocked Position 7.
- [x] Documentation Impact ist genau einmal `UpdateRequired` und enthält alle Governancefelder. / Documentation Impact is exactly once `UpdateRequired` and contains all governance fields.

## Validierungsnotizen / Validation Notes

- Iteration 1: Alle Positionen bestanden. / All items passed.
- Der aktive Spec-Template-Stack wurde aus Core plus Autonomous Run, Agent Parity, Cross-Platform, A11Y, iSAQB, Architecture und Security Governance vollständig berücksichtigt.
- Das optionale `after_specify`-Commit-Hook wird wegen des ausdrücklichen Commitverbots nicht ausgeführt.
- Specify-Payload: `specs/031-github-copilot-review-governance/spec.md`.
