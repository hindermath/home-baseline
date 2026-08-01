<!-- intake-authoring:begin -->
# Lastenheft: Level-0-Dokumentationsarchitektur und Sprachtrennung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-30
**Reihenfolge:** Dokumentationsvorlauf D5, nach abgeschlossenem D4
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Lernende und Nutzende ohne Spec-Kit-Vorkenntnisse, Lehrende,
Maintainer, KI-Agenten und Reviewer

## 1. Zweck / Purpose

D5 setzt ausschließlich bestätigte Findings aus D4 im Level-0-Repository um.
Der Lauf schafft eine verständliche, wartbare und barrierearme
Dokumentationsarchitektur. **Progressive Disclosure** bedeutet dabei: Eine
kurze Einstiegsebene zeigt die nächste sinnvolle Aktion; ausführliche
Erklärungen und vollständige Referenzen bleiben über klare Links erreichbar.

*D5 implements only accepted D4 findings in Level 0. It creates a layered,
maintainable documentation architecture with synchronized language paths,
clear sources of truth, and accessible navigation.*

## 2. Voraussetzungen und Grenzen / Preconditions and Boundaries

- D1 bis D3 sind abgeschlossen und bleiben unverändert.
- D4 besitzt ein gemergtes `Ready`-Ergebnis ohne offene Critical-/High-Findings.
- Die D4-Ziel- und Pfadmatrix ist verbindliche Migrationsgrundlage.
- D5 verändert keine Runtime, öffentliche API, Abhängigkeit oder
  Wartungslogik.
- Generierte Dokumente werden nur über ihre Quellen aktualisiert.
- Historische oder archivierte Evidence wird nicht redaktionell umgeschrieben.

## 3. Zielarchitektur / Target Architecture

### 3.1 Einstieg

- `README.md` wird der kompakte deutsche Einstieg.
- `README.en.md` wird die inhaltlich gleichwertige englische Fassung.
- Beide nennen Zweck, Zielgruppen, Voraussetzungen, Schnellstart,
  Sicherheitsgrenzen, Leserpfade und weiterführende Dokumentation.
- `docs/README.md` und `docs/README.en.md` werden die zentralen
  Dokumentationsportale.

### 3.2 Aufgabenorientierte Bereiche

Die D4-Matrix ordnet ausführliche Inhalte mindestens diesen Rollen zu:

- Einstieg und Lernen;
- täglicher Betrieb und Wartung;
- Governance und sichere Entwicklung;
- technische Referenz;
- Fehleranalyse und Audit.

Bestehende fachlich sinnvolle Verzeichnisse bleiben erhalten. D5 erzeugt keine
zweite konkurrierende Taxonomie, sondern ordnet sie über das Portal ein.

### 3.3 Vier Leserpfade

Jeder Leserpfad besitzt einen sichtbaren Einstieg, vorausgesetztes Wissen,
empfohlene Reihenfolge und nächste Aktion:

1. Lernende und Neueinsteiger;
2. tägliche Nutzende;
3. Maintainer und KI-Agenten;
4. Prüfung und Fehleranalyse.

### 3.4 Source- und Home-Runtime-Orientierung

Die D4-Matrix liefert einen sichtbaren, sprachgleichen Orientierungspfad für:

- `~/home-baseline-source` als dauerhaften versionierten Level-0-Checkout und
  einzigen Ort für kanonische Änderungen, Commits, PRs und Pushes;
- die **Home-Baseline Runtime** beziehungsweise **Home Runtime** als
  manifestgesteuerte Auswahl betrieblicher Dateien unter `~/`, nicht als
  Bezeichnung für das gesamte Home-Verzeichnis;
- `homeRuntime`, `sourceOnly` und `machineLocal` mit Zweck, typischen
  Artefakten, Owner, Änderungsort, Sync-Trigger und Remote-Grenze;
- den gerichteten Source-zu-Runtime-Sync, sichere Vorschau, Konfliktverhalten,
  lokale Home-Commits und die Host-/Container-Grenze;
- die belegten Vorteile der Trennung: saubere Versions- und
  Veröffentlichungshistorie, stabile betriebliche Einstiegspunkte, begrenzte
  Verteilungsfläche, Schutz maschinenlokaler Daten und reproduzierbare
  Aktualisierung.

Konkrete Runtime-Pfade werden aus dem Manifest dargestellt oder verlinkt und
nicht als manuell gepflegte, dauerhaft vollständige Liste dupliziert.

## 4. Dauerhafter Dokumentationsarchitektur-Vertrag

Die bestehende Documentation-Impact-Entscheidung bleibt genau eine von:
`UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate` oder `FollowUp`.
Zusätzlich dokumentiert jede relevante Änderung:

- betroffene Zielgruppen und Leserpfade;
- kanonische Quelle und Owner;
- Navigations- und Einstiegspunkt-Auswirkung;
- Dokumentklasse und Generatorgrenze;
- Sprachstrategie und Sprachpartner;
- Beispiel- und Plattformvalidierung;
- Distributionsklasse (`homeRuntime`, `sourceOnly` oder `machineLocal`) und
  daraus folgender Home-Sync-Bedarf;
