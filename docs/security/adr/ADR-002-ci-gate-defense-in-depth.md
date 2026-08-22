# ADR-002: Defense in Depth für lokale CI-Gates / Defense in Depth for Local CI Gates

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Security Architecture Reviewer
**Restrisiko / Residual risk**: Ein lokaler Hook ist umgehbar und darf nie die unabhängige Servergrenze ersetzen.
**Follow-up**: Stage B liefert den Server-Minimal-Gate und Ruleset nur über den regulären, exakt belegten Remote-Transaktionspfad; Live-Lieferung bleibt bis T127 ff. gesperrt.
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

## Stage-B-Erweiterung / Stage B Extension

Stage B setzt die frühere Handoff-Entscheidung um, ohne den Schutzvertrag zu
schwächen. Der Workflow wird zuerst als exakter Kandidat über Branch, lokales
Gate, PR, konkrete Remote-Checks und regulären Review geliefert. Erst nach
dessen Merge darf die getrennte Ruleset-Transaktion den Status
`home-baseline/ci-minimal-gate`, PR-Pflicht, eine Approval und `strict=true`
installieren. Direkte, Web- und API-Schreibpfade bleiben gesperrt; es werden
keine Bypass-Akteure konfiguriert.

Jede Remote-Aktion bindet Run-ID, numerische Repository-ID, Baseline-/
Candidate-Head, Planhash und einen stabilen Idempotency Key. Unklare Writes
werden read-only reconciled und nicht blind wiederholt. Stop persistiert die
letzte sichere Grenze atomar; Resume vermittelt Plan, Fleet, Authority,
Providerzustand, Evidence und Budget vollständig neu.

Der reguläre Merge ist weiterhin Normalweg. Ein Admin-Bypass ist nur nach
einer ausschließlich schutzregelbedingten Ablehnung erlaubt, wenn der aktuelle
PR-Head, sämtliche unabhängigen Checks, reguläre Review, Security-Evidence,
Zeit, Grund, Scope und aktuelle Authority gebunden sind. Bypass ersetzt keine
dieser Kontrollen. / Regular merge remains the normal path. An admin bypass is
limited to a protection-only refusal with exact current-head, gate, review,
security, time, scope, reason, and authority evidence; it replaces none of
those controls.

Konsequenz: Der zusätzliche Providerwriter erhöht die Angriffsfläche, wird
aber durch getrennte Read-/Write-Argumentarrays, festen Host, validierte IDs,
serielle Ausführung, exakten Restoreplan und kausale PreMerge-/PostMerge-
Evidence begrenzt. G4 und kontoweite Einstellungen bleiben außerhalb dieser
Entscheidung.
