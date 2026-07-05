# Lernbegleiter: Secure CaseTracker v2 07 – Import- und Export-Härtung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_07_Import-und-Export-Haertung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Import und Export sind die Tore, durch die Daten in großen Mengen ein- und ausströmen. Genau deshalb
sind sie ein beliebtes Angriffsziel. Eine Importdatei kann riesig sein (Überlastung), einen gefährlichen
Pfad enthalten (Ausbruch aus dem Zielordner), gefälschte Struktur haben oder beim Einlesen sogar Code
ausführen, wenn man unsicher **deserialisiert**. Ein Export wiederum kann versehentlich zu viele
personenbezogene Daten preisgeben. **Härten** bedeutet: jede dieser Gefahren bewusst begrenzen.

**EN:** Import and export are the gates through which data flows in and out in large amounts. That is exactly
why they are a popular attack target. An import file can be huge (overload), contain a dangerous path (escape
from the target folder), have a forged structure, or even execute code when read if you **deserialize**
insecurely. An export, in turn, can accidentally expose too much personal data. **Hardening** means:
deliberately limiting each of these dangers.

**DE:** In dieser Einheit beschreibst du erlaubte **Dateiformate**, **Größenlimits**, **Pfadprüfung**
(Kanonisierung), **sichere Deserialisierung**, **Datenminimierung** beim Export und **Negativtests**. Import
ist eine Vertrauensgrenze: Die Datei kommt von außen und ist zunächst nicht vertrauenswürdig.

**EN:** In this unit you describe allowed **file formats**, **size limits**, **path checking**
(canonicalization), **safe deserialization**, **data minimization** on export, and **negative tests**. Import
is a trust boundary: the file comes from outside and is initially not trustworthy.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Härtung / Hardening | Bewusstes Verringern von Angriffsmöglichkeiten eines Funktionsbereichs. |
| Deserialisierung / Deserialization | Umwandeln gespeicherter Daten zurück in Objekte; unsicher gefährlich. |
| Kanonisierung / Canonicalization | Pfad auf eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Größenlimit / Size limit | Obergrenze für Datei- oder Feldgröße, schützt vor Überlastung. |
| Allowlist / Allow-list | Liste erlaubter Werte (z. B. Formate); alles andere wird abgelehnt. |
| Datenminimierung / Data minimization | Beim Export nur nötige Felder ausgeben, keine überflüssigen Daten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Formate und Größen per Allowlist begrenzen.** Lege fest, welche Formate erlaubt sind
(z. B. nur CSV mit definierter Struktur) und wie groß eine Datei höchstens sein darf. **Warum wichtig:** Eine
Allowlist verhindert unbekannte, riskante Formate; ein Größenlimit verhindert, dass eine riesige Datei
Speicher und Zeit aufbraucht (Verfügbarkeit).

**EN:** **Step 1 – Limit formats and sizes via allow-list.** Define which formats are allowed (e.g. only CSV
with a defined structure) and the maximum file size. **Why it matters:** an allow-list prevents unknown, risky
formats; a size limit prevents a huge file from consuming memory and time (availability).

**DE:** **Schritt 2 – Pfade kanonisieren und prüfen.** Bringe jeden Datei- oder Zielpfad in seine Normalform
und prüfe dann, ob er im erlaubten Verzeichnis liegt. **Warum wichtig:** Ohne Kanonisierung erlaubt `../` den
Ausbruch aus dem Zielordner (**Path Traversal**). Erst die Normalform zeigt den echten Zielpfad.

**EN:** **Step 2 – Canonicalize and check paths.** Bring every file or target path into its normal form and
then check whether it lies within the allowed directory. **Why it matters:** without canonicalization, `../`
allows escaping the target folder (**path traversal**). Only the normal form shows the real target path.

**DE:** **Schritt 3 – Sicher deserialisieren.** Lies Importdaten mit einem sicheren, strengen Verfahren ein,
das keine beliebigen Typen oder Code aus der Datei erzeugt. Prüfe Struktur und Felder gegen das erwartete
Modell. **Warum wichtig:** Unsichere Deserialisierung kann Code ausführen oder Objekte erzeugen, die das
System angreifen. Der Inhalt einer Datei ist nie vertrauenswürdig.

