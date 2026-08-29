# Feature-Spezifikation: Flottenweite GitHub-Copilot-Review-Governance und Kostenbegrenzung / Feature Specification: Fleet-Wide GitHub Copilot Review Governance and Cost Control

**Feature Branch / Feature-Branch**: `031-github-copilot-review-governance`
**Created / Erstellt**: 2026-08-28
**Status**: Spezifiziert / Specified
**Binding Input / Bindende Eingabe**: `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.md`, Review `d76c8231-c875-41ee-9dfc-65afe756f626` (`Ready`)
**Audience / Zielgruppe**: Maintainer, Flotten-Operator*innen und Reviewer / maintainers, fleet operators, and reviewers

## Nutzungsszenarien und Tests / User Scenarios & Testing *(mandatory)*

### User Story 1 - Livezustand vor Änderungen sicher erfassen / Capture Live State Safely Before Changes (Priority: P1)

Als Maintainer möchte ich vor jeder Änderung den aktuellen Zustand der
accountweiten Automatik, des Abrechnungsmodells, der Default-Branches und aller
aktiven Copilot-Code-Review-Rulesets sehen, damit ein historischer Planungsstand
nicht als aktuelle Providerwahrheit verwendet wird.

*As a maintainer, I want the current account-wide automation, billing model,
default branches, and all active Copilot code-review rulesets captured before
each change, so a historical planning snapshot is never treated as current
provider truth.*

**Why this priority / Warum diese Priorität**: Jede spätere Mutation hängt von
korrekten IDs, vollständiger Zielmenge und aktuellen Berechtigungsgrenzen ab.
Der Intake-Stand `22/6/2/16` ist nur ein datierter Planungssnapshot.

*Every later mutation depends on correct IDs, complete scope, and current
authority boundaries. The intake counts `22/6/2/16` are only a dated planning
snapshot.*

**Independent Test / Unabhängiger Test**: Eine read-only Inventur erzeugt einen
redigierten, hashgebundenen Bericht mit Accountzustand, Abrechnungsanzeige,
Repository, Default-Branch, Ruleset-ID und Status. Kein Write wird ausgeführt.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** der historische Snapshot ist vorhanden, **When / Wenn** der Preflight startet, **Then / Dann** werden alle Zählwerte aus aktuellen Quellen neu berechnet und der Snapshot wird nur als Vergleich ausgewiesen.
2. **Given / Angenommen** eine ID, ein Branch, eine Sichtbarkeit oder eine Provideroberfläche weicht ab, **When / Wenn** der Sollplan gebildet werden soll, **Then / Dann** stoppt der Lauf fail-closed vor der ersten Mutation und nennt den exakten Blocker und die nächste sichere Aktion.
3. **Given / Angenommen** die persönliche accountweite Einstellung ist nur über eine Browseroberfläche beweisbar, **When / Wenn** API- oder CLI-Evidence vorliegt, **Then / Dann** gilt diese nicht als Ersatz für den notwendigen redigierten Browsernachweis.

---

### User Story 2 - Exakte Acht-Repository-Governance reversibel herstellen / Establish the Exact Eight-Repository Governance Reversibly (Priority: P1)

Als Flotten-Operator*in möchte ich genau die acht benannten Repositories auf
einen einheitlichen automatischen Reviewvertrag bringen und alle übrigen
aktuellen Automatiken reversibel deaktivieren, damit automatische Reviews
gezielt statt flottenweit Kosten erzeugen.

*As a fleet operator, I want exactly the eight named repositories to use one
automatic-review contract while all other current automations are disabled
reversibly, so automatic reviews create cost only in the selected fleet.*

**Why this priority / Warum diese Priorität**: Die feste Zielmenge ist der
fachliche Kern; jede Abweichung verändert Kosten, Reviewverhalten oder
Rollback-Fähigkeit.

**Independent Test / Unabhängiger Test**: Preview, Apply, Ergebnisinventur und
Rollback werden gegen exakte Account-, Repository- und Ruleset-IDs geprüft.
Ein zweiter Check meldet null Drift.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** der frische Preflight bestätigt die erwartete Ausgangslage, **When / Wenn** der autorisierte Apply abgeschlossen ist, **Then / Dann** sind genau die acht festgelegten Repository-/Branch-Ziele aktiv und die accountweite Automatik ist aus.
2. **Given / Angenommen** weitere aktuell aktive Rulesets liegen außerhalb der Acht, **When / Wenn** der Zielzustand hergestellt wird, **Then / Dann** werden sie deaktiviert, nicht gelöscht, und bleiben über ihre exakten IDs rückrollbar.
3. **Given / Angenommen** der Livezustand bestätigt die authoring-zeitlichen sechs bestehenden und zwei fehlenden Zielrulesets nicht, **When / Wenn** die Differenz erkannt wird, **Then / Dann** wird nicht still umklassifiziert oder mutiert; eine neue reviewte Change-Menge ist erforderlich.
4. **Given / Angenommen** eine Teilmutation oder Unterbrechung tritt ein, **When / Wenn** Resume oder Rollback angefordert wird, **Then / Dann** werden Authority, IDs, Vorzustand und Drift neu geprüft und keine Aktion dupliziert.

---

### User Story 3 - Genau ein Lite-Review mit manueller Wahlfreiheit / Keep One Lite Review and Manual Choice (Priority: P1)

Als Reviewer möchte ich pro qualifizierendem Pull Request höchstens ein
automatisches Lite-Review erhalten, keine Draft- oder Push-Re-Reviews, Copilot
aber überall manuell anfordern können, damit Reviewnutzen und Kosten
vorhersehbar bleiben.

*As a reviewer, I want at most one automatic Lite review per qualifying pull
request, no draft or push re-reviews, while Copilot remains manually
requestable everywhere, so review value and cost remain predictable.*

**Why this priority / Warum diese Priorität**: Die Auslösebedingungen sind die
direkte Kosten- und Qualitätsgrenze des Features.

**Independent Test / Unabhängiger Test**: Ein Open-PR, ein Draft-to-Ready-
Übergang und ein späterer Push werden getrennt beobachtet; manuelle
Reviewer-Anforderung und bestehende menschliche/technische Gates werden
zusätzlich geprüft.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** ein Pull Request wird direkt als Ready geöffnet, **When / Wenn** der automatische Vertrag greift, **Then / Dann** entsteht höchstens ein automatisches Lite-Review.
2. **Given / Angenommen** ein Pull Request wird als Draft geöffnet, **When / Wenn** er erstmals Ready wird, **Then / Dann** entsteht höchstens ein automatisches Lite-Review und während des Drafts keines.
3. **Given / Angenommen** ein bereits automatisch reviewter Pull Request erhält einen Push, **When / Wenn** keine manuelle Anforderung erfolgt, **Then / Dann** entsteht kein Re-Review.
4. **Given / Angenommen** ein Repository liegt innerhalb oder außerhalb der Acht, **When / Wenn** ein berechtigter Mensch Copilot bewusst als Reviewer anfordert, **Then / Dann** bleibt diese manuelle Möglichkeit verfügbar.
5. **Given / Angenommen** Copilot gibt Hinweise, **When / Wenn** eine Mergeentscheidung getroffen wird, **Then / Dann** bleiben menschliche Bewertung sowie technische CI- und Sicherheitsgates unabhängig erforderlich; Copilot ist niemals alleiniger Required Reviewer.

---

### User Story 4 - Kosten und Datenschutz getrennt belegen / Prove Cost and Privacy Separately (Priority: P2)

Als Maintainer möchte ich automatische und manuelle Reviewauslösungen, echte
AI-Credits und Copilot-Code-Review-Actions-Minuten getrennt sehen, ohne Secrets
oder vollständige Abrechnungsbelege offenzulegen, damit Kostenentscheidungen
nachvollziehbar und datensparsam bleiben.

*As a maintainer, I want automatic and manual review triggers, actual AI
credits, and Copilot code-review Actions minutes reported separately without
exposing secrets or full billing records, so cost decisions remain traceable
and privacy-preserving.*

**Why this priority / Warum diese Priorität**: AI-Credits und Actions-Minuten
sind verschiedene Kostenachsen; ein fester Preis pro Review wäre wegen des
nicht vorab offengelegten Modells Scheingenauigkeit.

**Independent Test / Unabhängiger Test**: Ein redigierter Nutzungsbericht weist
beide Kostenachsen, Messzeitraum, Quellenfrische und Reviewanzahl in getrennten
Feldern aus und besteht Secret-/Personendatenprüfung.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** Provider-Nutzungsdaten sind verfügbar, **When / Wenn** der Bericht erzeugt wird, **Then / Dann** werden AI-Credits und Actions-Minuten getrennt mit Quelle und Messzeitraum ausgegeben.
2. **Given / Angenommen** das automatisch verwendete Modell ist nicht vorab offengelegt, **When / Wenn** Kosten erklärt werden, **Then / Dann** wird kein fester Preis pro Review behauptet.
3. **Given / Angenommen** Rohdaten enthalten Token, Cookies, persönliche Details oder vollständige Belege, **When / Wenn** Evidence veröffentlicht wird, **Then / Dann** werden diese Inhalte ausgeschlossen oder redigiert.

---

### User Story 5 - Plattformgleich und barrierearm betreiben / Operate with Platform Parity and Accessibility (Priority: P2)

