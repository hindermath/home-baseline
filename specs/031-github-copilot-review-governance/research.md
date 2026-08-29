# Technische Forschung: GitHub-Copilot-Review-Governance / Technical Research: GitHub Copilot Review Governance

Die Recherche verwendet ausschließlich aktuelle offizielle GitHub-
Dokumentation sowie die terminalen G3-/Stage-B-Muster dieses Repositories.
Providerdokumentation wurde am 28. August 2026 geprüft. Nicht dokumentierte
APIs werden nicht aus UI-Aufrufen oder Browsernetzwerkverkehr abgeleitet.

## 1. Repository- und Ruleset-Inventur / Repository and Ruleset Inventory

**Decision / Entscheidung**: Die vollständige Accountmenge wird über
`GET /user/repos?affiliation=owner&visibility=all&sort=full_name&direction=asc`
mit vollständiger Pagination ermittelt. Pro Repository folgen Metadaten,
`GET /repos/{owner}/{repo}/rulesets?includes_parents=false&per_page=100` und
für jede numerische ID der Detailabruf. Effektive Regeln des Default Branch
werden zusätzlich read-only geprüft. Jeder aktive Detaildatensatz wird auf die
Regelart `copilot_code_review` untersucht.

**Rationale / Begründung**: Der authentifizierte User-Endpunkt deckt öffentliche
und private besessene Repositories ab und liefert ID, Sichtbarkeit und Default
Branch. Ruleset-Listen sind nur Summaries; Details sind für Conditions,
Enforcement und Regelparameter erforderlich. `includes_parents=false` trennt
repositoryeigene Mutationsziele von geerbten Regeln.

**Alternatives considered / Erwogene Alternativen**:

- historischer Snapshot `22/6/2/16`: verworfen, weil er kein Livezustand ist;
- nur die acht Zielrepositories lesen: verworfen, weil aktive Nichtziele sonst
  unentdeckt bleiben;
- Repositoryname als Identität: verworfen; numerische Provider-ID plus Slug
  schützt gegen Rename-/Suchdrift.

