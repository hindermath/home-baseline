<!-- intake-authoring:begin -->
# Lastenheft: Verlinkte Abarbeitungsreihenfolgen und Spec-Kit-Feature-Nachweise

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review / `ReadyForReview`
**Version:** 1.1
**Stand:** 2026-09-01
**Reihenfolge:** sichtbare Position 39 (`vorgezogen / promoted`), aktiver Manifestplatz 1, `Primary`, `Eligible`
**Bindende Vorgänger:** keine
**Beratender Vorgänger:** keiner
**Beratender Nachfolger:** G4 über `PreferredSerialOrder`, `binding: false`
**Delivery Mode:** `LocalImplementation`
**Zielgruppe:** Maintainer, Repository-Verantwortliche, Reviewer und Personen, die einen späteren Spec-Kit-Lauf vorbereiten

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt die als nächster Intake priorisierte
Dokumentations- und Renderer-Harmonisierung für sieben Herzensprojekt-
Repositories. Ihre menschenlesbaren Lastenheft-Abarbeitungsreihenfolgen sollen
die zugrunde liegenden Intake-Dateien, Abhängigkeiten und abgeschlossenen
Spec-Kit-Features direkt nachvollziehbar machen.

Die Erstellung dieses Lastenhefts ändert noch keine der sieben Zielansichten,
startet keinen Spec-Kit-Lauf und erteilt keine Commit-, Push-, Pull-Request-,
Merge- oder Flottenautorität.

*This intake defines the documentation and renderer harmonization across seven
passion-project repositories that is now prioritized as the next intake. Their
human-readable intake order views will link intake files, show direct
dependencies, and point
completed entries to their Spec Kit feature directories. Creating this intake
does not implement those changes or authorize remote delivery.*

## 2. Ausgangslage und Zielbild / Current and Target State

Die sieben Repositories verwenden unterschiedliche Darstellungen und
Generatoren. Einige Ansichten sind Tabellen, andere Listen; Dateinamen,
Abhängigkeiten und Feature-Nachweise sind nicht überall anklickbar oder in
derselben Form vorhanden. Die kanonischen Series-Manifeste und vorhandenen
Renderer bleiben jedoch die fachlichen Quellen für Reihenfolge, Lifecycle und
Abhängigkeiten.

Das Zielbild ist eine textorientierte, repositoryspezifisch erzeugte Tabelle
mit folgendem gemeinsamen Informationsvertrag:

```text
Position | Status | Lastenheft/Intake | Abhängigkeiten | Spec-Kit-Feature
```

Die Darstellung harmonisiert die Bedeutung, ohne bestehende Reihenfolgen,
Lifecycle-Zustände, Abhängigkeitskanten oder Produktverhalten zu ändern.

*The repositories currently use different list and table shapes. The target is
a shared, text-first information contract generated from each repository's
canonical sources without changing lifecycle, order, dependency semantics, or
product behavior.*

## 3. Zielgruppe, Vorwissen und Begriffe / Audience, Prior Knowledge, and Terms

Vorausgesetzt werden Grundkenntnisse in Markdown und Git. Spec-Kit-Erfahrung
wird nicht vorausgesetzt. Die folgenden Begriffe gelten im Lastenheft:

- **Intake / Lastenheft:** eine Anforderungsdatei, die spätere Arbeit
  beschreibt, aber allein keinen Lauf startet.
- **Series-Manifest:** die maschinenlesbare Quelle für Reihenfolge, Rollen,
  Lifecycle-Zustände und typisierte Abhängigkeiten.
- **Renderer:** ein Skript, das eine menschenlesbare Ansicht reproduzierbar
  aus kanonischen Daten erzeugt.
- **Bindende Abhängigkeit:** eine Kante mit `binding: true`, die ein fachliches
  Gate ausdrückt.
- **Beratende Abhängigkeit:** eine Kante mit `binding: false`, die eine
  bevorzugte Reihenfolge oder Schreibkonfliktvermeidung beschreibt.
