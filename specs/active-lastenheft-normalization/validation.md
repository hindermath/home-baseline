# Validation Evidence: Active Lastenheft Series

## Aktueller Umfang / Current Scope

- Aktive Ziele / Active targets: 36
- Roots: 3
- Eindeutige Abhängigkeiten / Unique dependencies: 43
- Bevorzugte `Eligible`-Kandidaten: genau D5
- Review-ID: `dddd6822-7bd8-4f45-889c-18b2052c49ba`
- Supersedes: `1c3aae4c-af2f-41e7-90c9-9208f56f1059`
- Findings, offene Fragen und akzeptierte Risiken: jeweils 0

Die Werte beschreiben die vollständige aktive Serie nach dem kausalen
Closeout von Feature 020. Historische Reviews und Series-Stände bleiben
bytegleich in ihren Archiven erhalten.

*These values describe the complete active series after the causal Feature 020
closeout. Historical reviews and series states remain byte-identical in their
archives.*

## Feature-Abschluss / Feature Closeout

- PR #194 mergte den exakten Feature-Head
  `c968cdf34bdcf470d4b4f77c7b7b6c6a453e6fab` als
  `3880b161d452891e35c5ec7eb0b28d86351d92f8`.
- Das unveränderte D4-Lastenheft ist als
  `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.020-documentation-architecture-audit.md`
  archiviert.
- Alle 26 technischen Jobs bestanden auf macOS, Ubuntu und Windows.
- Neun Gate-Anforderungen bestanden beide Exact-Head-Validatoren.
- Der umsetzbare Copilot-Befund wurde korrigiert und der Thread aufgelöst.
- D4 und seine einzelne ausgehende Kante wurden aus der aktiven Serie entfernt.
- D5 ist jetzt `Primary`, Root und der einzige bevorzugte `Eligible`-Kandidat.

*PR #194 merged the exact reviewed Feature 020 head. The unchanged intake is
archived, D4 and its single outgoing edge were removed, and D5 is now Primary,
a root, and the sole preferred Eligible candidate.*

## Series- und Review-Bindung

- Die Series-ID bleibt unverändert.
- Der vorherige 37-Ziel-Stand und sein Receipt sind unter
  `history/891f2bea-7f11-4692-84c1-82bfb5f1faf3/` bytegleich archiviert.
- Das aktuelle Manifest umfasst 36 Ziele, drei Roots und 43 Kanten.
- D5 bindet PR, Head, Merge, Audit-Kardinalitäten und `DIA001` aus Feature 020.
- Der D5-Einzelreview `414d968c-87c3-4860-8366-6f90dc9490b1` und der
  Series-Review sind jeweils `Ready`.
- Bash- und PowerShell-Validatoren akzeptieren Authoring-Receipt,
  Series-Manifest, Series-Receipt und beide Review-Ergebnisse.

*The series ID is unchanged. The prior 37-target state and receipt are archived
byte-for-byte. The current manifest contains 36 targets, three roots, and 43
edges. D5 binds the actual Feature 020 delivery evidence and `DIA001`; both
reviews are Ready in Bash and PowerShell.*

## Liefergrenze / Delivery Boundary

`Eligible` beschreibt die fachliche Reihenfolge und erteilt keine Feature-,
Remote-, Merge- oder Administratorautorität. Dieser Closeout startet D5 oder
einen anderen Spec-Kit-Lauf nicht automatisch.

*Eligible describes sequencing readiness and grants no feature, remote, merge,
or administrator authority. This closeout does not start D5 or another Spec Kit
run automatically.*
