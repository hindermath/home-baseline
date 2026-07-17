---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk Operations Track

## System Integration specialization from the third training year onward

EuFPA - European Company Programs Everything · Client company Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. Date: 2026-07-07.
:::

---

# Track goal

- The Operations Track treats Secure OrderDesk as a relational order/trading platform to be operated across platforms. Learners plan database operation, deployment, configuration, hardening, observability, builds, backup, supply chain, and operational evidence.
- The track builds on the baseline tag `learning/year-2-complete`.
- The domain stays language-neutral; the C# reference is the OrderDesk reference path.
- C#, Go, Java, Python, Rust, and Swift remain prepared as MSL paths.
- From year 3 onward, AI-assisted write work is expected in or with `absdd-image-sandbox`, or explicitly bounded with rationale.

---

# Data basis: Northwind and ALFKI

- The binding data basis stays the classic **Northwind sample database**
- Layout and data including the mandatory record **`ALFKI`**
- Customers, products, orders, and order lines in the Northwind layout
- All data is fictional and used in a brand-neutral way
- "Microsoft" is mentioned only as a historical source reference

::: notes
The record `ALFKI` is mandatory so that operation, backup, and recovery share the same reference point across all language paths. No real personal data or secrets may be used.
:::

---

# Secure Trader system landscape

- **Secure OrderDesk**: the relational order/trading platform (this track)
- **Secure ServiceHarvester**: collects system/inventory data of the PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, no hard dependency
- Each track stays operable on its own

::: notes
EuFPA builds three interlocking but individually independent systems for Secure Trader. The Operations Track deepens the operation of the OrderDesk platform.
:::

---

# Task sequence

- 01: Track-Baseline und Betriebszielbild
- 02: Datenbank-Deployment (Windows-Service, systemd, launchd)
- 03: Konfiguration, Secrets und sichere Defaults
- 04: Härtung und Angriffsflächen-Reduktion
- 05: Observability: Logging, Health und Metriken
- 06: CI/CD-Pipeline und reproduzierbare Builds
- 07: Backup, Recovery und Datenmigration
- 08: Supply Chain, SBOM und Dependency-Audit
- 09: Sandbox, Isolation und Betriebsnachweise
- 10: Betriebs-Review, Runbook und Abschluss

---

# Evidence

- secure development guideline
- 12 individual checklists and compendium
- related documents
- seven governance presets
- `Applicable`, `N/A`, `Open` with rationale
- public sandbox link and sandbox/IDE boundary
- deviations from sandbox use as risk or `N/A`

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure OrderDesk Operations Track learning series. The data basis is Northwind including ALFKI. Do not create an implementation.
```
