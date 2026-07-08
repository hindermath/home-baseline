# Secure Trader — Systemlandschaft und Beispieldaten / System Landscape and Sample Data

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Rolle / Role:** Gemeinsames Universums- und Datenmodell für drei Lernreihen-Familien
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA
- **Betrifft / Applies to:** Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker

## Zweck / Purpose

**DE:** Dieses Dokument verbindet die drei Lernreihen zu einem stimmigen, gemeinsamen Universum. Eine einzige,
datierte Firmen-Backstory treibt konsistente Beispieldaten für alle drei Systeme. Die Verzahnung ist bewusst
leicht: Sie ist anreichernder Kontext, **keine harte Abhängigkeit**. Jede Lernreihe bleibt eigenständig
bearbeitbar.

**EN:** This document ties the three learning series into one coherent shared universe. A single dated company
backstory drives consistent sample data for all three systems. The coupling is deliberately light: it is
enriching context, **not a hard dependency**. Every series stays usable on its own.

## Systemlandschaft / System Landscape

**DE:** Die fiktive Handelsfirma **Secure Trader** betreibt eine Bestell-/Handelsplattform auf
Northwind-Datenbasis. Die didaktische Software-Schmiede **EuFPA** baut und betreut für Secure Trader drei
ineinandergreifende, aber je eigenständig nutzbare Systeme:

- **Secure OrderDesk** — die Handels-/Bestellplattform selbst (Kunden, Produkte, Bestellungen; Northwind-Daten
  inkl. `ALFKI`).
- **Secure ServiceHarvester** — erfasst System-/Bestandsdaten der Arbeitsplatz-PCs und Server, auf denen
  Secure Trader läuft.
- **Secure CaseTracker** — Support-Plattform für Support-Cases von Kundinnen/Kunden (Angebot/Bestellung/
  Lieferung) und internen Mitarbeitenden.

**EN:** The fictional trading company **Secure Trader** runs an ordering/trading platform on a Northwind data
base. The didactic software house **EuFPA** builds and maintains three interlocking, yet individually usable
systems for Secure Trader: **Secure OrderDesk** (the trading platform itself), **Secure ServiceHarvester**
(collects system/inventory data of the workstation PCs and servers Secure Trader runs on), and **Secure
CaseTracker** (support platform for support cases from customers and internal staff).

## Firmen-Backstory und Zeitachse / Company Backstory and Timeline

**DE:** Secure Trader startet mit dem klassischen Northwind-Bestand: 91 Kundinnen und Kunden (inklusive
`ALFKI` – Alfreds Futterkiste), 9 Mitarbeitende, 77 Produkte in 8 Kategorien, 29 Lieferanten und 3 Versender.
Die Original-Bestelldaten laufen von 1996-07 bis 1998-05. Danach wächst die Firma bis heute (Stand 2026-07)
kontinuierlich weiter.

**EN:** Secure Trader starts from the classic Northwind stock: 91 customers (including `ALFKI` – Alfreds
Futterkiste), 9 employees, 77 products in 8 categories, 29 suppliers, and 3 shippers. The original order data
runs from 1996-07 to 1998-05. From there the company keeps growing until today (as of 2026-07).

```text
Zeitachse / Timeline
1996-07 ── Original-Northwind-Bestelldaten beginnen (Start-Kundenstamm, ALFKI aktiv)
1998-05 ── Original-Bestelldaten enden
1998-06 ── Fiktive Erweiterung beginnt (monatliches Wachstum)
   ...   ── je Monat: +1..2 neue Kund*innen, +8..16 Bestellungen (alt + neu gemischt)
   ...   ── je Jahr: +1..2 Mitarbeitende (je +1 Arbeitsplatz-PC); Server 1 -> 4
2026-07 ── Heutiger Stand (Snapshot für ServiceHarvester und CaseTracker)
```

## Wachstums- und Sizing-Regeln / Growth & Sizing Rules

**DE:** Verbindliche Regeln für die spätere Datengenerierung (fiktiv, plausibel, deterministisch skriptbar):

