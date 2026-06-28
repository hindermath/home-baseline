# Lastenheft: <Lernreihe> <Nr.> <Thema>

## Zweck / Purpose

**DE:** Beschreibe das konkrete Lernziel dieser Aufgabe. Die Aufgabe muss einzeln als Spec-Kit-Intake nutzbar sein.

**EN:** Describe the concrete learning goal of this task. The task must be usable as a standalone Spec Kit intake.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab <1/2/3>. Lehrjahr |
| Fachrichtung AE | <hoch/mittel/niedrig> |
| Fachrichtung SI | <hoch/mittel/niedrig> |
| Fachrichtung DPA | <hoch/mittel/niedrig> |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |

## Ausgangslage / Starting Point

- <fachlicher Kontext>
- <vorhandene Artefakte>
- <Abgrenzung zu vorherigen Aufgaben>

## Anforderungen / Requirements

- **R-01:** <funktionale oder dokumentarische Anforderung>
- **R-02:** <Sicherheitsanforderung>
- **R-03:** <Test-/Nachweisanforderung>

## Sicherheits- und Governance-Bezug / Security and Governance Relation

- sichere Entwicklung: <Richtlinie/Checkliste>
- MSL: <sprachneutraler oder sprachspezifischer Bezug>
- Datenschutz: <anwendbar oder N/A mit Begruendung>
- Lieferkette: <anwendbar oder N/A mit Begruendung>
- Barrierefreiheit: <anwendbar oder N/A mit Begruendung>
- Spec-Kit-Presets: <relevante Presets>
- Preset-Nachweis: `specify preset list` zeigt die fuer dieses Repo installierten Governance-Presets oder eine begruendete Ausnahme

## Erwartete Artefakte / Expected Artefacts

- `spec.md`
- `plan.md`
- `tasks.md`
- projektspezifische Markdown-Nachweise
- aktualisierte Checklisten oder `N/A`-Begruendungen

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Aufgabe ist in einer MSL umsetzbar.
- [ ] Sicherheitsannahmen sind dokumentiert.
- [ ] Nicht anwendbare Standards sind als `N/A` begruendet.
- [ ] Tests oder Review-Schritte sind benannt.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify
Nutze dieses Lastenheft als verbindlichen Intake fuer einen einzelnen Spec-Kit-Lauf.
Starte keinen Sammellauf fuer die gesamte Lernreihe.
Halte die Umsetzung DE-first, EN-second, CEFR B2 und WCAG 2.2 AA.
Beruecksichtige sichere Entwicklung, MSL, Sandbox-Nutzung, Spec-Kit-Presets und auditfaehige Markdown-Nachweise.
```
