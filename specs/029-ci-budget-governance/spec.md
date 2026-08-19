# Feature-Spezifikation: Flottenweite CI-Budget-Governance / Feature Specification: Fleet-Wide CI Budget Governance

**Feature Branch**: `029-ci-budget-governance`
**Created / Erstellt**: 2026-08-19
**Status**: Draft / Entwurf
**Input / Eingabe**: Bindendes, mit `Ready` bewertetes Lastenheft `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md`
**Delivery Mode / Liefermodus**: `LocalImplementation` (Stufe A / Stage A)
**Audience / Zielgruppe**: Maintainer, Flotten-Operator*innen, Repository-Verantwortliche und Reviewer
**Prior Knowledge / Vorwissen**: Grundlegende Git-, GitHub-Actions-, Bash- und PowerShell-Kenntnisse; keine Spec-Kit-Erfahrung
**Language and Accessibility / Sprache und Barrierefreiheit**: Deutsch zuerst, Englisch danach; CEFR B2; WCAG 2.2 AA, soweit anwendbar; textorientierte Darstellung

## Nutzungsszenarien und Tests / User Scenarios & Testing *(mandatory)*

### User Story 1 - Flotte eindeutig klassifizieren / Classify the Fleet Unambiguously (Priority: P1)

Als Flotten-Operator*in möchte ich jedes live ermittelte Git-Repository über
seine stabile Registry-ID genau einem freigegebenen CI-Profil zuordnen, damit
Budgetentscheidungen nachvollziehbar sind und Drift nicht stillschweigend zu
einer falschen Klassifikation führt.

*As a fleet operator, I want every live-discovered Git repository to be mapped
by its stable registry ID to exactly one approved CI profile so that budget
decisions remain auditable and drift cannot silently change classification.*

**Why this priority / Warum diese Priorität**: Ohne vollständige und
fail-closed geprüfte Zuordnung sind alle späteren Gate-, Workflow- und
Kostenentscheidungen unsicher.

**Independent Test / Unabhängiger Test**: Eine lokale Stufe-A-Inventur mit
vollständigen, fehlenden, doppelten, unbekannten und
sichtbarkeitsinkompatiblen Fixture-Zuordnungen kann allein ausgeführt werden.
Sie liefert für den gültigen Fall genau eine Zuordnung je Repository und für
jeden Driftfall einen reproduzierbaren Hard Stop.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** Register und read-only Live-Inventur enthalten dieselben stabilen Repository-IDs, **When / Wenn** die Profilklassifikation ausgeführt wird, **Then / Dann** erhält jede Repository-ID genau eines der fünf gültigen Profile und die aktuellen Kardinalitäten werden neu berechnet.
2. **Given / Angenommen** eine ID fehlt, ist unbekannt oder mehrfach zugeordnet, **When / Wenn** die Klassifikation ausgeführt wird, **Then / Dann** stoppt sie fail-closed, nennt den Blocker und fordert ein geprüftes Mapping-Update an, ohne eine Zuordnung zu raten.
3. **Given / Angenommen** ein öffentliches Repository besitzt ein privates Profil oder umgekehrt, **When / Wenn** die Sichtbarkeit geprüft wird, **Then / Dann** stoppt die Verarbeitung reproduzierbar vor jeder weiteren Planung.
4. **Given / Angenommen** die Flottenstruktur weicht vom Snapshot `3/6/6/21/12` vom 19. August 2026 ab, **When / Wenn** die Live-Inventur gültig ist, **Then / Dann** werden die Live-Zahlen berichtet und der alte Snapshot wird nicht als feste Soll-Kardinalität erzwungen.

---

### User Story 2 - Private Änderungen sicher lokal prüfen / Gate Private Changes Safely and Locally (Priority: P1)

Als Maintainer eines privaten Flottenrepositories möchte ich einen einzigen,
plattformgleichen lokalen CI-Gate ausführen und HEAD-gebundene Evidence
erhalten, damit der Pre-push-Hook nur passende erfolgreiche Prüfungen zulässt,
ohne den lokalen Hook als alleinige Sicherheitsgrenze zu behandeln.

*As a maintainer of a private fleet repository, I want one platform-equivalent
local CI gate and HEAD-bound evidence so that the pre-push hook accepts only
matching successful checks without treating the local hook as the sole
security boundary.*

**Why this priority / Warum diese Priorität**: Dieses Szenario senkt private
Runnerkosten und bewahrt zugleich Defense in Depth durch lokalen Nachweis und
einen unabhängigen serverseitigen Minimal-Gate.

**Independent Test / Unabhängiger Test**: Fixtures für HEAD, Gate-Set,
Einzelergebnisse, Hook-Version und Ruleset-Vertrag prüfen gültige, fehlende,
veraltete und fehlgeschlagene Evidence ohne Zugriff auf oder Änderung an einem
Zielrepository.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** alle lokalen Pflichtprüfungen sind erfolgreich, **When / Wenn** der CI-Gate endet, **Then / Dann** entsteht genau ein Nachweis unter dem festgelegten maschinenlokalen Pfad mit allen Pflichtfeldern.
2. **Given / Angenommen** HEAD oder Gate-Set-Hash unterscheidet sich vom Nachweis, **When / Wenn** der Pre-push-Hook prüft, **Then / Dann** blockiert er mit Profil, Status, Blocker und nächster Aktion in stabiler Textreihenfolge.
3. **Given / Angenommen** passende erfolgreiche Evidence liegt vor, **When / Wenn** der Hook prüft, **Then / Dann** lässt er den lokalen Pushpfad zu.
4. **Given / Angenommen** ein lokaler Hook fehlt oder wird umgangen, **When / Wenn** eine Stufe-A-Ruleset-/Workflow-Simulation den Default-Branch-Pfad bewertet, **Then / Dann** verlangt der Vertrag weiterhin Pull Request und genau einen erfolgreichen, schlanken, pfadabhängigen serverseitigen Gate.

---

### User Story 3 - CI-Auslöser und Kosten rationalisieren / Rationalize CI Triggers and Cost (Priority: P2)

Als Repository-Verantwortliche*r möchte ich profil- und pfadgerechte
Workflow-Entscheidungen simulieren, damit notwendige öffentliche CI erhalten
bleibt, private Doppelarbeit entfällt und die geplante private Monatslast
transparent unter dem Budgetziel liegt.

*As a repository owner, I want to simulate profile-aware and path-aware
workflow decisions so that required public CI remains, duplicate private work
is removed, and planned monthly private usage is transparently below target.*

**Why this priority / Warum diese Priorität**: Die Kostensenkung ist der
fachliche Nutzen, darf aber erst auf der sicheren Profil- und Gate-Basis
erfolgen.

**Independent Test / Unabhängiger Test**: Workflow-, Pfad- und
Zeitplan-Fixtures für jedes Profil können lokal simuliert und gegen erwartete
Jobzahlen sowie getrennte Verbrauchskategorien verglichen werden.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** eine private Governance-Lieferung, **When / Wenn** die Stufe-A-Simulation läuft, **Then / Dann** plant sie keinen vollständigen privaten PR-/Main-Build und höchstens einen schlanken verpflichtenden PR-Gate.
2. **Given / Angenommen** Änderungen an allen sechs SecureCaseTracker-Sprachrepositories, **When / Wenn** die Pfadverträge ausgewertet werden, **Then / Dann** werden höchstens sechs passende Produktjobs geplant.
3. **Given / Angenommen** ein Swift-PR und die planmäßigen Plattformnachweise, **When / Wenn** die Auslöser simuliert werden, **Then / Dann** läuft der Pflicht-PR-Nachweis unter Linux und der macOS-Nachweis nur wöchentlich oder manuell.
4. **Given / Angenommen** private Release-Please-Konfiguration, **When / Wenn** Auslöser geprüft werden, **Then / Dann** sind nur wöchentliche und manuelle Läufe vorgesehen.
5. **Given / Angenommen** öffentliche Produkt-, Canary- und Preset-Profile, **When / Wenn** die geplanten Diffs erzeugt werden, **Then / Dann** bleiben notwendige öffentliche CI und die drei Canaries erhalten, während keine neuen Einzelworkflows für die zwölf Public-Preset-Repositories entstehen.

---

### User Story 4 - Rollout ohne Eigenmutation vorbereiten / Prepare Rollout Without Self-Mutation (Priority: P2)

Als Reviewer möchte ich für jedes live ermittelte Zielrepository einen
deterministischen geplanten Diff, die Gate-Entscheidung und mögliche Blocker
sehen, damit Stufe A vollständig prüfbar ist, ohne Stufe B oder Remote-
Konvergenz vorzutäuschen.

*As a reviewer, I want a deterministic planned diff, gate decision, and any
blockers for every live-discovered target repository so that Stage A is fully
reviewable without pretending that Stage B or remote convergence occurred.*

**Why this priority / Warum diese Priorität**: Die Trennung der Lieferstufen
ist die verbindliche Autoritäts- und Sicherheitsgrenze dieses Features.

