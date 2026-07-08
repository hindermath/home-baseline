# Lernbegleiter: Secure OrderDesk Operations Track 01 – Track-Baseline und Betriebszielbild / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In der Basis- und der v2-Reihe hast du die Bestell-/Handelsplattform von Secure Trader mit der
Northwind-Datenbasis inkl. `ALFKI` gebaut. Jetzt **betreibst** du sie als Fachinformatiker*in der
Systemintegration. Betrieb bedeutet: Die Datenbank und die Plattform laufen dauerhaft, jemand ist dafür
verantwortlich, und wenn etwas ausfällt, muss klar sein, wer was tut. Bevor du Deployment, Konfiguration,
Härtung oder Logging planst, brauchst du ein **Betriebszielbild**: Was soll der Betrieb erreichen, wo hört
deine Verantwortung auf, und wie schützenswert sind die Kunden- und Bestelldaten? Ohne dieses Bild optimierst
du Einzelteile, ohne das Ziel zu kennen.

**EN:** In the base and v2 series you built Secure Trader's ordering/trading platform with the Northwind data
base including `ALFKI`. Now you **operate** it as a System Integration IT specialist. Operation means: the
database and the platform run continuously, someone is responsible for them, and when something fails it must
be clear who does what. Before you plan deployment, configuration, hardening, or logging, you need an
**operations target picture**: what should operation achieve, where does your responsibility end, and how
sensitive is the customer and order data? Without this picture you optimize individual parts without knowing
the goal.

**DE:** In dieser Einheit lernst du, Betriebsziele als messbare SLO zu formulieren, Systemgrenzen sauber zu
ziehen, Verantwortlichkeiten zu benennen und den Schutzbedarf des betriebenen Datenbank-Dienstes zu bewerten.
Das ist der Rahmen, in den alle folgenden Einheiten des Operations Track passen. Als fachlicher Anker dient
die in v2 gebaute Plattform mit `ALFKI` als festem Testdatensatz.

**EN:** In this unit you learn to formulate operational goals as measurable SLOs, to draw system boundaries
cleanly, to name responsibilities, and to assess the protection need of the operated database service. This
is the frame into which all following units of the Operations Track fit. The functional anchor is the
platform built in v2 with `ALFKI` as a fixed test record.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Betriebszielbild / Operations target picture | Klare Beschreibung, was der Betrieb erreichen soll und woran man Erfolg misst. |
| SLO / Service Level Objective | Messbares Betriebsziel, z. B. erlaubte Ausfallzeit der Datenbank oder maximale Antwortzeit einer Abfrage. |
| Systemgrenze / System boundary | Trennlinie zwischen dem, was du betreibst, und dem, was andere verantworten. |
| Verantwortlichkeit / Responsibility | Zuordnung, wer eine Aufgabe ausführt und wer über sie entscheidet. |
| Schutzbedarf / Protection need | Bewertung, wie schützenswert Vertraulichkeit, Integrität und Verfügbarkeit der Kunden-/Bestelldaten sind. |
| Baseline / Baseline | Dokumentierter Ausgangszustand, gegen den spätere Änderungen und Nachweise verglichen werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebsziele messbar machen.** Ein Ziel wie „die Datenbank soll zuverlässig laufen" ist
zu vage. Formuliere es als **SLO**: z. B. „Datenbank in mindestens 99 % der Geschäftszeit erreichbar",
„typische Bestellabfrage antwortet in unter 200 Millisekunden", „Neustart des Dienstes nach Absturz in unter
60 Sekunden". Nur messbare Ziele lassen sich später mit Logs und Metriken prüfen.

**EN:** **Step 1 – Make operational goals measurable.** A goal like "the database should run reliably" is too
vague. State it as an **SLO**: e.g. "database reachable at least 99 % of business hours", "typical order query
answers in under 200 milliseconds", "service restart after a crash in under 60 seconds". Only measurable goals
can later be checked with logs and metrics.

**DE:** **Schritt 2 – Systemgrenzen ziehen.** Schreibe auf, was zu deinem Betrieb gehört (der Datenbank-Dienst,
seine Konfiguration, die Datendateien) und was nicht (Betriebssystem-Patching, Netzwerk, ein von einem anderen
Team betriebener Backup-Speicher). An genau diesen Grenzen entstehen später Schnittstellen, Übergaben und
Vertrauensgrenzen. Was du nicht abgrenzt, kannst du nicht sauber verantworten.

**EN:** **Step 2 – Draw system boundaries.** Write down what belongs to your operation (the database service,
its configuration, the data files) and what does not (base OS patching, network, a backup store operated by
another team). Exactly at these boundaries interfaces, handovers, and trust boundaries appear later. What you
do not delimit, you cannot own cleanly.

