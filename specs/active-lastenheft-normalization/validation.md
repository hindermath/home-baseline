# Validation Evidence: Active Lastenheft Series

## Aktueller Umfang / Current Scope

- Aktive Ziele / Active targets: 37
- Roots: 3
- Eindeutige Abhaengigkeiten / Unique dependencies: 44
- Bevorzugte `Eligible`-Kandidaten: genau D4
- Review-ID: `7fd2b056-6e21-4108-bf09-237f294a6024`
- Supersedes: `31370a44-3c7a-4e7e-a9db-ac82bfa533d3`
- Findings, offene Fragen und akzeptierte Risiken: jeweils 0

Die Werte beschreiben die vollstaendige aktive Serie nach dem kausalen
Closeout von Feature 018 und der anschließenden D4-In-place-Supersession.
Historische Reviews und Series-Staende bleiben bytegleich in ihren Archiven
erhalten.

*These values describe the complete active series after the causal Feature 018
closeout and the subsequent in-place D4 supersession. Historical reviews and
series states remain byte-identical in their archives.*

## Feature-Abschluss / Feature Closeout

- PR #160 mergte den exakten Feature-Head
  `64df267a9fb4c695e142de3ae5654f6edc3af149` als
  `65693ef5981f93a54d1c230df4da1715bf13f877`.
- Das Lastenheft ist unveraendert als
  `Lastenheft_Agentic-Workspace-Maintenance-TUI.018-agentic-workspace-tui.md`
  archiviert.
- Position 4 und ihre einzelne Kante zu D4 wurden aus der aktiven Serie
  entfernt.
- D4 ist jetzt `Primary`, Root und der einzige `Eligible`-Kandidat.
- Feature 018 erweitert keine Zielrepository-, Provider-, Bereinigungs- oder
  Administratorautoritaet.

*PR #160 merged the exact reviewed feature head. The unchanged intake is
archived, item 4 and its single outgoing edge were removed, and D4 is now
Primary, a root, and the sole Eligible candidate. Feature 018 grants no
maintenance-target or provider authority.*

## Series- und Review-Bindung

- Die Series-ID bleibt unveraendert.
- D4 behält Pfad, Intake-ID, Rolle `Primary`, Root-Status und `Eligible`;
  ausschließlich sein normalisierter Hash wurde aktualisiert.
- Der vorherige 37-Ziel-Stand sowie sein Receipt sind unter
  `history/7862b534-0dd3-4ebb-9db4-ca27135155bb/` bytegleich archiviert.
- Der vorherige 38-Ziel-Stand mit 45 Kanten sowie sein Receipt sind unter
  `history/57442be4-5c21-43d4-a3cd-d46690aaa62d/` bytegleich archiviert.
- Das aktuelle Manifest umfasst 37 Ziele, drei Roots und 44 Kanten.
- Der neue Schema-1.1-Review bindet seinen Request per normalisiertem
  SHA-256.
- Bash- und PowerShell-Validatoren akzeptieren Series-Manifest,
  Series-Receipt und Review-Ergebnis ohne Befund.

*The series ID is unchanged. The prior 38-target, 45-edge state and its receipt
are archived byte-for-byte. The current manifest contains 37 targets, three
roots, and 44 edges. The new schema-1.1 result is hash-bound to its request and
accepted by both validator implementations.*

## Liefergrenze / Delivery Boundary

Diese Aktualisierung ersetzt D4 und seine Evidence in-place, ohne einen
Featurelauf zu starten. `Eligible` beschreibt die fachliche Reihenfolge und
erteilt keine Feature-, Remote-, Merge- oder Administratorautoritaet.

*This update supersedes D4 and its evidence in place without starting a
feature run. Eligible describes sequence readiness and grants no feature,
remote, merge, or administrator authority.*