**Independent Test / Unabhängiger Test**: Null-, Einzel- und
Mehrfachrepository-Fixtures erzeugen wiederholt dieselben geordneten
Entscheidungen und Exitcodes; eine Schreibbarriere weist nach, dass kein
Zielrepository, kein GitHub-Ruleset und keine Account-Einstellung verändert
wird.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** null, ein oder mehrere gültige Ziele, **When / Wenn** die Stufe-A-Rolloutplanung wiederholt wird, **Then / Dann** bleiben Reihenfolge, Profil, Diff, Gate-Entscheidung, Blocker und Exitcode für identische Eingaben deterministisch.
2. **Given / Angenommen** 47 Zielrepositories in der späteren Rolloutmenge, **When / Wenn** Stufe A abgeschlossen wird, **Then / Dann** existiert für jedes live ermittelte Ziel lokale Planungsevidence, aber kein Zielrepository wurde geändert.
3. **Given / Angenommen** eine Operation würde Commit, Push, Merge, Home-Sync, GitHub-Schreibzugriff, Ruleset-/Accountänderung oder G4-Start erfordern, **When / Wenn** sie in Stufe A angefordert wird, **Then / Dann** stoppt der Lauf und nennt die fehlende separate Autorität.

---

### User Story 5 - Plattformgleich und barrierearm arbeiten / Work with Platform Parity and Accessibility (Priority: P2)

Als Nutzer*in unter macOS, Linux oder Windows möchte ich dieselben Profile,
Entscheidungen, Evidence-Felder, Exitcodes und verständlichen Textausgaben
erhalten, damit Plattform und assistive Technologie die fachliche Aussage
nicht verändern.

*As a user on macOS, Linux, or Windows, I want the same profiles, decisions,
evidence fields, exit codes, and understandable text output so that platform
and assistive technology do not change the result.*

**Why this priority / Warum diese Priorität**: Plattform- und A11Y-Parität sind
verbindliche Qualitätsmerkmale des Repositorys und Teil der Abnahme.

**Independent Test / Unabhängiger Test**: Gemeinsame Fixtures werden über die
Bash- und PowerShell-Oberflächen sowie über textorientierte A11Y-Prüfungen
ausgewertet; normalisierte Ergebnisse müssen übereinstimmen.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** dieselben Fixture-Eingaben, **When / Wenn** Bash `--ci-gate` und PowerShell `-CiGate` laufen, **Then / Dann** stimmen fachliche Entscheidungen, Evidence-Felder und Exitcodes überein.
2. **Given / Angenommen** `--dry-run` oder `-WhatIf`, **When / Wenn** der neue Gate-Pfad aufgerufen wird, **Then / Dann** werden geplante Auswahl, Prüfungen und Evidence-Ziele angezeigt, aber keine Evidence geschrieben und keine Mutation ausgeführt.
3. **Given / Angenommen** Farbe, Unicode-Symbole oder räumliche Anordnung fehlen, **When / Wenn** Ausgabe und Dokumentation gelesen werden, **Then / Dann** bleiben Profil, Entscheidung, Status, Blocker und nächste Aktion vollständig verständlich.

---

### User Story 6 - Dokumentation und Verbrauch nachvollziehen / Understand Documentation and Consumption (Priority: P3)

Als Maintainer oder Reviewer möchte ich eine deutsch-zuerst/englisch-danach
geführte Bedien-, Architektur-, Sicherheits-, A11Y- und Kostenbeschreibung
erhalten, damit Betrieb, Fehlerbehebung, Re-Evaluation und der spätere
Stufe-B-Handoff ohne implizites Wissen prüfbar sind.

*As a maintainer or reviewer, I want German-first/English-second usage,
architecture, security, accessibility, and cost guidance so that operation,
troubleshooting, re-evaluation, and the later Stage B handoff are reviewable
without implicit knowledge.*

**Why this priority / Warum diese Priorität**: Dokumentation und Statistik
machen den langfristigen Governance-Vertrag nutzbar und verhindern die
Vermischung von Actions-Minuten und Copilot-Verbrauch.

**Independent Test / Unabhängiger Test**: Dokumentations-, A11Y-, Statistik-
und Verbrauchsfixtures können ohne Remote-Schreibzugriff auf Vollständigkeit,
Sprachparität und getrennte Kategorien geprüft werden.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** die geplanten privaten Jobs und Laufzeiten, **When / Wenn** das Kostenmodell berechnet wird, **Then / Dann** zeigt es wiederkehrende Grundlast, bedarfsabhängige Minimal-Gates und Copilot-Review-Runnerzeiten getrennt.
2. **Given / Angenommen** eine Fehler- oder Driftlage, **When / Wenn** eine Person die Dokumentation nutzt, **Then / Dann** findet sie Zweck, Voraussetzungen, Sicherheitsgrenze, Fehlerursache, nächste sichere Aktion und Re-Evaluation ohne vorausgesetzte Spec-Kit-Erfahrung.
3. **Given / Angenommen** die Implementierungsphase ist abgeschlossen, **When / Wenn** die Dokumentationsauswirkung geprüft wird, **Then / Dann** sind die betroffenen Sprachpartner, Manpage, PowerShell-Hilfe, Architektur-, Security-, A11Y-, Statistik- und Betriebsnachweise synchron aktualisiert.

### Randfälle / Edge Cases

- Der Registry-Knoten ist eine logische Collection und kein Git-Repository; er darf die Repository-Zahl nicht erhöhen.
- Ein Repository ist live vorhanden, aber nicht im Mapping; die Klassifikation stoppt, statt ein Profil abzuleiten.
- Eine gemappte ID fehlt live oder erscheint mehrfach; der Lauf meldet die genaue Drift und stoppt vor Kosten- oder Rolloutplanung.
- Sichtbarkeit oder Default-Branch ändern sich zwischen Inventur und Evidence-Erzeugung; die Evidence wird als veraltet behandelt und muss gegen einen aktuellen Snapshot neu erzeugt werden.
- Der HEAD ändert sich während eines Gate-Laufs; für den alten HEAD darf kein gültiger Nachweis entstehen.
- Das Gate-Set ändert sich bei gleichem HEAD; der alte Gate-Set-Hash macht die Evidence ungültig.
- Ein Einzelgate wird übersprungen, fehlt oder schlägt fehl; der Gesamtnachweis ist nicht erfolgreich.
- Der Evidence-Pfad existiert nicht oder ist nicht sicher beschreibbar; der Gate-Lauf stoppt ohne unvollständige Erfolgsdatei.
- Repository-ID, Pfad oder Git-Ausgabe enthält Leerzeichen, führende Bindestriche, Zeilenumbrüche oder Shell-Metazeichen; Eingaben werden validiert und niemals mittels `eval` oder dynamischer Ausführung interpretiert.
- Eine Workflow-Änderung berührt Build-, Security-, Governance- oder Abhängigkeitsflächen gleichzeitig; alle zugehörigen Pfadverträge müssen auslösen.
- Eine reine Dokumentationsänderung außerhalb verbindlicher Pfade darf keinen Produktbuild erzwingen, sofern kein Security-/Governance-Vertrag betroffen ist.
- Eine private Produktänderung hat einen eigenständigen fachlichen Main-Nachweis; nur dann darf ein zusätzlicher Main-Job geplant werden und die Begründung muss sichtbar sein.
- Ein macOS- oder Release-Please-Zeitplan kollidiert mit manueller Auslösung; beide zulässigen Auslöser werden einmalig, nicht doppelt gezählt.
- Die Live-Kardinalitäten weichen deutlich vom Planungssnapshot ab; das Kostenmodell verwendet die Live-Zahlen und erklärt die Abweichung.
- GitHub-Livezustand ist read-only nicht verfügbar; die Inventur stoppt als unbelegt und verwendet keine veralteten Zahlen als aktuelle Evidence.
- Copilot-Runnerdaten fehlen; die Kategorie bleibt als eigener, nicht mit Actions-Minuten vermischter Blocker sichtbar und löst keine G4-Konfiguration aus.
- Null Ziele liefern einen definierten erfolgreichen oder blockierenden Exitcode gemäß Eingabevertrag, ohne leere Erfolgsbehauptung; Einzel- und Mehrfachläufe bleiben geordnet.
- Ein lokaler Hook ist aktuell, aber die serverseitige Fixture-Regel fehlt; die Sicherheitsabnahme schlägt fehl.
- Ein serverseitiger Minimal-Gate ist vorhanden, aber zu breit oder nicht pfadabhängig; Kosten- und Sicherheitsabnahme schlagen fehl.
- Stufe-A-Evidence darf nicht als Nachweis einer remote konvergierten Flotte bezeichnet werden.

## Anforderungen / Requirements *(mandatory)*

### Funktionale Anforderungen / Functional Requirements

- **CBG-001 (FR-001) – Live-Inventur / Live Inventory**: Die Stufe-A-Lösung MUSS Repository, Sichtbarkeit, Default-Branch, Workflow-Auslöser, Runner, durchschnittliche Dauer und geplante Läufe aus Flottenregister und aktuellem read-only GitHub-Livezustand neu ermitteln. Fällt der aktuelle Zustand aus, MUSS sie fail-closed stoppen und DARF veraltete Daten nicht als Live-Evidence ausgeben.
  *The Stage A solution MUST re-discover repository, visibility, default branch, workflow triggers, runners, average duration, and planned runs from the fleet registry and current read-only GitHub state. If current state is unavailable, it MUST stop fail-closed and MUST NOT label stale data as live evidence.*
