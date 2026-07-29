# ADR-001: Wartungs-TUI bleibt Darstellungsschicht

**Status**: Accepted
**Datum / Date**: 2026-07-29

## Kontext / Context

Die Ein-Kommando-Wartung benötigt für Lernende und Maintainer eine sichere,
verständliche Terminalauswahl. Features 015 bis 017 haben die
Bash-/PowerShell-Engines und den Python-Vertragskern bereits gehärtet.

## Entscheidung / Decision

Eine .NET-10-Anwendung mit Spectre.Console übernimmt Auswahl, Erklärung,
Live-Darstellung und Ergebnisabgleich. Alle Wartungsoperationen bleiben in den
vorhandenen Engines. Die TUI startet sie genau einmal mit typisierten
Argumenten. JSONL-Ereignisse sind advisory; der atomare Bericht und
Prozess-Exit bleiben kanonisch.

*A .NET 10 application owns selection, explanation, live presentation, and
result reconciliation. All maintenance operations remain in the existing
engines. JSONL events are advisory; atomic report and process exit remain
canonical.*

## Folgen / Consequences

- Positive Folge: keine doppelte Git-, Paket- oder Plattformlogik.
- Positive Folge: Enhanced-, Plain- und Headless-Pfade teilen dieselben
  Engine-Grenzen.
- Aufwand: neue Lockfiles, lokaler Build-Cache und Drei-Plattform-Tests.
- Restrisiko: ein kompromittiertes lokales Konto bleibt außerhalb der
  Anwendungsgrenze.

## Verwarfene Alternativen / Rejected Alternatives

- Engine nach C# portieren: zu breite Revision und Regressionsrisiko.
- stdout parsen: kein stabiler Vertrag.
- Nach Enginefehler in Plain erneut starten: könnte Mutationen duplizieren.
- Binärdatei einchecken: schwächere Herkunfts- und Plattformkontrolle.

<!-- EN: docs/security/adr/ADR-001-maintenance-tui-boundary.md
[DE-Zusammenfassung: Die TUI präsentiert; vorhandene Skripte bleiben alleinige Engine.]
-->
