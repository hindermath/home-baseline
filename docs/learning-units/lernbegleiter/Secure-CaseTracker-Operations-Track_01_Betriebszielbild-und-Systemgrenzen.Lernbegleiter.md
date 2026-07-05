# Lernbegleiter: Secure CaseTracker Operations Track 01 – Betriebszielbild und Systemgrenzen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In der Basis-Reihe hast du den CaseTracker gebaut. Jetzt betreibst du ihn. Betrieb bedeutet:
Das System läuft dauerhaft, jemand ist dafür verantwortlich, und wenn etwas ausfällt, muss klar sein, wer
was tut. Bevor du Pipelines, Logs oder Backups planst, brauchst du ein **Betriebszielbild**: Was soll der
Betrieb erreichen, wo hört deine Verantwortung auf, und wie schützenswert sind die Daten? Ohne dieses Bild
optimierst du Details, ohne das Ziel zu kennen.

**EN:** In the base series you built the CaseTracker. Now you operate it. Operation means: the system runs
continuously, someone is responsible for it, and when something fails, it must be clear who does what.
Before you plan pipelines, logs, or backups, you need an **operations target picture**: what should
operation achieve, where does your responsibility end, and how sensitive is the data? Without this picture
you optimize details without knowing the goal.

**DE:** In dieser Einheit lernst du, Betriebsziele messbar zu formulieren, Systemgrenzen sauber zu ziehen,
Verantwortlichkeiten zu benennen und den Schutzbedarf des betriebenen Systems zu bewerten. Das ist der
Rahmen, in den alle folgenden Einheiten des Operations Track passen.

**EN:** In this unit you learn to formulate operational goals measurably, to draw system boundaries cleanly,
to name responsibilities, and to assess the protection needs of the operated system. This is the frame into
which all following units of the Operations Track fit.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Betriebszielbild / Operations target picture | Klare Beschreibung, was der Betrieb erreichen soll und woran man Erfolg misst. |
| Systemgrenze / System boundary | Trennlinie zwischen dem, was du betreibst, und dem, was andere verantworten. |
| Verantwortlichkeit / Responsibility | Zuordnung, wer eine Aufgabe ausführt und wer über sie entscheidet. |
| Schutzbedarf / Protection need | Bewertung, wie schützenswert Vertraulichkeit, Integrität und Verfügbarkeit sind. |
| SLO / Service Level Objective | Messbares Betriebsziel, z. B. erlaubte Ausfallzeit oder Antwortzeit. |
| Betriebsmodell / Operating model | Beschreibung, wie das System dauerhaft betrieben, überwacht und gewartet wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebsziele messbar machen.** Ein Betriebsziel wie „das System soll stabil laufen"
ist zu vage. Formuliere es als **SLO**: erlaubte Ausfallzeit pro Monat, maximale Antwortzeit, akzeptabler
Datenverlust im Notfall. Nur messbare Ziele lassen sich später mit Logs und Kennzahlen prüfen.

**EN:** **Step 1 – Make operational goals measurable.** A goal like "the system should run stably" is too
vague. State it as an **SLO**: allowed downtime per month, maximum response time, acceptable data loss in an
emergency. Only measurable goals can later be checked with logs and metrics.

**DE:** **Schritt 2 – Systemgrenzen ziehen.** Zeichne auf, was zu deinem Betrieb gehört (Anwendung,
Datenhaltung, Konfiguration) und was nicht (Netzinfrastruktur, Fremdsysteme, Cloud-Basis). Genau an diesen
Grenzen entstehen später Schnittstellen, Übergaben und Vertrauensgrenzen. Was du nicht abgrenzt, kannst du
nicht sauber verantworten.

**EN:** **Step 2 – Draw system boundaries.** Map what belongs to your operation (application, data storage,
configuration) and what does not (network infrastructure, third-party systems, cloud base). Exactly at these
boundaries interfaces, handovers, and trust boundaries appear later. What you do not delimit, you cannot own
cleanly.

