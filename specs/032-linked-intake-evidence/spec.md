# Feature-Spezifikation: Verlinkte Intake-Reihenfolgen und Spec-Kit-Feature-Nachweise / Feature Specification: Linked Intake Orders and Spec Kit Feature Evidence

**Feature Branch / Feature-Branch**: `032-linked-intake-evidence`
**Created / Erstellt**: 2026-09-01
**Status**: Spezifiziert / Specified
**Binding Input / Bindende Eingabe**: `Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md`, Review `9bcbbeb6-957c-4ef4-ba3e-53eb719c8811` (`Ready`)
**Audience / Zielgruppe**: Maintainer, Repository-Verantwortliche, Reviewer und Personen ohne vorausgesetzte Spec-Kit-Erfahrung / maintainers, repository owners, reviewers, and people without assumed Spec Kit experience

## Nutzungsszenarien und Tests / User Scenarios & Testing *(mandatory)*

### User Story 1 - Reihenfolge und Nachweise direkt nachvollziehen / Follow Order and Evidence Directly (Priority: P1)

Als Maintainer oder Reviewer möchte ich in jeder Abarbeitungsansicht Position,
Status, verlinkte Intake-Datei, direkte typisierte Abhängigkeiten und einen
belegten Spec-Kit-Feature-Nachweis gemeinsam sehen, damit ich den aktuellen
fachlichen Zustand ohne Suche in mehreren Quellen prüfen kann.

*As a maintainer or reviewer, I want every processing-order view to show the
position, status, linked intake file, direct typed dependencies, and proven
Spec Kit feature evidence together, so I can verify the current business state
without searching across multiple sources.*

**Why this priority / Warum diese Priorität**: Dieser gemeinsame
Informationsvertrag ist der unmittelbare Nutzerwert des Features.

**Independent Test / Unabhängiger Test**: Eine erzeugte Ansicht jedes der
genau sieben Zielrepositories wird zeilenweise gegen Intake-Dateien,
Series-Manifest und vorhandene Feature-Verzeichnisse geprüft.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** eine aktive Intake-Zeile wird angezeigt, **When / Wenn** sie gelesen wird, **Then / Dann** enthält sie genau die fünf vereinbarten Informationsfelder in der vereinbarten Reihenfolge.
2. **Given / Angenommen** ein Intake besitzt direkte eingehende Abhängigkeiten, **When / Wenn** die Ansicht erzeugt wird, **Then / Dann** erscheinen jede Kante, ihr `kind` und ihr Bindungsstatus entsprechend der kanonischen Quelle.
3. **Given / Angenommen** ein Intake besitzt keine direkte eingehende Abhängigkeit, **When / Wenn** die Ansicht erzeugt wird, **Then / Dann** erscheint `— (Root / keine direkte Abhängigkeit)`.
4. **Given / Angenommen** ein `Completed`-Intake besitzt ein zugeordnetes vorhandenes Feature-Verzeichnis, **When / Wenn** die Ansicht erzeugt wird, **Then / Dann** führt ein relativer Link auf dieses Verzeichnis.
5. **Given / Angenommen** ein `Completed`-Intake besitzt kein zuordenbares vorhandenes Feature-Verzeichnis, **When / Wenn** die Ansicht erzeugt wird, **Then / Dann** erscheint exakt `— (kein Spec-Kit-Feature / no Spec Kit feature)`.

---

### User Story 2 - Kanonische Daten reproduzierbar rendern / Render Canonical Data Reproducibly (Priority: P1)

Als Repository-Verantwortliche*r möchte ich die Ansicht ausschließlich aus
der jeweiligen kanonischen Manifest- oder Rendererquelle reproduzieren, damit
manuelle Tabellenänderungen keine falsche Reihenfolge oder veraltete Links
erzeugen.

*As a repository owner, I want the view reproduced only from the relevant
canonical manifest or renderer source, so manual table edits cannot create a
false order or stale links.*

**Why this priority / Warum diese Priorität**: Ohne kanonische Erzeugung wäre
die harmonisierte Ansicht nicht dauerhaft verlässlich.

**Independent Test / Unabhängiger Test**: Zwei aufeinanderfolgende
Renderer-Läufe mit unveränderten Eingaben erzeugen keinen zweiten Diff; ein
Manifest-zu-Ausgabe-Abgleich bestätigt alle fachlichen Felder.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** unveränderte kanonische Eingaben, **When / Wenn** der Renderer zweimal läuft, **Then / Dann** ist die zweite Ausgabe byteidentisch und erzeugt keinen Diff.
2. **Given / Angenommen** Position, Rolle, Status, Root oder Kante sind in der kanonischen Quelle festgelegt, **When / Wenn** die Ansicht erzeugt wird, **Then / Dann** stimmt jedes Feld ohne fachliche Umdeutung überein.
3. **Given / Angenommen** dieselben Home-Baseline-Eingaben, **When / Wenn** Bash- und PowerShell-Variante rendern, **Then / Dann** sind Links, Abhängigkeiten, Statuswerte und Feature-Nachweise semantisch gleich und gemäß bestehendem Vertrag bytegleich.
4. **Given / Angenommen** eine relative Zielauflösung verlässt das Repository oder ist ungültig, **When / Wenn** die Ausgabe validiert wird, **Then / Dann** stoppt der Lauf vor Veröffentlichung mit verständlichem Blocker.

---

### User Story 3 - TuiVision-Vertrag unverändert sichtbar machen / Preserve the TuiVision Contract Visibly (Priority: P1)

Als TuiVision-Maintainer möchte ich die zehn abgeschlossenen Intakes in
Manifestreihenfolge, ihre Features `037` bis `046`, alle sechs bestehenden
Abhängigkeiten und den getrennten optionalen Backlog sehen, damit die neue
Tabellenform keine historische oder fachliche Bedeutung verändert.

*As a TuiVision maintainer, I want to see the ten completed intakes in manifest
order, their features `037` through `046`, all six existing dependencies, and
the separate optional backlog, so the new table form changes no historical or
business meaning.*

**Why this priority / Warum diese Priorität**: TuiVision besitzt den
umfangreichsten bindenden Sondervertrag und die höchste Gefahr einer
unbeabsichtigten Reihenfolgeänderung.

**Independent Test / Unabhängiger Test**: Die Root- und Series-Ansichten
werden gegen die zehn festgelegten Intake-/Feature-Paare, sechs Manifestkanten
und genau einen getrennten `DeferredOptional`-Backlogeintrag geprüft.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** das unveränderte TuiVision-Series-Manifest, **When / Wenn** die Ansichten erzeugt werden, **Then / Dann** erscheinen genau zehn `Completed`-Zeilen in Position 1 bis 10 mit gültigen Feature-Links `037` bis `046`.
2. **Given / Angenommen** die sechs vorhandenen Abhängigkeiten, **When / Wenn** sie dargestellt werden, **Then / Dann** bleiben Richtung, `kind` und Bindungsstatus unverändert.
3. **Given / Angenommen** Feature `046-gsdb-spec-kit-intensive-review` ist zuletzt abgeschlossen, **When / Wenn** der Abschluss kenntlich gemacht wird, **Then / Dann** bleibt die kanonische Tabellenfolge 1 bis 10 unverändert.
4. **Given / Angenommen** `Lastenheft_Optional-NuGet-Package.md` ist `DeferredOptional`, **When / Wenn** die aktive Serie gerendert wird, **Then / Dann** erscheint es weder als elfte aktive Zeile noch mit einem erfundenen Feature-Link.

---

### User Story 4 - Barrierearm und sicher prüfen / Review Accessibly and Safely (Priority: P2)

Als Nutzer*in eines Screenreaders, einer Braille-Zeile oder eines Textbrowsers
möchte ich Status, Abhängigkeiten, fehlende Nachweise, Fehler und nächste
Aktionen linear und zweisprachig verstehen, damit die Ansicht nicht von Farbe,
Symbolen oder Tabellenlayout abhängt.

*As a user of a screen reader, Braille display, or text browser, I want to
understand status, dependencies, missing evidence, errors, and next actions in
linear bilingual text, so the view does not depend on colour, symbols, or table
layout.*

