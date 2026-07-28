# Contract: Run Finalization

Normaler Abschluss, ungefangener Fehler, `INT` und `TERM` rufen denselben
idempotenten Finalisierer auf. Eine Guard-Variable erlaubt genau einen
Abschluss. Der aktuelle Run ID, die zuletzt gestartete Stage, Signal oder
Fehler, Gesamtstatus, Exitcode und nächste Aktion werden in eine temporäre
Schwesterdatei geschrieben und atomar ersetzt.

| Klasse | Gesamtstatus | Exitcode |
|---|---|---:|
| Sollzustand erreicht | `SUCCESS` | 0 |
| nur optionale Warnung | `SUCCESS_WITH_WARNINGS` | 0 |
| Required-Drift oder Admin-Deferred | `PARTIAL` | 1 |
| Vertrags-/Betriebsfehler | `FAILED` | 2 |
| `INT` | `INTERRUPTED` | 130 |
| `TERM` | `INTERRUPTED` | 143 |

Ein früherer Erfolgsstatus darf einen späteren Fehler oder Signalabbruch nicht
überleben. Terminal, Log, Report und Prozess liefern denselben Endzustand.
