# Lernbegleiter: Secure ServiceHarvester Operations Track 10 – Betriebs-Review, Runbook und Abschluss / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende des Operations Track steht die Übergabe. Der Secure ServiceHarvester wurde gebaut (Einheit 06),
gesichert (Einheit 07), in seiner Lieferkette geprüft (Einheit 08) und isoliert betrieben (Einheit 09). Jetzt
geht es darum, diese Betriebssicht zusammenzuführen: ein **Betriebs-Review** fasst die wichtigsten
Entscheidungen zusammen, ein **Runbook** erklärt verständlich die zentralen Abläufe, und eine **Übergabe** nennt
offene Punkte, Restrisiken und eine klare Empfehlung. Ein Betrieb ist erst dann sauber übergeben, wenn ein
anderer Mensch ihn anhand der Dokumentation weiterführen kann.

**EN:** At the end of the Operations Track comes the handover. The Secure ServiceHarvester was built (unit 06),
protected (unit 07), checked in its supply chain (unit 08), and operated in isolation (unit 09). Now the point
is to bring this operational view together: an **operations review** summarizes the most important decisions, a
**runbook** explains the central procedures understandably, and a **handover** names open items, residual risks,
and a clear recommendation. An operation is only cleanly handed over when another person can continue it from
the documentation.

**DE:** In dieser Einheit lernst du, ein Betriebs-Review zu schreiben, ein kundenverständliches Runbook zu
erstellen, Restrisiken ehrlich zu benennen und eine Übergabeempfehlung zu formulieren. Als C#-Referenz dient
`InventarWorkerService`; die Idee bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar. Diese Einheit
schließt den Operations Track (Jahr 3, SI) ab.

**EN:** In this unit you learn to write an operations review, create a customer-understandable runbook, name
residual risks honestly, and formulate a handover recommendation. The C# reference is `InventarWorkerService`;
the idea stays comparable across C#, Go, Java, Python, Rust, and Swift. This unit closes the Operations Track
(year 3, SI).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Betriebs-Review / Operations review | Zusammenfassende Bewertung des Betriebs und seiner Entscheidungen. |
| Runbook / Runbook | Verständliche Anleitung für die wichtigsten Betriebsabläufe. |
| Restrisiko / Residual risk | Risiko, das nach allen Maßnahmen bewusst bestehen bleibt. |
| Offener Punkt / Open item | Noch nicht erledigte Aufgabe mit benannter Folgeaktion. |
| Akzeptanzkriterium / Acceptance criterion | Prüfbare Bedingung, wann ein Ergebnis angenommen werden kann. |
| Übergabe / Handover | Geordnete Weitergabe von Betrieb und Wissen an andere. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebs-Review schreiben.** Fasse die zentralen Betriebsentscheidungen der Einheiten 06
bis 09 zusammen: Wie wird gebaut, gesichert, die Lieferkette geprüft und isoliert betrieben? Nenne je Bereich
den Nachweis. Ein Review ist kein Werbetext, sondern eine ehrliche Bestandsaufnahme mit Belegen.

**EN:** **Step 1 – Write the operations review.** Summarize the central operational decisions of units 06 to
09: how is it built, protected, supply-chain-checked, and operated in isolation? Name the evidence per area. A
review is not marketing text but an honest assessment with proof.

**DE:** **Schritt 2 – Runbook erstellen.** Ein Runbook beschreibt die wichtigsten Abläufe verständlich: Wie
startet und stoppt man den Dienst? Wie stellt man aus einem Backup wieder her? Was tut man bei einem Alarm?
Schreibe es so, dass eine andere Person es ohne Nachfragen ausführen kann.

**EN:** **Step 2 – Create the runbook.** A runbook describes the most important procedures understandably: how
do you start and stop the service? How do you restore from a backup? What do you do on an alert? Write it so
that another person can execute it without asking back.

**DE:** **Schritt 3 – Restrisiken und offene Punkte benennen.** Kein Betrieb ist perfekt. Nenne die bewusst
akzeptierten Restrisiken (z. B. bis zu 1 Stunde Datenverlust) und die offenen Punkte mit Folgeaktion. Ehrliche
Restrisiken sind ein Zeichen von Reife, kein Fehler; Verschweigen erzeugt falsche Sicherheit.

