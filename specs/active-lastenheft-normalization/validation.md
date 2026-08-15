# Validation Evidence: Active Lastenheft Series

## Aktueller Umfang / Current Scope

- Aktive Ziele / Active targets: 34
- Roots: 1
- Eindeutige Abhaengigkeiten / Unique dependencies: 40
- Bevorzugter `Eligible`-Kandidat: genau G2A
- Review-ID: `bdd15623-d2b5-47eb-8600-73c546e5fdf9`
- Supersedes: `f6eaf048-c26b-408b-aa10-38efeb127593`
- Findings, offene Fragen und akzeptierte Risiken: jeweils 0

Die Werte beschreiben das zeitlich begrenzte Evidence-Integrity-Gate vor den
bisherigen Roots 7, 9 und 10. Historische Reviews und Series-Staende bleiben
bytegleich in ihren Archiven erhalten.

*These values describe the temporary evidence-integrity gate before previous
roots 7, 9, and 10. Historical reviews and series states remain byte-identical
in their archives.*

## Series- und Review-Bindung

- Die Series-ID bleibt unveraendert.
- Der vorherige 32-Ziel-Stand und sein Receipt sind unter
  `requirements/intakes/series/home-baseline-delivery/history/b6e3a616-53c7-4731-9e4e-69daad598f9e/`
  bytegleich archiviert.
- Der vorherige Review ist unter
  `specs/active-lastenheft-normalization/history/f6eaf048-c26b-408b-aa10-38efeb127593/`
  bytegleich archiviert.
- Das aktuelle Manifest umfasst 34 Ziele, eine Root und 40 Kanten.
- Der neue Schema-1.1-Series-Review ist `Ready` und bindet seinen Request-Hash.
- G2A und G2B besitzen zusaetzlich jeweils einen aktuellen `Ready`-Einzelreview.
- Bash- und PowerShell-Validatoren akzeptieren Manifest, Receipt und alle drei
  Review-Ergebnisse.

*The series ID is unchanged. The prior 32-target state, receipt, and review are
archived byte-for-byte. The current manifest contains 34 targets, one root, and
40 edges. Both validator implementations accept the bound series review and
the two single-target reviews.*

## Liefergrenze / Delivery Boundary

`Eligible` erteilt keine Feature-, Remote-, Merge- oder
Administratorautoritaet. Die aktuelle Benutzeranweisung erlaubt die Umsetzung
des genehmigten Plans im Delivery Mode `MergeAndSync`; ein Admin-Bypass wurde
fuer diesen Auftrag nicht abgeleitet. G2B, Release und Rollout bleiben bis zum
nachweisbaren G2A-Closeout blockiert.

*Eligible grants no feature, remote, merge, or administrator authority. The
current instruction permits the approved plan in `MergeAndSync` mode; no admin
bypass was inferred for this request. G2B, release, and rollout remain blocked
until G2A is demonstrably complete.*
