---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure ServiceHarvester v2 Service Edition

## Service edition from the second training year onward

EuFPA - European Company Programs Everything

IT specialist apprentices from the second training year onward · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the learning series. It does not replace a Spec Kit run and does not create repositories.
:::

---

# Why this series?

- EuFPA wants to extend the existing Secure ServiceHarvester into a cleanly separated service edition. The series deepens architecture, service hosting, persistence, harvester hardening, the API/service contract, authorization, audit logging, operation, configuration, and MSL comparison.
- The series deepens secure development with the guideline and checklists.
- Later implementations remain comparable across languages; the C# reference is `InventarWorkerService`.
- C#, Go, Java, Python, Rust, and Swift are prepared as MSL paths.
- `absdd-image-sandbox` is the public sandbox reference, but in year 2 it is not yet a hard mandatory run.

---

# Specialization fit

| Specialization | Focus |
|---|---|
| Application Development | architecture, backend abstraction, service contract, validation, and tests |
| System Integration | service hosting, configuration, secrets, logging, health, monitoring, and evidence paths |
| Data and Process Analysis | harvester data quality, metrics, privacy, and decision boundaries |
| Digital Networking | system boundaries, interfaces, communication flows, and availability |

---

# Task sequence

- 01: Architekturzielbild und Systemgrenzen
- 02: Plattformübergreifendes Dienst-Hosting und Lebenszyklus
- 03: Persistenzmodell und Backend-Abstraktion
- 04: Harvester: Zeitplanung, Idempotenz und Import-Härtung
- 05: API- und Service-Vertrag und OpenAPI
- 06: Fehler-, Validierungs- und Response-Modell
- 07: Rollen-, Autorisierung und Audit-Logging
- 08: Betrieb, Logging, Health und Monitoring
- 09: Sichere Konfiguration, Secrets und Betriebsnachweise
- 10: MSL-Vergleich und Abschlussreview

---

# Evidence

- secure development guideline
- 12 individual checklists and compendium
- related documents
- six governance presets
- `Applicable`, `N/A`, `Open` with rationale
- sandbox decision: `Applicable`, `N/A`, or `Open`
- IDE work outside the sandbox remains allowed

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md as the binding input file. Create a focused feature specification for the first task of the Secure ServiceHarvester v2 Service Edition learning series. Do not create an implementation.
```

::: notes
The prompt is an example for the first later single run. Instructors or learners start it deliberately in the matching language repository.
:::
