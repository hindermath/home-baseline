---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure ServiceHarvester Operations Track

## System Integration specialization from the third training year onward

EuFPA - European Company Programs Everything

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories. Date: 2026-07-06.
:::

---

# Track goal

- The Operations Track treats the ServiceHarvester as a cross-platform collector and worker service to be operated. Learners plan deployment, configuration, hardening, observability, builds, backup, supply chain, and operational evidence.
- The track builds on the baseline tag `learning/year-2-complete`.
- The domain stays language-neutral; the C# reference `InventarWorkerService` serves only as illustration.
- C#, Go, Java, Python, Rust, and Swift remain prepared as MSL paths.
- From year 3 onward, AI-assisted write work is expected in or with `absdd-image-sandbox`, or explicitly bounded with rationale.

---

# Task sequence

- 01: Track-Baseline und Betriebszielbild
- 02: Dienst-Deployment (Windows-Service, systemd, launchd)
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
- six governance presets
- `Applicable`, `N/A`, `Open` with rationale
- public sandbox link and sandbox/IDE boundary
- deviations from sandbox use as risk or `N/A`

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md as the binding input file. Create a focused feature specification for the first task of the Secure ServiceHarvester Operations Track learning series. Do not create an implementation.
```
