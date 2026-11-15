# Sicher entwickeln: Erkenntnisse aus Sicherheitsprüfungen

[English version: Secure development in practice](praxisleitfaden-sichere-entwicklung.en.md)

**Zielgruppe:** Auszubildende der vier IT-Berufe (Fachinformatik,
IT-System-Elektronik, IT-System-Management und Digitalisierungsmanagement)
sowie Entwicklerinnen und Entwickler ohne Sicherheits-Spezialwissen.

**Stand der Beispiele:** 15. November 2026. Die verlinkten Berichte beschreiben
jeweils einen geprüften historischen Stand. Dieser Leitfaden behauptet keinen
aktuellen Scan- oder Freigabestatus eines Repositories.

## Wozu dieser Leitfaden dient

Sicherer Code beginnt mit einer einfachen Frage: **Welche Daten darf ich nicht
als vertrauenswürdig behandeln?** Das können Eingaben aus einer Oberfläche,
Dateien im Repository, Konfiguration, ein heruntergeladenes Paket oder ein
Pfad aus einem Skriptparameter sein. Auch ein Repository, dessen Dateien sich
während eines einzelnen Prüflaufs nicht ändern, kann bösartige Inhalte
enthalten.

Dieser Text erklärt praktische Entscheidungen. Verbindliche Regeln stehen in
der [Leitlinie für sichere Programmierung](mitgeltende-dokumente/Leitlinie_Sichere-Programmierung.md),
der [Richtlinie für sichere Entwicklung](Richtlinie_Sichere-Entwicklung.md)
und den [Checklisten](checklisten/). Für eine konkrete Änderung gelten
zusätzlich deren projektspezifische `SECURITY.md`, Bedrohungsmodell und Tests.

**Nächste sichere Aktion:** Wähle einen Datenfluss deiner Aufgabe. Notiere
seinen Eingang, die Vertrauensgrenze, die Verarbeitung und die mögliche
Auswirkung. Prüfe dann die passende Regel und einen Gegenbeispiel-Test.

## Drei Begriffe, die man nicht verwechseln sollte

- Ein **Alert** ist ein Hinweis eines Werkzeugs wie CodeQL. Er zeigt einen
  möglichen Datenfluss oder ein Muster. Er beweist allein noch keine
  ausnutzbare Schwachstelle.
- Ein **bestätigter Fehler** hat eine nachvollziehbare Ursache und eine
  erreichbare Sicherheitsgrenze. Nach einer Korrektur braucht er einen Test
  und einen erneuten Scan auf der geprüften Revision.
- Ein **Fehlalarm** betrifft einen tatsächlich geprüften Datenfluss, der im
  festgehaltenen Bedrohungsmodell keine Sicherheitsgrenze verletzt. Die
  Begründung muss zum Repository, zur Regel, zum Pfad und zur analysierten
  Revision passen. Eine bloß ähnliche Datei reicht nicht.

Eine grüne CodeQL-Ausführung belegt, dass die konfigurierten Analysen liefen.
Sie belegt weder Fehlerfreiheit noch eine Prüfung von Bash, PowerShell,
Assembly oder anderen von CodeQL nicht analysierten Sprachen. Für solche
Sprachen sind passende Tests, Reviews und gegebenenfalls andere Werkzeuge
erforderlich. Siehe die [Einordnung gemeinsamer CodeQL-Befunde](../maintenance/codeql-shared-security-2026-11-13.md).

## Was die belegten Fälle zeigen

### Dateipfade und fremde Ziele

Ein Pfad, der als Text innerhalb eines Repositorys liegt, kann über einen
symbolischen Link zu einer Datei außerhalb führen. Bei Windows ist auch ein
Reparse Point relevant. Das gilt besonders für Löschen, Überschreiben,
Entpacken und das Erzeugen von Nachweisen. Prüfe deshalb die **physische**
Zielgrenze und die Art vorhandener Dateien, bevor ein Skript schreibt. Eine
rein lexikalische Prüfung auf `..` genügt nicht. Wenn sich ein Worktree
während der Prüfung ändern kann, muss auch diese Konkurrenzsituation im
Bedrohungsmodell und im Test berücksichtigt werden.

