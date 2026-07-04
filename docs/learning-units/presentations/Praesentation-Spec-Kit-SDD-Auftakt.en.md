---
lang: en
---

<!--
Markdown source for a PowerPoint-compatible presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Spec Kit SDD Kickoff

## Specification-driven development in learning series

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation is a neutral kickoff. It does not replace a Spec Kit run.
:::

---

# Why SDD?

- Understand first, then plan, then implement
- Make requirements and non-goals visible
- Check security, privacy, and accessibility questions early
- Document decisions so others can review them
- Do not start implementation from guesswork

---

# Role of Spec Kit

- Spec Kit structures specification, planning, tasks, and review
- It creates traceable artifacts for learning and project work
- It helps clarify open questions deliberately
- It does not replace vocational school, workplace training, or exam preparation

---

# Workflow

| Phase | Purpose |
|---|---|
| Constitution | durable project principles |
| Specify | feature specification from intake |
| Clarify | clarify open decisions |
| Plan | plan technical implementation |
| Tasks | split work into steps |
| Analyze | find gaps and contradictions |
| Implement | implement planned tasks |

---

# Master vs. Task

- Master intakes are overview maps
- Master intakes are not started as one large run
- Task intakes are concrete later starts
- Each Spec Kit run belongs to one task and one repository

---

# After Each Run

- Read and understand the artifacts
- Check `Applicable`, `N/A`, and `Open`
- Do not hide open items
- Commit decisions
- Plan review deliberately

---

# Minimal Start

```text
/speckit-specify Use <path-to-task-intake> as the binding input file. Create a focused feature specification. Do not create an implementation and do not start a collection run for the entire learning series.
```
