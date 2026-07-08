# Lastenheft: Secure OrderDesk Application Track 05 - Viewer- oder Client-Oberfläche

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Eine barrierefreie Viewer- oder Client-Oberfläche zeigt Kunden, Produkte und Bestellungen der Handelsplattform. Lernende gestalten eine wartbare Oberfläche (CLI oder minimaler Web-Viewer), sichern Ausgaben durch Encoding und stellen Tastaturbedienbarkeit sowie Screenreader-Tauglichkeit her; angezeigte Bestelldaten (inkl. `ALFKI`) bleiben fiktiv.

**EN:** An accessible viewer or client interface displays customers, products, and orders of the trading platform. Learners design a maintainable interface (CLI or minimal web viewer), secure outputs through encoding, and ensure keyboard operability and screen reader support; displayed order data (incl. `ALFKI`) stays fictional.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Oberflächenstruktur ist wartbar, sicher und barrierefrei? |
| SI | mittel | Welche Betriebs- oder Auslieferungsannahme hat der Viewer/Client? |
| DPA | mittel | Welche Bestelldaten werden angezeigt und welche Aussagegrenze ist sichtbar zu machen? |
| DV | mittel | Über welche Schnittstelle bezieht der Client die Daten der Bestellplattform? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Gestaltung und Entwicklung barrierefreier Benutzerschnittstellen mit Schutzbedarf und sicherer Ausgabe.

**EN:** The task supports the AE specialization in year 3. It connects designing and developing accessible user interfaces with protection need and secure output.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Application Track trägt **LF 10a, LF 11a, LF 12a** (berührt LF 4, LF 5). Für diese Einheit ist **LF 10a („Benutzerschnittstellen gestalten und entwickeln")** primär; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Application Track carries **LF 10a, LF 11a, LF 12a** (touches LF 4, LF 5). For this unit **LF 10a ("Benutzerschnittstellen gestalten und entwickeln")** is primary; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, sichere Architektur, Barrierefreiheit, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Barrierefreiheits- und Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Entwirf eine Viewer- oder Client-Oberfläche für Kunden, Produkte und Bestellungen der Handelsplattform. Berücksichtige: klare Informationsstruktur (z. B. Bestellliste mit Master-Detail zu Positionen), Tastaturbedienbarkeit, Screenreader- und Braille-Tauglichkeit, keine reine Farbcodierung von Bestellzuständen, Output-Encoding gegen XSS bei einem Web-Viewer, Behandlung angezeigter Daten als nicht vertrauenswürdig und eine begründete Wahl zwischen CLI und Web-Viewer. Trenne Gestaltung, Sicherheitsbezug und Nachweis.

**EN:** Design a viewer or client interface for customers, products, and orders of the trading platform. Consider: clear information structure (e.g. order list with master-detail to order lines), keyboard operability, screen reader and Braille support, no color-only coding of order states, output encoding against XSS in a web viewer, treating displayed data as untrusted, and a justified choice between CLI and web viewer. Separate design, security aspect, and evidence.

## Anforderungen / Requirements

- **R-01:** Die Oberflächenstruktur und die Wahl CLI gegenüber Web-Viewer sind klar beschrieben und begründet.
- **R-02:** Sicherheits-, Datenschutz-, Barrierefreiheits- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Barrierefreiheit (Tastatur, Screenreader, keine reine Farbe) und Output-Encoding sind als Nachweispfad benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Der Anzeige- und Bezugsvertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle angezeigten Bestelldaten sind fiktiv.
- Angezeigte Kunden- und Bestelldaten als nicht vertrauenswürdig behandeln und vor der Ausgabe kontextgerecht encodieren (XSS-Abwehr im Web-Viewer).
- Fehleranzeigen dürfen keine internen Zustände, Stack-Traces, SQL-Texte oder Verbindungszeichenketten preisgeben.
- Nur benötigte Kundenfelder anzeigen (Datenminimierung); nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Anzeige- und Datenbezugsvertrag bleibt für alle Zielsprachen vergleichbar.
- Sprachspezifische UI- oder CLI-Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung von Output-Encoding, Fehlerdarstellung und Barrierefreiheit.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Viewer- oder Client-Oberfläche.
- `plan.md` mit Gestaltungs-, Sicherheits-, Barrierefreiheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Oberflächen-Struktur, CLI/Web-Trade-off, Barrierefreiheits-Checkpunkte, Output-Encoding-Regel, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Oberfläche ist wartbar, sicher und barrierefrei (WCAG 2.2 AA) gestaltet.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Barrierefreiheit und Output-Encoding haben je einen Nachweispfad.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine barrierefreie Viewer- oder Client-Oberfläche für Kunden, Produkte und Bestellungen (Kundenfirma Secure Trader, Northwind-Basis inkl. ALFKI) im Application Track der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