- **CBG-002 (FR-002) – Profilvertrag und Drift / Profile Contract and Drift**: Eine versionierte Level-0-Zuordnung MUSS jede stabile Registry-ID genau an eines der Profile `Public Canary`, `Public Product`, `Private Product`, `Private Governance/Scaffold` oder `Public Preset` binden. Die ersten, zweiten und fünften Profile verlangen öffentliche, die dritten und vierten private Sichtbarkeit. Unbekannte, fehlende, doppelte oder sichtbarkeitswidrige Zuordnungen MÜSSEN vor weiterer Planung stoppen und ein geprüftes Mapping-Update verlangen; automatische Umklassifizierung ist verboten. Live-Kardinalitäten MÜSSEN neu berechnet werden.
  *A versioned Level 0 mapping MUST bind every stable registry ID to exactly one of the five named profiles with the declared visibility compatibility. Unknown, missing, duplicate, or incompatible mappings MUST stop before further planning and require a reviewed mapping update; automatic reclassification is forbidden. Cardinalities MUST be recomputed live.*
- **CBG-003 (FR-003) – Private Governance / Private Governance**: Für `Private Governance/Scaffold` DÜRFEN keine automatischen vollständigen PR- oder Main-Builds geplant werden. Vollständige Pflichtprüfungen MÜSSEN lokal fail-closed laufen. Genau ein schlanker, pfadabhängiger und später ruleset-verpflichtender serverseitiger PR-Gate MUSS als unabhängige Sicherheitsgrenze in kanonischen Stufe-A-Templates und Fixtures nachgewiesen werden.
  *Private Governance/Scaffold profiles MUST have no automatic full PR or main builds. Full mandatory checks MUST run locally and fail closed. Canonical Stage A templates and fixtures MUST prove exactly one lean, path-aware, later ruleset-required server-side PR gate as an independent security boundary.*
- **CBG-004 (FR-004) – Private Products / Private Products**: Private Produkt-Repositories MÜSSEN pfadabhängige PR-Prüfungen erhalten. Derselbe Build DARF nach einem Merge nicht ohne getrennt dokumentierten fachlichen Zweck auf `main` wiederholt werden.
  *Private product repositories MUST receive path-aware PR checks. The same build MUST NOT be repeated on main after merge without a separately documented business purpose.*
- **CBG-005 (FR-005) – CaseTracker / CaseTracker**: Eine simulierte Änderung an allen sechs SecureCaseTracker-Sprachrepositories DARF höchstens sechs passende Produktjobs planen.
  *A simulated change across all six SecureCaseTracker language repositories MUST plan no more than six matching product jobs.*
- **CBG-006 (FR-006) – Swift / Swift**: Der verpflichtende Swift-PR-Nachweis MUSS Linux verwenden; ein macOS-Nachweis DARF nur wöchentlich oder manuell als getrennter Plattformnachweis geplant werden.
  *Mandatory Swift PR verification MUST use Linux; macOS verification MUST be planned only weekly or manually as separate platform evidence.*
- **CBG-007 (FR-007) – Release Please / Release Please**: Private Release-Please-Läufe DÜRFEN nur wöchentlich und manuell ausgelöst werden.
  *Private Release Please runs MUST be triggered only weekly and manually.*
- **CBG-008 (FR-008) – Öffentliche CI / Public CI**: Erforderliche Standard-Runner-CI in öffentlichen Repositories MUSS erhalten bleiben. `home-baseline`, `AgentOperationsCockpit` und `TuiVision` MÜSSEN die drei Canaries bilden.
  *Required standard-runner CI in public repositories MUST remain. `home-baseline`, `AgentOperationsCockpit`, and `TuiVision` MUST be the three canaries.*
- **CBG-009 (FR-009) – Public Presets / Public Presets**: Für die zwölf öffentlichen Preset-Repositories DÜRFEN in diesem Feature keine neuen repositoriespezifischen Actions-Workflows geplant werden; Veröffentlichung und Validierung MÜSSEN über die kanonische Flottenpipeline oder lokale Evidence nachweisbar bleiben.
  *This feature MUST NOT plan new repository-specific Actions workflows for the twelve public preset repositories; publication and validation MUST remain provable through the canonical fleet pipeline or local evidence.*
- **CBG-010 (FR-010) – Ein-Kommando-Gate / One-Command Gate**: Das bestehende Wartungswerkzeug MUSS funktional gleichwertige Aufrufe `--ci-gate` in Bash und `-CiGate` in PowerShell bereitstellen. Die bestehende Cmdlet-Oberfläche `Invoke-HBAgenticWorkspaceMaintenance` MUSS den genehmigten `Verb-Noun`-Vertrag bewahren.
  *The existing maintenance tool MUST provide functionally equivalent Bash `--ci-gate` and PowerShell `-CiGate` calls. The existing `Invoke-HBAgenticWorkspaceMaintenance` cmdlet surface MUST preserve the approved Verb-Noun contract.*
- **CBG-011 (FR-011) – Evidence-Pfad / Evidence Path**: Nur erfolgreiche lokale Gates DÜRFEN einen maschinenlokalen Nachweis unter `~/.home-baseline/evidence/ci-gates/<repo-id>/<head-commit>.json` veröffentlichen. Ein fehlgeschlagener oder abgebrochener Lauf DARF keine erfolgreiche Restdatei hinterlassen.
  *Only successful local gates MAY publish machine-local evidence at the declared path. A failed or interrupted run MUST NOT leave a successful partial file.*
- **CBG-012 (FR-012) – Evidence-Inhalt / Evidence Content**: Jeder Nachweis MUSS mindestens Schema-Version, Repository-ID, HEAD-Commit, CI-Profil, Gate-Set-Hash, Plattform, Zeitstempel und geordnete Einzelergebnisse enthalten. Secrets, Tokens, private Abrechnungsdetails und unnötige personenbezogene Daten sind verboten.
  *Each record MUST contain at least schema version, repository ID, HEAD commit, CI profile, gate-set hash, platform, timestamp, and ordered individual results. Secrets, tokens, private billing details, and unnecessary personal data are forbidden.*
- **CBG-013 (FR-013) – Evidence-Gültigkeit / Evidence Validity**: Ein anderer HEAD, ein anderer Gate-Set-Hash, ein fehlender oder fehlgeschlagener Einzelgate oder fehlende Evidence MUSS den Nachweis ungültig machen.
  *A different HEAD, different gate-set hash, missing or failed individual gate, or missing evidence MUST invalidate the record.*
- **CBG-014 (FR-014) – Pre-push / Pre-push**: Der gemeinsame Pre-push-Hook MUSS in privaten Flottenrepositories passende erfolgreiche Evidence verlangen und bei fehlender, veralteter oder fehlgeschlagener Evidence blockieren. Installation und Versionsfrische des Hooks MÜSSEN prüfbar sein. Hook-Umgehung DARF die unabhängige PR- und Statuspflicht des serverseitigen Gate-Vertrags nicht aufheben.
  *The shared pre-push hook MUST require matching successful evidence in private fleet repositories and block missing, stale, or failed evidence. Hook installation and freshness MUST be verifiable. Hook bypass MUST NOT remove the independent PR and status requirement of the server-side gate contract.*
- **CBG-015 (FR-015) – Prozessgrenze / Process Boundary**: Pfadfilter MÜSSEN als versionierter, getesteter Prozessvertrag behandelt werden. Änderungen an Build-, Security-, Governance- oder Abhängigkeitsflächen MÜSSEN die jeweils zugeordneten Produkt- oder Minimal-Gates auslösen.
  *Path filters MUST be treated as a versioned, tested process contract. Changes to build, security, governance, or dependency surfaces MUST trigger their assigned product or minimal gates.*
- **CBG-016 (FR-016) – Copilot-Abgrenzung / Copilot Boundary**: GitHub-Copilot-Code-Review-Runnerzeiten MÜSSEN als eigene Verbrauchskategorie ausgewiesen und DÜRFEN weder mit privaten Actions-Minuten vermischt noch zur Änderung der Reviewer-Konfiguration verwendet werden. Reviewer-Konfiguration bleibt ausschließlich G4.
  *GitHub Copilot code-review runner time MUST be reported as a separate consumption category and MUST NOT be mixed with private Actions minutes or used to change reviewer configuration. Reviewer configuration remains exclusively G4.*
- **CBG-017 (FR-017) – Plattformparität / Platform Parity**: Bash und PowerShell MÜSSEN für identische Eingaben dieselben Profile, Entscheidungen, Evidence-Felder, Exitcodes und semantisch gleichen A11Y-tauglichen Textausgaben liefern. macOS, Linux und Windows sind Zielplattformen.
  *Bash and PowerShell MUST produce the same profiles, decisions, evidence fields, exit codes, and semantically equivalent accessible text output for identical inputs. macOS, Linux, and Windows are target platforms.*