Als Flotten-Operator*in oder Reviewer möchte ich Preview, Ergebnis, Fehler,
Rollback und nächste Aktion auf macOS, Linux und Windows in linearer,
textorientierter Form verstehen, damit die Governance ohne Farbe, Diagramm
oder spezielle Assistenzbarriere bedienbar bleibt.

*As a fleet operator or reviewer, I want preview, result, errors, rollback, and
next action to remain understandable in linear text on macOS, Linux, and
Windows, so governance is usable without colour, diagrams, or assistive
barriers.*

**Independent Test / Unabhängiger Test**: Native oder eng gebundene
Plattformnachweise vergleichen normalisierte Entscheidungen, Exitcodes und
Nullschreibwerte. Screenreader-/Textbrowser-orientierte Prüfung bestätigt die
lineare Reihenfolge.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** dieselben Eingaben und derselbe Snapshot, **When / Wenn** Bash und PowerShell im Previewmodus laufen, **Then / Dann** liefern beide dieselbe fachliche Entscheidung und null Mutationen.
2. **Given / Angenommen** ein Fehler oder Driftblocker, **When / Wenn** die CLI meldet, **Then / Dann** nennt jede Zeile Repository, Default-Branch, Zustand, geplante Aktion, Ergebnis und nächste sichere Aktion ohne farbabhängige Bedeutung.
3. **Given / Angenommen** Accountautomation nur im Browser geprüft werden kann, **When / Wenn** Plattformparität bewertet wird, **Then / Dann** wird dieser manuelle Provider-UI-Nachweis getrennt von Script- und API-Parität ausgewiesen.

### Randfälle / Edge Cases

- Der aktuelle Ruleset-Bestand stimmt nicht mit `22/6/2/16` überein: Hard Stop vor Mutation, neue exakte Mengen- und Authority-Prüfung.
- Ein Zielrepository wurde umbenannt, archiviert, übertragen, in der Sichtbarkeit geändert oder besitzt einen anderen Default-Branch: Hard Stop für das betroffene und alle noch nicht mutierten Ziele.
- Eine Ruleset-ID wurde ersetzt oder Parameter änderten sich zwischen Preview und Apply: Pre-State-Hash ist ungültig; kein Write.
- Die accountweite Einstellung kann nicht über eine unterstützte read-only Oberfläche bewiesen werden: Account-Gate bleibt offen; Repository-API-Erfolg genügt nicht.
- Browser- und API-Zustand widersprechen sich: Fail-closed, keine Quelle wird still bevorzugt.
- Das aktive Billingmodell oder die Usage-Anzeige kann nicht eindeutig einem aktuellen Vertrag zugeordnet werden: Kosten-Gate bleibt offen; kein Budgetkauf und keine Vertragsänderung.
- Ein PR wird als Draft geöffnet, mehrfach zwischen Draft und Ready gewechselt oder nach einem Review erneut gepusht: höchstens das erste qualifizierende automatische Review; spätere Reviews nur manuell.
- Copilot liefert wegen Quota, Billing oder Providerfehler kein Review: als Provider-/Billing-Refusal ausweisen, nicht als technischer Pass und nicht als menschliche Freigabe.
- Eine Mutation gelingt nur teilweise: Mischzustand wird exakt berichtet; Resume/Rollback beginnt erst nach frischer Inventur und Authority-Revalidierung.
- Ein Rollback würde neuere legitime Änderungen überschreiben: Hard Stop statt erzwungener Wiederherstellung.
- Der adminseitige Merge-Bypass wird benötigt: erst nach regulärem protection-only Refusal und nur mit vollständiger unabhängiger Acceptance-, Security-, Review- und Gate-Evidence.
- Position 7 oder eine andere Serienposition wird versehentlich adressiert: Hard Stop; G4 erteilt keine Position-7-Autorität.

## Anforderungen / Requirements *(mandatory)*

### Funktionale Anforderungen / Functional Requirements

- **CRG-001 (FR-001) – Live-Preflight / Live Preflight**: Vor jeder Provider-Mutation MUSS eine frische read-only Inventur Accountautomation, tatsächlich aktives Abrechnungsmodell und Usage-Anzeige, Repository-Sichtbarkeit, Default-Branches sowie die vollständige aktive `copilot_code_review`-Ruleset-Menge mit exakten Account-, Repository- und Ruleset-IDs neu ermitteln. Die Werte `22/6/2/16` sind ausschließlich der Planungssnapshot vom 2026-08-19. Jede unbekannte, fehlende oder abweichende Identität, Menge oder Quelle stoppt fail-closed vor der ersten Mutation und verlangt eine neu reviewte Change-Menge.
- **CRG-002 (FR-002) – Accountgrenze / Account Boundary**: Die persönliche accountweite automatische Copilot-Review-Einstellung MUSS im Zielzustand deaktiviert sein, damit ausschließlich Repository-Rulesets Automatik auslösen. Wenn keine unterstützte API-/CLI-Lesefläche existiert, MUSS ein redigierter manueller Browser-Vorher-/Nachher-Nachweis verwendet werden; Repository-API-Evidence DARF diesen Accountnachweis nicht ersetzen.
- **CRG-003 (FR-003) – Genau acht / Exactly Eight**: Nach erfolgreicher Abnahme DÜRFEN genau die folgenden acht Repository-/Default-Branch-Ziele ein aktives automatisches Copilot-Code-Review-Ruleset besitzen: `hindermath/home-baseline` (`main`), `hindermath/agent-operations-cockpit` (`main`), `hindermath/TuiVision` (`main`), `hindermath/TinyPl0` (`main`), `hindermath/TinyCalc` (`main`), `hindermath/InventarWorkerService` (`main`), `hindermath/cc65` (`master`) und `hindermath/tvision` (`master`). `TuiVision` wird nur einmal gezählt.
- **CRG-004 (FR-004) – Bestehende sechs / Existing Six**: Der authoring-zeitliche Plan erwartet Updates für `home-baseline`, `TuiVision`, `TinyPl0`, `TinyCalc`, `InventarWorkerService` und `cc65`. CRG-001 MUSS vor Apply bestätigen, welche dieser sechs Rulesets noch dieselben existierenden Ziel-IDs besitzen; abweichende Livefakten dürfen nicht still als Update behandelt werden.
- **CRG-005 (FR-005) – Neue zwei / New Two**: Der authoring-zeitliche Plan erwartet neue Rulesets für `agent-operations-cockpit` und `tvision`. CRG-001 MUSS vor Apply bestätigen, ob diese zwei weiterhin fehlen; bereits vorhandene, unbekannte oder abweichende Rulesets führen zur reviewten Driftentscheidung statt zu einer doppelten Anlage.
- **CRG-006 (FR-006) – Reversible Reduktion / Reversible Reduction**: Alle beim frischen CRG-001-Preflight aktiven automatischen Rulesets außerhalb der Acht MÜSSEN nach expliziter Freigabe deaktiviert und DÜRFEN NICHT gelöscht werden. Die authoring-zeitlichen 16 und ihre damalige Zusammensetzung sind nur Erwartung; Abweichung stoppt vor Mutation. Jede bestätigte Nichtziel-ID bleibt im Rollbackvertrag erhalten.
- **CRG-007 (FR-007) – Ein Review / One Review**: Pro Pull Request DARF höchstens ein automatisches Review ausgelöst werden: beim Ready-Öffnen oder beim ersten Wechsel von Draft zu Ready. Mehrfaches Ready-Wechseln oder Pushen DARF keine weitere Automatik auslösen.
- **CRG-008 (FR-008) – Keine Draft-Automatik / No Draft Automation**: Auf allen acht Zielrulesets MUSS `review_draft_pull_requests` `false` sein.
- **CRG-009 (FR-009) – Keine Push-Automatik / No Push Automation**: Auf allen acht Zielrulesets MUSS `review_on_push` `false` sein. Re-Reviews nach weiteren Änderungen sind ausschließlich bewusst manuell.
- **CRG-010 (FR-010) – Lite**: Der automatische Standardaufwand MUSS `Lite` sein. Ein teurerer Aufwand benötigt eine einzelne bewusste manuelle Entscheidung und ändert den automatischen Sollvertrag nicht.
- **CRG-011 (FR-011) – Manuelle Verfügbarkeit / Manual Availability**: Copilot MUSS in allen Repositories weiterhin manuell als Reviewer anforderbar bleiben; die Reduktion der Automatik darf diese Möglichkeit nicht sperren.
- **CRG-012 (FR-012) – Advisory**: Copilot DARF nicht alleiniger Required Reviewer sein und DARF menschliche Bewertung, technische CI, Security-Gates oder Acceptance-Evidence nicht ersetzen. Ein fehlendes, abgelehntes oder fehlerhaftes Copilot-Review ist kein technischer oder menschlicher Pass.
- **CRG-013 (FR-013) – Zwei Kostenachsen / Two Cost Axes**: Evidence MUSS AI-Credit-Verbrauch und Copilot-Code-Review-Actions-Minuten in getrennten Feldern, mit getrennten Quellen, Messzeiträumen und Einheiten berichten; automatische und manuelle Reviewauslösungen werden ebenfalls getrennt gezählt.
- **CRG-014 (FR-014) – Keine Scheingenauigkeit / No False Precision**: Da das automatisch gewählte Modell nicht verlässlich vorab offengelegt wird, DARF kein fester Preis pro Review behauptet werden. Berichtet werden tatsächliche Auslösungen und tatsächlicher Verbrauch mit Quellenfrische.
- **CRG-015 (FR-015) – Reproduzierbare Mutation / Reproducible Mutation**: Jede Provideränderung MUSS Preview, exakte Ziel-ID, redigierten Vorzustand samt normalisiertem Hash und Erfassungszeit, beabsichtigten Nachzustand, Operationsergebnis, frische Ergebnisinventur und begrenzten exakten Rollback besitzen. Apply und Rollback MÜSSEN idempotent sein; Drift zwischen Preview und Write stoppt.
- **CRG-016 (FR-016) – Berechtigungsgrenze und External-Write-Gate / Authority Boundary and External Write Gate**: Repository-lokale Spezifikation, Implementierung, Tests, Dokumentation und redigierte Evidence sind im aktuellen autonomen Lauf autorisiert. Commit, Push, Pull Request, regulärer Mergeversuch, der eng begrenzte Merge-Bypass nach protection-only Refusal, Branch-Cleanup und Default-Branch-Synchronisation gehören zum ausdrücklich erteilten `MergeAndSync`-Modus, jedoch nicht zu dieser Specify-Phase. GitHub-Account-, Ruleset- oder Billing-Mutationen benötigen zusätzlich vor jeder Operationsklasse ein aktuelles External-Write-Gate, das exakte Ziele, erlaubte Aktionen, Berechtigungsscope, Vorzustand, Rollback, Secret-Handhabung, Zeitgrenze und aktuelle ausdrückliche Provider-Write-Autorität bindet. Delivery-Modus und Bypass-Autorität erteilen keine allgemeine Provider-Admin-, Secret-, Subscription-, Budgetkauf- oder Cancellation-Autorität.
- **CRG-017 (FR-017) – Datenschutz / Privacy**: Versionierte oder teilbare Evidence DARF keine Tokens, Cookies, vollständigen Abrechnungsbelege, Rohantworten mit unnötigen Personendaten, private lokale Pfade oder nicht benötigte Accountdetails enthalten. Redigierte Exact-ID-Evidence enthält nur die für Audit, Drift und Rollback erforderlichen Identitäten.
- **CRG-018 (FR-018) – Dokumentation / Documentation**: Documentation Impact MUSS `UpdateRequired` bleiben. Scope, Acht-Repository-Ziel, manueller Review/Re-Review, Advisory-Grenze, beide Kostenachsen, External-Write-Gate, Rollback, Fehler-/Refusal-Klassen und Re-Evaluation MÜSSEN Deutsch zuerst und Englisch danach auf CEFR B2 dokumentiert werden.

