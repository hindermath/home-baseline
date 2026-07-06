# Lernbegleiter: Secure ServiceHarvester v2 04 – Harvester: Zeitplanung, Idempotenz und Import-Härtung / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_04_Harvester-Zeitplanung-Idempotenz-und-Import-Haertung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der **Harvester** ist der Teil des Dienstes, der regelmäßig Statusdaten sammelt – aus Quellen oder aus
importierten Dateien. „Regelmäßig“ heißt: nach einer **Zeitplanung** (z. B. alle fünf Minuten). Weil ein
Dienst neu startet, ein Lauf sich überschneiden oder eine Datei zweimal ankommen kann, muss das Sammeln
**idempotent** sein: Ein doppelter Lauf mit denselben Daten verändert das Ergebnis nicht. Und weil
Importdateien von außen kommen, sind sie eine **Vertrauensgrenze**, die **gehärtet** werden muss.

**EN:** The **harvester** is the part of the service that regularly collects status data – from sources or from
imported files. "Regularly" means: on a **schedule** (e.g. every five minutes). Because a service restarts, a
run can overlap, or a file can arrive twice, collection must be **idempotent**: a duplicate run with the same
data does not change the result. And because import files come from outside, they are a **trust boundary** that
must be **hardened**.

**DE:** In dieser Einheit beschreibst du die **Zeitplanung** (Intervall, Überlappungsschutz), die
**Idempotenz-Regel** (ein eindeutiger Schlüssel plus Upsert), und die **Import-Härtung**: erlaubte
**Dateiformate** (Allowlist), **Größenlimits**, **Pfadprüfung** (Kanonisierung gegen Path Traversal) und
**sichere Deserialisierung**. Dazu planst du **Negativtests**, die zeigen, dass schlechte Eingaben abgelehnt
werden.

**EN:** In this unit you describe the **schedule** (interval, overlap protection), the **idempotency rule** (a
unique key plus upsert), and the **import hardening**: allowed **file formats** (allow-list), **size limits**,
**path checking** (canonicalization against path traversal), and **safe deserialization**. You also plan
**negative tests** that show bad input is rejected.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Zeitplanung / Scheduling | Regelmäßiges Auslösen des Sammelns nach einem Intervall oder Plan. |
| Idempotenz / Idempotency | Eigenschaft, dass ein doppelter gleicher Lauf dasselbe Ergebnis erzeugt. |
| Upsert / Upsert | Anlegen oder Aktualisieren anhand eines eindeutigen Schlüssels statt blind einzufügen. |
| Härtung / Hardening | Bewusstes Verringern der Angriffsmöglichkeiten eines Funktionsbereichs. |
| Kanonisierung / Canonicalization | Pfad auf eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Negativtest / Negative test | Test, der prüft, ob eine schlechte Eingabe korrekt abgelehnt wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Zeitplanung und Überlappungsschutz festlegen.** Lege das Intervall fest (z. B. alle fünf
Minuten) und plane, was passiert, wenn ein Lauf länger dauert als das Intervall. **Warum wichtig:** Ohne
Überlappungsschutz starten zwei Läufe gleichzeitig und stören sich; ein einzelner, klar getakteter Lauf ist
vorhersehbar und testbar.

**EN:** **Step 1 – Define schedule and overlap protection.** Set the interval (e.g. every five minutes) and
plan what happens if a run takes longer than the interval. **Why it matters:** without overlap protection two
runs start at once and interfere; a single, clearly clocked run is predictable and testable.

**DE:** **Schritt 2 – Idempotenz über einen Schlüssel sichern.** Bestimme einen **eindeutigen Schlüssel** je
Datensatz (z. B. Maschine + Zeitpunkt) und nutze **Upsert**: Ist der Schlüssel vorhanden, wird aktualisiert,
sonst angelegt. **Warum wichtig:** So erzeugt ein doppelter Lauf oder ein Neustart keine Dubletten. Das
Ergebnis hängt nur von den Daten ab, nicht von der Anzahl der Läufe.

**EN:** **Step 2 – Secure idempotency via a key.** Determine a **unique key** per record (e.g. machine + time)
and use **upsert**: if the key exists, update; otherwise insert. **Why it matters:** this way a duplicate run
or a restart creates no duplicates. The result depends only on the data, not on the number of runs.

**DE:** **Schritt 3 – Formate und Größen per Allowlist begrenzen.** Lege fest, welche Importformate erlaubt
sind (z. B. nur CSV mit fester Struktur) und die maximale Dateigröße. **Warum wichtig:** Eine Allowlist
verhindert unbekannte, riskante Formate; ein Größenlimit verhindert, dass eine riesige Datei Speicher und Zeit
aufbraucht (Verfügbarkeit).

**EN:** **Step 3 – Limit formats and sizes via allow-list.** Define which import formats are allowed (e.g. only
CSV with a fixed structure) and the maximum file size. **Why it matters:** an allow-list prevents unknown,
risky formats; a size limit prevents a huge file from consuming memory and time (availability).

