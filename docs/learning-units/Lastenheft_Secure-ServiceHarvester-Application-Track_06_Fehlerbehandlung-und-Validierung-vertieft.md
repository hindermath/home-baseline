# Lastenheft: Secure ServiceHarvester Application Track 06 - Fehlerbehandlung und Validierung vertieft

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** AE - Anwendungsentwicklung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Fehlerbehandlung und Eingabevalidierung werden zu einem durchgängigen, mehrschichtigen Konzept vertieft. Lernende trennen Validierungsfehler, Fachfehler und technische Fehler, legen ein einheitliches Fehler-Response-Modell fest und weisen jedes Verhalten mit Negativtests nach.

**EN:** Error handling and input validation are deepened into a consistent, multi-layered concept. Learners separate validation errors, domain errors, and technical errors, define a uniform error response model, and evidence every behavior with negative tests.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (primär) | Welche Validierungs- und Fehlerentscheidung wird im Code an welcher Schicht getroffen? |
| SI | mittel | Wie wirken sich Fehlerpfade auf Betrieb, Neustart und Log-Auswertung aus? |
| DPA | mittel | Welche Fehlermeldung darf welche Daten enthalten und welche nicht? |
| DV | mittel | Welche Fehlerantwort überschreitet eine Schnittstellen- oder Systemgrenze? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe vertieft die sichere Realisierung von Anwendungsfunktionalität im 3. Lehrjahr. Sie verbindet mehrschichtige Validierung, kontrollierte Fehlerbehandlung und auditfähige Nachweise mit dem Schutzbedarf der verarbeiteten Statusdaten.

**EN:** The task deepens the secure realization of application functionality in the third year. It connects multi-layer validation, controlled error handling, and audit-ready evidence with the protection need of the processed status data.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Fail-Safe-Defaults, Trust Boundaries, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement und Fehlerbehandlungsvorgaben nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die vertiefte Fehlerbehandlung und Validierung des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung AE - Anwendungsentwicklung. Berücksichtige: Trennung von Validierungs-, Fach- und technischen Fehlern, ein einheitliches Fehler-Response-Modell mit stabilen Fehlercodes, Validierung an jeder Vertrauensgrenze und Negativtests als Nachweis. Fehlermeldungen an Endnutzer dürfen keine internen Zustände, Stack-Traces oder Verbindungszeichenketten preisgeben. Halte den fachlichen Vertrag sprachneutral; nutze `InventarWorkerService` nur als C#-Referenz.

**EN:** Prepare a focused specification for the deepened error handling and validation of the Secure ServiceHarvester for the AE - Application Development specialization. Consider: separation of validation, domain, and technical errors; a uniform error response model with stable error codes; validation at every trust boundary; and negative tests as evidence. Error messages to end users must not expose internal state, stack traces, or connection strings. Keep the domain contract language-neutral; use `InventarWorkerService` only as a C# reference.

## Anforderungen / Requirements

- **R-01:** Validierungsfehler, Fachfehler und technische Fehler sind klar getrennt und benannt.
- **R-02:** Ein einheitliches Fehler-Response-Modell mit stabilen Fehlercodes ist definiert.
- **R-03:** Jede Vertrauensgrenze validiert Eingaben, bevor sie weiterverarbeitet werden.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Fehlermeldungen an Endnutzer enthalten keine internen Details; die Diagnose bleibt im internen Log.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Eingaben, Importe, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Fehlerpfade fallen in einen sicheren Zustand zurück (Fail-Safe-Defaults).
- Positive Sicherheitsaussagen nur mit Negativtest-Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Fehler- und Validierungsmodell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Mechanismen (Exceptions, `Result`, Fehlerwerte) dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Eingabe-, Fehler-, Logging- oder Grenzprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Validierungs-, Fehler-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Fehlerklassen-Tabelle, Fehlercode-Katalog, Validierungsmatrix je Vertrauensgrenze, Negativtest-Liste.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung AE ist klar sichtbar.
- [ ] Validierungs-, Fach- und technische Fehler sind getrennt dokumentiert.
- [ ] Mindestens ein Negativtest pro Fehlerklasse ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die vertiefte Fehlerbehandlung und Validierung der EuFPA-Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
