# Architekturreview / Architecture Review

| Sicht | Status | Evidence | Owner / Reviewer | Restrisiko / Trigger |
|---|---|---|---|---|
| Kontext und Schnittstellen | Fulfilled | Architekturabschnitte Kontext/Schnittstellen | Architecture Owner / iSAQB Reviewer | Providerflächen ändern sich |
| Building Blocks und Runtime | Fulfilled | PowerShell-Kern, Bash-Adapter, Python-Tests | Product Core Owner / Architecture Reviewer | Runtime-/Adapterdrift |
| Deployment-/Providergrenze | Fulfilled locally | ADR-003; FakeProvider Read/Write/Reconcile/Second-Pass/Inventory-Zustandsmaschine | Provider Surface Owner / Security Reviewer | API/UI-/Permissiondrift; Live bleibt Open |
| Qualität und Trade-offs | Fulfilled | Architektur und A11Y/Security-Checklisten | Architecture Owner / Quality Reviewer | neue Zielmenge/Operation |
| Technische Schuld | Fulfilled | manuelle Browserattestierung dokumentiert | Provider Surface Owner / Architecture Reviewer | DOM/API-Unterstützung ändert sich |
| Native/Live/Delivery | Open | spätere Primary-Evidence | Gate Owners / Reviewers | Phasen 9–11; Head/Providerdrift |

Semantischer Abgleich mit `plan.md`: Kontext, iSAQB-Sichten, Trust Boundaries,
PowerShell-7/.NET-Produktkern, Ein-Prozess-Adapter, Evidenceklassen und
offene Live-/Native-/Deliverygrenzen sind vollständig und widerspruchsfrei.
