# Feature-Spezifikation: RL-SE-/Checklist-Selbstprüfung / Feature Specification: RL-SE Checklist Self-Assessment

**Feature-Branch / Feature Branch**: `025-rl-se-self-assessment`
**Erstellt / Created**: 2026-08-05
**Status**: Ready for Planning
**Eingabe / Input**: `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`
**Verbindliches Review / Binding Review**: `specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json`
**Vorgänger-Evidenz / Predecessor Evidence**: `specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md`
**Position**: 6, Root und einziger bevorzugter `Eligible`-Kandidat
**Delivery Authority**: `MergeAndSync`

**Authority transition (2026-08-08)**: The assessment implementation was first
completed locally under `LocalImplementation`. The current user instruction and
the superseding Ready intake/review grant `MergeAndSync` for Feature 025 under
the narrow admin-bypass boundary. This changes delivery governance only; it
does not expand assessment, runtime, preset, or remediation scope.

## Clarifications

### Session 2026-08-05

- Q: Welche Zeilengranularität ist für die Evidenzmatrix verbindlich? → A: Eine Zeile je stabiler Checklisten-ID; zusätzliche eindeutige Zeilen nur für Prüfpunkte ohne stabile ID. Querverweise erzeugen keine Duplikate. / Q: Which row granularity is binding for the evidence matrix? → A: One row per stable checklist ID; additional unique rows only for checkpoints without a stable ID. Cross-references create no duplicates.
- Q: Welche Vorrangregel gilt, wenn mehrere Workflow-Statuswerte passend erscheinen? → A: `N/A` bei Nichtanwendbarkeit; sonst `AlreadySatisfied` bei aktueller Evidenz; sonst `FollowUp` bei bewusstem Außerscope; sonst `Open` bei ungeklärter oder unzureichender Evidenz; andernfalls `Applicable`. / Q: Which precedence rule applies when several workflow statuses appear suitable? → A: `N/A` when not applicable; otherwise `AlreadySatisfied` with current evidence; otherwise `FollowUp` when deliberately out of scope; otherwise `Open` when unresolved or insufficiently evidenced; otherwise `Applicable`.
- Q: Wann gilt ein Evidenznachweis als aktuell? → A: Evidenz ist an den geprüften Commit oder dokumentierten Arbeitsbaum gebunden. Prüfergebnisse nennen Befehl, Zeitpunkt und Ergebnis; veränderliche externe Quellen zusätzlich Quelle und Abrufdatum. / Q: When is an evidence record current? → A: Evidence is bound to the assessed commit or documented working tree. Check results state the command, time, and outcome; mutable external sources additionally state the source and retrieval date.
- Q: Wie werden Priorität und Restrisiko einheitlich bewertet? → A: Priorität und Restrisiko verwenden `High`, `Medium` oder `Low`; Risiko und Restrisiko erhalten jeweils eine kurze Begründung. / Q: How are priority and residual risk assessed consistently? → A: Priority and residual risk use `High`, `Medium`, or `Low`; risk and residual risk each receive a short rationale.
- Q: Wie wird der Ausfall einer erforderlichen externen Evidenzquelle behandelt? → A: Lokale Repository-Evidenz ist primär. Eine nicht erreichbare erforderliche externe Quelle führt zu `Open` mit Quelle, Owner, Risiko und Re-Evaluation-Trigger, aber nicht zum Abbruch der gesamten Selbstprüfung. / Q: How is failure of a required external evidence source handled? → A: Local repository evidence is primary. An unavailable required external source results in `Open` with source, owner, risk, and re-evaluation trigger but does not abort the complete self-assessment.

## Nutzungsszenarien und Tests / User Scenarios & Testing

### User Story 1 - Vollständige Selbstprüfung durchführen / Complete the Self-Assessment (Priority: P1)

Maintainer und Ausbildungsverantwortliche können das aktuelle Level-0-
Repository gegen die Richtlinie Sichere Entwicklung, alle zwölf Checklisten,
den Sammelband, die mitgeltenden Dokumente und die installierten Governance-
Presets prüfen, ohne bereits erfüllte Punkte erneut umzusetzen.

*Maintainers and training leads can assess the current Level 0 repository
against the secure-development guideline, all twelve checklists, the
compendium, related documents, and installed governance presets without
reimplementing controls that are already proven.*

**Warum diese Priorität / Why this priority**: Die vollständige und
nachvollziehbare Abdeckung ist der Kernnutzen des Features und die Grundlage
für jede spätere Härtungsentscheidung.

**Unabhängiger Test / Independent Test**: Eine Abdeckungsprüfung weist genau
157 stabile Checklistenpunkte, zwölf Checklisten und fünfzehn mitgeltende
Dokumente aus und ordnet jeden relevanten Prüfpunkt genau einer Matrixzeile zu.

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Given** die Baseline 3.2.0 und die abgeschlossene Feature-024-Zuordnung,
   **When** die Selbstprüfung abgeschlossen wird, **Then** ist jeder relevante
   Prüfpunkt mit ID, normativer Quelle, Status und Begründung sichtbar.
2. **Given** ein bereits nachweislich erfüllter Prüfpunkt, **When** er bewertet
   wird, **Then** erhält er `AlreadySatisfied` und einen konkreten Evidenzpfad,
   ohne eine neue Umsetzung zu verlangen.
3. **Given** ein nicht anwendbarer Prüfpunkt, **When** er bewertet wird,
   **Then** erhält er `N/A`, eine fachliche oder technische Begründung und
   einen Re-Evaluation-Trigger.

---

### User Story 2 - Lücken und Folgearbeit sicher unterscheiden / Distinguish Gaps and Follow-Up Safely (Priority: P1)

Reviewer können ungeklärte, noch nicht belegte und bewusst nachgelagerte
Punkte voneinander unterscheiden. Positive Aussagen bleiben an aktuelle
Evidenz gebunden; menschliche Freigaben werden nicht erfunden.

*Reviewers can distinguish unresolved, unproven, and deliberately deferred
items. Positive claims remain bound to current evidence, and human approval is
never fabricated.*

**Warum diese Priorität / Why this priority**: Eine Selbstprüfung ist nur
vertrauenswürdig, wenn Unsicherheit, Risiko und Zuständigkeit sichtbar bleiben.

**Unabhängiger Test / Independent Test**: Jede `Open`- und `FollowUp`-Zeile
enthält Owner, Folgeaktion, Priorität, Risiko und Re-Evaluation-Trigger; jede
positive Aussage verweist auf prüfbare Evidenz.

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Given** ein anwendbarer, aber nicht ausreichend belegter Prüfpunkt,
   **When** er bewertet wird, **Then** lautet der Status `Open` und alle
   erforderlichen Zuständigkeits- und Risikofelder sind ausgefüllt.
2. **Given** ein fachlich relevanter Punkt außerhalb des aktuellen Laufs,
   **When** er abgegrenzt wird, **Then** lautet der Status `FollowUp` und die
   begrenzte Folgeaktion ist begründet.
3. **Given** ein ausschließlich menschlich entscheidbarer Kontrollpunkt,
   **When** keine menschliche Evidenz vorliegt, **Then** wird er nicht als
   erfüllt ausgewiesen.

---

### User Story 3 - Ergebnisse barrierearm verstehen / Understand Results Accessibly (Priority: P2)

Maintainer, Ausbildungsverantwortliche und Auszubildende können Status,
Evidenz, Risiken und nächste Aktionen ohne Spec-Kit-Vorkenntnisse und ohne
visuelle Zusatzinformation nachvollziehen.

*Maintainers, training leads, and apprentices can understand status, evidence,
risks, and next actions without prior Spec Kit knowledge and without relying
on visual-only information.*

**Warum diese Priorität / Why this priority**: Die Ergebnisse dienen sowohl
Governance als auch Ausbildung und müssen in textorientierten Hilfsmittel-
Setups vollständig nutzbar bleiben.

**Unabhängiger Test / Independent Test**: Die vollständigen Ergebnisse stehen
Deutsch zuerst und Englisch danach auf CEFR-B2-Niveau bereit; Tabellen,
Statuswerte und nächste Aktionen sind ohne Farbe, Diagramm oder räumliche
Position verständlich.

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Given** eine Person ohne Spec-Kit-Erfahrung, **When** sie die Zusammenfassung
   liest, **Then** findet sie Zweck, Statuslogik, Restrisiken und nächste Aktion
   ohne externe Begriffsliste.
2. **Given** ein Screenreader oder Textbrowser, **When** die Matrix gelesen wird,
   **Then** bleiben Zeilenbezug, Status und Evidenz eindeutig.
3. **Given** die deutsche und englische Fassung, **When** beide verglichen
   werden, **Then** enthalten sie dieselben Entscheidungen, Grenzen, Risiken,
   Evidenzen und nächsten Aktionen.

---

### User Story 4 - Begrenzte Verbesserung planen / Plan Bounded Improvement (Priority: P3)

Maintainer können aus der Selbstprüfung priorisierte Folgearbeit ableiten,
ohne in diesem Feature Produktcode, Runtime, Skripte, Providerkonfiguration
oder andere Repositories automatisch zu verändern.

*Maintainers can derive prioritized follow-up work without this feature
automatically changing product code, runtime, scripts, provider configuration,
or other repositories.*

**Warum diese Priorität / Why this priority**: Die Selbstprüfung soll sichere
Entscheidungen ermöglichen, nicht verdeckt in einen Härtungs- oder Flottenlauf
übergehen.

