# Lernbegleiter: Secure CaseTracker Operations Track 06 – Backup, Restore und Recovery-Übung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_06_Backup-Restore-und-Recovery-Uebung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Daten können verloren gehen: durch einen Defekt, einen Fehler, eine Löschung oder einen Angriff.
Ein **Backup** ist eine Sicherungskopie der Daten. Aber ein Backup allein rettet niemanden – erst das
**Restore** (die Wiederherstellung) beweist, dass die Kopie wirklich brauchbar ist. Eine **Recovery-Übung**
prüft den ganzen Weg zurück: Kann man aus dem Backup einen funktionierenden Zustand herstellen, und wie lange
dauert das? Ein ungeprüftes Backup ist nur eine Hoffnung, kein Schutz.

**EN:** Data can be lost: through a defect, an error, a deletion, or an attack. A **backup** is a safety copy
of the data. But a backup alone saves nobody – only the **restore** proves the copy is really usable. A
**recovery drill** tests the whole way back: can you produce a working state from the backup, and how long
does it take? An untested backup is only a hope, not protection.

**DE:** In dieser Einheit lernst du, Backup-Ziele festzulegen (**RPO** und **RTO**), den Restore-Ablauf zu
planen, eine Recovery-Übung durchzuspielen und Datenverlustgrenzen sowie Restrisiken ehrlich zu
dokumentieren.

**EN:** In this unit you learn to set backup goals (**RPO** and **RTO**), plan the restore procedure, run a
recovery drill, and honestly document data-loss limits and residual risks.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Backup / Backup | Sicherungskopie der Daten für den Fall eines Verlusts. |
| Restore / Restore | Wiederherstellung der Daten aus einem Backup. |
| Recovery-Übung / Recovery drill | Geplanter Test, ob eine Wiederherstellung wirklich gelingt. |
| RPO / Recovery Point Objective | Wie viel Datenverlust maximal akzeptabel ist (Zeit seit letztem Backup). |
| RTO / Recovery Time Objective | Wie lange eine Wiederherstellung höchstens dauern darf. |
| Restrisiko / Residual risk | Risiko, das nach allen Maßnahmen bewusst bestehen bleibt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Backup-Ziele festlegen (RPO/RTO).** Zwei Fragen stehen am Anfang: Wie viel Datenverlust
ist maximal tragbar (**RPO**)? Und wie lange darf die Wiederherstellung dauern (**RTO**)? Ein RPO von einer
Stunde bedeutet: Es wird mindestens stündlich gesichert. Diese Ziele leiten sich aus dem Schutzbedarf
(Verfügbarkeit) ab.

**EN:** **Step 1 – Set backup goals (RPO/RTO).** Two questions come first: how much data loss is at most
tolerable (**RPO**)? And how long may the restore take (**RTO**)? An RPO of one hour means: a backup happens
at least hourly. These goals derive from the protection need (availability).

**DE:** **Schritt 2 – Restore-Ablauf planen.** Beschreibe Schritt für Schritt, wie man aus einem Backup
zurück in den Betrieb kommt: Wo liegt das Backup, wie wird es entschlüsselt, in welcher Reihenfolge wird
wiederhergestellt, wer darf das tun? Ein klarer Ablauf verhindert Panik im Ernstfall.

**EN:** **Step 2 – Plan the restore procedure.** Describe step by step how to get from a backup back into
operation: where the backup is, how it is decrypted, in what order it is restored, who may do it. A clear
procedure prevents panic in a real case.

**DE:** **Schritt 3 – Recovery-Übung durchspielen.** Teste die Wiederherstellung, bevor du sie brauchst.
Miss dabei die tatsächliche Zeit und vergleiche sie mit dem RTO. Prüfe, ob die wiederhergestellten Daten
vollständig und korrekt sind. Nur eine geübte Wiederherstellung ist ein Nachweis, kein Versprechen.

**EN:** **Step 3 – Run the recovery drill.** Test the restore before you need it. Measure the actual time and
compare it with the RTO. Check that the restored data is complete and correct. Only a rehearsed restore is
evidence, not a promise.

**DE:** **Schritt 4 – Datenverlustgrenzen und Restrisiken dokumentieren.** Halte fest, welcher Datenverlust
im schlimmsten Fall bleibt und welche Risiken du bewusst in Kauf nimmst. Auch Backups selbst müssen geschützt
sein (Verschlüsselung, Zugriffsrechte), sonst wird die Sicherung zum Einfallstor. Ehrliche Restrisiken sind
Teil auditfähiger Dokumentation.

**EN:** **Step 4 – Document data-loss limits and residual risks.** Record which data loss remains in the
worst case and which risks you knowingly accept. Backups themselves must be protected too (encryption, access
rights), otherwise the safety copy becomes an entry point. Honest residual risks are part of audit-ready
documentation.

