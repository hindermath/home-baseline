# Lernbegleiter: Secure ServiceHarvester Operations Track 07 – Backup, Recovery und Datenmigration / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester sammelt und speichert Statusdaten. Diese Daten können verloren gehen:
durch einen Defekt, einen Fehler, eine Löschung oder einen Angriff. Ein **Backup** ist eine Sicherungskopie.
Aber ein Backup allein rettet niemanden – erst der **Restore** (die Wiederherstellung) beweist, dass die Kopie
brauchbar ist. Zusätzlich muss der Dienst manchmal auf ein neues Datenschema oder ein anderes Speicher-Backend
umziehen: Das ist eine **Datenmigration**, die geprüft und rückholbar sein muss.

**EN:** The Secure ServiceHarvester collects and stores status data. This data can be lost: through a defect,
an error, a deletion, or an attack. A **backup** is a safety copy. But a backup alone saves nobody – only the
**restore** proves the copy is usable. In addition, the service sometimes has to move to a new data schema or a
different storage backend: this is a **data migration**, which must be verified and reversible.

**DE:** In dieser Einheit lernst du, Backup-Ziele festzulegen (**RPO** und **RTO**), einen Restore-Ablauf zu
planen, eine Recovery-Übung durchzuspielen und eine Datenmigration sicher und prüfbar zu gestalten. Als
C#-Referenz dient `InventarWorkerService`; die Idee bleibt für C#, Go, Java, Python, Rust und Swift
vergleichbar. Sie nutzt die reproduzierbaren Builds aus Einheit 06 und liefert die Betriebsnachweise, die in
Einheit 10 zusammengefasst werden.

**EN:** In this unit you learn to set backup goals (**RPO** and **RTO**), plan a restore procedure, run a
recovery drill, and design a data migration safely and verifiably. The C# reference is `InventarWorkerService`;
the idea stays comparable across C#, Go, Java, Python, Rust, and Swift. It uses the reproducible builds from
unit 06 and delivers the operational evidence summarized in unit 10.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Backup / Backup | Sicherungskopie der Daten für den Fall eines Verlusts. |
| Restore / Restore | Wiederherstellung der Daten aus einem Backup. |
| Recovery-Übung / Recovery drill | Geplanter Test, ob eine Wiederherstellung wirklich gelingt. |
| RPO / Recovery Point Objective | Wie viel Datenverlust maximal akzeptabel ist (Zeit seit letztem Backup). |
| RTO / Recovery Time Objective | Wie lange eine Wiederherstellung höchstens dauern darf. |
| Datenmigration / Data migration | Geplanter Umzug der Daten auf ein neues Schema oder Backend. |
| Rückfallweg / Rollback | Geplanter Weg zurück, falls eine Migration fehlschlägt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Backup-Ziele festlegen (RPO/RTO).** Zwei Fragen stehen am Anfang: Wie viel Datenverlust
ist maximal tragbar (**RPO**)? Und wie lange darf die Wiederherstellung dauern (**RTO**)? Diese Ziele leiten
sich aus dem Schutzbedarf (Verfügbarkeit und Integrität) der Statusdaten ab.

**EN:** **Step 1 – Set backup goals (RPO/RTO).** Two questions come first: how much data loss is at most
tolerable (**RPO**)? And how long may the restore take (**RTO**)? These goals derive from the protection need
(availability and integrity) of the status data.

**DE:** **Schritt 2 – Restore-Ablauf planen.** Beschreibe Schritt für Schritt, wie man aus einem Backup zurück
in den Betrieb kommt: Wo liegt das Backup, wie wird es entschlüsselt, in welcher Reihenfolge wird
wiederhergestellt, wer darf das tun? Ein klarer Ablauf verhindert Panik im Ernstfall.

**EN:** **Step 2 – Plan the restore procedure.** Describe step by step how to get from a backup back into
operation: where the backup is, how it is decrypted, in what order it is restored, who may do it. A clear
procedure prevents panic in a real case.