### Übergreifende Qualitäts- und Autoritätsanforderungen / Cross-Cutting Quality and Authority Requirements

- **CR-001**: Das Feature ist Level-0-Flotten-Governance und kein einzelnes Level-2-Runtimefeature. Level-2-Registry-Zeilen bleiben für spätere zielrepository-spezifische Build-/Testnachweise bindend; keine Zielruntime wird durch diese Spezifikation neu festgelegt.
- **CR-002**: Nutzerseitige CLI-, Hilfe-, Dokumentations-, Fehler- und Evidence-Flächen MÜSSEN WCAG 2.2 AA soweit anwendbar erfüllen und vollständig textorientiert verständlich bleiben.
- **CR-003**: Deutsch steht zuerst, Englisch danach; CEFR B2, kurze Begriffserklärung beim ersten Auftreten und kein vorausgesetztes Spec-Kit-Wissen sind bindend.
- **CR-004**: Projektstatistik ist nach abgeschlossener Implementierungsphase zu aktualisieren. Shared Agent Guidance wird gemeinsam geprüft; Änderungen erfolgen nur atomar über alle gepflegten Flächen.
- **CR-005**: Primäre Implementierungssprache ist PowerShell 7 auf der speichersicheren .NET-Laufzeit; die verpflichtende Bash-Oberfläche ist der bestehende macOS/Linux-Adapter. Sichere PowerShell-/Bash-Codingregeln, Eingabevalidierung, kein `Invoke-Expression`/`eval` für nicht vertrauenswürdige Daten und eng begrenzte Prozess-/Providerargumente sind bindend. Eine spätere Änderung des gemeinsamen Kerns löst MSL- und Architektur-Re-Evaluation aus.
- **CR-006**: Security-, Architecture-, iSAQB-, A11Y-, Cross-Platform-, Agent-Parity-, Intake-Sequencing- und Autonomous-Run-Governance werden gemäß den Anwendbarkeitstabellen dieses Dokuments geprüft; stille Auslassung ist verboten.
- **CR-007**: Providerfehler, Billing-/Quota-Refusal, technischer Gate-Fehler, menschlicher Reviewstatus und bestandene Acceptance sind getrennte Zustände. Ein grüner Sammelname oder Bypass beweist keinen anderen Zustand.
- **CR-008**: Vor dem ersten Implementierungsedit MUSS der unten definierte Acceptance-Gate-Vertrag von Feature Owner und Reviewer gegen Intake, Spec und geplante Evidencepfade geprüft und als `Accepted` dokumentiert werden. Ohne diesen Nachweis bleibt Implementierung blockiert.
- **CR-009**: Jede externe Mutation MUSS zusätzlich das External-Write-Gate aus CRG-016 erfüllen. Ein `Accepted` Pre-Implementation-Gate erteilt allein keine externe Schreibautorität.
- **CR-010**: Position 7 bleibt außerhalb des Scopes und darf weder gestartet noch als impliziter Post-Write-Schritt vorbereitet werden.

### Schlüsseldaten / Key Entities

- **Desired-State Target Selector / Sollzustands-Zielselektor**: Unveränderliche Position, exakter Owner/Name-Slug und erwarteter Default-Branch für eines der acht festen Ziele; enthält bewusst keine Live-Provider-ID oder Sichtbarkeit.
- **Live Repository Identity / Live-Repository-Identität**: Frisch inventarisierte Repository-/Provider-ID, aktueller Slug, Sichtbarkeit und Default-Branch. Sie wird vor jedem Write erneut gelesen und gegen den Sollzustands-Zielselektor verglichen.
- **Copilot Review Ruleset / Copilot-Review-Ruleset**: Providerobjekt mit exakter Repository- und Ruleset-ID, Aktivstatus, Branchziel, Draft-/Pushschaltern, Aufwand und redigiertem Zustands-Hash.
- **Account Automation State / Account-Automatikzustand**: Persönliche automatische Revieweinstellung mit Quelle, Erfassungszeit, redigiertem Vorher-/Nachher-Beleg und Beweisgrenze der verwendeten Oberfläche.
- **Live Inventory Snapshot / Live-Inventursnapshot**: Vollständige read-only Account-, Billing-, Repository-, Branch- und Ruleset-Sicht mit normalisiertem Hash und Frischezeitpunkt; ersetzt niemals automatisch den reviewten Sollvertrag.
- **Mutation Plan / Mutationsplan**: Reviewte Menge exakter Create-, Update-, Disable- oder No-op-Schritte mit Vorbedingungen, Desired State und Rollback. Keine Delete-Aktion ist zulässig.
- **External Write Authorization / Externe Schreibautorität**: Operationsspezifischer Nachweis für exakte Providerziele, Aktionsallowlist, Berechtigungsscope, Zeitfenster, Secret-Handhabung, Vorzustand und Rollback.
- **Usage Evidence / Nutzungsevidence**: Datensparsame Messung automatischer/manueller Reviews, AI-Credits und Actions-Minuten in getrennten Einheiten und Zeiträumen.
- **Gate Evidence / Gate-Evidence**: Hashgebundener Nachweis für genau einen stabilen Acceptance-Gate mit Scope, Befehl, Runner/Plattform, Ergebnis, Owner, Reviewer und Re-Evaluation Trigger.
- **Rollback Record / Rollbackdatensatz**: Exakte, begrenzte Wiederherstellungsanweisung pro mutierter ID, die neuere legitime Änderungen niemals überschreibt.

## Erfolgskriterien / Success Criteria *(mandatory)*

### Messbare Ergebnisse / Measurable Outcomes