**Unabhängiger Test / Independent Test**: Die Abschlusszusammenfassung trennt
`AlreadySatisfied`, aktuelle Lücken und begrenzte Folgearbeit; der Git-Diff
enthält keine automatische Härtung oder repoübergreifende Mutation.

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Given** ein Sicherheitsbefund mit Umsetzungsbedarf, **When** das Feature
   abgeschlossen wird, **Then** ist er als `Open` oder `FollowUp` dokumentiert
   und nicht verdeckt behoben.
2. **Given** ein Befund in einem anderen Repository, **When** er erfasst wird,
   **Then** bleibt er eine referenzierte Folgeaktion und löst keinen Sammellauf
   aus.

### Randfälle / Edge Cases

- Ein Evidenzpfad existiert, ist aber veraltet, nicht mehr hashgebunden oder
  belegt eine andere Aussage als die Matrixzeile.
- Eine Vorgabe ist für Level-2-Projekte verpflichtend, für dieses Level-0-
  Repository aber nur als wiederverwendbare Governance-Basis relevant.
- Ein Prüfpunkt besitzt sowohl Anwendbarkeits- als auch Umsetzungsstatus; beide
  Achsen dürfen nicht zu einem einzigen positiven Status verschmolzen werden.
- Ein erzeugter Sammelband widerspricht einer kanonischen Einzelcheckliste.
- Eine positive Aussage hängt von einer menschlichen Freigabe, einem Audit oder
  einer organisatorischen Wirksamkeitsprüfung ab.
- Eine Matrixzeile berührt mehrere normative Quellen; eine primäre Quelle und
  nachvollziehbare Querverweise müssen erhalten bleiben.
- Ein technischer Begriff ist korrekt, aber für die erklärte Zielgruppe nicht
  bei der ersten Verwendung erläutert.
- Eine Tabelle ist visuell verständlich, verliert aber beim linearen Lesen den
  Bezug zwischen Prüfpunkt, Status und Evidenz.
- Ein lokaler oder privater Pfad, Token, personenbezogener Wert oder
  Providerdetail erscheint in Roh-Evidenz und darf nicht in das Ergebnis
  übernommen werden.
- Baseline-, Mapping- oder Preset-Versionen ändern sich während des Features;
  die Prüfung muss dann auf die neue Ausgangslage revalidiert werden.
- Eine erforderliche externe Evidenzquelle ist nicht erreichbar; der betroffene
  Prüfpunkt wird mit Quelle, Owner, Risiko und Re-Evaluation-Trigger als `Open`
  erfasst, während die übrige Selbstprüfung fortgesetzt wird.

## Anforderungen / Requirements

### Funktionale Anforderungen / Functional Requirements

- **RLSE-001**: Das Feature MUST die abgeschlossene Position-5-Baseline und
  ihren PR-Nachweis vor jeder fachlichen Bewertung als verbindliche
  Ausgangslage verwenden.
- **RLSE-002**: Das Feature MUST genau das aktuelle `home-baseline`-Repository
  prüfen und MUST keinen Sammellauf über weitere Repositories starten.
- **RLSE-003**: Das Feature MUST Richtlinie Sichere Entwicklung 3.2.0,
  Baseline-Manifest 3.2.0, zwölf kanonische Checklisten, 157 stabile
  Checklistenpunkte, Sammelband 2.2.0, fünfzehn mitgeltende Dokumente und die
  aktuelle Zuordnungsdatei vollständig abdecken.
- **RLSE-004**: Das Feature MUST das öffentliche Acht-Preset-Standardprofil und
  das verwaltete Elf-Preset-Profil unterscheiden und alle elf aktuell
  installierten Presets als Prüfgrundlage berücksichtigen.
- **RLSE-005**: Jede Ergebniszeile MUST eine eindeutige Prüfpunkt-ID, eine
  normative Quelle, genau einen Workflow-Status und eine kurze Begründung
  enthalten.
- **RLSE-006**: Der Workflow-Status MUST genau einen der Werte `Applicable`,
  `AlreadySatisfied`, `N/A`, `Open` oder `FollowUp` verwenden.
- **RLSE-007**: Jede `Applicable`-Zeile MUST geplanten Evidenz- oder
  Umsetzungspfad, Owner, Priorität, Risiko und Re-Evaluation-Trigger enthalten.
- **RLSE-008**: Jede `AlreadySatisfied`-Zeile MUST einen konkreten, aktuellen
  und zur Aussage passenden Evidenzpfad enthalten.
- **RLSE-009**: Jede `N/A`-Zeile MUST eine fachliche oder technische Begründung
  und einen Re-Evaluation-Trigger enthalten.
- **RLSE-010**: Jede `Open`-Zeile MUST Owner, Klärungs- oder Folgeaktion,
  Priorität, Risiko und Re-Evaluation-Trigger enthalten.
- **RLSE-011**: Jede `FollowUp`-Zeile MUST Owner, begründete Folgeaktion,
  Priorität, Risiko und Re-Evaluation-Trigger enthalten.
- **RLSE-012**: Wenn eine normative Quelle getrennte Achsen für Anwendbarkeit
  und Umsetzung verlangt, MUST die Matrix zusätzlich `Applicable`, `N/A` oder
  `Open` getrennt von `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled` oder
  `Not Assessed` erfassen.
- **RLSE-013**: Positive Einhaltungs-, Wirksamkeits- oder Erfüllungsaussagen
  MUST auf konkreter Evidenz beruhen; fehlende Human-Evidence MUST sichtbar
  bleiben.
- **RLSE-014**: Das Feature MUST mindestens MSL-Status, sichere
  Programmierschnittstellen, Ein-/Ausgabegrenzen, Eingabevalidierung,
  Fehlerbehandlung, Authentifizierung, Autorisierung, Kryptografie, Logging,
  Abhängigkeiten, Build/Release, Sandbox und agentische Entwicklung prüfen,
  soweit diese Flächen im Zielrepository vorhanden sind.
- **RLSE-015**: Das Feature MUST NIST SSDF, CWE Top 25, OWASP ASVS, OWASP SAMM,
  STRIDE/CAPEC, Zero Trust, BSI C3A/C5, SBOM, VEX, SLSA, OpenSSF Scorecard,
  AI-SBOM, NIS2, CRA, EU AI Act und DORA jeweils sichtbar bewerten oder mit
  statusgerechter Begründung abgrenzen.
- **RLSE-016**: Das Feature MUST bestehende Nachweise unter `docs/security/`,
  Tests, CI, Reviews und Spec-Kit-Artefakte als mögliche Evidenz prüfen, ohne
  Stub-Dateien automatisch als erfüllte Kontrolle zu werten.
- **RLSE-017**: Das Feature MUST die vollständige Evidenzmatrix unter
  `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md`
  und die Abschlusszusammenfassung daneben als `assessment-summary.md`
  vorsehen.
- **RLSE-018**: Die Abschlusszusammenfassung MUST Ergebnis, Abdeckung, offene
  Risiken, Restrisiken, Owner, Folgeaktionen und Re-Evaluation-Trigger
  enthalten.
- **RLSE-019**: Nutzerseitige Ergebnisartefakte MUST den vollständigen Inhalt
  Deutsch zuerst und Englisch danach, textorientiert, WCAG-2.2-AA-orientiert
  und auf CEFR-B2-Niveau bereitstellen.
- **RLSE-020**: Fachbegriffe und Abkürzungen MUST bei der ersten Verwendung
  erklärt werden; grundlegende Git-, Markdown- und Repository-Kenntnisse dürfen
  vorausgesetzt werden, Spec-Kit- oder Sicherheitsabkürzungswissen nicht.
- **RLSE-021**: Private Pfade, Secrets, produktive Tokens, unnötige
  personenbezogene Daten und ungeprüfte Providerdetails MUST aus Ergebnis-
  artefakten ausgeschlossen werden.
- **RLSE-022**: Das Feature MUST das aktuelle Build-, Test-, Dokumentations-
  und Governance-Verhalten unverändert lassen und ausgelöste Regressionen
  sichtbar melden.
- **RLSE-023**: Das Feature MUST ohne automatische Produktcode-, Runtime-, API-,
  Dependency-, Toolchain-, Skript-, Provider- oder Agent-Guidance-Härtung
  abgeschlossen werden.
- **RLSE-024**: Findings, die eine Umsetzung benötigen, MUST als `Open` oder
  `FollowUp` mit vollständigem Vertrag dokumentiert und MUST außerhalb dieses
  Features separat autorisiert werden.
- **RLSE-025**: Die Ergebnisnavigation MUST von `docs/security/README.md` zur
  datierten Selbstprüfung führen, ohne bestehende kanonische Baseline-
  Dokumente oder historische Evidenz umzudeuten.
- **RLSE-026**: Das Feature MUST genau eine Documentation-Impact-Entscheidung
  führen und die Projektstatistik nach einem abgeschlossenen Feature über die
  kanonische Konfiguration und den Renderer aktualisieren.
- **RLSE-027**: Das Feature MUST Position 6 bei erfolgreichem Abschluss
  kausal archivieren und die Series aktualisieren, darf aber keinen
  Nachfolgeintake automatisch starten.
- **RLSE-028**: Jede der 157 stabilen Checklisten-IDs MUST genau eine
  Matrixzeile identifizieren. Prüfpunkte ohne stabile Checklisten-ID MUST eine
  zusätzliche, im Matrixnamensraum eindeutige ID erhalten; Querverweise auf
  mehrere normative Quellen MUST in derselben Zeile bleiben und dürfen keine
  doppelte Zeile erzeugen.
