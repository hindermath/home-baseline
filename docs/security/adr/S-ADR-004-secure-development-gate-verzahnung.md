# S-ADR-004: Secure-Development-Gates zwischen Home Baseline und ABSDD

**Status:** Accepted for handoff; Baseline-3.3 adoption pending
**Datum:** 2026-08-29

## Entscheidung

Secure-Development-Evidence wird künftig über die vier Gates baseline, delta,
closure und image-impact strukturiert. Anwendbarkeit und Umsetzung bleiben
getrennte Achsen. Technische Validierung, Pilotfreigabe, Projektabnahme und
allgemeine Freigabe sind unabhängige Entscheidungen.

Das optionale Dreizehner-Profil ergänzt das bestehende Zwölfer-Profil um
secure-development-assurance-governance auf Priorität 15. Profile 8 bis 12
bleiben unverändert. HOSK/GWDG ist ExternalComparison-only.

## Folgen

- Positive technische Evidence kann keine menschliche Freigabe erzeugen.
- ABSDD-Adoption benötigt einen separaten Lauf und eigene Authority.
- Baseline 3.3.0 kann den Vertrag nach Position 14/15 übernehmen, ohne
  projektspezifische ABSDD-Evidence zu besitzen.
- Source-only GeneratedUpdate benötigt keinen Home-Sync.

## English

The four gates and independent decision boundaries form the future integration
contract. ABSDD adoption and human approvals remain separate work.