**Independent Test / Unabhängiger Test**: Die erzeugten Ansichten und
Fehlermeldungen werden linearisiert; alle Bedeutungen bleiben erhalten und die
Linktexte nennen die tatsächlichen Markdown-Dateinamen.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** eine Tabelle wird linearisiert, **When / Wenn** sie ohne Farbe oder räumliche Anordnung gelesen wird, **Then / Dann** bleiben Position, Status, Intake, Abhängigkeit und Feature-Nachweis eindeutig zuordenbar.
2. **Given / Angenommen** ein ungültiger Pfad, unbekanntes Ziel, NUL-Inhalt, ungültiges UTF-8 oder eine mehrdeutige Zuordnung, **When / Wenn** validiert wird, **Then / Dann** stoppt der Renderer mit einer textorientierten Meldung und veröffentlicht keine Ausgabe.
3. **Given / Angenommen** das Zielrepository verwendet den bilingualen Vertrag, **When / Wenn** nutzerseitige Texte geändert werden, **Then / Dann** stehen Deutsch zuerst und Englisch danach auf CEFR-B2-Niveau.

---

### User Story 5 - Repositoryweise vollständig abnehmen / Accept Each Repository Independently (Priority: P2)

Als Fleet-Maintainer möchte ich jedes der sieben Repositories mit seinem
eigenen Test-, A11Y-, Documentation-Impact-, Statistik- und
Delivery-Nachweis abschließen, damit ein Erfolg in einem Repository keinen
fehlenden Nachweis in einem anderen verdeckt.

*As a fleet maintainer, I want to complete each of the seven repositories with
its own test, accessibility, documentation-impact, statistics, and delivery
evidence, so success in one repository cannot conceal missing evidence in
another.*

**Independent Test / Unabhängiger Test**: Eine Abschlussmatrix besitzt genau
sieben Zeilen und weist pro Repository alle anwendbaren Gates, ihre Evidence
und den Delivery-Zustand nach.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** ein Zielrepository fehlt, ist verschmutzt, divergiert, folgt einem unerwarteten Remote oder besitzt keine eindeutige kanonische Quelle, **When / Wenn** der Implementierungs-Preflight läuft, **Then / Dann** stoppt der Lauf vor der ersten Mutation.
2. **Given / Angenommen** Home Baseline ist lokal validiert, **When / Wenn** der Vertrag in weitere Repositories übernommen wird, **Then / Dann** folgt `agent-operations-cockpit` zuerst und jedes weitere Repository bleibt ein getrennt prüfbarer Abschluss.
3. **Given / Angenommen** alle fachlichen Ausgaben stimmen, **When / Wenn** ein repositoryspezifischer Pflichtnachweis fehlt, **Then / Dann** gilt das betroffene Repository und das Gesamtfeature nicht als abgeschlossen.

### Randfälle / Edge Cases

- Ein `Completed`-Status besitzt mehrere plausible Feature-Verzeichnisse: Hard Stop wegen mehrdeutiger Zuordnung; kein Link wird geraten.
- Ein Feature-Verzeichnis ist vorhanden, aber der Intake ist nicht abgeschlossen: kein Feature-Link; das Feld kennzeichnet den fehlenden Abschluss verständlich.
- Ein relativer Pfad enthält `..`, ist absolut, verweist über einen symbolischen Link außerhalb des Repositorys oder beginnt mit einem Optionszeichen: als nicht vertrauenswürdige Pfaddaten behandeln und fail-closed stoppen.
- Ein Linkziel verschwindet zwischen Preview und Veröffentlichung: Validierung wird unmittelbar erneut ausgeführt; keine veraltete Ausgabe wird veröffentlicht.
- Eine beratende Kante wird als bindend dargestellt oder ihre Richtung vertauscht: Manifestvergleich schlägt fehl.
- Die sichtbare Position 39 wird mit dem aktiven Manifestplatz 1 verwechselt: beide Bedeutungen bleiben getrennt; Position 39 bleibt sichtbar, `Primary`, Root und einziger deklarierter `Eligible`-Kandidat.
- Die beratende `PreferredSerialOrder`-Kante Position 39 → Position 7 wird als Start- oder Blockierautorität interpretiert: Hard Stop; `binding: false` bleibt sichtbar.
- Ein Renderer normalisiert Zeilenenden plattformabhängig und erzeugt einen zweiten Diff: Paritäts- und Idempotenzgate schlägt fehl.
- Eine generierte Tabelle wurde manuell geändert: der kanonische Renderer überschreibt oder verweigert die Drift entsprechend dem lokalen Vertrag; die manuelle Änderung wird nicht zur Quelle.
- TuiVision ist beim Implementierungsstart weiterhin nicht lokal vorhanden: erst innerhalb aktueller Umsetzungsautorität wiederherstellen, danach Remote, Default-Branch, Sauberkeit und Synchronität prüfen.
- Eine neue Abhängigkeit scheint für die Umsetzung nötig: Scope stoppt vor Aufnahme; getrenntes Supply-Chain-Review und aktualisierte Planung sind erforderlich.

## Anforderungen / Requirements *(mandatory)*

### Funktionale Anforderungen / Functional Requirements