**EN:** **Step 3 – Deserialize safely.** Read import data with a safe, strict method that does not create
arbitrary types or code from the file. Check structure and fields against the expected model. **Why it
matters:** insecure deserialization can execute code or create objects that attack the system. A file's
content is never trustworthy.

**DE:** **Schritt 4 – Export minimieren und Negativtests planen.** Beim Export nur die wirklich nötigen Felder
ausgeben; keine internen oder überflüssigen personenbezogenen Daten. Plane Negativtests: zu große Datei,
falsches Format, gefährlicher Pfad, kaputte Struktur – jeweils erwartete Ablehnung. **Warum wichtig:** Nur
Erfolgspfade zu testen beweist nicht, dass die Härtung greift.

**EN:** **Step 4 – Minimize export and plan negative tests.** On export, output only the truly necessary
fields; no internal or superfluous personal data. Plan negative tests: oversized file, wrong format,
dangerous path, broken structure – each with an expected rejection. **Why it matters:** testing only success
paths does not prove the hardening works.

**DE:** **Typische Fehler.** Beliebige Formate akzeptieren. Kein Größenlimit. Pfade ohne Kanonisierung. Mit
einem bequemen, aber unsicheren Verfahren deserialisieren. Beim Export alle Felder „für alle Fälle“ ausgeben.
Keine Negativtests.

**EN:** **Common mistakes.** Accepting arbitrary formats. No size limit. Paths without canonicalization.
Deserializing with a convenient but insecure method. Exporting all fields "just in case". No negative tests.

### Beispiel / Example

```text
Import-Regeln:
  Format:   Allowlist { CSV } mit fester Spaltenstruktur
  Groesse:  max. 5 MB  (Schutz vor Ueberlastung)
  Pfad:     "../../etc/passwd" -> kanonisieren -> liegt AUSSERHALB Import-Ordner -> ABGELEHNT
  Struktur: Spalten und Typen gegen erwartetes Modell pruefen, sonst ABLEHNEN
  Deser.:   strenges CSV-Parsen, keine Objekt-/Code-Erzeugung aus Dateiinhalt

Export-Regeln (Datenminimierung):
  ausgeben:  fall_id, status, angelegt_am
  NICHT:     interne Kennungen, Klartextnamen, ganze Notizen

Negativtests: 6 MB Datei -> abgelehnt; Format XLSX -> abgelehnt; Pfad mit ../ -> abgelehnt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Import und Export sind der Kern systemübergreifender Datenbereitstellung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Härtung setzt den Schutzbedarf an den Dateigrenzen praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Deserialisierung,
Angriffsflächen-Reduktion, Datenschutz und auditfähige Nachweise. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_03` (sichere Architektur), `CL_04` (Bedrohungsmodellierung), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede
Importdatei ist nicht vertrauenswürdig und wird nach Format, Größe, Pfad und Struktur geprüft, bevor sie
wirkt.* A11Y-Aspekt: Fehlermeldungen beim Import (z. B. „Format nicht erlaubt“) müssen klar und textbasiert
sein, ohne reine Farbsignale, damit Screenreader- und Braille-Nutzende die Ablehnung verstehen.

