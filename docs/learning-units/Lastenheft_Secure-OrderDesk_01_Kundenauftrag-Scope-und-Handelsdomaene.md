# Lastenheft: Secure OrderDesk 01 - Kundenauftrag, Scope und Handelsdomäne

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Lernende können den Kundenauftrag der Handelsfirma Secure Trader verstehen, den fachlichen Scope einer
Bestell-/Handelsplattform begrenzen und erste Datenschutz- und Sicherheitsannahmen zu Kunden- und Bestelldaten
dokumentieren. Sie ordnen die Northwind-Datenbasis (inkl. `ALFKI`) als verbindliche Quelle ein.

**EN:** Learners can understand the customer task of the trading company Secure Trader, limit the functional
scope of an ordering/trading platform, and document first privacy and security assumptions about customer and
order data. They classify the Northwind data base (incl. `ALFKI`) as the binding source.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche spätere Implementierungsentscheidung hängt vom abgegrenzten Scope ab? |
| DPA | hoch | Welche Kunden- und Bestelldaten dürfen für spätere Auswertungen genutzt werden, ohne unnötige personenbezogene Daten zu verarbeiten? |
| SI | mittel bis hoch | Welche Betriebs-, Datenbank- oder Sandbox-Annahme muss früh dokumentiert werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Kundenorientierung, Projektabgrenzung, Schutzbedarf, Datenschutz und
dokumentierte Arbeitsplanung im Handelskontext.

**EN:** The task supports customer orientation, scope definition, protection needs, privacy, and documented
work planning in a trading context.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"), LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"), LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Anforderungen, Datenschutz, N/A-Begründung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Kompetenzprofile und Schulungsplan, Datenschutzleitlinie.
- **Presets:** security-governance, a11y-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe den Kundenauftrag der Handelsfirma Secure Trader für EuFPA. Lege fest, welche Funktionen die
Bestell-/Handelsplattform Secure OrderDesk in dieser Lernreihe behandeln soll (z. B. Kunden, Produkte,
Bestellungen und Bestellpositionen im Northwind-Layout) und welche bewusst außerhalb des Scopes bleiben.
Erfasse die Rollen `learner`, `developer` und `reviewer` als fachliche Rollen, noch nicht als fertiges
Authentifizierungssystem. Halte den Umfang im 1. Lehrjahr bewusst einfach; die verbindliche Datenbasis ist die
klassische Northwind-Sample-DB inklusive Pflicht-Datensatz `ALFKI`.

**EN:** Describe the customer task of the trading company Secure Trader for EuFPA. Define which functions the
Secure OrderDesk ordering/trading platform covers in this learning series (e.g. customers, products, orders,
and order lines in Northwind layout) and which stay intentionally out of scope. Capture `learner`,
`developer`, and `reviewer` as business roles, not yet as a finished authentication system. Keep the scope
deliberately simple in year 1; the binding data base is the classic Northwind sample database including the
mandatory record `ALFKI`.

## Anforderungen / Requirements

- **R-01:** Der Kundenauftrag und der fachliche Umfang sind klar beschrieben; In-Scope und Out-of-Scope sind getrennt.
- **R-02:** Die Rollen `learner`, `developer` und `reviewer` sind fachlich erklärt, ohne fertiges Authentifizierungssystem.
- **R-03:** Datenschutz-, Sicherheits- und Betriebsannahmen zu Kunden- und Bestelldaten sind getrennt dokumentiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder kurzer Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; die Northwind-Daten und alle Erweiterungen sind fiktiv.
- Datenarten benennen (z. B. Firmenname, Kontaktname, Anschrift, Bestell- und Positionsdaten) und je Datenart den Zweck beschreiben.
- Datenminimierung als frühes Akzeptanzkriterium festlegen; nur benötigte Kunden-/Bestellfelder in den Scope nehmen.
- Risiken aus unklarem Scope als offene Punkte notieren; positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren (z. B. Authentifizierung, Zahlungsabwicklung, Cloud-Betrieb, solange nur das Lernprojekt geschnitten wird).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt unabhängig von Programmiersprache und UI-Form; keine Festlegung auf CLI, API oder GUI.
- Das relationale Northwind-Layout (Kunden, Produkte, Bestellungen, Positionen) bleibt für alle Sprachpfade gleich; die Datenzugriffstechnik ist noch nicht festzulegen.
- C#, Go, Java, Python, Rust und Swift werden nur als spätere Zielsprachen benannt; sprachspezifische Frameworks, ORM/Datenbanktreiber und Testwerkzeuge sind noch nicht festzulegen.
- Löst eine Sprache besondere Plattformannahmen aus, wird dies als `Open` für spätere Aufgaben notiert.

## Erwartete Artefakte / Expected Artifacts

- Kundenauftrag der Firma Secure Trader in kurzer, verständlicher Form.
- In-Scope-/Out-of-Scope-Liste und fachliche Rollenbeschreibung.
- benannte Kunden- und Bestell-Datenarten mit Zweck sowie Verweis auf die Northwind-Datenbasis (inkl. `ALFKI`).
- erste Akzeptanzkriterien, erste Datenschutz- und Sicherheitsnotiz sowie dokumentierte offene Punkte mit Owner oder Folgeaufgabe und begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Der Kundenauftrag ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] In-Scope und Out-of-Scope sind getrennt beschrieben; jede Rolle ist fachlich erklärt.
- [ ] Die Northwind-Datenbasis inkl. Pflicht-Datensatz `ALFKI` ist als Quelle benannt.
- [ ] Mindestens eine Datenschutzannahme und eine Sicherheitsannahme zu Kunden-/Bestelldaten sind dokumentiert.
- [ ] Ein Review-Pfad ist benannt (Scope und Nicht-Ziele eindeutig, keine echten Daten genannt).
- [ ] Offene Punkte sind als `Open` mit Owner oder Folgeaufgabe notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Kundenauftrag, Scope, Rollen, Akzeptanzkriterien und erste Datenschutz-/Sicherheitsannahmen der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