- **SC-001**: 100 % der vor einer Mutation benötigten Account-, Billing-, Repository-, Branch- und Ruleset-Fakten werden frisch read-only ermittelt; null historische Snapshotwerte werden ungeprüft als Livefakten verwendet.
- **SC-002**: Nach erfolgreicher Providerabnahme sind genau 8 benannte Repository-/Branch-Ziele automatisch aktiv und 0 nicht benannte Ziele automatisch aktiv.
- **SC-003**: 100 % der frisch bestätigten aktiven Nichtziel-Rulesets sind deaktiviert, 0 sind gelöscht, und 100 % besitzen eine exakte rollbackfähige ID.
- **SC-004**: Auf allen 8 Zielrulesets sind Draft-Reviews aus, Push-Re-Reviews aus und der automatische Aufwand ist `Lite`.
- **SC-005**: Für jeden getesteten Ready-Open- oder ersten Draft-to-Ready-Fall entsteht höchstens 1 automatisches Review; für 100 % der getesteten Folge-Pushes entsteht 0 automatische Re-Review-Auslösung.
- **SC-006**: Manuelle Copilot-Anforderung bleibt in 100 % der geprüften Ziel- und Nichtzielrepositories verfügbar; Copilot ist in 0 Fällen alleiniger Required Reviewer.
- **SC-007**: 100 % der Nutzungsberichte trennen AI-Credits und Actions-Minuten sowie automatische und manuelle Auslösungen; 0 Berichte behaupten einen unbelegten Fixpreis pro Review.
- **SC-008**: 100 % der Apply-/Rollback-Schritte besitzen Exact-ID-Vorher-/Nachher-/Rollback-Evidence; ein zweiter Check meldet 0 Drift und erzeugt 0 zusätzliche Mutation.
- **SC-009**: 0 Secrets, Cookies, vollständige Abrechnungsbelege, unnötige Personendaten oder private lokale Pfade erscheinen in versionierter Evidence.
- **SC-010**: Bash und PowerShell liefern für identische Fixtures in 100 % der Fälle dieselbe normalisierte Entscheidung, denselben Exitcode und im Previewmodus 0 Writes.
- **SC-011**: 100 % der nutzerseitigen Status-, Fehler- und nächsten Aktionsinformationen sind in linearer Textform ohne Farbe verständlich und bestehen die geplante WCAG-2.2-AA-/CEFR-B2-Prüfung.
- **SC-012**: Position 7 wird 0-mal gestartet; Subscription, Budgetkauf und Cancellation werden 0-mal verändert.

### Rückverfolgbarkeit der Anforderungen / Requirement Traceability

| Intake-ID | Primäre Story / Primary Story | Primäre Abnahme / Primary Acceptance | Geplante Evidence / Planned Evidence |
|---|---|---|---|
| `CRG-001` | Story 1 | `AC-CRG-001` | Live-Inventur, Snapshotvergleich, Drift-Fixtures |
| `CRG-002` | Stories 1–2 | `AC-CRG-001`, `AC-CRG-002` | Redigierte Account-UI-Vorher-/Nachher-Evidence |
| `CRG-003` | Story 2 | `AC-CRG-002`, `AC-CRG-006` | Exakte Acht-Mengenprüfung |
| `CRG-004` | Story 2 | `AC-CRG-002`, `AC-CRG-009` | Exact-ID-Updateplan oder fail-closed Drift |
| `CRG-005` | Story 2 | `AC-CRG-002`, `AC-CRG-009` | Exact-ID-Createplan oder fail-closed Drift |
| `CRG-006` | Story 2 | `AC-CRG-003`, `AC-CRG-006`, `AC-CRG-009` | Disable-/Existenz-/Rollback-Evidence |
| `CRG-007` | Story 3 | `AC-CRG-005` | Open-, Draft-to-Ready- und Push-Auslösetest |
| `CRG-008` | Story 3 | `AC-CRG-004`, `AC-CRG-005` | Rulesetparameter und Draft-Test |
| `CRG-009` | Story 3 | `AC-CRG-004`, `AC-CRG-005` | Rulesetparameter und Push-Test |
| `CRG-010` | Story 3 | `AC-CRG-004`, `AC-CRG-005` | Aufwandparameter und Usage-Evidence |
| `CRG-011` | Story 3 | `AC-CRG-006` | Manuelle Reviewer-Anforderung in Ziel-/Nichtzielprobe |
| `CRG-012` | Story 3 | `AC-CRG-007` | Unveränderte Human-/CI-/Security-Gates |
| `CRG-013` | Story 4 | `AC-CRG-008` | Getrennte Usage-Felder und Quellen |
| `CRG-014` | Story 4 | `AC-CRG-008` | Kostenmethodik ohne Fixpreisbehauptung |
| `CRG-015` | Stories 1–2 | `AC-CRG-003`, `AC-CRG-009` | Exact-ID-Apply-/Rollback-/Idempotenz-Evidence |
| `CRG-016` | Stories 1–2 | `AC-CRG-001`, `AC-CRG-009`, `AC-CRG-010` | External-Write-Gate und Authority-Protokoll |
| `CRG-017` | Stories 1–5 | `AC-CRG-008`, `AC-CRG-009` | Redaktions- und Secret-Scan-Nachweis |
| `CRG-018` | Stories 3–5 | alle / all | Documentation-Impact-, A11Y- und Sprach-Evidence |

### Rückverfolgbarkeit der Abnahme / Acceptance Traceability

| Acceptance-ID | Bindender Abnahmeumfang / Binding Acceptance Scope | Requirement Coverage |
|---|---|---|
| **AC-CRG-001** | Der frische Preflight weist Abrechnungsmodell und Usage-Anzeige, Account-Automatik, Default-Branches, Sichtbarkeit und vollständige Ruleset-Menge mit Quellenfrische nach. Historische Zählwerte sind nur Vergleich. | `CRG-001`, `CRG-002`, `CRG-016` |
| **AC-CRG-002** | Genau die acht benannten Repository-/Branch-Ziele sind automatisch aktiv. Update/Create-Klassifikation folgt nur dem reviewten frischen Preflight. | `CRG-002`–`CRG-005` |
| **AC-CRG-003** | Die im frischen, reviewten Plan bestätigten früher aktiven Nichtziel-Rulesets—bei bestätigtem Intake-Snapshot 16—sind deaktiviert, weiterhin vorhanden und über exakte IDs rückrollbar; Snapshotdrift blockiert statt die Zahl still zu ändern. | `CRG-006`, `CRG-015` |
| **AC-CRG-004** | Auf allen acht Zielrulesets sind Draft- und Push-Re-Reviews deaktiviert und der automatische Aufwand ist `Lite`. | `CRG-008`–`CRG-010` |
| **AC-CRG-005** | Ein Ready-Open-PR oder erster Draft-to-Ready-Wechsel erzeugt höchstens ein automatisches Review; ein weiterer Push erzeugt keines. | `CRG-007`–`CRG-010` |
| **AC-CRG-006** | In jedem anderen Repository entsteht ohne manuelle Anforderung kein Copilot-Review; die manuelle Anforderung bleibt überall verfügbar. | `CRG-003`, `CRG-006`, `CRG-011` |
| **AC-CRG-007** | Menschliche Review- und technische Merge-/Security-Gates bleiben unverändert; Copilot ist nicht allein required. | `CRG-012` |
| **AC-CRG-008** | AI-Credits und Copilot-Actions-Minuten sowie automatische/manuelle Auslösungen werden getrennt, ohne geheime Abrechnungsdaten und ohne Fixpreisbehauptung berichtet. | `CRG-013`, `CRG-014`, `CRG-017` |
| **AC-CRG-009** | Apply und Rollback sind exact-ID-gebunden und idempotent; der zweite Check meldet null Drift. | `CRG-004`–`CRG-006`, `CRG-015`–`CRG-017` |
| **AC-CRG-010** | Position 7 wurde nicht gestartet; keine Subscription-, Budgetkauf- oder Cancellation-Aktion wurde ausgeführt. | `CRG-016`, `CR-010` |

## Annahmen und Abhängigkeiten / Assumptions and Dependencies

- Der bindende Intake und sein `Ready`-Review sind aktuell hashgleich; bei Hashdrift stoppt der Lauf und fordert erneutes Review.
- Stage B ist durch terminale Evidence mit 48/48 konvergierten Repositories abgeschlossen. Diese Evidence ersetzt keine G4-Providerinventur.
- Das aktive Serienmanifest führt G4 als `Primary/Eligible`; Position 7 bleibt durch `HardCompletionGate` blockiert, bis G4 später vollständig abgeschlossen und die Serie separat aktualisiert wird.
- Der aktuelle Delivery-Modus ist `MergeAndSync`. Die adminseitige Bypass-Autorität ist auf diesen G4-Lauf und einen vorausgehenden regulären protection-only Merge-Refusal begrenzt.
- Weder `MergeAndSync` noch der Bypass erteilen Provider-Admin-, Secret-, Subscription-, Budgetkauf-, Cancellation- oder Position-7-Autorität.
- Die offizielle Billing-/Usage-Anzeige und Provideroberflächen können sich ändern. CRG-001 und die Re-Evaluation Trigger sind deshalb bindend.
- Die feste Acht-Repository-Zielmenge bleibt fachlich bindend. Der Zustand „sechs vorhanden, zwei neu, sechzehn zu deaktivieren“ bleibt ohne frische Bestätigung unverbindlich.
- Keine neue Abhängigkeit ist vorausgesetzt. Jede vorgeschlagene Dependency benötigt Aktivitäts-, Lizenz-, CVE- und Supply-Chain-Prüfung.

## Autonomous-Run-Anwendbarkeit / Autonomous-Run Applicability

