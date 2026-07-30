<!-- intake-authoring:begin -->
# Lastenheft: Dokumentations-Informationsarchitektur- und Lernpfad-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-29
**Reihenfolge:** Dokumentationsvorlauf D4, nach aktiver Position 4
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, Kaufleute für IT-System-Management,
Kaufleute für Digitalisierungsmanagement, Lehrende, Maintainer und Reviewer ab
dem ersten Ausbildungsjahr

## 1. Zweck / Purpose

Dieser Intake beschreibt einen vollständigen, read-only ausgeführten Audit der
Informationsarchitektur der Git-getrackten Level-0-Dokumentation. Eine
**Informationsarchitektur** ordnet Inhalte so, dass Menschen Informationen
finden, verstehen und sicher anwenden können. Der Audit prüft deshalb nicht nur,
ob eine Aussage wahr ist, sondern auch, ob sie am richtigen Ort, für die
richtige Zielgruppe, in einer verständlichen Tiefe und mit einer klaren
maßgeblichen Quelle steht.

Der Lauf erweitert die abgeschlossenen Dokumentationsvorläufe D1 bis D3. Er
öffnet deren Findings nicht erneut und ersetzt weder den dort eingeführten
Documentation-Impact-Vertrag noch die flottenweite Baseline.

*This intake defines a read-only audit of the information architecture of all
Git-tracked Level 0 documentation. It extends the completed D1-D3 truth,
ownership, and fleet baseline with discoverability, reader-path, language,
depth, and maintainability evidence.*

## 2. Verbindliche Vorgänger und Reihenfolge / Binding Predecessors and Order

Verbindliche Grundlagen sind:

- D1 und PR #126: vollständiger Dokumentations-Wirklichkeitsabgleich;
- D2 und PR #128: Source-of-Truth, Ownership und Documentation Impact;
- D3 und PR #131: flottenweite Baseline und Abschluss `DOC001` bis `DOC015`;
- Feature 015 und PRs #142/#143: Windows-, Vorschau-, Ergebnis- und
  Wiederanlauf-Härtung;
- Feature 016 und PRs #146/#148: Linux-/Ubuntu-, Eingabe-, Aggregations-,
  Plattform- und Exact-Head-Härtung;
- Feature 017 und PRs #153/#154: Remote-Freshness, sichere Pull-Klassifikation,
  Worktree-Leases und dynamische Preset-Profile;
- Feature 018 und PRs #160/#165: interaktive Wartungs-TUI, Headless- und
  Fallback-Grenzen, Live-Evidence sowie kausaler Abschluss;
- `docs/documentation-governance.md`;
- `constitution.md` und `.specify/memory/constitution.md`;
- die gemergten Feature-Artefakte und Abschluss-Evidence der Positionen 1 bis
  4.

D4 startet erst, wenn Windows-, Linux-/Ubuntu-, Default-Branch-/Worktree-
Härtung und Maintenance-TUI abgeschlossen sind. Die genannten PRs und ihre
gemergten Heads bilden die fachliche Baseline; aktuelle Dateihashes werden beim
Audit neu aus Git abgeleitet und nicht aus diesem Lastenheft geraten. Der Audit
verändert keine fachliche Dokumentation und startet D5 nicht automatisch.

## 3. Prüfumfang / Audit Scope

Der Audit inventarisiert alle repository-eigenen, Git-getrackten
Dokumentationsflächen von Level 0:

- Root-README, Constitution, Pflichtenheft und Abarbeitungsreihenfolge;
- alle nutzerseitigen Dateien unter `docs/`;
- Lernreihen, sichere Entwicklung, Checklisten und mitgeltende Dokumente;
- Manpages, PowerShell Comment-Based Help und CLI-Nutzungstexte;
- die Wartungs-TUI-Dokumentfamilie in Root-README, Manpage, Architektur-,
  A11Y-, Sicherheits- und Skriptreferenz-Dokumentation;
- Spec-Kit-Templates, Commands, Skills, Preset-Dokumentation und Receipts;
- Agenten-Guidance auf allen gepflegten Oberflächen;
- Specs, Pläne, Tasks, Checklists, Contracts und Evidence;
- die Feature-015-bis-018-Verträge für Plattform, Remote-Freshness, Worktree,
  Headless-/TUI-Auswahl, JSONL-Live-Evidence, kanonisches Ergebnis,
  Unterbrechung und Fallback;
- generierte Sammelbände, Referenzen und Statistikdokumente;
- aktive, historische und archivierte Intakes.

Nicht Git-getrackte Maschinenzustände, Secrets, Caches und private Agentenlogs
gehören nicht zum veröffentlichbaren Inventar.