- **LAF-001 – Gemeinsame Spalten / Shared Columns**: Jede betroffene Root-Ansicht MUSS die Spalten `Position`, `Status`, `Lastenheft/Intake`, `Abhängigkeiten` und `Spec-Kit-Feature` in dieser Reihenfolge anbieten.
- **LAF-002 – Intake-Link / Intake Link**: Jeder angezeigte Lastenheft-Dateiname MUSS als relativer Markdown-Link auf die im Repository vorhandene Intake-Datei führen.
- **LAF-003 – Vollständige Linkbeschriftung / Complete Link Label**: Die Linkbeschriftung MUSS den tatsächlichen Markdown-Dateinamen enthalten; ein verkürzter Titel darf ihn nicht ersetzen.
- **LAF-004 – Direkte Abhängigkeiten / Direct Dependencies**: Jede direkte eingehende Series-Abhängigkeit MUSS mit ihrem `kind` und als `bindend / binding` oder `beratend / advisory` dargestellt werden.
- **LAF-005 – Root-Darstellung / Root Representation**: Ein Intake ohne direkte eingehende Abhängigkeit MUSS als `— (Root / keine direkte Abhängigkeit)` erkennbar sein.
- **LAF-006 – Belegter Feature-Link / Proven Feature Link**: Für jeden `Completed`-Eintrag mit vorhandenem zugeordnetem Feature-Verzeichnis MUSS die Spalte `Spec-Kit-Feature` relativ auf `specs/<feature>/` verlinken.
- **LAF-007 – Abgeschlossen ohne Feature / Completed Without Feature**: Für jeden `Completed`-Eintrag ohne zuordenbares vorhandenes Feature-Verzeichnis MUSS exakt `— (kein Spec-Kit-Feature / no Spec Kit feature)` erscheinen.
- **LAF-008 – Nicht abgeschlossen / Not Completed**: Nicht abgeschlossene Einträge DÜRFEN keinen erfundenen Feature-Link erhalten; ihr Feature-Feld MUSS den fehlenden Abschluss verständlich kennzeichnen.
- **LAF-009 – Kanonische Übereinstimmung / Canonical Agreement**: Position, Rolle, Status, Root-Zugehörigkeit, Kantenrichtung, `kind` und `binding` MÜSSEN mit der jeweiligen kanonischen Quelle übereinstimmen.
- **LAF-010 – Keine fachliche Mutation / No Business Mutation**: Die Harmonisierung DARF keinen Lifecycle-Zustand, keine Reihenfolge und keine Abhängigkeit fachlich ändern.
- **LAF-011 – Relative Linkprüfung / Relative Link Validation**: Relative Links MÜSSEN vom Speicherort der erzeugten Ansicht aus aufgelöst und auf vorhandene Datei- oder Verzeichnisziele innerhalb des Repositorys geprüft werden.
- **LAF-012 – Textorientierte Nutzbarkeit / Text-First Usability**: Tabellen MÜSSEN in Markdown und als linearisierter Text mit Screenreader, Braille-Zeile und Textbrowser verständlich bleiben.
- **LAF-013 – Kanonische Bearbeitung / Canonical Editing**: Änderungen MÜSSEN an der jeweiligen kanonischen Renderer- oder Manifestquelle erfolgen; eine isolierte Bearbeitung erzeugter Tabellen ist unzulässig.
- **LAF-014 – Idempotenz / Idempotence**: Wiederholte Renderer-Läufe mit unveränderten Eingaben MÜSSEN byteidentische fachliche Ausgabe erzeugen.
- **LAF-015 – Bash-/PowerShell-Parität / Bash-PowerShell Parity**: Die gemeinsamen Home-Baseline-Renderer für Bash und PowerShell MÜSSEN dieselben Links, Abhängigkeiten, Statuswerte und Feature-Nachweise erzeugen.
- **LAF-016 – Hilfe und Manpage / Help and Man Page**: Zugehörige Manpages und Hilfetexte MÜSSEN den erweiterten Ausgabe- und Validierungsvertrag dokumentieren.
- **LAF-017 – Level-1-Übernahme / Level-1 Adoption**: `agent-operations-cockpit` DARF den gemeinsamen Vertrag erst nach der lokal validierten Level-0-Änderung gezielt übernehmen.
- **LAF-018 – Lokale JavaScript-Renderer / Local JavaScript Renderers**: TinyPl0 und TinyCalc MÜSSEN ihre lokalen JavaScript-Renderer und alle daraus erzeugten Root-, Series- oder Evidence-Ansichten gemeinsam aktualisieren.
- **LAF-019 – Manifestgestützte Ansichten / Manifest-Backed Views**: InventarWorkerService und `absdd-image-sandbox` MÜSSEN ihre manifestgestützten Ansichten aus den vorhandenen kanonischen Daten erzeugen.
- **LAF-020 – TuiVision-Konsistenz / TuiVision Consistency**: TuiVision MUSS `scripts/render-requirements-intake-governance.mjs`, die Root-Ansicht und `requirements/intakes/series/tui-vision-delivery/order.md` konsistent aktualisieren.
- **LAF-021 – Repository-Governance / Repository Governance**: Repositoryspezifische Statistik-, Documentation-Impact- und Agent-Guidance-Regeln MÜSSEN pro Zielrepository geprüft und erfüllt werden.
- **LAF-022 – Produktgrenze / Product Boundary**: Produkt-APIs, Programmlogik, Runtime-Verhalten und öffentliche Datentypen DÜRFEN durch diese Dokumentationsarbeit nicht geändert werden.
- **LAF-023 – Zehn TuiVision-Zeilen / Ten TuiVision Rows**: Die TuiVision-Root-Ansicht MUSS genau zehn Tabellenzeilen mit Status `Completed` aus dem Series-Manifest ableiten.
- **LAF-024 – Sechs TuiVision-Abhängigkeiten / Six TuiVision Dependencies**: Die sechs vorhandenen TuiVision-Abhängigkeiten MÜSSEN mit unverändertem `kind`, unveränderter Richtung und unverändertem Bindungsstatus dargestellt werden.
- **LAF-025 – Letzter TuiVision-Abschluss / Latest TuiVision Completion**: Feature `046-gsdb-spec-kit-intensive-review` MUSS zusätzlich als zuletzt abgeschlossen erkennbar bleiben, ohne die kanonische Tabellenfolge 1 bis 10 zu verändern.
- **LAF-026 – Getrennter TuiVision-Backlog / Separate TuiVision Backlog**: `requirements/intakes/backlog/Lastenheft_Optional-NuGet-Package.md` MUSS getrennt als `DeferredOptional` im nicht ausführbaren Backlog verbleiben.
- **LAF-027 – Kein künstliches elftes Mitglied / No Artificial Eleventh Member**: Der optionale Backlog-Eintrag DARF weder als elftes aktives Serienmitglied erscheinen noch einen künstlichen Feature-Link erhalten.
- **LAF-028 – Plattformreihenfolge / Platform Order**: Auf macOS und Linux MUSS die vorhandene Bash-Variante zuerst geprüft werden; auf Windows die vorhandene PowerShell-7-Variante. Relevante Gegenvarianten MÜSSEN anschließend auf Parität geprüft werden.
- **LAF-029 – Sichere Pfadbehandlung / Safe Path Handling**: Pfade aus Manifesten MÜSSEN als nicht vertrauenswürdige repository-relative Daten behandelt werden; Renderer DÜRFEN sie nicht ausführen und nicht außerhalb des jeweiligen Repositorys auflösen.
- **LAF-030 – Strikte Eingabegrenzen / Strict Input Boundaries**: Ungültige UTF-8-Daten, NUL-Inhalt, unbekannte Ziele, Pfadüberschreitungen oder mehrdeutige Feature-Zuordnungen MÜSSEN vor einer Veröffentlichung fehlschlagen.
- **LAF-031 – Keine sensitiven Ausgaben / No Sensitive Output**: Ausgaben DÜRFEN keine Credentials, Tokens, privaten absoluten Pfade oder unnötigen personenbezogenen Daten enthalten.
- **LAF-032 – Bilingualer Vertrag / Bilingual Contract**: Nutzerseitige Inhalte MÜSSEN Deutsch zuerst und Englisch danach auf CEFR-B2-Niveau anbieten, sofern das Zielrepository diesen Vertrag verwendet.
- **LAF-033 – WCAG 2.2 AA**: Anwendbare Anforderungen aus WCAG 2.2 Level AA MÜSSEN erfüllt werden; Bedeutung darf nicht allein durch Farbe, Symbol oder Tabellenlayout vermittelt werden.
- **LAF-034 – Didaktische Kommentare / Didactic Comments**: Neue nicht triviale Renderer-Logik MUSS auf didaktischen Inline-Kommentarbedarf geprüft werden; Kommentare erklären Grund, Randbedingung oder Proof-Grenze und nicht offensichtliches Verhalten.
- **LAF-035 – Keine neue Abhängigkeit / No New Dependency**: Die Änderung DARF keine neue Abhängigkeit einführen. Wird eine neue Abhängigkeit unvermeidbar, MUSS die Umsetzung vor Aufnahme stoppen und ein getrenntes Supply-Chain-Review verlangen.

### Scope und Nicht-Ziele / Scope and Non-Goals

Der Implementierungsscope umfasst genau diese sieben Repositories und keine
weiteren:

| Repository | Registrierter Arbeitsbereich / Registered Workspace | Bindender lokaler Kontext / Binding Local Context |
|---|---|---|
| `home-baseline` | `home-baseline-source` | Kanonischer Level-0-Vertrag sowie gemeinsame Bash-/PowerShell-Renderer |
| `agent-operations-cockpit` | `RiderProjects/AgentOperationsCockpit` | Gezielte Übernahme nach lokal validiertem Level 0 |
| `TinyPl0` | `RiderProjects/TinyPl0` | Lokaler JavaScript-Renderer und erzeugte Ansichten |
| `TinyCalc` | `RiderProjects/TinyCalc` | Lokaler JavaScript-Renderer und erzeugte Ansichten |
| `TuiVision` | `RiderProjects/TuiVision` | Bindender Zehn-Intake-Vertrag und lokaler JavaScript-Renderer |
| `InventarWorkerService` | `RiderProjects/InventarWorkerService` | Manifestgestützte Reihenfolgeansicht |
| `absdd-image-sandbox` | `container-images/absdd-image-sandbox` | Manifestgestützte Reihenfolgeansicht in der Sandbox-Quelle |

Nicht im Scope sind Produkt-, API-, Runtime-, öffentliche Datentyp-, Build-
oder Dependency-Änderungen, Änderungen fachlicher Reihenfolgen, Lifecycle-
Zustände, Rollen, Roots oder Kanten sowie die Migration weiterer
Repositories. Specify selbst verändert keine anderen Checkouts oder Remotes
und führt keine Implementierung aus.

### Verbindliche TuiVision-Zuordnung / Binding TuiVision Mapping

| Position | Intake-Datei / Intake File | Spec-Kit-Feature |
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

### Verfassungsanforderungen / Constitution Requirements

