# Lastenheft: Secure CaseTracker 11 - Spec-Kit-Review und Abschluss

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können einen Spec-Kit-Lauf fachlich und sicherheitlich abschließen, Evidenz prüfen, Restrisiken dokumentieren und Ergebnisse kundengerecht präsentieren.

**EN:** Learners can close a Spec Kit run from a functional and security perspective, review evidence, document residual risks, and present results in a customer-oriented way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Implementierungs- und Testentscheidungen werden fachlich geprüft. |
| SI | Primär | Umgebung, Toolchain, Sandbox und Supply Chain werden geprüft. |
| DPA | Primär | Datenschutz, Datenqualität und Kennzahlen werden geprüft. |

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

## Sicherheitsanforderungen / Security Requirements

- Kein offener Sicherheitsbefund wird verschwiegen.
- `N/A` braucht Begründung.
- `Open` braucht Owner, Trigger oder Folgeaufgabe.
- Review-Ergebnisse werden nachvollziehbar dokumentiert.

## Datenschutzanforderungen / Privacy Requirements

- Abschlussartefakte enthalten keine echten personenbezogenen Daten.
- Datenschutzentscheidungen aus früheren Aufgaben werden zusammengeführt.
- Präsentation zeigt Datenminimierung und Aussagegrenzen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Abschluss bewertet fachliche Ergebnisse, Sicherheitsentscheidungen und Evidenz unabhängig von der Zielprogrammiersprache.
- Sprachspezifische Abweichungen werden als Abweichung, `N/A` oder `Open` dokumentiert.

## Sprachspezifische Hinweise / Language-Specific Notes

- Jede genutzte Zielprogrammiersprache nennt Testkommando, Audit-Werkzeug und offene Toolchain-Fragen.
- Unterschiede zwischen C#, Go, Java, Python, Rust und Swift werden als Lernpunkt, nicht als Fehler behandelt, solange der Kernvertrag erhalten bleibt.

## Erwartete Artefakte / Expected Artifacts

- Abschluss-Checkliste.
- Evidenzmatrix.
- Restrisikoliste.
- Folgeaufgaben.
- kurze EuFPA-Präsentationsstruktur.

## Akzeptanzkriterien / Acceptance Criteria

- Evidenzmatrix deckt alle gestarteten Lerneinheiten ab.
- `Applicable`, `N/A` und `Open` sind begründet.
- Restrisiken und Folgeaufgaben sind sichtbar.
- Die Abschlusspräsentation ist kundenverständlich und datenschutzfreundlich.

## Tests und Nachweise / Tests and Evidence

- Prüfung, ob alle Aufgabenartefakte auffindbar sind.
- Prüfung, ob alle `Applicable`-/`N/A`-/`Open`-Entscheidungen begründet sind.
- Prüfung, ob alle sechs Zielsprachen in der Lernreihe berücksichtigt wurden.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche technische Entscheidung würdest du im Review besonders erklären?
- **SI:** Welche Umgebungs- oder Toolchain-Frage bleibt als Risiko offen?
- **DPA:** Welche Kennzahl würdest du Kund*innen nur mit Warnhinweis zeigen?

## N/A-Regeln / N/A Rules

- Nicht gestartete Lerneinheiten sind `N/A` mit Hinweis auf die Reihenfolge.
- Nicht genutzte Zielsprachen sind `N/A`, wenn der konkrete Lauf nur eine Sprache behandelt.
- Externe Audits sind `N/A`, weil diese Lernreihe interne Ausbildungsnachweise erzeugt.

## Offene Punkte / Open Follow-Ups

- Offene Risiken werden nicht in der Präsentation versteckt, sondern verständlich zusammengefasst.
- Folgeaufgaben erhalten Owner, Trigger oder geplanten nächsten Spec-Kit-Lauf.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_11_Spec-Kit-Review-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Abschlussreview, Evidenzmatrix, Restrisiken, Folgeaufgaben und kundengerechte Abschlusspräsentation der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung.
```