**DE:** **Typische Fehler.** Backups anlegen, aber nie einen Restore testen. RPO/RTO nicht festlegen.
Backups unverschlüsselt oder für alle zugänglich ablegen. Recovery nur „im Kopf" planen. Restrisiken
verschweigen und so eine falsche Sicherheit erzeugen.

**EN:** **Common mistakes.** Creating backups but never testing a restore. Not setting RPO/RTO. Storing
backups unencrypted or accessible to everyone. Planning recovery only "in your head". Hiding residual risks
and thus creating false confidence.

### Beispiel / Example

```text
RPO:                 max. 1 Stunde Datenverlust  -> stündliches Backup
RTO:                 Wiederherstellung in max. 2 Stunden
Restore-Ablauf:      1) Backup finden  2) entschlüsseln  3) Daten einspielen  4) Integrität prüfen
Recovery-Übung:      gemessene Zeit 1 h 40 min  -> innerhalb RTO;  Daten vollständig geprüft
Backup-Schutz:       verschlüsselt, Zugriff nur Backup-Rolle (Least Privilege)
Restrisiko:          bis zu 1 h Verlust der letzten Fälle; dokumentiert und akzeptiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Backup, Restore und Recovery sichern die Verfügbarkeit des laufenden Systems. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Nach einem Ausfall wird der Dienst aus dem Backup wieder bereitgestellt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Verfügbarkeit, sichere Speicherung, auditfähige Evidenz
und ehrliche Restrisiken. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07` (sichere
Konfiguration), `CL_08` (Sicherheits-Review), `CL_10` (Logging/Nachweise) und `CL_12` (Dokumentation/N-A).
Die Sicherheitsentscheidung dieser Einheit lautet: *Nur eine getestete Wiederherstellung gilt als
Nachweis; Backups sind selbst geschützt.* A11Y-Aspekt: Restore-Ablauf und Übungsergebnis werden als klare,
nummerierte Textschritte dokumentiert, damit sie ohne Diagramm und ohne Farbcode nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: availability, secure storage, audit-ready evidence, and
honest residual risks. Matching checklists: `CL_01` (standards applicability), `CL_07` (secure
configuration), `CL_08` (security review), `CL_10` (logging/evidence), and `CL_12` (documentation/N-A). The
security decision of this unit is: *only a tested restore counts as evidence; backups are themselves
protected.* Accessibility aspect: restore procedure and drill result are documented as clear, numbered text
steps, so they stay usable without a diagram and without color coding.

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

4. **DE:** (SI) Was misst du in einer Recovery-Übung und wozu? /
   **EN:** (SI) What do you measure in a recovery drill and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die tatsächliche Wiederherstellungszeit (Vergleich mit RTO) und die Vollständigkeit/Korrektheit der
   Daten. So weiß man, ob die Ziele realistisch sind und ob der Ablauf im Ernstfall funktioniert.
   **EN:** The actual restore time (compared with RTO) and the completeness/correctness of the data. This
   shows whether the goals are realistic and whether the procedure works in a real case.

   </details>

5. **DE:** (SI) Wie leiten sich RPO und RTO aus dem Schutzbedarf ab? /
   **EN:** (SI) How do RPO and RTO derive from the protection need?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus dem Verfügbarkeits- und Integritätsbedarf. Sind Daten sehr wichtig, ist der akzeptable Verlust
   klein (kleines RPO) und die erlaubte Ausfallzeit kurz (kleines RTO). Der Schutzbedarf steuert also die
   Ziele.
   **EN:** From the availability and integrity need. If data is very important, the acceptable loss is small
   (small RPO) and the allowed downtime short (small RTO). So the protection need drives the goals.

   </details>

6. **DE:** (SI) Warum gehört ein Restrisiko in die Dokumentation, statt es zu verschweigen? /
   **EN:** (SI) Why does a residual risk belong in the documentation instead of being hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kein Schutz ist perfekt; ein bewusstes Restrisiko (z. B. bis zu 1 h Datenverlust) muss sichtbar
   sein, damit Verantwortliche es kennen und akzeptieren. Verschweigen erzeugt falsche Sicherheit.
   **EN:** No protection is perfect; a deliberate residual risk (e.g. up to 1 h data loss) must be visible so
   that those responsible know and accept it. Hiding it creates false confidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] RPO und RTO für ein betriebenes System festlegen und begründen.
- [ ] einen klaren, nummerierten Restore-Ablauf beschreiben.
- [ ] eine Recovery-Übung planen und ihr Ergebnis gegen die Ziele prüfen.
- [ ] erklären, warum Backups selbst geschützt sein müssen.
- [ ] Datenverlustgrenzen und Restrisiken ehrlich dokumentieren.

**EN:** I can …

- [ ] set RPO and RTO for an operated system and justify them.
- [ ] describe a clear, numbered restore procedure.
- [ ] plan a recovery drill and check its result against the goals.
- [ ] explain why backups themselves must be protected.
- [ ] honestly document data-loss limits and residual risks.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_06_Backup-Restore-und-Recovery-Uebung.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_06_Backup-Restore-und-Recovery-Uebung.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
