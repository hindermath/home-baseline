# Lastenheft: Secure CaseTracker Digital Networking Track 05 - Verfügbarkeit, Resilienz und Fallbacks

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Ausfallannahmen, Wiederanlauf, Degradation, Timeouts und Resilienzgrenzen werden geplant.

**EN:** Learners plan failure assumptions, restart behavior, degradation, timeouts, and resilience boundaries.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr und nutzt Spec-Kit nur als begleitende SDD-Struktur.

**EN:** The task supports Digital Networking in year 3 and uses Spec Kit only as a companion SDD structure.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Fail-Safe Defaults, Defense in Depth, sichere Architektur, Testbarkeit und Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** BCM-Notfallhandbuch, Testmanagement, Leitlinie Sicheres Softwaredesign.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Verfügbarkeit, Resilienz und Fallbacks. Berücksichtige Ausfallarten, Zeitüberschreitungen, Wiederanlauf, Datenverlustgrenzen, sichere Degradation, Testfälle und `N/A`-Begründungen.

**EN:** Prepare a specification for availability, resilience, and fallbacks. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Relevante Ausfallarten und Auswirkungen sind beschrieben.
- **R-02:** Timeout-, Retry-, Fallback- und Wiederanlaufannahmen sind getrennt dokumentiert.
- **R-03:** Sichere Degradation und Datenverlustgrenzen sind sichtbar.
- **R-04:** Test-, Review- oder Evidenzpfade sind benannt.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden begründet.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Fallbacks dürfen keine Authentifizierung, Autorisierung oder Datenschutzgrenzen umgehen.
- Fehlerausgaben dürfen keine Secrets, internen Pfade oder Verbindungsdaten offenlegen.
- Resilienzbehauptungen benötigen nachvollziehbare Test- oder Review-Evidenz.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Resilienz-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Ausfallmatrix, Fallback-Regeln, Timeout-/Retry-Annahmen, Testideen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Ausfallannahmen sind konkret und prüfbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Sicherheits- und Datenschutzgrenzen bleiben auch im Fehlerfall erhalten.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Verfügbarkeit, Resilienz und Fallbacks der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
