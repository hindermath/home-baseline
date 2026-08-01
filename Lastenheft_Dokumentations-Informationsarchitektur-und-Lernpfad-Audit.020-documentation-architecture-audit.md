<!-- intake-authoring:begin -->
# Lastenheft: Dokumentations-Informationsarchitektur- und Lernpfad-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-01
**Reihenfolge:** Dokumentationsvorlauf D4, nach abgeschlossener Position 4 und Feature 019 (R-TUI)
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
- Feature 019 und PR #192: exakter geprüfter Head
  `4d002f7cd5c58dc1d2bc3367e7a7ddb51653298d`, gemergt als
  `901266ff8bd76edc0b40ebb98409d24a4c99e19e`; kontinuierlicher
  JSONL-Ereignisstrom, vorgebundener kanonischer Berichtspfad,
  wahrheitsgemäße Ergebnisabstimmung, robuste frühe Finalisierung bei
  fehlendem oder ungültigem Report sowie Bash-3.2-sichere argumentlose
  Home-Runtime-Delegation;
- `docs/documentation-governance.md`;
- `constitution.md` und `.specify/memory/constitution.md`;
- die gemergten Feature-Artefakte und Abschluss-Evidence der Positionen 1 bis
  4.

D4 startet erst, wenn Windows-, Linux-/Ubuntu-, Default-Branch-/Worktree-
Härtung, Maintenance-TUI und R-TUI abgeschlossen und gemergt sind. Diese
Voraussetzung ist durch PR #192 und Merge-Commit `901266f` erfüllt. Die
genannten PRs und ihre gemergten Heads bilden die fachliche Baseline; aktuelle
Dateihashes werden beim Audit neu aus Git abgeleitet und nicht aus diesem
Lastenheft geraten. Der Audit verändert keine fachliche Dokumentation und
startet D5 nicht automatisch.

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
- die Feature-015-bis-018- sowie R-TUI-Verträge für Plattform,
  Remote-Freshness, Worktree, Headless-/TUI-Auswahl, JSONL-Live-Evidence,
  kanonisches Ergebnis, Unterbrechung und Fallback;
- den Workspace-Grenzvertrag zwischen der versionierten Level-0-Quelle
  `~/home-baseline-source`, der manifestgesteuerten Home-Baseline Runtime unter
  `~/` und ausschließlich maschinenlokalem Zustand;
- `scripts/config/home-sync-manifest.json`, `sync-home.*`, die zugehörige
  Manpage, Source-Resolver, Zustandsnachweise und alle aktiven Anleitungen, die
  Arbeits-, Lese-, Sync- oder Veröffentlichungsorte benennen;
- generierte Sammelbände, Referenzen und Statistikdokumente;
- aktive, historische und archivierte Intakes.

Nicht Git-getrackte Maschinenzustände, Secrets, Caches und private Agentenlogs
gehören nicht zum veröffentlichbaren Inventar.

### 3.1 Verbindliche Source-/Home-Runtime-Grenze / Binding Source/Home Runtime Boundary

Der Audit behandelt die Workspace-Grenze als eigene Informationsarchitektur:

- `~/home-baseline-source` ist der dauerhafte, versionierte Level-0-Checkout
  mit Remote-Autorität für Entwicklung, Commit, PR und Veröffentlichung.
- **Home-Baseline Runtime**, kurz **Home Runtime**, bezeichnet ausschließlich
  die durch das aktuelle Manifest ausgewählten Betriebsdateien unter `~/`.
  Das gesamte persönliche Home-Verzeichnis wird dadurch weder zur Runtime noch
  zu einer zweiten Level-0-Quelle.
- `homeRuntime` umfasst manifestgesteuert verteilte Skripte, gemeinsame
  Agenten-Guidance und ausgewählte Spec-Kit-Oberflächen.
- `sourceOnly` umfasst unter anderem Dokumentation, Specs, Lastenhefte,
  Preset-Quellen und Evidence, die direkt aus dem Source-Checkout gelesen
  werden.
- `machineLocal` umfasst lokalen Zustand wie Registry, Logs, Audit-State,
  `STATS.md` und vergleichbare maschinengebundene Nachweise; diese werden nicht
  allein durch ihre Lage unter `~/` zu veröffentlichbaren Quellen.

Der Audit leitet die konkrete Pfadmenge aus Manifest, Resolver und Git ab,
nicht aus einer dauerhaft festgeschriebenen Dateiliste. Er prüft den
gerichteten Sync von Source nach Home Runtime, den Änderungsort, den
Home-Sync-Trigger, Konflikt- und Force-Grenzen, lokale Home-Commits ohne
Remote-Autorität sowie die Host-/Container-Grenze. Die Dokumentation muss
außerdem die Vorteile erklären: nachvollziehbare Versions- und
Veröffentlichungshistorie in der Quelle, stabile betriebliche Einstiegspunkte,
kleinere Verteilungs- und Fehlerfläche, Schutz maschinenlokaler Daten und
prüfbare manifestgesteuerte Aktualisierung.

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
  015 bis 018 sowie R-TUI und trennt damalige Implementierungs-Evidence von der
  aktuellen, aus Git abgeleiteten Dokumentationswirklichkeit.
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
- **DIA-024:** Der Audit erstellt eine eigene Source-/Home-Runtime-Matrix über
  `homeRuntime`, `sourceOnly` und `machineLocal`, deren konkrete Pfade aus den
  aktuellen Quellen abgeleitet werden.
- **DIA-025:** Alle aktiven Leserpfade werden darauf geprüft, ob
  `~/home-baseline-source` als einzige versionierte Level-0-Quelle und die
  Home-Baseline Runtime als abgeleitete Betriebskopie verständlich getrennt
  sind.
