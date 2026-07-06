# Lastenheft: Secure ServiceHarvester Data & Process Track 07 - Anomalie- und Lückenerkennung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Referenzprojekt / Reference project:** C#-Referenz `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Anomalien (z. B. ein Zeitstempel in der Zukunft, ein plötzlicher OS-Wechsel, eine verstummte Maschine) und Lücken (fehlende Sammelläufe) in den ServiceHarvester-Daten werden erkannt, unterschieden und begründet gemeldet. Lernende wählen zwischen einfachen Schwellenwertregeln und Werkzeugen des maschinellen Lernens und wägen Falsch-Positive gegen Falsch-Negative ab.

**EN:** Anomalies (e.g., a timestamp in the future, a sudden OS change, a machine gone silent) and gaps (missing collection runs) in the ServiceHarvester data are detected, distinguished, and reported with justification. Learners choose between simple threshold rules and machine-learning tools and weigh false positives against false negatives.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Wie kapselt der Code eine Anomalieregel testbar und ohne Fehlalarm-Flut? |
| SI | mittel bis hoch | Welche Betriebslücke (Ausfall, Netz, Zeitdrift) erzeugt scheinbare Anomalien? |
| DPA | hoch | Welche Anomalie ist echt, welche ist ein Datenartefakt, und wie belegt man das? |
| DV | mittel bis hoch | Welche Kommunikations- oder Segmentierungslücke verursacht fehlende Sammelläufe? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Mustererkennung in gesammelten Daten, sichere Entwicklung und begründete Meldelogik mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports third-year specialization. It connects pattern detection in collected data, secure development, and justified alerting logic with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10c („Werkzeuge des maschinellen Lernens einsetzen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Begründung: Anomalie- und Lückenerkennung ist ein klassischer Einsatzfall für ML- und Schwellenwert-Werkzeuge; die Datenhaltung des Harvesters (LF 5) liefert die Zeitreihen. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10c ("Werkzeuge des maschinellen Lernens einsetzen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Rationale: anomaly and gap detection is a classic use case for ML and threshold tools; the harvester's data storage (LF 5) provides the time series. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Anomalie- und Lückenerkennung eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Definiere zunächst eine Baseline (was ist normal?), unterscheide echte Anomalien von Datenartefakten und benenne Erfassungslücken getrennt von auffälligen Werten. Lege je Erkennungsregel fest, ob sie ein einfacher Schwellenwert oder ein ML-Werkzeug ist, welche Falsch-Positiv-/Falsch-Negativ-Rate erwartet wird und wie ein Alarm belegt wird. Nutze die C#-Referenz `InventarWorkerService` nur als Vergleich; die Lösung bleibt sprachneutral. Anomalien aus nicht vertrauenswürdigen Daten dürfen nie ungeprüft eine Aktion auslösen.

**EN:** Prepare a focused specification for anomaly and gap detection for the DPA - Data and Process Analysis specialization. Consider: first define a baseline (what is normal?), distinguish real anomalies from data artifacts, and name collection gaps separately from unusual values. For each detection rule, define whether it is a simple threshold or an ML tool, which false-positive/false-negative rate is expected, and how an alert is evidenced. Use the C# reference `InventarWorkerService` only for comparison; the solution stays language-neutral. Anomalies derived from untrusted data must never trigger an action unchecked.

## Anforderungen / Requirements

- **R-01:** Baseline, Anomaliearten und Lückenarten sind klar beschrieben und getrennt benannt.
- **R-02:** Je Erkennungsregel sind Verfahren (Schwellenwert oder ML-Werkzeug), erwartete Fehlerrate und Meldeweg dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade für Alarme und für Falsch-Positive sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Eingaben, Zeitstempel, Dateien, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Anomalien aus nicht vertrauenswürdigen Daten lösen keine automatische Aktion ohne Prüfung aus.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Baseline, Anomalie- und Lückenregeln bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Bibliotheken für Statistik oder ML dürfen gewählt, müssen aber begründet und in der Lieferkette bewertet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Baseline-Definition, Anomalie-/Lücken-Regeltabelle, Fehlerraten-Abschätzung, Beispiel-Alarm mit Nachweis, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Echte Anomalien, Datenartefakte und Erfassungslücken sind getrennt sichtbar.
- [ ] Je Regel sind Verfahren, erwartete Fehlerrate und Nachweisweg benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Anomalie- und Lückenerkennung der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
