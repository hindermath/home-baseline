# Klarstellungsbericht: Flottenweite CI-Budget-Governance / Clarification Report: Fleet-Wide CI Budget Governance

**Phase / Phase**: `clarify`

**Date / Datum**: 2026-08-19

**Feature / Feature**: `specs/029-ci-budget-governance/spec.md`

**Binding review / Bindendes Review**: `Ready`, Review-ID `694b6579-3443-4c9e-8017-8c7b285dae0f`

No critical ambiguities detected worth formal clarification.

## Fragen / Questions

- Asked / Gefragt: `0`
- Answered / Beantwortet: `0`
- Blocking questions / Blockierende Fragen: `0`

Die drei früheren Intake-Fragen `IRA001` bis `IRA003` sind durch das
akzeptierte `Ready`-Review sowie die expliziten Verträge `CBG-001` bis
`CBG-021` und `AC-CBG-001` bis `AC-CBG-010` bereits bindend beantwortet. Sie
sind keine offenen Klarstellungsfragen.

*The three earlier intake questions `IRA001` through `IRA003` are already
bindingly answered by the accepted `Ready` review and the explicit contracts
`CBG-001` through `CBG-021` and `AC-CBG-001` through `AC-CBG-010`. They are
not open clarification questions.*

## Taxonomieabdeckung / Taxonomy Coverage

| Kategorie / Category | Status | Nachweis oder Planungsgrenze / Evidence or planning boundary |
|---|---|---|
| Kernziele und Erfolg / Core goals and success | Clear | Sechs priorisierte Stories sowie `AC-CBG-001` bis `AC-CBG-010` |
| Ausdrückliche Nicht-Ziele / Explicit out of scope | Clear | Hard Stops, `CBG-019`, `CBG-021` und English Contract Summary |
| Rollen und Personas / Roles and personas | Clear | Maintainer, Flotten-Operator*innen, Repository-Verantwortliche und Reviewer |
| Entitäten, Attribute, Beziehungen / Entities, attributes, relationships | Clear | Acht Schlüsseldaten-Entitäten mit ihren bindenden Beziehungen |
| Identität und Eindeutigkeit / Identity and uniqueness | Clear | Stabile Registry-ID, genau ein Profil, HEAD und Gate-Set-Hash |
| Lebenszyklen und Zustände / Lifecycles and states | Clear | Evidence-Erzeugung, Invalidierung, Hard Stop, Stufe-A-Planung und Stufe-B-Handoff |
| Datenmenge und Größenannahmen / Data volume and scale assumptions | Clear | 48/47 als datierte Evidence; Live-Kardinalitäten sind bindend neu zu ermitteln |
| Kritische Nutzerabläufe / Critical user journeys | Clear | Stories 1 bis 6 mit unabhängigen Tests und Given/When/Then-Abnahme |
| Fehler-, Leer- und Wartezustände / Error, empty, and loading states | Clear | Fail-closed Live-Ausfall, Null-/Einzel-/Mehrfachziele und Evidence-Fehler sind abgedeckt; keine GUI-Warteansicht |
| Barrierefreiheit und Lokalisierung / Accessibility and localization | Clear | WCAG 2.2 AA soweit anwendbar, text-first, Deutsch zuerst/Englisch danach, CEFR B2 |
| Leistung und Durchsatz / Performance and throughput | Deferred-to-Plan | Kosten-, Job- und Monatsgrenzen sind bindend; interne Laufzeitbudgets und Messpunkte sind Planungsdetails |
| Skalierbarkeit und Grenzwerte / Scalability and limits | Clear | Live-Flotte, 47 spätere Ziele, sechs CaseTracker-Jobs und Null-/Einzel-/Mehrfachfixtures |
| Zuverlässigkeit und Wiederherstellung / Reliability and recovery | Clear | Fail-closed Verhalten, atomare Erfolgsevidence, Frischetoken und erneute Erzeugung |
| Beobachtbarkeit / Observability | Clear | Geordnete Einzelergebnisse, Status, Blocker, nächste Aktion, Kosten- und Rollout-Evidence |
| Sicherheit und Datenschutz / Security and privacy | Clear | Defense in Depth, Zero Trust, Datenminimierung, Secret-Verbot und unabhängiger Server-Gate |
| Compliance und Regulierung / Compliance and regulation | Clear | Vollständige Applicable-/N/A-Matrix mit Evidence und Re-Evaluation Triggern |
| Externe Dienste und Fehlermodi / External services and failure modes | Clear | GitHub nur read-only; Nichtverfügbarkeit stoppt fail-closed; keine Remote-Mutation |
| Import-/Exportformate / Import and export formats | Deferred-to-Plan | JSON-Pfad, Mindestfelder und Hash-Bindung sind bindend; genaue Schemaausprägung ist Planungsdetail |
| Protokoll- und Versionsannahmen / Protocol and version assumptions | Deferred-to-Plan | Git-, GitHub-, Bash- und PowerShell-Grenzen sind fest; konkrete read-only API-/CLI-Versionierung gehört in den Plan |
| Negative Szenarien / Negative scenarios | Clear | Randfälle und Negativfixtures decken Drift, Bypass, ungültige Evidence und Live-Ausfall ab |
| Rate Limits und Drosselung / Rate limiting and throttling | Deferred-to-Plan | Jeder nicht belegbare Live-Zustand stoppt bereits fail-closed; Retry-/Backoff-Mechanik ist Planungsdetail |
| Konfliktauflösung / Conflict resolution | Clear | HEAD-, Gate-Set-, Registry- und Live-Snapshot-Drift invalidieren Evidence statt Konflikte zu erraten |
| Technische Einschränkungen / Technical constraints | Clear | Level 0, Bash/PowerShell-Parität, lokale Evidence, read-only GitHub und keine neue vorausgesetzte Abhängigkeit |
| Abwägungen und verworfene Alternativen / Tradeoffs and rejected alternatives | Clear | Kein Hook als Einzelschutz, keine Self-hosted Runner, keine doppelte private CI, keine automatische Umklassifizierung |
| Kanonische Begriffe / Canonical glossary terms | Clear | Intake-Begriffe, fünf exakte Profilnamen und Schlüsseldaten-Glossar |
| Synonyme und veraltete Begriffe / Synonyms and deprecated terms | Clear | Stufe A/Stage A und `LocalImplementation` sind konsistent; keine konkurrierenden Profilnamen |
| Testbarkeit der Abnahme / Acceptance testability | Clear | Messbare ACs, Fixture-Verträge, deterministische Ausgaben und Traceability in beide Richtungen |
| Definition-of-Done-Signale / Definition of Done signals | Clear | Specify-Gates, Governance-Evidence, grüne Validatoren und dokumentierte Re-Evaluation |
| Platzhalter und offene Marker / Placeholders and open markers | Clear | Keine `[NEEDS CLARIFICATION]`, TODO-, TBD- oder FIXME-Marker |
| Unmessbare Adjektive / Unquantified adjectives | Clear | Begriffe wie schlank und pfadabhängig sind durch genau einen Gate, Pfadverträge, Job- und Budgetgrenzen prüfbar |

