# Dokumentationsmigration DIA001 / Documentation Migration DIA001

## Ergebnis / Result

Die ehemalige 3.683-zeilige bilinguale Root-README wurde durch getrennte,
kompakte deutsche und englische Einstiegspunkte ersetzt. Ausführliche Inhalte
sind über vier Leserpfade und die bestehende `docs/`-Taxonomie erreichbar.

*The former 3,683-line bilingual root README was replaced with separate concise
German and English entry points. Detailed content remains reachable through
four reader paths and the existing `docs/` taxonomy.*

## Provenienz / Provenance

- Finding: `DIA001`
- Source commit: `edf33bc88029edea261e9c461d45c347d449ad3f`
- Source path: `README.md`
- Source lines: `3683`
- Normalized SHA-256:
  `9e91056e0746fc56a4e5eb17b615cb1cf56189dbada57e694859f346856482b5`
- Sections: `16`
- D6 findings: `0`
- D7 findings: `0`

Der frühere Volltext bleibt über den angegebenen Git-Commit prüfbar. Er wird
nicht als zweite aktive Dokumentationsquelle kopiert.

*The previous full text remains auditable through the named Git commit. It is
not copied into a second active documentation source.*

## Entscheidungen / Decisions

| Entscheidung | Anzahl | Bedeutung |
|---|---:|---|
| `Retained` | 1 | kompakter Root-Einstieg bleibt am Ort |
| `Moved` | 6 | Abschnitt besitzt einen neuen kanonischen Zielpfad |
| `Merged` | 9 | Inhalt wurde in eine aktuellere fachliche Quelle integriert |
| `Obsolete` | 0 | kein aktiver Abschnitt wurde ersatzlos entfernt |

Die vollständige zeilen- und hashgebundene Zuordnung steht in
[`documentation-migration.json`](documentation-migration.json).

## Proof-Grenze / Proof Boundary

Der Validator beweist Quellhash, Vollständigkeit, eindeutige Entscheidungen,
Ziele, Anker, Sprachpartner, Leserpfade und lokale Links. Der getrennte
semantische Review beurteilt Verständlichkeit, fachliche Gleichwertigkeit,
Progressive Disclosure und WCAG-2.2-AA-Anwendbarkeit.

*The validator proves source hash, completeness, unique decisions, targets,
anchors, language partners, reader paths, and local links. Separate semantic
review assesses comprehensibility, equivalence, progressive disclosure, and
applicable WCAG 2.2 AA criteria.*

## Semantischer Review / Semantic Review

Die sechs Sprachpaare besitzen dieselbe Überschriftenfolge, dieselben
Leserentscheidungen und dieselben sicheren nächsten Aktionen. Die englischen
Fassungen sind wegen anderer Wortgrenzen 9 bis 15 Prozent länger; es fehlt kein
deutscher Themenbereich. Begriffe wie kanonische Quelle, Home Runtime,
maschinenlokaler Zustand, Progressive Disclosure und Spec Kit werden beim
ersten Auftreten erklärt oder auf ihre Erklärung verlinkt.

Überschriften, beschreibende Links, Listen, Tabellen und Codeblöcke bleiben
textorientiert. Befehle nennen Plattform, Voraussetzungen, Nebenwirkung und
sicheren Prüfmodus. Farbe, Position oder ein Bild ist für keine Entscheidung
erforderlich. Der Review bestätigt CEFR B2 und die anwendbaren Kriterien von
WCAG 2.2 AA.

*The six language pairs have equivalent heading order, reader decisions, and
safe next actions. English word counts are 9 to 15 percent higher because of
language boundaries; no German topic is missing. Headings, descriptive links,
lists, tables, and code blocks remain text-first, and command examples identify
platform, prerequisites, side effects, and safe inspection mode.*