**DE:** **Schritt 3 – Verantwortlichkeiten benennen.** Ordne jede Betriebsaufgabe einer Rolle zu:
Wer deployt, wer überwacht, wer entscheidet im Notfall? Ein einfaches Rollen-Zuordnungsmodell verhindert,
dass im Ernstfall niemand oder alle gleichzeitig handeln. Trenne dabei „führt aus" von „entscheidet".

**EN:** **Step 3 – Name responsibilities.** Assign each operational task to a role: who deploys, who
monitors, who decides in an emergency? A simple role-assignment model prevents that in a real case nobody or
everybody acts at once. Separate "executes" from "decides".

**DE:** **Schritt 4 – Schutzbedarf bewerten.** Bewerte für Vertraulichkeit, Integrität und Verfügbarkeit,
wie hoch der Schaden bei einer Verletzung wäre (niedrig, mittel, hoch). Der Schutzbedarf steuert später,
wie viel Aufwand du in Secrets, Logging, Backup und Härtung steckst. Positive Schutzaussagen brauchen einen
Nachweis; wo etwas nicht anwendbar ist, dokumentierst du `N/A` mit Begründung.

**EN:** **Step 4 – Assess protection needs.** For confidentiality, integrity, and availability, rate how
high the damage of a breach would be (low, medium, high). The protection need later drives how much effort
you put into secrets, logging, backup, and hardening. Positive protection claims need evidence; where
something is not applicable, you document `N/A` with a rationale.

**DE:** **Typische Fehler.** Ziele ohne Messgröße. Systemgrenzen nur im Kopf, nicht schriftlich. Eine
einzige „Kümmerer"-Rolle für alles. Schutzbedarf pauschal auf „hoch" setzen, ohne zu begründen. Betrieb als
Nachgedanke behandeln statt als eigene Planungsaufgabe.

**EN:** **Common mistakes.** Goals without a metric. System boundaries only in your head, not written down.
A single "caretaker" role for everything. Setting protection needs to "high" everywhere without
justification. Treating operation as an afterthought instead of its own planning task.

### Beispiel / Example