**DE:** **Schritt 3 – Verantwortlichkeiten benennen.** Ordne jede Betriebsaufgabe einer Rolle zu: Wer
deployt, wer überwacht, wer entscheidet im Notfall über einen Restore? Trenne „führt aus" von „entscheidet".
So handelt im Ernstfall nicht niemand oder alle gleichzeitig, sondern es gibt eine klare Eskalation.

**EN:** **Step 3 – Name responsibilities.** Assign each operational task to a role: who deploys, who monitors,
who decides on a restore in an emergency? Separate "executes" from "decides". This way, in a real case neither
nobody nor everybody acts at once; there is a clear escalation.

**DE:** **Schritt 4 – Schutzbedarf bewerten.** Bewerte für Vertraulichkeit, Integrität und Verfügbarkeit,
wie hoch der Schaden bei einer Verletzung wäre (niedrig, mittel, hoch). Bei Kunden- und Bestelldaten ist die
Vertraulichkeit oft mittel bis hoch (Personenbezug) und die Integrität hoch, weil aus den Bestellungen
Geschäftsentscheidungen folgen. Der Schutzbedarf steuert später, wie viel Aufwand du in Secrets, Härtung,
Logging und Backup steckst. Positive Aussagen brauchen einen Nachweis; nicht Anwendbares wird als `N/A` mit
Begründung notiert.

**EN:** **Step 4 – Assess protection needs.** For confidentiality, integrity, and availability, rate how high
the damage of a breach would be (low, medium, high). For customer and order data, confidentiality is often
medium to high (personal reference) and integrity is high because business decisions are derived from orders.
The protection need later drives how much effort you put into secrets, hardening, logging, and backup.
Positive claims need evidence; what is not applicable is recorded as `N/A` with a rationale.

**DE:** **Typische Fehler.** Ziele ohne Messgröße. Systemgrenzen nur im Kopf, nicht schriftlich. Eine einzige
„Kümmerer"-Rolle für alles. Schutzbedarf pauschal auf „hoch" setzen, ohne zu begründen. Betrieb als
Nachgedanke behandeln statt als eigene Planungsaufgabe.

**EN:** **Common mistakes.** Goals without a metric. System boundaries only in your head, not written down. A
single "caretaker" role for everything. Setting protection needs to "high" everywhere without justification.
Treating operation as an afterthought instead of its own planning task.

### Beispiel / Example