Quellen: [Repositories REST API](https://docs.github.com/en/rest/repos/repos?apiVersion=2026-03-10),
[Rulesets REST API](https://docs.github.com/en/rest/repos/rules?apiVersion=2026-03-10).

## 2. Copilot-Ruleset-API / Copilot Ruleset API

**Decision / Entscheidung**: Repository-Rulesets sind die unterstützte API-
Fläche. Der Desired State verwendet `target=branch`, `enforcement=active`, die
exakte Default-Branch-Condition und genau eine `copilot_code_review`-Regel mit
`review_draft_pull_requests=false` und `review_on_push=false`. Create verwendet
`POST /repos/{owner}/{repo}/rulesets`; Update und Disable verwenden
`PUT /repos/{owner}/{repo}/rulesets/{ruleset_id}` mit vollständigem,
kanonisiertem Dateiinput.

**Rationale / Begründung**: Die offizielle REST-Dokumentation nennt diese
beiden Parameter und die Enforcementwerte `disabled`, `active`, `evaluate`.
`gh api --input` hält JSON aus Kommandozeile und Logs heraus. Update ist in der
aktuellen API ein `PUT`, nicht ein geratenes `PATCH`.

**Alternatives considered / Erwogene Alternativen**:

- GraphQL als Primärweg: verworfen, weil REST die benötigten Rulesetfelder und
  Permissions explizit dokumentiert;
- Browserbearbeitung aller Rulesets: verworfen wegen mangelnder
  Reproduzierbarkeit und Exact-ID-Automation;
- `DELETE`: normativ ausgeschlossen und aus dem G4-Adaptervokabular entfernt.

Quelle: [REST API endpoints for rules](https://docs.github.com/en/rest/repos/rules?apiVersion=2026-03-10).

## 3. Deaktivieren statt Löschen / Disable Instead of Delete

**Decision / Entscheidung**: Frisch bestätigte dedizierte aktive Nichtziel-
Rulesets werden per exakter ID mit `enforcement=disabled` erhalten. Ein
gemischtes Ruleset, das neben Copilot weitere Schutzregeln enthält, wird nicht
pauschal deaktiviert; es erzeugt `Blocked` und benötigt eine neue reviewte
Change-Menge.

**Rationale / Begründung**: GitHub dokumentiert Disabled als temporären,
reversiblen Status. Das Abschalten eines gemischten Rulesets könnte jedoch
unabhängige Branch-Security entfernen und AC-CRG-007 verletzen.

**Alternatives considered / Erwogene Alternativen**:

- Ruleset löschen und bei Rollback neu erstellen: verworfen, weil ID und
  Auditkontinuität verloren gehen;
- Copilotregel aus einem gemischten Ruleset still entfernen: verworfen, weil
  dies eine andere, nicht reviewte Mutation ist;
- jedes aktive Ruleset pauschal deaktivieren: verworfen wegen Gate-Schwächung.

Quelle: [Managing repository rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/managing-rulesets-for-a-repository).

## 4. Persönliche Accountautomatik / Personal Account Automation

**Decision / Entscheidung**: Die persönliche Einstellung „Automatic Copilot
code review“ wird als manuelle Browserfläche behandelt. Vorher-/Nachher-
Zustand, UI-Pfadklasse, Zeitpunkt, Operator und Reviewer werden redigiert
gehasht; Cookies, Browserprofile, HTML und unnötige Accountdetails bleiben
außerhalb versionierter Evidence.

**Rationale / Begründung**: GitHub beschreibt den Weg ausschließlich über
Profilbild → Copilot settings → Automatic Copilot code review. Es wurde keine
offiziell dokumentierte REST-/CLI-Fläche gefunden, die exakt diese persönliche
Einstellung liest oder schreibt. Repository-Rulesets beweisen diesen Zustand
nicht.

**Alternatives considered / Erwogene Alternativen**:

- undokumentierten Netzwerkendpunkt nachbauen: verworfen als instabil und
  nicht unterstützte Secret-/Cookiefläche;
- Browserautomation als Pflicht: verworfen, weil stabile Selektoren und
  Autorisierung nicht zugesichert sind;
- Accountzustand aus Rulesets ableiten: verworfen als falscher Proof.

Quelle: [Configuring automatic Copilot review](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-automatic-review).

## 5. Review-Aufwand `Lite` / `Lite` Review Effort

**Decision / Entscheidung**: `Lite` ist ein separater Browserzustand je der
acht Repositories unter Settings → Copilot → Code review. Er gehört nicht in
den Ruleset-API-Hash. Acht redigierte Vorher-/Nachher-Records und der bei einem
kontrollierten Review angezeigte tatsächliche Effort bilden die Evidence.

**Rationale / Begründung**: Die offizielle Ruleset-API dokumentiert nur Draft-
und Pushparameter für `copilot_code_review`. Der Effort-Level wird dagegen als
Repository-/Organization-UI-Einstellung beschrieben; Repositorywerte
überschreiben Organization Defaults. Eine nicht dokumentierte API wird nicht
erfunden.

**Alternatives considered / Erwogene Alternativen**:

- `effort_level` in den Rulesetpayload aufnehmen: verworfen als unbekanntes
  Feld;
- Lite nur aus dem Produktdefault ableiten: verworfen, weil ein Repository-
  Override möglich ist;
- Balanced akzeptieren: verworfen durch den Sollvertrag und höheren Verbrauch.

Quellen: [Configure automatic review](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-automatic-review),
[About Copilot code review](https://docs.github.com/en/copilot/concepts/agents/code-review).

## 6. Einmalige automatische Auslösung / One Automatic Trigger

**Decision / Entscheidung**: Das Ruleset setzt Draft- und Pushreview aus.
Damit wird ein direkt Ready geöffneter PR einmal reviewt; ein Draft wartet bis
zur ersten Ready-Phase; weitere Pushes lösen kein automatisches Re-Review aus.
Die Implementierung beweist dies mit deterministischen Lifecycle-Fixtures und,
nach separater Provider-Write-Autorität, einem kontrollierten Ready-/Draft-
to-Ready-/Push-Nachweis.

**Rationale / Begründung**: GitHub dokumentiert, dass ohne „Review new pushes“
nur einmal reviewt wird und dass Draftreview eine gesonderte Option ist. Der
Provider-Lifecycle-Test bleibt nötig, weil Settings allein kein tatsächliches
Reviewereignis beweisen.

**Alternatives considered / Erwogene Alternativen**:

- Push-Re-Reviews aktivieren: verworfen wegen Kosten- und Scopegrenze;
- Draftreview aktivieren: verworfen durch CRG-008;
- nur einen Mock als terminale Providerabnahme verwenden: verworfen; Mock ist
  Red/Green-Entwicklungsproof, nicht Livekonvergenz.

Quelle: [Configuring automatic review, repository ruleset options](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-automatic-review).

## 7. Manuelle Review-Verfügbarkeit / Manual Review Availability

**Decision / Entscheidung**: Die Automatikänderung berührt keine manuelle
Reviewerfunktion. Verfügbarkeit wird vor/nach in Ziel- und Nichtzielproben im
Reviewer-UI belegt. Ein tatsächlich manuell ausgelöstes Review ist eine
getrennte, kostenwirksame Provideroperation und benötigt einen eigenen Gate;
REST verwendet dann den dokumentierten Reviewer
`copilot-pull-request-reviewer[bot]`.

**Rationale / Begründung**: GitHub beschreibt manuelle Reviews als Default und
unterstützt eine REST-Revieweranforderung. Eine reine UI-Verfügbarkeitsprüfung
verbraucht keine Reviewressource; eine tatsächliche Anforderung darf nicht
stillschweigend aus `MergeAndSync` folgen.

**Alternatives considered / Erwogene Alternativen**:

- manuelle Fähigkeit durch ein Review in jedem Repository testen: verworfen
  wegen unnötiger Kosten und Providerwrites;
- Rulesetkonvergenz als manuellen Proof werten: verworfen, da getrennte Fläche.

Quelle: [Using GitHub Copilot code review](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/request-a-code-review/use-code-review).

## 8. AI Credits und Actions-Minuten / AI Credits and Actions Minutes

**Decision / Entscheidung**: AI Credits werden, soweit der aktuelle Vertrag
direkt vom persönlichen Account bezahlt wird, über
`GET /users/{username}/settings/billing/ai_credit/usage` mit `Plan:read`
erfasst. Actions-Minuten werden aus dem User-Billing-Usage-Report separat auf
`workflow_path=dynamic/agents/copilot-pull-request-reviewer` gefiltert.
Accounttyp, Messzeitraum, Quelle, Einheit und Frische werden je Kategorie
gespeichert; nicht passende Billingzuordnung bleibt `Unknown`.

**Rationale / Begründung**: GitHub dokumentiert zwei Kostenkomponenten:
Modellinteraktion als AI Credits und agentische Infrastruktur als Actions-
Minuten. User-Endpunkte gelten nur für persönlich bezahlte Pläne; bei
Organization-/Enterprise-Billing sind deren Endpunkte erforderlich. Das
Feature darf die aktuelle Billingzuordnung nicht raten.

**Alternatives considered / Erwogene Alternativen**:

- beide Kategorien addieren: verworfen wegen verschiedener Einheiten/
  Kostenträger;
- fehlende Werte als null: verworfen als künstlich grüner Bericht;
- Fixpreis pro Review: verworfen, weil das Reviewmodell nicht vorab
  offengelegt wird und Verbrauch mit PR-Größe variiert.

Quellen: [Billing usage REST API](https://docs.github.com/en/rest/billing/usage?apiVersion=2026-03-10),
[Models and pricing for Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing),
[GitHub Actions billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions).

## 9. Automatische und manuelle Trigger / Automatic and Manual Triggers

**Decision / Entscheidung**: Triggerzahlen sind eine dritte Evidenceachse.
Kontrollierte Testevents tragen `Automatic` oder `Manual` aus dem gebundenen
Auslöser; fremde Providerereignisse werden nur klassifiziert, wenn ein
eindeutiger Actor-/Request-/Rulesetbezug vorhanden ist, sonst `Unknown`.
`Unknown` wird berichtet und verhindert eine vollständige Attributionsaussage.

**Rationale / Begründung**: GitHub ordnet AI Credits bei Automatik dem PR-Autor
und bei manueller Anforderung dem anfordernden User zu. Billingmengen allein
beweisen deshalb weder Triggerart noch Reviewanzahl.

**Alternatives considered / Erwogene Alternativen**:

- Reviews aus Creditmenge schätzen: verworfen als Scheingenauigkeit;
- jeden Botreview als automatisch werten: verworfen, weil manuelle Anforderung
  denselben Reviewer nutzt;
- unbekannte Trigger verwerfen: verworfen, weil Vollständigkeit vorgetäuscht
  würde.

Quelle: [About Copilot code review – usage](https://docs.github.com/en/copilot/concepts/agents/code-review).

## 10. Exakte Mutation, Idempotenz und Rollback / Exact Mutation, Idempotency, and Rollback

**Decision / Entscheidung**: Jede Aktion bindet Run-ID, Operationsklasse,
Repository-ID, optional Ruleset-ID, Snapshot-/Plan-/Before-/Desired-/Rollback-
Hash und eine stabile Idempotenz-ID. `RulesetCreate`, `RulesetUpdate` und
`RulesetDisable` sind getrennte Klassen mit eigener aktueller Autorität;
`POST` gehört nur zu Create, `PUT` mit exakter ID nur zu Update oder Disable.
Mutationen sind serialisiert. Nach einem Timeout folgt GET-Reconciliation.
Rollback ist eine neue gated exact-ID-Transaktion, bewahrt die
Quelloperationsklasse und läuft nur, wenn der aktuelle Hash noch dem
fehlgeschlagenen Resultat entspricht.

**Rationale / Begründung**: Die Stage-B-Muster für kanonische JSON-Hashes,
sichere Argumentarrays, atomare Evidence, Providerfehlerklassen, externe
Write-Gates und Read-before-Retry sind bereits getestet. G4 erweitert sie um
Browserflächen und Create/Disable ohne eine zweite Engine einzuführen.

**Alternatives considered / Erwogene Alternativen**:

- blindes Retry von POST/PUT: verworfen wegen Duplikat/Überschreiben;
- globaler Rollback aller Ziele: verworfen, weil neuere legitime Änderungen
  überschrieben werden könnten;
- Zeitstempel im Entscheidungshash: verworfen; Zeit bleibt Frischemetadatum.

Lokale Quellen: `scripts/lib/agentic_workspace_fleet.py`,
`scripts/tests/test_stage_b_rollout.py`,
`specs/030-stage-b-rollout/contracts/workflow-ruleset-contract.md`.

## 11. Test- und Plattformstrategie / Test and Platform Strategy

**Decision / Entscheidung**: MacOS-first Red/Green-Slice mit Fake Provider,
danach vollständige Fixturematrix und read-only Liveslice. Ein eng begrenzter
GitHub-Actions-Workflow führt denselben Payload nativ unter Linux und Windows
aus. Er besitzt `contents: read`, keine Secrets, keine Providerwrites und
liefert hashgebundene Plattformrecords; vollständige Regression/Security/A11Y
bleibt ein eigenes Gate.

**Rationale / Begründung**: Dies entspricht Constitution 1.21.0 und den
terminal bewährten Stage-B-Proofs. Fake Provider macht Negativfälle und
Nullwrite-Zähler deterministisch; native Runner belegen Shell-/Runtime-
Semantik.

**Alternatives considered / Erwogene Alternativen**:

- nur portable Fixtures auf macOS: verworfen als unvollständiger
  Plattformproof;
- breit berechtigter CI-Workflow: verworfen wegen unnötiger Angriffsfläche;
- Windowssemantik aus PowerShell auf macOS ableiten: verworfen als nicht nativ.

## 12. Lieferung, Bypass und Position 7 / Delivery, Bypass, and Position 7

**Decision / Entscheidung**: Repositorylieferung folgt dem bestehenden
Stage-B-Muster: exakter Delivery Set, Branch/Commit/PR, konkrete Gates,
Exact-Head-Review, regulärer Mergeversuch, bounded admin bypass ausschließlich
nach `ProtectionOnlyRefusal`, Default-Sync und kausale PostMerge-Evidence.
Provider-Settings-Writes bleiben separate External-Write-Gates. Position 7,
Subscription, Budgetkauf und Cancellation sind Nullmutationen.

**Rationale / Begründung**: `MergeAndSync` und Bypass gelten für den
Git-Lieferpfad; sie sind weder Provider-Admin- noch Secret-Autorität. Das
aktive Serienmanifest bindet G4 als `Primary/Eligible` und Position 7 als
blockierten Nachfolger.

**Alternatives considered / Erwogene Alternativen**:

- Bypass als normaler Mergeweg: verworfen;
- Providerwrites aus Deliverymodus ableiten: verworfen;
- Position 7 im Closeout starten oder vorbereiten: verworfen als Scopebruch.

## 13. Terminalbewusste Parent-Adoption / Terminal-Aware Parent Adoption

**Decision / Entscheidung**: Der installierte modellgeroutete Parent bleibt für
normale Phasen alleiniger State-Writer. Nach Child-Exit `0` und erfolgreicher
Validierung der exakten strukturierten Ergebnisdatei liest er den
feature-lokalen State erneut von Disk. Nur für `implement-closeout` darf er
einen vom Child bereits publizierten terminalen Snapshot übernehmen, wenn
Identität, Schema, Delivery-Modus, `Completed/168/168`, alle Closeoutfelder,
Tasksdatei/-hash/-zählung, Resultpfad/-hash/Payload, vollständige
Routingmetadaten sowie die einparentige
`Active/NeedsRevalidation/167/168` → `Completed/168/168`-Commit- und
lokale/remote Default-Ref-Beziehung exakt stimmen. Dann
antwortet der Parent aus dem reloaded State und führt nach Child-Rückkehr
keinen Featurepfad-Writer aus. Maschinenlokale Log-/Resultmaterialisierung ist
nur `runnerLocal`-Evidence und keine Zustandsquelle.

Bei jeder anderen Child-State-Änderung, einschließlich `Active`,
`NeedsRevalidation`, falscher Identität, Resultpfad-/Hashdrift oder ungewisser
Gitbeziehung, bewahrt der Parent die Diskbytes und endet deterministisch mit
read-only Reconciliation. Derselbe Driftcheck gilt im Catch-Pfad. Hat der Child
den State nicht geändert, bleiben heutige atomare Parent-Success- und
Definite-Failure-Writes unverändert.

**Rationale / Begründung**: T168 macht die Publikation des exakten
Terminal-Commits bewusst zur letzten erforderlichen Mutation. Ein späterer
Parent-Write kann deshalb weder Resultathash noch Routingstatus „nachtragen“,
ohne einen undeliverten Diff zu erzeugen. Das Child kann dagegen Resultat und
hashgebundenen terminalen State vor seinem Commit vollständig vorbereiten.
Reload, strikte Adoption und Writerverzicht bewahren damit gleichzeitig die
feature-lokale Single Source of Truth, die bestehende nichtterminale
Parent-Ownership und die exakt letzte Remote-Fast-forward-Mutation. Native
PowerShell/.NET-Pfad-, JSON-, SHA-256- und Git-Prüfung vermeidet eine neue
Python-Produktabhängigkeit; die vorhandene Python-gestützte Validatorfläche
bleibt Test-/Validierungshilfe.

**Security-, Path- und TOCTOU-Bindung**: State, Tasks, Resultat und Payload
werden kanonisch unter Repository, Featurepfad beziehungsweise gebundenem
OutputDirectory aufgelöst; absolute Pfade, `..`, Symlinks/Reparse Points und
Escape blockieren. Git wird nur mit direkten Argumentarrays read-only
aufgerufen. Parent-Identitäten sind closed-world, Hashes lowercase SHA-256.
State-/Tasks-/Payloadbytes und lokale/remote Refs werden vor der Antwort
erneut geprüft; Drift führt ohne Writer zur Reconciliation. Fixturetests nutzen
ein temporäres lokales Repository und Bare-Remote und benötigen weder Netzwerk
noch Providerauthority.

**Alternatives considered / Erwogene Alternativen**:

- Runtimejournal oder separates Completion-Statefile als kanonische Quelle:
  verworfen, weil Status/Resume dann widersprüchliche Quellen hätten;
- stets den stale Parent-State schreiben und später committen: verworfen, weil
  dies T168s letzte Mutation und den identischen lokalen/remote Default bricht;
- jeder Child-State-Änderung blind vertrauen: verworfen, weil Active-,
  NeedsRevalidation-, Identitäts- und Resultdrift sonst Completion vortäuschen;
- Parent schreibt nach erfolgreichem Terminal-Push nur Resultathash nach:
  verworfen, weil auch ein „kleiner“ Write ein undelivertes Post-Terminal-Delta
  ist;
- neuer separater Terminalrunner oder ein Python-Adoptionskern: verworfen als
  zweite Orchestrierungsfläche beziehungsweise unnötige Produktabhängigkeit;
- Fehlerpfad schreibt immer `Blocked`: verworfen, weil er bei Child-Drift den
  einzig aktuellen Disk-Snapshot aus stale Memory zerstören würde.

Lokale Entscheidungsquellen:
`.specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1`,
dessen Bash-Wrapper, Phase-/State-Validatoren,
`tests/fixture-model-runner.ps1`, `tests/test-model-routing.ps1`,
`templates/autonomous-runbook-template.md`,
`templates/autonomous-run-evidence-template.md`, die installierten
Autonomous-/Status-/Resume-Skills sowie T165–T168 und `TA-007`.
