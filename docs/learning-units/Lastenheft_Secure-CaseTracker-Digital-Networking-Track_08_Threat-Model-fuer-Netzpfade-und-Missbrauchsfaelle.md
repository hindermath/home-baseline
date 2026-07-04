# Lastenheft: Secure CaseTracker Digital Networking Track 08 - Threat Model für Netzpfade und Missbrauchsfälle

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** STRIDE-orientierte Risiken, CAPEC-Bezüge, Missbrauchsfälle und Gegenmaßnahmen werden bewertet.

**EN:** Learners assess STRIDE-oriented risks, CAPEC references, abuse cases, and countermeasures.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit hilft bei Struktur und Evidenz, ersetzt aber keine klassische Bedrohungsmodellierungs- und Sicherheitsausbildung.

**EN:** The task supports Digital Networking in year 3. Spec Kit helps with structure and evidence but does not replace security education.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Threat Modeling, Defense in Depth, Fail-Safe Defaults, sichere Architektur und Review-Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Richtlinie Secure Development Life Cycle, Checkliste Secure Development Life Cycle.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite ein Threat Model für die wichtigsten Netzpfade. Berücksichtige STRIDE, relevante CAPEC-Muster, Missbrauchsfälle, betroffene Assets, Eintrittsstellen, Gegenmaßnahmen, Restrisiken und `N/A`-Begründungen.

**EN:** Prepare a threat model for the most important network paths. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Die wichtigsten Netzpfade und Assets sind benannt.
- **R-02:** STRIDE-Kategorien werden geprüft oder begründet als `N/A` dokumentiert.
- **R-03:** Relevante CAPEC-Muster werden für die risikoreichsten Pfade genutzt.
- **R-04:** Gegenmaßnahmen, Restrisiken und offene Punkte sind sichtbar.
- **R-05:** Review- und Evidenzpfade sind benannt.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine produktiven Details, echten Secrets oder ausnutzbaren Betriebsdaten dokumentieren.
- Missbrauchsfälle didaktisch beschreiben, nicht als Angriffsanleitung ausformulieren.
- Restrisiken nicht als behoben darstellen.
- Datenschutzrisiken aus Monitoring, Logs und Datenflüssen gesondert prüfen.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Threat-Model-, Review- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Threat-Model-Tabelle, Missbrauchsfälle, Gegenmaßnahmen, Restrisiken.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Threat Model und Missbrauchsfälle sind reviewfähig.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] CAPEC wird dort genutzt, wo es für die wichtigsten Pfade hilfreich ist.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_08_Threat-Model-fuer-Netzpfade-und-Missbrauchsfaelle.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein Threat Model der Netzpfade und Missbrauchsfälle der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
