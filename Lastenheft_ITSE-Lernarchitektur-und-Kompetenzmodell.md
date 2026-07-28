<!-- intake-authoring:begin -->
# Lastenheft: ITSE-Lernarchitektur und Kompetenzmodell

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 27, nach Position 26
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE- und FI-Lernende, Lehrende, Ausbildende, Maintainer und
Reviewer ab dem ersten Ausbildungsjahr
**Vorausgesetztes Wissen:** akzeptierte Findings aus Position 26; keine
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake definiert die Lernarchitektur für eine fachlich gleichwertige,
agentisch unterstützte ITSE-Integration. Die Fachinformatiker-Lernreihen sind
die primäre Wiederverwendungs- und Vergleichsbasis.

*This intake defines the ITSE learning architecture, competency model,
evidence contract, and safe agent boundary with the FI tracks as the primary
reuse baseline.*

## 2. Zielmodell / Target Model

Das Zielmodell besteht aus:

1. einem ITSE-Jahr-1-Retrofit für LF1 bis LF5;
2. einem technischen Jahr-2-Kern für LF6 bis LF9;
3. einer eigenen achtteiligen ITSE-Professional-Reihe für LF10 bis LF12;
4. kontrollierter Wiederverwendung aus FI/AE, FI/SI, FI/DPA und FI/DV;
5. C# als Referenzsprache für Diagnose, Simulation und Testautomatisierung;
6. einem kontrollierten Rollout in drei Level-1- und drei C#-Level-2-Ziele.

Es entsteht kein neues Produkt-, Hardware- oder Sprachrepository.

## 3. Kompetenz- und Evidence-Vertrag

Jede Kompetenz erhält stabile ID, amtliche Quelle, Lernfeld, Berufsbezug,
Zielniveau, Aufgabe, Eigenleistungsgrenze, Agentenrolle, Evidence, Bewertung
und Re-Evaluation-Trigger.

Evidence-Typen sind:

- `LearnerWork`
- `TeamWork`
- `AgentAssisted`
- `ReferenceMaterial`
- `InstructorProvided`

Jede praktische Aufgabe erhält genau einen Ausführungskontext:

- `SoftwareSandbox`
- `Simulation`
- `SupervisedLab`
- `TrainingCompany`

`SupervisedLab` bezeichnet eine durch befugtes Lehr- oder Fachpersonal
beaufsichtigte Laborhandlung. `TrainingCompany` bezeichnet einen
Ausbildungsnachweis aus dem Betrieb. Beide entstehen außerhalb autonomer
Agentenausführung.

## 4. Anforderungen / Requirements

- **ILA-001:** Das Modell deckt ITSE-LF1 bis LF12 und die Prüfungsbereiche
  vollständig ab.
- **ILA-002:** Gemeinsame FI-/ITSE-Kompetenzen besitzen genau eine kanonische
  Definition mit berufsbezogener Anwendung.
- **ILA-003:** Der Vergleich umfasst FI/AE, FI/SI, FI/DPA und FI/DV.
- **ILA-004:** FI/SI und FI/DV sind Schwerpunkte, ohne AE- und
  DPA-Kompetenzen auszublenden.
- **ILA-005:** ITSE-spezifische Energie-, Betriebssicherheits- und
  Instandhaltungskompetenzen bleiben eigenständig.
- **ILA-006:** C# ist Referenzsprache für Diagnosewerkzeuge,
  Inventarisierung, Konfigurationsprüfung, Simulation, Protokollauswertung und
  Testautomatisierung.
- **ILA-007:** C# und Simulation ersetzen keine beaufsichtigte
  elektrotechnische Praxis.
- **ILA-008:** KI-Agenten dürfen keine elektrische Anlage autonom schalten,
  speisen, messen, freigeben oder Schutzmaßnahmen umgehen.
- **ILA-009:** Jede bewertete Eigenleistung enthält Analyse,
  Entwurfsentscheidung, begrenzte Umsetzung, Prüfung und Reflexion.
- **ILA-010:** Aufgaben und Lernbegleiter verwenden denselben Kompetenz-,
  Evidence- und Sicherheitsvertrag.
- **ILA-011:** Jede neue Reihe besitzt Übersicht, acht Aufgaben,
  acht Lernbegleiter, Unterrichtsleitfaden, Mappings, Bewertungsraster,
  Evidence-Inventar und Abschlussnachweis.
- **ILA-012:** Deutsch zuerst, Englisch danach, CEFR B2, Ersterklärung und
  WCAG 2.2 AA sind verbindlich.
- **ILA-013:** Secure-Trader-Agentenarbeit bleibt Container-first.
- **ILA-014:** Bestehende FI-, KDM- und KITSM-Pfade werden nicht ersetzt.
- **ILA-015:** Positionen 28 bis 33 werden nicht automatisch gestartet.

## 5. Ergebnisartefakte / Expected Artifacts

- ITSE-Kompetenzkatalog;
- LF- und Prüfungsbereichsmatrix;
- FI-Wiederverwendungs- und Differenzierungsmodell;
- Dokumentpaket- und Dateinamensvertrag;
- Agenten-, Praxis- und Evidence-Modell;
- C#-Referenzprofil;
- aktualisierte Lernreihen-Vorlagen und Handoffs.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-ILA-001:** Jede Kompetenz besitzt Quelle, Lernfeld, Aufgabe, Evidence,
  Bewertung und Ausführungskontext.
- **AC-ILA-002:** Gemeinsame FI-/ITSE-Kompetenzen sind nicht redundant
  kanonisiert.
- **AC-ILA-003:** Alle vier FI-Fachrichtungen sind nachweisbar berücksichtigt.
- **AC-ILA-004:** Die Grenzen zwischen Software, Simulation, Labor und Betrieb
  sind maschinenprüfbar.
- **AC-ILA-005:** Das Pflicht-Dokumentpaket ist vollständig beschrieben.
- **AC-ILA-006:** Es verbleibt keine Critical-/High-Ambiguität für Position 28.
- **AC-ILA-007:** Kein Folgelauf wurde gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine Erstellung der einzelnen Einheiten.
- Keine Elektrofachkraft- oder Prüfungsqualifikation.
- Keine Produktcode- oder Flottenänderung.
- Keine autonome Hardwaresteuerung.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Lernarchitektur-und-Kompetenzmodell.md` as position 27. Verify complete ITSE coverage, all-four-FI reuse, ITSE differentiation, C# reference limits, evidence types, exact execution contexts, agent and electrical-safety boundaries, mandatory document package, accessibility, and no downstream execution.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Lernarchitektur-und-Kompetenzmodell.md` as the binding intake for position 27. Create a feature specification for the ITSE competency catalog, FI reuse model, evidence and execution-context contracts, C# reference profile, safe agent boundary, mandatory document package, and downstream handoffs. Preserve ILA-001 through ILA-015 and AC-ILA-001 through AC-ILA-007. Do not create unit materials, change product code, update fleet repositories, or start position 28.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-Lernarchitektur-und-Kompetenzmodell.md` with deliveryAuthority=MergeAndSync after position 26 is complete. Implement only accepted Level-0 architecture, models, templates, evidence, statistics, archive/order updates, and one non-empty PR. Return to clean synchronized main and do not start position 28.
```

<!-- intake-authoring:end -->
