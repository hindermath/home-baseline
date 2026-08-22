# Stage-B-Workflow-/Ruleset-Vertrag / Stage B Workflow and Ruleset Contract

## Zweck / Purpose

Dieser Vertrag macht die in Stage A simulierte Private-Governance-Grenze in
Stage B lieferbar. Er gilt ausschließlich für Ziele mit Profil
`private-governance-scaffold`. Öffentliche Canaries/Products behalten ihre
bestehende CI, Private Products erhalten ihre pfadabhängigen Produktgates und
Public Presets erhalten keine repositoriespezifischen Workflows.

*This contract turns the Stage A private-governance simulation into a Stage B
delivery contract. It applies only to `private-governance-scaffold` targets.*

## Workflow-Zielzustand / Workflow Desired State

Das Level-0-Template
`scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml`
wird im Ziel ausschließlich als
`.github/workflows/home-baseline-ci-minimal-gate.yml` materialisiert.

Verbindliche Semantik:

1. Einziger automatischer Trigger ist `pull_request`.
2. Pfadfilter stammen ausschließlich aus
   `scripts/config/ci-budget-path-contracts.json`.
3. Es gibt genau einen Job und genau einen Statusnamen:
   `home-baseline/ci-minimal-gate`.
4. Der Job verwendet einen Standard-Linux-Runner und nur die schlanken,
   profilgebundenen Gate-Argumentlisten.
5. Es gibt keinen automatischen Full Build auf PR oder Default Branch.
6. Externe schreibende Actions, dynamische Codeausführung und ungebundene
   Downloads sind verboten.
7. Workflowdatei und jede notwendige Änderung werden über einen nichtleeren,
   regulär geprüften PR geliefert.

Unbekannte Trigger, Expressions außerhalb der Stage-A-Teilmenge, zusätzliche
required Statusnamen oder ein ungefilterter Build blockieren vor Providerwrite.

## Ruleset-Zielzustand / Ruleset Desired State

Der GitHub-Ruleset besitzt exakt:

| Feld / Field | Wert / Value |
|---|---|
| Name | `home-baseline/private-governance-default` |
| Target | `default_branch` |
| Enforcement | `active` |
| Pull Request required | `true` |
| Required approvals | `1` reguläre Review / regular review |
| Required status checks | exakt `home-baseline/ci-minimal-gate` |
| Strict status checks | `true` |
| Bypass actors | leere Liste / empty list |
| Blocked normal write paths | `direct`, `web`, `api` |
| Admin bypass normal path | `false` |

„Blocked write paths“ ist die fachliche Normalform: Jeder Default-Branch-Write
muss aus einem bestandenen und reviewten PR stammen. Die ausdrücklich erteilte
Admin-Bypass-Authority ändert den Ruleset nicht und erzeugt keinen persistenten
Bypass Actor. Sie darf nur für einen konkreten Merge nach vollständig
bestandener unabhängiger Evidence verwendet werden.

## Liefersequenz / Delivery Sequence

1. Repository-ID, numerische Provider-ID, Default Branch, aktueller Workflow,
   bestehende Rulesets und Zugriff read-only inventarisieren.
2. Workflowdiff gegen das Stage-A-Template berechnen. Nichtleerer Diff folgt
   Branch → Commit → Push → PR → lokale/remote Gates → reguläre Review → Merge
   → Default-Sync.
3. Nach Workflow-Merge den aktuellen Rulesetzustand erneut lesen. Vorzustand
   und minimierte gewünschte Providerpayloads getrennt kanonisieren und hashen.
4. `stage-b-ruleset-plan.schema.json` validieren. Numerische Repository- und
   Ruleset-ID unmittelbar vor POST/PATCH neu prüfen.
5. Ruleset genau einmal erstellen oder minimal aktualisieren. Payload wird über
   eine restriktive temporäre JSON-Datei an `gh api --input` übergeben; keine
   Shellinterpolation und kein Prompt-Rohtext.
