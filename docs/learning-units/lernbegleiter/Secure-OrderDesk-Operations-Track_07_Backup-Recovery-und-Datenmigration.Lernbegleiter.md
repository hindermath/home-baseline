# Lernbegleiter: Secure OrderDesk Operations Track 07 – Backup, Recovery und Datenmigration / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Handelsdaten von Secure Trader (Kunden wie `ALFKI`, Produkte, Bestellungen, Positionen im
Northwind-Layout) sind der Wert der Plattform. Geht die Datenbank verloren – durch Hardwarefehler, einen
falschen Befehl oder eine misslungene Änderung – muss sie wiederhergestellt werden. **Backup** bedeutet, eine
geschützte Kopie der Daten anzulegen. **Recovery** bedeutet, aus dieser Kopie den Betrieb wiederherzustellen.
**Datenmigration** bedeutet, Daten kontrolliert von einer Schema-Version oder einem Datenbank-Backend in eine
andere zu überführen. Wichtig ist der ehrliche Grundsatz: Nur ein *getesteter* Restore und eine *geprüfte*
Migration gelten als Nachweis. Ein Backup, das nie zurückgespielt wurde, ist nur eine Hoffnung.

**EN:** Secure Trader's trading data (customers such as `ALFKI`, products, orders, lines in Northwind layout)
is the platform's value. If the database is lost – through hardware failure, a wrong command, or a failed
change – it must be restored. **Backup** means making a protected copy of the data. **Recovery** means
restoring operation from that copy. **Data migration** means moving data in a controlled way from one schema
version or database backend to another. The honest principle matters: only a *tested* restore and a *verified*
migration count as evidence. A backup that was never restored is only a hope.

**DE:** In dieser Einheit lernst du, Backup-Ziele als RPO und RTO zu benennen, einen nummerierten Restore-
Ablauf zu schreiben, eine Recovery-Übung mit Zeitmessung zu planen und eine Datenmigration mit Prüfung und
Rückfallweg zu beschreiben. Als C#-Referenz dient `InventarWorkerService`; die Idee bleibt für C#, Go, Java,
Python, Rust und Swift vergleichbar.

**EN:** In this unit you learn to name backup goals as RPO and RTO, write a numbered restore procedure, plan a
recovery drill with time measurement, and describe a data migration with a check and a fallback. The C#
reference is `InventarWorkerService`; the idea stays comparable across C#, Go, Java, Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Backup / Backup | Geschützte Kopie der Daten für den Notfall. |
| Restore / Restore | Rückspielen einer Backup-Kopie in den Betrieb. |
| RPO / RPO | Recovery Point Objective: maximal vertretbarer Datenverlust in Zeit. |
| RTO / RTO | Recovery Time Objective: maximal vertretbare Ausfallzeit bis zum Betrieb. |
| Recovery-Übung / Recovery drill | Geplanter Testlauf eines Restore mit Zeitmessung und Prüfung. |
| Datenmigration / Data migration | Kontrollierter Wechsel von Schema-Version oder Backend. |
| Rückfallweg / Fallback | Geplanter Weg zurück, wenn eine Migration scheitert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Backup-Ziele aus dem Schutzbedarf ableiten.** Frage: Wie viel Datenverlust ist noch
vertretbar (RPO) und wie schnell muss der Betrieb wieder laufen (RTO)? Bei Bestelldaten ist der Schutzbedarf
hoch, weil verlorene Bestellungen echten Schaden bedeuten. RPO und RTO müssen begründet, nicht geraten werden.

**EN:** **Step 1 – Derive backup goals from the protection need.** Ask: how much data loss is still acceptable
(RPO) and how quickly must operation run again (RTO)? For order data the protection need is high, because lost
orders mean real harm. RPO and RTO must be justified, not guessed.

**DE:** **Schritt 2 – Restore als nummerierte Schrittfolge schreiben.** Ein Restore muss unter Druck
funktionieren. Deshalb wird er als klare, nummerierte Abfolge dokumentiert: Backup finden, Integrität prüfen,
Datenbank stoppen, zurückspielen, Vollständigkeit prüfen (z. B. `ALFKI` vorhanden), Betrieb freigeben.