**EN:** Relation to the Secure Development Guideline: secure coding, safe deserialization, attack-surface
reduction, privacy, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_03`
(secure architecture), `CL_04` (threat modeling), `CL_08` (security code review), and `CL_10` (privacy). The
security decision of this unit is: *every import file is untrusted and is checked for format, size, path, and
structure before it takes effect.* Accessibility aspect: import error messages (e.g. "format not allowed")
must be clear and text-based, without color-only signals, so screen-reader and Braille users understand the
rejection.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein Import immer eine Vertrauensgrenze? /
   **EN:** Why is an import always a trust boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Datei kommt von außen und ist zunächst nicht vertrauenswürdig. Format, Größe, Pfad und Struktur
   müssen an dieser Grenze geprüft werden, bevor die Daten wirken.
   **EN:** The file comes from outside and is initially not trustworthy. Format, size, path, and structure must
   be checked at this boundary before the data takes effect.

   </details>

2. **DE:** Warum muss ein Dateipfad vor der Prüfung kanonisiert werden? /
   **EN:** Why must a file path be canonicalized before it is checked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Kanonisierung kann `../` aus dem erlaubten Verzeichnis herausführen (Path Traversal). Erst die
   Normalform zeigt den echten Zielpfad, den man prüfen kann.
   **EN:** Without canonicalization, `../` can lead out of the allowed directory (path traversal). Only the
   normal form shows the real target path that can be checked.

   </details>

3. **DE:** (AE) Warum ist unsichere Deserialisierung gefährlich, und wie liest man sicher ein? /
   **EN:** (AE) Why is insecure deserialization dangerous, and how do you read safely?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unsichere Deserialisierung kann aus Dateiinhalt beliebige Objekte oder Code erzeugen. Sicher liest
   man mit einem strengen Verfahren, das nur erwartete Felder gegen das Modell prüft.
   **EN:** Insecure deserialization can create arbitrary objects or code from file content. Safe reading uses a
   strict method that only checks expected fields against the model.

   </details>

4. **DE:** Warum ist ein Größenlimit eine Sicherheits- und keine Komfortfrage? /
   **EN:** Why is a size limit a security question and not a convenience one?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine riesige Datei kann Speicher und Rechenzeit aufbrauchen und den Dienst blockieren
   (Verfügbarkeit). Das Limit schützt vor dieser Überlastung.
   **EN:** A huge file can consume memory and compute time and block the service (availability). The limit
   protects against this overload.

   </details>

5. **DE:** (DPA) Warum ist Datenminimierung beim Export wichtig? /
   **EN:** (DPA) Why is data minimization important on export?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Export mit zu vielen Feldern gibt unnötig personenbezogene oder interne Daten preis. Nur die
   nötigen Felder senken das Datenschutz- und Missbrauchsrisiko.
   **EN:** An export with too many fields unnecessarily exposes personal or internal data. Only the necessary
   fields reduce the privacy and misuse risk.

   </details>

6. **DE:** (SI) Welche Negativtests gehören zu einem gehärteten Import? /
   **EN:** (SI) Which negative tests belong to a hardened import?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu große Datei, falsches Format, gefährlicher Pfad mit `../`, kaputte Struktur – jeweils mit
   erwarteter Ablehnung. Sie beweisen, dass die Härtung greift.
   **EN:** Oversized file, wrong format, dangerous path with `../`, broken structure – each with an expected
   rejection. They prove the hardening works.

   </details>

7. **DE:** Warum ist eine Allowlist erlaubter Formate besser als eine Verbotsliste? /
   **EN:** Why is an allow-list of permitted formats better than a deny-list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Allowlist lässt nur bekannte, geprüfte Formate zu; alles Unbekannte wird abgelehnt. Eine
   Verbotsliste muss jeden schlechten Fall kennen und übersieht leicht neue.
   **EN:** An allow-list permits only known, checked formats; anything unknown is rejected. A deny-list must
   know every bad case and easily misses new ones.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] erlaubte Formate und Größenlimits per Allowlist festlegen.
- [ ] einen Pfad kanonisieren und gegen das erlaubte Verzeichnis prüfen.
- [ ] sichere von unsicherer Deserialisierung unterscheiden.
- [ ] beim Export Datenminimierung begründen.
- [ ] Negativtests für Import und Export angeben.

**EN:** I can …

- [ ] define allowed formats and size limits via allow-list.
- [ ] canonicalize a path and check it against the allowed directory.
- [ ] distinguish safe from unsafe deserialization.
- [ ] justify data minimization on export.
- [ ] give negative tests for import and export.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_07_Import-und-Export-Haertung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_07_Import-und-Export-Haertung.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