## 4. Artefaktklassen / Artifact Classes

Jede Datei oder klar benannte Dokumentfamilie erhält genau eine Klasse:

- `ActiveSemantic`: aktuell handlungsleitend und semantisch zu prüfen;
- `Generated`: ausschließlich über eine kanonische Quelle zu aktualisieren;
- `Historical`: als historische Evidence unverändert zu bewahren;
- `Archived`: nicht aktiv, aber aus Provenienzgründen auffindbar zu halten;
- `ExternalReference`: fremde Quelle mit klarer Beweisgrenze;
- `AgentSurface`: abgeleitete Agenten- oder Command-Oberfläche;
- `IntakeEvidence`: Intake-, Receipt-, Review- oder Series-Nachweis.

Aktive Dokumente werden semantisch geprüft. Generierte Dokumente werden gegen
ihre Quellen validiert. Historische und archivierte Dokumente werden nur auf
Kennzeichnung, Provenienz, Links, Datenschutz und Auffindbarkeit geprüft.

## 5. Leserpfade und Tiefenmodell / Reader Paths and Depth Model

Der Audit prüft vier verbindliche Leserpfade:

1. **Lernende und Neueinsteiger:** Begriffe, Voraussetzungen, erster sicherer
   Ablauf und nachvollziehbare Lernschritte.
2. **Tägliche Nutzende:** wiederkehrende Bedienung, Statusprüfung, Wartung und
   sichere nächste Aktionen.
3. **Maintainer und KI-Agenten:** Quellen, Verträge, Änderungsgrenzen, Evidence
   und Delivery Authority.
4. **Prüfung und Fehleranalyse:** Governance, Reports, Exitcodes,
   Troubleshooting, Risiken und Re-Evaluation.

„Maximal ausführlich“ bedeutet vollständige fachliche Abdeckung durch
**gestufte Tiefe**: kompakte Einstiegspunkte verlinken auf ausführliche
Leitfäden und vollständige Referenzen. Es bedeutet nicht, jede Information in
eine einzelne möglichst lange Datei zu schreiben.

## 6. Sprach- und Teilungsmodell / Language and Splitting Model

Kurze Dokumente dürfen Deutsch-zuerst/Englisch-danach in einer Datei bleiben.
Eine getrennte deutsche und englische Fassung wird empfohlen, wenn mindestens
eines der folgenden Kriterien belegt ist:

- mehrere eigenständige Zielgruppen oder Aufgabenpfade;
- hohe Navigationslast oder schwer scanbare Überschriftenstruktur;
- umfangreiche normative oder betriebliche Inhalte;
- Inline-Zweisprachigkeit beeinträchtigt Lesbarkeit oder Wartbarkeit;
- häufige Sprachwechsel erschweren Screenreader- oder Textbrowser-Nutzung.

Es gilt keine starre Zeilengrenze. Sprachpartner müssen denselben
Informationsgehalt und gegenseitige Sprachlinks besitzen.

## 7. Bewertungsmodell / Decision Model

Jede geprüfte Einheit erhält genau eine Hauptentscheidung:

- `KeepAsIs`
- `Restructure`
- `SplitByTopic`
- `SplitByLanguage`
- `MergeDuplicate`
- `GeneratedFromSource`
- `ArchiveOnly`
- `FollowUp`

Jede Entscheidung dokumentiert Zielgruppe, Begründung, kanonische Quelle,
Owner, Zielpfad oder Beibehaltung, Risiko, Evidence und Re-Evaluation-Trigger.

## 8. Anforderungen / Requirements

- **DIA-001:** Der Audit erzeugt ein aus dem Git-Index abgeleitetes vollständiges
  Inventar ohne manuell gepflegte Bestandszahl als dauerhafte Wahrheit.
- **DIA-002:** Jede Datei oder benannte Dokumentfamilie erhält genau eine
  Artefaktklasse und eine Hauptentscheidung.
- **DIA-003:** Für jede aktive Einheit werden Zielgruppen, Leserpfade,
  vorausgesetztes Wissen und fachliche Tiefe erfasst.
- **DIA-004:** Die 3.000-plus-zeilige Root-README wird auf Rollenvermischung,
  Navigationslast, Duplikate und geeignete Auslagerungsziele geprüft.
- **DIA-005:** Für `README.md`, ein mögliches `README.en.md` und ein
  Dokumentationsportal entsteht eine verbindliche Zielarchitektur.
- **DIA-006:** Doppelte normative Aussagen werden einer kanonischen Quelle und
  klar benannten Ableitungen zugeordnet.
