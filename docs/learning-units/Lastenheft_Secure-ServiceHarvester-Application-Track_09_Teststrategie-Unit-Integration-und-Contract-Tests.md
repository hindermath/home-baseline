# Lastenheft: Secure ServiceHarvester Application Track 09 - Teststrategie: Unit, Integration und Contract-Tests

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

**DE:** Eine belastbare Teststrategie wird als Testpyramide aus Unit-, Integrations- und Contract-Tests entworfen. Lernende ordnen jede Testart ihrem Zweck zu, planen Negativ- und Sicherheitstests bewusst mit ein und legen reproduzierbare, auditfähige Testnachweise fest.

**EN:** A robust test strategy is designed as a test pyramid of unit, integration, and contract tests. Learners assign each test type to its purpose, deliberately include negative and security tests, and define reproducible, audit-ready test evidence.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (primär) | Welche Testart deckt welchen Vertrag oder welche Fehlerklasse ab? |
| SI | mittel | Wie laufen die Tests reproduzierbar in CI und Sandbox? |
| DPA | mittel | Wie bleiben Testdaten synthetisch und datenschutzkonform? |
| DV | mittel | Welcher Contract-Test sichert eine Schnittstellen- oder Systemgrenze ab? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe vertieft die sichere Realisierung und Qualitätssicherung von Anwendungsfunktionalität im 3. Lehrjahr. Sie verbindet Testpyramide, Negativtests und reproduzierbare Nachweise mit dem Schutzbedarf der getesteten Funktionen.

**EN:** The task deepens the secure realization and quality assurance of application functionality in the third year. It connects the test pyramid, negative tests, and reproducible evidence with the protection need of the tested functions.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Testbarkeit, sichere Programmierung, reproduzierbare Nachweise, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Testmanagement, Leitlinie für sichere Programmierung, CI-Nachweisvorgaben nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Teststrategie des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung AE - Anwendungsentwicklung. Berücksichtige: eine Testpyramide aus vielen schnellen Unit-Tests, gezielten Integrationstests und Contract-Tests an den Schnittstellenverträgen; bewusst geplante Negativ- und Sicherheitstests; synthetische Testdaten; sowie reproduzierbare, in CI und Sandbox lauffähige Nachweise. Nutze `InventarWorkerService` nur als C#-Referenz.

**EN:** Prepare a focused specification for the test strategy of the Secure ServiceHarvester for the AE - Application Development specialization. Consider: a test pyramid of many fast unit tests, targeted integration tests, and contract tests at the interface contracts; deliberately planned negative and security tests; synthetic test data; and reproducible evidence runnable in CI and sandbox. Use `InventarWorkerService` only as a C# reference.

## Anforderungen / Requirements

- **R-01:** Jede Testart (Unit, Integration, Contract) ist mit Zweck und Abgrenzung beschrieben.
- **R-02:** Negativ- und Sicherheitstests sind bewusst eingeplant, nicht nur Erfolgsfälle.
- **R-03:** Contract-Tests sichern die Schnittstellenverträge gegen unbemerkte Vertragsbrüche ab.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Tests sind reproduzierbar, verwenden nur synthetische Daten und laufen in CI/Sandbox.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Testdaten bleiben synthetisch.
- Testeingaben, Fixtures, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Sicherheitsrelevantes Verhalten (Validierung, Fehlerpfade, Auth) mit eigenen Negativtests belegen.
- Positive Qualitäts- oder Sicherheitsaussagen nur mit Testnachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Teststrategie bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Test-Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Negativ-, Grenz- oder Sicherheitstests.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Test-, Sicherheits-, CI- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Testpyramiden-Übersicht, Testfall-Matrix (positiv/negativ), Contract-Testliste, CI-Nachweisnotiz.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung AE ist klar sichtbar.
- [ ] Unit-, Integrations- und Contract-Tests sind mit Zweck getrennt sichtbar.
- [ ] Mindestens ein Negativ- und ein Contract-Test sind benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Teststrategie aus Unit-, Integrations- und Contract-Tests der EuFPA-Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