- Evidence und Re-Evaluation-Trigger.

Diese Regel wird in Constitution, `.specify/memory/constitution.md`,
`docs/documentation-governance.md`, Spec-/Plan-/Tasks-/Checklist-/PR-Flächen
und allen gepflegten Agentenoberflächen synchron verankert.

## 5. Sprachvertrag / Language Contract

- Deutsch bleibt die primäre Sprache.
- Kurze Dokumente dürfen Deutsch zuerst und Englisch danach enthalten.
- Kriterienbasiert große Dokumente erhalten eine synchron gepflegte englische
  Paralleldatei.
- Sprachpartner verlinken gegenseitig mit beschreibendem Linktext.
- Eine fachliche Änderung aktualisiert beide Sprachpfade oder bleibt
  nachweislich unvollständig.
- Dateinamen verwenden die im Repository etablierte `.en.md`-Konvention;
  bestehende normative `.EN.md`-Namen werden nicht ohne Migrationsgrund
  umbenannt.
- Automatische Übersetzung ersetzt keinen semantischen Review.

## 6. Anforderungen / Requirements

- **DAS-001:** D5 implementiert nur D4-Findings mit Ziel `Level0`.
- **DAS-002:** `README.md` und `README.en.md` werden gleichwertige,
  kompakte Einstiegspunkte mit gegenseitigen Sprachlinks.
- **DAS-003:** Beide Dokumentationsportale inventarisieren die
  aufgabenorientierten Bereiche und vier Leserpfade.
- **DAS-004:** Aus der Root-README ausgelagerte Inhalte bleiben vollständig
  erhalten oder werden als begründet überholt dokumentiert.
- **DAS-005:** Jeder verschobene Abschnitt erhält einen validierten Zielpfad
  und eine Linkmigrationsentscheidung.
- **DAS-006:** Doppelte normative Inhalte werden auf eine kanonische Quelle
  reduziert; Ableitungen verlinken dorthin.
- **DAS-007:** Die vier Documentation-Impact-Entscheidungen bleiben exakt
  erhalten und werden um die neuen Nachweisfelder ergänzt.
- **DAS-008:** Die Regeln für Progressive Disclosure, Leserpfade,
  Dokumentklassen und Sprachpartner werden normativ verankert.
- **DAS-009:** Gemeinsame Agenten-Guidance wird auf allen gepflegten
  Oberflächen in derselben Änderung aktualisiert.
- **DAS-010:** Spec-, Plan-, Tasks-, Checklist- und PR-Templates verlangen die
  neue Dokumentationsarchitektur-Prüfung.
- **DAS-011:** Generierte Dokumente werden ausschließlich über ihre
  kanonische Quelle und den dokumentierten Renderer verändert.
- **DAS-012:** Dokumentinventare werden aus Git oder strukturierten Quellen
  abgeleitet; manuelle Bestandszahlen sind nicht dauerhaft maßgeblich.
- **DAS-013:** Historische Evidence bleibt bytegleich oder erhält nur eine
  außerhalb der Evidence liegende Navigations- oder Provenienznotiz.
- **DAS-014:** Jede neue oder geänderte Befehlsanleitung nennt Plattform,
  Voraussetzungen, Nebenwirkungen und sicheren Prüfmodus.
- **DAS-015:** Nutzerseitige Texte erfüllen Deutsch zuerst, Englisch danach,
  CEFR B2 und Begriffserklärung beim ersten Auftreten.
- **DAS-016:** Navigation, Überschriften, Tabellen, Links und textorientierte
  Alternativen werden gegen anwendbare WCAG-2.2-AA-Kriterien geprüft.
- **DAS-017:** Semantischer Review und deterministische Validierung werden als
  getrennte Nachweise dokumentiert.
- **DAS-018:** Nicht sofort lösbare Dokumentationsschuld verwendet `FollowUp`
  mit Owner, Risiko, Frist, Wiedervorlage, Evidence und Scope-Grund.
- **DAS-019:** Ein Preset-Follow-up entsteht nur bei einem reproduzierbaren,
  projektunabhängigen Defekt.
- **DAS-020:** D5 startet weder D6 noch eine Flottenänderung automatisch.
- **DAS-021:** D5 implementiert die akzeptierten D4-Findings zur
  Source-/Home-Runtime-Grenze in Einstieg, Dokumentationsportal und
  Maintainer-/Agentenpfad.
- **DAS-022:** Die Begriffe Level-0-Quelle, Home-Baseline Runtime,
  `homeRuntime`, `sourceOnly` und `machineLocal` werden deutsch und englisch
  eindeutig und ohne Gleichsetzung des gesamten `~/` verwendet.
- **DAS-023:** Inhalt, Zweck, Vorteile, Nicht-Ziele und Autoritätsgrenzen der
  Home Runtime werden in gestufter Tiefe erklärt.