- **DIA-007:** Sprachtrennung wird ausschließlich nach den festgelegten
  fachlichen Kriterien empfohlen.
- **DIA-008:** Jeder vorgeschlagene Sprachpartner erhält eine
  Synchronisations- und Linkregel.
- **DIA-009:** Code- und Befehlsbeispiele werden auf Kontext, Plattform,
  Voraussetzungen, Sicherheitsgrenzen und sichere Prüfbarkeit bewertet.
- **DIA-010:** Nutzerseitige Inhalte werden auf Deutsch zuerst, Englisch
  danach, CEFR B2 und Erklärung von Fachbegriffen beim ersten Auftreten geprüft.
- **DIA-011:** Anwendbare WCAG-2.2-AA-Kriterien und textorientierte
  Alternativen werden je Dokumentfamilie erfasst.
- **DIA-012:** Generierte Dokumente werden ihrer kanonischen Quelle und ihrem
  Renderer zugeordnet; generierte Ausgaben werden nicht manuell korrigiert.
- **DIA-013:** Historische Evidence wird nicht modernisierend umgeschrieben.
- **DIA-014:** Die vier bestehenden Documentation-Impact-Entscheidungen
  `UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate` und `FollowUp`
  bleiben unverändert.
- **DIA-015:** Der Audit prüft, welche zusätzlichen Pflichtfelder der
  Documentation-Impact-Nachweis für Leserpfad, Navigation, Sprache,
  Source-of-Truth und Beispielvalidierung benötigt.
- **DIA-016:** Der Audit prüft semantisch und dokumentiert ausdrücklich die
  Grenze deterministischer Validatoren.
- **DIA-017:** Ein neues oder geändertes Preset wird nur als Follow-up
  empfohlen, wenn ein reproduzierbarer projektunabhängiger Defekt vorliegt.
- **DIA-018:** Der Lauf verändert keine fachliche Dokumentation, Runtime,
  Wartungsskripte, Presets oder Flotten-Repositories.
- **DIA-019:** Der Audit bindet die gemergten Feature- und Closeout-Nachweise
  015 bis 018 und trennt damalige Implementierungs-Evidence von der aktuellen,
  aus Git abgeleiteten Dokumentationswirklichkeit.
- **DIA-020:** Für die Wartungsoberfläche wird eine Konsistenzmatrix über
  Root-README, Manpage, Architektur, A11Y, Sicherheit, Skriptreferenz und
  Feature-Verträge erstellt.
- **DIA-021:** Die Matrix prüft Enhanced-, Plain- und Headless-Auswahl,
  No-Args-/TTY-Verhalten, sichere Vorschau, vorausgewähltes `DryRun`,
  Default-No-Bestätigung und unveränderte explizite Headless-Parameter.
- **DIA-022:** Die Matrix prüft den additiven JSONL-Live-Kanal,
  `EVENT_STREAM_DEGRADED`, Fallback nur vor Engine-Start, genau einmaliges
  `Ctrl+C` sowie Bericht und Prozess-Exitcode als kanonische Abschlusswahrheit.
- **DIA-023:** Remote-Freshness, sichere Pull-Klassifikation, begrenzte
  Netzwerk-Evidence, Worktree-Leases, Bereinigungsgrenzen und dynamische
  Preset-Profile werden auf widerspruchsfreie Dokumentation ohne dauerhaft
  fest codierte Flotten- oder Preset-Anzahl geprüft.

## 9. Ergebnisartefakte / Result Artifacts

- vollständiges Dokumentationsinventar;
- Source-of-Truth-, Owner-, Leserpfad- und Sprachmatrix;
- README- und Dokumentationsportal-Zielarchitektur;
- Alt-nach-Neu-Pfadmatrix mit Link- und Redirect-Grenzen;
- Liste validierter und nicht validierbarer Beispiele;
- Findings mit stabilen `DIA###`-IDs;
- Konsistenzmatrix der Feature-015-bis-018-Dokumentationsverträge;
- Wartungsoberflächen-Matrix für TUI, Plain, Headless, Live-Evidence,
  Abschlusswahrheit, Unterbrechung und Fallback;
- D5-, D6- oder D7-Handoff je bestätigtem Finding;
- textorientierter Abschlussbericht.

## 10. Akzeptanzkriterien / Acceptance Criteria

- **AC-DIA-001:** Jede Git-getrackte Dokumentationsfläche ist inventarisiert
  oder mit reproduzierbarer Ausschlussbegründung erfasst.
- **AC-DIA-002:** Jede geprüfte Einheit besitzt genau eine Klasse und
  Hauptentscheidung.