- **Spec-Kit-Feature:** ein vorhandenes Verzeichnis `specs/<feature>/`, das die
  Spezifikations- und Liefernachweise eines umgesetzten Intakes enthält.
- **`Completed`:** der Intake ist abgeschlossen; dieser Status allein
  garantiert nicht, dass ein Spec-Kit-Feature-Verzeichnis existiert.

*Readers need basic Markdown and Git knowledge, but no prior Spec Kit
experience. Status, dependency, decision, and next-action meaning remains
available as linear text and never depends on colour or layout alone.*

## 4. Umfang und betroffene Repositories / Scope and Affected Repositories

Die spätere Umsetzung umfasst genau diese sieben Repositories:

| Repository | Registrierter Arbeitsbereich / Registered workspace | Besonderheit / Special handling |
|---|---|---|
| `home-baseline` | `home-baseline-source` | Kanonischer Level-0-Vertrag und gemeinsame Bash-/PowerShell-Renderer |
| `agent-operations-cockpit` | `RiderProjects/AgentOperationsCockpit` | Gezielte Übernahme des freigegebenen Level-0-Vertrags |
| `TinyPl0` | `RiderProjects/TinyPl0` | Lokaler JavaScript-Renderer und erzeugte Reihenfolgeansichten |
| `TinyCalc` | `RiderProjects/TinyCalc` | Lokaler JavaScript-Renderer und erzeugte Reihenfolgeansichten |
| `TuiVision` | `RiderProjects/TuiVision` | Manifestbasierte Umstellung der bisherigen nummerierten Liste |
| `InventarWorkerService` | `RiderProjects/InventarWorkerService` | Manifestgestützte Reihenfolgeansicht |
| `absdd-image-sandbox` | `container-images/absdd-image-sandbox` | Manifestgestützte Reihenfolgeansicht in der Sandbox-Quelle |

Der derzeit nicht vorhandene lokale TuiVision-Checkout wird erst vor einer
später ausdrücklich autorisierten Umsetzung am registrierten Pfad aus dem
kanonischen Remote wiederhergestellt. Der Checkout wird vor Änderungen auf
einen sauberen und mit `origin/main` synchronen Zustand geprüft.

*The future implementation covers exactly seven repositories. A missing local
TuiVision checkout is restored and verified only after fresh implementation
authority; intake authoring itself does not clone or edit that repository.*

## 5. Gemeinsamer Darstellungs- und Datenvertrag / Shared Presentation and Data Contract

- **LAF-001:** Jede betroffene Root-Ansicht MUSS die Spalten `Position`,
  `Status`, `Lastenheft/Intake`, `Abhängigkeiten` und `Spec-Kit-Feature` in
  dieser Reihenfolge anbieten.
- **LAF-002:** Jeder angezeigte Lastenheft-Dateiname MUSS als relativer
  Markdown-Link auf die im Repository vorhandene Intake-Datei führen.
- **LAF-003:** Die Linkbeschriftung MUSS den tatsächlichen Markdown-Dateinamen
  enthalten; ein verkürzter Titel darf den Dateinamen nicht ersetzen.
- **LAF-004:** Jede direkte eingehende Series-Abhängigkeit MUSS mit ihrem
  `kind` und als `bindend / binding` oder `beratend / advisory` dargestellt
  werden.
- **LAF-005:** Ein Intake ohne direkte eingehende Abhängigkeit MUSS
  textorientiert als `— (Root / keine direkte Abhängigkeit)` erkennbar sein.
- **LAF-006:** Für jeden `Completed`-Eintrag mit vorhandenem Feature-Verzeichnis
  MUSS die Spalte `Spec-Kit-Feature` relativ auf `specs/<feature>/` verlinken.
- **LAF-007:** Für jeden `Completed`-Eintrag ohne zuordenbares vorhandenes
  Feature-Verzeichnis MUSS exakt
  `— (kein Spec-Kit-Feature / no Spec Kit feature)` erscheinen.
- **LAF-008:** Nicht abgeschlossene Einträge DÜRFEN keinen erfundenen
  Feature-Link erhalten. Ihr Feature-Feld MUSS den fehlenden Abschluss
  verständlich kennzeichnen.
