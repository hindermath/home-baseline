# Regulatorische Anwendbarkeit / Regulatory Applicability

**Status / Disposition**: N/A for direct product regulation in Stage A
**Owner**: home-baseline Feature Owner
**Reviewer**: Security and Compliance Reviewer
**Restrisiko / Residual risk**: Ein späterer produktiver, regulierter oder gehosteter Einsatz kann die Einordnung ändern.
**Follow-up**: Einordnung bei Markt-, Kunden-, Betriebs- oder Sektoränderung neu prüfen.
**Re-Evaluation**: Bei produktiver Nutzung, regulierter Organisation, Hosting oder personenbezogener Verarbeitung.

## Einzelentscheidungen / Individual Decisions

| Regelwerk | Disposition | Begründung |
|---|---|---|
| NIS2 | N/A | Private Workspace-Infrastruktur, kein in Scope bewerteter wesentlicher/wichtiger Dienst. |
| CRA | N/A | Kein digitales Produkt wird in Stufe A auf dem Markt bereitgestellt. |
| EU AI Act | N/A | KI ist Entwicklungswerkzeug; keine AI-Runtime, kein Modell oder Inferenzdienst wird betrieben/ausgeliefert. |
| DORA | N/A | Kein Finanzunternehmen oder IKT-Drittservice im DORA-Scope. |

Owner: Compliance Owner; Reviewer: Security and Compliance Reviewer.
Restrisiko: Organisation/Verwendung kann außerhalb dieses Repositories anders
einzuordnen sein. Trigger: Markt-/Kundenübergabe, regulierter Betrieb,
Finanzsektorrolle, AI-Runtime oder personenbezogene produktive Verarbeitung.

## Feature 030: Stage-B-Einzelentscheidungen / Stage B Decisions

| Regelwerk | Disposition | Begründung | Owner / Reviewer | Re-Evaluation |
|---|---|---|---|---|
| NIS2 | N/A | Stage B verwaltet private Workspace- und CI-Governance; es ist kein als wesentliche/wichtige Einrichtung bewerteter Dienst und trifft keine organisationsweite NIS2-Scopeentscheidung. | Compliance Owner / NIS2 Reviewer | Organisation wird in Scope bewertet, produktiver kritischer Dienst oder Incident-/Risikomanagement-Scope entsteht. |
| CRA | N/A | Weder die Skript-Control-Plane noch Templates werden in diesem Feature als Produkt mit digitalen Elementen auf dem EU-Markt bereitgestellt. | Product Compliance Owner / CRA Reviewer | Marktbereitstellung, kommerzielle Distribution, Produktintegration oder Herstellerrolle entsteht. |
| EU AI Act | N/A | KI ist nur Entwicklungswerkzeug; Stage B liefert kein KI-System, Modell, Dataset, Agentendienst oder Inferenzfeature aus und trifft keine automatisierte Personenentscheidung. | AI Governance Owner / EU-AI-Act Reviewer | AI-Runtime, Modell-/Dataset-Distribution, Anbieter-/Betreiberrolle oder entscheidungsrelevante KI entsteht. |
| DORA | N/A | Das Feature ist weder Finanzunternehmen noch IKT-Drittservice für Finanzunternehmen und betreibt keinen DORA-vertraglichen Produktionsdienst. | Financial Compliance Owner / DORA Reviewer | Finanzsektorrolle, IKT-Drittservice, vertragliche Leistung oder produktive Kundendatenverarbeitung entsteht. |

Diese `N/A`-Entscheidungen sind keine Rechtsberatung und keine Aussage über
Thorstens Organisation außerhalb des Repositoryscopes. Restrisiko: Nutzung
oder Distribution kann sich unabhängig vom Code ändern. Reviewer:
Security and Compliance Reviewer. Re-Evaluation zusätzlich bei Provider-,
Hosting-, Kunden-, Personen-, Markt- oder Sektoränderung.
