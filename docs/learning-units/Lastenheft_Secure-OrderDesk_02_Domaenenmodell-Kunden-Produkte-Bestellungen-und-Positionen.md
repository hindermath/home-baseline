# Lastenheft: Secure OrderDesk 02 - Domänenmodell: Kunden, Produkte, Bestellungen und Positionen

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

**DE:** Lernende können ein kleines relationales Domänenmodell aus Kunden, Produkten, Bestellungen und
Bestellpositionen sicher beschreiben. Sie unterscheiden Stammdaten (Kunden, Produkte, Kategorien, Lieferanten,
Versender) von Bewegungsdaten (Bestellungen und Positionen), erkennen das Master-Detail-Muster zwischen
Bestellung und Position und definieren erlaubte Bestellzustände sowie ungültige Zustandswechsel als Risiko. Die
verbindliche Datenbasis ist die klassische Northwind-Sample-DB inkl. `ALFKI`.

**EN:** Learners can securely describe a small relational domain model of customers, products, orders, and order
lines. They distinguish master data (customers, products, categories, suppliers, shippers) from transactional
data (orders and order lines), recognize the master-detail pattern between order and order line, and define
allowed order states and invalid state transitions as a risk. The binding data base is the classic Northwind
sample database incl. `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Beziehungs- oder Zustandsregel gehört ins Domänenmodell und nicht erst in die Oberfläche? |
| DPA | hoch | Welche Kunden- und Bestelldatenqualität brauchst du für spätere Auswertungen, ohne unnötige personenbezogene Felder zu speichern? |
| SI | mittel bis hoch | Welche relationalen Integritätsregeln (Fremdschlüssel, Pflichtfelder) müssen früh feststehen, damit die Datenbasis konsistent bleibt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, relationale Modellierung, Anwendungslogik, Informationssicherheit
und nachvollziehbare Dokumentation auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects data management, relational modeling, application logic, information security, and
traceable documentation at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):
**primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen
Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen:
`lernbegleiter/Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk
Base"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 4 ("Schutzbedarfsanalyse im
eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions:
`lernbegleiter/Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Code-Erzeugung, Datenschutz durch Datenminimierung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Architektur- und Modellentscheidungen, Datenschutz- und Nachweisdokumente nach Bedarf.
- **Presets:** architecture-governance, isaqb-architecture-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Definiere die Entitäten des Northwind-Kernlayouts für Secure OrderDesk: `Customer` (Stammdaten: z. B.
`CustomerID`, `CompanyName`, `ContactName`, `City`, `Country`), `Product` (z. B. `ProductID`, `ProductName`,
`SupplierID`, `CategoryID`, `UnitPrice`), `Order` (Bestellkopf: z. B. `OrderID`, `CustomerID`, `EmployeeID`,
`OrderDate`, `ShipVia`) und `OrderLine` (Bestellposition, entspricht `Order Details`: `OrderID`, `ProductID`,
`UnitPrice`, `Quantity`, `Discount`). Lege Pflichtfelder, optionale Felder, Primär- und Fremdschlüssel sowie
erlaubte Bestellzustände fest. Beispiel-Bestellzustände sind `new`, `confirmed`, `shipped` und `cancelled`.
Beschreibe das Master-Detail-Muster zwischen `Order` und ihren `OrderLine`-Einträgen sowie die
Fremdschlüsselbeziehungen zu `Customer` und `Product`. Der Pflicht-Datensatz `ALFKI` dient als fester Anker für
Beispiele. Halte das Modell im 1. Lehrjahr bewusst klein.

**EN:** Define the entities of the Northwind core layout for Secure OrderDesk: `Customer` (master data: e.g.
`CustomerID`, `CompanyName`, `ContactName`, `City`, `Country`), `Product` (e.g. `ProductID`, `ProductName`,
`SupplierID`, `CategoryID`, `UnitPrice`), `Order` (order header: e.g. `OrderID`, `CustomerID`, `EmployeeID`,
`OrderDate`, `ShipVia`), and `OrderLine` (order line, equivalent to `Order Details`: `OrderID`, `ProductID`,
`UnitPrice`, `Quantity`, `Discount`). Define mandatory fields, optional fields, primary and foreign keys, and
allowed order states. Example order states are `new`, `confirmed`, `shipped`, and `cancelled`. Describe the
master-detail pattern between `Order` and its `OrderLine` entries and the foreign-key relationships to
`Customer` and `Product`. The mandatory record `ALFKI` serves as a fixed anchor for examples. Keep the model
deliberately small in year 1.

## Anforderungen / Requirements

- **R-01:** Jede Entität (`Customer`, `Product`, `Order`, `OrderLine`) hat einen klaren Zweck, Pflichtfelder und optionale Felder.
- **R-02:** Primärschlüssel und Fremdschlüsselbeziehungen (`Order` → `Customer`, `OrderLine` → `Order`, `OrderLine` → `Product`) sind vollständig beschrieben.
- **R-03:** Erlaubte Bestellzustände und ihre Übergänge sind als Matrix oder Liste beschrieben; verbotene Zustandswechsel sind ausdrücklich genannt und begründet.
- **R-04:** Das Master-Detail-Verhältnis (`Order` zu `OrderLine`) und die Trennung von Stamm- und Bewegungsdaten sind dokumentiert; die Northwind-Basis inkl. `ALFKI` ist als Quelle benannt.
- **R-05:** Das Modell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar; alle `Applicable`, `N/A` und `Open` Punkte tragen Begründung oder Evidenzpfad.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Zustands- oder Bestandsänderung darf allein durch einen ungeprüften Eingabewert (z. B. Menge, Rabatt) erfolgen; Regeln liegen im Modell.
- Interne IDs (`CustomerID`, `OrderID`) bleiben technisch und enthalten keine zusätzlichen personenbezogenen Informationen über die Northwind-Felder hinaus.
- Nur benötigte Kundenfelder werden geführt (Datenminimierung); keine Zahlungsdaten, keine Lohn-/Personaldaten der Mitarbeitenden, keine über den Bestellzweck hinausgehenden Kontaktdaten.
- Stammdaten und Bewegungsdaten werden getrennt beschrieben; keine echten personenbezogenen Daten, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`. `ALFKI` und alle Erweiterungen sind fiktiv.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle Zielsprachen verwenden dieselben Entitäten, Felder, Schlüssel und Zustandsregeln im Northwind-Layout.
- Sprachspezifische Typen (Records, Structs, Dataclasses, Enums) sind erlaubt, ändern aber nicht den fachlichen Vertrag; die Datenzugriffstechnik (ORM, SQL-Treiber) ist noch nicht festzulegen.
- Fehlerfälle (z. B. Position ohne gültige Bestellung, unbekannte `ProductID`, negative Menge) müssen modelliert werden, nicht nur Erfolgspfade; MSL-Status ersetzt keine Modell- und Datenschutzprüfung.

