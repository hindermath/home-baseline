# Lernbegleiter: Secure InventoryHub 05 – Import, Export und Datenbereinigung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_05_Import-Export-und-Datenbereinigung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Inventardaten kommen selten allein: Sie werden aus CSV- oder JSON-Dateien importiert und für andere
Systeme exportiert. Genau hier lauern viele Probleme. Eine Importdatei ist **nicht vertrauenswürdig** – sie
kann fehlerhafte Zeilen, Dubletten, falsche Formate oder sogar Angriffe (z. B. CSV-Formel-Injection)
enthalten. Datenbereinigung sorgt dafür, dass nur saubere, eindeutige Datensätze ins Inventar gelangen. Beim
Export gilt: Es dürfen keine Daten hinausfließen, die dort nicht hingehören, etwa unnötige personenbezogene
Felder.

**EN:** Inventory data rarely comes alone: it is imported from CSV or JSON files and exported to other
systems. This is exactly where many problems hide. An import file is **untrusted** – it can contain faulty
rows, duplicates, wrong formats, or even attacks (e.g. CSV formula injection). Data cleaning ensures that only
clean, unique records enter the inventory. For export the rule is: no data may flow out that does not belong
there, such as unnecessary personal fields.

**DE:** In dieser Einheit lernst du, Import- und Exportformate zu definieren, ungültige Datensätze und
Dubletten sicher zu behandeln, sichere Fehlermeldungen zu formulieren und Datenschutzgrenzen beim Export zu
setzen.

**EN:** In this unit you learn to define import and export formats, safely handle invalid records and
duplicates, formulate safe error messages, and set privacy limits for export.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Import / Import | Einlesen von Daten aus einer externen Datei ins System. |
| Export / Export | Ausgabe von Daten aus dem System in eine Datei oder ein Zielsystem. |
| Dublette / Duplicate | Doppelter Datensatz, der dasselbe Objekt mehrfach abbildet. |
| Formatregel / Format rule | Vorgabe, wie Felder aufgebaut sein müssen (Trennzeichen, Typ, Länge). |
| CSV-Formel-Injection / CSV formula injection | Angriff, bei dem ein Zellwert in einer Tabelle als Formel ausgeführt wird. |
| Datenminimierung / Data minimization | Nur die wirklich nötigen Daten verarbeiten und weitergeben. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Formate festlegen.** Bestimme genau, wie eine gültige Importdatei aussieht: Spalten,
Reihenfolge, Trennzeichen, erlaubte Datentypen und Pflichtfelder. Ein klares Format ist die Grundlage jeder
Prüfung. Was nicht dem Format entspricht, wird abgelehnt oder gemeldet.

**EN:** **Step 1 – Define formats.** Determine exactly what a valid import file looks like: columns, order,
delimiter, allowed data types, and mandatory fields. A clear format is the basis of every check. Whatever does
not match the format is rejected or reported.

**DE:** **Schritt 2 – Jede Zeile prüfen.** Behandle jede Zeile als nicht vertrauenswürdig. Prüfe Datentypen,
Wertebereiche und Pflichtfelder. Achte auf CSV-Formel-Injection: Beginnt ein Zellwert mit `=`, `+`, `-` oder
`@`, kann er in einem Tabellenprogramm als Formel ausgeführt werden. Solche Werte müssen entschärft werden.

**EN:** **Step 2 – Check every row.** Treat every row as untrusted. Check data types, value ranges, and
mandatory fields. Watch for CSV formula injection: if a cell value starts with `=`, `+`, `-`, or `@`, it can
be executed as a formula in a spreadsheet program. Such values must be neutralized.

**DE:** **Schritt 3 – Dubletten und ungültige Sätze behandeln.** Lege Dublettenregeln fest: Woran erkennst du,
dass zwei Datensätze dasselbe Objekt meinen (z. B. gleiche Asset-Kennung)? Entscheide, ob doppelte Sätze
zusammengeführt oder abgelehnt werden. Ungültige Sätze werden nicht still verworfen, sondern nachvollziehbar
gemeldet, damit niemand denkt, alles sei importiert.