**DE:** **Schritt 4 – Pfade kanonisieren und sicher deserialisieren.** Bringe jeden Datei- oder Zielpfad in
seine Normalform und prüfe, ob er im erlaubten Verzeichnis liegt; ohne Kanonisierung erlaubt `../` den
Ausbruch (**Path Traversal**). Lies den Inhalt mit einem strengen Verfahren ein, das keine beliebigen Typen
oder Code erzeugt, und prüfe Struktur und Felder gegen das erwartete Modell. **Warum wichtig:** Der Inhalt
einer Importdatei ist nie vertrauenswürdig.

**EN:** **Step 4 – Canonicalize paths and deserialize safely.** Bring every file or target path into its
normal form and check whether it lies in the allowed directory; without canonicalization, `../` allows escape
(**path traversal**). Read the content with a strict method that creates no arbitrary types or code, and check
structure and fields against the expected model. **Why it matters:** the content of an import file is never
trustworthy.

**DE:** **Schritt 5 – Negativtests planen.** Plane Tests mit absichtlich schlechten Eingaben: zu große Datei,
falsches Format, gefährlicher Pfad mit `../`, kaputte Struktur, doppelter Lauf – jeweils mit erwartetem
Verhalten (Ablehnung bzw. keine Dublette). **Warum wichtig:** Nur Erfolgspfade zu testen beweist nicht, dass
Härtung und Idempotenz greifen.

**EN:** **Step 5 – Plan negative tests.** Plan tests with deliberately bad input: oversized file, wrong format,
dangerous path with `../`, broken structure, duplicate run – each with the expected behavior (rejection or no
duplicate). **Why it matters:** testing only success paths does not prove that hardening and idempotency work.

**DE:** **Typische Fehler.** Kein Überlappungsschutz beim Intervall. Datensätze blind einfügen statt per Upsert
(Dubletten). Beliebige Formate akzeptieren. Kein Größenlimit. Pfade ohne Kanonisierung. Mit einem bequemen,
aber unsicheren Verfahren deserialisieren. Keine Negativtests.

**EN:** **Common mistakes.** No overlap protection on the interval. Inserting records blindly instead of upsert
(duplicates). Accepting arbitrary formats. No size limit. Paths without canonicalization. Deserializing with a
convenient but insecure method. No negative tests.

### Beispiel / Example

```text
Zeitplanung:
  Intervall:          alle 5 Minuten
  Ueberlappungsschutz: laeuft ein Lauf noch, wird der naechste uebersprungen oder wartet

Idempotenz (Upsert):
  Schluessel:  (machine_id, collected_at)
  Regel:       vorhanden -> aktualisieren ; nicht vorhanden -> anlegen
  Folge:       doppelter Lauf / Neustart -> KEINE Dublette

Import-Haertung:
  Format:   Allowlist { CSV } mit fester Spaltenstruktur
  Groesse:  max. 5 MB  (Schutz vor Ueberlastung)
  Pfad:     "../../etc/passwd" -> kanonisieren -> liegt AUSSERHALB Import-Ordner -> ABGELEHNT
  Struktur: Spalten und Typen gegen Modell pruefen, sonst ABLEHNEN
  Deser.:   strenges CSV-Parsen, keine Objekt-/Code-Erzeugung aus Dateiinhalt

Negativtests: 6 MB Datei -> abgelehnt ; Format XLSX -> abgelehnt ; Pfad mit ../ -> abgelehnt ;
              zweiter identischer Lauf -> keine Dublette
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Der Harvester sammelt und importiert Daten aus anderen Systemen für die Bereitstellung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Import-Härtung setzt den Schutzbedarf an der Dateigrenze praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Deserialisierung,
Angriffsflächen-Reduktion, Datenschutz und auditfähige Nachweise. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_03` (sichere Architektur), `CL_04` (Bedrohungsmodellierung), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede
Importdatei ist nicht vertrauenswürdig und wird nach Format, Größe, Pfad und Struktur geprüft, und jeder Lauf
ist idempotent.* A11Y-Aspekt: Fehlermeldungen beim Import (z. B. „Format nicht erlaubt“) müssen klar und
textbasiert sein, ohne reine Farbsignale, damit Screenreader- und Braille-Nutzende die Ablehnung verstehen.

