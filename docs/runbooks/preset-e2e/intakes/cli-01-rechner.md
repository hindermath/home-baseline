# Vorlage 1: CLI-Rechner / Template 1: CLI calculator

**Status:** Inaktive Vorlage. Für einen beauftragten Lauf `<MSL>`, Run-ID, Ziel-Repository und Abnahmeverantwortung einsetzen; danach erst Intake Authoring und Review ausführen.

**EN status:** Inactive template. For a requested run, fill in `<MSL>`, run ID, target repository and reviewer; only then use Intake Authoring and Review.

## Deutsch

**Auftrag:** Erstelle in `<MSL>` einen CLI-Taschenrechner für Addition, Subtraktion, Multiplikation und Division. Der Aufruf lautet `calc <left> <operation> <right>` mit `add`, `subtract`, `multiply` oder `divide`. Erfolg gibt nur die Zahl nach stdout aus und endet mit Exit-Code 0; Fehler geben verständlichen Text nach stderr aus und enden ungleich 0. Verwende keine dynamische Auswertung von Eingabetext.

**Abnahme:** Dokumentiere Aufruf und Exit-Codes. Belege `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` und `1 / 2 = 0.5`. Ungültige Eingaben und Division durch null liefern keinen Zahlenwert als Erfolg. Trenne Rechenlogik von Ein- und Ausgabe; halte Sicherheits- und Architekturentscheidungen fest.

**Abhängigkeit:** Erstes Serienmitglied; kein Vorgänger. Nachfolger ist Vorlage 2.

## English

**Request:** Create a CLI calculator in `<MSL>` for addition, subtraction, multiplication and division. Invoke it as `calc <left> <operation> <right>` with `add`, `subtract`, `multiply` or `divide`. Success prints only the number to stdout and exits 0; errors print clear text to stderr and exit non-zero. Do not evaluate input text dynamically.

**Acceptance:** Document invocation and exit codes. Prove `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` and `1 / 2 = 0.5`. Invalid input and division by zero must not return a numeric success result. Separate domain logic from input and output; record security and architecture decisions.

**Dependency:** First series member; no predecessor. Template 2 follows.