- **Applicability / Anwendbarkeit**: `Applicable`; der Lauf verwendet feature-lokalen Run-State, geroutete Phasenergebnisse, Acceptance-Gates, Remote-Closeout und potenziell einen eng begrenzten Merge-Bypass.
- **Delivery mode and authority / Delivery-Modus und Autorität**: `MergeAndSync`, ausdrücklich im aktuellen Benutzerauftrag und in `specs/031-github-copilot-review-governance/autonomous-run-evidence.md` gebunden. Der Modus autorisiert den späteren Git-Lieferpfad, nicht automatisch Provider-Settings-Writes.
- **Accepted inputs / Akzeptierte Eingaben**: Die Hashes in `specs/031-github-copilot-review-governance/autonomous-run-state.json`, insbesondere Intake `303ef5b04b259389006d32f0c565cd335b2ff4d126aebc084d77ae124f96d6c5`, Ready-Review, Serienmanifest/-receipt und terminale Stage-B-Evidence.
- **Feature identity / Feature-Identität**: Branch und Feature-Pfad sind `031-github-copilot-review-governance` beziehungsweise `specs/031-github-copilot-review-governance`; `.specify/feature.json` bleibt darauf gebunden.
- **Hard boundary / Harte Grenze**: Diese Specify-Phase schreibt nur Spezifikation, Requirements-Qualitätscheckliste und Runner-Phasenergebnis. Sie führt weder Commit, Push, PR, Merge, GitHub-Settings-Write, Subscription-/Budgetaktion, Home-Sync noch Position-7-Start aus.
- **External writes / Externe Writes**: Spätere Account-/Ruleset-Mutationen bleiben bis zum aktuellen operationsspezifischen External-Write-Gate blockiert. Provider-Admin- oder Secret-Autorität wird nie aus dem Run-State abgeleitet.
- **Admin bypass / Admin-Bypass**: `Applicable` nur für den späteren Mergeweg nach dokumentiertem regulärem protection-only Refusal. Er ersetzt weder Acceptance, Security, Review noch technische Gate-Evidence und autorisiert keine Account-/Rulesetmutation.
- **Mutable validation tokens / Veränderliche Validierungstoken**: Feature-HEAD, Intake-/Review-/Manifest-/Receipt-Hashes, Live-Snapshot-Hash, Provider-IDs, Vorzustands-Hash, Gate-Map-Hash, Review-Head, Billingmodell und Evidence-Schema. Jede Änderung erzwingt die dazu erklärte Re-Evaluation.
- **Causal closeout / Kausaler Abschluss**: `Applicable`, weil Merge, Providerzustand, Default-Branch-Sync und gegebenenfalls Home Runtime kausal an PreMerge-/PostMerge-Evidence gebunden werden müssen. Provider-Settings-Closeout bleibt davon getrennt.
- **Run state / Laufzustand**: `specs/031-github-copilot-review-governance/autonomous-run-state.json`. Bewusster Stop führt zu `PausedByUser`; unerwartete Unterbrechung erfordert vollständige Drift-, Authority-, Hash-, Provider- und Gate-Revalidierung vor Resume.
- **Retrospective boundary / Retrospektivgrenze**: Portable Erkenntnisse dürfen Governance-, Kosten-, A11Y-, Test- und Evidence-Muster fördern. Credentials, persönliche Billingdetails, transienter Providerzustand und implizite Autorität sind ausgeschlossen.
- **Re-evaluation trigger / Re-Evaluation**: Run-State-, Delivery-Modus-, Branch-, Intake-, Review-, Serien-, Provider-, Billing-, Gate-, Bypass- oder Feature-HEAD-Drift.

### Specify-Phasengates / Specify Phase Gates

| Gate-ID | Anwendbarkeit / Applicability | Scope und prüfbarer Token / Scope and Verifiable Token | Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|
| `SPEC-GATE-001` | `Applicable` | Genau `spec.md` und `checklists/requirements.md` sind die zwei fachlichen Specify-Tasks; beide sind nicht leer und die Featurebindung bleibt unverändert. | Featurepfad und `.specify/feature.json` | Taskumfang oder Featurebindung ändert sich |
| `SPEC-GATE-002` | `Applicable` | `CRG-001` bis `CRG-018` und `AC-CRG-001` bis `AC-CRG-010` sind lückenlos, ohne Umnummerierung und mit expliziter Traceability vorhanden. | Tabellen und Anforderungen dieser Spezifikation | Intake- oder Reviewhash driftet |
| `SPEC-GATE-003` | `Applicable` | Die Snapshot-/Livegrenze, der External-Write-Gate, die Bypass-Ausnahme und alle verbotenen Autoritätsableitungen sind ausdrücklich enthalten. | CRG-001, CRG-016 und Autonomous-Run-Grenze | Authority, Provideroberfläche oder Billingmodell ändert sich |
| `SPEC-GATE-004` | `Applicable` | Keine ungelöste Klarstellung oder Templateplatzhalter; jede Qualitätschecklistenposition ist wahrheitsgemäß bestanden. | `checklists/requirements.md` | Neue Reviewfrage oder Qualitätsfinding |
| `SPEC-GATE-005` | `Applicable` | Der normalisierte lowercase SHA-256 bindet den finalen Spezifikationspayload im Phasenergebnis. | `.specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/specify.result.json` | Jede Änderung an `spec.md` |

Owner aller Specify-Gates ist der Feature Owner; Reviewer ist der nachfolgende
Spec-Kit-Phasenreview. Restrisiko ist spätere Drift bindender Artefakte. Der
Follow-up ist immer fail-closed Revalidierung, niemals stille Anpassung.

### Reviewter Pre-Implementation-Acceptance-Gate-Vertrag / Reviewed Pre-Implementation Acceptance-Gate Contract

Vor dem ersten Implementierungsedit MUSS eine Gate-Map mit den folgenden
stabilen IDs durch Feature Owner und Reviewer gegen Intake, Spezifikation,
Plan, Checklisten und Evidencepfade geprüft und ausdrücklich als `Accepted`
dokumentiert werden. Jede `Applicable`-Zeile benötigt unveränderten
`requiredScope`, mindestens einen erforderlichen Befehlstoken, die genannten
Runner-/Plattformtoken, Owner, Reviewer, Evidencepfad und Re-Evaluation Trigger.
`N/A` ist nur mit Begründung zulässig. Ein fehlendes oder geändertes Gate
blockiert Implementierung und jede externe Mutation.

*Before the first implementation edit, the Feature Owner and Reviewer must
review a gate map with the stable IDs below against the intake, specification,
plan, checklists, and evidence paths, and explicitly record `Accepted`.
Acceptance of this map does not grant external write authority.*