- **CR-001**: Die passenden Einträge des Level-2 Project Environment Registry aus `constitution.md` und den lokalen Verfassungen MÜSSEN bei Planung, Implementierung und Test pro Zielrepository bindend verwendet werden; `home-baseline` bleibt Level 0.
- **CR-002**: Alle nutzerseitigen Ansichten, Hilfen, Fehler und Evidence-Zusammenfassungen MÜSSEN ihren WCAG-2.2-AA-Reviewpfad benennen und vollständig textorientiert verständlich bleiben.
- **CR-003**: Nutzer- und lernendenseitige Inhalte MÜSSEN Deutsch zuerst und Englisch danach auf CEFR B2 liefern, Fachbegriffe bei erster Verwendung erklären und keine Spec-Kit-Erfahrung voraussetzen, sofern der lokale Sprachvertrag gilt.
- **CR-004**: Statistik- und AI-Agent-Guidance-Auswirkungen MÜSSEN in jedem der sieben Zielrepositories ausdrücklich als Update oder begründetes `N/A` entschieden werden.
- **CR-005**: Primäre Implementierungssprache für die lokalen Renderer ist JavaScript, eine Memory-Safe Language (MSL) der Allowlist. Bestehende Home-Baseline-Adapter bleiben Bash und PowerShell 7 und MÜSSEN deren sichere Codingregeln erfüllen. Abweichende lokale Renderer-Sprachen werden im Plan aus dem jeweiligen Registry-/Repositoryvertrag übernommen und erneut auf MSL-Anwendbarkeit geprüft.
- **CR-006**: `NIST SSDF` und `CWE Top 25` MÜSSEN für die produktionsgebundenen Rendereränderungen berücksichtigt werden; alle weiteren Security-Standards sind in der Governance-Tabelle ausdrücklich als `Applicable` oder `N/A` mit Begründung bewertet.
- **CR-007**: `OWASP ASVS` ist `N/A`, weil keine Web-, API-, HTTP-, Authentifizierungs- oder Autorisierungsfläche geändert wird. Re-Evaluation: Eine solche Fläche oder ein Netzwerkzugriff kommt in Scope.
- **CR-008**: `SBOM`, `VEX` und `SLSA` sind für diese reine Dokumentations-/Rendereränderung ohne neue Abhängigkeit oder neues Release-Artefakt `N/A`. Re-Evaluation: Dependency-, Paket-, Build-, Release- oder Veröffentlichungsumfang ändert sich.
- **CR-009**: AI wird nur als Entwicklungswerkzeug verwendet und ist kein ausgelieferter oder betriebener Produktbestandteil; `AI-SBOM` ist daher `N/A`. Re-Evaluation: Ein Modell, AI-Service, Datensatz oder Inferenzbestandteil kommt in Runtime- oder Produktscope.
- **CR-010**: Bestehende Manifest-zu-Renderer-Pfadgrenzen sind sicherheitsrelevant und MÜSSEN gegen Pfadüberschreitung und unerwartete Eingaben geprüft werden. Es entstehen keine neuen verteilten oder Remote-Trust-Boundaries; Zero Trust ist begründet `N/A`.
- **CR-011**: Home Baseline plant Security-Evidence unter `docs/security/linked-intake-evidence.md`; jedes weitere Zielrepository nutzt denselben relativen Pfad oder einen ausdrücklich begründeten lokalen Governance-Pfad.
- **CR-012**: Security, Architecture, iSAQB Architecture, A11Y, Cross-Platform, Agent Parity, Autonomous Run und Parallel Autonomous Run werden als Standardmatrix geprüft; die fleet-lokal installierten optionalen Model-Routing-, Intake-Authoring-, Intake-Review- und Intake-Sequencing-Presets bleiben zusätzlich bindend, soweit sie diesen Lauf betreffen.
- **CR-013**: Documentation Impact ist genau einmal als `GeneratedUpdate` entschieden: kanonische Renderer-/Manifestquellen werden geändert und die erzeugten Reihenfolgeansichten reproduzierbar aktualisiert. Details stehen im Abschnitt Documentation Impact.
- **CR-014**: Plattformnachweise MÜSSEN den agentenneutralen macOS-first-Vertrag erfüllen: lokaler Safe Mode zuerst, danach isolierter nativer Linux- beziehungsweise eng begrenzter nativer Windows-Nachweis mit exaktem Commit, Befehl, Runner/Plattform, Exitcode, Payload-SHA-256, Entscheidungs-SHA-256 und Nullschreibbindung. Teilproof ist kein vollständiger Regressionspass.

### Schlüsselentitäten / Key Entities

- **Repository-Ziel / Repository Target**: Eines der genau sieben benannten Repositories mit registriertem Pfad, Remote, Default-Branch, kanonischer Renderer-/Manifestquelle und repositoryspezifischen Gates.
- **Intake-Eintrag / Intake Entry**: Ein Series-Mitglied mit Dateipfad, sichtbarer Position, aktivem Manifestplatz, Rolle, Lifecycle-Status, Root-Zugehörigkeit und optionaler Feature-Zuordnung.
- **Abhängigkeitskante / Dependency Edge**: Eine direkte gerichtete Beziehung zwischen zwei Intakes mit `kind` und `binding`; `binding: false` ist beratend und kein Ausführungsgate.
- **Spec-Kit-Feature-Nachweis / Spec Kit Feature Evidence**: Ein tatsächlich vorhandenes repositoryrelatives Verzeichnis `specs/<feature>/`, das einem abgeschlossenen Intake eindeutig zugeordnet ist.
- **Erzeugte Reihenfolgeansicht / Generated Order View**: Die reproduzierbare textorientierte Darstellung aus kanonischen Daten mit den fünf gemeinsamen Feldern.
- **Repository-Abnahme / Repository Acceptance Record**: Die lokale Zusammenfassung aus Test-, Link-, UTF-8-, A11Y-, Security-, Documentation-Impact-, Statistik-, Agent-Parity- und Delivery-Evidence.

## Erfolgskriterien / Success Criteria *(mandatory)*

### Messbare Ergebnisse / Measurable Outcomes

- **SC-001**: Genau sieben und ausschließlich die benannten Repositories besitzen nach Abschluss den gemeinsamen Fünf-Felder-Vertrag in ihren betroffenen Root-Ansichten.
- **SC-002**: 100 % der angezeigten Intake-Dateinamen sind vollständige relative Markdown-Links auf vorhandene Dateien innerhalb des jeweiligen Repositorys.
- **SC-003**: 100 % der direkten eingehenden Abhängigkeiten stimmen in Richtung, `kind` und Bindungsstatus mit der kanonischen Quelle überein; Intakes ohne direkte Vorgänger zeigen den vereinbarten Root-Text.
- **SC-004**: 100 % der `Completed`-Zeilen besitzen entweder einen gültigen eindeutigen Feature-Link oder exakt den vereinbarten Kein-Feature-Text; 0 nicht abgeschlossene Zeilen besitzen einen erfundenen Feature-Link.
- **SC-005**: Zwei aufeinanderfolgende Renderer-Läufe mit unveränderten Eingaben erzeugen in jedem Zielrepository 0 zusätzliche Diffs.
- **SC-006**: TuiVision zeigt genau 10 `Completed`-Zeilen, 10 gültige Feature-Links `037` bis `046`, alle 6 bestehenden Abhängigkeiten und genau 1 getrennten `DeferredOptional`-Backlogeintrag.
- **SC-007**: Die fachliche Vorher-/Nachher-Prüfung meldet 0 Änderungen an Lifecycle, Reihenfolge, Rollen, Roots oder Abhängigkeitskanten und 0 Änderungen an Produkt-API, Runtime-Verhalten oder öffentlichen Datentypen.
- **SC-008**: 100 % der sieben Repository-Abnahmezeilen besitzen bestandene anwendbare Test-, Link-, UTF-8-, A11Y-, Statistik-, Documentation-Impact- und Security-Gates; ein fehlender Pflichtnachweis verhindert den Gesamtabschluss.
- **SC-009**: In linearisierten Screenreader-/Textbrowser-Prüfungen können Reviewer für 100 % der Stichproben Position, Status, Intake, Abhängigkeiten, Feature-Zustand und nächste Aktion ohne Farbe oder Tabellenposition bestimmen.
- **SC-010**: Home-Baseline-Bash- und PowerShell-Ausgaben stimmen bei identischen Eingaben in 100 % der fachlichen Felder überein; der bestehende Byteparitätsvertrag wird ohne Abweichung erfüllt.

## Annahmen und Abhängigkeiten / Assumptions and Dependencies

- Der Ready-Review bestätigt eine vollständige Anforderungenfassung ohne offene materielle Entscheidung; es werden keine Klarstellungsmarker benötigt.
- Position 39 bleibt die stabile sichtbare Kennung, aktiver Manifestplatz 1, `Primary`, Root und einziger deklarierter `Eligible`-Kandidat. Die nicht bindende `PreferredSerialOrder`-Kante führt von Position 39 zu Position 7 `Lastenheft_Secure-Development-Container-Hardening.md`.
- Die jeweiligen Series-Manifeste, lokalen Renderer und vorhandenen Feature-Verzeichnisse bleiben die kanonischen Quellen; die Spezifikation erfindet keine Zuordnungen.
- Der fehlende TuiVision-Checkout ist während Specify kein Fehler. Seine Wiederherstellung und Validierung sind ein späteres Implementierungs-Preflight-Gate.
- Home Baseline definiert und validiert den gemeinsamen Vertrag zuerst; `agent-operations-cockpit` übernimmt ihn anschließend gezielt. Die übrigen fünf Zielrepositories werden einzeln abgeschlossen.
- Bestehende Governance-Änderungen im aktuellen Worktree sind akzeptierte Eingabeevidence und werden durch Specify nicht zurückgesetzt, bereinigt oder umgeschrieben.
- Keine neue Dependency ist erforderlich. Eine entgegenstehende Planungsfeststellung stoppt und löst ein getrenntes Supply-Chain-Review aus.

