# Artefaktvertrag: RL-SE-Checklisten-Selbstprüfung

**Vertragsversion**: 1.0.0
**Geltungsbereich**: Menschlich lesbare Markdown-Evidenz und zugehöriger Documentation-Impact-Nachweis; keine API und keine neue Laufzeitschnittstelle.

## 1. Veröffentlichte Artefakte

Die spätere Implementierung veröffentlicht genau diese primären Ergebnisflächen:

1. `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md`
2. `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md`
3. einen direkten Reader-Path in `docs/security/README.md`
4. `specs/025-rl-se-self-assessment/documentation-impact-evidence.json`
5. die durch `docs/project-statistics.config.json` gesteuerte Statistikaktualisierung oder einen transparenten, autoritätsgebundenen Statistik-Follow-up-Nachweis.

Die Artefakte sind `sourceOnly`; `homeSyncRequired` ist `false`.

## 2. Sprach- und A11Y-Vertrag

- Jedes nutzerseitige Markdown-Artefakt enthält zuerst einen vollständigen deutschen und danach einen vollständigen englischen Teil.
- IDs, Statuswerte, Zahlen, Owner, Risiken, Trigger, Fristen und Evidence-Verweise stimmen zwischen beiden Teilen überein.
- Überschriften bilden eine logische Hierarchie; Tabellen besitzen eindeutige Spaltenüberschriften.
- Kein Ergebnis hängt ausschließlich von Farbe, Symbol, räumlicher Position oder visueller Gruppierung ab.
- Abkürzungen und Fachbegriffe werden bei erster Verwendung auf CEFR-B2-Niveau erklärt.
- Die lineare Textreihenfolge bleibt für Screenreader, Braille-Zeilen und Textbrowser vollständig nutzbar.

## 3. Matrixvertrag

### 3.1 Pflichtabschnitte

Die Matrix enthält in jeder Sprachhälfte mindestens:

1. Zweck, Scope und Proof-Grenze
2. Repository- und Baseline-Bindung
3. Quelleninventar
4. Zusatz-ID-Register
5. Legende und Statusvorrang
6. Assessment-Matrix
7. Dokument- und Preset-Abdeckungsnachweis
8. externe Evidenzausfälle
9. Review- und Re-Evaluation-Hinweise

### 3.2 Identitäts- und Mengenvertrag

- Die kanonische Quellmenge wird direkt aus den zwölf Checklisten gebildet.
- Ihre Kardinalität ist exakt 157; jede ID entspricht `^CL-[0-9]{2}-[0-9]{2}$`.
- Die Matrix enthält jede Quell-ID genau einmal, keine unbekannte `CL-*`-ID und kein Duplikat.
- Zusatz-IDs entsprechen `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$`, sind eindeutig und disjunkt zur Quellmenge.
- Jede Zusatz-ID besitzt einen Registereintrag mit Titel, Primärquelle und Bedarfsbegründung in DE und EN.
- Matrixgesamtzahl ist exakt `157 + deklarierte Zusatz-ID-Anzahl`.
- Alle 15 mitgeltenden Dokumente und alle elf Presets sind querverwiesen. Abdeckung allein berechtigt nicht zu `AlreadySatisfied`.

### 3.3 Pflichtfelder je Matrixzeile