**EN:** **Step 3 – Name residual risks and open items.** No operation is perfect. Name the knowingly accepted
residual risks (e.g. up to 1 hour of data loss) and the open items with a follow-up action. Honest residual
risks are a sign of maturity, not a fault; hiding them creates false confidence.

**DE:** **Schritt 4 – Akzeptanz und Übergabe formulieren.** Lege prüfbare Akzeptanzkriterien fest und gib eine
klare Empfehlung: übernehmen, mit Auflagen übernehmen oder nachbessern. Die Übergabe ist erst vollständig, wenn
Nachweise, Runbook und Restrisiken zusammen ein stimmiges Bild ergeben.

**EN:** **Step 4 – Formulate acceptance and handover.** Define testable acceptance criteria and give a clear
recommendation: accept, accept with conditions, or rework. The handover is only complete when evidence,
runbook, and residual risks together form a coherent picture.

**DE:** **Typische Fehler.** Ein Review ohne Belege schreiben. Ein Runbook, das nur der Autor versteht.
Restrisiken verschweigen. Offene Punkte ohne Folgeaktion lassen. Eine Übergabeempfehlung ohne prüfbare
Kriterien geben. Nur-positive Aussagen ohne Nachweis.

**EN:** **Common mistakes.** Writing a review without proof. A runbook only the author understands. Hiding
residual risks. Leaving open items without a follow-up action. Giving a handover recommendation without testable
criteria. Only-positive claims without evidence.

### Beispiel / Example