## Delivery-Kontext und Autonomous-Run-Vertrag / Delivery Context and Autonomous Run Contract

Dieser Abschnitt beschreibt ausschließlich den aktuellen Liefer- und
Orchestrierungskontext. Er ist keine Produktanforderung und erweitert den
fachlichen Scope nicht.

- **Delivery Mode**: `MergeAndSync`, ausdrücklich durch den aktuellen Nutzerauftrag autorisiert. Dieser Modus gilt für spätere, gategebundene Delivery-Phasen; Specify selbst führt keinen Commit, Push, Pull Request, Merge, Home-Sync oder eine Änderung anderer Repositories aus.
- **Admin-Bypass authority**: ausdrücklich vorhanden, aber ausschließlich als eng begrenzter späterer Ausnahmeweg nach einem regulären `protection-only` Merge-Refusal. Der Bypass ersetzt niemals Task-, Acceptance-, Security-, Review-, CI- oder sonstige Gate-Evidence und erteilt keine allgemeine Provider-, Secret-, Billing- oder Repository-Admin-Autorität.
- **Feature identity**: `specs/032-linked-intake-evidence` auf Branch `032-linked-intake-evidence`; Run-State `specs/032-linked-intake-evidence/autonomous-run-state.json`.
- **Accepted inputs**: der hashgebundene Intake, Authoring-Receipt, Ready-Review-Request/-Result/-Report sowie Series-Manifest/-Receipt und Operationsevidence aus dem unverändert übernommenen Run-State.
- **Autonomy boundary**: genau sieben benannte Repositories, keine fachliche Reihenfolgeänderung, keine Produktänderung, keine neue Dependency und keine nicht ausdrücklich gategebundene Remote- oder Provideraktion.
- **Delivery-set validation**: `Applicable`; vor der ersten späteren Mutation werden registrierter Pfad, Remote, Default-Branch, Sauberkeit, Synchronität und kanonische Quelle aller sieben Ziele frisch geprüft.
- **Routed-phase result semantics**: `Applicable`; jede Phase schreibt genau das Ergebnisformat des `autonomous-phase-result-template.json` an den im Run-State gebundenen `resultPath`. `Completed` ist nur zulässig, wenn erwartete Tasks und alle Phasengates vollständig belegt sind.
- **Gate-evidence lifecycle**: `Applicable`; Evidence ist repository-, Gate-, Commit-, Befehls- und Plattform-gebunden. Drift invalidiert betroffene Ergebnisse und verlangt Revalidierung statt stiller Wiederverwendung.
- **Causal closeout**: `Applicable`, weil `MergeAndSync` mehrere Repositorylieferungen mit abhängiger Reihenfolge umfasst. Closeout MUSS nachweisen, dass jeder Merge und Sync kausal zu einem bestandenen Repositoryabschluss gehört.
- **Mutable validation tokens**: `N/A`; Specify definiert keine wiederverwendbaren veränderlichen Freigabetokens. Re-Evaluation: Ein späterer Plan führt zeit- oder zustandsgebundene Token ein.
- **Deliberate stop**: Ein kooperativer Stop wird nur an einer sicheren Repository-/Phasengrenze wirksam und erteilt keine zusätzliche Autorität.
- **Unexpected interruption**: Vor Resume MÜSSEN Run-State, Branch/HEAD, akzeptierte Hashes, Zielzustände, Authority und bereits ausgeführte Operationen vollständig neu geprüft werden. Teiloperationen werden nicht dupliziert.
- **Explicit resume/block conditions**: `PausedByUser`, Hash-/Governance-/Authority-Drift, fehlende Pflicht-Evidence, verschmutzte/divergierte Ziele, unerwartete Remotes oder mehrdeutige Quellen blockieren bis zu einem ausdrücklich autorisierten Resume beziehungsweise einer Remediation.
- **Retrospective boundary**: Die Retrospektive darf nur portable Erkenntnisse zu Renderer-, Link-, Gate- und Multi-Repository-Evidence ableiten; sie startet kein Folgefeature und erweitert keine Flottenautorität.

### Acceptance-Gates / Abnahme-Gates

| Gate-ID | State | Required Scope / Erforderlicher Scope | Evidence / Nachweis | Owner / Reviewer | Re-Evaluation Trigger |
|---|---|---|---|---|---|
| `AC-LAF-001` | `Applicable` | Genau sieben Zielrepositories, kein weiteres Repository verändert | Sieben-Ziel-Diff- und Registry-Matrix | Fleet Owner / Feature Reviewer | Registry, Zielname, Pfad oder Scope ändert sich |
| `AC-LAF-002` | `Applicable` | Jede aktive Zeile besitzt fünf Felder in vereinbarter Reihenfolge | Renderer-Fixtures und erzeugte Ansichten | Repository Owner / Feature Reviewer | Spalten- oder View-Vertrag ändert sich |
| `AC-LAF-003` | `Applicable` | Alle Intake-Dateinamen sind gültige relative Links | Repositoryrelative Linkprüfung | Repository Owner / Documentation Reviewer | Intake-Pfad oder View-Speicherort ändert sich |
| `AC-LAF-004` | `Applicable` | Alle direkten Abhängigkeiten stimmen in Richtung, Typ und Bindung | Manifest-zu-Ausgabe-Abgleich | Repository Owner / Governance Reviewer | Series-Manifest oder Kantenmodell ändert sich |
| `AC-LAF-005` | `Applicable` | Jede `Completed`-Zeile besitzt gültigen Feature-Link oder exakten Fallback | Feature-Zuordnungs- und Existenzprüfung | Repository Owner / Feature Reviewer | Lifecycle oder Feature-Verzeichnis ändert sich |
| `AC-LAF-006` | `Applicable` | Kein Lifecycle, keine Position, Rolle, Root oder Kante fachlich geändert | Normalisierter Vorher-/Nachher-Abgleich | Fleet Owner / Governance Reviewer | Kanonische Quelldaten ändern sich |
| `AC-LAF-007` | `Applicable` | Zweiter unveränderter Renderer-Lauf erzeugt null Diff | Idempotenzprotokoll pro Repository | Repository Owner / Technical Reviewer | Rendererlogik oder Normalisierung ändert sich |
| `AC-LAF-008` | `Applicable` | Home-Baseline-Bash/PowerShell semantisch und vertragsgemäß bytegleich | Paritätsfixtures auf macOS, Linux und Windows | Level-0 Owner / Cross-Platform Reviewer | Plattform, Shell oder Ausgabeformat ändert sich |
| `AC-LAF-009` | `Applicable` | TuiVision: 10 Completed, Features 037–046, 6 Abhängigkeiten | TuiVision-Manifest-/Linkmatrix | TuiVision Owner / Feature Reviewer | TuiVision-Manifest oder Zuordnung ändert sich |
| `AC-LAF-010` | `Applicable` | Feature 046 bleibt als letzter Abschluss sichtbar, Tabellenfolge unverändert | TuiVision-Order- und Abschlussprüfung | TuiVision Owner / Governance Reviewer | Abschluss- oder Darstellungsvertrag ändert sich |
| `AC-LAF-011` | `Applicable` | Genau ein getrennter `DeferredOptional`-Backlog, kein aktives Mitglied | TuiVision-Backlogprüfung | TuiVision Owner / Governance Reviewer | Backlog-Lifecycle ändert sich |
| `AC-LAF-012` | `Applicable` | Alle lokalen Test-, Link-, UTF-8-, A11Y-, Statistik- und Documentation-Impact-Gates bestanden | Siebenzeilige Repository-Abnahmematrix | Fleet Owner / Fachreviewer je Gate | Lokaler Governance- oder Toolingvertrag ändert sich |
| `AC-LAF-013` | `Applicable` | Deliveryzustand pro Repository dokumentiert | Run-State, PR-/Merge-/Sync- oder lokale Evidence | Fleet Owner / Delivery Reviewer | DeliveryMode, Authority oder Branchschutz ändert sich |
| `AC-LAF-014` | `Applicable` | Null Produkt-API-, Runtime- oder Dependency-Änderungen | Scope-Diff, Dependency- und Runtime-Vergleich | Repository Owner / Architecture & Security Reviewer | Produkt-, Runtime- oder Dependencydatei kommt in Diff |

Gate Owner ist der Fleet Owner; repositoryspezifische Owner und Reviewer
bleiben in der jeweiligen Abnahmematrix namentlich oder rollenbasiert
zugeordnet. Restrisiko vor Implementierung ist eine noch unbekannte lokale
Renderer- oder Manifestabweichung. Follow-up ist eine aktualisierte Planung
und erneute Gate-Prüfung, keine stillschweigende Scope-Erweiterung.

