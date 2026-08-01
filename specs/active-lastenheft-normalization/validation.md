# Validation Evidence: Active Lastenheft Series

## Aktueller Umfang / Current Scope

- Aktive Ziele / Active targets: 35
- Roots: 3
- Eindeutige Abhängigkeiten / Unique dependencies: 42
- Bevorzugte `Eligible`-Kandidaten: genau D6
- Review-ID: `8ea4fe3c-73c2-43d1-89a7-4823d4dc048e`
- Supersedes: `dddd6822-7bd8-4f45-889c-18b2052c49ba`
- Findings, offene Fragen und akzeptierte Risiken: jeweils 0

Die Werte beschreiben die vollständige aktive Serie nach dem kausalen
Closeout von Feature 021. Historische Reviews und Series-Stände bleiben
bytegleich in ihren Archiven erhalten.

*These values describe the complete active series after the causal Feature 021
closeout. Historical reviews and series states remain byte-identical in their
archives.*

## Feature-Abschluss / Feature Closeout

- PR #197 mergte den exakten Feature-Head
  `663807ef0cd19c245fb171bc017dda5d5f84209a` als
  `468924a261996dd245f8f21e4e6693fd2cbe513c`.
- Das D5-Lastenheft ist als
  `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.021-level0-documentation-architecture.md`
  archiviert.
- Alle 26 technischen Jobs bestanden auf macOS, Ubuntu und Windows.
- Sieben Gate-Anforderungen bestanden beide Exact-Head-Validatoren.
- Alle fünf Copilot-Befunde wurden korrigiert; der letzte Exact-Head-Review ist
  `Ready to approve`, und es bleiben null offene Threads.
- D5 und seine einzelne ausgehende Kante wurden aus der aktiven Serie entfernt.
- D6 ist jetzt `Primary`, Root und der einzige bevorzugte `Eligible`-Kandidat.

*PR #197 merged the exact reviewed Feature 021 head. The intake is archived,
D5 and its single outgoing edge were removed, and D6 is now Primary, a root,
and the sole preferred Eligible candidate.*

## Series- und Review-Bindung

- Die Series-ID bleibt unverändert.
- Der vorherige 36-Ziel-Stand und sein Receipt sind unter
  `history/d14a8efb-4cfd-473a-b409-9d5c3f71434d/` bytegleich archiviert.
- Das aktuelle Manifest umfasst 35 Ziele, drei Roots und 42 Kanten.
- D6 bindet Features 018 bis 021 sowie die aktuelle Portal-, Leserpfad-,
  Skript-, Manpage-, Report- und Documentation-Impact-Evidence.
- Der D6-Einzelreview `89bbb2fa-8b91-41b4-a1f6-887436d6ee37` und der
  Series-Review sind jeweils `Ready`.
- Bash- und PowerShell-Validatoren akzeptieren Authoring-Receipt,
  Series-Manifest, Series-Receipt und beide Review-Ergebnisse.

*The series ID is unchanged. The prior 36-target state and receipt are archived
byte-for-byte. The current manifest contains 35 targets, three roots, and 42
edges. D6 binds the actual Feature 018 through 021 delivery evidence; both
reviews are Ready in Bash and PowerShell.*

## Liefergrenze / Delivery Boundary

`Eligible` beschreibt die fachliche Reihenfolge und erteilt keine Feature-,
Remote-, Merge- oder Administratorautorität. Dieser Closeout startet D6 oder
einen anderen Spec-Kit-Lauf nicht automatisch.

*Eligible describes sequencing readiness and grants no feature, remote, merge,
or administrator authority. This closeout does not start D6 or another Spec Kit
run automatically.*