| Gate-ID | Applicability | Required scope / Erforderlicher Scope | Validator-bound primary command / Validatorgebundener Primaerbefehl | Runner/platform token(s) | Planned evidence / Geplante Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|---|---|
| `AC-CRG-001` | `Applicable` | Fresh complete read-only billing/account/repository/branch/ruleset inventory; no snapshot substitution; browser-only account proof stays distinct. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-001 --check-only --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `BrowserManual` | `specs/031-github-copilot-review-governance/evidence/v1/acceptance-operational.json` plus redacted live inventory | Source, endpoint/UI, billing, ID, visibility, branch or snapshot changes |
| `AC-CRG-002` | `Applicable` | Exact target-set equality for the eight named repository/branch pairs after authorized change. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-002 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly` | Acceptance operational evidence and exact target manifest | Target set, repository identity, branch or ruleset semantics change |
| `AC-CRG-003` | `Applicable` | Every freshly confirmed active non-target ruleset is disabled, retained and exact-ID rollback capable; count drift blocks. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-003 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly` | Disable/existence/rollback inventory | Non-target set, ID or delete/disable behavior changes |
| `AC-CRG-004` | `Applicable` | All eight targets prove draft=false, push=false and automatic effort Lite. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-004 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `BrowserManual` | Exact parameter comparison | Provider parameter schema or effort vocabulary changes |
| `AC-CRG-005` | `Applicable` | Ready-open and first Draft-to-Ready produce at most one automatic review; later push produces none. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-005 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `PRLifecycle` | Redacted PR lifecycle evidence | Trigger semantics, PR lifecycle or provider behavior changes |
| `AC-CRG-006` | `Applicable` | No unrequested review outside the eight; manual review remains available in target and non-target samples. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-006 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `ManualReview`, `BrowserManual` | Automatic/manual review availability evidence | Manual reviewer capability or account/ruleset scope changes |
| `AC-CRG-007` | `Applicable` | Human review and technical CI/security gates are unchanged; Copilot is never sole required reviewer. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-007 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `Review` | Before/after gate map and review evidence | Branch protection, ruleset, reviewer or CI/security gate changes |
| `AC-CRG-008` | `Applicable` | AI credits, Actions minutes and automatic/manual triggers are separate, sourced and redacted; no fixed-price claim. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-008 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHubReadOnly`, `BillingReadOnly` | Redacted usage report and privacy scan | Billing model, quota period, categories or privacy policy changes |
| `AC-CRG-009` | `Applicable` | Exact-ID Apply and rollback are idempotent; second check has zero drift and zero writes. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-009 --dry-run -WhatIf --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `Linux`, `Windows` | Apply/rollback/state-machine and platform evidence | Apply semantics, supported platform, ID or rollback contract changes |
| `AC-CRG-010` | `Applicable` | Position 7, subscription, budget purchase and cancellation all remain unchanged. | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-010 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `MergeAndSync` | Mutation allowlist comparison and series-state evidence | Sequencing, subscription or authority scope changes |

Gate Owner ist der Fleet Governance Owner; Reviewer sind Feature Reviewer und,
wo einschlägig, Security-, Architecture-, A11Y- und Cross-Platform-Reviewer.
Restrisiko vor Ausführung ist Provider-/UI-Drift. Follow-up ist eine neue
reviewte Gate-Map und frische Evidence, nicht die Wiederverwendung alter
Resultate.

Die Spalten `Validator-bound primary command` und `Runner/platform token(s)`
sind kanonisch. Jeder vollständige Primaerbefehl steht als genau ein Element
in `requiredCommandTokens`; der installierte Validator muss diese komplette
Zeichenfolge im ausgefuehrten Befehl finden. Ein nicht ausgewertetes
`requiredCommand`-Feld existiert nicht. `--check-only`, `--dry-run` und
`-WhatIf` bezeichnen dort erforderliche Safe-Mode-Evidence; Bash- und
PowerShell-Token werden nicht als Optionen derselben Wrapperinvokation
missverstanden. `MergeAndSync` in `AC-CRG-010` beschreibt ausschließlich den
aktuellen Git-Liefermodus. Es erteilt keine Provider-Write-Autorität.

### External-Write-Gate für Provider-Mutationen / External Write Gate for Provider Mutations

Vor jeder Account- oder Ruleset-Mutationsklasse MUSS ein aktueller Gatebeleg
alle folgenden Punkte erfüllen; andernfalls ist der Zustand `Blocked`:

1. aktuelle ausdrückliche Autoritätsquelle für genau Account-Setting,
   Ruleset-Create, Ruleset-Update oder Ruleset-Disable; keine implizite
   Provider-Admin- oder Secret-Autorität;
2. exakte Account-, Repository- und Ruleset-IDs sowie erlaubte Operationen;
3. frischer CRG-001-Snapshot, normalisierter Vorzustands-Hash, Erfassungszeit,
   gewünschter Nachzustand und eng begrenzter Rollback;
4. bestandener, reviewter Pre-Implementation-Acceptance-Gate-Vertrag sowie
   vollständige aktuelle Acceptance-, Security-, Review- und technische
   Gate-Evidence für die konkrete Operation;
5. Preview mit null Writes, Least-Privilege-Berechtigungsprüfung,
   Secret-Handhabung ohne Offenlegung und Driftvergleich unmittelbar vor Write;
6. eindeutige Operations-/Idempotenz-ID, redigiertes Ergebnis und frische
   Post-Write-Inventur;
7. Hard Stop bei unbekannter ID, UI/API-Widerspruch, Authority-/Scope-/Zeitdrift,
   Provider-/Billing-Refusal oder nicht sicherem Rollback.

Der autorisierte Admin-Bypass betrifft ausschließlich den späteren
protection-only Merge-Refusal-Pfad. Er erfüllt keinen dieser Provider-
Settings-Punkte von selbst.

## Governance-Anwendbarkeit / Governance Applicability

| Checkpoint | Applicability | Specify implementation status | Rationale / Begründung | Planned evidence / Geplante Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|---|
| Security Governance | `Applicable` | `Partly Fulfilled` | Externe Providerwrites, untrusted IDs/UI/API-Daten, Secrets, Billing, Rollback und Evidence-Integrität sind sicherheitsrelevant; die Spec definiert Grenzen, Implementierungsproof folgt. | `docs/security/` gemäß Security-Tabelle, Acceptance- und External-Write-Gates | Trust Boundary, Dependency, Auth, Secret, Provider oder Scope ändert sich |
| Architecture Governance | `Applicable` | `Partly Fulfilled` | Account-, Repository-, Ruleset-, Browser-, Billing- und Evidence-Grenzen sowie Transaktions-/Rollbackabläufe ändern sich. | `docs/architecture/copilot-review-governance.md`, S-ADR, Threat Model | Provider, Runtime, UI/API, Deployment oder Transaktionsgrenze ändert sich |
| iSAQB Architecture Governance | `Applicable` | `Partly Fulfilled` | Kontext, Schnittstellen, Building Blocks, Laufzeit, Qualitätsattribute und technische Schuld sind betroffen. | Architekturübersicht, Qualitätszenarien, ADR-Review | Feature wird rein redaktionell ohne Architekturwirkung |
| A11Y Governance | `Applicable` | `Partly Fulfilled` | CLI, Fehler, Hilfe, Dokumentation und Evidence-Zusammenfassungen sind nutzerseitig. | `docs/accessibility/copilot-review-governance.md`, Sprach-/A11Y-Tests | Nutzeroberfläche oder Artefakttyp ändert sich |
| Cross-Platform Governance | `Applicable` | `Partly Fulfilled` | Ein script-shaped Tool für macOS/Linux/Windows wird erstellt oder erweitert. | Bash-/PowerShell-Parität, native Evidence, Manpage und Help | Plattform-, Tool- oder Adapterumfang ändert sich |
| Agent Parity Governance | `Applicable` | `Partly Fulfilled` | Gemeinsame Betriebs-/Authority-Guidance muss auf allen gepflegten Agentenflächen geprüft werden. | Paritätsvalidator, vollständiger Diff, gegebenenfalls atomare Updates | Shared Guidance, Templates, Constitution oder Routingrollen ändern sich |
| Intake Sequencing Governance | `Applicable` | `Fulfilled` | Aktuelles Manifest/Receipt erklärt G4 `Primary/Eligible`; Stage B ist terminal und Position 7 bleibt blockiert. | Gebundene Manifest-/Receipt-/Stage-B-Hashes im Run-State | Manifest, Receipt, Stage-B-Terminalstatus oder Position-7-Kante driftet |
| Autonomous Run Governance | `Applicable` | `Partly Fulfilled` | `MergeAndSync`, geroutete Ergebnisse, Gate-Evidence, Stop/Resume, Bypass und kausaler Closeout sind aktiv; Specify-Gates sind erfüllt, spätere Gates offen. | Run-State, Run-Evidence, Phase Results, Pre-/PostMerge-Evidence | Run-State, Delivery-Modus, Authority, Head, Gate oder Preset driftet |

Owner ist der Fleet Governance Owner. Reviewer sind die jeweils benannten
Fachreviewer. `Partly Fulfilled` bedeutet: Die Spezifikation hat Scope und
Evidencevertrag festgelegt; ausführbare oder Provider-Evidence ist noch nicht
als bestanden behauptet. Fehlende applicable Evidence blockiert die
Implementierungsabnahme und jeden External Write.

## Plattformübergreifende Anwendbarkeit / Cross-Platform Applicability

- **Script-shaped tool**: `Applicable`; eine idempotente Inventur-/Preview-/Apply-/Rollback-Oberfläche wird als funktional gleichwertiges Bash-/PowerShell-Paar geplant.
- **Platforms / Plattformen**: macOS und Linux über Bash; Windows über PowerShell 7+. macOS Safe Mode läuft zuerst; Linux/Windows folgen nativ oder als eng begrenzter hashgebundener CI-Nachweis.
- **Planned surfaces / Geplante Oberflächen**: `scripts/manage-copilot-review-governance.sh`, `scripts/manage-copilot-review-governance.ps1`; PowerShell-Cmdlet `Set-HBCopilotReviewGovernance` mit genehmigtem Verb `Set`.
- **Preview / Vorschau**: Bash `--dry-run` und PowerShell `-WhatIf` zeigen Live-Snapshot-Hash, exakte Ziel-ID, Vorzustand, geplante Aktion, Rollback und Evidencepfad; beide erzeugen null Provider-, Repository- oder Evidence-Writes.
- **Documentation / Dokumentation**: Unix-Manpage `docs/man/manage-copilot-review-governance.1.md`; vollständige bilinguale PowerShell Comment-based Help, Deutsch zuerst und Englisch danach.
- **Parity proof / Paritätsnachweis**: Identische Fixtures erzeugen gleiche normalisierte Entscheidung, Exitcode, Ziel-/Aktionsmenge und Nullschreibwerte. Native Evidence bindet Commit, Befehl, Runner/Plattform, Exitcode, Payload-SHA-256 und Entscheidungs-SHA-256. Teilproof ist kein Vollpass.
- **Browser-only setting / Browsergebundene Einstellung**: Die persönliche Accountautomation ist eine getrennte Provider-UI-Fläche. Script-/API-Parität beweist sie nur, wenn eine offiziell unterstützte Oberfläche dieselbe Einstellung tatsächlich liest; andernfalls ist redigierte manuelle Browser-Evidence erforderlich.
- **N/A decisions**: Keine Scriptplattform ist `N/A`. Browserautomatisierung ist `N/A` als vorausgesetzte Implementierung, weil diese Spezifikation weder Stabilität noch Verfügbarkeit einer automationsfähigen UI behauptet. Re-Evaluation: offizielle Account-Settings-API oder verlässlich autorisierte Browserautomation wird Teil des Plans.

## Barrierefreiheitsanwendbarkeit / Accessibility Applicability

- **Applicability / Anwendbarkeit**: `Applicable` für CLI, Fehlertexte, Status-/Kosten-/Rollbackberichte, Manpage, PowerShell-Hilfe, Betriebsdokumentation und Evidence-Zusammenfassungen.
- **WCAG 2.2 AA**: Anwendbar sind insbesondere 1.3.1 Information und Beziehungen, 1.4.1 Farbe, 2.1.1 Tastatur, 2.4.6 Überschriften/Beschriftungen, 3.3.1 Fehlererkennung, 3.3.2 Anweisungen und robuste Textstruktur. Pointer-, Drag-, Audio- und Videokriterien sind `N/A`, weil keine solche Oberfläche entsteht. Re-Evaluation: GUI, HTML oder Medien kommen in Scope.
- **Language / Sprache**: Deutsch zuerst, Englisch danach, CEFR B2, Fachbegriffe beim ersten Auftreten; Zielgruppe Maintainer, Flotten-Operator*innen und Reviewer mit grundlegenden GitHub-/PR-Kenntnissen, aber ohne vorausgesetzte Spec-Kit- oder Billing-Erfahrung.
- **Text-first**: Jede Ausgabe nennt in stabiler linearer Reihenfolge Repository, Default-Branch, Zustand, geplante Aktion, Ergebnis, Blocker und nächste sichere Aktion. Farbe, Symbol, Tabelle oder visuelle Position sind nie allein bedeutungstragend.
- **Code/visuals / Code und Visuals**: Codeblöcke erhalten Sprachkennzeichnung. ASCII- oder andere Darstellungen erhalten kurze deutsche und englische Textalternativen.
- **Didactic comments / Didaktische Kommentare**: `Applicable` für nicht triviale Logik zu Trust Boundaries, UI/API-Beweisgrenze, Exact-ID-Hashbindung, Drift, Idempotenz, Rollback, Redaction und External-Write-Gate. Kommentare erklären Warum, Trade-off oder Proof-Grenze.
- **Evidence / Nachweis**: `docs/accessibility/copilot-review-governance.md` und ausführbare Sprach-/Linearisierungs-/A11Y-Fixtures. Re-Evaluation bei jeder Änderung nutzerseitiger Ausgabe oder Interaktion.

## Architekturanwendbarkeit / Architecture Applicability

- **Applicability / Anwendbarkeit**: `Applicable`; Systemkontext, Schnittstellen, Building Blocks, Laufzeitverhalten, Deployment/Provideränderung, Qualitätsattribute und technische Schuld sind betroffen.
- **Architecture goals / Architekturziele**: Kostenbegrenzung, fail-closed Korrektheit, Least Privilege, reversible Exact-ID-Transaktionen, Idempotenz, Auditierbarkeit, Datenschutz, Plattformparität und verständliche Bedienung.
- **Affected views / Betroffene Sichten**: Level-0-Control-Plane, lokale Operatoroberfläche, GitHub Account UI, Repository-/Ruleset-Providerfläche, Billing-/Usage-Anzeige, Pull-Request-Lifecycle und versionierte redigierte Evidence.
- **Building blocks / Bausteine**: Live-Inventur, Sollvertrag, Driftentscheidung, Preview, External-Write-Gate, Apply, Post-Write-Check, Rollback, Usage-Messung und Evidence-Redaction.
- **Quality scenarios / Qualitätsszenarien**: ID-Drift stoppt vor Write; Browser/API-Widerspruch bleibt offen; Unterbrechung ist ohne Duplikate resumierbar; Rollback überschreibt keine neuere Änderung; ein Push erzeugt kein automatisches Re-Review; beide Kostenachsen bleiben getrennt.
- **Architecture evidence / Architekturnachweis**: `docs/architecture/copilot-review-governance.md` ist `Applicable`. Ein S-ADR unter `docs/security/adr/` ist für Account-vs-Repository-Steuerung, Browser/API-Beweisgrenze und External-Write-/Rollback-Transaktion erforderlich.
- **Technical debt / Technische Schuld**: Unbegrenzte flotte Automatik, Draft-/Push-Re-Reviews, historische Zählwerte als Betriebswissen und nicht reproduzierbare UI-Einzeländerungen werden durch explizite Verträge ersetzt.
- **Re-evaluation trigger / Re-Evaluation**: Provider, Account-/Rulesetmodell, UI/API, Billing, Zielmenge, Runtime, Rollback, Deployment oder Authority ändert sich.

## Sichere Architekturanwendbarkeit / Architecture Governance Applicability

- **Runtime/hardware and MSL / Runtime, Hardware und MSL**: PowerShell/.NET ist speichersicher. Bash bleibt als bestehender Unix-Adapter erforderlich; keine Hardwaregrenze erzwingt einen weiteren nicht speichersicheren Kern. Re-Evaluation: gemeinsame Kernsprache oder native Dependency ändert sich.
- **Trust boundaries / Vertrauensgrenzen**: Nicht vertrauenswürdige CLI-Parameter, Registry-/Git-Daten, Browseranzeige, Providerantworten, Billingdaten und gespeicherte IDs überqueren die lokale Orchestrierungsgrenze. Account, Repository, Ruleset, PR, Usage, lokale Evidence und Git-Lieferpfad sind getrennte Vertrauens-/Transaktionsräume.
- **Data classifications / Datenklassen**: Sollvertrag und öffentliche Repositorymetadaten sind öffentlich/intern; Sichtbarkeit, Usage-Zusammenfassungen und IDs sind intern; Tokens, Cookies, vollständige Belege und unnötige Personendaten sind restricted und bleiben außerhalb versionierter Evidence.
- **Threat modeling / Bedrohungsmodellierung**: `Applicable`; STRIDE+CIA und relevante CAPEC-Muster decken ID-/State-Spoofing, Evidence-Tampering, Repudiation unprotokollierter Writes, Information Disclosure, DoS durch Provider-/Quota-Fehler und Elevation of Privilege durch überbreite Adminrechte ab. Evidence: `docs/security/threat-model.md`.
- **S-ADR and arc42 / S-ADR und arc42**: `Applicable`; S-ADR wie oben und Update von `docs/security/arc42-security.md` für Authentisierung, Autorisierung, Inputvalidierung, Fehlerbehandlung, Logging, Dependencies und Providerdeployment.
- **Zero Trust**: `Applicable`; Accountsession, Netzwerkstandort, gespeicherte IDs, Browseranzeige, APIantwort, Review und Bypassstatus genießen kein implizites Vertrauen. Evidence: `docs/security/zero-trust-applicability.md`.
- **OWASP SAMM**: `Applicable` für den langlebigen Level-0-Workspace und wiederholbare Provider-Governance. Evidence: `docs/security/samm-assessment.md`.
- **BSI C3A**: `Applicable`, weil GitHub/Copilot als providerabhängige SaaS-Review-, Settings-, Usage- und Hostingfläche real genutzt wird. Evidence: `docs/security/cloud-autonomy-applicability.md` mit Lock-in, Exit, Portabilität und Autonomierisiko.
- **BSI C5**: `Applicable` als Cloud-Assurance-/Shared-Responsibility-Review für Hosting, Copilot, Actions und Settings; keine unbelegte Zertifizierungsaussage. Evidence: `docs/security/cloud-compliance-assurance.md`.
- **Re-evaluation trigger / Re-Evaluation**: Provider, Identity, Berechtigung, Datenklasse, UI/API, Hosting, Subprocessor, Assurance oder Remote-Write-Scope ändert sich.

## Sicherheitsgovernance-Anwendbarkeit / Security Governance Applicability

| Standard / Check | Applicability | Rationale and evidence / Begründung und Evidence | Re-Evaluation Trigger |
|---|---|---|---|
| Primary language / MSL | `Applicable` | PowerShell 7/.NET ist MSL; sichere PowerShell- und Bash-Regeln, Parameterprüfung und eng begrenzte Providerargumente. Evidence in Plan, Security Checklist und Language Rules. | Kernsprache, native Dependency oder Prozessgrenze ändert sich |
| NIST SSDF | `Applicable` | Produktionsnahe Provider-Governance benötigt Prepare/Protect/Produce/Respond-Evidence. | Feature wird rein redaktionell ohne ausführbare/operative Wirkung |
| CWE Top 25 | `Applicable` | Untrusted Inputs, Command/Path Handling, Autorisierung, Secrets und Evidence-Integrität benötigen relevante CWE-Prüfung. | Keine ausführbare Eingabe-, I/O- oder Authority-Fläche mehr |
| OWASP ASVS | `N/A` | Es wird kein eigener Web/API/HTTP/Auth-Service erstellt oder geändert; ein ausgehender Providerkonsum ist kein eigener ASVS-Service. Evidence: `docs/security/asvs-verification.md`. | Eigener Web-, API-, HTTP-, Session- oder Auth-Service kommt in Scope |
| SBOM | `Applicable` | Distributable Level-0-Skripte und Dokument-/Policy-Artefakte benötigen Supply-Chain-Inventar pro Release. | Keine distributable/releasefähige Artefaktmenge mehr |
| VEX | `Applicable` | Bekannte Findings in ausgelieferten oder bewerteten Komponenten benötigen Status. | Keine ausgelieferten oder bewerteten Komponenten mehr |
| AI-SBOM | `N/A` | Copilot wird als externes Entwicklungs-/Reviewwerkzeug genutzt; kein Modell, Dataset, Inferenzsystem oder KI-Runtime wird als Produktartefakt ausgeliefert oder selbst betrieben. Providertransparenzgrenzen werden dennoch dokumentiert. | KI-Modell, Dataset, Inferenzinfrastruktur oder KI-Runtime wird ausgeliefert/betrieben |
| SLSA | `Applicable` | CI-/veröffentlichte Skripte, Policies und Evidence benötigen Provenance- und Integritätsziel. | Keine CI-/Publikationsartefakte mehr |
| OpenSSF Scorecard | `Applicable` | Level 0 und mehrere Zielrepositories sind öffentliche OSS-/Distributionsflächen. | Keine öffentliche oder hochwirksame Dependency-/Repositoryfläche mehr |
| Dependency audit | `Applicable` | Jede neue oder geänderte Dependency benötigt Aktivitäts-, Lizenz-, CVE-, Registry- und Lockfile-Prüfung. Evidence: `docs/security/dependency-audit.md`. | Implementierung belegt keine Dependencyänderung; Prüfung bleibt als N/A-Beleg bestehen |
| CAPEC | `Applicable` | Providerwrite, Privilege, ID, Browser/API, Pfad, Prozess und Evidence besitzen materielle Angriffswege. | Trust Boundaries und externe Writes entfallen |
| Zero Trust | `Applicable` | Remoteverwaltete, account-/providerabhängige Transaktionen erfordern fortlaufende Verifikation. | Remote-/Providergrenze entfällt |
| OWASP SAMM | `Applicable` | Langlebiger Level-0-Workspace und wiederholbare Providerpraxis benötigen Improvement Evidence. | Workspace ist nicht mehr langlebig/operativ |
| BSI C3A | `Applicable` | Providerabhängige SaaS-Settings-, Review-, Usage- und Hostingfläche benötigt Autonomie-Review. | Providerabhängige Cloudfläche entfällt |
| BSI C5 | `Applicable` | GitHub/Copilot/Actions benötigen Assurance- und Shared-Responsibility-Review. | Keine Cloud-Assurance-/Providerbetriebsfläche mehr |
| Regulatory NIS2 | `N/A` | Kein nachgewiesener wesentlicher/wichtiger Dienst oder regulierter Kunde im Feature-Scope. | Regulierte Organisation, Dienst oder Lieferkettenrolle entsteht |
| Regulatory CRA | `N/A` | Das Governance-Feature platziert kein neues digitales Produkt wirtschaftlich auf dem EU-Markt; SBOM/secure delivery bleiben unabhängig anwendbar. | Marktbereitstellung, Kundenübergabe oder wirtschaftliche Distribution entsteht |
| Regulatory EU AI Act | `N/A` | Copilot ist Entwicklungs-/Reviewwerkzeug, keine ausgelieferte oder selbst betriebene KI-Produktkomponente. | KI-Runtime/-Produktkomponente kommt in Scope |
| Regulatory DORA | `N/A` | Kein Finanzunternehmen und kein nachgewiesener DORA-IKT-Drittservice im Scope. | Finanzsektorrolle oder regulierter IKT-Kunde entsteht |

Default-Security-Evidence wird unter `docs/security/` geführt:
`security-checklist.md`, `secure-coding-language-rules.md`,
`dependency-audit.md`, `asvs-verification.md`,
`supply-chain-evidence.md`, `threat-model.md`, `arc42-security.md`,
`zero-trust-applicability.md`, `samm-assessment.md`,
`cloud-autonomy-applicability.md`, `cloud-compliance-assurance.md` und
`regulatory-applicability.md`. Owner ist der Fleet Governance Owner; Reviewer
ist der Security and Compliance Reviewer. Restrisiko sind neue Provider-,
Dependency-, Auth-, Billing- oder Regulatory-Grenzen. Follow-up ist vollständige
Evidence vor der ersten betroffenen Provider-Mutation und erneut vor Closeout.

## Agenten-Parität / Agent Parity Applicability

- **Applicability / Anwendbarkeit**: `Applicable`; die gemeinsame Betriebs-, Authority-, A11Y- und Evidence-Führung muss agentenneutral bleiben.
- **Maintained surfaces / Gepflegte Flächen**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md` werden gemeinsam geprüft und bei einer shared-guidance Änderung atomar aktualisiert.
- **Constitution/templates / Verfassung und Vorlagen**: `constitution.md`, `.specify/memory/constitution.md`, `.specify/templates/` und relevante `scripts/templates/` werden gemeinsam geprüft. Die Spezifikation selbst ändert keinen Verfassungsgrundsatz; ein Update ist daher derzeit `N/A`. Re-Evaluation: Plan/Implementierung ändert shared policy, Runtimeguidance oder Templatevertrag.
- **Project templates / Projektvorlagen**: Sollvertrag, Evidence-/Gate-Schemata und Betriebsdokumentation müssen agenten- und credential-neutral bleiben. Konkrete lokale Modellnamen sind verboten.
- **Intentional deviations / Absichtliche Abweichungen**: Keine. Jede spätere Abweichung benötigt Begründung und Paritätsevidence in derselben Änderung.
- **Evidence / Nachweis**: Agent-Surface-Paritätsvalidator, vollständiger Diff und Documentation-Impact-Evidence. Owner: Fleet Governance Owner; Reviewer: Agent Parity Reviewer.

