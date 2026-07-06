# Lastenheft: Secure ServiceHarvester Digital Networking Track 09 - Ausfallszenarien und Resilienz

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

**DE:** Ausfallszenarien, Netzpartitionen, degradierter Betrieb, Failover, Wiederanlauf, Blast-Radius und Resilienzentscheidungen werden bewertet und mit Nachweisen belegt.

**EN:** Learners assess and evidence failure scenarios, network partitions, degraded operation, failover, recovery, blast radius, and resilience decisions.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | hoch | Welches Ausfallszenario und welche Resilienzentscheidung schützen die verteilte Sammlung? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| AE | mittel bis hoch | Welche Implementierungsentscheidung folgt aus Failover und degradiertem Betrieb? |
| DPA | mittel | Welche Datenqualität oder Aussagegrenze entsteht im degradierten Betrieb? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Ausfallszenarien und Resilienz gehören zum sicheren Betrieb vernetzter Systeme; deshalb steht der Betriebs- und Sicherheitsbezug im Vordergrund. Spec-Kit begleitet die Spezifikation und Nachweise, ersetzt aber nicht klassische Lern- und Prüfungsanteile.

**EN:** The task supports Digital Networking in year 3. Failure scenarios and resilience belong to the secure operation of networked systems; therefore the operational and security relation is central. Spec Kit accompanies specification and evidence but does not replace conventional training and assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Resilienz entscheidet, wie Clients und Dienste bei Störung, Partition oder Ausfall sicher weiterlaufen. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: resilience decides how clients and services continue safely under disturbance, partition, or outage. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Defense in Depth, Fail-Safe Defaults, Resilienz, Angriffsflächenreduktion und Review-Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Richtlinie Secure Development Life Cycle, Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Ausfallszenarien und Resilienz. Berücksichtige Ausfall einzelner Agenten, Netzpartition, Ausfall des zentralen Dienstes, degradierten Betrieb, Failover, Wiederanlauf, Blast-Radius, Restrisiken und Nachweispfade. Diese Einheit baut auf Betriebs- und Netznachweisen (Einheit 08) auf und liefert die Grundlage für das Netz-Review und den Abschluss (Einheit 10).

**EN:** Prepare a specification for failure scenarios and resilience. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Die wichtigsten Ausfallszenarien (Agent, Netz, zentraler Dienst) sind benannt.
- **R-02:** Degradierter Betrieb, Failover und Wiederanlauf sind nachvollziehbar beschrieben.
- **R-03:** Blast-Radius und Gegenmaßnahmen je Szenario sind sichtbar.
- **R-04:** Restrisiken, Test-, Review- oder Evidenzpfade sind benannt.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten und keine ausnutzbaren Betriebsdetails dokumentieren.
- Degradierter Betrieb muss in einen sicheren Zustand fallen (Fail-Safe), nicht in einen offenen.
- Restrisiken nicht als behoben darstellen.
- Ausfallszenarien didaktisch beschreiben, nicht als Angriffsanleitung ausformulieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Failover- und Wiederanlauf-Logik bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Resilienz- oder Supervisor-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Resilienz-, Failover- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Ausfallszenario-Tabelle, Degradations-/Failover-Notiz, Blast-Radius-Skizze, Restrisikoliste, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Ausfallszenario, Resilienzentscheidung und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Der degradierte Betrieb fällt nachweislich in einen sicheren Zustand.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Ausfallszenarien und Resilienz der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