6. Ruleset, Default Branch, Required Status und normalen Maintainerzugriff
   read-only neu prüfen. Provideraktions-ID und normalisierten Endhash sichern.
7. Bei Abweichung höchstens den vorab hashgebundenen Restore-Request anwenden,
   Restore erneut prüfen und unabhängig vom Restore-Ergebnis vor dem nächsten
   Ziel stoppen.

## No-op-Vertrag / No-op Contract

Ein Ziel ist nur No-op-konvergent, wenn gleichzeitig:

- der neu berechnete Git-Tree dem aktuellen Tree entspricht;
- der Workflow semantisch dem Zielvertrag entspricht;
- der Ruleset die obige exakte Schutzsemantik besitzt;
- Pflichtstatus, Reviewpflicht, Default Branch und Provider-ID frisch sind;
- Redaktions- und Secret-Scan `0` verbotene Treffer liefern.

Ein leerer Git-Diff bei Rulesetdrift erzeugt keinen leeren PR. Die notwendige
Ruleset-Transaktion läuft als auditierte Provideraktion; No-op-Evidence wird
erst danach publiziert.

## Admin-Bypass-Grenze / Admin Bypass Boundary

Der reguläre Merge ist immer der erste Versuch. `gh pr merge --admin` ist nur
zulässig, wenn:

- aktuelle `MergeAndSync`- und Bypass-Authority denselben Run, dasselbe Ziel,
  denselben PR-Head und ein enges Zeitfenster bindet;
- der normale Merge ausschließlich an einer Schutzregel scheiterte;
- Acceptance-, Security-, reguläre Review- und Gate-Evidence bereits
  vollständig und am exakten Kandidaten grün ist;
- Grund, Scope, Provideraktions-ID, Ergebnis und Post-Write-Verifikation in
  `AdminBypassEvidence` erfasst werden.

Der Bypass darf niemals Review, Check, Security-Prüfung, Ruleset-Validierung,
Budget oder Default-Sync ersetzen.

## Provider- und Sicherheitsgrenzen / Provider and Security Boundaries

- GitHub-Zugriffe erfolgen `gh`-CLI-first als Executable plus Argumentliste.
- Freie URLs sind verboten. Endpunkte entstehen nur aus validierter
  numerischer Repository-/Ruleset-ID oder dem zuvor gebundenen kanonischen
  Slug; Host und Provider sind fest.
- Nur Timeout, Connection Reset, DNS, 502/503/504 und explizites Rate Limit
  sind bei Reads begrenzt transient. Mutierende Aktionen werden nach unklarem
  Ergebnis zuerst reconciled und nicht blind wiederholt.
- Token, Header, private Pfade, Personenrohdaten und Providerrohantworten
  gelangen nicht in Evidence. Diagnose wird längenbegrenzt und redigiert.
- Kein `eval`, `Invoke-Expression`, Shell-String oder unvalidiertes
  Arbeitsverzeichnis ist zulässig.

## Abnahme / Acceptance

Positive und negative Fixtures müssen mindestens abdecken:

- exakten Workflow-/Statusvertrag und Pfadfilter;
- null/mehrere Statusnamen, zusätzlicher Trigger und Full Build;
- direkte/Web/API-Schreibversuche und fehlende reguläre Review;
- falsche Repository-/Ruleset-ID, Default-Branch- und Head-Drift;
- Provider-/Billing-Ablehnung versus technisches Gateversagen;
- fehlgeschlagene Post-Write-Prüfung plus engen Restore;
- Hook-Bypass bei weiterhin wirksamer Servergrenze;
- Admin-Bypass ohne frische oder vollständige Evidence;
- No-op ohne leeren PR und Resume ohne Duplikat.

Eine grüne Simulation allein beweist keine Live-Konvergenz. Terminaler Erfolg
benötigt die read-only Provider-Endprüfung im jeweiligen Repositoryresultat.
