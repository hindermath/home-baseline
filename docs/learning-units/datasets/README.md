# Secure Trader — Beispieldatensätze / Sample Datasets

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07 (Snapshot-Endpunkt / snapshot end point)
- **Übungsfirma / Training company:** EuFPA — Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Verbindliche Quellen / Binding sources:** `../Secure-Trader-Systemlandschaft.md`, `../Secure-OrderDesk-Datensatzquelle.md`
- **Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zweck / Purpose

**DE:** Dieses Verzeichnis enthält einen **deterministisch erzeugten**, fiktiven Beispieldatenbestand für die
drei Systeme des Secure-Trader-Universums — **Secure OrderDesk**, **Secure ServiceHarvester** und **Secure
CaseTracker**. Dieselben Kund*innen, Mitarbeitenden und Maschinen ziehen sich konsistent durch alle drei
Datensätze. Die Daten reichen von 1996-07 bis einschließlich **Juli 2026**.

**EN:** This directory holds a **deterministically generated**, fictional sample data set for the three Secure
Trader systems — Secure OrderDesk, Secure ServiceHarvester, and Secure CaseTracker. The same customers,
employees, and machines run consistently through all three datasets. Data spans 1996-07 up to and including
**July 2026**.

## Herkunft und Fiktivität / Provenance and Fictionality

**DE:** Die relationale Grundlage ist die klassische **Northwind-Traders-Sample-Datenbank** (historisch als
Microsoft-Beispiel bekannt), hier **markenneutral und rein didaktisch** verwendet. Feldnamen, Datentypen und
Fremdschlüssel folgen dem Northwind-Layout. **Alle Daten sind fiktiv.** Es sind keine echten personenbezogenen
Daten (PII), keine echten Secrets und keine realen internen Pfade enthalten. Der Name „Microsoft" erscheint nur
als Herkunftshinweis; „Windows" und „Windows Server" sind ausschließlich als Betriebssystem-Bezeichnungen
verwendet.

**EN:** The relational base is the classic **Northwind Traders sample database** (historically a Microsoft
sample), used here in a **brand-neutral, purely didactic** way. Field names, data types, and foreign keys
follow the Northwind layout. **All data is fictional** — no real PII, no real secrets, no real internal paths.
"Microsoft" appears only as an origin note; "Windows" / "Windows Server" are used only as OS names.

## Dateien / Files

```text
datasets/
├── generate-secure-trader-dataset.py   Deterministischer Generator (fester Seed)
├── schema.sql                          Portables SQL-DDL (Northwind-Kern-Tabellen)
├── README.md                           Diese Datei
├── orderdesk/                          Secure OrderDesk (Northwind-Layout)
│   ├── categories.csv                  CategoryID, CategoryName, Description
│   ├── suppliers.csv                   SupplierID, CompanyName, ContactName, City, Country
│   ├── shippers.csv                    ShipperID, CompanyName, Phone
│   ├── products.csv                    ProductID, ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock, Discontinued
│   ├── employees.csv                   EmployeeID, LastName, FirstName, Title, City, Country, HireDate
│   ├── customers.csv                   CustomerID, CompanyName, ContactName, City, Country
│   ├── orders.csv                      OrderID, CustomerID, EmployeeID, OrderDate, ShipVia, Freight
│   └── order_details.csv               OrderID, ProductID, UnitPrice, Quantity, Discount
├── serviceharvester/
│   └── machines.csv                    MachineName, OperatingSystem, LastContact
└── casetracker/
    └── cases.csv                       CaseID, ContactName, ContactType, Subject, AssetRef, Status
```

## Umfang (aktueller Lauf) / Volume (current run)

| Datei / File | Zeilen inkl. Header / Rows incl. header |
|---|---|
| `orderdesk/categories.csv` | 9 |
| `orderdesk/suppliers.csv` | 30 |
| `orderdesk/shippers.csv` | 4 |
| `orderdesk/products.csv` | 78 |
| `orderdesk/employees.csv` | 10 |
| `orderdesk/customers.csv` | 598 |
| `orderdesk/orders.csv` | 4726 |
| `orderdesk/order_details.csv` | 14096 |
| `serviceharvester/machines.csv` | 45 (4 Server + 40 PCs) |
| `casetracker/cases.csv` | 8 (7 Cases + Header) |

