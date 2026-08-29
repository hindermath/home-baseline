# Provider-Workflowvertrag / Provider Workflow Contract

Dieser Vertrag ist der lesbare Begleiter der JSON-Schemas. Er definiert die
unterstuetzten GitHub-API-Pfade, die ausdruecklich manuellen Browserpfade und
die Autoritaetsgrenzen. Er erteilt selbst keine Schreibberechtigung.

*This contract is the readable companion to the JSON schemas. It defines the
supported GitHub API paths, explicit manual browser paths, and authority
boundaries. It does not grant write authority.*

## 1. Trust Boundaries und Rollen / Trust Boundaries and Roles

| Grenze / Boundary | Eingabe / Input | Ausgabe / Output | Regel / Rule |
|---|---|---|---|
| GitHub REST | untrusted JSON, Status, Header, Pagination | validierte kanonische Records | `gh` zuerst; feste Host-/Endpointtemplates; direkte Argumentarrays; keine Shellstrings. |
| GitHub Browser UI | untrusted sichtbarer Zustand | redigierter manueller Attestation-Record | Keine undokumentierte API, Cookies, HTML-Archive oder Browserprofile. |
| Billing/Usage | personenbezogene Nutzungsdaten | minimale Kategorie-/Einheiten-Evidence | `Plan:read`, least privilege, keine Secrets oder Fixpreisbehauptung. |
| Lokaler Planer | Sollvertrag plus frischer Snapshot | deterministischer Plan | Pure Decision Core; keine Providerwrites. |
| External Write Gate | frische explizite Autoritaet | einmalige Operation | Exakte IDs/Hashes/Zeit/Scope/Rollback; deny by default. |
| Evidence Publisher | redigierte validierte Records | atomische Evidence | Root-/Symlink-/Rechtepruefung; Secret Scan vor Veroeffentlichung. |

Owner, Operator, Reviewer, Security Reviewer und Delivery Reviewer bleiben
getrennte Rollen. Eine Person kann mehrere Rollen innehaben, aber jeder Record
benennt die ausgeuebte Rolle und die reviewte Evidence.

## 2. Read-only API-Workflow

Die Implementierung erzeugt Argumentarrays, nie einen zusammengesetzten
Shellbefehl. Das folgende Arraymuster ist normativ; Parameterwerte werden
closed-world validiert:

```text
["gh", "api", "--method", "GET", "--hostname", "github.com",
 "-H", "Accept: application/vnd.github+json",
 "-H", "X-GitHub-Api-Version: 2026-03-10", ENDPOINT,
 "--paginate", "--slurp"]
```

Reihenfolge:

1. `GET /user/repos?affiliation=owner&visibility=all&sort=full_name&direction=asc&per_page=100` vollstaendig paginieren.
2. Jedes Repositorydetail gegen ID, Slug, Owner, Sichtbarkeit und Default Branch validieren.
3. `GET /repos/{owner}/{repo}/rulesets?includes_parents=false&per_page=100` vollstaendig paginieren.
4. Jede gelistete Ruleset-ID ueber `GET /repos/{owner}/{repo}/rulesets/{ruleset_id}` laden.
5. Effektive Default-Branch-Regeln read-only pruefen; geerbte/organisationsweite Quellen separat berichten.
6. Billing Owner bestimmen. Nur bei persoenlicher Abrechnung die User-Endpunkte
   `/users/{username}/settings/billing/ai_credit/usage` und
   `/users/{username}/settings/billing/usage` verwenden; sonst passenden
   Organization-/Enterprisepfad fordern oder `Unknown` berichten.
7. Actions-Usage nur fuer
   `workflow_path=dynamic/agents/copilot-pull-request-reviewer` klassifizieren.

Alle Seiten, Detailzahlen, Antwortklassen, API-Version und Frische werden
gespeichert. Rate Limit, 401/403/404, unvollstaendige Pagination, unbekannte
Felder mit Sicherheitswirkung oder Schemafehler blockieren; maximal drei
begrenzte Retries sind nur fuer eindeutig transiente GETs zulaessig.

## 3. Browser-only Workflow

Zwei Providerflaechen besitzen nach offizieller Dokumentation keinen
unterstuetzten API-Vertrag fuer G4:

1. **Persoenliche Accountautomatik**: Profile → Copilot settings → Automatic
   Copilot code review. Desired State: `Disabled`.
2. **Repository-Effort**: Repository → Settings → Copilot → Code review.
   Desired State: `Lite` fuer jede der acht exakten Repository-IDs.