- **CBG-018 (FR-018) – Sicherheitsgrenze / Security Boundary**: Kostenoptimierung DARF Secret-Scanning, Branch-Schutz, Mutation Barriers, Reviewpflichten oder sonstige Gates nicht abschwächen. Kanonische Ruleset-Anforderungen für private Governance-/Scaffold-Repositories MÜSSEN Pull Request und erfolgreichen Minimal-Gate vor jeder Default-Branch-Änderung verlangen und direkte, Web- oder API-Schreibpfade sperren. Admin-Bypass ist weder Voraussetzung noch normaler Lieferpfad.
  *Cost optimization MUST NOT weaken secret scanning, branch protection, mutation barriers, review obligations, or other gates. Canonical ruleset requirements for private governance/scaffold repositories MUST require a pull request and successful minimal gate before every default-branch change and block direct, web, or API write paths. Admin bypass is neither a prerequisite nor a normal delivery path.*
- **CBG-019 (FR-019) – Keine Eigenmutation / No Self-Mutation**: Das Wartungswerkzeug MUSS genau einen Engine-Prozess starten und DARF kein Zielrepository committen oder pushen. Für Stufe A sind außerdem Merge, Home-Sync, GitHub-Schreibzugriff, Ruleset-/Accountmutation und G4-Start verboten.
  *The maintenance tool MUST start exactly one engine process and MUST NOT commit or push any target repository. Stage A also forbids merge, Home sync, GitHub writes, ruleset/account mutation, and starting G4.*
- **CBG-020 (FR-020) – Dokumentation / Documentation**: Documentation Impact MUSS `UpdateRequired` sein. Bedienung, Profile, Evidence, Fehlerfälle, Security-/A11Y-Grenzen, Home-Runtime-Verteilung, Plattformbeispiele, Kostenmessung und Re-Evaluation MÜSSEN deutsch zuerst und englisch danach dokumentiert werden.
  *Documentation Impact MUST be `UpdateRequired`. Usage, profiles, evidence, failures, security/accessibility boundaries, Home Runtime distribution, platform examples, cost measurement, and re-evaluation MUST be documented German-first and English-second.*
- **CBG-021 (FR-021) – Lieferstufen / Delivery Stages**: Stufe A unter `LocalImplementation` DARF ausschließlich Level-0-eigene kanonische Profile, lokale Gates, HEAD-/Gate-Set-Evidence, Hook-Logik, Workflow-/Ruleset-Templates, Simulationen, Tests, Statistik, bilinguale Dokumentation und deterministische Rollout-Evidence ändern. Änderung oder Konvergenz der 47 Zielrepositories ist Stufe B und verlangt neue ausdrückliche Autorität.
  *Stage A under `LocalImplementation` MAY change only Level-0-owned canonical profiles, local gates, HEAD/gate-set evidence, hook logic, workflow/ruleset templates, simulations, tests, statistics, bilingual documentation, and deterministic rollout evidence. Mutation or convergence of the 47 target repositories is Stage B and requires new explicit authority.*

### Verfassungsanforderungen / Constitution Requirements *(mandatory)*

- **CR-001 – Level-Kontext / Level Context**: Dieses Feature ist Level-0-Arbeit und zielt nicht auf ein einzelnes Level-2-Projekt. Das Level-2 Project Environment Registry ist daher für die Implementierungslaufzeit `N/A`; seine Repository-IDs und Plattformangaben bleiben jedoch Eingaben der Flottenplanung. Re-Evaluation: sobald Stufe B ein konkretes Level-2-Ziel ändern darf.
- **CR-002 – A11Y**: CLI-Ausgaben, Fehlertexte, Dokumentation, generierte Workflow-/Ruleset-Templates und Kostenberichte MÜSSEN text-first bleiben und WCAG 2.2 AA berücksichtigen, soweit Kriterien anwendbar sind. Status, Abhängigkeit, Entscheidung, Blocker und nächste Aktion DÜRFEN nicht nur durch Farbe, Diagramm oder Position vermittelt werden.
- **CR-003 – Sprache und Lernzugang / Language and Learning Access**: Nutzerseitige Inhalte MÜSSEN Deutsch zuerst und Englisch danach bei ungefähr CEFR B2 liefern, Fachbegriffe beim ersten Gebrauch erklären und keine Spec-Kit-Erfahrung voraussetzen. Überschriften verwenden `DE / EN`, sofern kein Eigenname vorliegt.
- **CR-004 – Statistik und Agentenflächen / Statistics and Agent Surfaces**: `docs/project-statistics.md` und seine kanonische Konfiguration MÜSSEN nach der abgeschlossenen Implementierungsphase gemäß Statistikvertrag aktualisiert werden. Agentenflächen unterliegen der Paritätsprüfung in der Governance-Tabelle; eine Änderung gemeinsamer Betriebsführung MUSS alle dort genannten Flächen gemeinsam aktualisieren.
- **CR-005 – Sprachen und Speichersicherheit / Languages and Memory Safety**: Die primären gleichwertigen Skriptsprachen sind Bash für macOS/Linux und PowerShell 7+ auf der speichersicheren .NET-Laufzeit für Windows. Bash steht nicht auf der MSL-Allowlist; seine Nutzung ist durch die bestehende native Unix-Skriptoberfläche und den Paritätsvertrag begründet. Bash-Eingaben MÜSSEN validiert und gequotet werden, `eval` ist verboten, und externe Aufrufe MÜSSEN den End-of-Options-Vertrag verwenden. PowerShell MUSS Strict Mode, validierte Parameter und sichere Prozessaufrufe verwenden.
- **CR-006 – Sicherheitsstandards / Security Standards**: Die untenstehende Standardsmatrix ist bindend. `NIST SSDF`, `CWE Top 25`, `SBOM`, `VEX`, `SLSA`, `CAPEC`, `Zero Trust`, `OWASP SAMM` und `OpenSSF Scorecard` sind für die betroffenen Produktions-, CI-, Vertrauensgrenzen- oder Distributionsflächen `Applicable`; nicht anwendbare Standards sind ausdrücklich begründet.
- **CR-007 – ASVS**: `OWASP ASVS` ist `N/A`, weil Stufe A keinen Web-, API-, HTTP- oder Authentifizierungsdienst erzeugt oder ändert. Re-Evaluation: sobald eine solche Laufzeitoberfläche in Scope kommt.
- **CR-008 – Supply Chain**: Distributable Skripte, Hooks und CI-/Ruleset-Templates MÜSSEN in `docs/security/supply-chain-evidence.md` mit SBOM-/VEX-Entscheidung sowie Provenance-/SLSA-Ziel dokumentiert werden. Neue Abhängigkeiten sind nicht vorausgesetzt und müssten vor Aufnahme geprüft werden.
- **CR-009 – KI-Klassifikation / AI Classification**: KI wird ausschließlich als Entwicklungswerkzeug verwendet und ist keine veröffentlichte oder betriebene Runtime-/Produktkomponente. `AI-SBOM` ist deshalb `N/A`. Re-Evaluation: sobald Modell, KI-Dienst, Dataset, Inferenzinfrastruktur oder KI-Runtime ausgeliefert oder betrieben wird.
- **CR-010 – Vertrauensgrenzen / Trust Boundaries**: Lokaler Arbeitsbaum, Git-Metadaten, Registry-/Live-Daten, maschinenlokale Evidence, Pre-push-Hook und der unabhängig simulierte serverseitige PR-Gate bilden geänderte Vertrauensgrenzen. STRIDE+CIA, relevante CAPEC-Muster und Zero-Trust-Prinzipien MÜSSEN in den vorgesehenen Security-/Architektur-Nachweisen bewertet werden.
- **CR-011 – Security Evidence**: Verwendet werden mindestens `docs/security/threat-model.md`, `docs/security/arc42-security.md`, `docs/security/security-checklist.md`, `docs/security/security-quality-scenarios.md`, `docs/security/dependency-audit.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md` und eine Security-ADR unter `docs/security/adr/`. `docs/security/asvs-verification.md` erhält nur dann eine semantische Aktualisierung, wenn die dokumentierte N/A-Entscheidung sonst veraltet wäre.
- **CR-012 – Governance Presets**: Anwendbar ist die installierte Acht-Preset-Matrix: Security, Architecture, iSAQB Architecture, A11Y, Cross-Platform, Agent Parity, Autonomous Run und Parallel Autonomous Run Governance. Model Routing und Intake Governance bleiben operative Zusatzpresets; konkrete Provider- oder Modellnamen sind keine Feature-Anforderung.
- **CR-013 – Documentation Impact**: Die einzige Entscheidung ist `UpdateRequired`; der vollständige Vertrag steht im Abschnitt Dokumentationsauswirkung.

### Schlüsseldaten / Key Entities