## Governance-Anwendbarkeit / Governance Applicability

| Checkpoint | Applicability | Implementation Status | Rationale / Begründung | Planned Evidence / Geplante Evidence | Owner / Reviewer | Residual Risk, Follow-up, Re-Evaluation |
|---|---|---|---|---|---|---|
| Security Governance | `Applicable` | `Partly Fulfilled` | Manifestpfade, Linkziele, UTF-8/NUL, Secrets und Evidence-Integrität überschreiten bestehende Eingabegrenzen. | `docs/security/linked-intake-evidence.md` oder begründeter lokaler Pfad je Repository | Repository Owner / Security Reviewer | Lokale Rendererabweichung; bei Pfad-, Dependency-, Runtime- oder Trust-Boundary-Änderung neu prüfen |
| Architecture Governance | `Applicable` | `Partly Fulfilled` | Kanonische Quelle, Renderer und erzeugte Ansicht bilden einen qualitätsrelevanten Datenfluss; keine Produktarchitektur wird geändert. | `docs/architecture/linked-intake-evidence.md` oder begründeter lokaler Pfad | Repository Owner / Architecture Reviewer | Unbekannte lokale Quelle; bei neuem Building Block, Interface oder Deployment neu prüfen |
| iSAQB Architecture Governance | `Applicable` | `Partly Fulfilled` | Qualitätseigenschaften Nachvollziehbarkeit, Korrektheit, Idempotenz und Wartbarkeit sind betroffen. | Architektur-/Qualitätsszenarien in lokalem Evidence-Dokument | Repository Owner / Architecture Reviewer | Lokale technische Schuld; bei Kontext- oder Schnittstellenänderung neu prüfen |
| A11Y Governance | `Applicable` | `Partly Fulfilled` | Markdown-Ansichten, Hilfe, Fehler und Evidence sind nutzerseitige Artefakte. | `docs/accessibility/linked-intake-evidence.md` oder begründeter lokaler Pfad | Repository Owner / A11Y Reviewer | Tabellenlinearisierung; bei neuem HTML, UI, Bild oder Medienartefakt neu prüfen |
| Cross-Platform Governance | `Applicable` | `Partly Fulfilled` | Home Baseline ändert ein bestehendes Bash-/PowerShell-Rendererpaar; lokale JavaScript-Renderer müssen auf ihren unterstützten Plattformen deterministisch bleiben. | Plattform- und Paritätsnachweise je Repository | Repository Owner / Cross-Platform Reviewer | Zeilenenden/Pfadsemantik; bei Plattform- oder Script-Scope-Änderung neu prüfen |
| Agent Parity Governance | `Applicable` | `Partly Fulfilled` | Jedes Repository muss Guidance-Auswirkung prüfen; eine neue gemeinsame Regel ist nicht beabsichtigt. | Agent-Parity-Entscheidung in jeder Repository-Abnahme | Repository Owner / Agent-Parity Reviewer | Verdeckte Betriebsregel; bei Guidance-, Template-, Constitution- oder Routingänderung atomar aktualisieren |
| Autonomous Run Governance | `Applicable` | `Partly Fulfilled` | `MergeAndSync`, sieben abhängige Lieferziele, Phase Results, Stop/Resume und kausaler Closeout sind aktiv. | Run-State, Phase Results, Repository-Abnahmematrix, Closeout-Evidence | Fleet Owner / Autonomous Reviewer | Authority-/State-Drift; an jeder Phasengrenze revalidieren |
| Parallel Autonomous Run Governance | `N/A` | `Not Assessed` | Der akzeptierte Lauf ist seriell; die bindende Level-0→Level-1-Reihenfolge und repositoryweise Hard Stops erlauben keine implizite Kampagnenparallelisierung. | Diese begründete N/A-Entscheidung im Spec | Fleet Owner / Autonomous Reviewer | Re-Evaluation nur bei ausdrücklich autorisiertem Parallel-Campaign-Plan |
| Model Routing Governance | `Applicable` | `Fulfilled` | Die Specify-Phase ist bereits agentenneutral auf eine lokale Runnerrolle gebunden; provider- oder modellspezifische Produktanforderungen entstehen nicht. | Unveränderter Run-State und phasengebundener Result-Pfad | Fleet Owner / Routing Reviewer | Lokales Profil, Rolle oder Preflight driftet |
| Intake Authoring Governance | `Applicable` | `Fulfilled` | Hashgebundener Intake und Authoring-Receipt sind akzeptierte Eingaben. | Im Run-State gebundene Intake-/Receipt-Hashes | Intake Owner / Governance Reviewer | Intake-Hash oder Receipt ändert sich |
| Intake Review Governance | `Applicable` | `Fulfilled` | Review ist `Ready`, ohne Finding, Frage, Risiko oder Ausnahme. | Review `9bcbbeb6-957c-4ef4-ba3e-53eb719c8811` | Intake Owner / Review Owner | Review-, Request- oder Target-Hash ändert sich |
| Intake Sequencing Governance | `Applicable` | `Fulfilled` | Position 39 ist aktiver Manifestplatz 1, `Primary`, Root und einziger deklarierter `Eligible`-Kandidat; Kante zu Position 7 ist beratend. | Gebundene Series-Manifest-/Receipt-/Operation-Hashes | Series Owner / Governance Reviewer | Rolle, Lifecycle, Root, Reihenfolge oder Kante driftet |

`Partly Fulfilled` bedeutet: Specify hat Scope, Qualitätsziel und
Evidencevertrag vollständig festgelegt; ausführbare Implementierungs- und
Repository-Evidence folgt erst in den späteren Phasen. Fehlende applicable
Evidence blockiert `Completed`.

## Security Governance und Evidence / Security Governance and Evidence

| Standard / Checkpoint | Applicability | Status | Rationale / Begründung | Evidence / Follow-up | Re-Evaluation Trigger |
|---|---|---|---|---|---|
| MSL / Secure Coding | `Applicable` | `Partly Fulfilled` | JavaScript ist MSL; Bash-/PowerShell-Adapter bleiben nach den jeweiligen sicheren Codingregeln begrenzt. | `docs/security/linked-intake-evidence.md`, lokale Security-Checkliste | Primärsprache oder Adapter ändert sich |
| NIST SSDF | `Applicable` | `Partly Fulfilled` | Produktionsgebundene Renderer- und Evidence-Änderungen benötigen nachvollziehbare sichere Entwicklung und Prüfung. | Requirement-/Task-/Test-/Review-Traceability | Liefer- oder Produktionsscope entfällt beziehungsweise ändert sich |
| CWE Top 25 | `Applicable` | `Partly Fulfilled` | Path Traversal, Improper Input Validation und Command/Option Injection sind für Manifestpfade relevant. | Negative Pfad-, NUL-, UTF-8- und Ausführungstests | Eingabe-, Datei- oder Prozessgrenze ändert sich |
| OWASP ASVS | `N/A` | `Not Assessed` | Keine Web-, API-, HTTP-, Auth- oder Sessionfläche wird geändert. | Diese N/A-Entscheidung | Eine solche Fläche kommt in Scope |
| SBOM | `N/A` | `Not Assessed` | Kein neues Paket, keine neue Dependency und kein neues auslieferbares Softwareartefakt. | Dependency-Diff mit null Neuzugängen | Dependency- oder Release-Scope ändert sich |
| VEX | `N/A` | `Not Assessed` | Ohne neuen SBOM-/Vulnerability-Scope ist keine neue Exploitability-Aussage erforderlich. | Diese N/A-Entscheidung | SBOM, CVE oder Release-Scope entsteht |
| AI-SBOM | `N/A` | `Not Assessed` | AI ist ausschließlich Entwicklungswerkzeug, nicht Produkt- oder Runtimebestandteil. | Diese N/A-Entscheidung | AI-Modell, Service, Dataset oder Inferenz kommt in Scope |
| SLSA | `N/A` | `Not Assessed` | Keine CI/CD-gebaute oder veröffentlichte Softwarelieferung wird eingeführt. | Diese N/A-Entscheidung | Build-/Publish-Artefakt kommt in Scope |
| OpenSSF Scorecard | `N/A` | `Not Assessed` | Keine neue externe Dependency oder OSS-Supply-Chain-Auswahl. | Diese N/A-Entscheidung | Externe Dependency oder öffentlicher Supply-Chain-Scope ändert sich |
| STRIDE + CIA Threat Model | `Applicable` | `Partly Fulfilled` | Bestehende Manifest→Renderer→Dateisystem-Grenze verarbeitet nicht vertrauenswürdige Pfaddaten und schützt Integrität/Verfügbarkeit. | Lokaler Threat-Model-Eintrag unter `docs/security/` | Trust Boundary oder Datenklassifikation ändert sich |
| CAPEC | `Applicable` | `Partly Fulfilled` | Pfadmanipulation und eingeschleuste Optionen/Befehlsanteile sind einschlägige Angriffsmuster. | Negative Tests und Threat-Model-Referenz | Dateipfad- oder Prozessausführung ändert sich |
| Zero Trust | `N/A` | `Not Assessed` | Keine neue verteilte, Service-, Remote-Access- oder Netzwerkgrenze. | Diese N/A-Entscheidung | Remote-/Servicefluss kommt in Scope |
| OWASP SAMM | `Applicable` | `Partly Fulfilled` | Die Änderung stärkt definierte Requirements-, Verification- und Governance-Nachweise. | Lokale SAMM-/Security-Reviewentscheidung | Secure-Development-Prozess oder Scope ändert sich |
| BSI C3A | `N/A` | `Not Assessed` | Keine Cloud-Service-Auswahl oder providerabhängige Bereitstellung. | Diese N/A-Entscheidung | Cloud-/Providerdeployment kommt in Scope |
| BSI C5 | `N/A` | `Not Assessed` | Keine Cloud-Service-Auswahl, Hostingänderung oder Cloud-Assurance-Prüfung. | Diese N/A-Entscheidung | Cloud-/Hosting-Scope kommt in Scope |
| NIS2 / CRA / EU AI Act / DORA | `N/A` | `Not Assessed` | Keine Marktbereitstellung, Kundenübergabe, AI-Runtime, Finanzsektor-ICT- oder regulierte Lieferkette wird durch die Dokumentationsänderung neu geschaffen. | Lokale Regulatory-Applicability-Entscheidung | Release, Markt, Kunde, AI-Runtime oder regulierter Scope entsteht |
| Dependency Audit | `Applicable` | `Partly Fulfilled` | LAF-035 verlangt null neue Dependencies; der Diff muss dies belegen. | Lokaler Dependency-Diff/Audit | Eine Dependency ändert sich |