## Dokumentationsauswirkung / Documentation Impact

- **Decision / Entscheidung**: `UpdateRequired` — die einzige Documentation-Impact-Entscheidung dieses Features.
- **Audiences and reader paths / Zielgruppen und Leserpfade**: Maintainer, Flotten-Operator*innen und Reviewer beginnen bei Zweck, Voraussetzungen, Authority-/Datenschutzgrenze und sicherem Preview. Danach folgen Live-Inventur, Acht-Zielvertrag, Reviewtrigger, External-Write-Gate, Apply/Rollback, Kostenachsen, Fehler-/Refusal-Klassen und Re-Evaluation. Kanonischer Pfad: Lastenheft → Ready-Review → Spezifikation → Plan/Quickstart → Manpage/PowerShell-Hilfe → redigierte Acceptance-/Provider-Evidence → Retrospektive.
- **Canonical source and owner / Kanonische Quelle und Owner**: Level 0 besitzt den Flotten-Sollvertrag, Skript-, Gate-, Evidence- und Betriebsvertrag; Owner ist der Fleet Governance Owner. Provider-Livezustand bleibt externe Laufzeitwahrheit und wird nur frisch/redigiert belegt.
- **Affected documentation families / Betroffene Dokumentfamilien**: README-/Betriebsnavigation, `docs/scripts/`, Unix-Manpage, PowerShell-Hilfe, Architektur, Security, Accessibility, Usage-/Kostenmethodik, Rollback-/Incidentführung, Changelog/Abschlussnotiz und `docs/project-statistics.md` samt Konfiguration.
- **Navigation impact / Navigation**: Der Copilot-Review-Governance-Betrieb muss aus Wartungs-/Skriptnavigation erreichbar sein. Einstiegsseiten zeigen Zweck, Voraussetzungen, Grenzen und genau eine sichere Preview-Aktion vor Details.
- **Document class / Dokumentklasse**: Versionierter source-only Betriebs-, Sicherheits- und Governance-Vertrag mit deterministischen/redigierten maschinenlesbaren Evidence-Artefakten. Schema- und Hashprüfung ersetzt keine semantische Review.
- **Language strategy and partner / Sprachstrategie und Partner**: Deutsch zuerst, Englisch danach, CEFR B2. Kurze Flächen inline bilingual; große normative Seiten nur bei besserer Orientierung mit synchronisiertem `.en.md`-Partner.
- **Platform/example proof / Plattform-/Beispielnachweis**: Bash-`--dry-run` für macOS/Linux, PowerShell-`-WhatIf` für Windows sowie getrennte redigierte Browser-Account-Evidence, falls keine unterstützte Programmierschnittstelle existiert.
- **Distribution class / Distributionsklasse**: Spezifikation, Plan, Dokumentation, Verträge und redigierte versionierte Evidence sind `sourceOnly`; manifestgebundene finale Skripte sind `homeRuntime`; Credentials, Cookies, vollständige Billingbelege, lokale Profile und Rohlogs sind `machineLocal` und nicht zu committen.
- **Home-sync need / Home-Sync-Bedarf**: In Specify `false`. Später nur `true`, wenn der finale akzeptierte Diff tatsächlich manifestgebundene `homeRuntime` ändert, und erst nach Check/Preview, Merge, aktueller Authority und Konfliktprüfung.
- **Evidence / Nachweis**: Diese Spezifikation und `checklists/requirements.md`; später Documentation-Impact-Evidence, aktualisierte Betriebs-, Architektur-, Security-, A11Y-, Skript-, Manpage-, Hilfe-, Statistik- und redigierte Provider-/Usage-Nachweise.
- **Re-evaluation trigger / Re-Evaluation**: Zielgruppe, Zielmenge, Account-/Ruleset-/Billingoberfläche, Authority, Bypass-Scope, Review-/Gatevertrag, Provider, Skriptoberfläche, Zielplattform, Evidence-Schema/-pfad, Dokumentklasse, Distribution, Home Runtime oder Serienposition ändert sich.

## Englische Vertragszusammenfassung / English Contract Summary

The German-first sections and their English counterparts form one binding
specification. `CRG-001` through `CRG-018` and `AC-CRG-001` through
`AC-CRG-010` remain stable and explicitly traceable. The counts `22/6/2/16`
are historical planning values only; CRG-001 recomputes every live fact before
any write, and drift stops the run before mutation.

The target state has exactly eight named automatic-review rulesets, account-
wide automation disabled, at most one automatic Lite review on Ready-open or
first Draft-to-Ready, no draft or push automation, manual review everywhere,
and advisory-only Copilot. AI credits and Actions minutes remain separate.
Every write uses exact-ID before/after/rollback evidence and a current
operation-specific External Write Gate. Repository APIs do not prove a
browser-only personal setting.

The run has `MergeAndSync` authority and a bounded merge-bypass exception only
after a regular protection refusal. Neither grants general provider-admin,
secret, subscription, budget-purchase, cancellation, or Position-7 authority.
This Specify phase writes only its specification, requirements quality
checklist, and routed phase result.