- **Repository-Inventareintrag / Repository Inventory Entry**: Stabile Registry-ID, Repository-Pfad/Remote-Identität, Sichtbarkeit, Default-Branch, aktuelle Workflow-Auslöser, Runner, beobachtete durchschnittliche Dauer, geplante Läufe und Zeitpunkt/Quelle der Live-Prüfung. Ein Collection-Knoten ist kein Eintrag dieser Entität.
- **CI-Profilzuordnung / CI Profile Assignment**: Versionierte Eins-zu-eins-Beziehung zwischen stabiler Registry-ID und einem der fünf Profile einschließlich erwarteter Sichtbarkeit und aktuell berechneter Kardinalität.
- **Gate-Set / Gate Set**: Geordnete, versionierte Menge der für Profil und geänderte Pfade erforderlichen lokalen Prüfungen. Ihre normalisierte Darstellung bestimmt den Gate-Set-Hash.
- **CI-Gate-Evidence / CI Gate Evidence**: Maschinenlokaler, schema-versionierter Nachweis für genau eine Repository-ID, einen HEAD und einen Gate-Set-Hash mit Plattform, Zeitstempel und geordneten Einzelergebnissen.
- **Pfadvertrag / Path Contract**: Versionierte Zuordnung relevanter Build-, Security-, Governance-, Abhängigkeits- und Produktpfade zu den auszulösenden Jobs oder Minimal-Gates.
- **Workflow-/Ruleset-Vertrag / Workflow and Ruleset Contract**: Kanonische Level-0-Anforderung für Trigger, Zeitpläne, Pull-Request-Pflicht, Statuspflicht und gesperrte Default-Branch-Schreibpfade; in Stufe A nur Template und Fixture, keine aktive GitHub-Konfiguration.
- **Kostenmodell / Cost Model**: Getrennte Projektion wiederkehrender privater Jobs, bedarfsabhängiger Minimal-Gates, geschätzter privater Actions-Minuten und Copilot-Review-Runnerverbrauch mit Annahmen und Abweichungsbegründung.
- **Rollout-Planungseintrag / Rollout Plan Entry**: Deterministische Stufe-A-Aussage je live ermittelter Repository-ID mit Profil, geplantem Diff, Gate-Entscheidung, Blocker und Hinweis, dass keine Remote-Konvergenz erfolgt ist.

## Erfolgskriterien / Success Criteria *(mandatory)*

### Messbare Ergebnisse / Measurable Outcomes

- **AC-CBG-001**: 100 % der live ermittelten Git-Repositories sind über ihre stabile Registry-ID genau einem sichtbarkeitskompatiblen Profil zugeordnet; Collection-Knoten zählen nicht. Jede ungeklärte fehlende, unbekannte, doppelte oder inkompatible Zuordnung erzeugt in 100 % der Negativfixtures denselben Hard Stop statt einer stillen Umklassifizierung.
  *100% of live-discovered Git repositories are mapped by stable registry ID to exactly one visibility-compatible profile; collection nodes do not count. Every unresolved mapping drift produces the same hard stop in all negative fixtures instead of silent reclassification.*
- **AC-CBG-002**: Eine typische private Governance-Lieferung plant in der Stufe-A-Simulation 0 vollständige private PR-/Main-Builds und höchstens 1 schlanken verpflichtenden PR-Gate. Lokale Evidence und unabhängiger serverseitiger Gate sind beide als spätere Liefergrenze nachgewiesen.
  *A typical private governance delivery plans zero full private PR/main builds and at most one lean required PR gate, with both local evidence and the independent server gate proven as the later delivery boundary.*
- **AC-CBG-003**: Eine simulierte Änderung an allen sechs CaseTracker-Produkten plant höchstens 6 pfadgerechte PR-Jobs.
  *A simulated change across all six CaseTracker products plans at most six path-appropriate PR jobs.*
- **AC-CBG-004**: Das Stufe-A-Kostenmodell weist ungefähr 22 wiederkehrende private Jobs pro Woche aus, führt bedarfsabhängige Minimal-Gates separat und erklärt jede Abweichung vom Planungswert.
  *The Stage A cost model reports about 22 recurring private jobs per week, lists demand-driven minimal gates separately, and explains every deviation from the planning value.*
- **AC-CBG-005**: Die geplante private Monatslast liegt unter 500 von 3.000 Actions-Minuten; Copilot-AI-Credits und Copilot-Review-Runnerzeiten werden nicht in diesen Wert eingerechnet.
  *Planned private monthly usage remains below 500 of 3,000 Actions minutes; Copilot AI credits and review runner time are not included in that figure.*
- **AC-CBG-006**: Null-, Einzel- und Mehrfachrepository-Fixtures liefern bei identischen Eingaben in wiederholten Läufen identische geordnete fachliche Ergebnisse und passende Exitcodes. Zulässige Zeitstempelvariation verändert keine Entscheidung oder Hash-Bindung.
  *Zero-, single-, and multi-repository fixtures produce identical ordered business results and matching exit codes for identical inputs across repeated runs. Permitted timestamp variation does not change decisions or hash binding.*
- **AC-CBG-007**: 100 % der Hook-Negativfixtures mit fehlender, veralteter oder fehlgeschlagener Evidence blockieren; passende Evidence lässt den lokalen Pfad zu. Ruleset-/Workflow-Fixtures blockieren in 100 % der Fälle einen ungeprüften Default-Branch-Schreibpfad bei fehlendem oder umgangenem lokalen Hook.
  *All hook fixtures with missing, stale, or failed evidence block; matching evidence allows the local path. Ruleset/workflow fixtures block every unchecked default-branch write path when the local hook is absent or bypassed.*
- **AC-CBG-008**: Bash-/PowerShell-Parität, bestehende Wartungsregressionen, A11Y-, Secret-Scan-, Workflow-, Dokumentations- und betroffene Validatorprüfungen sind grün; kein Plattformfixture weist einen abweichenden fachlichen Ausgang auf.
  *Bash/PowerShell parity, existing maintenance regressions, accessibility, secret-scan, workflow, documentation, and affected validator checks pass, with no platform fixture producing a different business outcome.*
- **AC-CBG-009**: Der Stufe-A-Diff enthält 0 Änderungen an Copilot-Reviewer-Konfigurationen, G4-Zuständen, GitHub-Account-Einstellungen und aktiven Rulesets; G4 wurde nicht gestartet.
  *The Stage A diff contains zero changes to Copilot reviewer configuration, G4 state, GitHub account settings, or active rulesets, and G4 was not started.*
- **AC-CBG-010**: 100 % der live ermittelten Zielrepositories besitzen einen deterministischen lokalen Planungseintrag mit Profil, geplantem Diff, Gate-Entscheidung und Rollout-Blocker. Stufe A ändert ausschließlich versionierte Level-0-Artefakte und behauptet für 0 Zielrepositories eine remote ausgerollte Konvergenz.
  *Every live-discovered target repository has a deterministic local planning entry with profile, planned diff, gate decision, and rollout blocker. Stage A changes only versioned Level 0 artifacts and claims remote convergence for zero targets.*

### Rückverfolgbarkeit der Anforderungen / Requirement Traceability

| Intake-ID | Primäre Story / Primary Story | Abnahme / Acceptance |
|---|---|---|
| `CBG-001` | Story 1 | `AC-CBG-001`, `AC-CBG-010` |
| `CBG-002` | Story 1 | `AC-CBG-001`, `AC-CBG-010` |
| `CBG-003` | Story 2 | `AC-CBG-002`, `AC-CBG-007` |
| `CBG-004` | Story 3 | `AC-CBG-004`, `AC-CBG-005` |
| `CBG-005` | Story 3 | `AC-CBG-003` |
| `CBG-006` | Story 3 | `AC-CBG-004`, `AC-CBG-008` |
| `CBG-007` | Story 3 | `AC-CBG-004`, `AC-CBG-005` |
| `CBG-008` | Story 3 | `AC-CBG-008`, `AC-CBG-010` |
| `CBG-009` | Story 3 | `AC-CBG-008`, `AC-CBG-010` |
| `CBG-010` | Story 2, Story 5 | `AC-CBG-006`, `AC-CBG-008` |
| `CBG-011` | Story 2 | `AC-CBG-006`, `AC-CBG-007` |
| `CBG-012` | Story 2 | `AC-CBG-006`, `AC-CBG-007` |
| `CBG-013` | Story 2 | `AC-CBG-007` |
| `CBG-014` | Story 2 | `AC-CBG-007`, `AC-CBG-008` |
| `CBG-015` | Story 3 | `AC-CBG-002`, `AC-CBG-003`, `AC-CBG-008` |
| `CBG-016` | Story 6 | `AC-CBG-004`, `AC-CBG-005`, `AC-CBG-009` |
| `CBG-017` | Story 5 | `AC-CBG-006`, `AC-CBG-008` |
| `CBG-018` | Story 2 | `AC-CBG-002`, `AC-CBG-007`, `AC-CBG-009` |
| `CBG-019` | Story 4 | `AC-CBG-006`, `AC-CBG-009`, `AC-CBG-010` |
| `CBG-020` | Story 6 | `AC-CBG-008`, `AC-CBG-010` |
| `CBG-021` | Story 4 | `AC-CBG-009`, `AC-CBG-010` |

### Rückverfolgbarkeit der Abnahme / Acceptance Traceability

