# Lastenheft: Secure ServiceHarvester Digital Networking Track 06 - Verfügbarkeit, Timeouts und Wiederholstrategien

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Referenz / Reference:** C#-Referenz `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Verfügbarkeitsziele, Timeouts, Wiederholstrategien, Backoff, Idempotenz und Nachweispfade für die verteilte Sammlung werden getrennt festgelegt.

**EN:** Learners separately define availability targets, timeouts, retry strategies, backoff, idempotency, and evidence paths for the distributed collection.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | hoch | Welche Timeout-, Wiederhol- und Verfügbarkeitsentscheidung schützt die verteilte Sammlung? |
| SI | mittel bis hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| AE | mittel | Welche Implementierungsentscheidung folgt aus Timeout und Wiederholung? |
| DPA | mittel | Welche Datenqualität oder Aussagegrenze entsteht durch Wiederholungen und Ausfälle? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Verfügbarkeit, Timeouts und Wiederholstrategien gehören zum sicheren Betrieb vernetzter Dienste; deshalb steht der Betriebs- und Sicherheitsbezug im Vordergrund. Spec-Kit begleitet die Spezifikation und Nachweise, ersetzt aber nicht klassische Lern- und Prüfungsanteile.

**EN:** The task supports Digital Networking in year 3. Availability, timeouts, and retry strategies belong to the secure operation of networked services; therefore the operational and security relation is central. Spec Kit accompanies specification and evidence but does not replace conventional training and assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Timeouts und Wiederholungen bestimmen, wie Client-Dienst-Verbindungen unter Last und Störung sicher weiterlaufen. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: timeouts and retries decide how client-service connections continue safely under load and disturbance. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Verfügbarkeit, Fail-Safe Defaults, Defense in Depth, Resilienz und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Richtlinie Secure Development Life Cycle, Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Verfügbarkeit, Timeouts und Wiederholstrategien der verteilten Sammlung. Berücksichtige Verbindungs- und Anfrage-Timeouts, Wiederholversuche mit Backoff und Jitter, Obergrenzen, Idempotenz, Circuit-Breaker-Idee, Verfügbarkeitsziele, Verhalten bei Dauerfehlern und Nachweispfade. Diese Einheit baut auf der Transportsicherheit (Einheit 05) auf und liefert die Grundlage für die verteilte Sammlung (Einheit 07).

**EN:** Prepare a specification for availability, timeouts, and retry strategies of the distributed collection. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Verbindungs-, Anfrage- und Gesamt-Timeouts sind getrennt beschrieben und begründet.
- **R-02:** Wiederholstrategie, Backoff, Jitter und eine Obergrenze der Versuche sind festgelegt.
- **R-03:** Idempotenz und der Umgang mit Dauerfehlern (z. B. Aussetzen statt endloser Wiederholung) sind benannt.
- **R-04:** Verfügbarkeitsziele und Test-, Review- oder Evidenzpfade sind dokumentiert.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Wiederholungen dürfen keine Retry-Stürme, Datenverdopplung oder Überlastung eines Zieldienstes auslösen.
- Timeouts müssen gesetzt sein; unbegrenztes Warten ist ein Verfügbarkeits- und Sicherheitsrisiko.
- Fehlermeldungen dürfen keine internen Zustände, Endpunkte oder Secrets preisgeben.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag von Timeout, Backoff und Idempotenz bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Resilienz- oder HTTP-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Verfügbarkeits-, Timeout-, Wiederhol- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Timeout-Matrix, Wiederhol- und Backoff-Regeln, Idempotenz-Notiz, Verfügbarkeitsziel, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Timeout-, Wiederhol- und Verfügbarkeitsentscheidungen sind getrennt sichtbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad für Timeout und Wiederholung ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Verfügbarkeit, Timeouts und Wiederholstrategien der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
