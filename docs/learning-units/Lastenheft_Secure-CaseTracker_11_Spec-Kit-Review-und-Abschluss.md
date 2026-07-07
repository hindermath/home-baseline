# Lastenheft: Secure CaseTracker 11 - Spec-Kit-Review und Abschluss

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA

## Lernziel / Learning Goal

**DE:** Lernende können einen Spec-Kit-Lauf fachlich und sicherheitlich abschließen, Evidenz prüfen, Restrisiken dokumentieren und Ergebnisse kundengerecht präsentieren.

**EN:** Learners can close a Spec Kit run from a functional and security perspective, review evidence, document residual risks, and present results in a customer-oriented way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche technische Entscheidung würdest du im Review besonders erklären? |
| SI | Primär | Welche Umgebungs- oder Toolchain-Frage bleibt als Risiko offen? |
| DPA | Primär | Welche Kennzahl würdest du Kund*innen nur mit Warnhinweis zeigen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Projektabschluss, Review, Qualitätssicherung, Kundendarstellung, Datenschutz und Informationssicherheit.

**EN:** The task connects project closure, review, quality assurance, customer presentation, privacy, and information security.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 6 („Serviceanfragen bearbeiten")**; berührt LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_11_Spec-Kit-Review-und-Abschluss.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 6 ("Serviceanfragen bearbeiten")**; touched LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_11_Spec-Kit-Review-und-Abschluss.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** gesamte Richtlinie als Abschlussmaßstab.
- **Checklisten:** CL_01 bis CL_12, je nach Aufgabe `Applicable`, `N/A` oder `Open`.
- **Presets:** alle sechs Governance-Presets.
- **Evidenz:** `spec.md`, `plan.md`, `tasks.md`, Checklisten, Reviews, Testnachweise.

## Aufgabenstellung / Task

**DE:** Plane den Abschluss der Lernreihe. Definiere, welche Artefakte vorhanden sein müssen, wie offene Risiken dokumentiert werden und wie eine kurze Präsentation aus Sicht von EuFPA aufgebaut wird.

**EN:** Plan the closure of the learning series. Define which artifacts must exist, how open risks are documented, and how a short presentation from EuFPA's perspective is structured.

## Anforderungen / Requirements

- **R-01:** Für jede gestartete Lerneinheit sind die Artefakte auffindbar (`spec.md`, `plan.md`, `tasks.md`, Checklisten, Reviews, Testnachweise).
- **R-02:** Eine Evidenzmatrix deckt alle gestarteten Lerneinheiten ab und führt je Entscheidung `Applicable`, `N/A` oder `Open` mit Begründung und Evidenzpfad.
- **R-03:** Kein offener Sicherheitsbefund wird verschwiegen; `Open` erhält Owner, Trigger oder Folgeaufgabe, Restrisiken und Folgeaufgaben bleiben sichtbar.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; nicht gestartete Lerneinheiten sind `N/A` mit Hinweis auf die Reihenfolge, nicht genutzte Zielsprachen sind `N/A`, wenn der Lauf nur eine Sprache behandelt, und externe Audits sind `N/A`, weil diese Lernreihe interne Ausbildungsnachweise erzeugt.
- **R-05:** Die Bewertung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Kein offener Sicherheitsbefund wird verschwiegen.
- `N/A` braucht Begründung.
- `Open` braucht Owner, Trigger oder Folgeaufgabe.
- Review-Ergebnisse werden nachvollziehbar dokumentiert.
- Abschlussartefakte enthalten keine echten personenbezogenen Daten.
- Datenschutzentscheidungen aus früheren Aufgaben werden zusammengeführt.
- Präsentation zeigt Datenminimierung und Aussagegrenzen.
- Nicht anwendbare Standards werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Abschluss bewertet fachliche Ergebnisse, Sicherheitsentscheidungen und Evidenz unabhängig von der Zielprogrammiersprache.
- Sprachspezifische Abweichungen werden als Abweichung, `N/A` oder `Open` dokumentiert.
- Jede genutzte Zielprogrammiersprache nennt Testkommando, Audit-Werkzeug und offene Toolchain-Fragen.
- Unterschiede zwischen C#, Go, Java, Python, Rust und Swift werden als Lernpunkt, nicht als Fehler behandelt, solange der Kernvertrag erhalten bleibt.

## Erwartete Artefakte / Expected Artifacts

- Abschluss-Checkliste.
- Evidenzmatrix.
- Restrisikoliste.
- Folgeaufgaben.
- kurze EuFPA-Präsentationsstruktur.
- Liste offener Punkte: offene Risiken werden nicht in der Präsentation versteckt, sondern verständlich zusammengefasst, und Folgeaufgaben erhalten Owner, Trigger oder geplanten nächsten Spec-Kit-Lauf.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Evidenzmatrix deckt alle gestarteten Lerneinheiten ab.
- [ ] `Applicable`, `N/A` und `Open` sind begründet.
- [ ] Restrisiken und Folgeaufgaben sind sichtbar.
- [ ] Die Abschlusspräsentation ist kundenverständlich und datenschutzfreundlich.
- [ ] Es wird geprüft, ob alle Aufgabenartefakte auffindbar sind, ob alle `Applicable`-/`N/A`-/`Open`-Entscheidungen begründet sind und ob alle sechs Zielsprachen in der Lernreihe berücksichtigt wurden.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_11_Spec-Kit-Review-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Abschlussreview, Evidenzmatrix, Restrisiken, Folgeaufgaben und kundengerechte Abschlusspräsentation der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
