# Cloud-Autonomie-Anwendbarkeit / Cloud Autonomy Applicability

**Status / Disposition**: Stage A `N/A`; Feature 030 Stage B `Applicable`
**Owner**: home-baseline Feature Owner
**Reviewer**: Cloud Architecture Reviewer
**Restrisiko / Residual risk**: Eine spätere Cloud-Runtime oder Providerbindung würde die Einordnung ändern.
**Follow-up**: Bei Cloud-Service oder Providerentscheidung neu bewerten.
**Re-Evaluation**: Bei Cloud-Runtime, Hosting-Auswahl oder Providerabhängigkeit.

## BSI C3A

`N/A`: Das Feature wählt, betreibt oder deployt keine Cloud-Runtime und
verändert keine Providerkonfiguration. GitHub dient nur als bestehende
GET-only-Entwicklungsbeobachtung; die Stage-A-Planung bleibt lokal. Owner:
Cloud Architecture Owner; Reviewer: Cloud Architecture Reviewer. Restrisiko:
spätere Stufe B kann Providerabhängigkeit erweitern. Trigger: Cloud-Service,
Hostingauswahl, providerabhängiges Deployment oder Remote-Mutation.

## Feature 030: BSI C3A – GitHub-Providerbetrieb

`Applicable` als Cloud-Autonomie-Review, weil Stage B GitHub-Hosting, Actions,
PRs und Rulesets liest und unter enger Authority mutiert. Dies ist keine
Behauptung einer C3A-Zertifizierung oder formalen BSI-Prüfung.

- **Auswahl und Abhängigkeit**: GitHub ist der gebundene Provider für diese
  Flotte; numerische IDs, kanonische Slugs, feste API-Hosts und Provider-
  spezifische Verträge sind explizit dokumentiert.
- **Shared Responsibility**: Repositoryowner verantworten Inhalte, Branches,
  Reviews und Rulesets; GitHub verantwortet gehostete Plattform/Runner;
  Laufowner verantworten Authority, minimale Credentials, exakte Commands,
  Evidence und Incident-Handoff.
- **Exit und Portabilität**: kanonische Git-Objekte, JSON-Schemas, Templates,
  Plan/State und redigierte Evidence bleiben exportierbar. Provider-spezifische
  PR-/Ruleset-Adapter sind getrennt; ein Providerwechsel benötigt neue
  Verträge und Re-Evaluation, keine stille Übersetzung.
- **Betrieb**: begrenzte Reads, keine blinden Write-Retries, serieller Writer,
  Budgetgates, Stop/Resume und fail-closed Verhalten bei Quota/Billing/403/404.
- **Logging/Incident**: minimierte Provideraktions-IDs, Workflow-/Run-/Job-
  Bindungen, Blockercode, letzte sichere Grenze und nächste Aktion; keine
  Tokens, Actor-Namen oder Rohantworten.

Owner: Cloud Architecture Owner. Reviewer: C3A-oriented Reviewer.
Restrisiko: Provider-Lock-in bei PR-/Ruleset-Semantik und gehosteten Runnern.
Re-Evaluation bei Providerwechsel, neuer Cloud-Runtime, Permission-, Runner-,
Region-, Exit-, Logging- oder Incident-Prozessänderung.