Primäres Level-0-Evidence-Dokument ist
`docs/security/linked-intake-evidence.md`. Zielrepositories verwenden denselben
relativen Pfad oder dokumentieren ihren gleichwertigen kanonischen Pfad in der
Repository-Abnahme. Owner ist der jeweilige Repository Owner; Reviewer ist die
Security-Reviewrolle. Restrisiko sind lokale Rendererabweichungen, die erst im
Implementierungs-Preflight sichtbar werden.

## Architekturanwendbarkeit / Architecture Applicability

- **Systemkontext und Datenfluss / System context and data flow**: `Applicable`; kanonisches Series-Manifest und vorhandene Feature-Verzeichnisse speisen einen lokalen Renderer, der eine Markdown-Ansicht erzeugt und vor Veröffentlichung validiert.
- **Architekturziele / Architecture goals**: fachliche Korrektheit, Nachvollziehbarkeit, Idempotenz, lokale Pfadbegrenzung, Plattformparität und Wartbarkeit.
- **Interfaces / Schnittstellen**: Bestehende Manifest-, Dateisystem-, Renderer- und generierte Markdown-Verträge werden erweitert; Produkt-Interfaces bleiben unverändert.
- **Runtime und Deployment**: `N/A` für Produkt-Runtime/-Deployment, weil nur lokale Dokumentationsrenderer und erzeugte Dateien betroffen sind. Re-Evaluation: Ein Netzwerk-, Service-, Produkt- oder Deploymentpfad kommt in Scope.
- **Hardware/MSL constraint**: `N/A`; keine Hardwaregrenze verhindert JavaScript als MSL oder die bestehenden sicheren Shelladapter. Re-Evaluation: ein Zielrenderer verlangt eine nicht-MSL-Sprache.
- **Trust boundaries**: Keine neue Grenze; die bestehende Grenze von nicht vertrauenswürdigen Manifestpfaden zu lokalem Dateisystem und Ausgabe wird strenger validiert.
- **Data classification**: Intake-, Manifest- und Feature-Metadaten sind repositoryinterne beziehungsweise öffentliche Projektdaten; Credentials, Tokens, private absolute Pfade und unnötige Personendaten bleiben ausgeschlossen.
- **Threat model / Secure architecture**: `Applicable`; STRIDE/CIA und CAPEC-Prüfung für Pfadmanipulation, Integritätsverlust und unerwünschte Ausführung. Zero Trust ist begründet `N/A`.
- **ADR / S-ADR**: `N/A`, weil keine neue architektonisch signifikante Alternative oder Security Architecture Decision gewählt wird. Re-Evaluation: Plan führt neue kanonische Quelle, neuen Building Block oder neue Trust Boundary ein.
- **arc42 Section 8**: `Applicable` als begrenzte Prüfung der Eingabevalidierung, Fehlerbehandlung, Logging/Redaction und Dependencygrenze; Update nur, wenn der lokale bestehende Architekturvertrag dies verlangt.
- **Quality scenarios**: (1) ungültiger Pfad stoppt vor Write, (2) unveränderte Eingabe erzeugt null zweiten Diff, (3) Manifest und Ausgabe stimmen zu 100 %, (4) linearisierte Ausgabe bleibt vollständig verständlich.
- **Evidence**: `docs/architecture/linked-intake-evidence.md` oder begründeter lokaler Äquivalentpfad. Owner: Repository Owner; Reviewer: Architecture Reviewer. Re-Evaluation bei Interface-, Building-Block-, Runtime-, Deployment-, Trust-Boundary- oder Dependencyänderung.

## Barrierefreiheitsanwendbarkeit / Accessibility Applicability

- **Affected artefacts / Betroffene Artefakte**: `Applicable` für Markdown-Reihenfolgeansichten, CLI-/Renderer-Ausgaben, Fehlertexte, Manpage, PowerShell-Hilfe und Evidence-Zusammenfassungen. HTML, GUI, Bilder, Audio und Video sind `N/A`, solange kein Zielrepository daraus eine zusätzliche Ausgabe erzeugt; dann wird lokal neu bewertet.
- **WCAG 2.2 AA**: Insbesondere 1.3.1 Information und Beziehungen, 1.4.1 Farbe, 2.1.1 Tastatur, 2.4.6 Überschriften und Beschriftungen, 3.1.2 Sprache von Teilen, 3.3.1 Fehlererkennung und 3.3.2 Beschriftungen/Anweisungen sind anwendbar. Pointer-, Drag-, Audio- und Videokriterien sind `N/A`; Re-Evaluation bei entsprechender Oberfläche.
- **Language / Sprache**: Deutsch zuerst, Englisch danach auf CEFR B2, sofern der lokale Vertrag dies verlangt; Überschriften folgen `DE / EN` oder eine synchronisierte `.EN.md`-Fassung wird begründet gewählt.
- **Audience / Zielgruppe**: Maintainer, Repository-Verantwortliche, Reviewer und Lernende ab dem ersten Ausbildungsjahr mit Markdown-/Git-Grundkenntnissen; Spec-Kit-Erfahrung wird nicht vorausgesetzt.
- **Text-first contract / Textorientierter Vertrag**: Position, Status, Dateiname, Kantenrichtung, `kind`, Bindungsstatus, Feature-Zustand, Fehler und nächste Aktion bleiben linear als Text verfügbar; Farbe, Symbol und räumliche Position ergänzen höchstens.
- **Code blocks and visuals / Codeblöcke und Visuals**: Codeblöcke erhalten Sprachkennzeichnung. ASCII-Darstellungen oder Bilder erhalten kurze deutsche und englische Textalternativen; für die vereinbarte Tabelle ist eine verständliche Linearisierungsprüfung Pflicht.
- **Didactic comments / Didaktische Kommentare**: `Applicable` für nicht triviale Logik zu Pfadbegrenzung, Zuordnungsmehrdeutigkeit, Idempotenz, Parität und Proof-Grenzen; Kommentare erklären Warum, Randbedingung oder Trade-off.
- **Evidence**: `docs/accessibility/linked-intake-evidence.md` oder lokaler Äquivalentpfad mit Screenreader-/Textbrowser-orientierter Linearisierungsprüfung. Owner: Repository Owner; Reviewer: A11Y Reviewer. Re-Evaluation bei jedem neuen Artefakttyp oder Interaktionsmodell.

## Plattformübergreifende Anwendbarkeit / Cross-Platform Applicability

