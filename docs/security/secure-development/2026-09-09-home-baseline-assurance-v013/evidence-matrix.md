# Level-0 Assurance v0.1.3: Evidence-Matrix / Evidence matrix

## Prüfgrenze / Verification boundary

Eigener technischer Feldtest der Preset-Installation, Baseline-Bindung und
Gate-Semantik; keine erneute vollständige RL-SE-Produktabnahme. Die 30
Dokumentbewertungen in baseline.json bedeuten ausschließlich: Quelle vorhanden,
Version und Hash gebunden und durch den Validator zu prüfen. Sie bedeuten
nicht, dass alle 157 Sicherheitsmaßnahmen umgesetzt sind. Historische
Selbstprüfungen und der ABS-DD-Kontext bleiben unverändert.

*This is a scoped installation, baseline-binding and gate-semantics field test,
not a new full product security assessment. The 30 baseline assessments concern
document integrity only, not implementation of all 157 controls. Historical
assessments remain unchanged.*

## Nachweismatrix / Evidence matrix

| Gate | Anwendbarkeit / Applicability | Gegenstand / Subject | Nachweis / Evidence |
|---|---|---|---|
| Baseline | Applicable | Richtlinie, 12 Checklisten, Sammelband und mitgeltende Dokumente / controlled documents | baseline.json; normalized document bindings |
| Delta | Applicable | 0.1.2 auf unverändertes 0.1.3 / immutable upgrade | deltas/preset-v013.json; central matrix; installed registry |
| Closure | Applicable | Technische Prüfung getrennt von menschlichen Freigaben / decision separation | closure.json; field-test report |
| Image impact | N/A | Kein Image verändert / no image change | image-impact.json; scoped Git diff |
| CL-02-13 / C5 | N/A | Kein Cloud-Produktservice und kein C5-Test im genehmigten Ausbildungs-Scope / no cloud product service | User-approved scope; review 2026-12-31 |
| Produkt-/Konformitätsabnahme / Product acceptance | N/A for this technical test | Nicht Gegenstand dieser Installation / outside installation | Separate human decisions remain Open |

## Ausbildung und Grenzen / Education and boundaries

Alle sieben Kandidaten (TinyCalc, TinyPl0, InventarWorkerService,
absdd-image-sandbox, TuiVision, home-baseline, AOC) sind nichtproduktive,
nichtkommerzielle Ausbildungs- und Referenzprojekte. Primäre Zielgruppen:
Fachinformatiker*innen aller vier Fachrichtungen, IT-System-Elektroniker*innen,
Kaufleute für IT-System-Management und für Digitalisierungsmanagement.
Sicherheit beginnt im ersten Lehrjahr: Eingaben prüfen, Secrets schützen,
Agentenrechte begrenzen, Änderungen verstehen, testen und Freigaben begründen.
Die didaktische Tiefe wächst; reale Dateien und Zugangsdaten bleiben geschützt.

*All seven candidates are non-production, non-commercial educational/reference
projects for the four IT training occupations, including all four IT specialist
tracks. Security starts in year one; explanatory depth grows with experience,
while real files, credentials and agent permissions remain protected.*

Level 0 entwickelt und konsumiert das Preset: dieser Selbsttest ersetzt keinen
unabhängigen Feldnachweis. Quellen unter docs/secure-development bleiben
unverändert. Bestehende Risiko-, Pilot-, Projekt- und Releaseentscheidungen
werden nicht übernommen oder neu erteilt. Scope-Wiedervorlage: 2026-12-31;
technische Wiedervorlage: 2027-09-09. Ein geänderter Nutzungszweck löst eine
frühere Neubewertung aus; keine rechtliche Freistellung wird behauptet.

*Level 0 is both developer and consumer; this self-test is not independent
evidence. Baseline sources and historical decisions remain unchanged. Scope
review is due 2026-12-31, technical evidence 2027-09-09, earlier after scope
change. No legal exemption, certification or human approval is inferred.*

Nächste Aktion / Next action: Pakettests und vier Reviews abschließen,
Feldbericht veröffentlichen / complete tests and reviews, then publish report.
