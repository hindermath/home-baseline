# Cloud-Compliance-Assurance

**Status / Disposition**: Stage A `N/A`; Feature 030 Stage B `Applicable`
**Owner**: home-baseline Feature Owner
**Reviewer**: Cloud Compliance Reviewer
**Restrisiko / Residual risk**: Eine spätere Nutzung als Cloud-Service kann BSI-C5-Kontrollen auslösen.
**Follow-up**: Bei Cloud-Service oder produktivem Hosting neu bewerten.
**Re-Evaluation**: Bei Cloud-Service, produktivem Hosting oder Providerbetrieb.

## BSI C5

`N/A`: home-baseline stellt mit diesem Feature keinen Cloud-Service bereit und
betreibt kein produktives Hosting. Lokale Evidence und read-only GitHub-
Metadaten sind keine Cloud-Service-Erbringung. Owner: Cloud Compliance Owner;
Reviewer: Cloud Compliance Reviewer. Restrisiko: spätere gehostete
Automatisierung. Trigger: Cloud-Service, produktives Hosting, Providerbetrieb
oder Verarbeitung von Kundendaten.

## Feature 030: BSI C5 – Assurance-Review des Providerbetriebs

`Applicable` als kontrollbezogene Reviewfläche für GitHub-Hosting, Actions,
PRs und Rulesets. Das Repository besitzt und behauptet weder ein GitHub-
Testat noch eine eigene BSI-C5-Zertifizierung. Provider-Assurance muss vor
einem formalen Compliance-Claim separat beschafft und fachlich geprüft werden.

| Kontrollthema | Stage-B-Umsetzung |
|---|---|
| Organisation/Shared Responsibility | Provider-, Repository-, Run-, Security- und Reviewer-Verantwortung sind getrennt; Authority ist explizit. |
| Identity and Access | bestehender Credential Store, minimale Scopes, feste Identität, Least Privilege und kein Bypass-Normalpfad. |
| Change Management | exakter Kandidat, PR, konkrete Checks, Review, Merge, Ruleset-Verifikation und kausale Evidence. |
| Operations/Availability | Timeouts, bounded reads, Budgetgate, serieller Writer, atomarer Stop/Resume und keine blinden Writes. |
| Logging/Monitoring | Run-/Action-/Workflow-/Job-/Head-/Hashbindung, minimierte redigierte Records, Incident-Handoff. |
| Portability/Exit | Git-Objekte, Schemas, Templates und Evidence exportierbar; Provideradapter bleibt austauschbare Grenze. |

Owner: Cloud Compliance Owner. Reviewer: C5-oriented Reviewer. Restrisiko:
Providerkontrollen und Runner-Images liegen außerhalb des Repositories;
fehlende aktuelle Assurance ist kein Pass. Re-Evaluation bei Provider-,
Assurance-, Permission-, Logging-, Incident-, Datenklassen- oder
Shared-Responsibility-Änderung.