- **RLSE-029**: Wenn mehrere Workflow-Statuswerte passend erscheinen, MUST die
  Matrix genau diese Vorrangregel anwenden: `N/A` bei Nichtanwendbarkeit;
  andernfalls `AlreadySatisfied` bei aktueller Evidenz; andernfalls `FollowUp`
  bei bewusstem Außerscope; andernfalls `Open` bei ungeklärter oder
  unzureichender Evidenz; andernfalls `Applicable`.
- **RLSE-030**: Aktuelle Evidenz MUST an den geprüften Commit oder einen
  dokumentierten Arbeitsbaumstatus gebunden sein. Reproduzierbare
  Prüfergebnisse MUST Prüfbefehl, Prüfzeitpunkt und Ergebnis enthalten;
  veränderliche externe Evidenz MUST zusätzlich Quelle und Abrufdatum nennen.
  Fehlt eines der jeweils erforderlichen Felder, darf der Prüfpunkt nicht als
  `AlreadySatisfied` klassifiziert werden.
- **RLSE-031**: Jedes erforderliche Prioritätsfeld und jedes erforderliche
  Restrisikofeld MUST genau einen der Werte `High`, `Medium` oder `Low`
  verwenden. Jede Risikobeschreibung und jedes Restrisiko MUST zusätzlich eine
  kurze, fachlich nachvollziehbare Begründung enthalten.
- **RLSE-032**: Lokale Repository-Evidenz MUST die primäre Evidenzquelle sein.
  Ist eine erforderliche externe Quelle nicht erreichbar, MUST der betroffene
  Prüfpunkt als `Open` mit Quelle, Owner, Risiko und Re-Evaluation-Trigger
  erfasst werden; allein dieser Ausfall darf die übrige Selbstprüfung nicht
  abbrechen.

### Verfassungsanforderungen / Constitution Requirements

- **CR-001**: Das Level-2-Umgebungsregister ist für die aktuelle Level-0-
  Selbstprüfung `N/A`. Re-Evaluation erfolgt, sobald ein späterer
  repositoriespezifischer Intake ein Level-2-Ziel auswählt.
- **CR-002**: Barrierefreiheit ist `Applicable`: WCAG 2.2 Level AA, lineare
  Textnutzung, Screenreader-/Braille-/Textbrowser-Tauglichkeit und vollständige
  DE-/EN-Parität bilden die Review-Basis.
- **CR-003**: Die Zielgruppe und das Vorwissen aus dem Intake sind bindend;
  technische Begriffe werden bei erster Verwendung auf CEFR-B2-Niveau erklärt.
- **CR-004**: Projektstatistik ist bei Feature-Abschluss `Applicable` als
  deterministisch erzeugte Aktualisierung. Gemeinsame Agent-Guidance ist ohne
  Regeländerung `N/A`.
- **CR-005**: Eine primäre Implementierungssprache ist `N/A`, weil dieses
  Feature ausschließlich Dokumentations- und Evidenzartefakte bewertet und
  keine neue Programmlogik erzeugt. Der MSL-Status vorhandener Codeflächen
  bleibt dennoch ein Prüfpunkt. Re-Evaluation erfolgt bei Code- oder
  Skriptänderung.
- **CR-006**: NIST SSDF und CWE Top 25 sind als Prüfrahmen `Applicable`.
  Standard- und Regulierungspunkte mit kontextabhängiger Anwendbarkeit werden
  nicht stillschweigend ausgelassen.
- **CR-007**: OWASP ASVS ist für das Feature-Delta `N/A`, da kein Web-, API-,
  HTTP-, Authentifizierungs- oder Autorisierungsdienst geändert wird.
  Re-Evaluation erfolgt bei einem solchen Finding oder Scope-Delta.
- **CR-008**: SBOM, VEX und SLSA sind als bestehende Lieferketten-
  Prüfgegenstände `Applicable`; das Feature selbst erzeugt kein neues
  Releaseartefakt und keine neue Abhängigkeit.
- **CR-009**: AI-SBOM ist `N/A`, weil KI ausschließlich als Entwicklungs-
  werkzeug verwendet wird und kein KI-Modell, KI-Dienst, Datensatz oder
  Inferenzbestandteil Teil des ausgelieferten oder betriebenen Systems wird.
  Re-Evaluation erfolgt bei einem KI-Runtime- oder Produkt-Scope.
- **CR-010**: Neue Trust Boundaries, externe Datenflüsse und verteilte
  Architektur sind `N/A`, weil das Feature keine Runtime-Architektur ändert.
  Bestehende Architektur- und Bedrohungsnachweise bleiben Prüfgegenstände.
- **CR-011**: Der Standard-Evidenzort ist der in RLSE-017 benannte datierte
  Pfad unter `docs/security/`; fehlende kanonische Security-Dokumente werden
  als `Open` oder `FollowUp` erfasst, nicht verdeckt befüllt.
- **CR-012**: Alle elf installierten Governance-Presets sind als
  Prüfflächen `Applicable`; Parallel Autonomous ist als Ausführungsmodus
  `N/A`, weil genau ein Repository und ein Writer betroffen sind.
- **CR-013**: Documentation Impact ist `UpdateRequired` für die datierte
  Selbstprüfung, ihren Security-Index-Einstieg und die Abschluss-/Statistik-
  Evidenz. Die Distribution bleibt `sourceOnly`; Home Sync ist nicht nötig.

### Schlüsseldaten / Key Entities

- **Prüfgrundlage / Assessment Baseline**: Versionierte Menge aus Richtlinie,
  Baseline-Manifest, Checklisten, Sammelband, mitgeltenden Dokumenten,
  Constitution und Preset-Profilen.
- **Prüfpunkt / Assessment Checkpoint**: Eindeutige ID, normative Quelle,
  Workflow-Status, Begründung und gegebenenfalls getrennte Anwendbarkeits- und
  Umsetzungsachsen. Eine stabile Checklisten-ID identifiziert genau eine
  Matrixzeile; zusätzliche Prüfpunkte verwenden eindeutige IDs desselben
  Matrixnamensraums.
- **Evidenznachweis / Evidence Record**: Konkreter Repository-Pfad oder
  reproduzierbares Prüfergebnis mit Aussagegrenze und Aktualitätsbezug. Der
  Nachweis ist an den geprüften Commit oder dokumentierten Arbeitsbaum
  gebunden; Prüfergebnisse führen Befehl, Zeitpunkt und Ergebnis, veränderliche
  externe Quellen zusätzlich Quelle und Abrufdatum.
- **Risikoentscheidung / Risk Decision**: Priorität, Risiko, Restrisiko, Owner
  und Re-Evaluation-Trigger für nicht vollständig belegte Punkte. Priorität
  und Restrisiko verwenden `High`, `Medium` oder `Low`; Risiko und Restrisiko
  enthalten jeweils eine kurze Begründung.
- **Folgeaktion / Follow-Up Action**: Begrenzte, separat zu autorisierende
  Klärungs- oder Umsetzungsarbeit, die nicht in dieser Selbstprüfung versteckt
  erledigt wird.
- **Ergebnisartefakt / Result Artefact**: Vollständig bilinguale,
  textorientierte Matrix oder Zusammenfassung für Maintainer,
  Ausbildungsverantwortliche und Auszubildende.

## Erfolgskriterien / Success Criteria

### Messbare Ergebnisse / Measurable Outcomes

- **SC-001**: 12 von 12 Checklisten und 157 von 157 stabilen
  Checklistenpunkten sind jeweils genau einmal sichtbar abgedeckt. Zusätzliche
  Prüfpunkte ohne stabile ID besitzen eindeutige Matrix-IDs; es gibt null durch
  Querverweise erzeugte Duplikatzeilen.
- **SC-002**: 15 von 15 im Baseline-Manifest geführten mitgeltenden Dokumenten
  sind in der Prüfung repräsentiert.
- **SC-003**: 8 von 8 Standard-Presets und 3 von 3 optionalen Intake-Presets
  sind korrekt unterschieden und bewertet.
- **SC-004**: 100 Prozent der Matrixzeilen besitzen Prüfpunkt-ID, normative
  Quelle, Workflow-Status und Begründung; 100 Prozent erfüllen zusätzlich den
  jeweiligen statusabhängigen Feldvertrag.
- **SC-005**: 100 Prozent der Quellen mit getrenntem Statusmodell besitzen
  sowohl Anwendbarkeits- als auch Umsetzungsstatus.
- **SC-006**: Null positive Einhaltungs-, Wirksamkeits- oder
  Erfüllungsbehauptungen bleiben ohne konkreten Evidenzpfad.
- **SC-007**: 100 Prozent der `Open`- und `FollowUp`-Punkte besitzen Owner,
  Aktion, Priorität, Risiko und Re-Evaluation-Trigger.
- **SC-008**: Alle verpflichtenden Sicherheits-, Architektur-, A11Y-,
  Cross-Platform-, Agent-Parity-, Intake- und Autonomous-Governance-
  Checkpoints besitzen eine sichtbare `Applicable`-, `AlreadySatisfied`-,
  `N/A`-, `Open`- oder `FollowUp`-Entscheidung.
- **SC-009**: Deutsche und englische Ergebnisabschnitte enthalten 100 Prozent
  derselben Entscheidungen, Grenzen, Risiken, Evidenzen und nächsten Aktionen.
- **SC-010**: Eine repräsentative Person ohne Spec-Kit-Vorerfahrung kann in
  höchstens fünf Minuten Status, Evidenz, Risiko und nächste Aktion eines
  ausgewählten Prüfpunkts finden.
