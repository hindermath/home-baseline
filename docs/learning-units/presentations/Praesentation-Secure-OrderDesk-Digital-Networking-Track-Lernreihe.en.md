---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk Digital Networking Track

## Digital Networking specialization from the third training year onward

EuFPA - European Company Programs Everything · Client company Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. Date: 2026-07-07.
:::

---

# Track goal

- The Digital Networking Track treats Secure OrderDesk as a networked order pipeline for Secure Trader. Learners plan system context, interfaces between order intake, catalog, and relational store, communication flows, segmentation, transport security, availability, distributed integration, and operational evidence.
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
The record `ALFKI` is mandatory so that all language paths share the same reference point for interfaces and network paths. No real personal data or secrets may be used.
:::

---

# Secure Trader system landscape

- **Secure OrderDesk**: the relational order/trading platform (this track)
- **Secure ServiceHarvester**: collects system/inventory data of the PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, no hard dependency
- Each track stays workable on its own

::: notes
EuFPA builds three interlocking but individually independent systems for Secure Trader. The Digital Networking Track deepens the network and pipeline corner of the OrderDesk platform.
:::

---

# Task sequence

- 01: Track-Baseline und Netzzielbild
- 02: Systemkontext und Bestell-Pipeline-Netzbezüge
- 03: Schnittstellen und Kommunikationsflüsse
- 04: Segmentierung und Vertrauenszonen
- 05: Transportsicherheit und Endpunkt-Authentifizierung
- 06: Verfügbarkeit, Timeouts und Wiederholstrategien
- 07: Verteilte Integration und Agentenkommunikation
- 08: Betriebs- und Netznachweise
- 09: Ausfallszenarien und Resilienz
- 10: Netz-Review, Trade-offs und Abschluss

---

# Evidence

- communication matrix and interface list
- trust-boundary, segmentation, and transport-security evidence
- timeout, retry, and resilience evidence
- operational and network metrics without privacy violation
- threat model and residual risks for network paths
- `Applicable`, `N/A`, `Open` with rationale
- public sandbox link and sandbox/IDE boundary

---

# Important for learners

- Spec Kit structures specification, planning, tasks, and review
- Spec Kit does not replace vocational school, workplace training, or exam preparation
- Each run is started later and deliberately per task intake
- A clearly justified `N/A` is better than a silently skipped checkpoint

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure OrderDesk Digital Networking Track learning series. The data basis is Northwind including ALFKI. Do not create an implementation.
```
