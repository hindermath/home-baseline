# Lastenheft: Secure ServiceHarvester Application Track 02 - API-Erweiterung und Ressourcenmodell

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** AE - Anwendungsentwicklung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenzprojekt / C# reference project:** `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Die bestehende ServiceHarvester-API wird um Ressourcen für Maschinen und Snapshots erweitert. Lernende entwerfen ein sauberes Ressourcenmodell, wählen passende Endpunkte und Statuscodes und wahren die Rückwärtskompatibilität mit begründeten Trade-offs.

**EN:** The existing ServiceHarvester API is extended with resources for machines and snapshots. Learners design a clean resource model, choose suitable endpoints and status codes, and preserve backward compatibility with justified trade-offs.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welcher Endpunkt-, Ressourcen- und Vertragsentwurf setzt das Feature sauber um? |
| SI | mittel | Welche Betriebs- oder Deployment-Annahme folgt aus neuen Endpunkten? |
| DPA | mittel | Welche Datenfelder werden über die API sichtbar und wie ist ihre Aussagegrenze? |
| DV | mittel bis hoch | Welche Schnittstelle und welcher Kommunikationsvertrag ändern sich? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Realisierung von Funktionalität, sichere Schnittstellenverträge und die Anpassung der Datenverwaltung.

**EN:** The task supports the AE specialization in year 3. It connects realizing functionality, secure interface contracts, and adapting the data management.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Eingabevalidierung, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Schnittstellen- und Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erweitere die ServiceHarvester-API um klar geschnittene Ressourcen. Berücksichtige: Ressourcenmodell (Maschinen, Snapshots), sinnvolle Pfade und HTTP-Methoden, konsistente Statuscodes, Idempotenz lesender und wiederholbarer Aufrufe, Rückwärtskompatibilität zu bestehenden Clients und eine begründete Versionierungsstrategie. Trenne Vertrag, Sicherheitsbezug und Nachweis.

**EN:** Extend the ServiceHarvester API with clearly scoped resources. Consider: resource model (machines, snapshots), meaningful paths and HTTP methods, consistent status codes, idempotency of read and repeatable calls, backward compatibility for existing clients, and a justified versioning strategy. Separate contract, security aspect, and evidence.

## Anforderungen / Requirements

- **R-01:** Das Ressourcenmodell und die neuen Endpunkte sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Rückwärtskompatibilität und Versionierung sind mit Trade-off begründet.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Der API-Vertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Alle Eingaben an der API-Grenze als nicht vertrauenswürdig behandeln und validieren.
- Fehlerantworten dürfen keine internen Zustände, Stack-Traces oder Verbindungszeichenketten preisgeben.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der API-Vertrag (Ressourcen, Methoden, Statuscodes) bleibt für alle Zielsprachen vergleichbar.
- Sprachspezifische Web-Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Eingabevalidierung, Auth-, Output- oder Fehlerbehandlungsprüfung an der API-Grenze.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die API-Erweiterung.
- `plan.md` mit Ressourcen-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Ressourcen-/Endpunkt-Tabelle, Statuscode-Matrix, Kompatibilitäts- und Versionierungsnotiz, Validierungsregeln, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Das Ressourcenmodell und die Endpunkte sind konsistent und begründet.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Rückwärtskompatibilität und Versionierung sind mit Trade-off begründet.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine rückwärtskompatible API-Erweiterung mit sauberem Ressourcenmodell im Application Track der EuFPA-Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
