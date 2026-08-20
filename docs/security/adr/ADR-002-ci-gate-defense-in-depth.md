# ADR-002: Defense in Depth für lokale CI-Gates / Defense in Depth for Local CI Gates

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Security Architecture Reviewer
**Restrisiko / Residual risk**: Ein lokaler Hook ist umgehbar und darf nie die unabhängige Servergrenze ersetzen.
**Follow-up**: Server-Minimal-Gate erst in einer neu autorisierten Stufe B anwenden.
**Re-Evaluation**: Bei Hook-, Evidence-, Server-Gate-, Ruleset- oder Authority-Änderungen.

## Kontext / Context

Ein lokaler Gate bindet Prüfungen an Repository-ID, Profil, HEAD und
Gate-Set-Hash. Der Pre-push-Hook konsumiert nur aktuelle atomare
Erfolgsevidence. Beide Kontrollen laufen jedoch im Benutzerkontext und können
lokal entfernt oder umgangen werden.

## Entscheidung / Decision

Wir verwenden Defense in Depth: lokale Evidence plus Hook liefert schnelle
Rückmeldung; ein unabhängiger, schlanker, pfadabhängiger Serverstatus
`home-baseline/ci-minimal-gate` und PR-Pflicht schützen später den Default
Branch. Direkte, Web- und API-Schreibpfade bleiben gesperrt,
`adminBypassNormalPath=false`. Stufe A simuliert diese Policy nur aus inaktiven
Templates und setzt `remoteConverged=false`.

*Local evidence and hook provide feedback. An independent lean server status
plus pull-request policy remains the authoritative bypass-resistant boundary.
Stage A simulates it only.*

## Folgen / Consequences

- Ein grüner Hook ist notwendig für den lokalen privaten Pushpfad, aber niemals
  Merge- oder Remote-Autorität.
- Fehlende, alte, fehlgeschlagene oder hashinkonsistente Evidence blockiert.
- Der Serververtrag bleibt auch bei Hook-Bypass unverändert beweisbar.
- Vollständige private PR-/Main-Builds werden nicht automatisch verdoppelt;
  Pflichtprüfungen bleiben lokal, der Server-Gate bleibt schlank.
- Stufe B benötigt neue Autorität, aktuelle Live-Evidence und separaten Review.

## Verworfene Alternativen / Rejected Alternatives

Nur Hook: umgehbar. Nur Server-Full-Build: unnötig teuer und langsam. Aktives
Ruleset in Stufe A: außerhalb der Authority. Admin-Bypass als Normalpfad:
verletzt Least Privilege und Fail-Safe Defaults.