Preview ist eine reine Sichtpruefung. Apply benoetigt pro Operationsklasse ein
frisches External-Write-Gate. Der Operator notiert Before/After, semantische
UI-Pfadklasse, UTC-Zeit und Rolle. Fuer die persoenliche Accountautomatik wird
exakt `accountOwner=hindermath` notiert; Repository-ID ist dort verboten. Fuer
Repository-Effort wird stattdessen die exakte Repository-ID notiert. Ein
Reviewer bestaetigt den redigierten Record. Browserautomation und Reverse
Engineering sind nicht erforderlich. UI-Abweichung oder nicht eindeutiger
Account blockiert.

Die manuelle Reviewer-Verfuegbarkeit wird read-only vor/nach belegt. Ein real
ausgeloestes manuelles Review ist eine eigene Operation; es wird nicht aus
Account-, Ruleset- oder Deliveryautoritaet abgeleitet.

## 4. Deterministischer Preview

Preview validiert Sollvertrag, komplette Inventur und Browser-Evidence,
erzeugt `NoOp`, `Update`, `Create`, `Disable` oder `Blocked`, sortiert stabil
und schreibt exakt nullmal zum Provider. Historische Zaehler beeinflussen
keine Entscheidung. Das Preview-JSON enthaelt:

- unveraenderliche Target Selector ausschließlich aus Position, Slug und
  Default Branch sowie ein getrenntes closed-world `desiredSettings`-Objekt
  fuer die gemeinsamen Account-, Ruleset-, Trigger- und Effort-Sollparameter;
- separat frisch inventarisierte Live-Identitaet aus Repository-ID, Slug,
  Sichtbarkeit und Default Branch; Selector/Live-Vergleich vor jedem Write;
- exakte Repository-/Ruleset-IDs und die getrennten Operationsklassen
  `RulesetCreate`, `RulesetUpdate` und `RulesetDisable`;
- fuer die Accountaktion exakt `accountOwner=hindermath`; derselbe Wert muss
  spaeter in Gate, Mutation Result und Account-Rollback stehen;
- Before-/Desired-/Rollbackhash je Aktion;
- feste Methoden (`POST`, `PUT`, `BrowserManual`, `None`);
- kanonische Payloadpfade statt sensitiver Inline-Nutzlast;
- `planSha256`, Frischegrenze und rote Blockierungsgruende.

Ein gemischtes Schutz-/Copilot-Ruleset, eine doppelte ID oder ein unbekannter
Browserzustand ist `Blocked`. `Delete` ist weder Schema- noch Adapterwert.

## 5. Apply-Vertrag

Apply ist ohne passendes `Authorized` External-Write-Gate unmoeglich. Direkt
vor jeder Aktion werden Provider-ID, Sichtbarkeit, Slug, Default Branch und
Before-Hash erneut gelesen. Ein Gate bindet genau eine Rulesetklasse; weder
Methode noch Autoritaet werden zwischen `RulesetCreate`, `RulesetUpdate` und
`RulesetDisable` geteilt.

Fuer `AccountSetting` validiert der Gate-Check vor Apply exakt
`accountOwner=hindermath`, den aktuellen ausdruecklichen `authorityRecordId`
samt `authoritySha256`, genau `BrowserManual`, genau
`PersonalCopilotSettings:write` sowie leere `repositoryIds`, `rulesetIds` und
`pullRequestIds`. Fehlender oder abweichender Account, ein Account, der nur aus
Credentials abgeleitet wurde, oder eine Ableitung aus `MergeAndSync` bzw.
Admin-Bypass blockiert. Nicht accountbezogene Klassen duerfen `accountOwner`
nicht enthalten.

```text
Create: ["gh", "api", "--method", "POST", ENDPOINT, "--input", PAYLOAD_FILE]
Update: ["gh", "api", "--method", "PUT",  EXACT_ID_ENDPOINT, "--input", PAYLOAD_FILE]
Disable:["gh", "api", "--method", "PUT",  EXACT_ID_ENDPOINT, "--input", PAYLOAD_FILE]
```

`PAYLOAD_FILE` ist Owner-only, schema-validiert und wird nach Nutzung sicher
entfernt. Write-Retries sind verboten. Nach Timeout oder Verbindungsabbruch
folgt ein GET auf die exakte Identitaet; nur eindeutige Reconciliation setzt
fort. Jede Operation wird serialisiert und danach frisch validiert.

