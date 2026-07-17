# Lastenheft: Secure ServiceHarvester 11 - Spec-Kit-Review und Abschluss

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Abschluss-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Ein Spec-Kit-Lauf des Secure ServiceHarvester wird fachlich und sicherheitlich abgeschlossen: Evidenz wird geprüft, Restrisiken werden dokumentiert und Ergebnisse werden kundenverständlich präsentiert.

**EN:** A Secure ServiceHarvester Spec Kit run is closed from a functional and security perspective: evidence is reviewed, residual risks are documented, and results are presented in a customer-understandable way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche technische Entscheidung würdest du im Review besonders erklären? |
| SI | hoch | Welche Umgebungs-, Betriebs- oder Toolchain-Frage bleibt als Risiko offen? |
| DPA | hoch | Welche Kennzahl würdest du Kund*innen nur mit Warnhinweis zeigen? |
| DV | mittel bis hoch | Welche Schnittstellen- oder Systemgrenzenannahme bleibt als Restrisiko offen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Serviceabschluss, Review, Qualitätssicherung, kundenverständliche Übergabe, Datenschutz und Informationssicherheit auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects service closure, review, quality assurance, customer-understandable handover, privacy, and information security at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 6 („Serviceanfragen bearbeiten")**; berührt LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_11_Spec-Kit-Review-und-Abschluss.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 6 ("Serviceanfragen bearbeiten")**; touched LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_11_Spec-Kit-Review-und-Abschluss.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** gesamte Richtlinie als Abschlussmaßstab, auditfähige Evidenz, keine verschwiegenen Sicherheitsbefunde.
- **Checklisten:** CL_01 bis CL_12, je nach Aufgabe `Applicable`, `N/A` oder `Open`.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Richtlinie Testmanagement, Leitlinie für sichere Programmierung.
- **Presets:** alle sieben Governance-Presets als Nachweisrahmen.

## Aufgabenstellung / Task

**DE:** Plane den Abschluss eines Spec-Kit-Laufs des Secure ServiceHarvester. Definiere, welche Artefakte vorhanden sein müssen, wie eine Evidenzmatrix je gestarteter Lerneinheit gefüllt wird, wie offene Risiken dokumentiert werden und wie eine kurze, kundenverständliche Präsentation aus Sicht von EuFPA aufgebaut wird. Halte den Abschluss im 1. Lehrjahr klar und schlank.

**EN:** Plan the closure of a Secure ServiceHarvester Spec Kit run. Define which artifacts must exist, how an evidence matrix per started learning unit is filled, how open risks are documented, and how a short, customer-understandable presentation from EuFPA's perspective is structured. Keep the closure clear and lean in year 1.

## Anforderungen / Requirements

- **R-01:** Für jede gestartete Lerneinheit sind die Artefakte auffindbar (`spec.md`, `plan.md`, `tasks.md`, Checklisten, Reviews, Testnachweise).
- **R-02:** Eine Evidenzmatrix führt je Anforderung `Applicable`, `N/A` oder `Open` mit Begründung und Evidenzpfad.
- **R-03:** Kein offener Sicherheitsbefund wird verschwiegen; `Open` erhält Owner, Trigger oder Folgeaufgabe.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Bewertung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Kein offener Sicherheitsbefund wird verschwiegen; positive Aussagen brauchen konkrete Evidenz.
- `N/A` braucht eine kurze technische Begründung; `Open` braucht Owner, Trigger oder Folgeaufgabe.
- Abschlussartefakte enthalten keine echten personenbezogenen Daten und keine echten Secrets; Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>` sind erlaubt.
- Die Präsentation zeigt Datenminimierung und Aussagegrenzen und versteckt keine offenen Risiken.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Abschluss bewertet fachliche Ergebnisse, Sicherheitsentscheidungen und Evidenz unabhängig von der Zielprogrammiersprache.
- Sprachspezifische Abweichungen werden als Abweichung, `N/A` oder `Open` dokumentiert, nicht als Fehler.
- Jede genutzte Zielsprache nennt Testkommando, Audit-Werkzeug und offene Toolchain-Fragen.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für den Abschluss.
- `plan.md` mit Abschluss-, Review- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Prüf-, Review- und Dokumentationsschritten.
- Abschluss-Checkliste, Evidenzmatrix, Restrisikoliste, Folgeaufgaben und kurze EuFPA-Präsentationsstruktur.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Die Evidenzmatrix deckt alle gestarteten Lerneinheiten ab.
- [ ] `Applicable`, `N/A` und `Open` sind begründet; Restrisiken und Folgeaufgaben sind sichtbar.
- [ ] Mindestens ein Prüf- oder Reviewpfad je genutzter Zielsprache ist benannt.
- [ ] Die Abschlusspräsentation ist kundenverständlich und datenschutzfreundlich.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_11_Spec-Kit-Review-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Abschlussreview, Evidenzmatrix, Restrisiken, Folgeaufgaben und kundengerechte Abschlusspräsentation des Secure ServiceHarvester der EuFPA-Lernreihe. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
