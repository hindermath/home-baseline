# Lastenheft: Secure ServiceHarvester Digital Networking Track 08 - Betriebs- und Netznachweise

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

**DE:** Betriebs- und Netznachweise wie Erreichbarkeit, Health, Metriken, Logs und Verbindungsproben werden geplant, dokumentiert und gegen ihre Aussagegrenzen abgegrenzt.

**EN:** Learners plan, document, and bound operational and network evidence such as reachability, health, metrics, logs, and connectivity probes against their interpretation limits.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | hoch | Welcher Netz- oder Betriebsnachweis belegt, dass die verteilte Sammlung erreichbar und gesund ist? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität oder Aussagegrenze hat ein Nachweis? |
| AE | mittel | Welche Implementierungsentscheidung folgt aus Health- und Metrik-Nachweisen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Betriebs- und Netznachweise gehören zum sicheren Betrieb vernetzter Systeme; deshalb steht der Betriebs- und Sicherheitsbezug im Vordergrund. Spec-Kit begleitet die Spezifikation und Nachweise, ersetzt aber nicht klassische Lern- und Prüfungsanteile.

**EN:** The task supports Digital Networking in year 3. Operational and network evidence belongs to the secure operation of networked systems; therefore the operational and security relation is central. Spec Kit accompanies specification and evidence but does not replace conventional training and assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: erreichbare, gesunde und nachweisbare Dienste sind Kern des sicheren Betriebs vernetzter Systeme. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: reachable, healthy, and provable services are core to the secure operation of networked systems. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Nachvollziehbarkeit, auditfähige Evidenz, sichere Protokollierung, Datenschutz und Betrieb.
- **Checklisten:** CL_01, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Testmanagement, Datenschutzleitlinie, Richtlinie Secure Development Life Cycle.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Betriebs- und Netznachweise. Berücksichtige Health-Checks, Erreichbarkeits- und Verbindungsproben, Metriken, Logs, Korrelation über Agenten hinweg, Aufbewahrung, Zugriff, Datenschutzgrenzen und die Aussagegrenzen jedes Nachweises. Diese Einheit baut auf der Agentenkommunikation (Einheit 07) auf und liefert die Grundlage für Ausfallszenarien und Resilienz (Einheit 09).

**EN:** Prepare a specification for operational and network evidence. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Health-, Erreichbarkeits- und Verbindungsnachweise sind getrennt beschrieben.
- **R-02:** Metriken, Logs und Korrelation über Agenten hinweg sind dokumentiert.
- **R-03:** Zweck, Zugriff, Aufbewahrung und Datenschutzgrenzen sind sichtbar.
- **R-04:** Zu jedem Nachweis ist die Aussagegrenze benannt (was er nicht belegt).
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Keine Secrets, Tokens, vollständigen Pfade oder unnötigen personenbezogenen Daten protokollieren.
- Nachweise dürfen keine ausnutzbaren Netz- oder Betriebsdetails offenlegen.
- Aus einem Nachweis darf keine stärkere Aussage abgeleitet werden, als seine Datenqualität trägt.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Health-, Metrik- und Log-Struktur bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Observability- oder Logging-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Nachweis-, Datenschutz- und Evidenzpfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Nachweismatrix, Health-/Probe-Liste, Log-Datenschutzregeln, Aussagegrenzen, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Betriebsnachweis, Datenschutzgrenze und Aussagegrenze sind getrennt sichtbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Zu jedem Nachweis ist benannt, was er belegt und was nicht.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Betriebs- und Netznachweise der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
