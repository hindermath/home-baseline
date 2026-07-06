# Lernbegleiter: Secure ServiceHarvester 06 – Persistenz, Import und Export / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_06_Persistenz-Import-und-Export.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester sammelt Statusdaten von Maschinen. Diese Daten müssen gespeichert
(**Persistenz**), teils eingelesen (**Import**, z. B. eine CSV-Liste bekannter Maschinen) und wieder
herausgegeben (**Export**) werden. Genau hier lauern typische Fehler: **unsichere Deserialisierung** (aus
einer Datei wird gefährlicher Code), **Pfadfehler** (`../` führt aus dem erlaubten Ordner heraus) und
**unnötige Datenweitergabe** (der Export enthält Felder, die niemand braucht). Damit der Dienst später die
Speicherform wechseln kann, planst du eine **austauschbare Ablage** (Backend-Abstraktion): Die Kernlogik
spricht mit einem einfachen Vertrag, egal ob dahinter JSON, SQLite oder eine andere Form steckt.

**EN:** The Secure ServiceHarvester collects machine status data. This data must be stored (**persistence**),
partly read in (**import**, e.g. a CSV list of known machines), and given out again (**export**). Exactly here
typical mistakes lurk: **unsafe deserialization** (a file turns into dangerous code), **path errors** (`../`
leads out of the allowed folder), and **unnecessary data disclosure** (the export contains fields nobody
needs). So the service can later switch storage form, you plan an **exchangeable storage backend** (backend
abstraction): the core logic talks to a simple contract, no matter whether JSON, SQLite, or another form sits
behind it.

**DE:** In dieser Einheit legst du eine einfache, sichere Persistenzform fest und setzt klare Regeln für Import
und Export: Pfade begrenzen, importierte CSV-Daten nach dem Einlesen erneut fachlich prüfen und beim Export nur
die wirklich nötigen Felder ausgeben. Import und Export nutzen denselben fachlichen Datenvertrag wie das
Domänenmodell (name, os, last_contact).

**EN:** In this unit you set a simple, safe persistence form and clear rules for import and export: limit
paths, re-validate imported CSV data functionally after reading, and export only the truly needed fields.
Import and export use the same functional data contract as the domain model (name, os, last_contact).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhaftes Speichern von Daten, z. B. in Datei oder Datenbank. |
| Ablage-Abstraktion / Storage abstraction | Austauschbares Backend hinter einem festen Datenvertrag. |
| Deserialisierung / Deserialization | Umwandlung gespeicherter Daten zurück in Objekte im Programm. |
| Pfad-Kanonisierung / Path canonicalization | Pfad in eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Datenvertrag / Data contract | Verbindliche Struktur, an die sich Import und Export halten. |
| Exportprofil / Export profile | Festlegung, welche Felder ein bestimmter Export enthält. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ablage-Abstraktion und Persistenzform wählen.** Beschreibe einen einfachen Vertrag zum
Speichern und Lesen (z. B. „speichere Snapshot", „lies alle Maschinen") und entscheide dich dahinter für JSON,
SQLite oder eine sprachübliche Alternative. Begründe die Wahl. Warum eine Abstraktion? So kann der Dienst
später die Speicherform wechseln, ohne die Kernlogik umzubauen.

**EN:** **Step 1 – Choose storage abstraction and persistence form.** Describe a simple contract for storing
and reading (e.g. "store snapshot", "read all machines") and behind it decide on JSON, SQLite, or a
language-common alternative. Justify the choice. Why an abstraction? So the service can later switch storage
form without rebuilding the core logic.

