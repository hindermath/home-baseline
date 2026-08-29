# Secure Development Assurance Governance

Dieses optionale Spec-Kit-Preset prüft einen projektgeführten
Secure-Development-Nachweis. Es besitzt die Richtlinie oder Checklisten nicht,
ändert sie nicht automatisch und erteilt keine menschliche Freigabe.

Das Preset unterscheidet vier Gates: baseline, delta, closure und image-impact.
Jeder Prüfpunkt trennt Anwendbarkeit (Applicable, N/A, Open) und Umsetzung
(Fulfilled, Partly Fulfilled, Not Fulfilled, Not Assessed). Zulässige
Ergebnisse sind Ready, ReadyWithAcceptedRisks, NeedsRemediation und Blocked.

Es stellt genau zwei öffentliche Befehle bereit:

- $speckit-secure-development-status [<evidence-dir>]
- $speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>

Technische Validierung, Pilotfreigabe, Projektabnahme und allgemeine Sandbox-,
Produkt- oder Flottenfreigabe bleiben vier getrennte Entscheidungen.
HOSK/GWDG ist ausschließlich ein externer Vergleich und kein lokaler Nachweis.

## English

This optional Spec Kit preset validates project-owned secure-development
evidence. It does not own or automatically modify policy documents and cannot
grant a human approval. It keeps technical validation, pilot authorization,
project acceptance, and general sandbox/product/fleet authorization separate.
HOSK/GWDG is external comparison material only.