- **DIA-026:** Der Audit erfasst Inhalt, Zweck, Vorteile und Nicht-Ziele der
  Home Runtime einschließlich der Aussage, dass nicht das gesamte `~/`
  Bestandteil der Runtime ist.
- **DIA-027:** Für `sourceOnly`-, `homeRuntime`- und `machineLocal`-Änderungen
  werden Arbeitsort, Sync-Bedarf, Commit-/Remote-Autorität und sichere nächste
  Aktion dokumentiert.
- **DIA-028:** Direkte Änderungen in der Home Runtime werden nicht als
  kanonische Source-Änderung oder als veröffentlichbarer Ersatz für einen
  Source-PR dargestellt.
- **DIA-029:** Lokale Home-Commits werden als Audit- und
  Wiederherstellungsnachweis ohne Remote-Autorität von Level-0-Commits
  unterschieden.
- **DIA-030:** Host-Sync, Source-Resolver und die schreibgeschützte
  Container-Referenz werden als getrennte Betriebsgrenzen geprüft.
- **DIA-031:** Widersprüche bei Arbeitsverzeichnis, Lesequelle, Sync-Trigger,
  Force-Verwendung oder Veröffentlichungsort erhalten stabile Findings und
  einen eindeutigen D5- oder D6-Handoff.

## 9. Ergebnisartefakte / Result Artifacts

- vollständiges Dokumentationsinventar;
- Source-of-Truth-, Owner-, Leserpfad- und Sprachmatrix;
- README- und Dokumentationsportal-Zielarchitektur;
- Alt-nach-Neu-Pfadmatrix mit Link- und Redirect-Grenzen;
- Liste validierter und nicht validierbarer Beispiele;
- Findings mit stabilen `DIA###`-IDs;
- Konsistenzmatrix der Feature-015-bis-018- und R-TUI-Dokumentationsverträge;
- Wartungsoberflächen-Matrix für TUI, Plain, Headless, Live-Evidence,
  Abschlusswahrheit, Unterbrechung und Fallback;
- Source-/Home-Runtime-Matrix mit Artefaktklasse, Owner, Änderungsort,
  Sync-Trigger, Remote-Autorität, Nutzen und Proof-Grenze;
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
  sowie R-TUI sind vollständig zugeordnet, ohne historische Evidence
  umzuschreiben.
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
- **AC-DIA-018:** Die drei Artefaktklassen `homeRuntime`, `sourceOnly` und
  `machineLocal` sind aus aktuellen Quellen vollständig und widerspruchsfrei
  zugeordnet.
- **AC-DIA-019:** Alle vier Leserpfade können Quelle, Home Runtime,
  maschinenlokalen Zustand und deren jeweilige Autorität unterscheiden.
- **AC-DIA-020:** Inhalt und Vorteile der Home Runtime sind belegt, ohne `~/`
  pauschal als Runtime oder Remote-Checkout zu bezeichnen.
- **AC-DIA-021:** Für jede Artefaktklasse sind Änderungsort, Sync-Bedarf,
  Commit-/Push-Grenze und sichere nächste Aktion entschieden.
- **AC-DIA-022:** Source-Resolver, Host-Sync und Container-Referenz besitzen
  keine unaufgelöste Critical-/High-Ambiguität.

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
$speckit-intake-review Review `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` as documentation preflight D4 after Feature 019 merged through PR #192. Verify the completed D1-D3 baseline, merged Feature 015-018 evidence, and the merged Feature-019 evidence for JSONL continuity, pre-bound report ownership, robust early finalization, truthful result reconciliation, and Bash-3.2-safe argumentless Home-Runtime delegation; then verify read-only Level-0 scope, complete Git-derived inventory, exact artifact classes and decision vocabulary, four reader paths, criteria-based language splitting, progressive disclosure, generated and historical boundaries, the source/home-runtime contract with `homeRuntime`, `sourceOnly`, and `machineLocal`, maintenance TUI/plain/headless and canonical-result documentation consistency, Remote-Freshness and Worktree documentation, measurable acceptance, learner accessibility, and the prohibition on documentation or runtime remediation. Do not modify the intake or start D4.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` as the binding intake for documentation preflight D4. Create a feature specification for a complete read-only Level-0 documentation information-architecture and learner-path audit after Features 015 through 019 and their causal closeouts are merged. Preserve DIA-001 through DIA-031, AC-DIA-001 through AC-DIA-022, the exact artifact classes and decisions, four reader paths, progressive disclosure, criteria-based language splitting, the source/home-runtime matrix and authority boundaries, D1-D3 evidence boundaries, the Feature-015-to-019 documentation consistency matrices, and no-remediation scope. Do not implement documentation changes, alter runtime behavior, create a preset, or start D5.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` with deliveryAuthority=MergeAndSync after Features 015 through 019 and their causal closeouts are merged. Keep all existing documentation, runtime, scripts, presets, and fleet repositories read-only except for accepted feature artifacts, deterministic audit-only tooling, audit evidence, statistics, archive/order updates, and delivery evidence. Audit the complete Git-derived Level-0 documentation inventory; produce the source/home-runtime matrix for `homeRuntime`, `sourceOnly`, and `machineLocal`; and explicitly reconcile Remote-Freshness, safe pull and Worktree contracts plus TUI/plain/headless selection, safe preview, JSONL advisory evidence, canonical report/exit, interruption and fallback documentation across README, manpage, architecture, A11Y, security, script reference and Feature contracts. Bind the merged Feature-019 proof for continuous JSONL, pre-bound report ownership, robust early finalization, truthful result reconciliation, and Bash-3.2-safe argumentless delegation. Converge all required and useful optional checks and reviews, merge one non-empty Level-0 PR, return to clean synchronized main, and do not start D5 automatically.
```

<!-- intake-authoring:end -->
