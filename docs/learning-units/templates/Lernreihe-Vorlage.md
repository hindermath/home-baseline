# <Lernreihe> / <Learning Series>

## Zweck / Purpose

**DE:** Beschreibe hier kurz, welches fachliche Problem die Lernreihe behandelt und warum sie fuer Fachinformatiker*innen relevant ist.

**EN:** Briefly describe which practical problem the learning series covers and why it matters for IT specialist apprentices.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab <1/2/3>. Lehrjahr |
| Fachrichtung AE | <hoch/mittel/niedrig> |
| Fachrichtung SI | <hoch/mittel/niedrig> |
| Fachrichtung DPA | <hoch/mittel/niedrig> |
| Sprachniveau / Language level | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |

## Lernziele / Learning Goals

- <Lernziel 1>
- <Lernziel 2>
- <Lernziel 3>

## Arbeitsmodell / Working Model

| Level | Geplanter Name / Planned Name | Zweck / Purpose |
|---|---|---|
| Level 0 | `home-baseline-tmp` | kanonische Quelle fuer Lernmaterial und Vorlagen |
| Level 1 | `<SeriesName>Projects` | Koordination, Statusmatrix, Paketierung |
| Level 2 | `<SeriesName>-CSharp`, `<SeriesName>-Go`, `<SeriesName>-Java`, `<SeriesName>-Python`, `<SeriesName>-Rust`, `<SeriesName>-Swift` | getrennte MSL-Sprachpfade mit lokaler Secure-Development-Basis |

## Aufgabenstruktur / Task Structure

| Nr. | Aufgaben-Lastenheft | Zweck | Manueller Spec-Kit-Lauf |
|---:|---|---|---|
| 0 | `Lastenheft_<SeriesName>-Lernreihe.md` | Gesamtlandkarte, nicht als grosser Lauf starten | nein |
| 1 | `Lastenheft_<SeriesName>_01_<Thema>.md` | erster konkreter Intake | ja |
| 2 | `Lastenheft_<SeriesName>_02_<Thema>.md` | zweiter konkreter Intake | ja |

## Nachweise / Evidence

- erwartete Markdown-Dokumente
- auszufuellende Checklisten aus `docs/secure-development/checklisten/CL_01_*.md` bis `CL_12_*.md`
- Checklistensammelband `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- mitgeltende Dokumente unter `docs/secure-development/mitgeltende-dokumente/`
- installierte Governance-Presets aus `scripts/config/spec-kit-governance-presets.json`, nachgewiesen mit `specify preset list`
- `N/A`-Begruendungen fuer nicht anwendbare Standards
- Test- und Review-Nachweise
- Bezug zu sicherer Entwicklung, MSL, Sandbox und Spec-Kit-Presets

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Das Master-Lastenheft ist nur Gesamtlandkarte.
- Einzelne Aufgaben-Lastenhefte werden spaeter manuell mit `/speckit-specify` gestartet.
