# Lastenheft: Secure CaseTracker Digital Networking Track 03 - Trust Boundaries und Segmentierung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Vertrauensgrenzen, Netzwerksegmente, Schutzbedarf und erlaubte Übergänge werden sichtbar gemacht.

**EN:** Learners make trust boundaries, network segments, protection needs, and allowed transitions visible.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit strukturiert Spezifikation, Planung und Nachweise, ersetzt aber keine berufliche Grundbildung.

**EN:** The task supports Digital Networking in year 3. Spec Kit structures specification, planning, and evidence but does not replace vocational learning.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Defense in Depth, Least Privilege, Fail-Safe Defaults, Trust Boundaries und sichere Architektur.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Richtlinie Secure Development Life Cycle.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Trust Boundaries und Segmentierung. Berücksichtige Segmente, erlaubte Übergänge, blockierte Pfade, Schutzbedarf, Datenklassen und Begründungen für `N/A` oder offene Punkte.

**EN:** Prepare a specification for trust boundaries and segmentation. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Vertrauensgrenzen und Segmente sind klar benannt.
- **R-02:** Erlaubte und verbotene Übergänge sind getrennt beschrieben.
- **R-03:** Schutzbedarf und Datenklassen sind pro Segment oder Übergang sichtbar.
- **R-04:** `Applicable`, `N/A` und `Open` Punkte werden begründet.
- **R-05:** Die Arbeit bleibt sprachneutral vergleichbar, soweit möglich.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Standardannahme ist deny by default, erlaubte Übergänge werden begründet.
- Übergänge mit personenbezogenen Daten oder Secrets erhalten eigene Prüfnotiz.
- Nicht modellierte Übergänge dürfen nicht stillschweigend als sicher gelten.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Segmentierungs- und Nachweisstrategie.
- `tasks.md` mit Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Segmentliste, Trust-Boundary-Matrix, erlaubte Übergänge, blockierte Pfade.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Segmentierung und Trust Boundaries sind prüfbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Trust Boundaries und Segmentierung der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
