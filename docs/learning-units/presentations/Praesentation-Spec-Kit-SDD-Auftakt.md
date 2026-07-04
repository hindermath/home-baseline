---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Spec Kit SDD Auftakt

## Spezifikationsgesteuerte Entwicklung in Lernreihen

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation ist eine neutrale Auftaktinformation. Sie ersetzt keinen Spec-Kit-Lauf.
:::

---

# Warum SDD?

- Erst verstehen, dann planen, dann umsetzen
- Anforderungen und Nicht-Ziele sichtbar machen
- Sicherheits-, Datenschutz- und A11Y-Fragen früh prüfen
- Entscheidungen so dokumentieren, dass andere sie reviewen können
- Umsetzung nicht aus Bauchgefühl starten

---

# Rolle von Spec Kit

- Spec Kit strukturiert Spezifikation, Planung, Aufgaben und Review
- Es erzeugt nachvollziehbare Artefakte für Lern- und Projektarbeit
- Es hilft, offene Fragen bewusst zu klären
- Es ersetzt nicht Berufsschule, betriebliche Ausbildung oder Prüfungsvorbereitung

---

# Workflow

| Phase | Zweck |
|---|---|
| Constitution | langlebige Projektprinzipien |
| Specify | Feature-Spezifikation aus Intake |
| Clarify | offene Entscheidungen klären |
| Plan | technische Umsetzung planen |
| Tasks | Arbeit in Schritte zerlegen |
| Analyze | Lücken und Widersprüche finden |
| Implement | geplante Aufgaben umsetzen |

---

# Master vs. Aufgabe

- Master-Lastenhefte sind Gesamtlandkarten
- Master-Lastenhefte werden nicht als Sammellauf gestartet
- Aufgaben-Lastenhefte sind konkrete spätere Intakes
- Jeder Spec-Kit-Lauf gehört zu genau einer Aufgabe und einem Repo

---

# Nach jedem Lauf

- Artefakte lesen und verstehen
- `Applicable`, `N/A` und `Open` prüfen
- Offene Punkte nicht verstecken
- Entscheidungen committen
- Review bewusst einplanen

---

# Minimaler Start

```text
/speckit-specify Nutze <Pfad-zum-Aufgaben-Lastenheft> als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