| System | Regel |
|---|---|
| Secure OrderDesk | Pro Monat 1–2 neue Kund*innen; pro Monat 8–16 Bestellungen (inkl. `Order Details`), verteilt über alten UND neuen Kundenstamm; `ALFKI` bleibt aktiv; lückenlos 1998-06 bis 2026-07. |
| Secure ServiceHarvester | Start: 2 Arbeitsplatz-PCs + 1 Server. Ziel heute: 4 Windows-Server. Pro Jahr 1–2 neue Mitarbeitende, je +1 Arbeitsplatz-PC. Erfasst wird je Maschine: Name, Betriebssystem, letzter Kontakt. |
| Secure CaseTracker | 4 Kundenanfragen (Angebot/Bestellung/Lieferung) + 2–4 Mitarbeitenden-Anfragen (interne IT/Prozess), verknüpft mit realen Kund*innen/Bestellungen bzw. Mitarbeitenden/Maschinen der Beispieldaten. |

**EN:** Binding rules for later (fictional, plausible, deterministically scriptable) data generation: OrderDesk
adds 1–2 new customers and 8–16 orders per month over old and new customers (ALFKI stays active) without gaps
from 1998-06 to 2026-07; ServiceHarvester grows from 2 workstations + 1 server to 4 Windows servers with 1–2
new employees per year (each +1 PC), recording name, operating system, and last contact per machine;
CaseTracker holds 4 customer inquiries plus 2–4 employee inquiries linked to the customers/orders and
employees/machines of the sample data.

**DE:** Erwartetes Gesamtvolumen im Vollausbau (~338 Monate 1998-06 bis 2026-07): rund 2.700–5.400
Bestellungen, rund 340–680 neue Kund*innen (zzgl. 91 Original), rund 30–65 Arbeitsplatz-PCs plus 4 Server.

**EN:** Expected full-build volume (~338 months): roughly 2,700–5,400 orders, roughly 340–680 new customers
(plus the 91 original), and roughly 30–65 workstation PCs plus 4 servers.

## Beispieldaten Secure OrderDesk / Sample Data (Northwind-Layout)

**DE:** Kunden im Northwind-Layout — der Pflicht-Datensatz `ALFKI` ist enthalten; zwei fiktive Neukunden
zeigen das monatliche Wachstum.

```text
Customers (CustomerID; CompanyName; ContactName; City; Country)
ALFKI; Alfreds Futterkiste; Maria Anders; Berlin; Germany            (Original, aktiv)
AROUT; Around the Horn; Thomas Hardy; London; UK                     (Original)
NORDW; Nordwind Feinkost GmbH; Lena Brandt; Hamburg; Germany          (fiktiv, neu 2019-03)
ALPBI; Alpenbistro Handels AG; Marco Keller; Innsbruck; Austria       (fiktiv, neu 2024-11)
```

**DE:** Beispielbestellungen — je eine aus dem Original-Zeitraum und aus der fiktiven Erweiterung; `ALFKI`
bleibt aktiv.

```text
Orders (OrderID; CustomerID; EmployeeID; OrderDate; ShipVia; Freight)
10643; ALFKI; 6; 1997-08-25; 1; 29.46      (Original)
50218; ALFKI; 4; 2026-06-15; 2; 41.80      (fiktive Erweiterung, ALFKI weiterhin aktiv)
50219; NORDW; 7; 2026-06-17; 3; 18.20      (fiktive Erweiterung, neuer Kunde)

Order Details (OrderID; ProductID; UnitPrice; Quantity; Discount)
50218; 28; 45.60; 15; 0.05
50218; 39; 18.00; 21; 0.00
50219; 76; 18.00; 10; 0.10
```

## Beispieldaten Secure ServiceHarvester / Sample Data (IT-Bestand)

**DE:** Maschinen-Inventar im ServiceHarvester-Datenmodell (Name, Betriebssystem, letzter Kontakt). Der
Snapshot zeigt den Wachstumsstand: aus 2 PCs + 1 Server sind 4 Windows-Server plus je ein PC pro
Mitarbeitendem geworden.

