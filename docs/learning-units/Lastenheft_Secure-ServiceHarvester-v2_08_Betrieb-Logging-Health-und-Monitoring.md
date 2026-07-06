# Lastenheft: Secure ServiceHarvester v2 08 - Betrieb, Logging, Health und Monitoring

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Strukturiertes Logging, ein Health- und Status-Endpunkt, einfache Betriebskennzahlen und die Regel, keine Secrets in Logs zu schreiben, werden geplant. Der Harvester-Dienst wird so beobachtbar, dass Betreiber Zustand und Auslastung erkennen, ohne Interna oder Geheimnisse preiszugeben.

**EN:** Structured logging, a health and status endpoint, simple operational metrics, and the rule not to write secrets into logs are planned. The harvester service becomes observable so operators recognize state and load without exposing internals or secrets.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt Secure ServiceHarvester v2): **primär LF 9 („Netzwerke und Dienste bereitstellen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section Secure ServiceHarvester v2): **primary LF 9 ("Netzwerke und Dienste bereitstellen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_07, CL_08, CL_09.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den beobachtbaren Betrieb des Secure ServiceHarvester eine fokussierte Spezifikation. Berücksichtige: strukturiertes Logging (Ereignis, Ebene, Kontext), einen Health- und Status-Endpunkt, einfache Betriebskennzahlen (z. B. letzte erfolgreiche Sammlung, Anzahl verarbeiteter Snapshots, Fehlerzahl) und die Regel, dass keine Secrets in Logs oder Statusausgaben erscheinen. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** Prepare a focused specification for the observable operation of the Secure ServiceHarvester. Consider structured logging (event, level, context), a health and status endpoint, simple operational metrics (e.g. last successful collection, number of processed snapshots, error count), and the rule that no secrets appear in logs or status output. The C# reference `InventarWorkerService` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Logs, Health-/Status-Endpunkt, Konfiguration, Metriken und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Keine Secrets, Tokens oder internen Pfade in Logs oder Statusausgaben schreiben.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Log-Feldliste, Health-/Status-Vertrag, Kennzahlen-Liste, Regel für secret-freie Ausgaben, Reviewpfad.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für den beobachtbaren Betrieb (strukturiertes Logging, Health/Status, einfache Kennzahlen) der EuFPA-Lernreihe Secure ServiceHarvester v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