## Erwartete Artefakte / Expected Artifacts

- Entitätenliste mit Feldern, Pflicht-/Optional-Kennzeichnung sowie Primär- und Fremdschlüsseln für `Customer`, `Product`, `Order` und `OrderLine`.
- Beziehungsübersicht (Master-Detail und Fremdschlüssel) mit Verweis auf die Northwind-Datenbasis inkl. `ALFKI`.
- Zustandsdiagramm oder tabellarische Zustandsmatrix für die Bestellzustände.
- Liste ungültiger Zustands- und Beziehungsverletzungen mit kurzer Begründung.
- erste Modell-Testideen für erlaubte und verbotene Übergänge sowie referenzielle Integrität.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Jede Entität hat Zweck, Pflichtfelder, optionale Felder und benannte Schlüssel.
- [ ] Master-Detail (`Order`/`OrderLine`) und die Fremdschlüssel zu `Customer` und `Product` sind nachvollziehbar dokumentiert.
- [ ] Jeder erlaubte Bestellzustand ist erklärt; verbotene Zustandswechsel sind ausdrücklich genannt.
- [ ] Das Modell speichert keine unnötigen personenbezogenen Daten.
- [ ] Die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für das sprachneutrale relationale Domänenmodell aus Kunden, Produkten, Bestellungen und Bestellpositionen im Northwind-Layout (Kundenfirma Secure Trader, Pflicht-Datensatz ALFKI), inklusive Primär- und Fremdschlüsseln, Master-Detail-Muster, erlaubten und verbotenen Bestellzuständen sowie Datenminimierung. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
