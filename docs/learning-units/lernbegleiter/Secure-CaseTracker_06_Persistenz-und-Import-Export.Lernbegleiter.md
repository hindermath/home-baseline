# Lernbegleiter: Secure CaseTracker 06 – Persistenz, Import und Export / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Daten müssen gespeichert (**Persistenz**), eingelesen (**Import**) und wieder herausgegeben
(**Export**) werden. Genau hier lauern typische Fehler: **unsichere Deserialisierung** (aus einer Datei wird
gefährlicher Code), **Pfadfehler** (`../` führt aus dem erlaubten Ordner heraus) und **unnötige
Datenweitergabe** (der Export enthält Felder, die niemand braucht). In dieser Einheit planst du eine einfache,
sichere Persistenzform und legst klare Regeln für Import und Export fest: Pfade begrenzen, importierte Daten
nach dem Einlesen erneut fachlich prüfen und beim Export nur die wirklich nötigen Felder ausgeben.

**EN:** Data must be stored (**persistence**), read in (**import**), and given out again (**export**). Exactly
here typical mistakes lurk: **unsafe deserialization** (a file turns into dangerous code), **path errors**
(`../` leads out of the allowed folder), and **unnecessary data disclosure** (the export contains fields
nobody needs). In this unit you plan a simple, safe persistence form and set clear rules for import and
export: limit paths, re-validate imported data functionally after reading, and export only the truly needed
fields.

**DE:** Erlaubt sind für Lernzwecke JSON, SQLite oder eine sprachübliche Alternative. Import und Export nutzen
denselben fachlichen Datenvertrag wie das Domänenmodell.

**EN:** For learning purposes, JSON, SQLite, or a language-common alternative is allowed. Import and export use
the same functional data contract as the domain model.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhaftes Speichern von Daten, z. B. in Datei oder Datenbank. |
| Deserialisierung / Deserialization | Umwandlung gespeicherter Daten zurück in Objekte im Programm. |
| Pfad-Kanonisierung / Path canonicalization | Pfad in eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Datenvertrag / Data contract | Verbindliche Struktur, an die sich Import und Export halten. |
| Exportprofil / Export profile | Festlegung, welche Felder ein bestimmter Export enthält. |
| Parametrisierte Abfrage / Parameterized query | SQL mit Platzhaltern, das Eingaben nicht als Code interpretiert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Persistenzform wählen und begründen.** Entscheide dich für JSON, SQLite oder eine
sprachübliche Alternative und begründe die Wahl. Warum begründen? Jede Form hat Grenzen; eine dokumentierte
Entscheidung macht spätere Änderungen und Tests nachvollziehbar.

**EN:** **Step 1 – Choose and justify the persistence form.** Decide on JSON, SQLite, or a language-common
alternative and justify the choice. Why justify? Each form has limits; a documented decision makes later
changes and tests traceable.

