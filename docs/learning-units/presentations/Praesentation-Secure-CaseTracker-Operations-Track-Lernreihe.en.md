---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure CaseTracker Operations Track

## System Integration specialization from the third training year onward

EuFPA - European Company Programs Everything

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the track. It does not replace a Spec Kit run and does not create repositories.
:::

---

# Track goal

- The Operations Track treats the CaseTracker as an operated system. Learners plan sandboxing, runtime, CI/CD, secrets, monitoring, backup/restore, incident response, supply-chain evidence, and hardening.
- The track builds on Secure CaseTracker and Secure CaseTracker v2.
- Later work stays separated by language path and task intake.
- C#, Go, Java, Python, Rust, and Swift remain prepared as MSL paths.
- From year 3 onward, AI-assisted write work is expected in or with `absdd-image-sandbox`, or explicitly bounded with rationale.

---

# Task sequence

- 01: Betriebszielbild und Systemgrenzen
- 02: Sandbox- und Laufzeitprofil
- 03: CI/CD-Pipeline und Release-Nachweise
- 04: Secrets, Konfiguration und Least Privilege
- 05: Logging, Monitoring und Alerting
- 06: Backup, Restore und Recovery-Übung
- 07: Incident Response und Betriebsdokumentation
- 08: Dependency-, SBOM- und Supply-Chain-Nachweise
- 09: Härtungscheck gegen Richtlinie und Presets
- 10: Abschlussreview mit Betriebsrisiken und Übergabe

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
/speckit-specify Use docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md as the binding input file. Create a focused feature specification for the first task of the Secure CaseTracker Operations Track learning series. Do not create an implementation.
```