- **SC-011**: Null Produktcode-, Runtime-, API-, Dependency-, Toolchain-,
  Skript-, Provider- oder gemeinsame Agent-Guidance-Änderungen werden durch
  dieses Feature eingeführt.
- **SC-012**: Alle vor dem Feature grünen, durch den tatsächlichen Diff
  ausgelösten lokalen Prüfungen bleiben grün; Abweichungen werden als Findings
  statt als Erfolg behandelt.
- **SC-013**: 100 Prozent der Matrixzeilen besitzen genau einen Workflow-
  Status; null Zeilen verletzen die festgelegte Status-Vorrangregel.
- **SC-014**: 100 Prozent der `AlreadySatisfied`-Zeilen besitzen einen
  fachlich passenden und an Commit oder dokumentierten Arbeitsbaum gebundenen
  Nachweis; Prüfergebnisse und veränderliche externe Quellen erfüllen zu 100
  Prozent ihre zusätzlichen Aktualitätsfelder.
- **SC-015**: 100 Prozent der erforderlichen Prioritäts- und Restrisikofelder
  verwenden `High`, `Medium` oder `Low`; null Risiko- oder Restrisikoeinträge
  bleiben ohne kurze Begründung.
- **SC-016**: 100 Prozent der nicht erreichbaren erforderlichen externen
  Quellen erzeugen einen vollständigen `Open`-Eintrag; null Selbstprüfungen
  brechen allein wegen der Nichterreichbarkeit einer externen Quelle ab.

## Annahmen / Assumptions

- Die Baseline 3.2.0, Richtlinie 3.2.0, 157 stabilen IDs und das Mapping 1.3.0
  bilden zum Start den fachlichen Ist-Stand und werden vor Planung erneut auf
  Drift geprüft.
- Die Feature-024-Evidenz belegt die Vollständigkeit der Zuordnungsoberfläche,
  nicht automatisch die Erfüllung jedes projektspezifischen Kontrollpunkts.
- Bestehende Dateien unter `docs/security/` können Stubs oder featurebezogene
  Nachweise sein und gelten nur für die Aussage, die sie tatsächlich belegen.
- Grundlegende Git-, Markdown- und Repository-Kenntnisse sind vorhanden;
  Spec-Kit- und Sicherheitsabkürzungswissen ist nicht vorausgesetzt.
- Eine Selbstprüfung darf ein korrektes `AlreadySatisfied`- oder `N/A`-Ergebnis
  liefern und muss keine künstliche Härtungsänderung erzeugen.
- Historische Evidenz wird nicht redaktionell geändert; neue Erkenntnisse
  verweisen auf sie und nennen ihre Aussagegrenze.

## Autonomous-Run-Anwendbarkeit / Autonomous-Run Applicability

- **Beabsichtigter Delivery Mode**: `MergeAndSync`, verbindlich aus der
  aktuellen Benutzeranweisung und dem supersedierenden `Ready`-Intake.
  Commit, Push, PR und Merge sind fuer Feature 025 autorisiert. Der enge
  Admin-Bypass gilt nur bei gruenen technischen Gates, null umsetzbaren
  Review-Threads und Human Approval als einzigem offenen Gate. Secret- oder
  Provider-Administration bleibt ausgeschlossen.
- **Akzeptierte Eingaben**: verbindlicher Intake und `Ready`-Review,
  Feature-024-Quelle und PR-Evidenz, aktives Series-Manifest, Baseline-Manifest
  sowie die elf installierten Governance-Presets.
- **Autonomiegrenze**: genau ein Repository; keine automatische Härtung, kein
  Sammellauf, keine Änderung fremder oder schmutziger Arbeitsbäume und kein
  Start eines Nachfolgeintakes.
- **Causal Closeout**: nach dem gemergten Feature-PR erforderlich,
  weil Position 6 archiviert und die Series kausal fortgeschrieben werden
  muss. Der Closeout darf nur Evidence, Intake-Archiv, Series, Reihenfolge,
  Run-State, Retrospektive und Statistik kausal fortschreiben.
- **Mutable Validation Tokens**: `Applicable`; Feature-Head, Checks,
  Review-Threads, Mergebarkeit und Default-Branch-Synchronisierung werden vor
  jeder Remote-Aktion frisch gebunden.
- **Run-State-Pfad**: Ein später ausdrücklich gestarteter Autonomous-Lauf
  verwendet `specs/025-rl-se-self-assessment/autonomous-run-state.json`.
- **Stop/Resume**: Ein bewusster Stop endet an einer sicheren Artefaktgrenze;
  ein unerwarteter Abbruch erfordert vollständige Drift-, Authority- und
  Evidence-Revalidierung vor Resume.

| Gate-ID | Status | Erforderlicher Umfang / Required Scope | Stabiler Prüftoken / Stable Check Token | Begründung oder Trigger / Rationale or Trigger |
|---|---|---|---|---|
| `RLSEG-BASELINE` | `Applicable` | Baseline, 12 Checklisten, 157 IDs, 15 Dokumente, Mapping | `secure-development-baseline` | Muss bei Baseline-/Mapping-Drift erneut laufen |
| `RLSEG-MATRIX` | `Applicable` | Gemeinsame und statusabhängige Pflichtfelder | `assessment-matrix-contract` | Muss nach jeder Matrixänderung erneut laufen |
| `RLSEG-EVIDENCE` | `Applicable` | Positive Claims, Pfade, Human-only-Grenzen | `evidence-integrity` | Muss nach jeder Evidenzänderung erneut laufen |
| `RLSEG-A11Y` | `Applicable` | DE/EN-Parität, CEFR B2, text-first, WCAG 2.2 AA | `a11y-bilingual-review` | Muss nach jeder Nutzertextänderung erneut laufen |
| `RLSEG-REGRESSION` | `Applicable` | Alle durch den tatsächlichen Diff ausgelösten Repo-Gates | `repository-regression` | Umfang wird im Plan aus dem Diff abgeleitet |
| `RLSEG-REMOTE` | `Applicable` | Provider-, PR-, Review-, Exact-Head-, Merge- und Default-Branch-Gates | `feature-025-exact-head` | Vor Push, PR, Merge und nach jedem Head-Wechsel erneut prüfen |
| `RLSEG-PARALLEL` | `N/A` | Parallelkampagne | `N/A` | Ein Repository und ein Writer; Trigger ist expliziter Kampagnenauftrag |

## Agenten-Parität / Agent Parity Applicability

- Die Selbstprüfung liest gemeinsame Agent-Guidance als mögliche Evidenz,
  ändert aber keine gemeinsame Regel. Änderungen an `AGENTS.md`, `CLAUDE.md`,
  `GEMINI.md`, `.github/copilot-instructions.md` oder
  `.github/agents/copilot-instructions.md` sind daher `N/A`.
- `.specify/memory/constitution.md`, Projekt-Templates und Modellrouting bleiben
  unverändert. Re-Evaluation erfolgt, wenn ein Finding eine gemeinsame Regel-
  oder Templateänderung verlangt; diese Änderung benötigt separate Autorität
  und vollständige Parität.
- Es gibt keine intentionale Abweichung zwischen Agentenoberflächen.

## Audit-Evidence-Anwendbarkeit / Audit Evidence Applicability

Die Spezifikation führt die folgende Feature-Level-Entscheidung. Die spätere
vollständige Prüfpunktmatrix verwendet denselben Statusvertrag und ergänzt bei
Quellen mit getrenntem Modell beide Statusachsen.

| Checkpoint | Status | Evidenz-/Folgevertrag / Evidence or Follow-Up Contract |
|---|---|---|
| Feature-024-Vorgänger | `AlreadySatisfied` | `specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md` |
| Aktuelles Intake Review | `AlreadySatisfied` | `specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json` |
| Baseline-, Checklisten- und Dokumentabdeckung | `Applicable` | Geplanter Pfad RLSE-017; Owner: home-baseline Maintainer; Priorität: High; Risiko: stille Kontrolllücke; Trigger: Baseline- oder Mapping-Drift |
| NIST SSDF und CWE Top 25 | `Applicable` | Geplanter Pfad RLSE-017; Owner: Security Reviewer; Priorität: High; Risiko: unvollständiger Secure-SDLC-/Schwachstellenblick; Trigger: jede relevante Baseline- oder Codeflächenänderung |
| OWASP ASVS | `N/A` | Kein Web-/API-/HTTP-/Auth-Delta; Trigger: entsprechender Scope oder Finding |
| SBOM, VEX und SLSA | `Applicable` | Vorhandene Lieferketten-Evidenz bewerten; Owner: Release/Security Maintainer; Priorität: High; Risiko: intransparente Artefakte; Trigger: Release-, Dependency- oder Buildänderung |
| OpenSSF Scorecard | `Applicable` | Öffentliches Repository prüfen; Owner: Repository Maintainer; Priorität: Medium; Risiko: unerkannte OSS-Governance-Lücke; Trigger: Release oder neue Hochrisikoabhängigkeit |
| AI-SBOM | `N/A` | KI nur Entwicklungswerkzeug; Trigger: KI-Modell, Dienst, Datensatz oder Inferenz im Produkt/Runtime-Scope |
| STRIDE/CIA und CAPEC | `N/A` | Keine neue Trust Boundary oder Architekturänderung; Trigger: externer Datenfluss, privilegierte Grenze oder Runtime-Finding |
| Zero Trust, BSI C3A und BSI C5 | `N/A` | Nur generische Repository-/CI-Entwicklungsinfrastruktur; Trigger: Cloud-Runtime, Managed Service, Remote-Access- oder Provider-Auswahl |
| OWASP SAMM | `Applicable` | Bestehendes Assessment bewerten; Owner: Security Governance Maintainer; Priorität: Medium; Risiko: stagnierende Verbesserungsplanung; Trigger: Audit, Incident oder Baseline-Änderung |
| NIS2, CRA, EU AI Act und DORA | `Applicable` | Regulatorische Anwendbarkeit prüfen; Owner: home-baseline Maintainer mit fachlicher Rechtsprüfung bei Bedarf; Priorität: Medium; Risiko: falscher Compliance-Claim; Trigger: Marktprodukt, regulierter Kunde, AI-Runtime oder Finanzsektor-Abhängigkeit |
| WCAG 2.2 AA und Sprachparität | `Applicable` | Geplanter Pfad RLSE-017; Owner: Documentation/A11Y Reviewer; Priorität: High; Risiko: unzugängliche oder widersprüchliche Ergebnisse; Trigger: Nutzertextänderung |
| Cross-Platform-Skriptänderung | `N/A` | Kein neues oder geändertes Skript; Trigger: Script-shaped Tool oder Plattformlogik im Scope |
| Agent-Guidance-Änderung | `N/A` | Keine gemeinsame Regeländerung; Trigger: Finding mit Guidance-/Templatebedarf |
| Projektstatistik | `Applicable` | Canonical Config plus Renderer bei Feature-Abschluss; Owner: home-baseline Maintainer; Priorität: Low; Risiko: Statistikdrift; Trigger: abgeschlossene Phase |

