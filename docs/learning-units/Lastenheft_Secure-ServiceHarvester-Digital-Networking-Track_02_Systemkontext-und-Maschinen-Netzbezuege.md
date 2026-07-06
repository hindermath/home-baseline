# Lastenheft: Secure ServiceHarvester Digital Networking Track 02 - Systemkontext und Maschinen-/Netzbezüge

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Primär geeignet für / Primary fit:** DV (Schwerpunkt); berührt SI, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Der Systemkontext des verteilten Sammelns wird abgegrenzt: beteiligte Systeme, Benutzergruppen, Knoten, Sammel-Agenten auf den Zielmaschinen, Subnetze, externe Systeme und die Datenklassen an jedem Netzbezug. Lernende benennen, wo Daten die Vertrauenszone wechseln.

**EN:** The system context of distributed collection is defined: involved systems, user groups, nodes, collection agents on target machines, subnets, external systems, and the data classes at each network relation. Learners name where data crosses the trust zone.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welcher Knoten ist am stärksten exponiert und welcher Netzbezug ist am kritischsten? |
| SI | hoch | Welche Maschinen-, Subnetz- oder Betriebsannahme muss dokumentiert und nachgewiesen werden? |
| AE | mittel bis hoch | Welche Schnittstelle folgt aus einem benannten Netzbezug? |
| DPA | mittel bis hoch | Welche Datenklasse fließt über welchen Netzbezug und wie wird sie geschützt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet die Entwicklung cyber-physischer Systeme, die Netzeinbindung von Clients, sichere Architektur und Datenschutz. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10d („Cyber-physische Systeme entwickeln")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10d ("Cyber-physische Systeme entwickeln")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Trust Boundaries, Angriffsfläche reduzieren, Datenschutz und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Systemkontext eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: beteiligte Systeme, Benutzergruppen und Rollen, Knoten und Sammel-Agenten, Subnetze und Netzbezüge, externe Systeme, die Datenklassen je Netzbezug und erste Vertrauensgrenzen. Baue auf dem Netzzielbild aus Einheit 01 auf.

**EN:** Prepare a focused specification for the system context for the Digital Networking specialization. Consider involved systems, user groups and roles, nodes and collection agents, subnets and network relations, external systems, the data classes per network relation, and first trust boundaries. Build on the network target picture from unit 01.

## Anforderungen / Requirements

- **R-01:** Der Systemkontext ist mit beteiligten Systemen, Rollen und Knoten beschrieben.
- **R-02:** Maschinen-/Netzbezüge, Subnetze und Datenklassen sind getrennt dokumentiert.
- **R-03:** Erste Trust Boundaries und die exponiertesten Knoten sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Sammel-Agenten, Subnetze, Netzbezüge, Konfiguration und Logs als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Systemkontext bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Agenten- oder Discovery-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Kontextdiagramm oder Kontextliste, Knoten-/Agenten-Liste, Subnetz-/Netzbezug-Tabelle mit Datenklasse, erste Trust-Boundary-Liste.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Für jeden Netzbezug ist die Datenklasse benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen Systemkontext mit Maschinen- und Netzbezügen der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