| Abnahme-ID | Bindende Anforderungen / Binding Requirements |
|---|---|
| `AC-CBG-001` | `CBG-001`, `CBG-002` |
| `AC-CBG-002` | `CBG-003`, `CBG-014`, `CBG-015`, `CBG-018`, `CBG-021` |
| `AC-CBG-003` | `CBG-005`, `CBG-015`, `CBG-021` |
| `AC-CBG-004` | `CBG-004`, `CBG-006`, `CBG-007`, `CBG-016`, `CBG-021` |
| `AC-CBG-005` | `CBG-004`, `CBG-007`, `CBG-016`, `CBG-021` |
| `AC-CBG-006` | `CBG-010`, `CBG-011`, `CBG-012`, `CBG-017`, `CBG-019` |
| `AC-CBG-007` | `CBG-003`, `CBG-013`, `CBG-014`, `CBG-018`, `CBG-021` |
| `AC-CBG-008` | `CBG-006`, `CBG-008`, `CBG-009`, `CBG-014`, `CBG-015`, `CBG-017`, `CBG-020` |
| `AC-CBG-009` | `CBG-016`, `CBG-018`, `CBG-019`, `CBG-021` |
| `AC-CBG-010` | `CBG-001`, `CBG-002`, `CBG-008`, `CBG-009`, `CBG-019`, `CBG-020`, `CBG-021` |

## Annahmen / Assumptions

- Die aktuelle Ready-Review-Evidence und ihre drei beantworteten Fragen sind bindend; es bestehen keine offenen Findings, akzeptierten Risiken oder Operator-Ausnahmen.
- Die 48 Git-Repositories, davon 47 spätere Zielrepositories neben der Level-0-Quelle, sowie die Sichtbarkeits- und Profilzahlen sind datierte Planungs-Evidence und werden vor Implementierungsabnahme read-only live revalidiert.
- Stabile Registry-IDs sind die einzige zulässige Identität für Profilzuordnung; Repository-Namen oder Pfade allein reichen nicht für automatische Klassifikation.
- Der aktuelle GitHub-Livezustand darf in Stufe A read-only gelesen werden. Jeder GitHub-Schreibzugriff bleibt verboten.
- Zeitstempel dürfen zwischen realen Evidence-Läufen variieren; für identische Fixture-Zeit und identische Eingaben müssen normalisierte Ausgaben deterministisch sein.
- Der serverseitige Minimal-Gate wird in Stufe A nur als kanonischer Workflow-/Ruleset-Vertrag mit Fixtures und Simulation nachgewiesen; er wird nicht in GitHub aktiviert.
- Der spätere Stufe-B-Rollout darf diese Spezifikation als Handoff verwenden, benötigt aber eine neue Autoritätsprüfung, eine aktuelle Live-Inventur und eine eigene Abnahme der Remote-Konvergenz.
- Keine neue externe Abhängigkeit ist fachlich vorausgesetzt. Jede später vorgeschlagene Abhängigkeit benötigt Security-, Lizenz-, CVE- und Supply-Chain-Prüfung.

## Autonomous-Run-Anwendbarkeit / Autonomous-Run Applicability

- **Authority / Autorität**: Der aktuelle Benutzerauftrag und `specs/029-ci-budget-governance/autonomous-run-state.json` autorisieren ausschließlich die Specify-Phase und Stufe A im Modus `LocalImplementation`.
- **Accepted inputs / Akzeptierte Eingaben**: Lastenheft SHA-256 `48a0560280842535d1b847ebca7387768d52d10ecae31e12ed177566375c2610`, Review-Result SHA-256 `21cbde9393b83b187e718a8b0d3593cf4873478a68c849bbd42a577de7b4d04e`, Review-Report SHA-256 `d350cd3a2324371c8181abdef74cd833cfcbfdfa8ed609aac0867052357d0dd6` sowie die im Run-State gebundenen Serienartefakte.
- **Hard boundary / Harte Grenze**: Kein Commit, Push, Merge, Home-Sync, GitHub-Schreibzugriff, Ruleset-/Accountänderung, Admin-Bypass, G4-Start oder Edit eines Zielrepositories. Autonomie erweitert diese Grenze nicht.
- **Mutable validation tokens / Veränderliche Validierungstoken**: `HEAD-Commit` und `Gate-Set-Hash` sind veränderliche Validierungstoken. Jede Änderung invalidiert zugehörige Evidence. Registry-/Live-Snapshot-Hash und Hook-Version sind zusätzliche Frischemerkmale.
- **Causal closeout / Kausaler Abschluss**: `N/A` für Specify und Stufe A, weil keine externe Mutation oder Veröffentlichung autorisiert ist. Re-Evaluation: sobald Stufe B, Remote-Publikation oder GitHub-Konvergenz ausdrücklich autorisiert wird.
- **Run state / Laufzustand**: `specs/029-ci-budget-governance/autonomous-run-state.json`. Ein bewusster Stop wird als `PausedByUser` behandelt; eine unerwartete Unterbrechung verlangt Drift-, Hash-, Branch-, Authority- und Gate-Revalidierung vor Fortsetzung. Resume darf keine neue Lieferautorität ableiten.
- **Retrospective boundary / Retrospektivgrenze**: Wiederverwendbare Erkenntnisse dürfen später nur portable Governance-, Test- und Evidence-Muster beschreiben; Providerdaten, Secrets, maschinenlokale Profile und implizite Remote-Rechte sind ausgeschlossen.

### Specify-Phasengates / Specify Phase Gates

| Gate-ID | Anwendbarkeit / Applicability | Scope und prüfbarer Token / Scope and Verifiable Token | Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|
| `SPEC-GATE-001` | `Applicable` | Genau `spec.md` und `checklists/requirements.md` sind die erwarteten Tasks; beide sind nicht leer. | Aktueller Feature-Pfad | Änderung des erwarteten Taskumfangs |
| `SPEC-GATE-002` | `Applicable` | `CBG-001` bis `CBG-021` und `AC-CBG-001` bis `AC-CBG-010` sind lückenlos in Anforderungen, Abnahme und Traceability vorhanden. | Tabellen in dieser Spezifikation | Drift des akzeptierten Lastenhefts |
| `SPEC-GATE-003` | `Applicable` | Keine ungelöste Klarstellungsmarkierung; jede Qualitätschecklistenposition ist wahrheitsgemäß bestanden. | `checklists/requirements.md` | Neue offene Reviewfrage oder Qualitätsfehler |
| `SPEC-GATE-004` | `Applicable` | Die Stufe-A-Grenze und alle verbotenen Remote-/Mutationstätigkeiten sind ausdrücklich enthalten. | CBG-019, CBG-021 und Autonomous-Run-Grenze | Neue explizite Delivery Authority |
| `SPEC-GATE-005` | `Applicable` | Normalisierter lowercase SHA-256 bindet den finalen Spezifikationspayload im Phasenergebnis. | Runner-Ausgabedatei für `specify` | Jede Änderung an `spec.md` |

Owner aller Specify-Gates ist der Feature-Owner; Reviewer ist der nachfolgende
Spec-Kit-Phasenreview. Restrisiko ist eine spätere Drift bindender Intake- oder
Governance-Artefakte; der Follow-up ist in diesem Fall ein fail-closed Stop mit
erneuter Specify-/Clarify-Bewertung, nicht eine stille Anpassung.

## Governance-Anwendbarkeit / Governance Applicability

| Checkpoint | Anwendbarkeit / Applicability | Umsetzungsstatus in Specify / Implementation Status | Begründung / Rationale | Geplante Evidence / Planned Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|---|
| Security Governance | `Applicable` | `Not Assessed` | Gate-, Hook-, Workflow-, Evidence-, Eingabe- und Vertrauensgrenzen ändern sich. | `docs/security/` gemäß CR-011 | Wegfall der Security-Flächen oder neue Auth-/Secret-/Crypto-Fläche |
| Architecture Governance | `Applicable` | `Not Assessed` | Lokale und serverseitige Kontrollen bilden Defense in Depth; Datenflüsse und Trust Boundaries ändern sich. | `docs/architecture/ci-budget-governance.md`, Security-Nachweise | Neue Runtime, Cloud-Auswahl oder veränderte Liefergrenze |
| iSAQB Architecture Governance | `Applicable` | `Not Assessed` | Schnittstellen, Laufzeitablauf, Qualitätsattribute, Deployment-Vertrag und technischer Schuldenabbau sind betroffen. | `docs/architecture/ci-budget-governance.md`, Security Quality Scenarios, S-ADR | Nur noch rein redaktionelle Änderung ohne Architekturwirkung |
| A11Y Governance | `Applicable` | `Not Assessed` | CLI, Fehlertexte, Berichte, Templates, Manpage und Hilfe sind nutzerseitig. | `docs/accessibility/ci-budget-governance.md`, A11Y-Tests | Entfernung aller nutzerseitigen Artefakte |
| Cross-Platform Governance | `Applicable` | `Not Assessed` | Das Feature ändert ein script-shaped tool für macOS/Linux/Windows. | Paritätsfixtures, Manpage, PowerShell-Hilfe, betroffene Validatoren | Nachweis, dass eine Plattform technisch unmöglich ist; derzeit nicht gegeben |
| Agent Parity Governance | `Applicable` | `Not Assessed` | Gemeinsame Betriebsführung, CI-Profile oder Modell-Routing-Grenzen können Agentenflächen berühren und müssen gemeinsam geprüft werden. | Paritätsdiff und `scripts/tests/test_spec_kit_agent_surface_parity.py` | Plan weist nach, dass keine gemeinsame Guidance betroffen ist; dann bleibt Review anwendbar, Update kann `N/A` sein |