## Plattformübergreifende Anwendbarkeit / Cross-Platform Applicability

- Das Feature fügt kein script-shaped Tool hinzu, ändert keines und entfernt
  keines. Bash-/PowerShell-Varianten, neue Manpage, neues Cmdlet und neue
  `--dry-run`-/`-WhatIf`-Oberflächen sind daher `N/A`.
- Bestehende plattformübergreifende Skripte und Prüfungen bleiben mögliche
  Evidenz und werden nur ausgeführt, wenn der tatsächliche Diff ihren
  dokumentierten Trigger auslöst.
- Re-Evaluation erfolgt, wenn Planung oder ein Finding neue Automatisierung
  verlangt. Eine solche Scope-Erweiterung benötigt eine ausdrückliche
  Entscheidung und dann vollständige Bash-/PowerShell-, Manpage-,
  Verb-Noun-, Hilfe- und Safe-Mode-Parität.

## Barrierefreiheitsanwendbarkeit / Accessibility Applicability

- Betroffene Nutzerartefakte sind Spezifikation, Evidenzmatrix,
  Abschlusszusammenfassung, Security-Index-Einstieg und spätere Plan-/Task-
  Artefakte.
- Vollständiges Deutsch zuerst und Englisch danach ist inline erforderlich;
  beide Sprachspuren enthalten denselben fachlichen Inhalt.
- WCAG 2.2 Level AA ist für anwendbare Text-, Struktur-, Überschriften-, Link-
  und Tabellenkriterien verbindlich. Status darf nicht nur durch Farbe,
  Symbol, Diagramm oder Position vermittelt werden.
- CEFR B2 ist das Lesbarkeitsziel. Fachbegriffe werden bei der ersten
  Verwendung erklärt; erstmals Nutzende von Spec Kit sind eingeschlossen.
- Codeblöcke erhalten Sprachkennzeichnung; ASCII-Diagramme oder Bilder sind
  nicht erforderlich. Werden sie später ergänzt, brauchen sie eine kurze
  vollständige DE-/EN-Textalternative.
- Didaktische Inline-Code-Kommentare sind `N/A`, weil keine Programmlogik
  geändert wird. Trigger ist eine spätere Code- oder Skriptänderung.
- Ein separates Update unter `docs/accessibility/` ist `N/A`, weil die datierte
  Assessment-Evidence ihren A11Y-Nachweis selbst enthält. Trigger ist eine UI-,
  HTML-, CLI- oder zentrale A11Y-Regeländerung.

## Architekturanwendbarkeit / Architecture Applicability

- Systemkontext, Schnittstellen, Bausteine, Runtime-Verhalten, Deployment und
  technische Schulden werden durch dieses Feature nicht verändert.
- Architekturziele sind daher auf Evidenztreue, Nachvollziehbarkeit,
  Änderbarkeit und barrierearme Lesbarkeit der Prüfartefakte begrenzt.
- Neue Architektur-Evidence unter `docs/architecture/`, allgemeine ADRs und
  Architektur-Risikoeinträge sind `N/A`. Trigger ist ein Finding, das eine
  architekturrelevante Änderung statt einer dokumentierten Folgeaktion verlangt.
- Sicherheitsrelevante bestehende Architektur bleibt Prüfgegenstand, aber die
  Selbstprüfung ersetzt oder verändert keine Architekturentscheidung.

## Sichere Architekturanwendbarkeit / Architecture Governance Applicability

- Runtime-, Hardware- und Plattformzwänge beeinflussen keine neue
  Sprachwahl, weil keine Programmlogik entsteht.
- Es werden keine Trust Boundaries erzeugt, entfernt oder verändert und keine
  neuen Datenflüsse klassifiziert.
- STRIDE+CIA, CAPEC, S-ADR, arc42 Section 8, Security-Quality-Szenarien,
  Zero Trust, OWASP SAMM-Änderungsplan sowie BSI C3A/C5-Architekturupdates sind
  für das Feature-Delta `N/A`. Bestehende Dokumente werden als Evidenz geprüft.
- Re-Evaluation erfolgt bei Runtime-, Authentifizierungs-, Autorisierungs-,
  Netzwerk-, Cloud-, Deployment- oder sensiblen Datenfluss-Findings.

## Sicherheitsgovernance-Anwendbarkeit / Security Governance Applicability

- **Primäre Implementierungssprache**: `N/A`; das Feature erzeugt keine neue
  Programmlogik. Damit entsteht weder eine neue MSL- noch eine Non-MSL-
  Entscheidung. Vorhandene Sprachen und ihre Secure-Coding-Regeln bleiben Teil
  der Selbstprüfung.
- **Secure Development**: NIST SSDF, CWE Top 25, sichere Entwicklungsumgebung,
  Security Review und Evidenzhygiene sind `Applicable` als Prüfrahmen.
- **Web/Application Security**: OWASP ASVS ist für das Feature-Delta `N/A`;
  vorhandene web-/auth-bezogene Flächen würden den Punkt in der Matrix neu
  auslösen.
- **Supply Chain**: SBOM, VEX, SLSA, Dependency-Audit und OpenSSF Scorecard sind
  als bestehende Repository-/Release-Prüfflächen `Applicable`; das Feature
  erzeugt keine neue Abhängigkeit oder Distribution.
- **AI**: KI wird nur als Entwicklungswerkzeug genutzt; AI-SBOM ist mit dem in
  CR-009 genannten Trigger `N/A`.
- **Regulierung**: CRA-, NIS2-, EU-AI-Act- und DORA-Anwendbarkeit wird geprüft,
  ohne Rechts- oder Zertifizierungsbehauptung zu erfinden.
- **Security-Evidence**: Geplant sind die Markdown-Artefakte aus RLSE-017.
  Bestehende `docs/security/`-Dateien werden referenziert oder als Stub/
  unzureichend klassifiziert; sie werden nicht automatisch gehärtet.
- **Secrets und Datenschutz**: Rohdaten werden auf private Pfade, Secrets,
  Tokens und unnötige personenbezogene Daten begrenzt; Ergebnisartefakte
  enthalten nur veröffentlichbare Evidenz.

## Dokumentationsauswirkung / Documentation Impact

- **Entscheidung**: `UpdateRequired`.
- **Betroffene Zielgruppen**: Maintainer, Ausbildungsverantwortliche,
  Security-/A11Y-Reviewer und sekundär Auszubildende.
- **Leserpfade**: `docs/security/README.md` zur datierten Selbstprüfung;
  Spezifikation zu Matrix und Abschlusszusammenfassung.
- **Kanonische Quellen und Owner**: Baseline-Manifest und zwölf Checklisten
  bleiben fachliche Quellen; die datierte Matrix ist Feature-Evidence. Owner
  ist der home-baseline Maintainer, fachliche Reviews erfolgen durch die
  benannten Security-/A11Y-Rollen.
- **Navigation**: Der Security-Index erhält bei Umsetzung einen direkten Link;
  historische Feature-024-Evidence bleibt unverändert.
- **Dokumentklasse und Sprache**: `sourceOnly`, vollständiges Deutsch zuerst
  und Englisch danach, CEFR B2; kein Home Sync.
- **Plattform-/Beispielnachweis**: Nur durch den tatsächlichen Diff ausgelöste
  macOS-/Linux-/Windows-Gates werden verlangt; die Ergebnislogik selbst bleibt
  plattformneutral und textorientiert.
- **Evidence**: `specs/025-rl-se-self-assessment/spec.md`,
  `specs/025-rl-se-self-assessment/checklists/requirements.md` und die in
  RLSE-017 geplanten Markdown-Artefakte.
- **Re-Evaluation-Trigger**: Baseline-, Preset-, Zielgruppen-, A11Y-,
  Architektur-, Runtime-, Distributions- oder Delivery-Authority-Änderung.

---

# Complete English Version

This section is the complete English counterpart of the German-first
specification above. The requirement IDs, decisions, boundaries, risks,
evidence paths, and next-phase conditions are normative and identical in both
language tracks.