In Level 0 wurden unter anderem das Löschen eines nur teilweise erzeugten
Lernpaket-Ziels, physisch gebundene Feature-Nachweise und atomar ersetzte
CSV-Dateien korrigiert. Der [Korrekturbericht mit Alert-Zuordnung](../maintenance/level0-codeql-remediation-batch-2026-11-14.md)
nennt die einzelnen historischen Befunde und Testgrenzen.

### Prozesse, Konfiguration und CI-Rechte

Wenn Daten als Shell-Text ausgeführt werden, können Sonderzeichen eine
zusätzliche Anweisung bilden. Übergebe einem Prozess deshalb Programm und
Argumente getrennt. Eine Argumentliste ersetzt aber nicht die Prüfung, **ob
das gewählte Programm und sein Ziel überhaupt erlaubt sind**. Downloads und
Konfiguration brauchen nachvollziehbare Herkunft und gültige Formate.

Auch die CI ist ein Programm mit Rechten. Ein reiner Prüfworkflow braucht in
der Regel nur Leserechte. Der [Deep-Scan-Korrekturbericht](../security/deep-scan-high-remediation-2026-11-06.md)
dokumentiert unter anderem begrenzte Pfade, geprüfte Manifestwerte und
`contents: read` für einen erzeugten Prüfworkflow. Diese Beispiele sind
Lernfälle; sie sind keine pauschale Freigabe für andere Repositories.

### Nachweise, Scans und Verteilung

Eine Korrektur in einer gemeinsamen Quelle erreicht Verbraucher erst durch
deren vorgesehenen Verteilungsweg. Prüfe Paketversion, installierte Datei und
analysierte Revision getrennt. Ein alter Alert kann einen älteren Stand
betreffen; ein neuer Scan muss die tatsächlich ausgelieferte Revision
analysieren. Historische Artefakte werden dafür nicht umgeschrieben.

Ein Scanner kann einen echten Fehler übersehen oder einen ungefährlichen
Pfad melden. Deshalb ergänzen sich **Bedrohungsmodell, gezielter Test,
Code-Review und Scan**. Keiner dieser Nachweise ersetzt allein die anderen.

## Was speichersichere Sprachen leisten

Eine *Memory-Safe Language* (MSL) verhindert oder begrenzt typische Fehler
bei Speicherzugriffen. Sie prüft zum Beispiel Grenzen oder Besitzregeln.
Sie verhindert nicht automatisch SQL-Injection, unsichere Dateipfade,
fehlende Autorisierung, Datenabfluss, schädliche Abhängigkeiten oder
unbegrenzte Netzwerkzugriffe. Native Erweiterungen und `unsafe`-Bereiche
können zusätzliche Speichergrenzen öffnen.

Die [Sandbox-MSL-Einordnung](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/msl-applicability.md)
nennt sechs bereitgestellte Sprachfamilien. Die folgenden Hinweise gelten
auch außerhalb dieser Sandbox, müssen aber zum konkreten Projekt passen.

### C# und .NET

- **Typisches Risiko:** Eine Web-Anwendung übernimmt Eingaben direkt in SQL,
  HTML oder einen Dateipfad. Der Garbage Collector schützt davor nicht.
- **Sicherer Weg:** Datenbankparameter statt zusammengesetzter SQL-Texte
  nutzen, Ausgaben für ihren HTML-Kontext kodieren, Zugriffsrechte vor dem
  Lesen oder Schreiben prüfen und nur erlaubte Dateiziele verwenden.
- **Prüfung:** Mit Sonderzeichen, fremden IDs und einem Pfad außerhalb des
  vorgesehenen Bereichs testen. Ein abgewiesener Zugriff darf keine
  Verbindungszeichenkette oder einen Stacktrace an Nutzende ausgeben.

### Java

- **Typisches Risiko:** Ein DTO oder eine JSON-Datei ist syntaktisch gültig,
  enthält aber unzulässige Werte oder eine fremde Objekt-ID.
