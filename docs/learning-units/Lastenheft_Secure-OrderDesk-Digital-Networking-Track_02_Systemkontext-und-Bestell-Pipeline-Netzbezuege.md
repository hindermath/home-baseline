# Lastenheft: Secure OrderDesk Digital Networking Track 02 - Systemkontext und Bestell-Pipeline-Netzbezüge

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Primär geeignet für / Primary fit:** DV (Schwerpunkt); berührt SI, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Der Systemkontext der Bestell-Pipeline wird abgegrenzt: beteiligte Systeme, Benutzergruppen, Knoten (Bestellannahme, Katalog, relationale Ablage, Auswertung), Subnetze, externe Systeme und die Datenklassen an jedem Netzbezug. Lernende benennen, wo Bestell- und Kundendaten die Vertrauenszone wechseln.

**EN:** The system context of the order pipeline is defined: involved systems, user groups, nodes (order intake, catalog, relational store, analytics), subnets, external systems, and the data classes at each network relation. Learners name where order and customer data cross the trust zone.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welcher Knoten ist am stärksten exponiert und welcher Netzbezug der Bestell-Pipeline ist am kritischsten? |
| SI | hoch | Welche Host-, Subnetz- oder Betriebsannahme muss dokumentiert und nachgewiesen werden? |
| AE | mittel bis hoch | Welche Schnittstelle folgt aus einem benannten Netzbezug? |
| DPA | mittel bis hoch | Welche Datenklasse (z. B. personenbezogene Kundendaten) fließt über welchen Netzbezug und wie wird sie geschützt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet die Entwicklung cyber-physischer Systeme, die Netzeinbindung von Clients, sichere Architektur und Datenschutz. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10d („Cyber-physische Systeme entwickeln")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_02_Systemkontext-und-Bestell-Pipeline-Netzbezuege.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10d ("Cyber-physische Systeme entwickeln")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_02_Systemkontext-und-Bestell-Pipeline-Netzbezuege.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Trust Boundaries, Angriffsfläche reduzieren, Datenschutz und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Systemkontext eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: beteiligte Systeme, Benutzergruppen und Rollen, Knoten (Bestellannahme, Katalog, relationale Ablage im Northwind-Schema, Auswertung), Subnetze und Netzbezüge, externe Systeme, die Datenklassen je Netzbezug (Betriebsdaten, personenbezogene Kundendaten wie `ContactName`, Secret) und erste Vertrauensgrenzen. Baue auf dem Netzzielbild aus Einheit 01 auf.

**EN:** Prepare a focused specification for the system context for the Digital Networking specialization. Consider involved systems, user groups and roles, nodes (order intake, catalog, relational store in the Northwind schema, analytics), subnets and network relations, external systems, the data classes per network relation (operational data, personal customer data such as `ContactName`, secret), and first trust boundaries. Build on the network target picture from unit 01.

## Anforderungen / Requirements

- **R-01:** Der Systemkontext ist mit beteiligten Systemen, Rollen und Knoten beschrieben.
- **R-02:** Netzbezüge der Bestell-Pipeline, Subnetze und Datenklassen sind getrennt dokumentiert.
- **R-03:** Erste Trust Boundaries und die exponiertesten Knoten sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; nur fiktive Northwind-Daten wie `ALFKI`; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Bestellannahme, Katalog, relationale Ablage, Subnetze, Netzbezüge, Konfiguration und Logs als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Systemkontext bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Dienst- oder Datenbank-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Kontextdiagramm oder Kontextliste, Knoten-Liste, Subnetz-/Netzbezug-Tabelle mit Datenklasse, erste Trust-Boundary-Liste.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Für jeden Netzbezug ist die Datenklasse benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track_02_Systemkontext-und-Bestell-Pipeline-Netzbezuege.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen Systemkontext mit Bestell-Pipeline-Netzbezügen der EuFPA-Lernreihe Secure OrderDesk Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