**EN:** **Step 2 – Write the restore as a numbered sequence.** A restore must work under pressure. So it is
documented as a clear, numbered sequence: find backup, check integrity, stop database, restore, verify
completeness (e.g. `ALFKI` present), release operation.

**DE:** **Schritt 3 – Recovery-Übung mit Zeitmessung planen.** Erst die Übung beweist, dass RTO erreichbar ist.
Miss die Zeit vom Start bis zum geprüften Betrieb und vergleiche sie mit dem RTO. Notiere, was gefehlt hat,
etwa ein unklarer Schritt oder ein fehlender Zugriff.

**EN:** **Step 3 – Plan a recovery drill with time measurement.** Only the drill proves that the RTO is
reachable. Measure the time from start to verified operation and compare it with the RTO. Note what was
missing, e.g. an unclear step or a missing access right.

**DE:** **Schritt 4 – Migration mit Prüfung und Rückfallweg.** Eine Datenmigration verändert echte Daten.
Deshalb braucht sie eine Prüfung auf Vollständigkeit und Korrektheit (Anzahl Datensätze, Stichproben wie
`ALFKI`) und einen Rückfallweg, falls etwas schiefgeht. Ohne Rückfallweg ist eine misslungene Migration ein
Notfall.

**EN:** **Step 4 – Migration with check and fallback.** A data migration changes real data. So it needs a
check for completeness and correctness (record counts, samples such as `ALFKI`) and a fallback if something
goes wrong. Without a fallback, a failed migration is an emergency.

**DE:** **Typische Fehler.** Backups anlegen, aber nie testen. RPO/RTO raten statt begründen. Backups
unverschlüsselt und für jeden lesbar ablegen. Migration ohne Vollständigkeitsprüfung. Kein Rückfallweg.
Echte Kundendaten statt fiktiver Northwind-Daten für Übungen verwenden.

**EN:** **Common mistakes.** Making backups but never testing them. Guessing RPO/RTO instead of justifying
them. Storing backups unencrypted and readable by anyone. Migration without a completeness check. No fallback.
Using real customer data instead of fictitious Northwind data for drills.

### Beispiel / Example

