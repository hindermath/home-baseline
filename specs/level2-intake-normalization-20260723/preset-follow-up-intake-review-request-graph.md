# Preset Follow-up: Intake Review Request Graph Validation

## Entscheidung / Decision

`Promote`

## Beobachtung / Observation

Die Bash- und PowerShell-Ergebnisvalidatoren von
`intake-review-governance` v0.1.0 pruefen Review-Ergebnis, Zielhashes und
Evidence, validieren aber die Kanten des zugehoerigen Series-Request-Graphen
nicht vollstaendig. Eine syntaktisch gueltige Request-Datei kann daher eine
fehlende, doppelte oder fachlich widerspruechliche Vorgaengerkante enthalten,
ohne dass der Result-Validator dies meldet.

Der Feldlauf in `SecureServiceHarvester-CSharp` reproduzierte die Grenze. Ein
unabhaengiger Graph-Auditor erkannte und korrigierte eine Zwischenfassung vor
der Abnahme. Die finale Serie ist konsistent; es liegt kein offener
Repositorybefund vor.

## Generische Zielregel / Generic Target Rule

Bei `mode: Series` sollen beide portablen Validatoren zusaetzlich pruefen:

- jede Request-Ziel-ID und jeder Zielpfad ist eindeutig;
- jede Graphkante referenziert zwei vorhandene, verschiedene Ziele;
- doppelte Kanten und Zyklen werden abgelehnt;
- die deklarierte Reihenfolge und die Vorgaengerkanten widersprechen sich
  nicht;
- Result-Ziele und Request-Ziele bilden dieselbe Menge;
- fehlende Graph-Evidence kann nicht durch ein formal gueltiges
  `Ready`-Ergebnis verdeckt werden.

*For series reviews, both portable validators should validate target identity,
edge integrity, acyclicity, declared ordering, and request/result set parity.*

## Reproduktion / Reproduction

1. Einen gueltigen Series-Request mit mindestens drei Zielen und einem
   `Ready`-Ergebnis erzeugen.
2. Im Request eine Kante entfernen, duplizieren oder auf ein unbekanntes Ziel
   umbiegen.
3. Die v0.1.0-Bash- und PowerShell-Ergebnisvalidatoren ausfuehren.
4. Aktueller Befund: Der Ergebnisvertrag kann weiterhin bestehen.
5. Erwartung: Beide Validatoren lehnen die manipulierte Serie deterministisch
   und mit derselben Fehlerklasse ab.

## Promotion-Grenze / Promotion Boundary

Die Korrektur gehoert in einen begrenzten Folge-PR des
Intake-Review-Presets. Er benoetigt positive und negative
Bash-/PowerShell-Fixtures, Paritaetsnachweis, Paket-/ZIP-Smoke und danach die
normale optionale Flottenadoption. Diese Kampagne veraendert oder
veroeffentlicht das Preset nicht stillschweigend.

Owner: Home Baseline / Intake Review Governance

Confidence: High

Occurrence count: 1 reproduced field occurrence

Security impact: Integrity of series ordering and review evidence

Re-evaluation trigger: Next Intake Review Governance maintenance release