**Feature Branch**: `025-rl-se-self-assessment`
**Created**: 2026-08-05
**Status**: Ready for Planning
**Input**: `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`
**Binding Review**: `specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json`
**Predecessor Evidence**: `specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md`
**Position**: 6, root and sole preferred `Eligible` candidate
**Delivery Authority**: `MergeAndSync`

## User Scenarios and Testing

### User Story 1 - Complete the Self-Assessment (Priority: P1)

Maintainers and training leads can assess the current Level 0 repository
against the Secure Development Guideline, all twelve checklists, the
compendium, related documents, and installed governance presets without
reimplementing controls that are already proven.

**Why this priority**: Complete and traceable coverage is the core feature
value and the basis for every later hardening decision.

**Independent Test**: A coverage review reports exactly 157 stable checklist
items, twelve checklists, and fifteen related documents and maps every relevant
checkpoint to exactly one matrix row.

**Acceptance Scenarios**:

1. **Given** baseline 3.2.0 and the completed Feature 024 mapping, **When** the
   self-assessment is completed, **Then** every relevant checkpoint is visible
   with an ID, normative source, status, and rationale.
2. **Given** a checkpoint that is already proven, **When** it is assessed,
   **Then** it receives `AlreadySatisfied` and a concrete evidence path without
   requiring new implementation.
3. **Given** a checkpoint that does not apply, **When** it is assessed,
   **Then** it receives `N/A`, a professional or technical rationale, and a
   re-evaluation trigger.

### User Story 2 - Distinguish Gaps and Follow-Up Safely (Priority: P1)

Reviewers can distinguish unresolved, unproven, and deliberately deferred
items. Positive claims remain bound to current evidence, and human approval is
never fabricated.

**Why this priority**: A self-assessment is trustworthy only when uncertainty,
risk, and responsibility remain visible.

**Independent Test**: Every `Open` and `FollowUp` row contains an owner, action,
priority, risk, and re-evaluation trigger; every positive claim references
verifiable evidence.

**Acceptance Scenarios**:

1. **Given** an applicable but insufficiently proven checkpoint, **When** it is
   assessed, **Then** its status is `Open` and every responsibility and risk
   field is complete.
2. **Given** a relevant checkpoint outside the current run, **When** it is
   bounded, **Then** its status is `FollowUp` and the later action is justified.
3. **Given** a control that only a human may decide, **When** no human evidence
   exists, **Then** it is not reported as fulfilled.

### User Story 3 - Understand Results Accessibly (Priority: P2)

Maintainers, training leads, and apprentices can understand status, evidence,
risks, and next actions without prior Spec Kit experience and without relying
on visual-only information.

**Why this priority**: The results support governance and training and must
remain fully usable in text-oriented assistive setups.

**Independent Test**: Complete results are available in German first and
English second at CEFR-B2 level; tables, status values, and next actions remain
understandable without colour, diagrams, or spatial position.

**Acceptance Scenarios**:

1. **Given** a person without Spec Kit experience, **When** they read the
   summary, **Then** they can find purpose, status logic, residual risks, and
   the next action without an external glossary.
2. **Given** a screen reader or text browser, **When** the matrix is read,
   **Then** row identity, status, and evidence remain unambiguous.
3. **Given** the German and English tracks, **When** they are compared,
   **Then** they contain the same decisions, boundaries, risks, evidence, and
   next actions.

### User Story 4 - Plan Bounded Improvement (Priority: P3)

Maintainers can derive prioritized follow-up work without this feature
automatically changing product code, runtime, scripts, provider configuration,
or other repositories.

**Why this priority**: The self-assessment enables safe decisions and must not
silently become a hardening or fleet run.

**Independent Test**: The completion summary separates `AlreadySatisfied`,
current gaps, and bounded follow-up; the Git diff contains no automatic
hardening or cross-repository mutation.

**Acceptance Scenarios**:

1. **Given** a security finding that requires implementation, **When** the
   feature completes, **Then** it is recorded as `Open` or `FollowUp` and is
   not silently remediated.
2. **Given** a finding in another repository, **When** it is recorded,
   **Then** it remains a referenced follow-up and starts no campaign.

### Edge Cases

- An evidence path exists but is stale, no longer hash-bound, or proves a
  different claim than the matrix row.
- A rule is mandatory for Level 2 projects but only relevant to this Level 0
  repository as reusable governance.
- A checkpoint has both applicability and implementation state; the two axes
  must not be collapsed into one positive status.
- A generated compendium conflicts with a canonical checklist.
- A positive claim depends on human approval, an audit, or an organisational
  effectiveness review.
- A matrix row touches several normative sources; one primary source and
  traceable cross-references must remain visible.
- A technical term is correct but is not explained for the declared audience
  at first use.
- A table works visually but loses the checkpoint-to-status-to-evidence
  relationship during linear reading.
- Raw evidence contains a local/private path, token, personal value, or
  provider detail that must not appear in the result.
- Baseline, mapping, or preset versions change during the feature and require
  revalidation of the accepted current state.
- A required external evidence source is unavailable. The affected checkpoint
  is recorded as `Open` with source, owner, risk, and re-evaluation trigger,
  while the remaining self-assessment continues.

## Requirements

### Functional Requirements

- **RLSE-001**: The feature MUST use the completed item-5 baseline and its PR
  evidence as binding current state before any professional assessment.
- **RLSE-002**: The feature MUST assess exactly the current `home-baseline`
  repository and MUST NOT start a campaign across other repositories.
- **RLSE-003**: The feature MUST completely cover Secure Development Guideline
  3.2.0, baseline manifest 3.2.0, twelve canonical checklists, 157 stable
  checklist items, compendium 2.2.0, fifteen related documents, and the current
  mapping document.
- **RLSE-004**: The feature MUST distinguish the public eight-preset default
  from the managed eleven-preset profile and include all eleven currently
  installed presets as assessment inputs.
- **RLSE-005**: Every result row MUST contain a unique checkpoint ID, normative
  source, exactly one workflow status, and a short rationale.
- **RLSE-006**: Workflow status MUST use exactly one of `Applicable`,
  `AlreadySatisfied`, `N/A`, `Open`, or `FollowUp`.
- **RLSE-007**: Every `Applicable` row MUST contain a planned evidence or
  implementation path, owner, priority, risk, and re-evaluation trigger.
- **RLSE-008**: Every `AlreadySatisfied` row MUST contain a concrete, current
  evidence path that proves the stated claim.
- **RLSE-009**: Every `N/A` row MUST contain a professional or technical
  rationale and a re-evaluation trigger.
- **RLSE-010**: Every `Open` row MUST contain an owner, clarification or
  follow-up action, priority, risk, and re-evaluation trigger.
- **RLSE-011**: Every `FollowUp` row MUST contain an owner, justified later
  action, priority, risk, and re-evaluation trigger.
- **RLSE-012**: Where a normative source requires separate applicability and
  implementation axes, the matrix MUST additionally record `Applicable`,
  `N/A`, or `Open` separately from `Fulfilled`, `Partly Fulfilled`,
  `Not Fulfilled`, or `Not Assessed`.
- **RLSE-013**: Positive compliance, effectiveness, or fulfilment claims MUST
  rely on concrete evidence; missing human evidence MUST remain visible.
- **RLSE-014**: The feature MUST assess at least MSL status, secure interfaces,
  input/output boundaries, input validation, error handling, authentication,
  authorisation, cryptography, logging, dependencies, build/release, sandbox,
  and agentic development where those surfaces exist in the target repository.
- **RLSE-015**: The feature MUST visibly assess or provide a status-compliant
  boundary for NIST SSDF, CWE Top 25, OWASP ASVS, OWASP SAMM, STRIDE/CAPEC,
  Zero Trust, BSI C3A/C5, SBOM, VEX, SLSA, OpenSSF Scorecard, AI-SBOM, NIS2,
  CRA, EU AI Act, and DORA.
- **RLSE-016**: The feature MUST review existing evidence under
  `docs/security/`, tests, CI, reviews, and Spec Kit artefacts without treating
  stub documents as fulfilled controls automatically.
- **RLSE-017**: The feature MUST plan the complete evidence matrix at
  `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md`
  and the completion summary beside it as `assessment-summary.md`.
- **RLSE-018**: The completion summary MUST contain the outcome, coverage,
  open risks, residual risks, owners, follow-up actions, and re-evaluation
  triggers.
- **RLSE-019**: User-facing result artefacts MUST provide the complete content
  in German first and English second, remain text-first, target WCAG 2.2 AA,
  and use CEFR-B2 language.
- **RLSE-020**: Terms and abbreviations MUST be explained at first use. Basic
  Git, Markdown, and repository knowledge may be assumed; Spec Kit and security
  abbreviation knowledge may not.
- **RLSE-021**: Private paths, secrets, production tokens, unnecessary personal
  data, and unverified provider details MUST be excluded from result artefacts.
- **RLSE-022**: The feature MUST preserve current build, test, documentation,
  and governance behaviour and visibly report any triggered regression.
- **RLSE-023**: The feature MUST complete without automatic product-code,
  runtime, API, dependency, toolchain, script, provider, or agent-guidance
  hardening.
- **RLSE-024**: Findings that require implementation MUST be recorded as
  `Open` or `FollowUp` with the complete field contract and MUST require
  separate authorization outside this feature.
- **RLSE-025**: Result navigation MUST lead from `docs/security/README.md` to
  the dated assessment without reinterpreting canonical baseline documents or
  historical evidence.
