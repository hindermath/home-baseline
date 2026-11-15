# Vorlage 2: Web-Tests / Template 2: Web tests

**Status:** Inaktive Vorlage. Erst nach belegtem Abschluss des HTTP-Rechners instanziieren und prüfen.

**EN status:** Inactive template. Instantiate and review it only after the HTTP calculator has a proven completion.

## Deutsch

**Auftrag:** Ergänze Unit-Tests für die Rechenlogik und Integrationstests gegen den lokalen HTTP-Vertrag in `<MSL>`. Prüfe gültige Rechnungen, `1 / 2 = 0.5`, ungültige Eingaben, Division durch null, HTTP-Status und sichere Fehlerantworten.

**Abnahme:** Tests laufen ohne Benutzereingriff und benötigen keine öffentlich erreichbare Anwendung. Belege Befehle, Anzahl, Plattform, Testadresse sowie Fehler und Skips. Eine erfolgreiche Antwort auf nur einen Happy Path genügt nicht.

**Abhängigkeit:** Bindend nach Web-Vorlage 1. Die Weboberfläche folgt.

## English

**Request:** Add unit tests for the calculator logic and integration tests for the local `<MSL>` HTTP contract. Cover valid calculations, `1 / 2 = 0.5`, invalid input, division by zero, HTTP status and safe error responses.

**Acceptance:** Tests run without user interaction and need no publicly reachable app. Record commands, counts, platform, test address, failures and skips. One successful happy-path response is insufficient.

**Dependency:** Binding after web template 1. The web UI follows.
