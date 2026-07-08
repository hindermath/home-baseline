# Secure Trader — Beispieldatensätze / Sample Datasets

## Metadaten / Metadata

- **Stand / Date:** 2026-07-08
- **Übungsfirma / Training company:** EuFPA — Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Verbindliche Quellen / Binding sources:** `../Secure-Trader-Systemlandschaft.md`, `../Secure-OrderDesk-Datensatzquelle.md`
- **Snapshot-Endmonat / Snapshot end month:** 2026-07 (`--end 2026-07`)
- **Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zweck / Purpose

**DE:** Dieses Verzeichnis enthält einen fiktiven, konsistenten Beispieldatenbestand für die drei Systeme des
Secure-Trader-Universums — **Secure OrderDesk**, **Secure ServiceHarvester** und **Secure CaseTracker**.
Dieselben Kund*innen, Mitarbeitenden und Maschinen ziehen sich konsistent durch alle drei Datensätze. **Alle
drei wachsen monatlich mit:** die Daten beginnen 1996-07 und reichen bis zum **Endmonat** — standardmäßig bis
zum **heutigen Monat** (`datetime.now()`), damit Auszubildende mit Daten bis zu ihrem **Projektdatum**
arbeiten. Der eingecheckte Snapshot reicht bis **2026-07**.

**EN:** This directory holds a fictional, consistent sample data set for the three Secure Trader systems. The
same customers, employees, and machines run consistently through all three datasets, and **all three grow
month by month** from 1996-07 up to the **end month** — by default the current month (`datetime.now()`), so
apprentices work with data up to their **project date**. The committed snapshot ends at **2026-07**.

## Für Auszubildende: Referenzdaten erzeugen / For Apprentices: Generate the Reference Data

**DE:** Führe den Generator beim Projektstart aus — er erzeugt die Referenzdaten bis zum heutigen Monat:

```bash
cd docs/learning-units/datasets
python3 generate-secure-trader-dataset.py            # Enddatum = heutiger Monat (now())
python3 generate-secure-trader-dataset.py --end 2026-07   # gepinnter Snapshot-Stand
```

**Wichtig:** Damit **alle sechs Sprach-Repos** (C#, Go, Java, Python, Rust, Swift) und alle Lernenden einer
Kohorte **exakt denselben** Datenbestand vergleichen können, denselben Lauf bzw. dieselben Parameter verwenden.
Der **Seed** ist fest (`--seed`, Default `20260707`), das **Enddatum** ist dynamisch (`--end YYYY-MM`, Default
`now()`). Gleiches `(end, seed)` → **bitgleiche** Ausgabe.

**EN:** Run the generator at project start to produce the reference data up to today's month. To let all six
language repos and a whole cohort compare **the same** data, use the same run / the same parameters. The seed
is fixed (`--seed`, default `20260707`); the end date is dynamic (`--end YYYY-MM`, default `now()`). The same
`(end, seed)` yields **bit-identical** output.

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
├── generate-secure-trader-dataset.py   Generator: --end (Default now()), --seed (fest), --out
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
    └── cases.csv                       CaseID, CreatedDate, ContactName, ContactType, Subject, AssetRef, Status
```

## Umfang (Snapshot `--end 2026-07`) / Volume (snapshot `--end 2026-07`)

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
| `casetracker/cases.csv` | 2365 (2364 Cases + Header) |

**Hinweis:** Bei einem späteren `--end` wachsen alle Zahlen entsprechend (z. B. `--end 2030-01`: ~5213
Bestellungen, 5 Server + 47 PCs, ~2649 Cases).

## Generierungsregeln / Generation Rules

**DE:**

1. **Basis (Northwind, fiktiv):** 8 Kategorien, 3 Versender, 29 Lieferanten, 77 Produkte, 9 Start-Mitarbeitende
   (Vertrieb), 91 Start-Kund*innen. Pflicht-Datensatz **`ALFKI` — Alfreds Futterkiste, Maria Anders, Berlin**
   enthalten und über den gesamten Zeitraum aktiv; `AROUT` als weiterer Anker.
2. **OrderDesk-Bestellungen:** Original **1996-07…1998-05** (15–35/Monat), danach **lückenlos 8–16
   Bestellungen/Monat + 1–2 neue Kund*innen/Monat** bis `--end` (alt + neu gemischt, `ALFKI` regelmäßig).
   Positionen 1–5 je Bestellung; `OrderID` fortlaufend ab `10248`; alle Fremdschlüssel konsistent.
3. **ServiceHarvester `machines.csv`:** Start 1998 mit `WS-01`, `WS-02` + `SRV-01`; **1–2 neue Mitarbeitende/
   Jahr, je +1 Arbeitsplatz-PC** (unbegrenzt bis `--end`). **Windows-Server** folgen der historischen Kadenz,
   so kalibriert, dass ~2026 genau **4 Server** erreicht sind, und wachsen darüber hinaus weiter (grob +1 alle
   ~8 Jahre). OS: Windows 10/11 Pro (PCs), Windows Server 2016/2019/2022/2025 (Server). `LastContact` nahe `--end`.
4. **CaseTracker `cases.csv` (monatliche Kadenz):** pro Monat **1998-06 … `--end`** **4 Kundenanfragen** +
   **2–4 Mitarbeitenden-Anfragen**, mit `CreatedDate`. Kundenanfragen referenzieren eine periodengültige
   `CustomerID` und meist eine reale `OrderID` (Bestelldatum ≤ Case-Datum; `ALFKI` regelmäßig);
   Mitarbeitenden-Anfragen referenzieren eine bis dahin existierende Maschine (`WS-…`/`SRV-…`). `Status ∈ {new,
   in_progress, resolved}` (ältere Cases überwiegend `resolved`).

**Konsistenz:** Dieselben Kund*innen, Mitarbeitenden und Maschinen erscheinen periodengültig über alle drei
Systeme. Die speziellen Neukunden `NORDW` (2019-03) und `ALPBI` (2024-11) spiegeln die Systemlandschaft-Beispiele.

**EN:** Northwind base (mandatory active `ALFKI`); OrderDesk orders 1996-07…1998-05 (15–35/month) then a
gap-free extension to `--end` with 8–16 orders and 1–2 new customers per month; ServiceHarvester grows from 2
PCs + 1 server with 1–2 new employees per year (each +1 PC) and Windows servers on a historical cadence
(calibrated to 4 by ~2026, growing further); CaseTracker generates 4 customer + 2–4 employee cases per month
(with `CreatedDate`) linked to period-valid customers/orders and machines.

## Reproduzierbarkeit und Determinismus / Reproducibility and Determinism

**DE:** Der Generator ist reproduzierbar je **(Enddatum, Seed)**: gleiches Paar → **bitgleiche** Ausgabe. Nur
das **Default-Enddatum** kommt aus `datetime.now()`; der **Seed** ist fest (`--seed`, Default `20260707`) und
wird **nicht** aus der Uhr abgeleitet (kein `os.urandom`). So sind die Daten einerseits aktuell bis zum
Projektdatum, andererseits über alle Sprach-Repos und Läufe hinweg identisch reproduzierbar. Der eingecheckte
Snapshot wurde mit `--end 2026-07` erzeugt. CSV-Dateien nutzen LF-Zeilenenden.

**EN:** The generator is reproducible per **(end date, seed)**: the same pair yields **bit-identical** output.
Only the **default end date** comes from `datetime.now()`; the **seed** is fixed (`--seed`, default `20260707`)
and never derived from the clock. So the data is both current to the project date and identically reproducible
across all language repos and runs. The committed snapshot was generated with `--end 2026-07`. CSV files use LF
line endings.