| Feld | Vertrag |
|---|---|
| ID | Stabile `CL-*`-ID oder deklarierte `HB-RLSE-*`-ID. |
| Titel | Vollständiger Titel in der jeweiligen Sprachhälfte. |
| Primärquelle | Repository-relativer Pfad plus Abschnitt/Anker. |
| Querverweise | Weitere Baseline-, Dokument-, Preset- oder Evidence-Quellen; `None`/`Keine`, wenn leer. |
| Workflowstatus | Genau einer von `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, `FollowUp`. |
| Anwendbarkeit | `Applicable`, `N/A` oder `Open`, soweit vom Quellprofil verlangt. |
| Umsetzungsstatus | `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`, soweit verlangt. |
| Begründung | Prüfpunktspezifische Entscheidung, kein Textbaustein ohne Kontext. |
| Evidence | Evidence-ID oder ausdrücklich `None`/`Keine`; positive Status brauchen aktuelle Evidence. |
| Owner | Verantwortliche Rolle. |
| Reviewer | Fachliche Review-Rolle. |
| Priorität | `High`, `Medium` oder `Low`. |
| Risiko und Restrisiko | Jeweils Stufe plus Begründung. |
| Nächste Aktion | Für `Open` und `FollowUp` konkret und zwingend. |
| Frist/Review | Für `FollowUp` Datum oder `NotScheduled` plus Trigger. |
| Re-Evaluation | Konkreter Zustands- oder Ereignistrigger. |

Eine breite Tabelle darf in logisch verbundene, identitätsgleiche Detailblöcke aufgeteilt werden, wenn dies die lineare A11Y-Nutzung verbessert. Es muss trotzdem eindeutig genau eine Entscheidung je ID geben.

### 3.4 Statusvertrag

Die Entscheidung wird in dieser Reihenfolge getroffen:

1. `N/A`: fachlich nicht anwendbar; `Applicability=N/A`, `ImplementationStatus=Not Assessed`, Begründung und Trigger vorhanden.
2. `AlreadySatisfied`: anwendbar und vollständig durch aktuelle, aussagegleiche Evidence belegt; `Applicability=Applicable`, `ImplementationStatus=Fulfilled`.
3. `FollowUp`: notwendige Arbeit bewusst außerhalb des Scopes; Owner, Risiko, Frist/Trigger, Evidence-Ziel und Scope-Grund vorhanden.
4. `Open`: Widerspruch, Unsicherheit, nicht verfügbare Quelle oder unzureichende Evidence; Owner, Risiko, nächste Aktion und Trigger vorhanden.
5. `Applicable`: anwendbar mit dokumentiertem Behandlungspfad und ohne offene Entscheidungsunsicherheit; darf nicht als Synonym für erfüllt verwendet werden.

Ein `AlreadySatisfied` ohne vollständige Evidenzfrische ist ein Vertragsfehler.

### 3.5 Evidence-Vertrag

- Repository-Evidence nennt Pfad, konkrete Aussage, Commit/Arbeitsbaum-Bindung und Prüfzeitpunkt.
- Befehlsevidence nennt exakten Befehl, Zeitpunkt, Ergebnis und Zustandsbindung.
- Veränderliche externe Evidence nennt Quelle, Abrufdatum, Ergebnis und Proof-Grenze.
- Repository-Pfade sind relativ, enthalten kein `..` und geben keine privaten Home-Pfade preis.
- Secrets, Tokens, agentische private Zustände, Rohlogs, History- oder SQLite-Dateien dürfen weder aufgenommen noch zitiert werden.
- Feature-024-Evidence stützt nur die von ihr tatsächlich bewiesene Mapping-Integrität.
- Nicht verfügbare externe Evidence führt für den betroffenen Prüfpunkt zu `Open`, nicht zum Abbruch der Matrix.

## 4. Summary-Vertrag

Die Zusammenfassung enthält:

- Baseline- und Repository-Bindung;
- exakte Zeilenzahl und Verteilung über alle fünf Workflowstatus;
- Nachweis `12/12` Checklisten, `157/157` stabile IDs, `15/15` Dokumente und `11/11` Presets;
- alle High-Risk-Findings und ihre Owner;
- alle Open-Evidenzlücken sowie Follow-ups mit Risiko, Frist/Trigger und Scope-Grund;
- erläuterte Standards-/Regulierungsentscheidungen ohne Rechts- oder Zertifizierungsbehauptung;
- A11Y- und Sprachreview-Ergebnis;
- Documentation Impact `UpdateRequired`, Distribution `sourceOnly`, `homeSyncRequired=false`;
- Statistikstatus mit Evidence; erwarteter `DRIFT` wird nicht als technischer Fehler oder `CURRENT` dargestellt;
- Status des kausalen Series-Closeouts und die klare Aussage, dass kein Nachfolgeintake gestartet wurde;
- den nächsten sicheren, innerhalb der aktuellen Autorität möglichen Schritt.

Die Summary darf keine Matrixentscheidung überschreiben. Bei Abweichung ist die Matrix maßgeblich und die Summary zu korrigieren.

## 5. Navigation- und Documentation-Impact-Vertrag

- `docs/security/README.md` verlinkt direkt auf Matrix und Summary oder auf einen eindeutig beschrifteten Einstieg im datierten Verzeichnis.
- Die Level-0-Einordnung darf nicht als Level 1 bezeichnet werden.
- Der Evidence-Nachweis verwendet `.specify/templates/documentation-impact-evidence-template.json` als Schemaquelle.
- Die einzige Entscheidung ist `UpdateRequired`.
- Der Nachweis nennt Zielgruppen, Leserpfade, kanonische Quellen und Owner, Navigation, Dokumentklasse, Sprachpartner, Plattform-/Beispielnachweis, Distribution, Home-Sync-Bedarf, Evidence und Re-Evaluation.
- Bash- und PowerShell-Validator für Documentation Impact müssen beide bestehen.

## 6. Statistik- und Closeout-Vertrag

- Statistikquelle ist `docs/project-statistics.config.json`; das Ledger wird nicht manuell im generierten Block editiert.
- Der Renderer-Schreibmodus wird nicht an seiner Clean-Tree-Barriere vorbeigeführt.
- Die aktuelle `MergeAndSync`-Autorität erlaubt die Commit-Bindung. Statistik wird erst nach dem Source-Commit und bei sauberem Arbeitsbaum gerendert.
- Der Series-Closeout beginnt erst nach vollständiger, validierter Ergebnislieferung und wird aus dem dann aktuellen Manifest neu berechnet.
- Archive, Nachfolger-Manifest/-Receipt, Operationsjournal, Supersession-Hashes und Order-Dokument sind erst in einem autorisierten Closeout zu ändern.
- Kein Nachfolger wird durch dieses Feature gestartet. Commit, Push, PR und Merge verwenden die aktuelle `MergeAndSync`-Autorität; Remediation-Intakes und Folgeläufe benötigen eigene aktuelle Autorität.

## 7. Vertragsabnahme

Der Vertrag gilt als erfüllt, wenn alle folgenden Beweise vorliegen:

- Baseline- und Mapping-Validatoren bestehen auf beiden verfügbaren Shellpfaden beziehungsweise dem vorhandenen Python-Mapping-Test;
- 157/157-Mengenidentität, Zusatzregister, Statuswerte, Pflichtfelder, Pfade, 15/15- und 11/11-Abdeckung sind deterministisch geprüft;
- DE/EN-Parität und A11Y wurden semantisch geprüft;
- Documentation-Impact-Validatoren bestehen;
- die durch den tatsächlichen Diff ausgelösten Repository-Gates bestehen;
- Statistikstatus und Series-Closeout sind wahrheitsgemäß und autoritätskonform dokumentiert.

---

# Artifact Contract: RL-SE Checklist Self-Assessment

**Contract version**: 1.0.0
**Scope**: Human-readable Markdown evidence and its Documentation Impact record; no API or new runtime interface.

## 1. Published Artifacts

Later implementation publishes exactly these primary result surfaces:

1. `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md`
2. `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md`
3. a direct reader path in `docs/security/README.md`
4. `specs/025-rl-se-self-assessment/documentation-impact-evidence.json`
5. the statistics update controlled by `docs/project-statistics.config.json`, or a transparent, authority-bound statistics follow-up record.

The artifacts are `sourceOnly`; `homeSyncRequired` is `false`.

## 2. Language and Accessibility Contract

- Every user-facing Markdown artifact contains a complete German part followed by a complete English part.
- IDs, statuses, counts, owners, risks, triggers, due dates, and evidence references match across both parts.
- Headings form a logical hierarchy; tables have unambiguous column headers.
- No result depends exclusively on color, a symbol, spatial position, or visual grouping.
- Abbreviations and terms are explained on first use at CEFR B2 level.
- Linear text order remains fully usable with screen readers, Braille displays, and text browsers.

## 3. Matrix Contract

### 3.1 Required Sections

Each language half contains at least:

1. purpose, scope, and proof boundary
2. repository and baseline binding
3. source inventory
4. additional-ID register
5. legend and status precedence
6. assessment matrix
7. document and preset coverage proof
8. external evidence failures
9. review and re-evaluation notes

### 3.2 Identity and Cardinality Contract

- The canonical source set is built directly from the twelve checklist files.
- Its cardinality is exactly 157; every identifier matches `^CL-[0-9]{2}-[0-9]{2}$`.
- The matrix contains every source identifier exactly once, no unknown `CL-*` identifier, and no duplicate.
- Additional identifiers match `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$`, are unique, and are disjoint from the source set.
- Every additional identifier has a register entry with title, primary source, and need rationale in DE and EN.
- Total matrix rows equal `157 + declared additional-ID count`.
- All 15 related documents and all eleven presets are cross-referenced. Coverage alone does not authorize `AlreadySatisfied`.

### 3.3 Required Fields per Matrix Row

| Field | Contract |
|---|---|
| ID | Stable `CL-*` ID or declared `HB-RLSE-*` ID. |
| Title | Complete title in the respective language half. |
| Primary source | Repository-relative path plus section/anchor. |
| Cross-references | Other baseline, document, preset, or evidence sources; `None` when empty. |
| Workflow status | Exactly one of `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, `FollowUp`. |
| Applicability | `Applicable`, `N/A`, or `Open` when required by the source profile. |
| Implementation status | `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, or `Not Assessed` when required. |
| Rationale | Checkpoint-specific decision, not an uncontextualized boilerplate. |
| Evidence | Evidence ID or explicit `None`; positive statuses require current evidence. |
| Owner | Responsible role. |
| Reviewer | Professional review role. |
| Priority | `High`, `Medium`, or `Low`. |
| Risk and residual risk | Each includes a level and rationale. |
| Next action | Concrete and required for `Open` and `FollowUp`. |
| Due/review | For `FollowUp`, a date or `NotScheduled` plus trigger. |
| Re-evaluation | Concrete state or event trigger. |

A wide table may be split into logically linked, identity-preserving detail blocks when this improves linear accessibility. There must still be exactly one unambiguous decision per ID.

### 3.4 Status Contract

Decisions follow this order:

1. `N/A`: professionally non-applicable; `Applicability=N/A`, `ImplementationStatus=Not Assessed`, with rationale and trigger.
2. `AlreadySatisfied`: applicable and fully supported by current, semantically matching evidence; `Applicability=Applicable`, `ImplementationStatus=Fulfilled`.
3. `FollowUp`: required work is intentionally outside scope; owner, risk, due date/trigger, evidence goal, and scope rationale exist.
4. `Open`: contradiction, uncertainty, unavailable source, or insufficient evidence; owner, risk, next action, and trigger exist.
5. `Applicable`: applies with a documented treatment path and no unresolved decision uncertainty; it is not a synonym for fulfilled.

`AlreadySatisfied` without complete evidence freshness is a contract error.

### 3.5 Evidence Contract

- Repository evidence records path, concrete claim, commit/working-tree binding, and observation time.
- Command evidence records exact command, timestamp, result, and state binding.
- Mutable external evidence records source, retrieval date, result, and proof boundary.
- Repository paths are relative, contain no `..`, and expose no private Home paths.
- Secrets, tokens, private agent state, raw logs, history, and SQLite files must neither be included nor cited.
- Feature 024 evidence supports only the mapping integrity it actually proves.
- Unavailable external evidence makes the affected checkpoint `Open`; it does not abort the matrix.

## 4. Summary Contract

The summary contains:

- baseline and repository binding;
- exact row count and distribution across all five workflow statuses;
- proof of `12/12` checklists, `157/157` stable IDs, `15/15` documents, and `11/11` presets;
- all High-risk findings and their owners;
- all Open evidence gaps and FollowUps with risk, due date/trigger, and scope rationale;
- explained standards/regulatory decisions without legal or certification claims;
- accessibility and language review result;
- Documentation Impact `UpdateRequired`, distribution `sourceOnly`, `homeSyncRequired=false`;
- statistics state with evidence; expected `DRIFT` is not represented as a technical failure or as `CURRENT`;
- causal series-closeout state and an explicit statement that no successor intake was started;
- the next safe step available under current authority.

The summary must not override a matrix decision. If they differ, the matrix governs and the summary must be corrected.

## 5. Navigation and Documentation Impact Contract

- `docs/security/README.md` links directly to the matrix and summary or to a clearly labeled entry in the dated directory.
- The Level 0 repository must not be described as Level 1.
- The evidence record uses `.specify/templates/documentation-impact-evidence-template.json` as its schema source.
- The only decision is `UpdateRequired`.
- The record covers audiences, reader paths, canonical sources and owner, navigation, document class, language partner, platform/example proof, distribution, Home-sync need, evidence, and re-evaluation.
- Both Bash and PowerShell Documentation Impact validators pass.

## 6. Statistics and Closeout Contract

- The statistics source is `docs/project-statistics.config.json`; the generated ledger block is not edited manually.
- Renderer write mode is not forced past its clean-tree barrier.
- Current `MergeAndSync` authority permits commit binding. Statistics are rendered only after the source commit and with a clean worktree.
- Series closeout begins only after complete, validated result delivery and is recalculated from the then-current manifest.
- Archives, successor manifest/receipt, operations journal, supersession hashes, and order document are changed only in an authorized closeout.
- This feature starts no successor. Commit, push, pull request, and merge use current `MergeAndSync` authority; remediation intakes and later runs require separate current authority.

## 7. Contract Acceptance

The contract is fulfilled when all of the following evidence exists:

- baseline and mapping validators pass across the available shell paths and existing Python mapping test;
- 157/157 set identity, additional register, status values, required fields, paths, 15/15 and 11/11 coverage are checked deterministically;
- German/English parity and accessibility receive semantic review;
- Documentation Impact validators pass;
- repository gates triggered by the actual diff pass;
- statistics and series-closeout states are truthful and authority-compliant.
