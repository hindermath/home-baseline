# Lastenheft: Secure ServiceHarvester 10 - Betriebssicht und Kennzahlen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA, SI, AE, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Health, Betriebssicht und einfache Betriebskennzahlen des Sammel-Dienstes werden definiert, berechnet und kritisch bewertet, ohne Datenqualität, Datenschutz und Aussagegrenzen zu ignorieren.

**EN:** Health, operational view, and simple operational metrics of the collection service are defined, calculated, and critically assessed without ignoring data quality, privacy, and limits of interpretation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Kennzahlenberechnung muss deterministisch testbar sein? |
| SI | hoch | Welche Betriebs- oder Health-Daten wären nützlich, aber sensibel? |
| DPA | hoch | Welche Kennzahl kann leicht falsch interpretiert werden und warum? |
| DV | mittel bis hoch | Welche Systemgrenze oder Kommunikationsannahme beeinflusst die Datenqualität? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Betriebssicht, Health, einfache Kennzahlen, Datenqualität, Datenschutz und kundenverständliche Darstellung auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects the operational view, health, simple metrics, data quality, privacy, and customer-understandable presentation at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 6 („Serviceanfragen bearbeiten")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 6 ("Serviceanfragen bearbeiten")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Zweckbindung, nachvollziehbare Dokumentation, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_11.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Richtlinie Testmanagement nach Bedarf.
- **Presets:** security-governance, a11y-governance.

## Aufgabenstellung / Task

**DE:** Definiere für den laufenden Secure ServiceHarvester eine einfache Betriebssicht und Kennzahlen: Anzahl gesehener Maschinen, Alter des letzten Sammelns (Harvest-Age), Fehlerquote der Sammelläufe und Datenqualitätsprobleme. Beschreibe, welche Daten dafür genutzt werden dürfen und welche Aussagegrenzen bestehen. Halte die Betriebssicht im 1. Lehrjahr bewusst einfach.

**EN:** For the running Secure ServiceHarvester, define a simple operational view and metrics: number of seen machines, age of the last collection (harvest age), error rate of collection runs, and data-quality issues. Describe which data may be used and what limits of interpretation exist. Keep the operational view deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Health- und Betriebssicht des Dienstes sind klar beschrieben (läuft, sammelt, letzter Erfolg).
- **R-02:** Jede Kennzahl hat Zweck, sprachneutrale Formel und Aussagegrenze.
- **R-03:** Fehlende, fehlerhafte oder veraltete Daten werden sichtbar behandelt, nicht still gefüllt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Beispieldaten bleiben fiktiv.
- Kennzahlen dürfen keine Rückschlüsse auf echte Personen ermöglichen.
- Aggregierte Werte enthalten keine vertraulichen Detail- oder Freitextinhalte.
- Positive Aussagen zu Betrieb oder Sicherheit nur mit Nachweis treffen; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Kennzahlenformeln sind unabhängig von der Zielprogrammiersprache.
- Jede Sprache muss dieselben fiktiven Testdaten gleich auswerten.
- Sprachspezifische Datums-, Zeit- und Zeitzonenlogik wird deterministisch getestet, wenn sie die Aussage beeinflusst.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` mit Health-/Betriebssicht und Kennzahlenkatalog.
- `plan.md` mit Berechnungs-, Datenqualitäts-, Datenschutz- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Berechnungs-, Test- und Dokumentationsschritten.
- Beispielauswertung mit fiktiven, wiederholbaren Daten und Aussagegrenzen.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Jede Kennzahl hat Zweck, Formel und Aussagegrenze.
- [ ] Fehlende, fehlerhafte oder veraltete Daten werden sichtbar behandelt.
- [ ] Mindestens ein deterministischer Test für eine Kennzahl ist benannt.
- [ ] Datenschutzrisiken sind bewertet; offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Health, Betriebssicht, einfache Betriebskennzahlen, Datenqualität, Datenschutz und Aussagegrenzen des Secure ServiceHarvester der EuFPA-Lernreihe. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