**EN:** **Step 3 – Handle duplicates and invalid records.** Define duplicate rules: how do you recognize that
two records mean the same object (e.g. same asset identifier)? Decide whether duplicate records are merged or
rejected. Invalid records are not silently discarded but reported traceably, so no one thinks everything was
imported.

**DE:** **Schritt 4 – Sicherer Export mit Datenschutzgrenze.** Beim Export gilt Datenminimierung: Exportiere
nur die Felder, die das Zielsystem wirklich braucht. Keine unnötigen personenbezogenen Daten. Prüfe außerdem,
ob der Export selbst wieder Formel-Injection-sicher ist. Fehlermeldungen bleiben verständlich, ohne interne
Pfade oder Systemdetails.

**EN:** **Step 4 – Safe export with a privacy limit.** For export, data minimization applies: export only the
fields the target system truly needs. No unnecessary personal data. Also check whether the export itself is
formula-injection-safe. Error messages stay understandable, without internal paths or system details.

**DE:** **Typische Fehler.** Importdateien blind vertrauen. Formel-Injection ignorieren. Ungültige Zeilen
still verwerfen. Keine Dublettenregel. Beim Export mehr Felder ausgeben als nötig. Fehlermeldungen mit
internen Details oder Dateipfaden.

**EN:** **Common mistakes.** Blindly trusting import files. Ignoring formula injection. Silently discarding
invalid rows. No duplicate rule. Exporting more fields than needed. Error messages with internal details or
file paths.

### Beispiel / Example

