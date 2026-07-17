---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk v2 Trading Edition

## Trading edition from the second training year onward

EuFPA - European Company Programs Everything · Client company Secure Trader

IT specialist apprentices from the second training year onward · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the learning series. It does not replace a Spec Kit run and does not create repositories.
:::

---

# Why this series?

- EuFPA wants to extend the existing Secure OrderDesk from a simple ordering program into a cleanly separated relational trading platform. The series deepens architecture, hosting, relational persistence, order intake, the API/service contract, authorization, audit logging, operation, configuration, and MSL comparison.
- The series deepens secure development with the guideline and checklists.
- The shared core contract of the base series - the Northwind ordering domain for Secure Trader including `ALFKI` - stays valid and is implemented at greater technical depth.
- C#, Go, Java, Python, Rust, and Swift are prepared as MSL paths; the C# reference is the OrderDesk reference path.
- `absdd-image-sandbox` is the public sandbox reference, but in year 2 it is not yet a hard mandatory run.

---

# Target picture

- Clear system boundaries between order intake, catalog, relational store, and interface
- Cross-platform hosting and a safely managed lifecycle
- A replaceable backend abstraction over relational backends
- Secure, exclusively parameterized SQL access
- Observable operation with logging, health, and simple revenue/order metrics

::: notes
v2 turns the small ordering example into a more deeply separated platform. The core contract stays the same; the technical implementation becomes cleaner and more observable.
:::

---

# Specialization fit

| Specialization | Focus |
|---|---|
| Application Development | architecture, backend abstraction, API contract, error/response model, and tests |
| System Integration | database operation, configuration, secrets, logging, health, monitoring, and evidence paths |
| Data and Process Analysis | order and line-item data quality, revenue metrics, privacy, and decision boundaries |
| Digital Networking | system boundaries, order-pipeline interfaces, communication flows, and availability |

---

# Architecture and system boundaries

- Order intake, catalog, relational store, and interface are deliberately separate building blocks
- Trust boundaries sit at every entry point: input is treated as untrusted
- The backend abstraction encapsulates data access and keeps business logic SQL-free
- Defense in depth: validation, parameterized access, and authorization interlock
- Least privilege and fail-safe defaults are architectural requirements, not ad-hoc decisions

::: notes
Secure architecture (Principle XIII) and secure code (Principle XII) must work together. The system boundaries are the common thread of the first units.
:::

---

# Data basis: Northwind and ALFKI

- The binding data basis stays the classic **Northwind sample database**
- Layout and data including the mandatory record **`ALFKI`**
- Original order data (~1996-1998), extended with fictional records up to 2026
- All data is fictional and used in a brand-neutral way
- "Microsoft" is mentioned only as a historical source reference

::: notes
The record `ALFKI` is mandatory so that all language paths share the same reference point. No real personal data or secrets may be used.
:::

---

# Secure Trader system landscape

- **Secure OrderDesk**: the relational order/trading platform (this series)
- **Secure ServiceHarvester**: collects system/inventory data of the PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, no hard dependency
- Each learning series stays workable on its own

::: notes
EuFPA builds three interlocking but individually independent systems for Secure Trader. v2 deepens the OrderDesk corner of this landscape.
:::

---

# Relational persistence model

- Persistence sits behind a clear abstraction, not scattered across the business logic
- Relational backends are switched deliberately: SQLite, PostgreSQL, SQL Server
- Customers, products, orders, and line items stay in the Northwind layout
- Data access is exclusively parameterized (no SQL injection)
- Migrations and schema decisions stay documented and traceable

::: notes
The replaceable backend cut is a central learning point. It shows that business logic and data access can be separated cleanly.
:::

---

# Order intake: idempotency and import hardening

- Order intake and catalog access are made idempotent
- Repeated runs do not create duplicate bookings
- Input is validated and normalized at the trust boundary
- Import paths are hardened against faulty, incomplete, or malicious data
- Error cases lead into a safe state, not into half-finished orders

::: notes
Idempotency and import hardening are the core of robust order intake. Negative tests explicitly belong here.
:::

---

# API and service contract

- A clear API/service contract describes inputs and outputs unambiguously
- OpenAPI documents the contract in a machine- and human-readable way
- A uniform error, validation, and response model carries across all endpoints
- Error messages do not expose internal details, stack traces, or connection strings
- Roles `learner`, `developer`, and `reviewer` control access (least privilege)

::: notes
The contract is the external view of the platform. Clean error handling without internal details is a deliberate security decision.
:::

---

# Operation, logging, health, and monitoring

- Structured logging without secrets and without customer data in clear text
- Health/status endpoints make the state visible
- Simple revenue/order metrics support operation and analysis
- Secure configuration: secrets in suitable stores, never in source code or Git
- Operational evidence shows that operation is verifiable and traceable

::: notes
Secure development does not end with the code. Observable operation and clean configuration are part of the evidence.
:::

---

# Task sequence

- 01: Architekturzielbild und Systemgrenzen
- 02: Plattformübergreifendes Hosting und Lebenszyklus
- 03: Relationales Persistenzmodell und Backend-Abstraktion
- 04: Bestellannahme: Idempotenz und Import-Härtung
- 05: API- und Service-Vertrag und OpenAPI
- 06: Fehler-, Validierungs- und Response-Modell
- 07: Rollen-, Autorisierung und Audit-Logging
- 08: Betrieb, Logging, Health und Monitoring
- 09: Sichere Konfiguration, Secrets und Betriebsnachweise
- 10: MSL-Vergleich und Abschlussreview

---

# MSL comparison

- C#, Go, Java, Python, Rust, and Swift are implemented as MSL paths
- All six languages count as memory-safe languages in this series
- MSL reduces certain memory errors
- MSL does not replace review of input, SQL, I/O, auth, crypto, logging, or dependencies
- Implementations stay comparable across languages; behavior must match

::: notes
Especially in a relational domain, MSL is shown not to be a complete security guarantee. SQL safety must be sound in every language.
:::

---

# Evidence

- secure development guideline
- 12 individual checklists and compendium
- related documents
- seven governance presets
- `Applicable`, `N/A`, `Open` with rationale
- sandbox decision: `Applicable`, `N/A`, or `Open`
- IDE work outside the sandbox remains allowed

---

# Later starting point

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md as the binding input file. Create a focused feature specification for the first task of the Secure OrderDesk v2 Trading Edition learning series. The data basis is Northwind including ALFKI. Do not create an implementation.
```

::: notes
The prompt is an example for the first later single run. Instructors or learners start it deliberately in the matching language repository.
:::
