<!-- intake-authoring:begin -->
# Lastenheft: KDM Professional Jahr 3

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 23, nach Position 22  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** Kaufleute für Digitalisierungsmanagement, Lehrende, Ausbildende,
Maintainer und Reviewer ab dem dritten Ausbildungsjahr  
**Vorausgesetztes Wissen:** abgeschlossener kaufmännischer Jahr-2-Kern; keine
vorherige Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake erstellt die berufsspezifische Jahr-3-Lernreihe für KDM. Sie
verbindet Geschäftsprozesse, Datenqualität, C#-/SQL-Integration,
Wirtschaftlichkeit, digitale Geschäftsmodelle und verantwortliche Veränderung.

*This intake creates the occupation-specific year-3 KDM learning series.*

## 2. Verbindliche acht Einheiten / Eight Required Units

1. Geschäfts- und Wertschöpfungsprozesse
2. Datenbedarf und Datenmodell
3. Datenqualität, Datenschutz und Bereinigung
4. C#-/SQL-Datenintegration
5. Kennzahlen und Wirtschaftlichkeitsbewertung
6. Digitale Geschäftsmodelle
7. Prozessveränderung und organisatorische Einführung
8. Abschlussbewertung und Handlungsempfehlung

Die drei Secure-Trader-Systeme liefern unterschiedliche, aber verbundene
Bestell-, Service-, Betriebs- und Falldaten.

## 3. Pflicht-Dokumentpaket / Required Document Package

Die Reihe erhält Übersicht, acht Aufgaben-Lastenhefte, acht Lernbegleiter,
Unterrichtsleitfaden, Kompetenz-/Lernfeld-/Prüfungsbereich-Mapping,
Bewertungsraster, Evidence-Inventar, C#-/SQL-Praxisgrenze und Abschlussnachweis.

## 4. Anforderungen / Requirements

- **KDM-001:** Alle KDM-Lernfelder des dritten Ausbildungsjahres werden
  vollständig abgedeckt.
- **KDM-002:** Prozesse werden mit Ausgangszustand, Beteiligten, Daten,
  Engpässen, Risiken und Zielzustand textorientiert beschrieben.
- **KDM-003:** Datenbedarf und Datenmodell trennen fachliche Notwendigkeit,
  Verfügbarkeit, Qualität, Zweckbindung und Aufbewahrung.
- **KDM-004:** Datenqualitätsaufgaben enthalten reproduzierbare Regeln,
  Testdaten, Fehlerklassen und Aussagegrenzen.
- **KDM-005:** Die C#-/SQL-Integration verwendet parametrisierte Zugriffe,
  Eingabevalidierung, Positiv-/Negativtests und verständliche Fehlerbehandlung.
- **KDM-006:** Kennzahlen nennen Definition, Einheit, Datenbasis, Zeitraum,
  Ausschlüsse und Interpretationsgrenze.
- **KDM-007:** Wirtschaftlichkeitsbewertungen dokumentieren Annahmen,
  Alternativen, Kosten, Nutzen, Risiken und Sensitivität.
- **KDM-008:** Digitale Geschäftsmodelle werden auf Wertbeitrag, Datenschutz,
  Sicherheit, Barrierefreiheit und realistische Betriebsfähigkeit geprüft.
- **KDM-009:** Prozessveränderungen berücksichtigen Rollen, Kommunikation,
  Schulung, Akzeptanz, Kontrolle und Re-Evaluation.
- **KDM-010:** Jede Handlungsempfehlung trennt Evidenz, Schlussfolgerung,
  Unsicherheit und offene Entscheidung.
- **KDM-011:** Eigenleistung und Agentenunterstützung werden je Einheit
  getrennt nachgewiesen.
- **KDM-012:** Alle nutzerseitigen Inhalte erfüllen Deutsch zuerst, Englisch
  danach, CEFR B2 und WCAG 2.2 AA.
- **KDM-013:** Die Reihe verändert weder Produktcode noch Zielrepositorys.
- **KDM-014:** Position 24 wird nicht automatisch gestartet.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-KDM-001:** Genau acht Aufgaben und acht passende Lernbegleiter bestehen.
- **AC-KDM-002:** Unterrichtsleitfaden, Mappings, Raster und Evidence sind
  vollständig.
- **AC-KDM-003:** Alle KDM-Lernfelder und Prüfungsbereiche sind ohne
  Prüfungsgarantie zugeordnet.
- **AC-KDM-004:** Daten-, Kennzahlen- und Wirtschaftlichkeitsaussagen sind
  reproduzierbar und begrenzt.
- **AC-KDM-005:** C#-/SQL-Praxis und Tests sind verständlich nachweisbar.
- **AC-KDM-006:** Link-, Sprach-, Accessibility- und Strukturprüfungen bestehen.
- **AC-KDM-007:** Kein Produktcode und kein Zielrepository wurde geändert.
- **AC-KDM-008:** Position 24 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine KITSM-Jahr-3-Inhalte.
- Keine Produktivdaten oder reale personenbezogene Daten.
- Keine Prüfungssimulation oder Prüfungsgarantie.
- Kein C#-Rollout in diesem Lauf.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-Professional-Jahr3.md` as position 23. Verify exactly eight units, complete KDM year-3 learning-field and competency coverage, process/data/economic integration, safe C#/SQL work, reproducible metrics and recommendations, the full document package, learner-versus-agent evidence, accessibility, and no rollout or product implementation.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-Professional-Jahr3.md` as the binding intake for position 23. Create a feature specification for the complete eight-unit KDM year-3 learning series and its overview, unit intakes, companions, teaching guide, mappings, assessment, evidence, C#/SQL proof, and accessibility. Preserve KDM-001 through KDM-014 and AC-KDM-001 through AC-KDM-008. Do not modify target repositories, implement learner solutions, or start position 24.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-Professional-Jahr3.md` with deliveryAuthority=MergeAndSync after position 22 is complete. Create only the accepted Level-0 KDM learning document package, deterministic validation, evidence, statistics, archive/order updates, and delivery evidence. Keep product code and all Level-1/Level-2 repositories unchanged. Merge one non-empty PR, return to clean synchronized main, and do not start position 24.
```

<!-- intake-authoring:end -->
