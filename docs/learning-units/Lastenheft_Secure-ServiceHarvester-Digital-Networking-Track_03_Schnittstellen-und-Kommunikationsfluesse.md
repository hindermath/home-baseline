# Lastenheft: Secure ServiceHarvester Digital Networking Track 03 - Schnittstellen und Kommunikationsflüsse

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Primär geeignet für / Primary fit:** DV (Schwerpunkt); berührt AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Die Schnittstellen und Kommunikationsflüsse des verteilten Sammelns werden vollständig beschrieben: Quelle, Ziel, Richtung, Zweck, Datenklasse, Protokoll und Port je Verbindung. Lernende erstellen eine Kommunikationsmatrix, die erlaubte und verbotene Pfade nach dem Prinzip *deny by default* trennt.

**EN:** The interfaces and communication flows of distributed collection are fully described: source, target, direction, purpose, data class, protocol, and port per connection. Learners build a communication matrix that separates allowed and forbidden paths using *deny by default*.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welche Kommunikationsrichtung entscheidet über die spätere Segment- oder Firewall-Regel? |
| AE | hoch | Welcher Schnittstellenvertrag (Pull/Push, Format) folgt aus dem Kommunikationsfluss? |
| SI | hoch | Welche Port-/Protokollannahme muss dokumentiert und als Betriebsnachweis geprüft werden? |
| DPA | mittel bis hoch | Welche Datenklasse verlangt einen verschlüsselten oder engeren Pfad? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet die Entwicklung cyber-physischer Systeme, die Netzeinbindung von Clients, sichere Architektur und Angriffsflächenreduktion. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10d („Cyber-physische Systeme entwickeln")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10d ("Cyber-physische Systeme entwickeln")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Trust Boundaries, Angriffsfläche reduzieren, sichere Konfiguration, sichere Schnittstellenverträge und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Schnittstellen und Kommunikationsflüsse eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: alle Schnittstellen (z. B. Agent-Push oder Sammler-Pull, API, Nachrichtenkanal), je Verbindung Quelle, Ziel, Richtung, Zweck, Datenklasse, Protokoll und Port, verbotene Verbindungen als Nicht-Ziele sowie eine Kommunikationsmatrix. Baue auf dem Systemkontext aus Einheit 02 auf.

**EN:** Prepare a focused specification for the interfaces and communication flows for the Digital Networking specialization. Consider all interfaces (e.g. agent push or collector pull, API, message channel), source, target, direction, purpose, data class, protocol, and port per connection, forbidden connections as non-goals, and a communication matrix. Build on the system context from unit 02.

## Anforderungen / Requirements

- **R-01:** Jede Schnittstelle ist mit Quelle, Ziel, Richtung, Zweck und Datenklasse beschrieben.
- **R-02:** Erlaubte und verbotene Kommunikationsflüsse sind getrennt und als Matrix dokumentiert.
- **R-03:** Ports, Protokolle und unsichere Annahmen sind benannt; Unsicheres ist als `Open` markiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Schnittstellen, Protokolle, Ports, Nachrichtenkanäle und Logs als mögliche Vertrauensgrenzen prüfen.
- Sensible Datenklassen dürfen nicht unverschlüsselt übertragen werden; jede Aussage braucht einen Nachweis.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Schnittstellenvertrag (Richtung, Format, Datenklasse) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische HTTP-, gRPC- oder Messaging-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Schnittstellenliste, Kommunikationsmatrix (Quelle/Ziel/Richtung/Datenklasse/Protokoll/Status), Nicht-Ziele der Kommunikation, Liste offener Protokollannahmen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Kommunikationsmatrix trennt erlaubte und verbotene Pfade (deny by default).
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Schnittstellen und Kommunikationsflüsse der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