**DE:** **Schritt 3 – Recovery-Übung durchspielen.** Teste die Wiederherstellung, bevor du sie brauchst. Miss
die tatsächliche Zeit und vergleiche sie mit dem RTO. Prüfe, ob die wiederhergestellten Daten vollständig und
korrekt sind. Nur eine geübte Wiederherstellung ist ein Nachweis, kein Versprechen.

**EN:** **Step 3 – Run the recovery drill.** Test the restore before you need it. Measure the actual time and
compare it with the RTO. Check that the restored data is complete and correct. Only a rehearsed restore is
evidence, not a promise.

**DE:** **Schritt 4 – Datenmigration sicher gestalten.** Eine Migration ändert Struktur oder Speicherort der
Daten. Sichere zuerst (Backup!), plane einen Rückfallweg (Rollback) und prüfe nach der Migration Vollständigkeit
und Korrektheit. Eine Migration ohne Rückfallweg und ohne Prüfung ist ein Risiko, kein Fortschritt.

**EN:** **Step 4 – Design the data migration safely.** A migration changes the structure or location of the
data. Back up first (backup!), plan a rollback, and after the migration check completeness and correctness. A
migration without a rollback and without verification is a risk, not progress.

**DE:** **Typische Fehler.** Backups anlegen, aber nie einen Restore testen. RPO/RTO nicht festlegen. Backups
unverschlüsselt oder für alle zugänglich ablegen. Eine Migration ohne vorheriges Backup und ohne Rückfallweg
starten. Nach der Migration nicht prüfen, ob alle Daten korrekt übernommen wurden.

**EN:** **Common mistakes.** Creating backups but never testing a restore. Not setting RPO/RTO. Storing backups
unencrypted or accessible to everyone. Starting a migration without a prior backup and without a rollback. Not
checking after the migration whether all data was taken over correctly.

### Beispiel / Example

```text
RPO:                 max. 1 Stunde Datenverlust  -> stündliches Backup
RTO:                 Wiederherstellung in max. 2 Stunden
Restore-Ablauf:      1) Backup finden  2) entschlüsseln  3) einspielen  4) Integrität prüfen
Recovery-Übung:      gemessene Zeit 1 h 40 min  -> innerhalb RTO;  Daten vollständig geprüft
Migration:           altes Schema -> neues Schema; vorher Backup, Rollback definiert, danach Prüfsumme
Backup-Schutz:       verschlüsselt, Zugriff nur Backup-Rolle (Least Privilege)
Restrisiko:          bis zu 1 h Verlust der letzten Snapshots; dokumentiert und akzeptiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Backup, Recovery und Migration sichern Verfügbarkeit und Integrität des laufenden Systems. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Nach einem Ausfall wird der Dienst aus dem Backup wieder bereitgestellt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Verfügbarkeit, sichere Speicherung, Datenintegrität,
auditfähige Evidenz und ehrliche Restrisiken. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07`
(sichere Konfiguration), `CL_08` (Sicherheits-Review), `CL_10` (Datenschutz/Nachweise) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Nur ein getesteter Restore und eine
geprüfte, rückholbare Migration gelten als Nachweis; Backups sind selbst geschützt.* A11Y-Aspekt:
Restore-Ablauf, Übungsergebnis und Migrationsprüfung werden als klare, nummerierte Textschritte dokumentiert,
ohne Diagramm und ohne Farbcode.

**EN:** Relation to the Secure Development Guideline: availability, secure storage, data integrity, audit-ready
evidence, and honest residual risks. Matching checklists: `CL_01` (standards applicability), `CL_07` (secure
configuration), `CL_08` (security review), `CL_10` (privacy/evidence), and `CL_12` (documentation/N-A). The
security decision of this unit is: *only a tested restore and a verified, reversible migration count as
evidence; backups are themselves protected.* Accessibility aspect: restore procedure, drill result, and
migration check are documented as clear, numbered text steps, without a diagram and without color coding.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein Backup ohne getesteten Restore kein echter Schutz? /
   **EN:** Why is a backup without a tested restore not real protection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erst der Restore beweist, dass die Kopie brauchbar ist. Ein Backup kann unvollständig, beschädigt
   oder nicht lesbar sein. Ohne Test weiß man das erst im Ernstfall – dann ist es zu spät.
   **EN:** Only the restore proves the copy is usable. A backup can be incomplete, damaged, or unreadable.
   Without a test you learn this only in a real case – then it is too late.

   </details>