- **Script-shaped tool**: `Applicable`; der bestehende Home-Baseline-Renderer in `scripts/lib/secure-development-hardening.sh` und `.ps1` wird erweitert. TinyPl0, TinyCalc und TuiVision ändern bestehende JavaScript-Renderer. InventarWorkerService und `absdd-image-sandbox` besitzen manifestgebundene Ansichten, aber noch keinen dedizierten Order-Renderer; der Plan benennt deshalb für beide einen neuen repositorylokalen, dependencyfreien Bash-/PowerShell-Renderer samt Test- und Hilfeflächen. / InventarWorkerService and `absdd-image-sandbox` have manifest-bound views but no dedicated order renderer yet; the plan therefore names a repository-local, dependency-free Bash/PowerShell renderer with test and help surfaces for each.
- **Platforms / Plattformen**: macOS und Linux über Bash beziehungsweise die lokale JavaScript-Laufzeit; Windows über PowerShell 7 und die lokale JavaScript-Laufzeit. Auf dem aktuellen macOS-Host läuft die Bash-Safe-Mode-Prüfung zuerst.
- **Bash/PowerShell parity**: Beide Home-Baseline-Varianten sind im Scope; keine Variante ist `N/A`.
- **PowerShell Cmdlet/function**: Home Baseline und Agent Operations Cockpit behalten `Update-SdhOrderFile` mit genehmigtem Verb `Update`. Die geplanten PowerShell-Renderer für InventarWorkerService und `absdd-image-sandbox` stellen `Invoke-RequirementsIntakeGovernanceRender`, ihre Testoberflächen `Test-RequirementsIntakeGovernance` als Advanced Functions mit genehmigten Verben bereit. / The planned PowerShell renderer and test surfaces use approved `Invoke` and `Test` verbs as advanced functions.
- **Dry run / Vorschau**: Bestehender Bash-`--dry-run`- und PowerShell-`-WhatIf`-Pfad MUSS die erweiterte Ausgabe und Linkvalidierung mit null Writes abdecken.
- **Documentation / Dokumentation**: Bestehende Unix-Manpage `docs/man/prepare-secure-development-hardening.1.md` und vollständige bilinguale PowerShell Comment-based Help werden gemeinsam aktualisiert, soweit der gemeinsame Renderer über diese Oberfläche bedient wird.
- **Parity evidence / Paritätsnachweis**: Identische Fixtures erzeugen dieselben fünf Felder, Links, Kanten, Status-/Featurewerte, Fehlerklassen, Exitcodes und Nullschreibwerte. Native Evidence bindet Commit, Befehl, Plattform/Runner, Exitcode, Payload- und Entscheidungs-SHA-256.
- **N/A decisions**: Eine dritte plattformspezifische Scriptvariante zusätzlich zum geplanten Bash-/PowerShell-Paar ist `N/A`; Home/AOC erweitern ihr bestehendes Paar, TinyPl0/TinyCalc/TuiVision ihre vorhandenen JavaScript-Renderer, und InventarWorkerService/Sandbox erhalten das verbindliche neue Paar. Re-Evaluation: Eine Zielplattform kann durch diese Oberflächen nicht abgedeckt werden. / A third platform-specific script variant beyond the planned Bash/PowerShell pair is `N/A`; re-evaluate when a target platform cannot be covered.

## Agent-Parity-Anwendbarkeit / Agent Parity Applicability

- **Shared guidance change**: `N/A` als erwartete Mutation; das Feature ändert den fachlichen Renderer-/Ansichtsvertrag und keine neue gemeinsame Agentenregel. Re-Evaluation: Planung oder Implementierung benötigt eine neue Betriebs-, Security-, A11Y-, Statistik- oder Deliveryregel.
- **Mandatory review**: `Applicable`; jedes Zielrepository dokumentiert, ob seine Agent-Guidance wegen Bedienung, Pfad, Test oder Evidence aktualisiert werden muss.
- **Home-Baseline parity set**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md` werden gemeinsam geprüft; Änderungen einer gemeinsamen Regel erfolgen atomar.
- **Target parity sets**: Die jeweilige Registry-/lokale Constitution-Zeile ist bindend. Dazu gehören mindestens die vier gemeinsamen Flächen; TuiVision umfasst zusätzlich `.github/agents/copilot-instructions.md`, TinyPl0 die erlaubten `.codex`-Prompt-/Regelflächen und `absdd-image-sandbox` seine dokumentierten GitLab-/Container-/Hook-Flächen.
- **Project templates**: `N/A` als erwartete Mutation, weil kein neuer Shared-Guidance- oder Bootstrapvertrag entsteht. Re-Evaluation: eine neue gemeinsame Regel oder ein neues Projekt soll dieselbe Ansicht erhalten.
- **`.specify/memory/constitution.md`**: `N/A` als erwartete Mutation; die bestehende Verfassung enthält bereits die bindenden Regeln. Re-Evaluation: Registry-, MSL-, A11Y-, Statistik-, Preset- oder Agent-Parity-Baseline ändert sich.
- **Intentional deviation**: Keine beabsichtigt. Jede später notwendige Abweichung wird im selben Repository-Diff mit Begründung, Owner, Risiko und Re-Evaluation Trigger dokumentiert.
- **Model routing guidance**: `N/A` als Mutation; die bestehende agentenneutrale Rollenbindung bleibt unverändert. Re-Evaluation: Routingrolle oder gemeinsame Routing-Guidance ändert sich.
- **Evidence**: Agent-Parity-Entscheidung in jeder der sieben Repository-Abnahmezeilen. Owner: Repository Owner; Reviewer: Agent-Parity Reviewer.

## Documentation Impact und Statistik / Documentation Impact and Statistics

**Decision / Entscheidung**: `GeneratedUpdate`.

- **Source / Quelle**: jeweiliges Series-Manifest, vorhandene Feature-Verzeichnisse und kanonischer lokaler Renderer.
- **Owner**: jeweiliger Repository Owner; Fleet Owner für den gemeinsamen Fünf-Felder-Vertrag.
- **Affected audiences / Zielgruppen**: Maintainer, Repository-Verantwortliche, Reviewer, Lernende und spätere Spec-Kit-Nutzende.
- **Affected documents / Dokumentfamilien**: Root-Abarbeitungsreihenfolge, gegebenenfalls Series-Order-/Evidence-Ansichten, Renderer-Hilfe/Manpage, A11Y-/Security-/Architektur-/Betriebsevidence und Statistik-Ledger.
- **Reader paths / Leserpfade**: Repository-README beziehungsweise Root-Ansicht → verlinkte Intake-Datei → direkte Abhängigkeit/Series-Manifest → belegtes `specs/<feature>/`-Verzeichnis.
- **Navigation impact / Navigationsauswirkung**: Direkte relative Links ersetzen nicht verlinkte oder verkürzte Dateinamen; keine weitere Navigation außerhalb des Repositorys.
- **Document class / Dokumentklasse**: kanonische maschinenlesbare Manifestdaten, generierte operative Markdown-Ansicht und repositoryspezifische Evidence.
- **Language strategy / Sprachstrategie**: DE zuerst, EN danach auf CEFR B2, sofern lokaler Vertrag; große normative Dokumente dürfen eine synchronisierte `.EN.md`-Fassung nutzen.
- **Platform/example proof / Plattform-/Beispielnachweis**: macOS-first Safe Mode, danach native/eng gebundene Linux-/Windows-Parität; TuiVision-Zehn-Zeilen-Fixture als bindendes Beispiel.
- **Distribution class / Distributionsklasse**: Zielrepository-spezifisch `sourceOnly`, sofern der lokale Manifestvertrag keine `homeRuntime`-Datei berührt. Home-Sync ist für Specify `N/A` und verboten; bei späterer Änderung einer manifestgebundenen Home-Runtime-Datei muss der Bedarf vor einem ausdrücklich autorisierten Sync neu bewertet werden.
- **Statistics**: Jedes Repository dokumentiert genau eine Statistikentscheidung nach seinem lokalen Ledgervertrag. Ein abgeschlossenes Feature beziehungsweise eine abgeschlossene Implementierungsphase löst die dort vorgeschriebene Fortschreibung aus.
- **Evidence**: kanonischer Quelldiff, deterministischer Renderer-Nachweis, erzeugter Ausgabediff, Linkprüfung und Repository-Abnahmematrix.
- **Re-evaluation trigger / Wiedervorlage**: Renderer-/Manifestquelle, Leserpfad, Sprachpartner, Plattformumfang, Distributionsklasse, Home-Runtime-Bindung oder Statistikmethodik ändert sich.
