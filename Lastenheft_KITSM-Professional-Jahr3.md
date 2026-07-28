<!-- intake-authoring:begin -->
# Lastenheft: KITSM Professional Jahr 3

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 22, nach Position 21  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** Kaufleute für IT-System-Management, Lehrende, Ausbildende,
Maintainer und Reviewer ab dem dritten Ausbildungsjahr  
**Vorausgesetztes Wissen:** abgeschlossener kaufmännischer Jahr-2-Kern; keine
vorherige Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake erstellt die berufsspezifische Jahr-3-Lernreihe für KITSM. Sie
verbindet Kundenbedarf, technische IT-Lösung, Angebot, Vertrag, Vertrieb,
Service und Wirtschaftlichkeit.

*This intake creates the occupation-specific year-3 KITSM learning series.*

## 2. Verbindliche acht Einheiten / Eight Required Units

1. Kundenauftrag und Anforderungsanalyse
2. IT-Lösungskonzept und Leistungsgrenzen
3. Kosten- und Leistungsrechnung
4. Beschaffung, Lizenzen und Lieferanten
5. Angebot, Vertrag und Forderungsgrenzen
6. Marketing und Vertrieb
7. Netzwerkinfrastruktur und Kalkulation
8. Einführung, Service, Abnahme und Abschluss

Secure OrderDesk unterstützt Angebots-, Vertrags- und Vertriebsfälle. Secure
ServiceHarvester und Secure CaseTracker unterstützen Service-, Betriebs-,
Support- und Übergabeszenarien.

## 3. Pflicht-Dokumentpaket / Required Document Package

Die Reihe erhält Übersicht, acht Aufgaben-Lastenhefte, acht Lernbegleiter,
Unterrichtsleitfaden, Kompetenz-/Lernfeld-/Prüfungsbereich-Mapping,
Bewertungsraster, Evidence-Inventar, C#-/SQL-Praxisgrenze und Abschlussnachweis.

## 4. Anforderungen / Requirements

- **KIS-001:** Alle KITSM-Lernfelder des dritten Ausbildungsjahres werden
  vollständig abgedeckt.
- **KIS-002:** Jede Einheit verbindet Kundenperspektive, technische
  Machbarkeit, Sicherheit und wirtschaftliche Bewertung.
- **KIS-003:** Anforderungen und Lösungskonzept nennen Scope, Nicht-Ziele,
  Risiken, Abhängigkeiten und überprüfbare Abnahme.
- **KIS-004:** Kosten- und Leistungsrechnung verwendet nachvollziehbare Daten,
  Einheiten, Annahmen und Aussagegrenzen.
- **KIS-005:** Beschaffung und Lizenzen prüfen Lieferfähigkeit, Sicherheit,
  Datenschutz, Supply Chain und Total Cost of Ownership.
- **KIS-006:** Angebot und Vertrag trennen verbindliche Leistung,
  Voraussetzung, Ausschluss, Haftungsgrenze und Abnahme.
- **KIS-007:** Marketing und Vertrieb bleiben wahrheitsgetreu, barrierefrei und
  frei von unbelegten Sicherheits- oder Leistungsversprechen.
- **KIS-008:** Netzwerkplanung enthält textorientierte Topologie, Kapazität,
  Schutzbedarf, Verfügbarkeit und Kosten.
- **KIS-009:** Einführung und Service enthalten Schulung, Support, SLA,
  Eskalation, Accessibility und Abschlussnachweis.
- **KIS-010:** C#-/SQL-Artefakte aus Jahr 1 und 2 werden fachlich bewertet und
  nur bei begründetem Lernziel erweitert.
- **KIS-011:** Eigenleistung und Agentenunterstützung werden je Einheit
  getrennt nachgewiesen.
- **KIS-012:** Alle nutzerseitigen Inhalte erfüllen Deutsch zuerst, Englisch
  danach, CEFR B2 und WCAG 2.2 AA.
- **KIS-013:** Die Reihe verändert weder Produktcode noch Zielrepositorys.
- **KIS-014:** Position 23 wird nicht automatisch gestartet.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-KIS-001:** Genau acht Aufgaben und acht passende Lernbegleiter bestehen.
- **AC-KIS-002:** Unterrichtsleitfaden, Mappings, Raster und Evidence sind
  vollständig.
- **AC-KIS-003:** Alle KITSM-Lernfelder und Prüfungsbereiche sind ohne
  Prüfungsgarantie zugeordnet.
- **AC-KIS-004:** Jede wirtschaftliche Aussage besitzt Quelle, Einheit,
  Annahme und Grenze.
- **AC-KIS-005:** Alle drei Secure-Trader-Systeme werden sinnvoll einbezogen.
- **AC-KIS-006:** Link-, Sprach-, Accessibility- und Strukturprüfungen bestehen.
- **AC-KIS-007:** Kein Produktcode und kein Zielrepository wurde geändert.
- **AC-KIS-008:** Position 23 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine KDM-Jahr-3-Inhalte.
- Keine vollständige Produktimplementierung.
- Keine Prüfungssimulation oder Prüfungsgarantie.
- Kein C#-Rollout in diesem Lauf.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KITSM-Professional-Jahr3.md` as position 22. Verify exactly eight units, complete KITSM year-3 learning-field and competency coverage, customer/solution/economic integration, truthful offers and marketing, network planning, service and acceptance, the full document package, learner-versus-agent evidence, accessibility, and no rollout or product implementation.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KITSM-Professional-Jahr3.md` as the binding intake for position 22. Create a feature specification for the complete eight-unit KITSM year-3 learning series and its overview, unit intakes, companions, teaching guide, mappings, assessment, evidence, C#/SQL evaluation, and accessibility. Preserve KIS-001 through KIS-014 and AC-KIS-001 through AC-KIS-008. Do not modify target repositories, implement learner solutions, or start position 23.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KITSM-Professional-Jahr3.md` with deliveryAuthority=MergeAndSync after position 21 is complete. Create only the accepted Level-0 KITSM learning document package, deterministic validation, evidence, statistics, archive/order updates, and delivery evidence. Keep product code and all Level-1/Level-2 repositories unchanged. Merge one non-empty PR, return to clean synchronized main, and do not start position 23.
```

<!-- intake-authoring:end -->