**DE:** **Schritt 2 – Sicher deserialisieren.** Nutze sichere Parser und keine gefährlichen Formate: kein
`pickle` aus Importdaten (Python), keine native Java-Serialisierung, restriktive Jackson/Gson-Konfiguration,
`serde` mit Domänenvalidierung (Rust), `Codable` mit Validierung (Swift), `System.Text.Json` ohne unsichere
Formatter (C#). Warum? Unsichere Deserialisierung kann beim Einlesen fremden Code ausführen.

**EN:** **Step 2 – Deserialize safely.** Use safe parsers and no dangerous formats: no `pickle` from import
data (Python), no native Java serialization, restrictive Jackson/Gson configuration, `serde` with domain
validation (Rust), `Codable` with validation (Swift), `System.Text.Json` without unsafe formatters (C#). Why?
Unsafe deserialization can execute foreign code while reading.

**DE:** **Schritt 3 – Pfade begrenzen und nach dem Parsen erneut validieren.** Normalisiere jeden Dateipfad
und prüfe, ob er im erlaubten Verzeichnis liegt. Validiere importierte Daten nach dem Einlesen erneut gegen die
Domänenregeln. Warum doppelt prüfen? Ein gültiges Dateiformat bedeutet nicht gültige Fachdaten; erst die
Domänenprüfung schützt das Modell.

**EN:** **Step 3 – Limit paths and re-validate after parsing.** Normalize every file path and check that it
lies inside the allowed directory. Re-validate imported data against the domain rules after reading. Why check
twice? A valid file format does not mean valid business data; only the domain check protects the model.

**DE:** **Schritt 4 – Export datensparsam gestalten.** Unterscheide ein vollständiges Lernexport-Profil von
einem datensparsamen Auswertungsprofil. Nicht benötigte Felder werden nicht exportiert. Datenbank- oder
Dateifehler dürfen keine internen Details an Endnutzer ausgeben. Warum? Ein Export ist eine Datenweitergabe;
zu viele Felder verletzen leicht den Datenschutz.

**EN:** **Step 4 – Make export data-minimal.** Distinguish a complete learning-export profile from a
data-minimal analysis profile. Fields that are not needed are not exported. Database or file errors must not
reveal internal details to end users. Why? An export is a data disclosure; too many fields easily violate
privacy.

**DE:** **Typische Fehler.** Unsichere Deserialisierungsformate. Pfade ohne Kanonisierung akzeptieren.
Importierte Daten nur formal, aber nicht fachlich prüfen. Alle Felder exportieren. SQL ohne Parametrisierung.
Interne Fehlermeldungen an Endnutzer.

**EN:** **Common mistakes.** Unsafe deserialization formats. Accepting paths without canonicalization.
Checking imported data only formally, not functionally. Exporting all fields. SQL without parameterization.
Internal error messages to end users.

### Beispiel / Example

```text
Import (JSON):     Datei case-import.json  ->  Parser liest Struktur  ->  Domaenenvalidierung (Status gueltig?)
Pfad-Eingabe:      "../../secrets/config"  ->  kanonisieren  ->  liegt NICHT im Import-Ordner  ->  ABGELEHNT
SQL (SQLite):      SELECT * FROM cases WHERE id = ?   (Platzhalter, NICHT id = '" + input + "')
Exportprofil A:    Lernexport  -> alle fachlichen Felder (fiktive Daten)
Exportprofil B:    Auswertung  -> nur status, createdAt, closedAt  (kein Name, keine Notiz)
Fehlermeldung:     "Import fehlgeschlagen: ungueltiges Statusfeld."  (kein Stack-Trace, kein Pfad)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Persistenz, Import und Export sind Kernfunktionen der Datenverwaltung. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Import und Export stellen Daten über Systemgrenzen hinweg bereit. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Datenschutz und Supply-Chain-Bezug
bei Serialisierungsbibliotheken. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Bibliotheken), `CL_08` (Sicherheits-Code-Review) und `CL_11` (Datenschutz/Datenqualität). Die
Sicherheitsentscheidung dieser Einheit lautet: *Importe werden nach dem Einlesen erneut fachlich validiert,
Pfade werden begrenzt, und der Export bleibt datensparsam.* A11Y-Aspekt: Fehlermeldungen bei Import/Export
sind klarer Text ohne interne Details und ohne reine Farbsignale, damit sie mit Screenreader und Braille-Zeile
nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, privacy, and supply-chain relevance of
serialization libraries. Matching checklists: `CL_01` (standards applicability), `CL_05`
(dependencies/libraries), `CL_08` (security code review), and `CL_11` (privacy/data quality). The security
decision of this unit is: *imports are re-validated functionally after reading, paths are limited, and export
stays data-minimal.* Accessibility aspect: import/export error messages are clear text without internal
details and without color-only signals, so they remain usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist unsichere Deserialisierung gefährlich? /
   **EN:** Why is unsafe deserialization dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Manche Formate können beim Einlesen Objekte erzeugen oder Code ausführen. Aus einer harmlos
   aussehenden Datei kann so ein Angriff werden. Sichere Parser und Formate verhindern das.
   **EN:** Some formats can create objects or execute code while reading. A harmless-looking file can thus turn
   into an attack. Safe parsers and formats prevent this.

   </details>

2. **DE:** (AE) Welche Daten müssen nach dem Einlesen erneut validiert werden? /
   **EN:** (AE) Which data must be re-validated after reading?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Alle importierten Fachdaten gegen die Domänenregeln, z. B. gültige Zustände und Pflichtfelder. Ein
   gültiges Dateiformat garantiert keine gültigen Fachdaten.
   **EN:** All imported business data against the domain rules, e.g. valid states and mandatory fields. A valid
   file format does not guarantee valid business data.

   </details>

3. **DE:** (SI) Wo darf die Anwendung Dateien lesen oder schreiben, und wie wird das erzwungen? /
   **EN:** (SI) Where may the application read or write files, and how is that enforced?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur in klar erlaubten Verzeichnissen. Erzwungen wird das durch Kanonisierung des Pfads und Prüfung,
   ob er im erlaubten Ordner liegt; `../`-Ausbrüche werden abgelehnt.
   **EN:** Only in clearly allowed directories. Enforced by canonicalizing the path and checking that it lies
   inside the allowed folder; `../` escapes are rejected.

   </details>

4. **DE:** (DPA) Welche Exportdaten reichen für Kennzahlen aus, ohne unnötige personenbezogene Daten? /
   **EN:** (DPA) Which export data is enough for metrics without unnecessary personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Meist Status, Zeitstempel und Fallzähler. Namen, Freitexte und Kontaktdaten sind für Kennzahlen
   unnötig und werden im Auswertungsprofil weggelassen.
   **EN:** Usually status, timestamps, and case counters. Names, free text, and contact data are unnecessary
   for metrics and are left out in the analysis profile.

   </details>

5. **DE:** Warum werden zwei Exportprofile unterschieden? /
   **EN:** Why are two export profiles distinguished?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein vollständiges Lernexport-Profil dient dem Lernen mit fiktiven Daten, ein datensparsames
   Auswertungsprofil schützt beim Weitergeben vor unnötiger Datenpreisgabe.
   **EN:** A complete learning-export profile serves learning with fictitious data, a data-minimal analysis
   profile protects against unnecessary data disclosure when sharing.

   </details>

6. **DE:** Warum darf eine Datenbank- oder Dateioperation keine internen Details an Endnutzer ausgeben? /
   **EN:** Why must a database or file operation not reveal internal details to end users?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Interne Meldungen wie Pfade oder SQL-Fehler helfen Angreifern und verletzen den Datenschutz. Nutzer
   bekommen eine klare, allgemeine Meldung; Details bleiben im internen Log.
   **EN:** Internal messages such as paths or SQL errors help attackers and violate privacy. Users get a clear,
   general message; details stay in the internal log.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Persistenzform wählen und die Entscheidung begründen.
- [ ] unsichere Deserialisierungsformate benennen und vermeiden.
- [ ] Dateipfade kanonisieren und auf erlaubte Verzeichnisse begrenzen.
- [ ] importierte Daten nach dem Einlesen erneut fachlich validieren.
- [ ] ein datensparsames Exportprofil von einem vollständigen unterscheiden.

**EN:** I can …

- [ ] choose a persistence form and justify the decision.
- [ ] name and avoid unsafe deserialization formats.
- [ ] canonicalize file paths and limit them to allowed directories.
- [ ] re-validate imported data functionally after reading.
- [ ] distinguish a data-minimal export profile from a complete one.

## Kaufmännische Rollen-Umschaltung / Commercial Role Switch

**DE:** Dies ist die **SQL-Schlüsseleinheit** für beide kaufmännischen Berufe (Grundlage:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
Hier findet der verpflichtende **SQL-Schreib-Touch** statt. SQL ist die deklarative
Brücken-Programmiersprache: Du beschreibst das Ergebnis, der Agent trägt das „Wie".

- **KITSM (minimaler Touch):** Schreibe **eine** parametrisierte Abfrage selbst, z. B. „Cases eines
  Kunden" (`... WHERE CustomerID = ?`). Zusätzlich eine kleine **Konfig-/Parameter-Änderung** (z. B.
  Import-Timeout). Kein dynamisches SQL aus Eingaben.
- **KDM (Authoring):** Schreibe eine parametrisierte **Prozesskennzahl-Abfrage** (z. B. „Cases je
  Status") selbst und rechne das Ergebnis gegen einen festen Testanker.
- **Abnahme (evidenzbasiert), eingebaute Abweichung:** Im Datenzugriffs-/Import-Code des Agenten ist
  eine Stelle **nicht parametrisiert** (String-Verkettung) oder eine Filterspalte fehlt der Allowlist.
  Finde diese Stelle in der Abnahme und lehne ab, bis sie parametrisiert ist.

**EN:** This is the **SQL key unit** for both commercial occupations and hosts the mandatory **SQL write
touch** (basis:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
KITSM writes one parameterized query (e.g. "cases of a customer") plus a small config change. KDM
authors a parameterized process-metric query (e.g. "cases per status") and checks it against a fixed
test anchor. Evidence-based acceptance: one spot in the agent's data-access/import code is not
parameterized (string concatenation) or a filter column is missing from the allowlist — find it and
reject until fixed.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
