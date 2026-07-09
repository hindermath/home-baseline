# Lernbegleiter: Secure CaseTracker 01 – Kundenauftrag und Scope / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Jedes Softwareprojekt beginnt mit einer Frage: *Was genau will die Kundin oder der Kunde?* Wenn diese
Frage unklar bleibt, baut man am Ziel vorbei. In dieser Einheit beschreibst du den **Kundenauftrag** der
Übungsfirma EuFPA für den Secure CaseTracker und legst den **Scope** fest – also die Grenze zwischen dem, was
dazugehört (In-Scope), und dem, was bewusst draußen bleibt (Out-of-Scope). Ein klarer Scope schützt vor
endlosem Wachstum, falschen Erwartungen und übersehenen Risiken.

**EN:** Every software project starts with one question: *what exactly does the customer want?* If this
question stays unclear, you build past the goal. In this unit you describe the **customer task** of the
training company EuFPA for the Secure CaseTracker and define the **scope** – the boundary between what belongs
in (in-scope) and what stays deliberately out (out-of-scope). A clear scope protects against endless growth,
wrong expectations, and overlooked risks.

**DE:** Du erfasst außerdem die fachlichen Rollen `learner`, `developer` und `reviewer` – noch als Konzept,
nicht als fertiges Anmeldesystem – und dokumentierst erste Datenschutz- und Sicherheitsannahmen.

**EN:** You also capture the business roles `learner`, `developer`, and `reviewer` – still as a concept, not
as a finished login system – and document first privacy and security assumptions.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Kundenauftrag / Customer task | Kurze, verständliche Beschreibung dessen, was der Kunde erreichen will. |
| Scope / In-Scope | Menge der Funktionen, die zu diesem Projekt gehören. |
| Out-of-Scope | Bewusst ausgeschlossene Funktionen, mit kurzer Begründung. |
| Fachliche Rolle / Business role | Rollenbegriff aus der Sachlogik, noch ohne technische Authentifizierung. |
| Datenminimierung / Data minimization | Nur die Daten erheben und verarbeiten, die wirklich nötig sind. |
| Akzeptanzkriterium / Acceptance criterion | Prüfbare Bedingung, ab der ein Ergebnis als erfüllt gilt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Auftrag verstehen.** Formuliere in wenigen, klaren Sätzen, was EuFPA vom Secure
CaseTracker erwartet: Fälle erfassen, Status verfolgen, Bearbeitung nachvollziehen. Warum kurz und
verständlich? Ein Auftrag, den auch Auszubildende im 1. Lehrjahr verstehen, verhindert Missverständnisse.

**EN:** **Step 1 – Understand the task.** State in a few clear sentences what EuFPA expects from the Secure
CaseTracker: record cases, track status, follow the processing. Why short and understandable? A task that
first-year apprentices can understand prevents misunderstandings.

**DE:** **Schritt 2 – In-Scope und Out-of-Scope trennen.** Liste getrennt auf, was das Projekt behandelt
(z. B. Fälle, Status, Notizen) und was nicht (z. B. Zahlungsabwicklung, echte Produktiv-Authentifizierung,
Cloud-Betrieb). Warum trennen? Nicht-Ziele sind genauso wichtig wie Ziele; ohne sie wächst das Projekt
unkontrolliert (Scope Creep).

**EN:** **Step 2 – Separate in-scope and out-of-scope.** List separately what the project covers (e.g. cases,
status, notes) and what it does not (e.g. payment processing, real production authentication, cloud
operation). Why separate? Non-goals are as important as goals; without them the project grows uncontrolled
(scope creep).

**DE:** **Schritt 3 – Rollen fachlich beschreiben.** Erkläre `learner`, `developer` und `reviewer` als
Aufgaben, nicht als Login. `learner` bearbeitet Lernaufgaben, `developer` implementiert, `reviewer` prüft.
Warum jetzt nur fachlich? Ein echtes Authentifizierungssystem ist hier `N/A`; die Rollen brauchen zuerst eine
klare Bedeutung, bevor Technik sie umsetzt.

**EN:** **Step 3 – Describe roles functionally.** Explain `learner`, `developer`, and `reviewer` as duties,
not as a login. `learner` works on learning tasks, `developer` implements, `reviewer` checks. Why only
functional now? A real authentication system is `N/A` here; the roles first need a clear meaning before
technology implements them.

