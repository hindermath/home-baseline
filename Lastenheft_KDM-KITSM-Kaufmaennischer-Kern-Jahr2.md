<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-Kaufmännischer Kern Jahr 2

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 21, nach Position 20  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** KDM- und KITSM-Lernende, Lehrende, Ausbildende, Maintainer und
Reviewer ab dem zweiten Ausbildungsjahr  
**Vorausgesetztes Wissen:** abgeschlossener Jahr-1-Pfad und Grundkenntnisse in
C#, SQL, Tests, Datenschutz und Kundenkommunikation

## 1. Zweck / Purpose

Dieser Intake erstellt eine gemeinsame Lernreihe für die gemeinsamen
kaufmännischen Lernfelder des zweiten Ausbildungsjahres. Der
**kaufmännische Kern** verbindet technische Umsetzbarkeit mit Kundenbedarf,
Beschaffung, Kosten, Service und verantwortlicher Einführung.

*This intake creates the shared KDM and KITSM year-2 commercial core learning
series.*

## 2. Verbindliche acht Einheiten / Eight Required Units

1. Serviceanfrage und Kundenbedarf
2. Anforderungen und Softwareentwurf
3. Begrenzte C#-Implementierung
4. Automatisierte Tests, Fehlerkorrektur und Qualität
5. Beschaffung, Lizenzen und Lieferantenbewertung
6. Netzwerkbasierte IT-Lösung
7. Einführung, Schulung, Sicherheit und Barrierefreiheit
8. Abnahme, Reflexion und Übergabe

Die Einheiten nutzen Secure OrderDesk, Secure ServiceHarvester und Secure
CaseTracker als zusammenhängende Fallbeispiele.

## 3. Pflicht-Dokumentpaket / Required Document Package

- eine Lernreihen-Übersicht;
- acht Aufgaben-Lastenhefte;
- acht Lernbegleiter;
- ein Unterrichtsleitfaden;
- Kompetenz-, Lernfeld- und Prüfungsbereich-Mapping;
- Bewertungsraster und Evidence-Inventar;
- C#-/SQL-Praxisvertrag;
- Abschluss- und Übergabenachweis.

## 4. Anforderungen / Requirements

- **KY2-001:** Die acht Einheiten decken LF6 bis LF9 vollständig ab.
- **KY2-002:** Jede Einheit verwendet mindestens ein passendes
  Secure-Trader-Szenario; die Reihe erklärt die systemübergreifende Verbindung.
- **KY2-003:** Das Softwareprojekt umfasst Anforderung, Entwurf, C#-Umsetzung,
  SQL, Positiv-/Negativtests und Fehlerkorrektur.
- **KY2-004:** Die Implementierungsaufgabe bleibt begrenzt, nachvollziehbar und
  für kaufmännische IT-Lernende fachlich relevant.
- **KY2-005:** Beschaffungs-, Lizenz-, Lieferanten- und Wirtschaftlichkeitsfragen
  werden anhand prüfbarer Kriterien bearbeitet.
- **KY2-006:** Die Netzwerkaufgabe enthält Topologie, Schutzbedarf,
  Zugriffsgrenzen, Kosten und textorientierte Darstellung.
- **KY2-007:** Einführung und Schulung berücksichtigen Datenschutz,
  Informationssicherheit und WCAG 2.2 AA.
- **KY2-008:** Jede Einheit enthält Lernziel, Voraussetzungen, Begriffserklärung,
  Schrittfolge, Eigenleistung, Agentengrenze, Evidence und Bewertung.
- **KY2-009:** Jeder Lernbegleiter enthält Verständnisfragen mit
  Musterantworten, ohne die Lernendenlösung vorwegzunehmen.
- **KY2-010:** Der Unterrichtsleitfaden erklärt Reihenfolge, Differenzierung,
  typische Fehler, sichere Betreuung und Bewertungsgrenzen.
- **KY2-011:** Deutsch zuerst, Englisch danach und CEFR B2 gelten für alle
  nutzerseitigen Inhalte.
- **KY2-012:** Die Reihe bleibt Level-0-Lernmaterial und verändert keine
  Zielrepositorys.
- **KY2-013:** Position 22 wird nicht automatisch gestartet.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-KY2-001:** Genau acht Aufgaben-Lastenhefte und acht passende
  Lernbegleiter sind vorhanden.
- **AC-KY2-002:** Ein Unterrichtsleitfaden und alle Mappings sind vollständig.
- **AC-KY2-003:** LF6–LF9 besitzen jeweils Kompetenz, Aufgabe, Evidence und
  Bewertung.
- **AC-KY2-004:** C#-, SQL- und Testnachweise sind reproduzierbar beschrieben.
- **AC-KY2-005:** Alle drei Secure-Trader-Systeme werden fachlich sinnvoll
  verwendet.
- **AC-KY2-006:** Accessibility-, Link-, Sprach- und Strukturprüfungen bestehen.
- **AC-KY2-007:** Kein Produktcode und kein Zielrepository wurde geändert.
- **AC-KY2-008:** Position 22 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine Jahr-3-Spezialisierung.
- Keine Prüfungssimulation.
- Keine fertige Referenzlösung.
- Kein C#-Rollout in diesem Lauf.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-Kaufmaennischer-Kern-Jahr2.md` as position 21. Verify exactly eight units, complete LF6-LF9 coverage, all mandatory document-package members, a bounded C#/SQL software project with tests, procurement and network competence, all three Secure Trader scenarios, learner-versus-agent evidence, accessibility, and no rollout or product implementation.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-Kaufmaennischer-Kern-Jahr2.md` as the binding intake for position 21. Create a feature specification for the complete eight-unit shared year-2 KDM/KITSM learning series and its overview, unit intakes, companions, teaching guide, mappings, assessment, evidence, C#/SQL proof, and accessibility. Preserve KY2-001 through KY2-013 and AC-KY2-001 through AC-KY2-008. Do not modify target repositories, implement learner solutions, or start position 22.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-Kaufmaennischer-Kern-Jahr2.md` with deliveryAuthority=MergeAndSync after position 20 is complete. Create only the accepted Level-0 learning document package, deterministic validation, evidence, statistics, archive/order updates, and delivery evidence. Keep product code and all Level-1/Level-2 repositories unchanged. Merge one non-empty PR, return to clean synchronized main, and do not start position 22.
```

<!-- intake-authoring:end -->
