# Intake Review: Flottenweite CI-Budget-Governance und Actions-Rationalisierung

## Identitaet / Identity

- Review-ID: `694b6579-3443-4c9e-8017-8c7b285dae0f`
- Modus / Mode: `Single`
- Policy: `home-baseline-active-lastenhefte-v1`
- Ergebnis / Outcome: `Ready`
- Ziel / Target:
  `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md`
- Normalized SHA-256:
  `48a0560280842535d1b847ebca7387768d52d10ecae31e12ed177566375c2610`
- Git-Blob: `N/A` (aktuell reparierter Working-Tree-Inhalt)
- Ziele / Targets: `1`
- Worker: `0`
- Supersedes: `9ab74f34-7b6c-4f7c-9a54-558e10328c2d`

## Ergebnis / Outcome

Das reparierte Lastenheft ist fuer Specify bereit. Der vollstaendige Re-Review
hat keine offenen Findings, Fragen, akzeptierten Risiken oder
Operator-Ausnahmen ergeben. Die drei zuvor blockierenden Punkte sind durch
ausdrueckliche Benutzerentscheidungen und konsistente Anforderungen,
Abnahmekriterien, Ergebnisartefakte, Hard Stops sowie Copy-Ready-Prompts
geschlossen.

Die Live-Inventur bestaetigt erneut 48 Git-Repositories, davon 27 privat und 21
oeffentlich; kein Repository besitzt einen fehlenden Default-Branch. Diese
Zahlen bleiben datierte Evidence. Der neue Profilvertrag bindet stattdessen
jede stabile Registry-ID explizit und stoppt bei unbekannter, fehlender,
doppelter oder sichtbarkeitswidriger Zuordnung fail-closed.

*The repaired intake is ready for Specify. The complete re-review found no open
findings, questions, accepted risks, or operator exceptions. Live evidence
again confirms 48 Git repositories: 27 private and 21 public, all with a
default branch. Those counts remain dated evidence; the binding contract is the
versioned registry-ID mapping with fail-closed drift handling.*

## Geschlossene Findings / Resolved Findings

| ID | Vorher / Previous | Reparatur und Nachweis / Repair and evidence |
|---|---|---|
| `IR001` | High: Der lokale Hook war keine vollstaendige Sicherheitsgrenze. | `CBG-003`, `CBG-014`, `CBG-018`, `AC-CBG-002` und `AC-CBG-007` verlangen jetzt einen schlanken, unabhaengigen und ruleset-verpflichtenden serverseitigen PR-Gate. Hook-Umgehung ersetzt weder PR- noch Statuspflicht. |
| `IR002` | High: Flottenweite Zielwirkung widersprach `LocalImplementation`. | `CBG-021`, Ergebnisartefakte, Hard Stops, Stufe-A-Abnahmen und beide Prompts trennen die lokale Level-0-Implementierung von einem separat autorisierten Stufe-B-Flotten-Rollout. |
| `IR003` | Medium: Feste Profilzahlen kollidierten mit Live-Drift. | `CBG-002` definiert eine versionierte Zuordnung je stabiler Registry-ID, explizite Sichtbarkeitskompatibilitaet und fail-closed Stopps. `3/6/6/21/12` ist nur der Snapshot vom 19. August 2026. |

## Vollstaendige Checklistenabdeckung / Complete Checklist Coverage

- Identitaet, Zielgruppe, Zweck, Scope und Nicht-Ziele: `PASS`
- Vorwissen und erstmalige Begriffserklaerung: `PASS`
- Atomare Anforderungen `CBG-001` bis `CBG-021`: `PASS`
- Messbare Stufe-A-Abnahme `AC-CBG-001` bis `AC-CBG-010`: `PASS`
- Security-, Mutation-, Push-, PR- und Statusgrenze: `PASS`
- Hook-Installation, Versionsfrische und unabhaengige Servergrenze: `PASS`
- Delivery Authority, lokale Stufe A und separater Flotten-Handoff: `PASS`
- Deterministische Profilklassifikation und Re-Evaluation: `PASS`
- Budgetmodell und getrennte Minimal-Gate-Messung: `PASS`
- Datenschutz, Secrets und Datenminimierung: `PASS`
- Barrierefreiheit, textorientierte Ausgabe, WCAG 2.2 AA und CEFR B2: `PASS`
- Deutsch zuerst, Englisch danach: `PASS`
- Bash-/PowerShell- und Plattformvertrag: `PASS`
- Specify-/Autonomous-Prompt-Ausrichtung: `PASS`
- Striktes UTF-8, kein NUL und kein Binaerinhalt: `PASS`

## Governance- und Seriengrenze / Governance and Series Boundary

Die Schema-2.0-Konfiguration meldet `Aligned`. Die aktive Serie ist nach der
hash-only Aktualisierung in Bash und PowerShell gueltig: 34 Ziele, drei Roots,
38 Abhaengigkeiten und genau ein deklarierter `Eligible`-Kandidat. Position,
Rolle, Root-Zugehoerigkeit und bindende G4-Kante blieben unveraendert.

`Ready` und `Eligible` erteilen keine Implementierungs-, Commit-, Push-,
Merge-, Bypass- oder Flotten-Rollout-Autoritaet. Der Single-Review ersetzt
keinen vollstaendigen Series-DAG-Review.

*Schema-2.0 governance is aligned. After the hash-only update, Bash and
PowerShell validators accept the active series with 34 targets, three roots, 38
dependencies, and one declared Eligible candidate. Ready and Eligible grant no
implementation or remote-delivery authority.*

## Risiken und Fragen / Risks and Questions

- Critical: `0`
- High: `0`
- Medium: `0`
- Low: `0`
- Akzeptierte Risiken / Accepted risks: `0`
- Offene Fragen / Open questions: `0`
- Operator-Ausnahmen / Operator exceptions: `0`

## Dokumentationsauswirkung / Documentation Impact

`UpdateRequired`, in dieser Reparatur erfuellt:

- Kanonische Quelle und Owner: das deutsche und englische Lastenheft,
  `home-baseline intake owner`.
- Betroffene Leserpfade: Maintainer, Flotten-Operator*innen,
  Repository-Verantwortliche und Reviewer ueber Lastenheft, Specify-Prompt und
  Autonomous-Prompt.
- Aktualisierte Dokumentklasse: versioniertes bilinguales Intake mit
  Authoring-, Review- und Serien-Evidence.
- Navigation und Sprachpartner bleiben im gemeinsamen Dokument synchron.
- Distributionsklasse: `source-only`; kein Home-Sync erforderlich.
- Re-Evaluation: Aenderung der Sicherheitsgrenze, Delivery Authority,
  Stufentrennung, Registry-ID-Klassifikation, Sichtbarkeit oder Flottenstruktur.

## Naechste Aktion / Next Action

```text
$speckit-specify Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md
```

Dieser Schritt wird nicht automatisch gestartet.

*This step is not started automatically.*