- **Sicherer Weg:** Eingaben beim Eintritt fachlich validieren, die
  Berechtigung für das konkrete Objekt prüfen, Datenbankzugriffe
  parametrisieren und Deserialisierung auf erwartete Typen begrenzen.
- **Prüfung:** Ungültige Werte, fremde IDs, große Datenmengen und
  unerwartete Typen testen. Fehlerantworten sollen verständlich sein und
  keine internen Details verraten.

### Go

- **Typisches Risiko:** Ein Dienst ruft eine vom Nutzer angegebene URL ab
  oder wartet unbegrenzt auf eine externe Antwort.
- **Sicherer Weg:** Erlaubte Ziele und Weiterleitungen prüfen, Timeouts
  setzen und `context` bis zum Netzwerkaufruf durchreichen. Für
  sicherheitsrelevante Zufallswerte `crypto/rand` verwenden.
- **Prüfung:** Interne oder unerlaubte Ziele, Redirects und langsame
  Antworten testen. Abbruch und Timeout müssen den Aufruf wirklich beenden.

### Rust

- **Typisches Risiko:** Nicht vertrauenswürdige Daten lösen einen `panic`
  aus; eine kleine `unsafe`-Stelle verletzt eine nicht dokumentierte
  Annahme.
- **Sicherer Weg:** Eingaben mit begrenzten Formaten einlesen, Fehler als
  `Result` behandeln und `unsafe` klein, begründet und überprüfbar halten.
  Grenzen zu fremden Bibliotheken und nativen Funktionen gesondert prüfen.
- **Prüfung:** Leere, überlange und fehlerhafte Eingaben sowie Grenzwerte
  testen. Ein Parserfehler darf den Dienst nicht unkontrolliert beenden.

### Python

- **Typisches Risiko:** Ein Skript öffnet einen Pfad aus JSON oder führt
  Eingabetext mit `eval`, `pickle` oder `shell=True` aus.
- **Sicherer Weg:** JSON auf erwartete Felder und Werte prüfen, Dateiziele
  physisch begrenzen und Prozesse mit einer Argumentliste starten. Für
  unbekannte Daten kein `pickle` oder `eval` einsetzen.
- **Prüfung:** Unbekannte Felder, Links aus dem Repository hinaus,
  Sonderzeichen in Argumenten und fehlgeschlagene Teiloperationen testen.
  Ein Dry-run darf nichts schreiben.

### Swift

- **Typisches Risiko:** Ein Force-Unwrap beendet die App bei fehlerhaften
  Daten; eine Datei-URL oder ein Netzwerkziel überschreitet die erlaubte
  Grenze.
- **Sicherer Weg:** Dekodierte Werte fachlich prüfen, optionale Werte
  kontrolliert behandeln und Datei-URLs auf den erlaubten Bereich begrenzen.
  Geheimnisse gehören in die Keychain; Kryptografie nutzt geeignete
  Plattform-APIs wie CryptoKit.
- **Prüfung:** Fehlende Felder, ungültige URLs und abgelaufene Zugriffsrechte
  testen. Die Anwendung soll eine verständliche Fehlermeldung anzeigen.

## Skripte sind ebenfalls sicherheitsrelevant

### Bash

Ein Bash-Skript kann Dateien löschen, Werkzeuge installieren oder
Repositories aktualisieren. Quote Variablen wie `"$path"`, beende Optionen
vor einem Dateinamen mit `--`, vermeide `eval` für fremde Daten und prüfe
Downloadquelle sowie Prüfsumme. `set -euo pipefail` hilft bei Fehlern,
ersetzt aber weder Eingabeprüfung noch sichere Löschgrenzen. Teste
Dateinamen mit Leerzeichen und führendem `-`, Symlinks, fehlende Werkzeuge
und den schreibfreien `--dry-run`.

### PowerShell 7

Nutze validierte Parameter und `-LiteralPath` für Pfade. Vermeide
`Invoke-Expression` auf nicht vertrauenswürdigem Text. `-WhatIf` und
`SupportsShouldProcess` zeigen die geplante Wirkung, bevor etwas geändert
wird; native Programme brauchen zusätzlich eine Prüfung ihres Exitcodes.
Teste Sonderzeichen, nicht vorhandene Ziele, Links und Windows-spezifische
Reparse Points. Bash-Dry-run und PowerShell-WhatIf sollen dieselbe
Sicherheitsentscheidung treffen.