- **RLSE-026**: The feature MUST record exactly one Documentation Impact
  decision and update project statistics through the canonical configuration
  and renderer after feature completion.
- **RLSE-027**: After successful completion, the feature MUST causally archive
  item 6 and update the Series but MUST NOT start a successor intake.
- **RLSE-028**: Each of the 157 stable checklist IDs MUST identify exactly one
  matrix row. A checkpoint without a stable checklist ID MUST receive an
  additional ID that is unique within the matrix namespace. Cross-references
  to multiple normative sources MUST remain in that same row and MUST NOT
  create a duplicate row.
- **RLSE-029**: When several workflow statuses appear suitable, the matrix MUST
  apply exactly this precedence rule: `N/A` when not applicable; otherwise
  `AlreadySatisfied` when current evidence exists; otherwise `FollowUp` when
  deliberately out of scope; otherwise `Open` when unresolved or
  insufficiently evidenced; otherwise `Applicable`.
- **RLSE-030**: Current evidence MUST be bound to the assessed commit or a
  documented working-tree state. Reproducible check results MUST state the
  command, check time, and outcome. Mutable external evidence MUST additionally
  state its source and retrieval date. If any applicable required field is
  missing, the checkpoint MUST NOT be classified as `AlreadySatisfied`.
- **RLSE-031**: Every required priority field and every required residual-risk
  field MUST use exactly one of `High`, `Medium`, or `Low`. Every risk
  description and every residual risk MUST additionally include a short,
  professionally traceable rationale.
- **RLSE-032**: Local repository evidence MUST be the primary evidence source.
  If a required external source is unavailable, the affected checkpoint MUST
  be recorded as `Open` with source, owner, risk, and re-evaluation trigger.
  That failure alone MUST NOT abort the remaining self-assessment.

### Constitution Requirements

- **CR-001**: The Level 2 Environment Registry is `N/A` for this Level 0
  assessment. Re-evaluate when a later repository-specific intake selects a
  Level 2 target.
- **CR-002**: Accessibility is `Applicable`: WCAG 2.2 AA, linear text use,
  screen-reader/Braille/text-browser usability, and complete DE/EN parity form
  the review baseline.
- **CR-003**: Audience and prior knowledge from the intake are binding; terms
  are explained at first use at CEFR-B2 level.
- **CR-004**: Project statistics are `Applicable` as a deterministic generated
  update at feature completion. Shared agent guidance is `N/A` without a rule
  change.
- **CR-005**: A primary implementation language is `N/A` because the feature
  assesses documentation and evidence only and creates no program logic. MSL
  status of existing code surfaces remains an assessment checkpoint.
  Re-evaluate for any code or script change.
- **CR-006**: NIST SSDF and CWE Top 25 are `Applicable` as assessment frames.
  Context-dependent standards and regulations are never silently omitted.
- **CR-007**: OWASP ASVS is `N/A` for the feature delta because no web, API,
  HTTP, authentication, or authorisation service changes. Re-evaluate for such
  a finding or scope delta.
- **CR-008**: SBOM, VEX, and SLSA are `Applicable` as existing supply-chain
  assessment subjects; the feature creates no release artefact or dependency.
- **CR-009**: AI-SBOM is `N/A` because AI is development tooling only and no
  model, service, dataset, or inference component enters the released or
  operated system. Re-evaluate for AI runtime or product scope.
- **CR-010**: New trust boundaries, external data flows, and distributed
  architecture are `N/A` because runtime architecture does not change.
  Existing architecture and threat evidence remain assessment inputs.
- **CR-011**: The default evidence location is the dated `docs/security/` path
  in RLSE-017; missing canonical security documents become `Open` or
  `FollowUp` rather than being silently populated.
- **CR-012**: All eleven installed governance presets are `Applicable` as
  assessment surfaces. Parallel Autonomous is `N/A` as an execution mode
  because one repository and one writer are in scope.
- **CR-013**: Documentation Impact is `UpdateRequired` for the dated
  assessment, Security index entry, completion evidence, and statistics.
  Distribution remains `sourceOnly`; Home Sync is not required.

### Key Entities

- **Assessment Baseline**: The versioned set of guideline, baseline manifest,
  checklists, compendium, related documents, Constitution, and preset profiles.
- **Assessment Checkpoint**: A unique ID, normative source, workflow status,
  rationale, and—where required—separate applicability and implementation
  axes. One stable checklist ID identifies exactly one matrix row; additional
  checkpoints use unique IDs in the same matrix namespace.
- **Evidence Record**: A concrete repository path or reproducible check result
  with a defined claim boundary and freshness context. It is bound to the
  assessed commit or documented working tree; check results state command,
  time, and outcome, while mutable external sources additionally state source
  and retrieval date.
- **Risk Decision**: Priority, risk, residual risk, owner, and re-evaluation
  trigger for an item that is not fully proven. Priority and residual risk use
  `High`, `Medium`, or `Low`; risk and residual risk each include a short
  rationale.
- **Follow-Up Action**: Bounded clarification or implementation work that
  requires separate authorization and is not silently completed here.
- **Result Artefact**: A fully bilingual, text-first matrix or summary for
  maintainers, training leads, and apprentices.

## Success Criteria

- **SC-001**: 12 of 12 checklists and 157 of 157 stable checklist items are
  each visibly covered exactly once. Additional checkpoints without a stable
  ID have unique matrix IDs, and cross-references create zero duplicate rows.
- **SC-002**: 15 of 15 related documents listed in the baseline manifest are
  represented in the assessment.
- **SC-003**: 8 of 8 default presets and 3 of 3 optional intake presets are
  correctly distinguished and assessed.
- **SC-004**: 100 percent of matrix rows have a checkpoint ID, normative
  source, workflow status, and rationale; 100 percent also satisfy the
  status-dependent field contract.
- **SC-005**: 100 percent of sources with a separate status model have both an
  applicability and implementation state.
- **SC-006**: Zero positive compliance, effectiveness, or fulfilment claims
  remain without a concrete evidence path.
- **SC-007**: 100 percent of `Open` and `FollowUp` items have an owner, action,
  priority, risk, and re-evaluation trigger.