```text
Betriebsziel (SLO):     "Verfügbarkeit 99,0 % im Monat, max. 15 Min. Antwortzeit-Ausreißer/Tag"
Systemgrenze (innen):   CaseTracker-Anwendung, Datei-/DB-Persistenz, App-Konfiguration
Systemgrenze (außen):   Betriebssystem-Patching, Netzwerk, Backup-Zielspeicher (anderes Team)
Verantwortlichkeit:     Deploy = Azubi (führt aus), Notfall-Freigabe = Ausbilder (entscheidet)
Schutzbedarf:           Vertraulichkeit mittel, Integrität hoch, Verfügbarkeit mittel
Nachweis:               docs/security/ + Betriebszielbild-Tabelle; offene Punkte als Open notiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12b Kundenspezifische Systemintegration durchführen | Primär / Primary | Betriebszielbild, Systemgrenzen und Verantwortlichkeiten sind der Auftakt einer kundenspezifischen Integration. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf des betriebenen Systems wird hier bewertet und begründet. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, klare Verantwortlichkeiten und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Review),
`CL_10` (Logging/Nachweise) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit
lautet: *Der Schutzbedarf wird vor dem Betrieb bewertet und steuert alle weiteren Maßnahmen.* A11Y-Aspekt:
Betriebszielbild und Rollenmatrix müssen als Text und Tabelle lesbar sein, nicht nur als Diagramm mit
Farben, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, clear responsibilities, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security review),
`CL_10` (logging/evidence), and `CL_12` (documentation/N-A). The security decision of this unit is: *the
protection need is assessed before operation and drives all further measures.* Accessibility aspect: the
operations picture and role matrix must be readable as text and table, not only as a colored diagram, so
they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht ein Betriebsziel wie „stabil laufen" nicht aus? /
   **EN:** Why is an operational goal like "run stably" not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es ist nicht messbar. Ohne Messgröße (z. B. Verfügbarkeit in Prozent, erlaubte Ausfallzeit) kann
   man später mit Logs und Kennzahlen nicht prüfen, ob das Ziel erreicht wurde. Ein SLO macht das Ziel prüfbar.
   **EN:** It is not measurable. Without a metric (e.g. availability in percent, allowed downtime) you cannot
   later check with logs and metrics whether the goal was met. An SLO makes the goal verifiable.

   </details>

2. **DE:** Wozu dienen klar gezogene Systemgrenzen im Betrieb? /
   **EN:** What are clearly drawn system boundaries good for in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie trennen deine Verantwortung von der anderer. An den Grenzen entstehen Schnittstellen,
   Übergaben und Vertrauensgrenzen. Klare Grenzen verhindern, dass im Störfall unklar ist, wer zuständig ist.
   **EN:** They separate your responsibility from that of others. At the boundaries interfaces, handovers, and
   trust boundaries appear. Clear boundaries prevent that in an incident it is unclear who is responsible.

   </details>

3. **DE:** Warum sollte man „führt aus" und „entscheidet" bei Verantwortlichkeiten trennen? /
   **EN:** Why should you separate "executes" and "decides" in responsibilities?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im Notfall braucht es eine ausführende und eine entscheidende Person. Trennt man das nicht,
   handelt entweder niemand oder mehrere widersprüchlich. Die Trennung schafft klare Eskalation und
   Nachvollziehbarkeit.
   **EN:** In an emergency you need an executing and a deciding person. Without separation, either nobody acts
   or several act contradictorily. The separation creates clear escalation and traceability.

   </details>

4. **DE:** Wie steuert der Schutzbedarf spätere Betriebseinheiten wie Secrets oder Backup? /
   **EN:** How do protection needs drive later operational units such as secrets or backup?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Schutzbedarf sagt, wie hoch der Schaden bei Verletzung wäre. Hoher Integritäts- oder
   Verfügbarkeitsbedarf rechtfertigt mehr Aufwand bei Secrets-Schutz, Logging, Backup und Härtung. Er
   priorisiert den Aufwand.
   **EN:** The protection need says how high the damage of a breach would be. High integrity or availability
   need justifies more effort in secrets protection, logging, backup, and hardening. It prioritizes the effort.

   </details>

5. **DE:** (SI) Was gehört bei einem betriebenen Serverdienst typischerweise *nicht* in deine Systemgrenze? /
   **EN:** (SI) What typically does *not* belong inside your system boundary for an operated server service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Oft nicht: Betriebssystem-Patching der Basis, physisches Netzwerk, Strom, Cloud-Grundinfrastruktur
   oder ein von einem anderen Team betriebener Backup-Speicher. Diese Abhängigkeiten werden als externe
   Verantwortung dokumentiert.
   **EN:** Often not: base OS patching, physical network, power, cloud base infrastructure, or a backup store
   operated by another team. These dependencies are documented as external responsibility.

   </details>

6. **DE:** (SI) Warum wird eine positive Verfügbarkeitsaussage nur mit Nachweis akzeptiert? /
   **EN:** (SI) Why is a positive availability claim only accepted with evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Nachweis ist die Aussage eine Behauptung. Auditfähiger Betrieb verlangt, dass Ziele mit
   Messungen (Logs, Monitoring, Testläufe) belegt werden. Nicht Belegbares wird als `Open` oder `N/A` mit
   Begründung notiert.
   **EN:** Without evidence the claim is just an assertion. Audit-ready operation requires goals to be backed
   by measurements (logs, monitoring, test runs). What cannot be shown is recorded as `Open` or `N/A` with a
   rationale.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] mindestens ein Betriebsziel als messbares SLO formulieren.
- [ ] die Systemgrenze meines Betriebs schriftlich innen/außen abgrenzen.
- [ ] Betriebsaufgaben Rollen zuordnen und „führt aus" von „entscheidet" trennen.
- [ ] den Schutzbedarf für Vertraulichkeit, Integrität und Verfügbarkeit begründet einstufen.
- [ ] offene Punkte als `Open` und nicht anwendbare Punkte als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] state at least one operational goal as a measurable SLO.
- [ ] delimit my operation's system boundary inside/outside in writing.
- [ ] assign operational tasks to roles and separate "executes" from "decides".
- [ ] rate protection needs for confidentiality, integrity, and availability with a rationale.
- [ ] record open items as `Open` and non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
