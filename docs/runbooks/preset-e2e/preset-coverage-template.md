# Leere Preset-Abdeckungsmatrix / Blank preset coverage matrix

Diese Matrix wird für **einen** beauftragten Lauf kopiert. Statuswerte: `bestanden`, `fehlgeschlagen`, `blockiert`, `nicht anwendbar`. Eine Installation allein ist kein Funktionsnachweis. Über A und B zusammen muss jede Zeile mindestens einmal funktional bestanden sein; das Parallel-Preset wird in B und D ausgeführt.

Copy this matrix for **one** requested run. Use `passed`, `failed`, `blocked` or `not applicable`. Installation alone is not functional evidence. Across A and B, each row must pass functionally at least once; exercise the parallel preset in B and D.

| Preset | Version + Hash | Konkreter Aufruf / Invocation | Erwartetes Artefakt / Expected artifact | Ergebnis / Result | Beleg / Evidence |
|---|---|---|---|---|---|
| security-governance | _auszufüllen_ | _auszufüllen_ | Eingabe-/Ausführungsgrenzen | _auszufüllen_ | _auszufüllen_ |
| secure-development-assurance-governance | _auszufüllen_ | _auszufüllen_ | Assurance-Entscheidung | _auszufüllen_ | _auszufüllen_ |
| architecture-governance | _auszufüllen_ | _auszufüllen_ | Architekturentscheidung | _auszufüllen_ | _auszufüllen_ |
| isaqb-architecture-governance | _auszufüllen_ | _auszufüllen_ | Qualitätsszenario | _auszufüllen_ | _auszufüllen_ |
| a11y-governance | _auszufüllen_ | _auszufüllen_ | A11Y-Prüfpfad | _auszufüllen_ | _auszufüllen_ |
| cross-platform-governance | _auszufüllen_ | _auszufüllen_ | Plattform-/Testvertrag | _auszufüllen_ | _auszufüllen_ |
| agent-parity-governance | _auszufüllen_ | _auszufüllen_ | Agentenflächen-Vergleich | _auszufüllen_ | _auszufüllen_ |
| model-routing-governance | _auszufüllen_ | _auszufüllen_ | gebundene Vorprüfung | _auszufüllen_ | _auszufüllen_ |
| intake-authoring-governance | _auszufüllen_ | _auszufüllen_ | vier erstellte Lastenhefte | _auszufüllen_ | _auszufüllen_ |
| intake-review-governance | _auszufüllen_ | _auszufüllen_ | semantische Review | _auszufüllen_ | _auszufüllen_ |
| intake-sequencing-governance | _auszufüllen_ | _auszufüllen_ | validierte Serie | _auszufüllen_ | _auszufüllen_ |
| autonomous-run-governance | _auszufüllen_ | _auszufüllen_ | Featurezustand | _auszufüllen_ | _auszufüllen_ |
| parallel-autonomous-run-governance | _auszufüllen_ | _auszufüllen_ | Kampagnenzustand B/D; A/C begründet N/A | _auszufüllen_ | _auszufüllen_ |
| project-statistics-governance | _auszufüllen_ | _auszufüllen_ | reproduzierbare Statistik | _auszufüllen_ | _auszufüllen_ |

## Negativ-Gates / Negative gates

DE: Die [Bash- und PowerShell-7-Beispiele](shell-examples.md) zeigen lesende Status- und Hashprüfungen. Erfasse die tatsächlich benutzte Shell und den ausgeführten Aufruf; ein Beispiel ist kein Nachweis.

EN: The [Bash and PowerShell 7 examples](shell-examples.md#english) show read-only state and digest checks. Record the shell and invocation actually used; examples are not evidence.

| Gate und getrennte Fixture / Gate and separate fixture | Erwarteter Abbruch / Expected stop | Tatsächliches Ergebnis / Actual result | Beleg / Evidence |
|---|---|---|---|
| _auszufüllen / to fill_ | _auszufüllen / to fill_ | _auszufüllen / to fill_ | _auszufüllen / to fill_ |

**DE:** Pro Preset sind Aufruf, Wirkung und Beleg nötig. Ein `blockiert`, `fehlgeschlagen` oder unbegründetes `nicht anwendbar` verhindert die Aussage „alle 14 bestanden“. Beschädige für Negativtests keinen aktiven Lauf.

**EN:** Each preset needs an invocation, observed behavior and evidence. `Blocked`, `failed` or unjustified `not applicable` prevents a claim that all 14 passed. Never damage an active run for a negative test.