- **LAF-009:** Position, Rolle, Status, Root-Zugehörigkeit, Kantenrichtung,
  `kind` und `binding` MÜSSEN mit der jeweiligen kanonischen Quelle
  übereinstimmen.
- **LAF-010:** Die Harmonisierung DARF keinen Lifecycle-Zustand, keine
  Reihenfolge und keine Abhängigkeit fachlich ändern.
- **LAF-011:** Relative Links MÜSSEN vom Speicherort der erzeugten Ansicht aus
  aufgelöst und auf vorhandene Datei- oder Verzeichnisziele geprüft werden.
- **LAF-012:** Tabellen MÜSSEN in Markdown und als linearisierter Text mit
  Screenreader, Braille-Zeile und Textbrowser verständlich bleiben.

## 6. Renderer- und Repository-Vertrag / Renderer and Repository Contract

- **LAF-013:** Änderungen MÜSSEN an der jeweiligen kanonischen Renderer- oder
  Manifestquelle erfolgen; eine isolierte Bearbeitung erzeugter Tabellen ist
  unzulässig.
- **LAF-014:** Wiederholte Renderer-Läufe mit unveränderten Eingaben MÜSSEN
  byteidentische fachliche Ausgabe erzeugen.
- **LAF-015:** Die gemeinsamen Home-Baseline-Renderer für Bash und PowerShell
  MÜSSEN dieselben Links, Abhängigkeiten, Statuswerte und Feature-Nachweise
  erzeugen.
- **LAF-016:** Zugehörige Manpages und Hilfetexte MÜSSEN den erweiterten
  Ausgabe- und Validierungsvertrag dokumentieren.
- **LAF-017:** `agent-operations-cockpit` DARF den gemeinsamen Vertrag erst
  nach der lokal validierten Level-0-Änderung gezielt übernehmen.
- **LAF-018:** TinyPl0 und TinyCalc MÜSSEN ihre lokalen JavaScript-Renderer und
  alle daraus erzeugten Root-, Series- oder Evidence-Ansichten gemeinsam
  aktualisieren.
- **LAF-019:** InventarWorkerService und `absdd-image-sandbox` MÜSSEN ihre
  manifestgestützten Ansichten aus den vorhandenen kanonischen Daten erzeugen.
- **LAF-020:** TuiVision MUSS
  `scripts/render-requirements-intake-governance.mjs`, die Root-Ansicht und
  `requirements/intakes/series/tui-vision-delivery/order.md` konsistent
  aktualisieren.
- **LAF-021:** Repositoryspezifische Statistik-, Documentation-Impact- und
  Agent-Guidance-Regeln MÜSSEN pro Zielrepository geprüft und erfüllt werden.
- **LAF-022:** Produkt-APIs, Programmlogik, Runtime-Verhalten und öffentliche
  Datentypen DÜRFEN durch diese Dokumentationsarbeit nicht geändert werden.

## 7. Verbindlicher TuiVision-Vertrag / Binding TuiVision Contract

Die TuiVision-Tabelle folgt der kanonischen Manifestreihenfolge und verwendet
folgende vorhandene Zuordnung:

| Position | Intake-Datei | Spec-Kit-Feature |
|---:|---|---|
| 1 | `requirements/intakes/active/Lastenheft_22_Wave6-Combined-Delta-Closure.md` | `specs/037-wave6-combined-delta-closure/` |
| 2 | `requirements/intakes/active/Lastenheft_15_Post-Wave6-Example-Portfolio-Conformance-Audit.md` | `specs/038-example-portfolio-conformance-audit/` |
| 3 | `requirements/intakes/active/Lastenheft_Example-Portfolio-Closure.md` | `specs/039-example-portfolio-closure/` |
| 4 | `requirements/intakes/active/Lastenheft_Constitution_Change.md` | `specs/040-constitution-governance-closure/` |
| 5 | `requirements/intakes/active/Lastenheft_Source-Reference-Policy.md` | `specs/041-source-reference-policy/` |
| 6 | `requirements/intakes/active/Lastenheft_Transactional-Form-Model.md` | `specs/042-transactional-form-model/` |
| 7 | `requirements/intakes/active/Lastenheft_23_Documentation-Publishing-Closure.md` | `specs/043-documentation-publishing-closure/` |
| 8 | `requirements/intakes/active/Lastenheft_Sandbox-gestuetzte-Secure-Development-Haertung.md` | `specs/044-sandbox-secure-development-hardening/` |
| 9 | `requirements/intakes/archive/Lastenheft_RL-SE-Checklist-Selbstpruefung.045-rl-se-checklist-self-review.md` | `specs/045-rl-se-checklist-self-review/` |
| 10 | `requirements/intakes/archive/Lastenheft_GSDB-Spec-Kit-Intensivpruefung.046-gsdb-spec-kit-intensive-review.md` | `specs/046-gsdb-spec-kit-intensive-review/` |

- **LAF-023:** Die TuiVision-Root-Ansicht MUSS genau zehn Tabellenzeilen mit
  Status `Completed` aus dem Series-Manifest ableiten.
- **LAF-024:** Die sechs vorhandenen TuiVision-Abhängigkeiten MÜSSEN mit
  unverändertem `kind`, unveränderter Richtung und unverändertem
  Bindungsstatus dargestellt werden.
- **LAF-025:** Feature `046-gsdb-spec-kit-intensive-review` MUSS zusätzlich als
  zuletzt abgeschlossen erkennbar bleiben, ohne die kanonische Tabellenfolge
  1 bis 10 zu verändern.
- **LAF-026:**
  `requirements/intakes/backlog/Lastenheft_Optional-NuGet-Package.md` MUSS
  getrennt als `DeferredOptional` im nicht ausführbaren Backlog verbleiben.
- **LAF-027:** Der optionale Backlog-Eintrag DARF weder als elftes aktives
  Serienmitglied erscheinen noch einen künstlichen Feature-Link erhalten.

## 8. Plattform-, Sicherheits- und Qualitätsgrenzen / Platform, Security, and Quality Boundaries

- **LAF-028:** Auf macOS und Linux ist die vorhandene Bash-Variante zuerst zu
  prüfen; auf Windows die vorhandene PowerShell-7-Variante. Relevante
  Gegenvarianten werden anschließend auf Parität geprüft.
- **LAF-029:** Pfade aus Manifesten MÜSSEN als Repository-relative Daten
  behandelt werden. Renderer dürfen sie nicht ausführen und nicht außerhalb
  des jeweiligen Repositorys auflösen.
- **LAF-030:** Ungültige UTF-8-Daten, NUL-Inhalt, unbekannte Ziele,
  Pfadüberschreitungen oder mehrdeutige Feature-Zuordnungen MÜSSEN vor einer
  Veröffentlichung fehlschlagen.
- **LAF-031:** Ausgaben DÜRFEN keine Credentials, Tokens, privaten absoluten
  Pfade oder unnötige personenbezogene Daten enthalten.
- **LAF-032:** Nutzerseitige Inhalte MÜSSEN Deutsch zuerst und Englisch danach
  auf CEFR-B2-Niveau anbieten, sofern das Zielrepository diesen bilingualen
  Vertrag verwendet.
- **LAF-033:** Anwendbare Anforderungen aus WCAG 2.2 Level AA MÜSSEN erfüllt
  werden; Bedeutung darf nicht allein durch Farbe, Symbol oder Tabellenlayout
  vermittelt werden.
- **LAF-034:** Neue nicht triviale Renderer-Logik MUSS auf didaktischen
  Inline-Kommentarbedarf geprüft werden. Kommentare erklären Grund,
  Randbedingung oder Proof-Grenze und nicht offensichtliches Verhalten.
- **LAF-035:** Die Änderung führt keine neue Abhängigkeit ein. Falls sich das
  bei der späteren Planung als unvermeidbar erweist, ist ein getrenntes
  Supply-Chain-Review erforderlich.