- **AC-DIA-003:** Alle vier Leserpfade sind vollständig bewertet.
- **AC-DIA-004:** Die Root-README besitzt eine nachvollziehbare Ziel- und
  Migrationsmatrix ohne vorschnelle Dateiverschiebung.
- **AC-DIA-005:** Sprachtrennungen sind kriterienbasiert und nennen Partner,
  Synchronisation und Navigation.
- **AC-DIA-006:** Aktive, generierte, historische und archivierte Inhalte
  wurden nach ihrer jeweiligen Prüfgrenze behandelt.
- **AC-DIA-007:** Jede positive Behauptung verweist auf konkrete Evidence.
- **AC-DIA-008:** Es verbleibt keine Critical-/High-Ambiguität für D5.
- **AC-DIA-009:** D1-D3-Evidence wurde nicht verändert oder neu interpretiert.
- **AC-DIA-010:** Keine fachliche Dokumentation oder Runtime wurde geändert.
- **AC-DIA-011:** Preset-Follow-ups sind entweder reproduzierbar belegt oder
  ausdrücklich `NoPromotion`.
- **AC-DIA-012:** D5 wurde nicht automatisch gestartet.
- **AC-DIA-013:** Die gemergten Feature- und Closeout-Nachweise 015 bis 018
  sind vollständig zugeordnet, ohne historische Evidence umzuschreiben.
- **AC-DIA-014:** README, Manpage, Architektur-, A11Y-, Sicherheits-,
  Skriptreferenz- und Feature-Verträge besitzen für dieselbe
  Wartungsoberfläche keine unaufgelösten Critical-/High-Widersprüche.
- **AC-DIA-015:** Auswahlmodus, sichere Vorschau, Bestätigung,
  Live-Evidence, kanonisches Ergebnis, Unterbrechung und Fallback besitzen
  jeweils eine konkrete Dokumentationsentscheidung und Proof-Grenze.
- **AC-DIA-016:** Remote-Freshness, Pull-Klassen, Netzwerkversuche,
  Worktree-Leases und Bereinigungsgrenzen sind über alle aktiven
  Dokumentationsflächen konsistent bewertet.
- **AC-DIA-017:** Flotten- und Preset-Zahlen sind als zeitgebundene Evidence
  oder dynamisch abgeleitete Werte gekennzeichnet und werden nicht als
  dauerhafte technische Obergrenze verwendet.

## 11. Nicht-Ziele / Non-Goals

- Keine Umstrukturierung oder Sprachmigration innerhalb des Audits.
- Keine funktionale Skript-, Runtime-, Workflow- oder Preset-Änderung.
- Keine flottenweite Dokumentationsänderung.
- Keine pauschale Zeilenobergrenze.
- Keine redaktionelle Modernisierung historischer Evidence.

<!-- intake-authoring:prompts -->
## 12. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` as documentation preflight D4. Verify the completed D1-D3 baseline and merged Feature 015-018 evidence, read-only Level-0 scope, complete Git-derived inventory, exact artifact classes and decision vocabulary, four reader paths, criteria-based language splitting, progressive disclosure, generated and historical boundaries, maintenance TUI/plain/headless and canonical-result documentation consistency, Remote-Freshness and Worktree documentation, measurable acceptance, learner accessibility, and the prohibition on documentation or runtime remediation. Do not modify the intake or start D4.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` as the binding intake for documentation preflight D4. Create a feature specification for a complete read-only Level-0 documentation information-architecture and learner-path audit after Features 015 through 018 and their causal closeouts. Preserve DIA-001 through DIA-023, AC-DIA-001 through AC-DIA-017, the exact artifact classes and decisions, four reader paths, progressive disclosure, criteria-based language splitting, D1-D3 evidence boundaries, the Feature-015-to-018 documentation consistency matrices, and no-remediation scope. Do not implement documentation changes, alter runtime behavior, create a preset, or start D5.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` with deliveryAuthority=MergeAndSync after Features 015 through 018 and their causal closeouts are complete. Keep all existing documentation, runtime, scripts, presets, and fleet repositories read-only except for accepted feature artifacts, deterministic audit-only tooling, audit evidence, statistics, archive/order updates, and delivery evidence. Audit the complete Git-derived Level-0 documentation inventory and explicitly reconcile Remote-Freshness, safe pull and Worktree contracts plus TUI/plain/headless selection, safe preview, JSONL advisory evidence, canonical report/exit, interruption and fallback documentation across README, manpage, architecture, A11Y, security, script reference and Feature contracts. Converge all required and useful optional checks and reviews, merge one non-empty Level-0 PR, return to clean synchronized main, and do not start D5 automatically.
```

<!-- intake-authoring:end -->