## Generierungsregeln / Generation Rules

**DE:**

1. **Basis (Northwind, fiktiv):** 8 Kategorien, 3 Versender, 29 Lieferanten, 77 Produkte, 9 Start-Mitarbeitende,
   91 Start-Kund*innen. Der Pflicht-Datensatz **`ALFKI` — Alfreds Futterkiste, Maria Anders, Berlin, Germany**
   ist enthalten und bleibt über den gesamten Zeitraum aktiv. `AROUT` (Around the Horn, Thomas Hardy, London)
   ist ebenfalls als Anker enthalten.
2. **Bestellungen:** Original-Zeitraum **1996-07 bis 1998-05** (15–35 Bestellungen/Monat, nur Start-Kundenstamm).
   Fiktive Erweiterung **1998-06 bis einschließlich 2026-07**: **lückenlos 8–16 Bestellungen/Monat** über alten
   UND neuen Kundenstamm, plus **1–2 neue Kund*innen/Monat**. Jede Bestellung: `OrderDate`, `ShipVia` (1–3),
   `EmployeeID` (1–9), `Freight`, 1–5 Positionen mit `ProductID`, `UnitPrice`, `Quantity` (1–40) und
   `Discount ∈ {0, 0.05, 0.10, 0.15, 0.20, 0.25}`. `OrderID` fortlaufend ab `10248`. Alle Fremdschlüssel konsistent.
3. **ServiceHarvester `machines.csv`:** Start 1998 mit `WS-01`, `WS-02` + `SRV-01`. Bis 2026 insgesamt **4
   Windows-Server** (`SRV-01`–`SRV-04`) und pro Jahr 1–2 neue Arbeitsplätze (`WS-03`, `WS-04`, …). OS: Windows 10/11
   Pro (PCs), Windows Server 2016/2019/2022 (Server). `LastContact` nahe 2026-07 (aktive Maschinen).
4. **CaseTracker `cases.csv`:** 4 Kundenanfragen (Referenz auf echte `CustomerID`/`OrderID`, inkl. `ALFKI`) +
   3 Mitarbeitenden-Anfragen (Referenz auf echte `EmployeeID`/`MachineName`). `Status ∈ {new, in_progress, resolved}`.

**Konsistenz:** Dieselben Kund*innen, Mitarbeitenden und Maschinen erscheinen über alle drei Systeme. Die
speziellen Neukunden `NORDW` (2019-03) und `ALPBI` (2024-11) spiegeln die Beispiele der Systemlandschaft.

**EN:** Northwind base (8 categories, 3 shippers, 29 suppliers, 77 products, 9 employees, 91 starting customers,
mandatory active `ALFKI`); original orders 1996-07..1998-05 (15–35/month) and a gap-free fictional extension
1998-06..2026-07 (8–16 orders and 1–2 new customers per month); ServiceHarvester grows from 2 PCs + 1 server to
4 Windows servers plus one PC per employee; CaseTracker links 4 customer and 3 employee cases to real records.

## Determinismus / Determinism

**DE:** Der Generator setzt genau **einen festen Seed** (`random.seed(20260707)`) und nutzt **keine**
Wanduhr-Abhängigkeit: kein `datetime.now()`, keine Echtzeit, kein `os.urandom`. Der Endmonat ist fest auf
`2026-07` kodiert und wird nicht aus dem heutigen Datum abgeleitet. Jeder Lauf erzeugt daher **bitgleiche**
Ergebnisse.

**EN:** The generator uses exactly **one fixed seed** (`random.seed(20260707)`) and **no** wall-clock
dependency — no `datetime.now()`, no real time, no `os.urandom`. The end month is hard-coded to `2026-07`.
Every run therefore produces **bit-identical** output.

## Reproduktion / Reproduction

```bash
cd docs/learning-units/datasets
python3 generate-secure-trader-dataset.py
```

**DE:** Der Lauf überschreibt alle CSVs im Zielbaum deterministisch neu. `schema.sql` liefert das portable
Northwind-Kernschema zum Laden der CSVs in eine Datenbank.

**EN:** The run deterministically regenerates all CSVs. `schema.sql` provides the portable Northwind core schema
to load the CSVs into a database.
