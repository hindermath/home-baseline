# Workitem: Wartungs-Toolchain-JSON-Ergebnishärtung / Maintenance Toolchain JSON Result Hardening

- Status: umgesetzt / implemented
- Owner: Level-0-Wartungsskript-Maintainer
- Datum / Date: 2026-08-09
- Ursprung / Origin: Modell-Routing-Flottenabschluss
- Entscheidung / Decision: `FollowUp`

## Anlass / Motivation

Der skriptbezogene Modell-Routing-Pfad und `--scripts-only` sind grün. Der
vollständige Ein-Kommando-Check kann jedoch beim Einlesen einer fehlenden oder
leeren Datei `agentic-toolchain-<run-id>.json` mit einem allgemeinen
JSON-Parserfehler abbrechen. Ein fehlender Ergebnisvertrag darf nicht als
Parserausnahme oder impliziter Erfolg erscheinen.

*The script-only model-routing path is green. The full one-command check can
still fail with a generic JSON parser error when an expected
`agentic-toolchain-<run-id>.json` file is missing or empty. A missing result
contract must never become an unclassified parser exception or an implicit
success.*

## Zielvertrag / Target Contract

- Producer schreiben Ergebnisdateien atomar über einen laufbezogenen
  temporären Pfad und eine abschließende Umbenennung.
- Consumer prüfen vor dem Parsen Existenz, Dateityp, Mindestgröße, UTF-8 und
  erwartete JSON-Struktur.
- Fehlend, leer, abgeschnitten und syntaktisch ungültig erhalten stabile,
  blockierende Status- und Exitklassen mit genauer nächster Aktion.
- Der Orchestrator erzeugt genau einen kanonischen Abschlussstatus; ein früher
  Fehler darf keine widersprüchliche Erfolgsevidence hinterlassen.
- Bash und PowerShell bleiben semantisch äquivalent.
- Modell-Routing-, Preset-, Provider- und Delivery-Verträge bleiben außerhalb
  dieses Follow-ups.

*Producers publish results atomically. Consumers validate existence, size,
UTF-8, and schema before parsing. Missing, empty, truncated, and malformed
results receive stable blocking outcomes with one exact next action. Bash and
PowerShell remain equivalent.*

## Abnahme / Acceptance

- Positive Fixture für ein vollständiges gültiges Ergebnis.
- Negative Fixtures für fehlende, leere, abgeschnittene, syntaktisch ungültige
  und schemafremde Ergebnisse.
- Kein Stacktrace und keine rohe Parserfehlermeldung in nutzerseitiger Ausgabe.
- Report, Prozess-Exitcode und textorientierte Zusammenfassung stimmen überein.
- Vorschau-, Check-only-, Scripts-only-, Enhanced-, Plain- und Headless-Modus
  regressieren nicht.
- Windows-, macOS- und Linux-Nachweise verwenden dieselben Statusklassen.

## Abschlussnachweis / Closeout Evidence

Der begrenzte Wartungs-Follow-up wurde nach reproduzierter Leerausgabe direkt
umgesetzt. Producer schreiben auch auf fruehen Fehlerpfaden atomare
Fehlerergebnisse; Consumer verwenden stabile Fehlerklassen. Positive und
negative Fixtures decken gueltige, fehlende, leere, abgeschnittene,
syntaktisch fehlerhafte, nicht als UTF-8 lesbare und schemafremde Ergebnisse
ab. Die bestehende Windows-Orchestrierung erzeugt keinen separaten
Toolchain-Dateivertrag und bleibt daher funktional unveraendert; ihre
Abschlussklassen `Passed`, `Blocked` und `Failed` entsprechen weiterhin dem
gemeinsamen Orchestratorvertrag.

*The narrowly reproduced maintenance follow-up was implemented directly.
Producers publish atomic failure results on early exits, and consumers use
stable failure classes. Positive and negative fixtures cover valid, missing,
empty, truncated, malformed, non-UTF-8, and schema-mismatched results. The
Windows orchestrator has no separate toolchain-file contract and therefore
remains functionally unchanged; its completion classes still match the shared
orchestrator contract.*
