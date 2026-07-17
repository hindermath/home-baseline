---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk Data & Process Track

## Data and Process Analysis specialization from the third training year onward

EuFPA - European Company Programs Everything · Client company Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. The platform is a relational order/trading platform for Secure Trader on the Northwind data basis, language-neutral, with the C# reference path OrderDesk.
:::

---

# Track goal

- The Data & Process Track deepens the responsible handling of Secure Trader's order and trading data. Learners plan data quality in orders and line items, revenue metrics, reporting, privacy, anomaly detection, and the honest naming of interpretation limits.
- The track builds on Secure OrderDesk and Secure OrderDesk v2 and starts from the tag `learning/year-2-complete`.
- Later work stays separated by language path and task intake.
- C#, Go, Java, Python, Rust, and Swift remain prepared as MSL paths.

---

# Data basis: Northwind and ALFKI

- The binding data basis stays the classic **Northwind sample database**
- Layout and data including the mandatory record **`ALFKI`**
- Customers, products, orders, and order lines in the Northwind layout
- All data is fictional and used in a brand-neutral way
- "Microsoft" is mentioned only as a historical source reference

::: notes
The record `ALFKI` is mandatory so that all language paths share the same data basis for metrics and evaluations. No real personal data or secrets may be used.
:::

---

# Secure Trader system landscape

- **Secure OrderDesk**: the relational order/trading platform (this track)
- **Secure ServiceHarvester**: collects system/inventory data of the PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, no hard dependency
- Each track stays workable on its own

::: notes
EuFPA builds three interlocking but individually independent systems for Secure Trader. The Data & Process Track deepens the evaluation corner of the OrderDesk platform.
:::

---

# Task sequence

- 01: Track-Baseline und Datenzielbild
- 02: Datenqualität in Bestellungen und Positionen
- 03: Umsatz-Kennzahlen und Betriebsmetriken
- 04: Datenschutz und Datenminimierung vertieft
- 05: Reporting und Aggregationsansichten (barrierefrei)
- 06: Aussagegrenzen und Datenunsicherheit
- 07: Anomalie- und Lückenerkennung
- 08: Prozessfeedback und Verbesserung
- 09: Test- und Nachweisstrategie für Datenaussagen
- 10: Daten-Review, Trade-offs und Abschluss

---

# Evidence

- secure development guideline
- 12 individual checklists and compendium
- related documents
- seven governance presets
- `Applicable`, `N/A`, `Open` with rationale

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure OrderDesk Data & Process Track learning series. The data basis is Northwind including ALFKI. Do not create an implementation.
```