```text
Machines (MachineName; OperatingSystem; LastContact)
SRV-01; Windows Server 2016; 2026-07-06T22:10Z   (erster Server, seit Start)
SRV-02; Windows Server 2019; 2026-07-06T22:11Z
SRV-03; Windows Server 2022; 2026-07-06T22:09Z
SRV-04; Windows Server 2022; 2026-07-06T22:12Z   (vierter Server, aktuell)
WS-01;  Windows 11 Pro;      2026-07-06T17:45Z   (erster Arbeitsplatz, seit Start)
WS-02;  Windows 11 Pro;      2026-07-06T17:50Z
WS-07;  Windows 11 Pro;      2026-07-06T16:30Z   (Arbeitsplatz einer 2024 neu Eingestellten)
```

**DE:** Wachstumshistorie (verkürzt): Start 1998 mit `WS-01`, `WS-02`, `SRV-01`; danach pro Jahr 1–2 neue
Arbeitsplätze; `SRV-02` bis `SRV-04` kamen mit steigender Last hinzu.

## Beispieldaten Secure CaseTracker / Sample Data (Support-Cases)

**DE:** Support-Cases im CaseTracker-Datenmodell (Kontaktname, Fallbeschreibung, Asset-Bezug,
Bearbeitungsnotiz). Sie verweisen auf reale Kund*innen/Bestellungen bzw. Mitarbeitende/Maschinen der
Beispieldaten — als Kontext, nicht als Voraussetzung.

```text
Kundenanfragen / Customer cases (Kontakt; Fallbeschreibung; Asset-Bezug)
Maria Anders (ALFKI); Lieferstatus zu Bestellung 50218 unklar; Order 50218
Thomas Hardy (AROUT); Angebot für Großmenge Produkt 28 angefragt; Product 28
Lena Brandt (NORDW); Rechnung zu Bestellung 50219 weicht ab; Order 50219
Marco Keller (ALPBI); Neuanlage Lieferadresse gewünscht; Customer ALPBI

Mitarbeitenden-Anfragen / Employee cases (Kontakt; Fallbeschreibung; Asset-Bezug)
Nancy Davolio (Emp 1); OrderDesk-Login nach Passwortablauf gesperrt; WS-01
IT-Betrieb (Emp 4); SRV-03 meldet vollen Log-Datenträger; SRV-03
Neue Kollegin (Emp – 2024); Arbeitsplatz WS-07 braucht OrderDesk-Zugriff; WS-07
```

## Fiktivität, Datenschutz und Provenance / Fictionality, Privacy and Provenance

**DE:** Alle Daten sind fiktiv. Die Northwind-Basis ist bereits fiktiv; die Erweiterung bleibt fiktiv und
plausibel. Es werden keine echten personenbezogenen Daten, keine echten Secrets und keine realen internen
Pfade verwendet. Datensparsamkeit gilt: Beispieldaten enthalten nur, was zum Lernziel nötig ist.

**EN:** All data is fictional. The Northwind base is already fictional; the extension stays fictional and
plausible. No real personal data, no real secrets, and no real internal paths are used. Data minimization
applies: sample data contains only what the learning goal needs.

**DE:** Datenherkunft: Die relationale Grundlage von Secure OrderDesk ist die klassische
Northwind-Traders-Sample-Datenbank (historisch als Microsoft-Beispiel bekannt), hier nur als didaktische
Datenquelle und markenneutral verwendet. Der Reihenname bleibt **Secure OrderDesk**.

**EN:** Data origin: the relational base of Secure OrderDesk is the classic Northwind Traders sample database
(historically known as a Microsoft sample), used here only as a didactic data source and in a brand-neutral
way. The series name stays **Secure OrderDesk**.

## Grenzen / Boundaries

**DE:** Dieses Dokument definiert Modell und Regeln plus kleine Beispieldaten. Die vollständigen, bis 2026-07
generierten Datensätze liegen unter [`datasets/`](datasets/README.md) (deterministischer Generator
`generate-secure-trader-dataset.py` plus generierte CSV-Dateien und `schema.sql`). Die Verzahnung bleibt
leicht: Kein Aufgaben-Lastenheft einer Reihe setzt eine andere Reihe voraus.

**EN:** This document defines the model, the rules, and small sample data. The full datasets generated up to
2026-07 are in [`datasets/`](datasets/README.md) (deterministic generator `generate-secure-trader-dataset.py`
plus generated CSV files and `schema.sql`). The coupling stays light: no task intake of one series requires
another series.
