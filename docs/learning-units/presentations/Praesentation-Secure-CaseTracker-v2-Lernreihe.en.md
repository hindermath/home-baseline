---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure CaseTracker v2 Service Edition

## Service edition from the second training year onward

EuFPA - European Company Programs Everything

IT specialist apprentices from the second training year onward · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the learning series. It does not replace a Spec Kit run and does not create repositories.
:::

---

# Why this series?

- EuFPA wants to extend the existing Secure CaseTracker into a service edition. The series deepens architecture, persistence, API/service boundaries, authorization, audit logging, tests, CI, sandbox, operation, and MSL comparison.
- The series deepens secure development with the guideline and checklists.
- Later implementations remain comparable across languages.
- C#, Go, Java, Python, Rust, and Swift are prepared as MSL paths.

---

# Specialization fit

| Specialization | Focus |
|---|---|
| Application Development | architecture, interfaces, implementation decisions, and tests |
| System Integration | sandbox, CI, configuration, operation, and evidence paths |
| Data and Process Analysis | data quality, metrics, privacy, and decision boundaries |

---

# Task sequence

- 01: Architekturzielbild und Systemgrenzen
- 02: Persistenzmodell und Migrationen
- 03: API- und Service-Vertrag
- 04: Fehler-, Validierungs- und Response-Modell
- 05: Rollen- und Autorisierungsmatrix
- 06: Audit-Logging und Datenschutz
- 07: Import- und Export-Härtung
- 08: Teststrategie und CI-Nachweise
- 09: Sandbox- und Betriebsnachweise
- 10: MSL-Vergleich und Abschlussreview

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
/speckit-specify Use docs/learning-units/Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md as the binding input file. Create a focused feature specification for the first task of the Secure CaseTracker v2 Service Edition learning series. Do not create an implementation.
```

::: notes
The prompt is an example for the first later single run. Instructors or learners start it deliberately in the matching language repository.
:::
