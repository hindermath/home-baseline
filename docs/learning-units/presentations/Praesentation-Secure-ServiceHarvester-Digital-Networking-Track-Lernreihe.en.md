---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure ServiceHarvester Digital Networking Track

## Digital Networking specialization from the third training year onward

EuFPA - European Company Programs Everything

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. Date: 2026-07-06.
:::

---

# Track goal

- The Digital Networking Track treats the ServiceHarvester as a networked, cross-platform collector and worker service. Learners plan system context, interfaces, communication flows, segmentation, transport security, availability, distributed collection, and operational evidence.
- The track builds on the baseline tag `learning/year-2-complete`.
- The domain stays language-neutral; the C# reference `InventarWorkerService` serves only as illustration.
- C#, Go, Java, Python, Rust, and Swift remain prepared as MSL paths.
- From year 3 onward, AI-assisted write work is expected in or with `absdd-image-sandbox`, or explicitly bounded with rationale.

---

# Task sequence

- 01: Track-Baseline und Netzzielbild
- 02: Systemkontext und Maschinen-/Netzbezüge
- 03: Schnittstellen und Kommunikationsflüsse
- 04: Segmentierung und Vertrauenszonen
- 05: Transportsicherheit und Endpunkt-Authentifizierung
- 06: Verfügbarkeit, Timeouts und Wiederholstrategien
- 07: Verteilte Sammlung und Agentenkommunikation
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
/speckit-specify Use docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure ServiceHarvester Digital Networking Track learning series. Do not create an implementation.
```