## 9. Ausführungsreihenfolge und Hard Stops / Delivery Order and Hard Stops

1. Vor jeder späteren Mutation werden Zielpfad, Remote, Default-Branch,
   Sauberkeit und Synchronität aller sieben Checkouts geprüft.
2. Home Baseline definiert und validiert zuerst den gemeinsamen Vertrag.
3. Agent Operations Cockpit übernimmt anschließend ausschließlich die
   freigegebene gemeinsame Änderung.
4. TinyPl0, TinyCalc, InventarWorkerService, `absdd-image-sandbox` und
   TuiVision werden repositoryweise mit ihren lokalen Generatoren angepasst.
5. Jeder Repositoryabschluss benötigt seine eigenen Tests, Documentation
   Impact, Statistikentscheidung und aktuelle Delivery-Autorität.

Der Lauf stoppt vor der ersten Mutation, wenn ein Ziel fehlt, verschmutzt,
divergiert, einem unerwarteten Remote folgt oder seine kanonische
Manifest-/Rendererquelle nicht eindeutig bestimmt werden kann. Der fehlende
TuiVision-Checkout ist für dieses Lastenheft kein Fehler; er ist erst ein
Preflight-Gate der späteren Umsetzung.

*Level 0 establishes the shared contract first. Every repository then receives
a bounded local change with its own evidence. Missing, dirty, diverged, or
ambiguously owned targets stop before mutation.*

## 10. Nicht-Ziele / Non-Goals

- Keine Änderung der sieben Abarbeitungsreihenfolgen durch die Erstellung
  dieses Lastenhefts.
- Kein Restore oder Clone des TuiVision-Repositorys in diesem Intake-Lauf.
- Kein Intake Review durch die reine Authoring- oder Series-Operation.
- Kein Specify-, Autonomous- oder Parallel-Autonomous-Lauf.
- Keine Produkt-, API-, Runtime-, Build- oder Dependency-Änderung.
- Keine Änderung bestehender Lifecycle-Zustände, Rollen, Roots oder Kanten.
- Keine automatische Migration weiterer Repositories außerhalb der sieben
  ausdrücklich genannten Ziele.
- Keine Commits, Pushes, Pull Requests, Merges, Bypasses oder Remote-Mutationen
  ohne neue ausdrückliche Autorität.

## 11. Risiken und Gegenmaßnahmen / Risks and Mitigations

| Risiko / Risk | Gegenmaßnahme / Mitigation |
|---|---|
| Ein Link zeigt auf einen nicht vorhandenen Intake oder Feature-Pfad. | Repository-relative Ziele vor Veröffentlichung deterministisch prüfen. |
| Manuell geänderte Ausgabe wird beim nächsten Renderer-Lauf überschrieben. | Kanonische Renderer- oder Manifestquelle ändern und Idempotenz testen. |
| Eine beratende Kante erscheint fälschlich als Blocker. | `kind` und Bindungsstatus gemeinsam ausgeben. |
| Ein `Completed`-Status wird mit einem nicht belegten Feature gleichgesetzt. | Vorhandenes Verzeichnis verlangen oder den festgelegten Kein-Feature-Text ausgeben. |
| Die TuiVision-Sonderdarstellung verfälscht die kanonische Reihenfolge. | Letzten Abschluss separat hervorheben und die Tabelle weiterhin in Manifestreihenfolge rendern. |
| Ein breiter Flottenlauf überschreitet lokale Autorität. | Repositoryweise Hard Stops und frische Delivery-Autorität verlangen. |
| Tabellen sind für Hilfsmittel schwer verständlich. | Spalten eindeutig benennen und jede Bedeutung als linearen Text verfügbar halten. |

## 12. Erwartete Artefakte und Evidence / Expected Artifacts and Evidence

- Aktualisierte kanonische Renderer oder Manifestquellen in allen sieben
  Repositories.
