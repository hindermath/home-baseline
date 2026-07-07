# Lastenheft: Secure CaseTracker Digital Networking Track 02 - Topologie, Schnittstellen und Kommunikationsflüsse

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Topologie, Protokolle, Datenflüsse, Ports, Richtungen und Datenklassen werden nachvollziehbar beschrieben.

**EN:** Learners describe topology, protocols, data flows, ports, directions, and data classes in a traceable way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welche Kommunikationsrichtung entscheidet über die spätere Segment- oder Firewall-Regel? |
| AE | hoch | Welcher Schnittstellenvertrag (Richtung, Port, Format) folgt aus dem Kommunikationsfluss? |
| SI | hoch | Welche Port-/Protokollannahme muss dokumentiert und als Betriebsnachweis geprüft werden? |
| DPA | mittel bis hoch | Welche Datenklasse verlangt einen verschlüsselten oder engeren Pfad? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr und nutzt Spec-Kit als begleitende SDD-Struktur, nicht als Ersatz für das Berufsbild oder die klassische Ausbildung.

**EN:** The task supports Digital Networking in year 3 and uses Spec Kit as a companion SDD structure, not as a replacement for vocational training.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10d („Cyber-physische Systeme entwickeln")**; berührt LF 3 („Clients in Netzwerke einbinden"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10d ("Cyber-physische Systeme entwickeln")**; touched LF 3 ("Clients in Netzwerke einbinden"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Trust Boundaries, Angriffsfläche reduzieren, sichere Konfiguration, Datenschutz und Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Zugangssteuerung, Testmanagement und Richtlinie Secure Development Life Cycle.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation für Topologie, Schnittstellen und Kommunikationsflüsse. Berücksichtige Kommunikationsrichtung, Datenklassen, Ports, Protokolle, erlaubte und verbotene Verbindungen sowie Nachweise für Annahmen.

**EN:** Prepare a focused specification for topology, interfaces, and communication flows. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Jede relevante Verbindung hat Quelle, Ziel, Richtung, Zweck und Datenklasse.
- **R-02:** Verbotene oder nicht benötigte Verbindungen sind als Nicht-Ziele sichtbar.
- **R-03:** Ports, Protokolle oder gleichwertige Schnittstellenannahmen sind nachvollziehbar.
- **R-04:** `Applicable`, `N/A` und `Open` Punkte werden begründet.
- **R-05:** Sprachpfade bleiben vergleichbar, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Datenflüsse mit Personenbezug, Secrets oder Betriebsdaten gesondert kennzeichnen.
- Offene Netzwerkannahmen nicht als erfüllt darstellen.
- Monitoring- oder Testdaten nicht mit produktiven Daten vermischen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Schnittstellenvertrag (Richtung, Format, Datenklasse) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische HTTP-, gRPC- oder Messaging-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Topologie-, Sicherheits- und Evidenzpfaden.
- `tasks.md` mit prüfbaren Dokumentations-, Test- und Review-Schritten.
- Erwartete Evidenz: Kommunikationsmatrix, Schnittstellenliste, Nicht-Ziel-Liste, offene Annahmen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Kommunikationsflüsse sind für Reviewende nachvollziehbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Datenklassen und Datenschutzgrenzen sind benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Topologie, Schnittstellen und Kommunikationsflüsse der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
