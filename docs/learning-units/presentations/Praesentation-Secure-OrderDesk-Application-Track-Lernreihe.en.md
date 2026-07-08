---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk Application Track

## Application Development specialization from the third training year onward

EuFPA - European Company Programs Everything · Client company Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. The platform is a relational order/trading platform for Secure Trader on the Northwind data basis, language-neutral, with the C# reference path OrderDesk.
:::

---

# Track goal

- The Application Track deepens secure feature and interface development of the order/trading platform for Secure Trader. Learners plan functions on the Northwind ordering domain, persistence adapters with parameterized queries, query logic, a maintainable interface, secure serialization, and tests.
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
The record `ALFKI` is mandatory so that all language paths share the same reference point for features and tests. No real personal data or secrets may be used.
:::

---

# Secure Trader system landscape

- **Secure OrderDesk**: the relational order/trading platform (this track)
- **Secure ServiceHarvester**: collects system/inventory data of the PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, no hard dependency
- Each track stays workable on its own

::: notes
EuFPA builds three interlocking but individually independent systems for Secure Trader. The Application Track deepens the feature corner of the OrderDesk platform.
:::

---

# Task sequence

- 01: Track-Baseline und Feature-Zielbild
- 02: API-Erweiterung und Ressourcenmodell
- 03: Persistenz-Adapter und Repository-Muster
- 04: Query-, Filter- und Paginierungslogik
- 05: Viewer- oder Client-Oberfläche (barrierefrei)
- 06: Fehlerbehandlung und Validierung vertieft
- 07: Erweiterbarkeit und Konfigurierbarkeit
- 08: Sichere Serialisierung und Schnittstellenverträge
- 09: Teststrategie: Unit, Integration und Contract-Tests
- 10: Feature-Review, Trade-offs und Abschluss

---

# Evidence

- secure development guideline
- 12 individual checklists and compendium
- related documents
- six governance presets
- `Applicable`, `N/A`, `Open` with rationale

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure OrderDesk Application Track learning series. The data basis is Northwind including ALFKI. Do not create an implementation.
```