- **DAS-024:** Jede relevante Dokumentationsfläche kann ihren
  Home-Sync-Bedarf aus der Distributionsklasse ableiten; konkrete Dateimengen
  verweisen auf das aktuelle Manifest.
- **DAS-025:** Source-only-Änderungen lösen keinen unnötigen Home-Sync aus;
  Home-Runtime-Änderungen werden erst kanonisch in der Quelle geliefert und
  danach geprüft synchronisiert.
- **DAS-026:** Maschinenlokaler Zustand, lokale Home-Commits und direkte
  Runtime-Änderungen erhalten keine implizite Remote- oder
  Veröffentlichungsautorität.
- **DAS-027:** Host-Sync, Source-Resolver und Container-Referenz werden ohne
  neue absolute Pfadkopplung oder funktionale Skriptänderung dokumentiert.

## 7. Nicht-Ziele / Non-Goals

- Keine funktionale Änderung von Skripten oder Runtime.
- Keine pauschale Aufteilung jeder zweisprachigen Datei.
- Keine starre maximale Dateilänge.
- Keine Bearbeitung von Level-1-/Level-2-Repositories.
- Keine Umdeutung abgeschlossener D1-D4-Evidence.

## 8. Akzeptanzkriterien / Acceptance Criteria

- **AC-DAS-001:** Alle umgesetzten Änderungen sind auf D4-Findings
  zurückführbar.
- **AC-DAS-002:** Deutsche und englische Einstiegspunkte besitzen denselben
  Informationsumfang und funktionierende Sprachlinks.
- **AC-DAS-003:** Alle vier Leserpfade sind aus dem Root-Einstieg in höchstens
  zwei nachvollziehbaren Navigationsschritten erreichbar.
- **AC-DAS-004:** Kein ausgelagerter aktiver Inhalt ist verloren oder ohne
  dokumentierte Entscheidung verwaist.
- **AC-DAS-005:** Interne Links und relevante historische Deep Links sind
  validiert oder besitzen einen dokumentierten Ersatz.
- **AC-DAS-006:** Constitution, Dokumentations-Governance, Templates und
  Agentenflächen enthalten denselben normativen Kern.
- **AC-DAS-007:** Generierte Inhalte stimmen mit ihren Quellen überein.
- **AC-DAS-008:** Sprach-, A11Y- und semantische Reviews besitzen Evidence.
- **AC-DAS-009:** Die finale Änderung enthält keine Runtime-, API-,
  Abhängigkeits- oder Wartungsverhaltensänderung.
- **AC-DAS-010:** D6 und D7 wurden nicht automatisch gestartet.
- **AC-DAS-011:** Quelle, Home Runtime und maschinenlokaler Zustand sind aus
  beiden Spracheinstiegen in höchstens zwei Navigationsschritten erreichbar.
- **AC-DAS-012:** Ein Lernender kann erklären, welche Artefakte aus der Quelle
  gelesen, nach `~/` synchronisiert oder ausschließlich lokal gehalten werden.
- **AC-DAS-013:** Ein Maintainer kann für eine Änderung den kanonischen
  Arbeitsort, Home-Sync-Bedarf und erlaubten Veröffentlichungsweg bestimmen.
- **AC-DAS-014:** Keine aktive Dokumentation bezeichnet das gesamte `~/` als
  Home Runtime oder die Runtime als zweite Level-0-Quelle.
- **AC-DAS-015:** Die Source-/Runtime-Dokumentation stimmt mit Manifest,
  `sync-home.*`, Manpage, Resolver und Container-Grenze überein.

<!-- intake-authoring:prompts -->
## 9. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md` as documentation preflight D5. Verify its hard dependency on the merged D4 findings, compact German and English entry pages, documentation portals, four reader paths, progressive disclosure, criteria-based language splitting, exact Documentation Impact vocabulary, the source/home-runtime orientation and distribution classes, normative placement, generated and historical boundaries, link migration, semantic review, no-runtime scope, and measurable acceptance. Do not modify the intake or start D5.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md` and the accepted merged D4 findings as binding input for documentation preflight D5. Create the feature specification for Level-0 documentation restructuring, synchronized German and English entry paths, four reader paths, the source/home-runtime orientation, and the durable documentation-architecture contract. Preserve DAS-001 through DAS-027, AC-DAS-001 through AC-DAS-015, the exact four Documentation Impact decisions, criteria-based splitting, distribution classes, generated and historical boundaries, link migration, semantic validation, and no-runtime/no-fleet scope. Do not start D6 or D7.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md` with deliveryAuthority=MergeAndSync after D4 is merged and Ready. Implement only accepted Level-0 D4 findings, establish the bilingual source/home-runtime orientation and distribution-class contract, preserve runtime and maintenance behavior, synchronize all normative and agent surfaces, validate both language paths and migrated links, converge required and useful optional checks and reviews, merge one non-empty Level-0 PR, return to clean synchronized main, and do not start D6 or D7 automatically.
```

<!-- intake-authoring:end -->
