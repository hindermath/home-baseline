<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-Lernarchitektur und Kompetenzmodell

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 19, nach Position 18
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** KDM- und KITSM-Lernende, Lehrende, Ausbildende, Maintainer und
Reviewer ab dem ersten Ausbildungsjahr
**Vorausgesetztes Wissen:** Ergebnisse des Gap-Audits; keine vorherige
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake definiert aus den bestätigten Audit-Findings die gemeinsame
Lernarchitektur für KDM und KITSM. Eine **Lernarchitektur** beschreibt, wie
Kompetenzen, Aufgaben, Lernmaterialien, Praxis, Evidence und Reihenfolge
zusammenwirken.

*This intake defines the shared learning architecture, competency model, and
evidence contract for KDM and KITSM.*

## 2. Zielmodell / Target Model

Das Zielmodell besteht aus:

1. vertieften Jahr-1-Pfaden in den vorhandenen Secure-Trader-Grundreihen;
2. einem gemeinsamen kaufmännischen Kern für Jahr 2;
3. einem eigenen KITSM-Track für Jahr 3;
4. einem eigenen KDM-Track für Jahr 3;
5. C#/.NET als verbindlicher Referenzsprache;
6. einem kontrollierten Rollout in drei Level-1- und drei C#-Level-2-Repositories.

Es entstehen keine neuen Produkt- oder Sprach-Repositories.

## 3. Kompetenz- und Evidence-Vertrag

Jede Kompetenz erhält eine stabile ID, Berufsbezug, Lernfeld, Zielniveau,
Aufgabe, Eigenleistungsgrenze, Evidence, Bewertung und Re-Evaluation.

Evidence-Typen sind genau:

- `LearnerWork`
- `TeamWork`
- `AgentAssisted`
- `ReferenceMaterial`
- `InstructorProvided`

Eine als eigene Kompetenz bewertete Leistung muss Analyse, wesentliche
Entwurfsentscheidung, begrenzte Umsetzung, Prüfung und Reflexion durch die
lernende Person nachvollziehbar machen.

## 4. Dokumentpaket-Vertrag

Jede neue Lernreihe besitzt:

- eine Lernreihen-Übersicht;
- acht Aufgaben-Lastenhefte;
- acht Lernbegleiter;
- einen Unterrichtsleitfaden;
- Kompetenz-, Lernfeld- und Prüfungsbereich-Mapping;
- Bewertungsraster und Evidence-Inventar;
- C#-/SQL-Praxisvertrag;
- Glossarverweise und textorientierte Accessibility-Nachweise;
- Abschluss- und Übergabenachweis.

## 5. Anforderungen / Requirements

- **KLA-001:** Das Modell bildet alle KDM-/KITSM-Lernfelder ohne Lücke ab.
- **KLA-002:** Gemeinsame Jahr-1- und Jahr-2-Kompetenzen werden einmal
  beschrieben und berufsbezogen angewendet.
- **KLA-003:** KITSM- und KDM-Jahr-3-Kompetenzen bleiben getrennt.
- **KLA-004:** C#/.NET ist die verbindliche Referenzsprache; SQL ist
  verpflichtender ergänzender Praxisbestandteil.
- **KLA-005:** LF5 verlangt eine begrenzte C#-/SQL-Änderung mit Tests.
- **KLA-006:** LF7 verlangt ein zusammenhängendes begrenztes Softwareprojekt
  mit Entwurf, C#-Implementierung, Tests und Fehlerkorrektur.
- **KLA-007:** Andere MSL-Pfade sind optionaler Vergleich und keine
  Abschlussvoraussetzung.
- **KLA-008:** Jede Einheit trennt Eigenleistung, Teamarbeit und
  Agentenunterstützung.
- **KLA-009:** Prüfungsbereiche werden auf Kompetenzen gemappt, ohne
  Prüfungsgarantie oder Prüfungssimulation.
- **KLA-010:** Das Dokumentpaket ist für jede neue Reihe vollständig
  verpflichtend.
- **KLA-011:** Deutsch zuerst, Englisch danach, CEFR B2, Ersterklärung von
  Fachbegriffen und WCAG 2.2 AA sind verbindlich.
- **KLA-012:** Secure-Trader-Agentenarbeit bleibt Container-first.
- **KLA-013:** Das Modell bewahrt bestehende FI-Lernpfade und vermeidet
  duplizierte Produktreihen.
- **KLA-014:** Rollen, Kompetenz-IDs, Dokumentnamen und Evidence-Schemata werden
  in Blueprint, Register und Vorlagen verankert.
- **KLA-015:** Positionen 20 bis 25 werden nicht automatisch gestartet.

## 6. Ergebnisartefakte / Expected Artifacts

- verbindliches Drei-Reihen-/Jahr-1-Retrofit-Modell;
- Kompetenzkatalog und Lernfeldmatrix;
- Evidence- und Bewertungsmodell;
- Dokumentpaket- und Dateinamensvertrag;
- C#-/SQL-Referenzprofil;
- Agenten- und Eigenleistungsregel;
- aktualisierte zentrale Lernreihen-Vorlagen;
- Handoffs für Positionen 20 bis 25.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-KLA-001:** Jede offizielle Kompetenz besitzt ID, Lernfeld, Aufgabe,
  Evidence und Bewertung.
- **AC-KLA-002:** Das Modell enthält genau drei neue Reihen und ein
  Jahr-1-Retrofit.
- **AC-KLA-003:** Das Pflicht-Dokumentpaket ist maschinenprüfbar beschrieben.
- **AC-KLA-004:** C#-, SQL-, Test- und Eigenleistungsuntergrenzen sind eindeutig.
- **AC-KLA-005:** Bestehende FI-Pfade und Repositories bleiben unverändert.
- **AC-KLA-006:** Es verbleibt keine Critical-/High-Ambiguität für Position 20.
- **AC-KLA-007:** Kein Folgelauf wurde automatisch gestartet.

## 8. Nicht-Ziele / Non-Goals

- Keine Erstellung der einzelnen Lernmaterialien in diesem Lauf.
- Keine Produktcode- oder Flottenänderung.
- Kein neues Preset.
- Keine prozentuale Programmierquote als Ersatz für Kompetenznachweise.

<!-- intake-authoring:prompts -->
## 9. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-Lernarchitektur-und-Kompetenzmodell.md` as position 19. Verify the three-series plus year-1-retrofit model, complete learning-field coverage, C# reference and SQL floor, LF5/LF7 implementation proof, exact evidence types, learner-versus-agent boundaries, mandatory document package, accessibility, and no product or fleet implementation.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-Lernarchitektur-und-Kompetenzmodell.md` as the binding intake for position 19. Create a feature specification for the KDM/KITSM learning architecture, competency catalog, evidence model, C# reference profile, mandatory document package, learner-work boundary, and downstream handoffs. Preserve KLA-001 through KLA-015 and AC-KLA-001 through AC-KLA-007. Do not create unit materials, change product code, update fleet repositories, or start position 20.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-Lernarchitektur-und-Kompetenzmodell.md` with deliveryAuthority=MergeAndSync after position 18 is complete and its findings are accepted. Implement only the Level-0 architecture, model, templates, evidence, statistics, order/archive updates, and delivery evidence. Merge one non-empty PR, return to clean synchronized main, and do not start position 20 automatically.
```

<!-- intake-authoring:end -->
