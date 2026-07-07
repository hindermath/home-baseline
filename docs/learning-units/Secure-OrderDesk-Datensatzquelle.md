# Secure OrderDesk — Datensatzquelle / Dataset Source

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Reihe / Series:** Secure OrderDesk
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Verwandtes Dokument / Related:** `Secure-Trader-Systemlandschaft.md`
- **Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zweck / Purpose

**DE:** Dieses Dokument legt verbindlich fest, aus welcher Quelle die Daten der Secure-OrderDesk-Reihe stammen
und nach welchen Regeln sie bis Juli 2026 erweitert werden. Die spätere praktische Umsetzung in sechs
Sprachpfaden nutzt denselben Datenbestand.

**EN:** This document binds the source of the Secure OrderDesk data and the rules for extending it up to July
2026. The later implementation across six language paths uses the same data set.

## Datenquelle / Data Source

**DE:** Verbindliche Grundlage ist die **klassische Northwind-Traders-Sample-Datenbank mit Layout und Daten**
— nicht nur als Inspiration, sondern als konkretes Schema und konkreter Startdatenbestand. Das Original-Schema
(Feldnamen, Datentypen, Fremdschlüssel) gilt als kanonisches Layout.

**EN:** The binding foundation is the **classic Northwind Traders sample database, with layout and data** — not
only as inspiration, but as the concrete schema and starting data. The original schema (field names, data
types, foreign keys) is the canonical layout.

## Tabellen / Tables

**DE:** Verbindliche Kern-Tabellen im Original-Layout:

| Tabelle / Table | Inhalt / Content |
|---|---|
| `Categories` | 8 Warenkategorien |
| `Customers` | Kundenstamm inkl. Pflicht-Datensatz `ALFKI` |
| `Employees` | Mitarbeitende (Start: 9) |
| `Suppliers` | Lieferanten (Start: 29) |
| `Shippers` | Versender (Start: 3) |
| `Products` | Produkte (Start: 77) |
| `Orders` | Bestellungen (Kopf) |
| `Order Details` | Bestellpositionen |

**DE:** Optional erweiterbar: `Region`, `Territories`, `EmployeeTerritories`.

**EN:** Optional extensions: `Region`, `Territories`, `EmployeeTerritories`.

## Pflicht-Datensatz ALFKI / Mandatory Record ALFKI

**DE:** Der Datensatz `ALFKI` (Alfreds Futterkiste, Kontakt Maria Anders, Berlin) **muss** enthalten und über
den gesamten Zeitraum aktiv sein. Er ist im Original vorhanden und dient als fester Anker für Beispiele,
Tests und Nachweise.

**EN:** The record `ALFKI` (Alfreds Futterkiste, contact Maria Anders, Berlin) **must** be present and active
across the whole period. It exists in the original data and serves as a fixed anchor for examples, tests, and
evidence.

## Zeitliche Erweiterung und Wachstum / Temporal Extension and Growth

**DE:** Die Original-Bestelldaten laufen nur von 1996-07 bis 1998-05. Fehlende Monate werden mit plausiblen
fiktiven Datensätzen aufgefüllt:

- **1–2 neue Kund*innen pro Monat** (fiktiv, plausibel, Northwind-Layout).
- **8–16 Bestellungen pro Monat** (inkl. `Order Details`), **verteilt über alten und neuen Kundenstamm**;
  `ALFKI` bleibt aktiv.
- Lückenlos von 1998-06 bis **einschließlich Juli 2026**.
- Konsistente Fremdschlüssel; plausible Mengen, Preise, Rabatte, Versender und Mitarbeitende.

**EN:** The original order data runs only from 1996-07 to 1998-05. Missing months are filled with plausible
fictional records: 1–2 new customers per month and 8–16 orders per month (incl. order details), spread over
old and new customers with `ALFKI` staying active, without gaps from 1998-06 up to and including July 2026,
with consistent foreign keys and plausible quantities, prices, discounts, shippers, and employees.

**DE:** Erwartetes Volumen im Vollausbau siehe `Secure-Trader-Systemlandschaft.md` (rund 2.700–5.400
Bestellungen, rund 340–680 neue Kund*innen). Die Generierung ist deterministisch skriptbar.

**EN:** Expected full-build volume: see `Secure-Trader-Systemlandschaft.md`. Generation is deterministically
scriptable.

## Format / Format

**DE:** Der Referenzdatenbestand bleibt sprachneutral, damit alle sechs MSL-Sprachen (C#, Go, Java, Python,
Rust, Swift) dieselben Daten nutzen: portables SQL-DDL für das Schema plus Seed-Daten als CSV und/oder
SQL-`INSERT`s. Das endgültige Format wird im Vollausbau festgelegt; dieser Pilot fixiert Quelle, ALFKI-Pflicht,
Wachstumsregeln und die Erweiterung bis 2026-07.

**EN:** The reference data stays language-neutral so all six MSL languages use the same data: portable SQL DDL
for the schema plus seed data as CSV and/or SQL `INSERT`s. The final format is decided in the full build; this
pilot fixes the source, the ALFKI requirement, the growth rules, and the extension up to 2026-07.

## Beispiel-Ausschnitt mit ALFKI / Sample Excerpt with ALFKI

```text
Customers (CustomerID; CompanyName; ContactName; City; Country)
ALFKI; Alfreds Futterkiste; Maria Anders; Berlin; Germany

Orders (OrderID; CustomerID; EmployeeID; OrderDate; ShipVia; Freight)
50218; ALFKI; 4; 2026-06-15; 2; 41.80

Order Details (OrderID; ProductID; UnitPrice; Quantity; Discount)
50218; 28; 45.60; 15; 0.05
```

**DE:** Weitere zusammenhängende Beispieldaten (auch für ServiceHarvester und CaseTracker) stehen in
`Secure-Trader-Systemlandschaft.md`.

**EN:** More connected sample data (also for ServiceHarvester and CaseTracker) is in
`Secure-Trader-Systemlandschaft.md`.

## Fiktivität und Provenance / Fictionality and Provenance

**DE:** Alle Daten sind fiktiv; die Erweiterung enthält keine echte PII und keine echten Secrets. Datenherkunft
ist die klassische Northwind-Traders-Sample-Datenbank (historisch als Microsoft-Beispiel bekannt), hier
markenneutral und rein didaktisch verwendet. Der Reihenname bleibt **Secure OrderDesk**.

**EN:** All data is fictional; the extension contains no real PII and no real secrets. The data origin is the
classic Northwind Traders sample database (historically known as a Microsoft sample), used here in a
brand-neutral, purely didactic way. The series name stays **Secure OrderDesk**.
