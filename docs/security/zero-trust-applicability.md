# Zero-Trust-Anwendbarkeit / Zero Trust Applicability: home-baseline

**Projekt / Project**: home-baseline (Level-1)
**Datum / Date**: 2026-04-24
**Status**: Teilweise anwendbar / Partially applicable
**Template-Quelle / Template Source**: `.specify/templates/zero-trust-applicability-template.md`

home-baseline ist lokal-first, nutzt aber Remote-Git-Hosting und
Credential-Stores. Die vollstaendige Bewertung erfolgt in der Template-Struktur.

*home-baseline is local-first, but it uses remote git hosting and credential
stores. The full evaluation should be captured using the template structure.*

## Feature 029: CI-Budget-Governance

Status: `Applicable` für Least Privilege, explizite Trust Boundaries und
fortlaufende Verifikation. GitHub-Zugriff ist auf REST-GET begrenzt; Registry,
Assignment, Sichtbarkeit, HEAD und Hash werden bei jedem Lauf neu geprüft.
Lokaler Hook und unabhängiger Serververtrag werden nicht gegenseitig als
Vertrauensersatz verwendet. Kein Admin-Bypass ist Normalpfad.

Owner: Security Architecture Owner; Reviewer: Zero-Trust Reviewer.
Restrisiko: kompromittierter lokaler Account. Re-Evaluation bei neuer Identität,
Remote-Mutation, Cloud-Runtime oder Netzvertrauensgrenze.