2. **DE:** Was bedeuten RPO und RTO? /
   **EN:** What do RPO and RTO mean?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** RPO (Recovery Point Objective) ist der maximal akzeptable Datenverlust, also die Zeit seit dem
   letzten Backup. RTO (Recovery Time Objective) ist die maximal erlaubte Dauer der Wiederherstellung.
   **EN:** RPO (Recovery Point Objective) is the maximum acceptable data loss, i.e. the time since the last
   backup. RTO (Recovery Time Objective) is the maximum allowed duration of the restore.

   </details>

3. **DE:** Warum muss ein Backup selbst geschützt werden? /
   **EN:** Why must a backup itself be protected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Backup enthält alle Daten. Liegt es unverschlüsselt oder frei zugänglich, wird es zum
   Einfallstor: Ein Angreifer bekommt über die Kopie alles. Deshalb: Verschlüsselung und Zugriff nur für die
   Backup-Rolle.
   **EN:** A backup contains all data. If it lies unencrypted or freely accessible, it becomes an entry point:
   an attacker gets everything via the copy. Therefore: encryption and access only for the backup role.

   </details>

4. **DE:** (SI) Warum braucht eine Datenmigration ein vorheriges Backup und einen Rückfallweg? /
   **EN:** (SI) Why does a data migration need a prior backup and a rollback?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Migration kann fehlschlagen oder Daten falsch übernehmen. Ein vorheriges Backup und ein
   geplanter Rückfallweg erlauben es, den alten, funktionierenden Zustand wiederherzustellen, statt mit
   beschädigten Daten weiterzumachen.
   **EN:** A migration can fail or take over data incorrectly. A prior backup and a planned rollback allow
   restoring the old, working state instead of continuing with damaged data.

   </details>

5. **DE:** (SI) Was misst und prüfst du in einer Recovery-Übung und wozu? /
   **EN:** (SI) What do you measure and check in a recovery drill and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die tatsächliche Wiederherstellungszeit (Vergleich mit RTO) und die Vollständigkeit/Korrektheit der
   Daten. So weiß man, ob die Ziele realistisch sind und ob der Ablauf im Ernstfall funktioniert.
   **EN:** The actual restore time (compared with RTO) and the completeness/correctness of the data. This shows
   whether the goals are realistic and whether the procedure works in a real case.

   </details>

6. **DE:** (SI) Wie prüfst du nach einer Migration, dass die Daten korrekt übernommen wurden? /
   **EN:** (SI) How do you check after a migration that the data was taken over correctly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch Vollständigkeits- und Korrektheitsprüfungen, z. B. Anzahlvergleich, Prüfsummen oder
   Stichproben zentraler Felder. Erst wenn die Prüfung stimmt, gilt die Migration als erfolgreich.
   **EN:** Through completeness and correctness checks, e.g. count comparison, checksums, or spot checks of key
   fields. Only when the check passes is the migration considered successful.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] RPO und RTO für den Sammel-Dienst festlegen und begründen.
- [ ] einen klaren, nummerierten Restore-Ablauf beschreiben.
- [ ] eine Recovery-Übung planen und ihr Ergebnis gegen die Ziele prüfen.
- [ ] eine Datenmigration mit Backup, Rückfallweg und Prüfung planen.
- [ ] Datenverlustgrenzen und Restrisiken ehrlich dokumentieren.

**EN:** I can …

- [ ] set RPO and RTO for the collection service and justify them.
- [ ] describe a clear, numbered restore procedure.
- [ ] plan a recovery drill and check its result against the goals.
- [ ] plan a data migration with backup, rollback, and verification.
- [ ] honestly document data-loss limits and residual risks.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
