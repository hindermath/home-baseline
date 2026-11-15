# Vorlage 1: HTTP-Rechner / Template 1: HTTP calculator

**Status:** Inaktive Vorlage. Für einen beauftragten Lauf `<MSL>`, Run-ID, Ziel-Repository und Abnahmeverantwortung einsetzen; danach erst Intake Authoring und Review ausführen.

**EN status:** Inactive template. For a requested run, fill in `<MSL>`, run ID, target repository and reviewer; only then use Intake Authoring and Review.

## Deutsch

**Auftrag:** Erstelle in `<MSL>` eine lokale Web-Anwendung für vier Grundrechenarten. `POST /calculate` nimmt JSON mit `left`, `operation` (`add`, `subtract`, `multiply`, `divide`) und `right` entgegen. Erfolg liefert HTTP 200 mit `{"result": <number>}`; ungültige Eingaben oder Division durch null liefern HTTP 400 mit `{"error": "<text>"}`. `GET /` darf bis zum Oberflächen-Feature eine einfache Textseite liefern. Trenne Rechenlogik vom HTTP-Eingang. Keine externe Veröffentlichung oder dynamische Auswertung von Eingabetext.

**Abnahme:** Belege `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` und `1 / 2 = 0.5`. Ungültige Eingaben und Division durch null liefern verständliche Fehler mit passenden HTTP-Status und keinen scheinbar erfolgreichen Zahlenwert. Halte Eingabe-, Ausgabe- und Netzwerkgrenzen sowie Architekturentscheidungen fest. Dieses Feature verlangt noch keine grafische Oberfläche.

**Abhängigkeit:** Erstes Serienmitglied; kein Vorgänger. Nachfolger ist Vorlage 2.

## English

**Request:** Create a local `<MSL>` web app for the four operations. `POST /calculate` accepts JSON with `left`, `operation` (`add`, `subtract`, `multiply`, `divide`) and `right`. Success returns HTTP 200 with `{"result": <number>}`; invalid input or division by zero returns HTTP 400 with `{"error": "<text>"}`. `GET /` may show a simple text page until the UI feature. Separate domain logic from HTTP input. Do not publish externally or evaluate input text dynamically.

**Acceptance:** Prove `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` and `1 / 2 = 0.5`. Invalid input and division by zero return clear errors with suitable HTTP status, not a plausible numeric success result. Record input, output and network boundaries and architecture decisions. A graphical UI is not required in this feature.

**Dependency:** First series member; no predecessor. Template 2 follows.