`Deferred-to-Plan` bezeichnet ausschließlich die Wahl interner Mechanismen
innerhalb bereits bindender Produkt-, Sicherheits- und Abnahmegrenzen. Keine
dieser Entscheidungen ändert Architekturziel, fachliches Datenmodell,
Task-Zuschnitt, Sicherheitsgrenze, Validierungsstrategie oder operative
Bereitschaft der Spezifikation.

*`Deferred-to-Plan` covers only internal mechanism choices within already
binding product, security, and acceptance boundaries. None changes the
specification's architecture goals, business data model, task decomposition,
security boundary, validation strategy, or operational readiness.*

## Konsistenzbestätigung / Consistency Confirmation

- Keine `[NEEDS CLARIFICATION]`-Markierung und kein TODO, TBD oder FIXME ist offen.
- Kein widersprüchlicher Scope verbleibt; die drei früheren Review-Findings sind geschlossen.
- Keine Sicherheits- oder Lieferentscheidung ist ungelöst.
- `spec.md` wurde in dieser Phase nicht geändert.

*No `[NEEDS CLARIFICATION]` marker, TODO, TBD, or FIXME remains. No
contradictory scope or unresolved security/delivery decision remains, and
`spec.md` was not changed in this phase.*

## Exakte Liefergrenze / Exact Delivery Boundary

**Stufe A / Stage A under `LocalImplementation`** darf ausschließlich
Level-0-eigene kanonische Profile, lokale Gates, HEAD-/Gate-Set-Evidence,
Hook-Logik, Workflow-/Ruleset-Templates, Simulationen, Tests, Statistik,
bilinguale Dokumentation und deterministische Rollout-Evidence ändern.

*Stage A under `LocalImplementation` may change only Level-0-owned canonical
profiles, local gates, HEAD/gate-set evidence, hook logic, workflow/ruleset
templates, simulations, tests, statistics, bilingual documentation, and
deterministic rollout evidence.*

Stufe A darf keines der 47 Zielrepositories ändern oder als remote konvergiert
bezeichnen. Verboten sind Commit, Push, Merge, Home-Sync, GitHub-Schreibzugriff,
Änderungen an aktiven Rulesets oder Account-Einstellungen, Admin-Bypass,
Zielrepository-Edits und der Start von G4. Die tatsächliche Änderung oder
Konvergenz der 47 Zielrepositories ist Stufe B und benötigt neue, ausdrückliche
Autorität.

*Stage A must not mutate any of the 47 target repositories or claim remote
convergence. Commit, push, merge, Home sync, GitHub writes, active ruleset or
account-setting changes, admin bypass, target-repository edits, and starting
G4 are forbidden. Actual mutation or convergence of the 47 target
repositories is Stage B and requires new explicit authority.*

## Phasengates / Phase Gates

| Gate | Ergebnis / Result | Evidence |
|---|---|---|
| `CLARIFY-GATE-001` | Pass | Verpflichtender Prerequisite-Pfadcheck exakt einmal erfolgreich ausgeführt |
| `CLARIFY-GATE-002` | Pass | Alle fünf akzeptierten Artefakt-Hashes stimmen mit dem Autonomous Run State überein |
| `CLARIFY-GATE-003` | Pass | Vollständiger Taxonomie-Scan ohne materielle offene Frage |
| `CLARIFY-GATE-004` | Pass | Null Fragen gestellt/beantwortet; `spec.md` unverändert |
| `CLARIFY-GATE-005` | Pass | Stufe-A-/`LocalImplementation`-Grenze und verbotene Operationen vollständig bestätigt |

## Dokumentationsauswirkung / Documentation Impact

`NoUpdateRequired`: Dieser Bericht ist der angeforderte Phasennachweis und
ändert weder den bindenden Featurevertrag noch eine kanonische Betriebs- oder
Nutzerdokumentation. Owner ist der Feature-Owner; Evidence ist diese Datei.
Re-Evaluation ist erforderlich, falls eine spätere Klarstellung `spec.md` oder
die Liefergrenze ändert.

*`NoUpdateRequired`: This report is the requested phase evidence and changes
neither the binding feature contract nor canonical operational or user
documentation. The feature owner owns this decision; this file is the
evidence. Re-evaluate if a later clarification changes `spec.md` or the
delivery boundary.*