Die [Sandbox-Regeln für Python, Bash und PowerShell](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/secure-coding-language-rules.md)
zeigen die dort geltenden zusätzlichen Skriptgrenzen.

## So prüfst du eine Änderung

1. **Schutzwert nennen:** Was darf nicht gelesen, verändert oder gelöscht
   werden? Wer darf die Aktion auslösen?
2. **Datenfluss zeichnen:** Woher kommt die Eingabe, wo wird sie geprüft und
   welche Datei, Datenbank, URL oder welcher Prozess nutzt sie?
3. **Grenze prüfen:** Ist der Pfad physisch begrenzt? Ist das Ziel erlaubt?
   Reichen die Rechte? Bleiben Secrets aus Logs und Fehlermeldungen heraus?
4. **Gegenprobe bauen:** Ein Test muss eine ungültige Eingabe abweisen und
   zeigen, dass bestehende Daten und erlaubte Funktionen erhalten bleiben.
5. **Werkzeuge lesen:** Scan-Alert, Regel, Pfad, Datenfluss und analysierte
   Revision prüfen. Bei Unklarheit `needs_review` festhalten, nicht raten.
6. **Auslieferung prüfen:** Nach einer Korrektur den exakten Stand in Quelle
   und Verbraucher prüfen. Ein grüner Scan ist ein Teilnachweis, keine
   allgemeine Sicherheitsfreigabe.

Für die Ausbildungsberufe unterscheidet sich der Schwerpunkt: Fachinformatik
prüft den Programmfluss; IT-System-Elektronik auch Geräte- und
Netzwerkgrenzen; IT-System-Management Rechte und Betriebsabläufe;
Digitalisierungsmanagement Datenwege und Zuständigkeiten. **Alle vier**
können denselben Datenfluss und dieselben Nachweise gemeinsam besprechen.

## Sandbox und Zugänglichkeit

Eine Sandbox begrenzt einen Agentenprozess, macht eingehende Dateien aber
nicht vertrauenswürdig. Mounts können echte Host-Dateien sichtbar machen;
Zugangsdaten gehören nicht in Prompts, Commits oder Audit-Exporte. Die
[Sandbox-Isolation](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/sandbox-isolation.md)
und ihr [Bedrohungsmodell](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/threat-model.md)
beschreiben die tatsächlichen Grenzen. Ein offener Punkt ist keine
stillschweigende Risikoakzeptanz.

Sicherheitsmeldungen und Prüfberichte müssen auch ohne Farbe verständlich
sein. Nenne Status und nächste Handlung als Text, benutze aussagekräftige
Linknamen und eine klare Überschriftenfolge. Ein Kommando darf keine
wichtige Rückfrage ausschließlich über Maus oder Farbe vermitteln.
Anwendbare WCAG-2.2-AA-Kriterien gelten für nutzerseitige Ausgaben und
Dokumentation; ein automatischer Check beweist keine vollständige
Barrierefreiheit.

## Weiterführende Quellen

- [Sicherheits-Code-Review-Checkliste](checklisten/CL_08_Sicherheits-Code-Review.md)
  und [Checkliste für KI-Codeerzeugung](checklisten/CL_09_KI-Codeerzeugung.md)
- [Lernpfad für sichere Entwicklung](Lernpfad_Sichere-Entwicklung_Lehrjahr-1-bis-3.md)
- [Deep-Scan-Korrekturbericht vom November 2026](../security/deep-scan-high-remediation-2026-11-06.md)
- [Level-0-CodeQL-Korrekturbericht vom November 2026](../maintenance/level0-codeql-remediation-batch-2026-11-14.md)
- [Einordnung gemeinsamer CodeQL-Befunde](../maintenance/codeql-shared-security-2026-11-13.md)

Diese Quellen sind technische Nachweise und Lernmaterial. Die konkrete
Sicherheitsentscheidung bleibt an Projekt, Bedrohungsmodell und geprüfte
Revision gebunden.