- Reproduzierbar erzeugte Root- und gegebenenfalls Series-Order-Ansichten.
- Linkprüfung für jeden Intake- und Feature-Pfad.
- Manifest-zu-Ausgabe-Abgleich für Position, Status und Abhängigkeiten.
- Idempotenznachweis pro Renderer.
- Bash-/PowerShell-Paritätsnachweis für gemeinsame Home-Baseline-Oberflächen.
- JavaScript-Renderer-Nachweise für TinyPl0, TinyCalc und TuiVision.
- Repositoryspezifische Test-, A11Y-, Documentation-Impact- und
  Statistiknachweise.
- Getrennte lokale Diffs und spätere Pull Requests pro Repository, jedoch nur
  nach neuer ausdrücklicher Remote-Delivery-Autorität.

## 13. Abnahmekriterien / Acceptance Criteria

- **AC-LAF-001:** Genau sieben ausdrücklich benannte Repositories sind im
  Scope; kein weiteres Repository wurde verändert.
- **AC-LAF-002:** Jede erzeugte aktive Intake-Zeile besitzt die fünf
  vereinbarten Informationsfelder.
- **AC-LAF-003:** Jeder angezeigte Lastenheft-Dateiname ist ein gültiger
  relativer Link auf die tatsächliche Markdown-Datei.
- **AC-LAF-004:** Alle direkten Abhängigkeiten stimmen in Richtung, Typ und
  Bindungsstatus mit dem jeweiligen kanonischen Manifest überein.
- **AC-LAF-005:** Jede `Completed`-Zeile besitzt entweder einen gültigen Link
  auf das zugeordnete Feature-Verzeichnis oder exakt den vereinbarten
  Kein-Feature-Text.
- **AC-LAF-006:** Kein Status, keine Position, keine Rolle, kein Root und keine
  Abhängigkeit wurde durch die Darstellungsänderung fachlich verändert.
- **AC-LAF-007:** Zwei aufeinanderfolgende Renderer-Läufe ohne Eingabeänderung
  erzeugen keinen zweiten Diff.
- **AC-LAF-008:** Gemeinsame Bash- und PowerShell-Ausgaben sind semantisch und,
  wo der bestehende Vertrag dies verlangt, bytegleich.
- **AC-LAF-009:** TuiVision zeigt genau zehn `Completed`-Zeilen, zehn gültige
  Feature-Links von `037` bis `046` und alle sechs vorhandenen Abhängigkeiten.
- **AC-LAF-010:** TuiVision kennzeichnet Feature `046` weiterhin als zuletzt
  abgeschlossen, ohne die kanonische Tabellenreihenfolge zu verändern.
- **AC-LAF-011:** Der TuiVision-Backlog bleibt genau ein getrennter
  `DeferredOptional`-Eintrag und kein aktives Serienmitglied.
- **AC-LAF-012:** Alle anwendbaren repositoryspezifischen Tests, Link-, UTF-8-,
  A11Y-, Statistik- und Documentation-Impact-Gates sind erfolgreich.
- **AC-LAF-013:** Für jedes Repository ist nach Abschluss dokumentiert, ob nur
  lokal implementiert oder mit neuer Autorität veröffentlicht wurde.
- **AC-LAF-014:** Es wurden keine Produkt-APIs, Runtime-Funktionen oder neuen
  Abhängigkeiten eingeführt.

## 14. Documentation Impact und Statistik / Documentation Impact and Statistics

Die spätere Umsetzung erhält `UpdateRequired` oder `GeneratedUpdate` gemäß der
jeweiligen kanonischen Rendererquelle. Owner, Leserpfade, Navigation,
Dokumentklasse, Sprachpartner, Plattformnachweis, Distributionsklasse,
Home-Sync-Bedarf und Re-Evaluation werden repositoryweise dokumentiert.

Für dieses Level-0-Intake gilt `UpdateRequired`: Lastenheft,
Abarbeitungsreihenfolge, Authoring-/Series-/Review-Evidence und das
Statistik-Ledger werden gemeinsam aktualisiert. Die Änderung ist `source-only`;
ein Home-Runtime-Sync ist nicht erforderlich.

*The intake itself updates source-only governance documentation and evidence.
The later seven-repository implementation records its documentation and
statistics impact separately in every target repository.*