`RulesetCreate` uebernimmt die neue ID nur, wenn validierte `201`-Antwort und
frische Nachinventur dieselbe Repository-/Ruleset-ID liefern; Mutation Result,
After-State und Rollback binden diese ID samt Ergebnis- und Inventurhash.
`RulesetUpdate` und `RulesetDisable` verlangen in Plan, Gate, Resultat,
Nachinventur und Rollback dieselben exakten Repository-/Ruleset-IDs und
erhalten unbekannte
Rulesetfelder und unabhaengige Schutzregeln. Account-/Effort-Aenderungen folgen
der manuellen Checkliste und haben eigene Gates. Fuer `AccountSetting` muessen
Mutationsplan, Gate, Resultat und Rollback bytegenau dieselbe normalisierte
Accountidentitaet `hindermath` verwenden; Mismatch ist ein Hard Stop.

Alle neun External-Write-Gate-Klassen sind closed-world an Methode,
Identitätsfelder und Minimum-Scope gebunden. `Delivery` akzeptiert nur
`GitPush` und `GitHubMerge` mit Repository-/PR-Identität und niemals Provider-
`POST`, Provider-`PUT`, Ruleset-ID oder Settings-Scope. Ein Admin-Bypass
erweitert diese Grenze nicht. `Rollback` bindet seine Quelloperationsklasse
und darf deren ID-/Scopegrenze nicht umgehen.

## 6. Rollback und Idempotenz / Rollback and Idempotency

Rollback ist keine automatische Kompensation. Er benoetigt eine neue
`Rollback`-Autoritaet und darf nur den exakten vorher gebundenen Zustand
wiederherstellen, wenn der aktuelle Hash noch `failedAfterSha256` entspricht.
Ein Rollback aus `AccountSetting` bindet erneut `accountOwner=hindermath`,
`BrowserManual`, `PersonalCopilotSettings:write`, den aktuellen ausdruecklichen
Rollback-Authority-Record und leere Repository-/Ruleset-/PR-ID-Arrays. Andere
Rollbackquellen duerfen keine Accountidentitaet tragen.
Jeder Rollbackrecord bindet die `sourceOperationClass`; Create-, Update- und
Disable-Ursprung bleiben getrennt auditierbar. Die Klasse `Rollback` erteilt
keine neue Autoritaet fuer eine andere Quelloperation. Bei Drift stoppt er.
Create-Rollback loescht nicht; er deaktiviert die neu erzeugte exakte ID,
sofern dies vorab gebunden und weiterhin sicher ist.

Nach Konvergenz wird dieselbe Inventur-/Plan-/Validate-Kette erneut ausgefuehrt.
Terminale Idempotenz bedeutet `driftCount=0` und `writes=0`, nicht lediglich
einen erfolgreichen Exitcode.

## 7. Review- und Usage-Proof

- Ein Ready geoeffneter PR oder der erste Draft-to-Ready-Uebergang erzeugt
  hoechstens ein automatisches Lite-Review.
- Draft und spaetere Pushes erzeugen kein automatisches Review.
- Manuelle Reviewanforderung bleibt moeglich und getrennt autorisiert.
- Copilot ist advisory; Human Review, Acceptance, Security und technische
  Gates bleiben eigenstaendig.
- AI Credits, Copilot-Actions-Minuten und automatische/manuelle/unbekannte
  Trigger werden getrennt berichtet. Fehlende Zuordnung ist `Unknown`.

Controlled PR lifecycle und manuelle Trigger sind Providerwrites mit eigenen
IDs, Zeitfenstern und Rollback-/Cleanupplan. Fixtures allein reichen fuer
Implementierungs-Red/Green, nicht fuer terminale Livekonvergenz.

## 8. Delivery und Bypass

Repositorydelivery folgt Branch → Commit → Push → PR → Gate-Mengengleichheit →
Exact-Head Human/Copilot Review → regulaerer Mergeversuch → Default-Sync. Der
begrenzte Admin-Bypass ist nur nach einem belegten `ProtectionOnlyRefusal`
zulaessig, bleibt exakte PR-/Head-/Zeit-Autoritaet und ersetzt keine Acceptance,
Security-, Review- oder Gate-Evidence. Position 7, Subscription/Budget und Home
werden nicht veraendert. Home-Sync ist nur bei manifestgebundenem
`homeRuntime`, nach Preview und nach gemergter Source zulaessig.

## 9. Exitcodes

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | Preview/Validate/Apply/Rollback vollstaendig und verifiziert. |
| `1` | Validierungs-, Test- oder Providerfehler; kein terminaler Erfolg. |
| `2` | Eingabe-, Schema-, Pfad- oder Aufruffehler. |
| `3` | Autoritaet fehlt/ist abgelaufen oder Drift/Unsicherheit blockiert sicher. |
| `130` | Kooperativer Stop; Zustand/Evidence bleibt resumierbar. |