**DE:** **Schritt 2 – Sicher deserialisieren und CSV importieren.** Nutze sichere Parser und keine gefährlichen
Formate: kein `pickle` aus Importdaten (Python), keine native Java-Serialisierung, restriktive Jackson/Gson-
Konfiguration, `serde` mit Domänenvalidierung (Rust), `Codable` mit Validierung (Swift), `System.Text.Json`
ohne unsichere Formatter (C#). Beim CSV-Import gilt: Trennzeichen, Spaltenzahl und Datentypen prüfen. Warum?
Unsichere Deserialisierung kann beim Einlesen fremden Code ausführen, und CSV-Felder können Steuerzeichen oder
Formeln enthalten.

**EN:** **Step 2 – Deserialize safely and import CSV.** Use safe parsers and no dangerous formats: no `pickle`
from import data (Python), no native Java serialization, restrictive Jackson/Gson configuration, `serde` with
domain validation (Rust), `Codable` with validation (Swift), `System.Text.Json` without unsafe formatters
(C#). For CSV import: check separator, column count, and data types. Why? Unsafe deserialization can execute
foreign code while reading, and CSV fields can contain control characters or formulas.

**DE:** **Schritt 3 – Pfade begrenzen und nach dem Parsen erneut validieren.** Normalisiere jeden Dateipfad
und prüfe, ob er im erlaubten Verzeichnis liegt. Validiere importierte Daten nach dem Einlesen erneut gegen die
Domänenregeln (z. B. gültiger `os`-Wert, plausibler `last_contact`). Warum doppelt prüfen? Ein gültiges
CSV-Format bedeutet nicht gültige Fachdaten; erst die Domänenprüfung schützt das Modell.

**EN:** **Step 3 – Limit paths and re-validate after parsing.** Normalize every file path and check that it
lies inside the allowed directory. Re-validate imported data against the domain rules after reading (e.g.
valid `os` value, plausible `last_contact`). Why check twice? A valid CSV format does not mean valid business
data; only the domain check protects the model.

**DE:** **Schritt 4 – Export datensparsam gestalten.** Unterscheide ein vollständiges Lernexport-Profil von
einem datensparsamen Auswertungsprofil. Nicht benötigte Felder werden nicht exportiert. Datei-, Datenbank-
oder Ablagefehler dürfen keine internen Details an Endnutzer ausgeben. Warum? Ein Export ist eine
Datenweitergabe über Systemgrenzen; zu viele Felder verletzen leicht den Datenschutz.

**EN:** **Step 4 – Make export data-minimal.** Distinguish a complete learning-export profile from a
data-minimal analysis profile. Fields that are not needed are not exported. File, database, or storage errors
must not reveal internal details to end users. Why? An export is a data disclosure across system boundaries;
too many fields easily violate privacy.

**DE:** **Typische Fehler.** Unsichere Deserialisierungsformate. Pfade ohne Kanonisierung akzeptieren.
Importierte CSV-Daten nur formal, aber nicht fachlich prüfen. Alle Felder exportieren. SQL ohne
Parametrisierung. Interne Fehlermeldungen an Endnutzer.

**EN:** **Common mistakes.** Unsafe deserialization formats. Accepting paths without canonicalization. Checking
imported CSV data only formally, not functionally. Exporting all fields. SQL without parameterization. Internal
error messages to end users.

### Beispiel / Example

```text
Import (CSV):      Datei machines.csv (name,os,last_contact) -> Parser prueft Spalten -> Domaenenvalidierung
Pfad-Eingabe:      "../../secrets/config"  ->  kanonisieren  ->  liegt NICHT im Import-Ordner  ->  ABGELEHNT
SQL (SQLite):      SELECT * FROM machines WHERE name = ?   (Platzhalter, NICHT name = '" + input + "')
Exportprofil A:    Lernexport  -> alle fachlichen Felder (fiktive Daten)
Exportprofil B:    Auswertung  -> nur os, last_contact-Status  (kein interner Pfad, keine Rohdaten)
Fehlermeldung:     "Import fehlgeschlagen: ungueltiges os-Feld."  (kein Stack-Trace, kein Pfad)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Persistenz, Import und Export sind Kernfunktionen der Datenverwaltung. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Import und Export stellen Statusdaten über Systemgrenzen hinweg bereit. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Datenschutz und Supply-Chain-Bezug
bei Serialisierungs- und CSV-Bibliotheken. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Bibliotheken), `CL_08` (Sicherheits-Code-Review) und `CL_11` (Datenschutz/Datenqualität). Die
Sicherheitsentscheidung dieser Einheit lautet: *Importe werden nach dem Einlesen erneut fachlich validiert,
Pfade werden begrenzt, und der Export bleibt datensparsam.* A11Y-Aspekt: Fehlermeldungen bei Import/Export
sind klarer Text ohne interne Details und ohne reine Farbsignale, damit sie mit Screenreader und Braille-Zeile
nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, privacy, and supply-chain relevance of
serialization and CSV libraries. Matching checklists: `CL_01` (standards applicability), `CL_05`
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

2. **DE:** Warum ist eine austauschbare Ablage hinter einem festen Datenvertrag sinnvoll? /
   **EN:** Why is an exchangeable storage backend behind a fixed data contract useful?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst kann die Speicherform (JSON, SQLite, …) wechseln, ohne die Kernlogik umzubauen. Der feste
   Vertrag hält Import, Export und Tests stabil.
   **EN:** The service can switch storage form (JSON, SQLite, …) without rebuilding the core logic. The fixed
   contract keeps import, export, and tests stable.

   </details>

3. **DE:** (AE) Welche importierten CSV-Daten müssen nach dem Einlesen erneut validiert werden? /
   **EN:** (AE) Which imported CSV data must be re-validated after reading?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Alle Fachdaten gegen die Domänenregeln, z. B. gültiger `os`-Wert, vorhandener `name`, plausibler
   `last_contact`. Ein gültiges CSV-Format garantiert keine gültigen Fachdaten.
   **EN:** All business data against the domain rules, e.g. valid `os` value, present `name`, plausible
   `last_contact`. A valid CSV format does not guarantee valid business data.

   </details>

4. **DE:** (SI) Wo darf der Dienst Dateien lesen oder schreiben, und wie wird das erzwungen? /
   **EN:** (SI) Where may the service read or write files, and how is that enforced?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur in klar erlaubten Verzeichnissen. Erzwungen wird das durch Kanonisierung des Pfads und Prüfung,
   ob er im erlaubten Ordner liegt; `../`-Ausbrüche werden abgelehnt.
   **EN:** Only in clearly allowed directories. Enforced by canonicalizing the path and checking that it lies
   inside the allowed folder; `../` escapes are rejected.

   </details>

5. **DE:** (DPA) Welche Exportdaten reichen für Kennzahlen aus, ohne unnötige personenbezogene Daten? /
   **EN:** (DPA) Which export data is enough for metrics without unnecessary personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Meist Betriebssystem-Verteilung, Anzahl aktiver Maschinen und Zeitstempel-Status. Interne Pfade,
   Rohdaten oder unnötige Kennungen werden im Auswertungsprofil weggelassen.
   **EN:** Usually operating-system distribution, number of active machines, and timestamp status. Internal
   paths, raw data, or unnecessary identifiers are left out in the analysis profile.

   </details>

6. **DE:** (DV) Warum ist ein Export eine besonders sensible Stelle für die systemübergreifende
   Datenbereitstellung? / **EN:** (DV) Why is an export an especially sensitive point for cross-system data
   provision?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Beim Export verlassen Daten die Systemgrenze und werden anderen Systemen zugänglich. Zu viele oder
   falsche Felder können dort dauerhaft weiterverarbeitet werden, daher zählt Datensparsamkeit besonders.
   **EN:** On export, data leaves the system boundary and becomes accessible to other systems. Too many or
   wrong fields can be processed further there permanently, so data minimization matters especially.

   </details>

7. **DE:** Warum werden zwei Exportprofile unterschieden? /
   **EN:** Why are two export profiles distinguished?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein vollständiges Lernexport-Profil dient dem Lernen mit fiktiven Daten, ein datensparsames
   Auswertungsprofil schützt beim Weitergeben vor unnötiger Datenpreisgabe.
   **EN:** A complete learning-export profile serves learning with fictitious data, a data-minimal analysis
   profile protects against unnecessary data disclosure when sharing.

   </details>

8. **DE:** Warum darf eine Datei- oder Ablageoperation keine internen Details an Endnutzer ausgeben? /
   **EN:** Why must a file or storage operation not reveal internal details to end users?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Interne Meldungen wie Pfade oder SQL-Fehler helfen Angreifern und verletzen den Datenschutz. Nutzer
   bekommen eine klare, allgemeine Meldung; Details bleiben im internen Log.
   **EN:** Internal messages such as paths or SQL errors help attackers and violate privacy. Users get a clear,
   general message; details stay in the internal log.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Ablage-Abstraktion und eine Persistenzform wählen und die Entscheidung begründen.
- [ ] unsichere Deserialisierungsformate benennen und vermeiden.
- [ ] Dateipfade kanonisieren und auf erlaubte Verzeichnisse begrenzen.
- [ ] importierte CSV-Daten nach dem Einlesen erneut fachlich validieren.
- [ ] ein datensparsames Exportprofil von einem vollständigen unterscheiden.
- [ ] interne Details aus nutzerseitigen Fehlermeldungen heraushalten.

**EN:** I can …

- [ ] choose a storage abstraction and a persistence form and justify the decision.
- [ ] name and avoid unsafe deserialization formats.
- [ ] canonicalize file paths and limit them to allowed directories.
- [ ] re-validate imported CSV data functionally after reading.
- [ ] distinguish a data-minimal export profile from a complete one.
- [ ] keep internal details out of user-facing error messages.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_06_Persistenz-Import-und-Export.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_06_Persistenz-Import-und-Export.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