## 15. Entscheidungen, Annahmen und offene Fragen / Decisions, Assumptions, and Open Questions

- `IAD001`: Ein zentrales Level-0-Lastenheft bündelt den gemeinsamen Vertrag
  für alle sieben Repositories.
- `IAD002`: Das Lastenheft behält die sichtbare Kennung Position 39, wird als
  vorgezogenes Ziel auf aktiven Manifestplatz 1 sowie `Primary` und `Eligible`
  umgebucht und erhält eine beratende Kante zu G4.
- `IAD003`: TuiVision gehört zum verbindlichen Scope; die zehn abgeschlossenen
  Einträge, sechs Kanten und der getrennte optionale Backlog bleiben erhalten.
- `IAD004`: Feature-Links werden nur bei belegtem Verzeichnis erzeugt; sonst
  gilt der festgelegte Kein-Feature-Text.
- `IAD005`: Delivery Authority bleibt `LocalImplementation`; Remote-Lieferung
  benötigt neue ausdrückliche Autorität.
- Die aktuelle Anforderungenfassung ist vollständig. Es bestehen keine
  offenen materiellen Entscheidungen.

## 16. Reihenfolge und spätere Fortschreibung / Order and Later Updates

Dieser Intake behält die stabile sichtbare Kennung Position 39, wird jedoch als
`vorgezogen / promoted` an aktiven Manifestplatz 1 gestellt. Er ist der einzige
deklarierte bevorzugte `Primary`- und `Eligible`-Kandidat. Die bisherige
beratende Kante von Position 38 entfällt; stattdessen ordnet eine
`PreferredSerialOrder`-Kante mit `binding: false` G4 beratend nach diesem Intake
ein. Diese Einordnung erteilt keine Start- oder Delivery-Autorität.

Spätere Änderungen dieses Lastenhefts erfolgen ausschließlich über:

```text
$speckit-intake-update Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md
```

Eine Änderung des Zielhashs erfordert anschließend ein begrenztes,
ausdrücklich autorisiertes Series-Hash-Update und invalidiert einen
gegebenenfalls vorhandenen Review.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md als alleinige verbindliche Intake-Datei. Erstelle ausschließlich die Feature-Spezifikation für die verlinkten Lastenheft-Abarbeitungsreihenfolgen, typisierten Abhängigkeiten und Spec-Kit-Feature-Nachweise in home-baseline, agent-operations-cockpit, TinyPl0, TinyCalc, TuiVision, InventarWorkerService und absdd-image-sandbox. Bewahre die stabile sichtbare Kennung Position 39, die vorgezogene Einordnung als aktiver Manifestplatz 1 mit Primary und Eligible, die nicht bindende PreferredSerialOrder-Kante zu G4, alle repositoryspezifischen Lifecycle- und DAG-Daten, den TuiVision-Vertrag mit zehn Completed-Einträgen, Features 037 bis 046, sechs Abhängigkeiten und getrenntem DeferredOptional-Backlog sowie WCAG 2.2 AA, DE/EN-Verträge, Documentation Impact und alle Hard Stops. Ändere keine Dateien, Checkouts oder Remotes und führe keine Implementierung, Commits, Pushes, Pull Requests oder Merges aus.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md Fuehre den vollständigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake, validiere vor jeder Mutation alle sieben registrierten Checkouts und implementiere den gemeinsamen Tabellen-, Link-, Abhängigkeits- und Feature-Nachweisvertrag dauerhaft in den kanonischen Renderern. Stelle den registrierten TuiVision-Checkout nur innerhalb dieser ausdrücklichen lokalen Autorität wieder her und stoppe bei fehlenden, verschmutzten, divergierten oder mehrdeutigen Zielen. Bewahre alle Lifecycle-, Reihenfolge- und DAG-Daten, den TuiVision-Vertrag sowie A11Y-, Plattform-, Documentation-Impact-, Statistik- und Evidence-Gates. Erzeuge keine Commits, Pushes, Pull Requests, Merges, Bypasses oder sonstigen Remote-Mutationen und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