```text
Importzeile (CSV): AST-002;Server;RZ-1;team-ops;aktiv
Formatregel:       5 Spalten, Trennzeichen ";", status IN {aktiv, wartung, ausgemustert}
Ergebnis:          GÜLTIG -> importiert

Importzeile:       =SUM(1+1);Laptop;Halle-B;;aktiv
Prüfung:           Zelle beginnt mit "=" -> Formel-Injection-Verdacht + Pflichtfeld owner leer
Ergebnis:          ABGELEHNT, gemeldet: "Zeile 7: unzulässiger Wert, Pflichtfeld owner fehlt"

Dublettenregel:    gleiche Asset-Kennung -> zusammenführen oder ablehnen (dokumentiert)
Export:            nur { id, typ, standort, status } -> kein owner-Klarname (Datenminimierung)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Import und Export sind systemübergreifende Datenbereitstellung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Datenbereinigung schützt die Qualität der verwalteten Daten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Eingabeverarbeitung, Datei-I/O, Datenschutz und
sichere Fehlerbehandlung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (Zugangssteuerung),
`CL_04` (Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede importierte Zeile gilt als nicht vertrauenswürdig, und
jeder Export folgt der Datenminimierung.* A11Y-Aspekt: Import-Fehlerberichte müssen als klarer Text mit
Zeilenbezug lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleiben.

**EN:** Relation to the Secure Development Guideline: safe input handling, file I/O, privacy, and safe error
handling. Matching checklists: `CL_01` (standards applicability), `CL_03` (access control), `CL_04` (threat
modeling), `CL_08` (security code review), and `CL_10` (privacy). The security decision of this unit is: *every
imported row is treated as untrusted, and every export follows data minimization.* Accessibility aspect: import
error reports must be readable as clear text with a row reference, without color-only marking, so they stay
usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Importdatei nicht vertrauenswürdig? /
   **EN:** Why is an import file untrusted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie stammt von außen und kann fehlerhafte, doppelte oder schädliche Inhalte enthalten. Erst nach
   einer Prüfung an der Vertrauensgrenze dürfen die Daten ins Inventar.
   **EN:** It comes from outside and can contain faulty, duplicate, or malicious content. Only after a check at
   the trust boundary may the data enter the inventory.

   </details>

2. **DE:** Was ist CSV-Formel-Injection, und wie schützt man sich? /
   **EN:** What is CSV formula injection, and how do you protect against it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Zellwert, der mit `=`, `+`, `-` oder `@` beginnt, kann in einem Tabellenprogramm als Formel
   ausgeführt werden. Schutz: solche Werte erkennen und entschärfen, z. B. maskieren oder ablehnen.
   **EN:** A cell value starting with `=`, `+`, `-`, or `@` can be executed as a formula in a spreadsheet.
   Protection: detect and neutralize such values, e.g. escape or reject them.

   </details>

3. **DE:** Warum sollten ungültige Importzeilen gemeldet und nicht still verworfen werden? /
   **EN:** Why should invalid import rows be reported rather than silently discarded?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wird still verworfen, glaubt man, alles sei importiert. Ein nachvollziehbarer Bericht mit Zeilenbezug
   zeigt, was fehlt, und schützt die Datenqualität und das Vertrauen ins Ergebnis.
   **EN:** If silently discarded, one believes everything was imported. A traceable report with a row reference
   shows what is missing and protects data quality and trust in the result.

   </details>

4. **DE:** Was ist eine Dublettenregel, und wozu dient sie? /
   **EN:** What is a duplicate rule, and what is it for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie legt fest, woran man erkennt, dass zwei Sätze dasselbe Objekt meinen (z. B. gleiche Kennung),
   und was dann geschieht (zusammenführen oder ablehnen). Sie verhindert doppelte Bestände.
   **EN:** It defines how to recognize that two records mean the same object (e.g. same identifier) and what
   then happens (merge or reject). It prevents duplicate stock.

   </details>

5. **DE:** (DPA) Warum gilt beim Export Datenminimierung? /
   **EN:** (DPA) Why does data minimization apply to export?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es dürfen nur die wirklich nötigen Felder das System verlassen. Unnötige, besonders personenbezogene
   Daten erhöhen das Datenschutzrisiko ohne Nutzen.
   **EN:** Only the truly necessary fields may leave the system. Unnecessary, especially personal, data raises
   the privacy risk without benefit.

   </details>

6. **DE:** Warum ist ein klar definiertes Importformat die Grundlage jeder Prüfung? /
   **EN:** Why is a clearly defined import format the basis of every check?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur mit einem festen Format weiß man, was gültig ist. Abweichungen lassen sich dann eindeutig
   erkennen und behandeln. Ohne Format ist keine verlässliche Prüfung möglich.
   **EN:** Only with a fixed format do you know what is valid. Deviations can then be clearly detected and
   handled. Without a format, no reliable check is possible.

   </details>

7. **DE:** Warum darf ein Importfehler keine internen Dateipfade zeigen? /
   **EN:** Why must an import error not show internal file paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Interne Pfade und Systemdetails helfen Angreifern und gehören nicht in eine Nutzermeldung. Die
   Meldung soll den Fehler und die betroffene Zeile nennen, nicht die Systemstruktur.
   **EN:** Internal paths and system details help attackers and do not belong in a user message. The message
   should name the error and the affected row, not the system structure.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein gültiges Import- und Exportformat beschreiben.
- [ ] jede Importzeile als Vertrauensgrenze prüfen.
- [ ] CSV-Formel-Injection erkennen und entschärfen.
- [ ] eine Dublettenregel formulieren.
- [ ] beim Export Datenminimierung anwenden.

**EN:** I can …

- [ ] describe a valid import and export format.
- [ ] check every import row as a trust boundary.
- [ ] detect and neutralize CSV formula injection.
- [ ] formulate a duplicate rule.
- [ ] apply data minimization on export.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_05_Import-Export-und-Datenbereinigung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_05_Import-Export-und-Datenbereinigung.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
