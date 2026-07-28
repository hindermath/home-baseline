<!-- intake-authoring:begin -->
# Lastenheft: Lernreihen-Gesamtkonsistenz-Closure

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 33, nach Position 32
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Lernende aller integrierten IT-Berufe, Lehrende, Ausbildende,
Maintainer und Reviewer
**Vorausgesetztes Wissen:** abgeschlossene FI-, KDM-/KITSM- und ITSE-Reihen;
keine Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser unabhängige read-only Abschluss prüft die Lernreihen **in sich**, **an
sich** und **insgesamt zueinander**. Er umfasst alle Fachinformatiker-
Fachrichtungen, ITSE, KITSM und KDM sowie die drei Secure-Trader-Familien.

*This independent read-only closure validates internal, normative, and
cross-series consistency across all integrated IT occupations and Secure
Trader learning families.*

## 2. Drei Konsistenzebenen / Three Consistency Levels

**In sich konsistent** bedeutet: Reihenwurzel, Aufgabe, Lernbegleiter,
Unterrichtsleitfaden, Mapping, Evidence, Bewertung und Prompt widersprechen
sich innerhalb einer Reihe nicht.

**An sich konsistent** bedeutet: Die Reihe entspricht den amtlichen
Ausbildungsgrundlagen und der Level-0-Governance für Sicherheit, Lernende,
Sprache und Barrierefreiheit.

**Insgesamt konsistent** bedeutet: Gemeinsame Kompetenzen, berufsspezifische
Vertiefungen, Lehrjahresübergänge und Produktfamilien passen ohne Lücke,
ungeklärte Duplikation oder widersprüchliche Aussage zusammen.

## 3. Prüfbestand / Audit Inventory

- FI/AE, FI/SI, FI/DPA und FI/DV;
- IT-System-Elektroniker*innen;
- Kaufleute für IT-System-Management;
- Kaufleute für Digitalisierungsmanagement;
- Secure OrderDesk, Secure ServiceHarvester und Secure CaseTracker;
- Level-0-Quellen sowie die freigegebenen Level-1-/C#-Level-2-Rollouts.

## 4. Entscheidungsmodell / Decision Model

Jeder geprüfte Bereich erhält genau eine Entscheidung:

- `Consistent`
- `IntentionalDifference`
- `Finding`
- `ProductDecision`

`IntentionalDifference` benötigt Begründung, Grundlage, Owner und
Re-Evaluation-Trigger. `Finding` erhält eine stabile `LSC###`-ID,
Schweregrad, betroffene Reihen, Evidence, Owner und Follow-up-Grenze.
`ProductDecision` blockiert die Gesamtabnahme.

Gesamtergebnisse sind:

- `Consistent`
- `NeedsRemediation`
- `Blocked`

Ein autonomer Agent akzeptiert kein Restrisiko stellvertretend für Menschen.

## 5. Anforderungen / Requirements

- **LGC-001:** Jede Lernreihe wird intern auf konsistente Ziele,
  Voraussetzungen, Aufgaben, Lernbegleiter, Evidence und Abnahme geprüft.
- **LGC-002:** Aufgaben und zugehörige Lernbegleiter müssen dieselben
  Kompetenz-, Sicherheits- und Agentengrenzen verwenden.
- **LGC-003:** Jede Reihe wird gegen Ausbildungsordnung, Rahmenlehrplan,
  Blueprint, Register, Constitution und Secure-Development-Baseline geprüft.
- **LGC-004:** Der Berufsvergleich umfasst alle vier FI-Fachrichtungen, ITSE,
  KITSM und KDM.
- **LGC-005:** Gemeinsame Kompetenzen besitzen genau eine kanonische Quelle.
- **LGC-006:** Berufsspezifische Unterschiede sind beabsichtigt, begründet und
  nachweisbar.
- **LGC-007:** LF-, Lehrjahres- und Reihenübergänge sind vollständig,
  widerspruchsfrei und ohne Kreisbezug.
- **LGC-008:** Keine Berufsgruppe wird durch fehlende Aufgabe, Evidence oder
  Bewertung nur nominell integriert.
- **LGC-009:** OrderDesk, ServiceHarvester und CaseTracker besitzen
  verständliche, voneinander abgegrenzte Lernrollen.