```text
Betriebsziel (SLO):     "Datenbank 99 % der Geschäftszeit erreichbar; Neustart nach Absturz < 60 s"
Systemgrenze (innen):   Datenbank-Dienst, Plattform-Konfiguration, lokale Datendateien
Systemgrenze (außen):   OS-Patching, Netzwerk, zentraler Backup-Speicher (anderes Team)
Verantwortlichkeit:     Deploy = Azubi (führt aus), Restore-Freigabe = Ausbilder (entscheidet)
Schutzbedarf:           Vertraulichkeit mittel-hoch, Integrität hoch, Verfügbarkeit mittel
Datenanker:             Northwind-Datenbasis inkl. ALFKI (fiktiv)
Nachweis:               docs/security/ + SLO-/Systemgrenzen-Tabelle; offene Punkte als Open
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b;
berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b;
touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12b Kundenspezifische Systemintegration durchführen | Primär / Primary | Betriebszielbild, Systemgrenzen und Verantwortlichkeiten sind der Auftakt einer kundenspezifischen Integration. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf der betriebenen Kunden- und Bestelldaten wird hier bewertet und begründet. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, klare Verantwortlichkeiten und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Review),
`CL_10` (Logging/Nachweise) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit
lautet: *Der Schutzbedarf der Kunden- und Bestelldaten wird vor dem Betrieb bewertet und steuert alle weiteren
Maßnahmen.* A11Y-Aspekt: SLO-Tabelle, Systemgrenzen und Rollenmatrix müssen als Text und Tabelle lesbar sein,
nicht nur als farbiges Diagramm, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, clear responsibilities, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security review),
`CL_10` (logging/evidence), and `CL_12` (documentation/N-A). The security decision of this unit is: *the
protection need of customer and order data is assessed before operation and drives all further measures.*
Accessibility aspect: the SLO table, system boundaries, and role matrix must be readable as text and table,
not only as a colored diagram, so they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht ein Betriebsziel wie „die Datenbank soll zuverlässig laufen" nicht aus? /
   **EN:** Why is an operational goal like "the database should run reliably" not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es ist nicht messbar. Ohne Messgröße (z. B. Erreichbarkeit in Prozent, maximale Antwortzeit) kann
   man später mit Logs und Metriken nicht prüfen, ob das Ziel erreicht wurde. Ein SLO macht das Ziel prüfbar.
   **EN:** It is not measurable. Without a metric (e.g. availability in percent, maximum response time) you
   cannot later check with logs and metrics whether the goal was met. An SLO makes the goal verifiable.

   </details>

2. **DE:** Wozu dienen klar gezogene Systemgrenzen im Datenbank-Betrieb? /
   **EN:** What are clearly drawn system boundaries good for in database operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie trennen deine Verantwortung von der anderer. An den Grenzen entstehen Schnittstellen,
   Übergaben und Vertrauensgrenzen. Klare Grenzen verhindern, dass im Störfall unklar ist, wer zuständig ist.
   **EN:** They separate your responsibility from that of others. At the boundaries interfaces, handovers, and
   trust boundaries appear. Clear boundaries prevent that in an incident it is unclear who is responsible.

   </details>

3. **DE:** (SI) Was gehört bei einem betriebenen Datenbank-Dienst typischerweise *nicht* in deine Systemgrenze? /
   **EN:** (SI) What typically does *not* belong inside your system boundary for an operated database service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Oft nicht: Betriebssystem-Patching der Basis, physisches Netzwerk, Strom, Cloud-Grundinfrastruktur
   oder ein von einem anderen Team betriebener Backup-Speicher. Diese Abhängigkeiten dokumentierst du als
   externe Verantwortung.
   **EN:** Often not: base OS patching, physical network, power, cloud base infrastructure, or a backup store
   operated by another team. You document these dependencies as external responsibility.

   </details>

4. **DE:** (SI) Warum trennt man „führt aus" und „entscheidet" bei Betriebsverantwortlichkeiten? /
   **EN:** (SI) Why do you separate "executes" and "decides" in operational responsibilities?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im Notfall, etwa bei einem nötigen Restore, braucht es eine ausführende und eine entscheidende
   Person. Ohne Trennung handelt entweder niemand oder mehrere widersprüchlich. Die Trennung schafft klare
   Eskalation und Nachvollziehbarkeit.
   **EN:** In an emergency, e.g. a needed restore, you need an executing and a deciding person. Without
   separation, either nobody acts or several act contradictorily. The separation creates clear escalation and
   traceability.

   </details>

5. **DE:** (DPA) Warum ist der Schutzbedarf „Integrität" für die Bestelldaten oft hoch? /
   **EN:** (DPA) Why is the "integrity" protection need often high for the order data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus den Bestelldaten werden Geschäftsentscheidungen und Auswertungen abgeleitet, etwa Umsatz je
   Zeitraum. Falsche oder manipulierte Bestellungen führen direkt zu falschen Entscheidungen, daher zählt die
   Integrität stark.
   **EN:** Business decisions and reports are derived from order data, e.g. revenue per period. Wrong or
   manipulated orders lead directly to wrong decisions, so integrity matters strongly.

   </details>

6. **DE:** (AE) Wie wirkt ein Betriebsziel auf den Aufbau der Datenzugriffsschicht zurück? /
   **EN:** (AE) How does an operational goal feed back into the structure of the data access layer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein SLO wie „Neustart nach Absturz < 60 s" verlangt, dass Verbindungen sauber auf- und abgebaut
   werden und der Dienst seinen Zustand nicht verliert. Ein SLO für Antwortzeiten beeinflusst Indizes,
   Verbindungspools und Abfragegestaltung. Betriebsziele wirken so auf Startlogik, Konfigurierbarkeit und
   Datenzugriff.
   **EN:** An SLO like "restart after crash < 60 s" requires connections to open and close cleanly and the
   service not to lose state. A response-time SLO influences indexes, connection pools, and query design.
   Operational goals thus influence startup logic, configurability, and data access.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel:
   Backup-Detailplanung ist in dieser Baseline-Einheit `N/A`, weil sie in einer späteren Einheit behandelt
   wird. So bleibt sichtbar, dass der Punkt geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: detailed backup
   planning is `N/A` in this baseline unit because it is covered in a later unit. This keeps visible that the
   point was checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] mindestens ein Betriebsziel des Datenbank-Betriebs als messbares SLO formulieren.
- [ ] die Systemgrenze meines Betriebs schriftlich innen/außen abgrenzen.
- [ ] Betriebsaufgaben Rollen zuordnen und „führt aus" von „entscheidet" trennen.
- [ ] den Schutzbedarf der Kunden-/Bestelldaten für Vertraulichkeit, Integrität und Verfügbarkeit begründet einstufen.
- [ ] offene Punkte als `Open` und nicht anwendbare Punkte als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] state at least one operational goal of the database operation as a measurable SLO.
- [ ] delimit my operation's system boundary inside/outside in writing.
- [ ] assign operational tasks to roles and separate "executes" from "decides".
- [ ] rate the protection need of customer/order data for confidentiality, integrity, and availability with a rationale.
- [ ] record open items as `Open` and non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
