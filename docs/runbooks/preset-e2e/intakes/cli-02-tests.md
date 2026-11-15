# Vorlage 2: CLI-Tests / Template 2: CLI tests

**Status:** Inaktive Vorlage. Erst nach belegtem Abschluss von CLI-Vorlage 1 instanziieren und prüfen.

**EN status:** Inactive template. Instantiate and review it only after CLI template 1 has a proven completion.

## Deutsch

**Auftrag:** Ergänze passende Unit-Tests für die Rechenlogik und Integrationstests für den tatsächlichen CLI-Aufruf in `<MSL>`. Prüfe alle vier Grundrechenarten, `1 / 2 = 0.5`, ungültige Eingaben und Division durch null.

**Abnahme:** Tests laufen ohne Benutzereingriff und vergleichen Ergebnis, Text-Fehler und Exit-Code. Dokumentiere Befehle, Anzahl, Plattform und fehlgeschlagene oder übersprungene Tests. Ein grüner Build ohne ausgeführte Tests genügt nicht.

**Abhängigkeit:** Bindend nach CLI-Vorlage 1. Nachfolger ist die TUI.

## English

**Request:** Add suitable unit tests for the domain logic and integration tests for the real `<MSL>` CLI invocation. Cover all four operations, `1 / 2 = 0.5`, invalid input and division by zero.

**Acceptance:** Tests run without user interaction and compare result, text error and exit code. Record commands, counts, platform, failures and skips. A green build without executed tests is insufficient.

**Dependency:** Binding after CLI template 1. The TUI follows.