```text
Schutzbedarf:  Bestelldaten hoch  -> RPO = 15 min (max. Datenverlust), RTO = 2 h (max. Ausfall)
Restore:       1) Backup finden  2) Integrität prüfen  3) DB stoppen  4) zurückspielen
               5) Vollständigkeit prüfen (ALFKI vorhanden?)  6) Betrieb freigeben
Recovery-Übung: gemessene Zeit 1 h 40 min  -> innerhalb RTO; Lücke: Zugriff auf Backup-Speicher fehlte
Migration:     Schema v3 -> v4; Prüfung: Datensatzzahl gleich, Stichprobe ALFKI korrekt; Rückfallweg: Backup v3
Secrets:       Backup-Schlüssel nur als <PLATZHALTER-KEIN-ECHTER-WERT>, echter Wert im Secret-Store
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Backup, Recovery und Migration sichern Verfügbarkeit und geordneten Betrieb. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Restore stellt den Dienst nach einem Ausfall wieder bereit. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Verfügbarkeit, sichere Speicherung, Datenintegrität und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07` (Betrieb/Verfügbarkeit),
`CL_08` (Sicherheits-Review), `CL_10` (Zugangssteuerung) und `CL_12` (Dokumentation/N-A). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nur ein getesteter Restore und eine geprüfte Migration gelten
als Nachweis; Backups werden verschlüsselt und nach Least Privilege geschützt.* A11Y-Aspekt: RPO/RTO,
Restore-Schritte und Migrationsprüfungen werden als nummerierte Textschritte dokumentiert, ohne reine
Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: availability, secure storage, data integrity, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_07` (operation/availability),
`CL_08` (security review), `CL_10` (access control), and `CL_12` (documentation/N-A). The security decision of
this unit is: *only a tested restore and a verified migration count as evidence; backups are encrypted and
protected by least privilege.* Accessibility aspect: RPO/RTO, restore steps, and migration checks are
documented as numbered text steps, without color-only marking, so they stay usable with a screen reader or
Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet ein angelegtes von einem getesteten Backup? /
   **EN:** What distinguishes a created backup from a tested backup?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein angelegtes Backup ist nur eine Kopie; niemand weiß, ob es sich zurückspielen lässt. Ein
   getestetes Backup wurde in einer Übung erfolgreich zurückgespielt und geprüft. Erst das gilt als Nachweis.
   **EN:** A created backup is only a copy; nobody knows whether it can be restored. A tested backup was
   successfully restored and verified in a drill. Only that counts as evidence.

   </details>

2. **DE:** Was bedeuten RPO und RTO? /
   **EN:** What do RPO and RTO mean?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** RPO ist der maximal vertretbare Datenverlust in Zeit (wie alt darf das letzte Backup sein). RTO ist
   die maximal vertretbare Ausfallzeit bis zum wiederhergestellten Betrieb.
   **EN:** RPO is the maximum acceptable data loss in time (how old the last backup may be). RTO is the maximum
   acceptable downtime until operation is restored.

   </details>

3. **DE:** Warum sollte eine Recovery-Übung die Zeit messen? /
   **EN:** Why should a recovery drill measure time?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die gemessene Zeit zeigt, ob das RTO in der Praxis erreichbar ist. Ohne Messung bleibt das RTO
   eine Annahme, und Lücken (fehlender Zugriff, unklare Schritte) bleiben unentdeckt.
   **EN:** Only the measured time shows whether the RTO is reachable in practice. Without measurement the RTO
   stays an assumption, and gaps (missing access, unclear steps) remain undetected.

   </details>

4. **DE:** (SI) Wie prüfst du, dass eine Datenmigration vollständig und korrekt war? /
   **EN:** (SI) How do you verify that a data migration was complete and correct?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über Prüfungen wie den Vergleich der Datensatzzahlen vor und nach der Migration und Stichproben an
   bekannten Datensätzen (z. B. `ALFKI`). Zusätzlich braucht es einen Rückfallweg, falls die Prüfung scheitert.
   **EN:** Via checks such as comparing record counts before and after the migration and samples on known
   records (e.g. `ALFKI`). Additionally, a fallback is needed if the check fails.

   </details>

5. **DE:** (SI) Warum müssen Backups selbst geschützt werden? /
   **EN:** (SI) Why must backups themselves be protected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Backup enthält alle Daten. Liegt es unverschlüsselt und breit lesbar, ist es ein einfaches Ziel.
   Deshalb: Verschlüsselung und Zugriff nach Least Privilege, damit die Kopie nicht zum Leck wird.
   **EN:** A backup contains all data. If it is unencrypted and widely readable, it is an easy target.
   Therefore: encryption and least-privilege access, so the copy does not become a leak.

   </details>

6. **DE:** Warum werden Übungen mit fiktiven Northwind-Daten statt echten Kundendaten gemacht? /
   **EN:** Why are drills done with fictitious Northwind data instead of real customer data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fiktive Daten (inkl. `ALFKI`) vermeiden ein Datenschutzrisiko und erlauben trotzdem eine
   realistische Prüfung. Echte Kundendaten in Übungen wären ein unnötiges Risiko.
   **EN:** Fictitious data (incl. `ALFKI`) avoids a privacy risk while still allowing a realistic check. Real
   customer data in drills would be an unnecessary risk.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] RPO und RTO aus dem Schutzbedarf der Bestelldaten begründen.
- [ ] einen Restore als klare, nummerierte Schrittfolge beschreiben.
- [ ] eine Recovery-Übung mit Zeitmessung planen.
- [ ] eine Datenmigration mit Vollständigkeitsprüfung und Rückfallweg beschreiben.
- [ ] begründen, warum Backups selbst verschlüsselt und geschützt werden.

**EN:** I can …

- [ ] justify RPO and RTO from the protection need of the order data.
- [ ] describe a restore as a clear, numbered sequence.
- [ ] plan a recovery drill with time measurement.
- [ ] describe a data migration with a completeness check and a fallback.
- [ ] justify why backups themselves are encrypted and protected.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