- **SC-008**: Every mandatory Security, Architecture, A11Y, Cross-Platform,
  Agent Parity, Intake, and Autonomous Governance checkpoint has a visible
  `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, or `FollowUp` decision.
- **SC-009**: German and English result sections contain 100 percent of the
  same decisions, boundaries, risks, evidence, and next actions.
- **SC-010**: A representative person without prior Spec Kit experience can
  locate status, evidence, risk, and next action for a selected checkpoint in
  no more than five minutes.
- **SC-011**: The feature introduces zero product-code, runtime, API,
  dependency, toolchain, script, provider, or shared agent-guidance changes.
- **SC-012**: Every pre-feature local check triggered by the actual diff
  remains green; deviations are reported as findings rather than success.
- **SC-013**: 100 percent of matrix rows have exactly one workflow status, and
  zero rows violate the defined status precedence rule.
- **SC-014**: 100 percent of `AlreadySatisfied` rows have professionally
  matching evidence bound to a commit or documented working tree; check
  results and mutable external sources satisfy 100 percent of their additional
  freshness fields.
- **SC-015**: 100 percent of required priority and residual-risk fields use
  `High`, `Medium`, or `Low`; zero risk or residual-risk entries lack a short
  rationale.
- **SC-016**: 100 percent of unavailable required external sources produce a
  complete `Open` record, and zero self-assessments abort solely because an
  external source is unavailable.

## Assumptions

- Baseline 3.2.0, Guideline 3.2.0, the 157 stable IDs, and mapping 1.3.0 are the
  professional current state at feature start and are revalidated for drift
  before planning.
- Feature 024 evidence proves completeness of the mapping surface, not
  automatic fulfilment of every repository-specific control.
- Existing `docs/security/` files may be stubs or feature-specific evidence and
  count only for the claim they actually prove.
- Basic Git, Markdown, and repository knowledge exists; Spec Kit and security
  abbreviation knowledge does not.
- A valid self-assessment may return `AlreadySatisfied` or `N/A` and need not
  manufacture a hardening change.
- Historical evidence is not editorially changed; new findings reference it
  and state its proof boundary.

## Autonomous-Run Applicability

- **Intended Delivery Mode**: `MergeAndSync`, binding from the current user
  instruction and superseding Ready intake. Commit, push, PR, and merge are
  authorized for Feature 025. The narrow admin bypass is allowed only with
  green technical gates, zero actionable review threads, and Human Approval as
  the sole open gate. Secret or provider administration remains excluded.
- **Accepted Inputs**: binding intake and `Ready` review, Feature 024 source and
  PR evidence, active Series manifest, baseline manifest, and eleven installed
  governance presets.
- **Autonomy Boundary**: one repository; no automatic hardening, campaign,
  mutation of foreign/dirty worktrees, or successor-intake start.
- **Causal Closeout**: required after the feature PR is merged because item 6
  must be archived and the Series causally advanced. Only evidence, intake
  archive, Series, order, run state, retrospective, and statistics may change.
- **Mutable Validation Tokens**: `Applicable`; bind feature head, checks,
  review threads, mergeability, and default-branch synchronization freshly
  before every remote action.
- **Run-State Path**: A later explicitly started Autonomous run uses
  `specs/025-rl-se-self-assessment/autonomous-run-state.json`.
- **Stop/Resume**: A deliberate stop ends at a safe artefact boundary. An
  unexpected interruption requires complete drift, authority, and evidence
  revalidation before resume.

| Gate ID | Status | Required Scope | Stable Check Token | Rationale or Trigger |
|---|---|---|---|---|
| `RLSEG-BASELINE` | `Applicable` | Baseline, 12 checklists, 157 IDs, 15 documents, mapping | `secure-development-baseline` | Re-run on baseline or mapping drift |
| `RLSEG-MATRIX` | `Applicable` | Common and status-dependent required fields | `assessment-matrix-contract` | Re-run after every matrix change |
| `RLSEG-EVIDENCE` | `Applicable` | Positive claims, paths, human-only boundaries | `evidence-integrity` | Re-run after every evidence change |
| `RLSEG-A11Y` | `Applicable` | DE/EN parity, CEFR B2, text-first, WCAG 2.2 AA | `a11y-bilingual-review` | Re-run after every user-facing text change |
| `RLSEG-REGRESSION` | `Applicable` | Repository gates triggered by the actual diff | `repository-regression` | Plan derives scope from the diff |
| `RLSEG-REMOTE` | `Applicable` | Provider, PR, review, exact-head, merge, and default-branch gates | `feature-025-exact-head` | Re-run before push, PR, merge, and after every head change |
| `RLSEG-PARALLEL` | `N/A` | Parallel campaign | `N/A` | One repository and one writer; trigger is an explicit campaign request |

## Agent Parity Applicability

- The assessment reads shared agent guidance as possible evidence but changes
  no shared rule. Changes to `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md`, and
  `.github/agents/copilot-instructions.md` are therefore `N/A`.
- `.specify/memory/constitution.md`, project templates, and model routing remain
  unchanged. Re-evaluate when a finding requires a shared guidance or template
  change; that change needs separate authority and complete parity.
- No intentional deviation between agent surfaces exists.

## Audit Evidence Applicability

The following feature-level decision is binding. The later complete checkpoint
matrix uses the same status contract and adds both status axes where the
normative source requires them.

| Checkpoint | Status | Evidence or Follow-Up Contract |
|---|---|---|
| Feature 024 predecessor | `AlreadySatisfied` | `specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md` |
| Current Intake Review | `AlreadySatisfied` | `specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json` |
| Baseline, checklist, and document coverage | `Applicable` | Planned RLSE-017 path; owner: home-baseline Maintainer; priority: High; risk: silent control gap; trigger: baseline or mapping drift |
| NIST SSDF and CWE Top 25 | `Applicable` | Planned RLSE-017 path; owner: Security Reviewer; priority: High; risk: incomplete secure-SDLC/weakness view; trigger: relevant baseline or code-surface change |
| OWASP ASVS | `N/A` | No web/API/HTTP/auth delta; trigger: corresponding scope or finding |
| SBOM, VEX, and SLSA | `Applicable` | Assess existing supply-chain evidence; owner: Release/Security Maintainer; priority: High; risk: opaque artefacts; trigger: release, dependency, or build change |
| OpenSSF Scorecard | `Applicable` | Assess the public repository; owner: Repository Maintainer; priority: Medium; risk: unseen OSS governance gap; trigger: release or new high-impact dependency |
| AI-SBOM | `N/A` | AI is development tooling only; trigger: model, service, dataset, or inference in product/runtime scope |
| STRIDE/CIA and CAPEC | `N/A` | No new trust boundary or architecture change; trigger: external flow, privileged boundary, or runtime finding |
| Zero Trust, BSI C3A, and BSI C5 | `N/A` | Generic repository/CI development infrastructure only; trigger: cloud runtime, managed service, remote access, or provider selection |
| OWASP SAMM | `Applicable` | Assess existing snapshot; owner: Security Governance Maintainer; priority: Medium; risk: stagnant improvement planning; trigger: audit, incident, or baseline change |
| NIS2, CRA, EU AI Act, and DORA | `Applicable` | Screen regulatory applicability; owner: home-baseline Maintainer with professional legal review when needed; priority: Medium; risk: false compliance claim; trigger: market product, regulated customer, AI runtime, or financial-sector dependency |
| WCAG 2.2 AA and language parity | `Applicable` | Planned RLSE-017 path; owner: Documentation/A11Y Reviewer; priority: High; risk: inaccessible or contradictory results; trigger: user-facing text change |
| Cross-platform script change | `N/A` | No new or changed script; trigger: script-shaped tool or platform logic in scope |
| Agent-guidance change | `N/A` | No shared rule change; trigger: finding that needs guidance/template work |
| Project statistics | `Applicable` | Canonical configuration plus renderer at feature completion; owner: home-baseline Maintainer; priority: Low; risk: statistics drift; trigger: completed phase |

## Cross-Platform Applicability

- The feature adds, changes, and removes no script-shaped tool. Bash/PowerShell
  variants, a new man page, a new Cmdlet, and new `--dry-run`/`-WhatIf`
  surfaces are therefore `N/A`.
- Existing cross-platform scripts and checks remain possible evidence and run
  only when their documented trigger is activated by the actual diff.
- Re-evaluate when planning or a finding requires new automation. Such a scope
  expansion needs an explicit decision and full Bash/PowerShell, man-page,
  Verb-Noun, help, and safe-mode parity.

## Accessibility Applicability

- Affected user artefacts are the specification, evidence matrix, completion
  summary, Security index entry, and later plan/task artefacts.
- Complete German first and English second is required inline; both tracks
  carry the same professional content.
- WCAG 2.2 AA applies to relevant text, structure, heading, link, and table
  criteria. Status never relies only on colour, symbol, diagram, or position.
- CEFR B2 is the readability target. Terms are explained at first use and
  first-time Spec Kit users are included.
- Code blocks use language tags. No ASCII diagram or image is required; any
  later addition needs a short complete DE/EN text alternative.
- Didactic inline-code comments are `N/A` because no program logic changes.
  Re-evaluate for a later code or script change.
- A separate `docs/accessibility/` update is `N/A` because the dated assessment
  evidence carries its own A11Y review. Re-evaluate for UI, HTML, CLI, or
  central A11Y-rule changes.

## Architecture Applicability

- System context, interfaces, building blocks, runtime behaviour, deployment,
  and technical debt do not change.
- Architecture goals are limited to evidence fidelity, traceability,
  modifiability, and accessible readability of assessment artefacts.
- New `docs/architecture/` evidence, general ADRs, and architecture-risk
  records are `N/A`. Re-evaluate when a finding requires architecture work
  rather than documented follow-up.
- Existing security-relevant architecture remains an assessment input, but the
  self-assessment neither replaces nor changes an architecture decision.

## Architecture Governance Applicability

- Runtime, hardware, and platform constraints affect no new language choice
  because no program logic is created.
- No trust boundary is created, removed, or changed and no new data flow is
  classified.
- STRIDE+CIA, CAPEC, S-ADR, arc42 Section 8, security quality scenarios,
  Zero Trust, OWASP SAMM plan updates, and BSI C3A/C5 architecture updates are
  `N/A` for the feature delta. Existing documents are assessed as evidence.
- Re-evaluate for runtime, authentication, authorisation, network, cloud,
  deployment, or sensitive-data-flow findings.

## Security Governance Applicability

- **Primary implementation language**: `N/A`; the feature creates no program
  logic. It therefore creates neither a new MSL nor non-MSL decision. Existing
  languages and secure-coding rules remain assessment inputs.
- **Secure Development**: NIST SSDF, CWE Top 25, secure development
  environment, security review, and evidence hygiene are `Applicable` as
  assessment frames.
- **Web/Application Security**: OWASP ASVS is `N/A` for the feature delta;
  existing web/auth surfaces would reactivate it in the matrix.
- **Supply Chain**: SBOM, VEX, SLSA, dependency audit, and OpenSSF Scorecard are
  `Applicable` as existing repository/release assessment surfaces; the feature
  creates no dependency or distribution.
- **AI**: AI is development tooling only; AI-SBOM is `N/A` with the CR-009
  trigger.
- **Regulation**: CRA, NIS2, EU AI Act, and DORA applicability is assessed
  without inventing legal or certification claims.
- **Security Evidence**: The Markdown artefacts in RLSE-017 are planned.
  Existing `docs/security/` files are referenced or classified as stubs/
  insufficient; they are not automatically hardened.
- **Secrets and Privacy**: Raw data is bounded against private paths, secrets,
  tokens, and unnecessary personal data; results contain publishable evidence
  only.

## Documentation Impact

- **Decision**: `UpdateRequired`.
- **Affected audiences**: Maintainers, training leads, Security/A11Y reviewers,
  and secondarily apprentices.
- **Reader paths**: `docs/security/README.md` to the dated assessment; feature
  specification to matrix and completion summary.
- **Canonical sources and owner**: The baseline manifest and twelve checklists
  remain professional sources; the dated matrix is feature evidence. The
  home-baseline Maintainer owns it, with professional review by the named
  Security/A11Y roles.
- **Navigation**: The Security index gains a direct link during implementation;
  historical Feature 024 evidence remains unchanged.
- **Document class and language**: `sourceOnly`, complete German first and
  English second, CEFR B2; no Home Sync.
- **Platform/example proof**: Only macOS/Linux/Windows gates triggered by the
  actual diff are required; result logic is platform-neutral and text-first.
- **Evidence**: `specs/025-rl-se-self-assessment/spec.md`,
  `specs/025-rl-se-self-assessment/checklists/requirements.md`, and the
  Markdown artefacts planned in RLSE-017.
- **Re-evaluation trigger**: Baseline, preset, audience, A11Y, architecture,
  runtime, distribution, or Delivery Authority change.