- **LGC-010:** C#-Referenzaufgaben, Container-first, Agentenautorität und
  Eigenleistungsgrenzen sind serienübergreifend konsistent.
- **LGC-011:** Elektrische Praxis-, Simulations- und Evidence-Grenzen werden
  in allen ITSE-relevanten Reihen gleich verwendet.
- **LGC-012:** Deutsch zuerst, Englisch danach, CEFR B2, Ersterklärung,
  textorientierte Abhängigkeiten und WCAG 2.2 AA werden geprüft.
- **LGC-013:** Level-0-, Level-1- und C#-Level-2-Artefakte besitzen
  nachvollziehbare Quell-/Zielparität oder eine begründete lokale Abweichung.
- **LGC-014:** Links, IDs, Dateinamen, Status, Reihenfolge und nächste Aktionen
  sind vollständig und eindeutig.
- **LGC-015:** Jeder Bereich erhält genau eine Entscheidung aus dem
  festgelegten Modell.
- **LGC-016:** `Consistent` ist nur bei null offenen Findings,
  Produktentscheidungen und ungeklärten Abweichungen zulässig.
- **LGC-017:** Der Lauf ist read-only und behebt keine Findings.
- **LGC-018:** Folge-Intakes entstehen nur aus belegten, deduplizierten
  Findings und werden nicht automatisch gestartet.

## 6. Ergebnisartefakte / Expected Artifacts

- vollständiges Lernreihen- und Berufs-Inventar;
- interne Konsistenzmatrix je Reihe;
- normative Konsistenzmatrix je Beruf;
- berufs- und serienübergreifende Kompetenzmatrix;
- Produktfamilien- und Rollout-Paritätsmatrix;
- Entscheidungs-, Finding- und Follow-up-Ledger;
- textorientierter Gesamtabschlussbericht.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-LGC-001:** Jede aktive Lernreihe und jedes zugehörige Dokumentpaket ist
  genau einmal inventarisiert.
- **AC-LGC-002:** Alle sieben Berufsprofile besitzen vollständige
  Kompetenz-, Aufgaben-, Evidence- und Bewertungsnachweise.
- **AC-LGC-003:** Es gibt keine ungeklärte kanonische Duplikation oder
  widersprüchliche Definition.
- **AC-LGC-004:** Alle Lehrjahres- und Reihenübergänge sind maschinenprüfbar.
- **AC-LGC-005:** Level-0-/1-/2-Parität oder absichtliche Abweichung ist
  vollständig belegt.
- **AC-LGC-006:** Null offene Critical-/High-Findings und null
  Produktentscheidungen.
- **AC-LGC-007:** Der Lauf enthält keine Remediation und startet keinen
  Folge-Intake.

## 8. Nicht-Ziele / Non-Goals

- Keine Korrektur entdeckter Findings.
- Keine Harmonisierung fachlich notwendiger Berufs-Unterschiede.
- Keine Prüfungsgarantie oder Ersetzung der dualen Ausbildung.
- Kein automatischer Folge-, Rollout- oder Produktlauf.

<!-- intake-authoring:prompts -->
## 9. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Lernreihen-Gesamtkonsistenz-Closure.md` as position 33. Verify the three consistency levels, complete seven-occupation and three-product-family inventory, internal task/companion consistency, official-source alignment, canonical competency reuse, justified differences, year transitions, rollout parity, exact decision model, read-only boundary, accessibility, and no automatic follow-up.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Lernreihen-Gesamtkonsistenz-Closure.md` as the binding intake for position 33. Create a read-only audit specification for internal, normative, cross-occupation, cross-series, product-family, and rollout consistency across FI/AE, FI/SI, FI/DPA, FI/DV, ITSE, KITSM, and KDM. Preserve LGC-001 through LGC-018 and AC-LGC-001 through AC-LGC-007. Do not remediate findings, harmonize intentional differences, change product code, or start any follow-up.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete read-only Spec Kit run for `Lastenheft_Lernreihen-Gesamtkonsistenz-Closure.md` with deliveryAuthority=MergeAndSync after position 32 is complete. Produce only consistency evidence, deterministic validators, statistics, archive/order updates, and one non-empty PR. Return to clean synchronized main, do not remediate findings, and do not start any follow-up intake.
```

<!-- intake-authoring:end -->