Für alle sechs Checkpoints ist der Owner der Feature-Owner und der Reviewer der
benannte Feature-Reviewer. Restrisiko im Specify-Stand ist `Not Assessed`, weil
Implementierungsevidence erst in der Implementierungsphase entsteht. Follow-up
ist die Überführung jeder `Applicable`-Zeile in Plan, Tasks und Abnahme; ein
fehlender Nachweis blockiert die Implementierungsabnahme.

## Plattformübergreifende Anwendbarkeit / Cross-Platform Applicability

- **Script-shaped tool**: `Applicable`; `scripts/maintain-agentic-workspace.sh` und `scripts/maintain-agentic-workspace.ps1` bleiben funktional gleichwertig.
- **Platforms / Plattformen**: macOS und Linux über Bash; Windows über PowerShell 7+; gemeinsame normalisierte Fixtures prüfen fachliche Parität.
- **Interfaces / Oberflächen**: Bash `--ci-gate`; PowerShell `-CiGate`; Cmdlet `Invoke-HBAgenticWorkspaceMaintenance` mit genehmigtem Verb `Invoke`.
- **Preview / Vorschau**: Bash `--dry-run` und PowerShell `-WhatIf` zeigen Auswahl, Gate-Set, geplante Einzelschritte und Evidence-Ziel, schreiben aber keine Evidence und ändern weder Repository noch Home Runtime.
- **Documentation / Dokumentation**: `docs/man/maintain-agentic-workspace.1.md` wird für Bash aktualisiert; die PowerShell-Datei erhält vollständige deutsch-zuerst/englisch-danach geführte Comment-based Help für `-CiGate`.
- **Validators / Validatoren**: Betroffen sind mindestens Shell-Syntax, PSScriptAnalyzer, `scripts/tests/test_agentic_workspace_maintenance.py`, Maintenance-Contract-/Wrapper-Regressionen, Hook-/Secret-Scan-Prüfungen, Workflow-/Pfadfixtures, A11Y-Prüfungen, Dokumentationsvalidierung und Bash-/PowerShell-Parität.
- **N/A decisions**: Keine Plattformvariante ist `N/A`. Re-Evaluation: Zielplattform oder bestehender Paritätsvertrag ändern sich.

## Barrierefreiheitsanwendbarkeit / Accessibility Applicability

- **Affected artefacts / Betroffene Artefakte**: CLI-Ausgabe, Fehlertexte, Kosten-/Rolloutberichte, Workflow-/Ruleset-Templates, Dokumentation, Manpage, PowerShell-Hilfe und didaktische Inline-Kommentare für nicht triviale Gate-/Hash-/Driftlogik.
- **WCAG 2.2 AA**: Wahrnehmbare und textlich vollständige Zustände, verständliche Beschriftungen, konsistente Reihenfolge, robuste Markdown-/CLI-Struktur und Bedienbarkeit ohne Farbe sind `Applicable`; GUI-spezifische Pointer- oder Video-Kriterien sind `N/A`, weil keine GUI oder zeitbasierte Medien entstehen. Re-Evaluation: neue GUI-, HTML- oder Medienoberfläche.
- **Language / Sprache**: Deutsch zuerst, Englisch danach, CEFR B2, Fachbegriffe beim ersten Gebrauch, `DE / EN`-Überschriften. Spec-Kit-Vorwissen wird nicht vorausgesetzt.
- **Text-first**: Profil, Entscheidung, Status, Blocker und nächste Aktion stehen in stabiler linearer Reihenfolge. Tabellen und mögliche ASCII-Diagramme erhalten kurze deutsche und englische Textalternativen; Codeblöcke erhalten Sprachkennzeichnung.
- **Didactic comments / Didaktische Kommentare**: `Applicable` für neue nicht triviale Logik zu Trust Boundaries, Hash-Bindung, fail-closed Drift, atomarer Evidence-Veröffentlichung und Prozessgrenzen. Kommentare erklären Warum, Trade-off oder Proof-Grenze, nicht offensichtliches Was.
- **Evidence / Nachweis**: `docs/accessibility/ci-budget-governance.md` und ausführbare A11Y-/Sprachparitätsfixtures. Owner ist der Feature-Owner, Reviewer der A11Y-Reviewer; Restrisiko ist Plattformausgabe-Drift. Re-Evaluation bei jeder Änderung nutzerseitiger Ausgaben oder Templates.

## Architekturanwendbarkeit / Architecture Applicability

- **Architecture goals / Architekturziele**: Kostenkontrolle, fail-closed Korrektheit, Defense in Depth, deterministische Auditierbarkeit, minimale Runnerlast, Plattformparität, sichere Nichtmutation und verständliche Betriebsführung.
- **Affected views / Betroffene Sichten**: Systemkontext zwischen Level 0, Flottenregister, read-only GitHub-Livezustand und 47 späteren Zielen; Schnittstellen der Wartungsskripte; Building Blocks für Mapping, Gate-Set, Evidence, Hook, Kosten- und Rolloutplanung; Laufzeitfolge vom Inventar bis Evidence; späterer Deployment-/Rolloutvertrag.
- **Quality scenarios / Qualitätsszenarien**: Drift stoppt vor Planung; Hook-Umgehung bleibt durch unabhängigen Serververtrag geschützt; identische Inputs liefern plattformgleich dieselben Entscheidungen; eine sechsfach CaseTracker-Änderung erzeugt höchstens sechs Jobs; Stufe A mutiert kein Ziel.
- **Evidence / Nachweis**: `docs/architecture/ci-budget-governance.md` ist `Applicable`. Eine Architekturentscheidung zur Trennung von lokalem Evidence-Gate und unabhängigem serverseitigem Minimal-Gate MUSS als S-ADR unter `docs/security/adr/` dokumentiert werden.
- **Technical debt / Technische Schuld**: Implizite Profilklassifikation, doppelte Builds, ungebundene lokale Evidence und Hook-als-Einzelschutz werden durch explizite Verträge ersetzt.
- **Re-Evaluation**: Änderungen an Profilen, Vertrauensgrenzen, Deployment, Zielplattformen, Stage-B-Autorität oder GitHub-Gate-Modell.

## Sichere Architekturanwendbarkeit / Architecture Governance Applicability

- **Runtime/hardware constraint**: Bash ist wegen der vorhandenen nativen macOS-/Linux-Skriptoberfläche erforderlich; PowerShell 7+ bildet Windows auf einer speichersicheren Managed Runtime ab. Keine Hardwaregrenze erzwingt weitere nicht speichersichere Komponenten.
- **Trust boundaries / Vertrauensgrenzen**: Nicht vertrauenswürdige Registry-, Pfad-, Git- und Live-Daten überqueren die Skripteingabe; Gate-Ergebnisse werden in maschinenlokale Evidence überführt; der Hook konsumiert diese Evidence; der serverseitige Gate-Vertrag prüft unabhängig einen PR-Pfad. Die letzte Grenze wird in Stufe A nur simuliert, nicht remote eingerichtet.
- **Data classes / Datenklassen**: Profil-/Workflow-Templates sind öffentlich oder intern; Repository-Sichtbarkeit und Inventurmetadaten sind intern; Secrets, Tokens, private Billingdaten und unnötige Personendaten sind restricted und dürfen nicht in Evidence gelangen.
- **Threat modeling**: STRIDE+CIA und CAPEC sind `Applicable`, besonders für Spoofing/Tampering von HEAD-, Gate-Set- und Evidence-Daten, Repudiation fehlender Gate-Protokolle, Information Disclosure sowie Denial of Service durch fail-open Fehlerpfade. Evidence: `docs/security/threat-model.md`.
- **S-ADR and arc42**: S-ADR für Defense-in-Depth-Grenze und Update von `docs/security/arc42-security.md` sind `Applicable`.
- **Zero Trust**: `Applicable`, weil weder lokaler Hook noch Netzwerk-/Clone-Stand implizit vertraut werden darf; Identität, HEAD, Gate-Set und serverseitiger Status müssen explizit verifiziert werden. Evidence: `docs/security/zero-trust-applicability.md`.
- **OWASP SAMM**: `Applicable` für den langlebigen Level-0-Workspace; die neue CI-/Evidence-Praxis fließt in `docs/security/samm-assessment.md` ein.
- **BSI C3A**: `N/A`; GitHub wird in Stufe A nur als generische Entwicklungs-/read-only Inventurinfrastruktur genutzt, keine Cloud-Service-Auswahl oder betriebene Cloud-Runtime ist in Scope. Re-Evaluation: providerabhängige Deployment-/Hosting-Entscheidung oder Stufe-B-Cloudbetrieb.
- **BSI C5**: `N/A` aus demselben Toolchain-Grund; kein Cloud-Assurance- oder Shared-Responsibility-Scope wird verändert. Re-Evaluation: Cloud-Assurance-Prüfung, Kundenanforderung oder betriebener Cloud-Service.

