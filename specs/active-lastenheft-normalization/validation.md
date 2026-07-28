# Validation Evidence: Active Lastenheft Series

## Aktueller Umfang / Current Scope

- Aktive Ziele / Active targets: 39
- Roots: 3
- Eindeutige Abhängigkeiten / Unique dependencies: 46
- Deklarierte `Eligible`-Kandidaten: genau Position 3
- Review-ID: `9eab8a9a-14be-401f-b002-719f4becc269`
- Supersedes: `292b5f47-6164-49a9-9107-b62a23a032a7`
- Findings, offene Fragen und akzeptierte Risiken: jeweils 0

Die Zahlen beschreiben die aktuelle vollständige Series. Historische
Normalisierungs- und Migrationsläufe bleiben unverändert in ihren jeweiligen
Archiven erhalten.

*These values describe the complete current series. Historical normalization
and migration runs remain unchanged in their respective archives.*

## Intake-Supersession

- Die Intake-ID `40faffea-1f68-416c-9ca3-d932c9a3fda1` bleibt erhalten.
- Der frühere Zielstand und sein Receipt sind bytegleich unter der neuen
  Operations-ID archiviert.
- Das neue Schema-2.0-Receipt verwendet Authoring Governance v0.3.0,
  nachvollziehbare geordnete Quellen und `MergeAndSync`.
- PWH-001 bis PWH-015 und AC-001 bis AC-017 bleiben erhalten.
- PWH-016 bis PWH-020 und AC-018 bis AC-027 binden dynamische Preset-Profile,
  die Features 015/016, exakte Bereinigungsfreigaben, begrenzte
  Netzwerk-Evidence und die Zielrepository-Grenze.

*The stable intake identity and archived predecessor are preserved. The new
schema-2.0 receipt binds Authoring Governance v0.3.0, ordered evidence, and
`MergeAndSync`. Existing requirements remain, while the added requirements
cover dynamic profiles, prior regression contracts, exact cleanup authority,
bounded network evidence, and target-repository delivery boundaries.*

## Series- und Review-Bindung

- Series-ID, 39 Ziele, drei Roots, 46 Abhängigkeiten, Rollen, Reihenfolge und
  Status sind unverändert.
- Nur der normalisierte Hash des in-place aktualisierten Intake wurde im
  Series-Manifest ersetzt.
- Alter Series-Receipt, altes Series-Manifest sowie der frühere Review-Request,
  das Ergebnis und der Bericht sind bytegleich archiviert.
- Der neue Schema-1.1-Review bindet seinen Request per normalisiertem SHA-256.
- Bash- und PowerShell-Validatoren akzeptieren Intake, Receipt,
  Series-Manifest, Series-Receipt und Review-Ergebnis jeweils ohne Befund.

*Series identity and structure remain unchanged. Only the updated intake hash
was replaced. Previous series and review artifacts are archived byte-for-byte,
the new schema-1.1 result is hash-bound to its request, and both validator
implementations pass.*

## Liefergrenze / Delivery Boundary

Dieser Auftrag aktualisiert nur Intake-, Receipt-, Series- und Review-Evidence.
Er startet weder Specify noch Autonomous, Feature 017 oder die Wartungs-TUI.
`MergeAndSync` autorisiert nur diese Intake-Lieferung und den später ausdrücklich
gestarteten Feature-017-Lauf im Home-Baseline-Repository.

*This work updates only intake, receipt, series, and review evidence. It starts
neither Specify nor Autonomous, Feature 017, nor the maintenance TUI.
`MergeAndSync` authorizes only this intake delivery and a later explicitly
started Feature 017 run in Home Baseline.*