**EN:** Relation to the Secure Development Guideline: secure coding, safe deserialization, attack-surface
reduction, privacy, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_03`
(secure architecture), `CL_04` (threat modeling), `CL_08` (security code review), and `CL_10` (privacy). The
security decision of this unit is: *every import file is untrusted and is checked for format, size, path, and
structure, and every run is idempotent.* Accessibility aspect: import error messages (e.g. "format not
allowed") must be clear and text-based, without color-only signals, so screen-reader and Braille users
understand the rejection.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Idempotenz beim Sammeln, und warum ist sie für einen Dienst wichtig? /
   **EN:** What does idempotency mean for collection, and why is it important for a service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein doppelter Lauf mit denselben Daten verändert das Ergebnis nicht. Weil ein Dienst neu startet oder
   Läufe sich überschneiden können, verhindert Idempotenz (per Schlüssel und Upsert) Dubletten und falsche
   Zählungen.
   **EN:** A duplicate run with the same data does not change the result. Because a service restarts or runs can
   overlap, idempotency (via key and upsert) prevents duplicates and wrong counts.

   </details>

2. **DE:** Warum ist eine Importdatei immer eine Vertrauensgrenze? /
   **EN:** Why is an import file always a trust boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Datei kommt von außen und ist zunächst nicht vertrauenswürdig. Format, Größe, Pfad und Struktur
   müssen an dieser Grenze geprüft werden, bevor die Daten wirken.
   **EN:** The file comes from outside and is initially not trustworthy. Format, size, path, and structure must
   be checked at this boundary before the data takes effect.

   </details>

3. **DE:** (AE) Wie sichert man Idempotenz technisch über einen Schlüssel und Upsert? /
   **EN:** (AE) How do you technically secure idempotency via a key and upsert?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man wählt einen eindeutigen Schlüssel je Datensatz (z. B. Maschine + Zeitpunkt). Beim Speichern
   prüft man, ob der Schlüssel existiert: vorhanden -> aktualisieren, sonst anlegen. So entstehen keine
   Dubletten, egal wie oft der Lauf startet.
   **EN:** You choose a unique key per record (e.g. machine + time). On save you check whether the key exists:
   present -> update, otherwise insert. This creates no duplicates, no matter how often the run starts.

   </details>

4. **DE:** (DPA) Warum ist Datenminimierung auch beim Import wichtig? /
   **EN:** (DPA) Why is data minimization important on import too?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Importdatei kann mehr Felder enthalten, als gebraucht werden. Nur die nötigen Felder übernehmen
   senkt das Datenschutzrisiko, verbessert die Datenqualität und verkleinert die Angriffsfläche.
   **EN:** An import file can contain more fields than needed. Taking over only the necessary fields reduces the
   privacy risk, improves data quality, and shrinks the attack surface.

   </details>

5. **DE:** (SI) Welche Negativtests gehören zu einem gehärteten Harvester-Import? /
   **EN:** (SI) Which negative tests belong to a hardened harvester import?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu große Datei, falsches Format, gefährlicher Pfad mit `../`, kaputte Struktur und ein zweiter
   identischer Lauf – jeweils mit erwarteter Ablehnung bzw. ohne Dublette. Sie beweisen, dass Härtung und
   Idempotenz greifen.
   **EN:** Oversized file, wrong format, dangerous path with `../`, broken structure, and a second identical run
   – each with expected rejection or no duplicate. They prove hardening and idempotency work.

   </details>

6. **DE:** (DV) Warum ist ein Überlappungsschutz bei der Zeitplanung eine Frage der Verfügbarkeit? /
   **EN:** (DV) Why is overlap protection in scheduling a matter of availability?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Starten zwei Läufe gleichzeitig, konkurrieren sie um Quellen, Netz und Store und können sich
   blockieren oder überlasten. Ein Überlappungsschutz hält den Dienst vorhersehbar und ansprechbar.
   **EN:** If two runs start at once, they compete for sources, network, and store and can block or overload
   each other. Overlap protection keeps the service predictable and responsive.

   </details>

7. **DE:** Warum muss ein Dateipfad vor der Prüfung kanonisiert werden? /
   **EN:** Why must a file path be canonicalized before it is checked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Kanonisierung kann `../` aus dem erlaubten Verzeichnis herausführen (Path Traversal). Erst die
   Normalform zeigt den echten Zielpfad, den man prüfen kann.
   **EN:** Without canonicalization, `../` can lead out of the allowed directory (path traversal). Only the
   normal form shows the real target path that can be checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein Sammel-Intervall mit Überlappungsschutz festlegen.
- [ ] Idempotenz über einen eindeutigen Schlüssel und Upsert erklären.
- [ ] erlaubte Formate und Größenlimits per Allowlist festlegen.
- [ ] einen Pfad kanonisieren und sicher deserialisieren.
- [ ] Negativtests für Import und wiederholten Lauf angeben.

**EN:** I can …

- [ ] define a collection interval with overlap protection.
- [ ] explain idempotency via a unique key and upsert.
- [ ] define allowed formats and size limits via an allow-list.
- [ ] canonicalize a path and deserialize safely.
- [ ] give negative tests for import and for a repeated run.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_04_Harvester-Zeitplanung-Idempotenz-und-Import-Haertung.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_04_Harvester-Zeitplanung-Idempotenz-und-Import-Haertung.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
