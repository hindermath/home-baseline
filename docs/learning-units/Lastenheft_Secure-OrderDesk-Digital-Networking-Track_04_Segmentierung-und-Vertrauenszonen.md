# Lastenheft: Secure OrderDesk Digital Networking Track 04 - Segmentierung und Vertrauenszonen

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

**DE:** Das Netz der Bestell-Pipeline wird in Vertrauenszonen und Segmente geteilt. Lernende leiten aus der Kommunikationsmatrix Segmentgrenzen ab, setzen *deny by default* und *least privilege* zwischen den Segmenten um und begründen Choke Points, über die kontrollierter Verkehr fließt.

**EN:** The order-pipeline network is divided into trust zones and segments. Learners derive segment boundaries from the communication matrix, apply *deny by default* and *least privilege* between segments, and justify choke points through which controlled traffic flows.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welche Segmentgrenze schützt den kritischsten Netzbezug der Bestell-Pipeline am wirksamsten? |
| SI | hoch | Welche Segment- oder Firewall-Regel muss als Betriebsnachweis geprüft werden? |
| AE | mittel | Welche Schnittstelle muss über einen definierten Choke Point statt direkt sprechen? |
| DPA | mittel bis hoch | Welche Datenklasse (z. B. personenbezogene Kundendaten) verlangt ein eigenes, engeres Segment? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet den sicheren Betrieb vernetzter Systeme, die Bereitstellung von Netzwerken und Diensten, sichere Architektur und Angriffsflächenreduktion. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen") und LF 3 („Clients in Netzwerke einbinden"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen") and LF 3 ("Clients in Netzwerke einbinden"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Trust Boundaries, Defense in Depth, Least Privilege, Fail-Safe Defaults und Angriffsfläche reduzieren.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Segmentierung und Vertrauenszonen eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: Vertrauenszonen (z. B. Bestell-Clients, Bestellannahme, Katalog, relationale Ablage, Auswertung), Segmentgrenzen aus der Kommunikationsmatrix, deny-by-default-Regeln, least privilege zwischen Segmenten, Choke Points und die Zuordnung von Datenklassen zu Segmenten. Baue auf den Kommunikationsflüssen aus Einheit 03 auf.

**EN:** Prepare a focused specification for segmentation and trust zones for the Digital Networking specialization. Consider trust zones (e.g. order clients, order intake, catalog, relational store, analytics), segment boundaries from the communication matrix, deny-by-default rules, least privilege between segments, choke points, and the mapping of data classes to segments. Build on the communication flows from unit 03.

## Anforderungen / Requirements

- **R-01:** Vertrauenszonen und Segmente sind benannt und mit ihren Assets beschrieben.
- **R-02:** Segmentgrenzen mit deny-by-default- und least-privilege-Regeln sind dokumentiert.
- **R-03:** Choke Points und die Datenklassen je Segment sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; nur fiktive Northwind-Daten wie `ALFKI`; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Segmentgrenzen, Regeln, Choke Points, Konfiguration und Logs als mögliche Vertrauensgrenzen prüfen.
- Jede Segmentregel folgt deny by default; positive Aussagen nur mit Nachweis.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Segment- und Zonenmodell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische oder plattformspezifische Firewall-/Netzwerkwerkzeuge dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Zonen-/Segment-Liste, Segmentregel-Tabelle (Quelle-Segment/Ziel-Segment/erlaubt-verboten), Choke-Point-Liste, Datenklasse-je-Segment-Zuordnung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Jede Segmentregel ist auf deny by default und least privilege prüfbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Segmentierung und Vertrauenszonen der EuFPA-Lernreihe Secure OrderDesk Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