## Sicherheitsgovernance-Anwendbarkeit / Security Governance Applicability

| Standard / Check | Anwendbarkeit / Applicability | Begründung und Evidence / Rationale and Evidence | Re-Evaluation Trigger |
|---|---|---|---|
| NIST SSDF | `Applicable` | Produktionsnahe CI-, Hook- und Evidence-Werkzeuge benötigen Prepare/Protect/Produce/Respond-Nachweis in Security Checklist und Plan/Tasks. | Feature wird rein redaktionell und ändert keine ausführbare Lieferkette |
| CWE Top 25 | `Applicable` | Nicht vertrauenswürdige Eingaben, Pfade, Shell-/Prozessaufrufe und Evidence-Integrität benötigen relevante CWE-Prüfung. | Keine ausführbare Eingabe- oder I/O-Fläche mehr betroffen |
| OWASP ASVS | `N/A` | Kein Web/API/HTTP/Auth-Service; N/A-Entscheidung in Security-Index/ASVS-Nachweis aktuell halten. | Neue Web-, API-, HTTP- oder Auth-Oberfläche |
| SBOM | `Applicable` | Skripte, Hooks und Templates sind distributable Level-0-Artefakte; `docs/security/supply-chain-evidence.md`. | Artefakte werden nicht mehr verteilt oder released |
| VEX | `Applicable` | Abhängigkeits-/Toolchainbewertung braucht für bekannte Findings einen Status; `docs/security/supply-chain-evidence.md` und `dependency-audit.md`. | Keine auslieferbaren oder bewerteten Komponenten mehr |
| AI-SBOM | `N/A` | KI nur Entwicklungswerkzeug, keine KI-Runtime-/Produktkomponente. | KI-Modell, -Dienst, Dataset, Inferenzinfrastruktur oder Runtime wird ausgeliefert/betrieben |
| SLSA | `Applicable` | CI-/veröffentlichte Templates und Evidence benötigen Provenance-/Integritätsziel; `docs/security/supply-chain-evidence.md`. | Keine CI-/Publikationsartefakte mehr |
| OpenSSF Scorecard | `Applicable` | Level 0 und öffentliche Vorlagen sind OSS-/Distributionsflächen; Beobachtungen in Supply-Chain-Evidence. | Repository und alle betroffenen Abhängigkeiten sind nicht öffentlich/hochwirksam |
| CAPEC | `Applicable` | Materiale Manipulations- und Bypasspfade werden im Threat Model referenziert. | Trust Boundaries entfallen |
| Regulatory NIS2/CRA/EU AI Act/DORA | `N/A` | Stufe A ist private Workspace-/Entwicklungsinfrastruktur ohne Marktprodukt, regulierten Dienst/Kunden, AI-Runtime oder Finanzsektor-ICT-Rolle. Evidence: `docs/security/regulatory-applicability.md`. | Release/Marktbereitstellung, Kundenübergabe, regulierter Betrieb, AI-Runtime oder Finanzsektorrolle |

Owner der Standardsentscheidungen ist der Feature-Owner, Reviewer der Security-
Reviewer. Umsetzungsstatus bleibt in Specify `Not Assessed`; Restrisiko ist eine
später hinzugefügte Abhängigkeit oder Vertrauensgrenze. Follow-up ist die
vollständige Evidence-Aktualisierung vor Implementierungsabnahme.

## Agenten-Parität / Agent Parity Applicability

- **Applicability / Anwendbarkeit**: `Applicable` für die Prüfung gemeinsamer Betriebsführung und agentenneutraler Routing-/Autonomiegrenzen.
- **Maintained surfaces / Gepflegte Flächen**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md` sind gemeinsam zu prüfen und bei einer gemeinsamen Guidance-Änderung atomar zu aktualisieren.
- **Constitution/templates**: `constitution.md`, `.specify/memory/constitution.md` und `.specify/templates/` werden nur geändert, wenn die Implementierung einen gemeinsamen Grundsatz oder Spec-Kit-Vertrag ändert. Der aktuelle Featurevertrag erfindet keine solche Verfassungsänderung.
- **Project templates / Projektvorlagen**: Kanonische Workflow-/Ruleset-Templates dieses Features sind fachlich betroffen; agentenspezifische Provider- oder Modellnamen sind verboten.
- **Intentional deviations / Absichtliche Abweichungen**: Keine. Jede später notwendige Abweichung braucht Begründung und Paritätsevidence in derselben Änderung.
- **Evidence / Nachweis**: Paritätsdiff, `scripts/tests/test_spec_kit_agent_surface_parity.py` und Dokumentations-Impact-Evidence. Re-Evaluation: jede Änderung gemeinsamer Guidance, Templates, Constitution oder Routingrollen.

## Dokumentationsauswirkung / Documentation Impact

- **Decision / Entscheidung**: `UpdateRequired` — die einzige Documentation-Impact-Entscheidung dieses Features.
- **Audiences and reader paths / Zielgruppen und Leserpfade**: Maintainer, Flotten-Operator*innen, Repository-Verantwortliche und Reviewer beginnen bei Zweck, Voraussetzungen, Sicherheits-/Autoritätsgrenze und einem sicheren lokalen Vorschauaufruf; danach folgen Profile, Gate-/Evidence-Betrieb, Fehlerbehebung, Kostenmodell, Architektur-/Security-/A11Y-Nachweise und Stufe-B-Handoff.
- **Canonical source and owner / Kanonische Quelle und Owner**: Level 0 besitzt Profilvertrag, Skript-/Hook-Vertrag, Workflow-/Ruleset-Templates und Rolloutplanung; Owner ist der `home-baseline` Feature-Owner. Zielrepositories bleiben Eigentümer ihrer späteren Runtimewahrheit und werden in Stufe A nicht geändert.
- **Affected documentation families / Betroffene Dokumentfamilien**: Betriebs-/README- und Skriptreferenz, `docs/scripts/`, `docs/man/maintain-agentic-workspace.1.md`, bilinguale PowerShell-Hilfe, Architektur, Security, Accessibility, Workflow-/Ruleset-Template-Erklärung, Kosten-/Rollout-Evidence und Projektstatistik.
- **Navigation impact / Navigation**: Neue CI-Gate- und Profilseiten müssen aus bestehender Wartungs-/Skriptnavigation erreichbar sein; große Einstiegsseiten verwenden Progressive Disclosure und verweisen in die Detailnachweise.
- **Document class / Dokumentklasse**: Versionierter Betriebs- und Governance-Vertrag mit generierten beziehungsweise deterministischen Evidence-Artefakten; semantische Dokumentation bleibt reviewpflichtig.
- **Language strategy and partner / Sprachstrategie und Partner**: Deutsch zuerst, Englisch danach, CEFR B2. Inline-bilingual für kurze Betriebsflächen; synchronisierte `.en.md`-Partner nur, wenn Umfang und bestehende Dokumentklasse dies verlangen.
- **Platform/example proof / Plattform-/Beispielnachweis**: Ein Bash-Beispiel für macOS/Linux, ein PowerShell-Beispiel für Windows sowie normalisierte Paritätsfixtures; Ausgaben bleiben ohne Farbe verständlich.
- **Distribution class / Distributionsklasse**: Spezifikation und kanonische Quellen sind `sourceOnly`; später manifestgebundene Skript-/Hook-Flächen sind `homeRuntime`; erfolgreiche Gate-Evidence ist `machineLocal` und niemals Git-getrackt.
- **Home-sync need / Home-Sync-Bedarf**: Für Specify und die autorisierte Stufe A `false`; kein Home-Sync wird ausgeführt. Eine spätere Distribution erfordert getrennte Vorschau, Konfliktprüfung und ausdrückliche Autorität.
- **Evidence / Nachweis**: `specs/029-ci-budget-governance/spec.md`, `specs/029-ci-budget-governance/checklists/requirements.md`, spätere Documentation-Impact-Evidence im Featureverzeichnis sowie aktualisierte Architektur-, Security-, A11Y-, Skript-, Manpage- und Statistiknachweise.
- **Re-evaluation trigger / Re-Evaluation**: Änderung von Profilen, Sichtbarkeit, Flottenstruktur, Sicherheitsgrenze, Delivery Authority, Stage-Trennung, Skriptoberfläche, Zielplattformen, Evidence-Schema/-pfad, Home-Runtime-Verteilung, Dokumentklassen oder Zielgruppen.

## English Contract Summary

The German-first sections above and their inline English counterparts form one
binding specification. The normative identifiers `CBG-001` through `CBG-021`
and `AC-CBG-001` through `AC-CBG-010` are preserved without renumbering. Stage
A is limited to Level-0-owned source, local gates and evidence, hook logic,
canonical workflow/ruleset templates, simulations, tests, statistics,
bilingual documentation, and deterministic rollout planning. Stage A never
claims or performs convergence of the 47 target repositories. Any remote
mutation, Home sync, GitHub write, ruleset/account change, commit, push, merge,
admin bypass, target-repository edit, or G4 start requires separate explicit
authority and is outside this specification phase.
