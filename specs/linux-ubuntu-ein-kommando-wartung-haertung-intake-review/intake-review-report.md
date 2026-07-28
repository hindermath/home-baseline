# Intake Review: Linux-/Ubuntu-Haertung der Ein-Kommando-Wartung

## Identitaet / Identity

- Review-ID: `48ca0b20-22e0-47f0-bee0-a19672c48b42`
- Modus / Mode: `Single`
- Policy: `home-baseline-active-lastenhefte-v1`
- Ergebnis / Outcome: `Ready`
- Ziel / Target:
  `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md`
- Normalized SHA-256:
  `b9b6c57e89a0fa58199879a41306239f3dedcb5961e72cb81dc67f204d4d38f4`
- Git-Blob: `N/A`, weil der gepruefte Worktree-Inhalt noch nicht als
  passendes Git-Objekt vorliegt.
- Ziele / Targets: `1`
- Worker: `0`

## Ergebnis / Outcome

Der Intake ist fuer die fachliche Spec-Kit-Uebergabe konsistent. Identitaet,
Zielgruppe, Zweck, Scope, Nicht-Ziele, Delivery Authority und Abschlussgrenze
sind eindeutig. LUM-001 bis LUM-011 sind unterscheidbar und durch AC-001 bis
AC-015 messbar abgedeckt. Die neuen Grenzen fuer Admin-Prompt-Autoritaet,
CLI-Nutzbarkeit, Capability-Sperren und abbruchfeste Berichtsfinalisierung
widersprechen den bestehenden stdin-, Required-, Swift- und
Supply-Chain-Anforderungen nicht.

*The intake is internally consistent for its functional Spec Kit handoff.
Identity, audience, purpose, scope, non-goals, delivery authority, and
completion boundary are explicit. LUM-001 through LUM-011 are distinguishable
and measurably covered by AC-001 through AC-015. The new admin-authority,
CLI-usability, capability, and interruption-safe reporting boundaries do not
conflict with the existing input, required-tool, Swift, or supply-chain
requirements.*

## Checklistenabdeckung / Checklist Coverage

- Identitaet, Maintainer-Zielgruppe, Zielzustand und Nicht-Ziele: `PASS`
- Atomare und testbare Anforderungen: `PASS`, LUM-001 bis LUM-011
- Messbare Abnahme und erwartete Evidence: `PASS`, AC-001 bis AC-015
- Historische Baseline, Root-Position 2 und TUI-HardCompletionGate: `PASS`
- Delivery Authority und Remote-Grenze: `PASS`, `LocalImplementation`
- Sicherheit, Privilegiengrenze, Supply Chain und Secret-Schutz: `PASS`
- Barrierefreiheit, lineare Textausgabe und DE-vor-EN-Vertrag: `PASS`
- Linux-/Ubuntu-, macOS- und PowerShell-Paritaetsgrenzen: `PASS`
- Specify-/Autonomous-Prompt gegen normative IDs und Grenzen: `PASS`
- Striktes UTF-8, kein NUL, keine Credential-Muster oder unnoetigen
  personenbezogenen Daten: `PASS`
- Lernendenvertrag: `N/A`; die erklaerte Zielgruppe sind Maintainer, nicht
  Lernende. Die Darstellung bleibt dennoch textorientiert und zweisprachig.

## Findings, Risiken und Fragen / Findings, Risks, and Questions

- Critical: `0`
- High: `0`
- Medium: `0`
- Low: `0`
- Accepted risks: `0`
- Open questions: `0`

## Provenienz und Abgrenzung / Provenance and Boundary

Diese Single-Review ersetzt fuer genau den Linux-Intake die durch den
Target-Hashwechsel ungueltige Abdeckung der Series-Review
`47c855a9-b945-4e95-bcaa-9db9a2e5b6f1`. Sie erneuert keine Series-DAG-Review.
Der Intake bleibt aufgrund der unabhaengig verwalteten Manifestreihenfolge
`Eligible`; `Ready` erteilt weder Implementierungs- noch Commit-, Push-, PR-
oder Merge-Autoritaet.

*For this Linux target only, this Single review replaces the target coverage
invalidated in Series review `47c855a9-b945-4e95-bcaa-9db9a2e5b6f1`. It does
not refresh the Series DAG. The intake remains `Eligible` because of the
independently managed manifest order; `Ready` grants no implementation,
commit, push, pull-request, or merge authority.*

## Naechste Aktion / Next Action

```text
$speckit-intake-review specs/active-lastenheft-normalization/intake-review-request.json
```

Die naechste Aktion ist eine ausdrueckliche Series-Review zur Erneuerung der
weiterhin supersedierten Series-Evidence. Sie startet weder Specify noch einen
Autonomous-Lauf.

*The exact next action is an explicit Series review to refresh the still
superseded Series evidence. It starts neither Specify nor an autonomous run.*