```text
Betriebs-Review:  06 CI/CD reproduzierbar (Nachweis: Pipeline-Log) | 07 Restore geübt (Nachweis: Übungsbericht)
                  08 SBOM + Audit (Nachweis: SBOM, Scan) | 09 Sandbox + Least Privilege (Nachweis: Start/Health/Stop)
Runbook:          Start, Stopp, Restore, Alarm-Reaktion - je als klare, nummerierte Schritte
Restrisiko:       bis zu 1 h Datenverlust (RPO); dokumentiert und akzeptiert
Offener Punkt:    automatischer CVE-Alarm noch nicht aktiv -> Folgeaufgabe benannt
Akzeptanz:        Übergabe empfohlen mit Auflage "CVE-Alarm nachrüsten"
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12b Kundenspezifische Systemintegration durchführen | Primär / Primary | Betriebs-Review, Runbook und Übergabe sind kundenspezifische Integrationsaufgaben. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Restrisiken und Betriebsnachweise verweisen auf den Schutzbedarf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Evidenz, ehrliche Restrisiken,
kundenverständliche Übergabe und N/A-Begründung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit),
`CL_07` (sichere Konfiguration), `CL_08` (Sicherheits-Review), `CL_10` (Datenschutz/Nachweise), `CL_11`
(Abschluss/Übergabe) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Ein
Betrieb gilt erst als übergeben, wenn Review, Runbook, Restrisiken und Nachweise zusammen prüfbar sind.*
A11Y-Aspekt: Runbook und Restrisiko-Liste werden als klare, nummerierte Textschritte dokumentiert, ohne reine
Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready evidence, honest residual risks,
customer-understandable handover, and N/A rationale. Matching checklists: `CL_01` (standards applicability),
`CL_07` (secure configuration), `CL_08` (security review), `CL_10` (privacy/evidence), `CL_11`
(closure/handover), and `CL_12` (documentation/N-A). The security decision of this unit is: *an operation is
only handed over once review, runbook, residual risks, and evidence are together verifiable.* Accessibility
aspect: runbook and residual-risk list are documented as clear, numbered text steps, without color-only marking,
so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dient ein Betriebs-Review am Ende des Tracks? /
   **EN:** What is the purpose of an operations review at the end of the track?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es fasst die zentralen Betriebsentscheidungen der vorangehenden Einheiten mit ihren Nachweisen
   zusammen und macht sichtbar, wie der Dienst gebaut, gesichert, geprüft und betrieben wird. So entsteht ein
   ehrliches Gesamtbild.
   **EN:** It summarizes the central operational decisions of the previous units with their evidence and shows
   how the service is built, protected, checked, and operated. This creates an honest overall picture.

   </details>

2. **DE:** Was macht ein gutes Runbook aus? /
   **EN:** What makes a good runbook?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es beschreibt die wichtigsten Abläufe (Start, Stopp, Restore, Alarm-Reaktion) so klar und
   nummeriert, dass eine andere Person sie ohne Nachfragen ausführen kann. Verständlichkeit steht vor
   Vollständigkeit im Detail.
   **EN:** It describes the most important procedures (start, stop, restore, alert response) so clearly and
   numbered that another person can execute them without asking back. Understandability comes before exhaustive
   detail.

   </details>

3. **DE:** (SI) Warum gehören Restrisiken in die Übergabe statt sie zu verschweigen? /
   **EN:** (SI) Why do residual risks belong in the handover instead of being hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kein Betrieb ist perfekt. Ein bewusstes Restrisiko muss sichtbar sein, damit Verantwortliche es
   kennen und akzeptieren können. Verschweigen erzeugt falsche Sicherheit und verlagert das Risiko auf ahnungslose
   Nachfolger.
   **EN:** No operation is perfect. A deliberate residual risk must be visible so that those responsible can
   know and accept it. Hiding it creates false confidence and shifts the risk onto unaware successors.

   </details>

4. **DE:** (SI) Warum sollte eine Übergabeempfehlung prüfbare Akzeptanzkriterien enthalten? /
   **EN:** (SI) Why should a handover recommendation contain testable acceptance criteria?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Prüfbare Kriterien machen klar, wann der Betrieb wirklich angenommen werden kann, statt es dem
   Gefühl zu überlassen. So kann der Empfänger die Empfehlung nachvollziehen und überprüfen.
   **EN:** Testable criteria clarify when the operation can really be accepted, instead of leaving it to
   feeling. This lets the recipient understand and verify the recommendation.

   </details>

5. **DE:** (SI) Wie verweist du im Review auf die Ergebnisse der Einheiten 06 bis 09? /
   **EN:** (SI) How do you reference the results of units 06 to 09 in the review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Je Bereich wird die Betriebsentscheidung mit ihrem Nachweis genannt: CI/CD mit Pipeline-Log,
   Backup/Recovery mit Übungsbericht, Lieferkette mit SBOM und Audit, Sandbox mit Start-/Health-/Shutdown-Beleg.
   So ist jede Aussage belegt.
   **EN:** Per area, the operational decision is named with its evidence: CI/CD with pipeline log,
   backup/recovery with drill report, supply chain with SBOM and audit, sandbox with start/health/shutdown
   proof. This way every claim is evidenced.

   </details>

6. **DE:** Warum ist eine Übergabe erst vollständig, wenn ein anderer Mensch den Betrieb fortführen kann? /
   **EN:** Why is a handover only complete when another person can continue the operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Sinn der Übergabe ist die Fortführung ohne den ursprünglichen Autor. Erst wenn Runbook,
   Nachweise und Restrisiken zusammen ausreichen, um den Betrieb selbstständig zu führen, ist das Ziel
   erreicht.
   **EN:** The purpose of the handover is continuation without the original author. Only when runbook, evidence,
   and residual risks together suffice to run the operation independently is the goal achieved.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein Betriebs-Review mit Belegen über mehrere Einheiten schreiben.
- [ ] ein kundenverständliches Runbook für die wichtigsten Abläufe erstellen.
- [ ] Restrisiken und offene Punkte mit Folgeaktion ehrlich benennen.
- [ ] prüfbare Akzeptanzkriterien und eine Übergabeempfehlung formulieren.
- [ ] begründen, wann ein Betrieb wirklich sauber übergeben ist.

**EN:** I can …

- [ ] write an operations review with evidence across several units.
- [ ] create a customer-understandable runbook for the most important procedures.
- [ ] honestly name residual risks and open items with a follow-up action.
- [ ] formulate testable acceptance criteria and a handover recommendation.
- [ ] justify when an operation is really cleanly handed over.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