**DE:** **Schritt 4 – Datenarten und Datenschutz benennen.** Nenne die Datenarten (Kontaktname,
Fallbeschreibung, Asset-Bezug, Bearbeitungsnotiz) und je einen Zweck. Setze Datenminimierung als frühes
Akzeptanzkriterium. Warum so früh? Wer erst am Ende an Datenschutz denkt, hat oft schon zu viele Daten
gesammelt.

**EN:** **Step 4 – Name data types and privacy.** Name the data types (contact name, case description, asset
reference, work note) and a purpose for each. Set data minimization as an early acceptance criterion. Why so
early? Whoever thinks about privacy only at the end has often already collected too much data.

**DE:** **Typische Fehler.** Alles „irgendwie" dazunehmen und nichts ausschließen. Rollen sofort als
Login-System denken. Echte Kundendaten statt fiktiver Beispiele. Offene Fragen löschen statt als `Open` mit
Owner zu notieren.

**EN:** **Common mistakes.** Including everything "somehow" and excluding nothing. Thinking of roles
immediately as a login system. Using real customer data instead of fictitious examples. Deleting open
questions instead of noting them as `Open` with an owner.

### Beispiel / Example

```text
Kundenauftrag:   EuFPA will Kundenfälle erfassen, deren Status verfolgen und die Bearbeitung nachvollziehen.
In-Scope:        Fall anlegen, Status ändern, Notiz ergänzen, Fall schließen, Rollen als Konzept.
Out-of-Scope:    Zahlung, echte Produktiv-Authentifizierung, Cloud-Betrieb, KI-Runtime (jeweils N/A + Grund).
Rollen:          learner (bearbeitet), developer (implementiert), reviewer (prueft) -> nur fachlich.
Datenarten:      Kontaktname (Ansprache), Fallbeschreibung (Bearbeitung), Notiz (Verlauf) -> minimiert.
Offen (Open):    "Braucht Export eine eigene Rolle?" -> Owner: reviewer, Folgeaufgabe Einheit 05/06.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Kundenauftrag, Rolle im Betrieb und Auftragsverständnis sind der Kern der Einheit. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Erste Schutzbedarfs- und Datenschutzannahmen entstehen bereits bei der Scope-Definition. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Ein Fall ist eine Serviceanfrage; der Auftrag ordnet die spätere Servicebearbeitung ein. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Anforderungen, Datenschutz, `N/A`-Begründung und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review als spätere Perspektive), `CL_09` (Testmanagement), `CL_10` (Kompetenz/Nachweis) und
`CL_12` (sichere Umgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Was nicht im Scope steht,
wird bewusst und begründet ausgeschlossen, nicht vergessen.* A11Y-Aspekt: In-Scope- und Out-of-Scope-Listen
werden als klare Textlisten geführt, verständlich mit Screenreader und ohne Farb-nur-Signale; die Rollen sind
sprachlich, nicht farblich unterschieden.

**EN:** Relation to the Secure Development Guideline: secure requirements, privacy, `N/A` justification, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review as
a later perspective), `CL_09` (test management), `CL_10` (competence/evidence), and `CL_12` (secure
environment). The security decision of this unit is: *what is not in scope is excluded deliberately and with a
reason, not forgotten.* Accessibility aspect: in-scope and out-of-scope lists are kept as clear text lists,
understandable with a screen reader and without color-only signals; the roles are distinguished by wording,
not by color.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine klare Out-of-Scope-Liste genauso wichtig wie die In-Scope-Liste? /
   **EN:** Why is a clear out-of-scope list as important as the in-scope list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie verhindert unkontrolliertes Wachstum und falsche Erwartungen. Alle wissen, was das Projekt
   bewusst nicht leistet, und die Arbeit bleibt planbar.
   **EN:** It prevents uncontrolled growth and wrong expectations. Everyone knows what the project
   deliberately does not do, and the work stays plannable.

   </details>

2. **DE:** Warum werden die Rollen zuerst nur fachlich und nicht als Login-System beschrieben? /
   **EN:** Why are the roles first described only functionally and not as a login system?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Rollen brauchen zuerst eine klare Bedeutung. Eine echte Authentifizierung ist hier `N/A` und
   folgt später; ohne fachliche Klarheit würde die Technik am Bedarf vorbeigehen.
   **EN:** The roles first need a clear meaning. Real authentication is `N/A` here and follows later; without
   functional clarity, the technology would miss the actual need.

   </details>

3. **DE:** (DPA) Welche Daten dürfen für spätere Kennzahlen genutzt werden, ohne unnötige personenbezogene Daten zu verarbeiten? /
   **EN:** (DPA) Which data may be used for later metrics without processing unnecessary personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aggregierte, technische Angaben wie Statuszeiten und Fallzahlen. Kontaktnamen oder Freitexte sind
   für Kennzahlen meist unnötig und werden nach Datenminimierung ausgelassen.
   **EN:** Aggregated, technical values such as status times and case counts. Contact names or free text are
   usually unnecessary for metrics and are left out following data minimization.

   </details>

4. **DE:** (AE) Welche spätere Implementierungsentscheidung hängt direkt vom Scope ab? /
   **EN:** (AE) Which later implementation decision depends directly on the scope?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel, welche Aktionen und Felder überhaupt umgesetzt werden. Was Out-of-Scope ist, wird
   nicht implementiert; der Scope steuert Datenmodell, Rollen und Tests.
   **EN:** For example, which actions and fields are implemented at all. What is out of scope is not built;
   the scope drives the data model, roles, and tests.

   </details>

5. **DE:** (SI) Welche Laufzeit- oder Sandbox-Annahme sollte früh geklärt werden? /
   **EN:** (SI) Which runtime or sandbox assumption should be clarified early?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ob und wann in der Sandbox gearbeitet wird und ob Netzwerkzugriff nötig ist. Solche Annahmen
   beeinflussen Betrieb und Werkzeuge und werden als `Open` notiert, wenn noch unklar.
   **EN:** Whether and when work happens in the sandbox and whether network access is needed. Such assumptions
   affect operation and tools and are noted as `Open` when still unclear.

   </details>

6. **DE:** Warum werden schon in dieser frühen Einheit Datenschutz- und Sicherheitsannahmen dokumentiert? /
   **EN:** Why are privacy and security assumptions documented already in this early unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Frühe Annahmen verhindern, dass später zu viele Daten gesammelt oder Risiken übersehen werden.
   Datenschutz und Sicherheit sind von Anfang an Teil des Auftrags, nicht ein Nachtrag.
   **EN:** Early assumptions prevent collecting too much data or overlooking risks later. Privacy and security
   are part of the task from the start, not an afterthought.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Kundenauftrag in wenigen, verständlichen Sätzen beschreiben.
- [ ] In-Scope und Out-of-Scope getrennt und begründet auflisten.
- [ ] die Rollen `learner`, `developer` und `reviewer` fachlich erklären.
- [ ] Datenarten mit Zweck benennen und Datenminimierung als Kriterium setzen.
- [ ] mindestens eine Datenschutz- und eine Sicherheitsannahme dokumentieren.

**EN:** I can …

- [ ] describe the customer task in a few understandable sentences.
- [ ] list in-scope and out-of-scope separately and with reasons.
- [ ] explain the roles `learner`, `developer`, and `reviewer` functionally.
- [ ] name data types with a purpose and set data minimization as a criterion.
- [ ] document at least one privacy and one security assumption.

## Kaufmännische Rollen-Umschaltung / Commercial Role Switch

**DE:** Diese Einheit lässt sich in der kaufmännischen Rolle als **Auftraggeber:in** fahren (Grundlage:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
Der Agent entwickelt; du beauftragst und nimmst ab.

- **KITSM:** Formuliere aus dem Kundenauftrag eine kurze **Leistungsbeschreibung** für das
  Case-Handling (Scope, Nicht-Ziele, messbare Abnahmekriterien, Service-/SLA-Aspekte) für `/specify`.
- **KDM:** Formuliere den **Datenbedarf** und ein erstes **Prozesskennzahl-Ziel** (z. B.
  „Cases je Status und Zeitraum") als Anforderung für `/specify`.
- **Pflicht-Touch:** hier noch kein Code — der aktive SQL-Schreib-Touch folgt in Einheit 06.
- **Abnahme (evidenzbasiert), eingebaute Abweichung:** Mindestens eine Anforderung in der Agenten-Spec
  ist unklar oder fehlt; finde sie über `/clarify`, bevor du abnimmst.

**EN:** Run this unit in the commercial role as **client** (basis:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
KITSM: turn the customer order into a short service description with measurable acceptance criteria and
SLA aspects for `/specify`. KDM: state the data need and a first process-metric goal for `/specify`.
Mandatory touch: no code yet — the active SQL write touch follows in unit 06. Evidence-based acceptance:
at least one requirement is unclear or missing; find it via `/clarify` before accepting.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
