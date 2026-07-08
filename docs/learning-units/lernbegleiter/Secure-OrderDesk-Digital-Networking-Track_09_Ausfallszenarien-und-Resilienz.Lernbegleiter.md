# Lernbegleiter: Secure OrderDesk Digital Networking Track 09 – Ausfallszenarien und Resilienz / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Bestell-Pipeline von Secure Trader läuft nie störungsfrei: Der Katalogdienst fällt aus, das Netz zur
relationalen Ablage wird geteilt (Partition), oder die Bestellannahme ist kurz nicht erreichbar. **Resilienz**
ist die Fähigkeit, solche Störungen sicher zu überstehen, statt komplett auszufallen oder – schlimmer –
unbemerkt falsche Bestelldaten zu verarbeiten. In dieser Einheit betrachtest du **Ausfallszenarien**
systematisch und entscheidest, wie die Pipeline reagiert: Läuft sie eingeschränkt weiter (**degradierter
Betrieb**), etwa indem Bestellungen zwischengepuffert werden? Springt eine Ersatzkomponente ein (**Failover**)?
Wie kommt sie nach der Störung sauber zurück (**Wiederanlauf**)? Und wie groß ist der Schaden im schlimmsten Fall
(**Blast-Radius**)?

**EN:** Secure Trader's order pipeline never runs without disturbance: the catalog service fails, the network to
the relational store is split (partition), or the order intake is briefly unreachable. **Resilience** is the
ability to survive such disturbances safely, instead of failing completely or – worse – silently processing
wrong order data. In this unit you look at **failure scenarios** systematically and decide how the pipeline
reacts: does it keep running with limitations (**degraded operation**), e.g. by buffering orders? Does a
replacement component step in (**failover**)? How does it come back cleanly after the disturbance
(**recovery**)? And how large is the damage in the worst case (**blast radius**)?

**DE:** Der wichtigste Grundsatz ist **Fail-Safe**: Bei einer Störung fällt die Pipeline in einen **sicheren**
Zustand, nicht in einen offenen. Lieber ehrlich „Bestellung noch nicht bestätigt" melden als eine Bestellung
stillschweigend verlieren oder doppelt anlegen. Restrisiken werden ehrlich benannt, nicht beschönigt. Die
Lösung bleibt sprachneutral für C#, Go, Java, Python, Rust und Swift.

**EN:** The most important principle is **fail-safe**: on a disturbance the pipeline falls into a **safe** state,
not an open one. Better to honestly report "order not yet confirmed" than to silently lose an order or create it
twice. Residual risks are named honestly, not glossed over. The solution stays language-neutral for C#, Go,
Java, Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Resilienz / Resilience | Fähigkeit, Störungen sicher zu überstehen und sich zu erholen. |
| Ausfallszenario / Failure scenario | Konkrete Störung wie Katalog-, Netz- oder Bestellannahme-Ausfall. |
| Netzpartition / Network partition | Das Netz zerfällt in Teile, die einander nicht erreichen. |
| Degradierter Betrieb / Degraded operation | Eingeschränkter, aber sicherer Weiterbetrieb, z. B. Bestellungen puffern. |
| Failover / Failover | Umschalten auf eine Ersatzkomponente bei Ausfall. |
| Wiederanlauf / Recovery | Geordnete Rückkehr in den Normalbetrieb nach der Störung. |
| Blast-Radius / Blast radius | Reichweite des Schadens, den eine Störung auslösen kann. |
| Fail-Safe / Fail-safe | Verhalten, das im Fehlerfall in einen sicheren Zustand fällt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ausfallszenarien systematisch sammeln.** Gehe die Bestell-Pipeline durch und benenne die
wichtigsten Störungen: Katalogdienst fällt aus, Netzpartition zwischen Bestellannahme und relationaler Ablage,
Bestellannahme nicht erreichbar, Ablage langsam oder voll. Erst wer die Szenarien benennt, kann sie absichern.

**EN:** **Step 1 – Collect failure scenarios systematically.** Go through the order pipeline and name the main
disturbances: catalog service fails, network partition between order intake and relational store, order intake
unreachable, store slow or full. Only by naming the scenarios can you protect against them.

**DE:** **Schritt 2 – Degradierten Betrieb definieren.** Kläre je Szenario: Was soll noch funktionieren, was
nicht? Fällt der Katalog aus, kann die Bestellannahme Bestellungen zwischenpuffern und als „angenommen, noch
nicht bestätigt" kennzeichnen – nicht als „abgeschlossen". Wichtig: Der eingeschränkte Betrieb muss in einen
**sicheren** Zustand fallen (Fail-Safe), keine falschen Bestätigungen aussprechen.

**EN:** **Step 2 – Define degraded operation.** For each scenario clarify: what should still work, what not? If
the catalog fails, the order intake can buffer orders and mark them as "accepted, not yet confirmed" – not as
"completed". Important: the limited operation must fall into a **safe** state (fail-safe), issuing no false
confirmations.

**DE:** **Schritt 3 – Failover und Wiederanlauf planen.** Für kritische Komponenten überlegst du einen Failover:
Gibt es eine Ersatzinstanz der Bestellannahme, die übernimmt? Genauso wichtig ist der Wiederanlauf: Wenn Katalog
oder Ablage zurückkommen, müssen gepufferte Bestellungen sauber nachverarbeitet werden, ohne eine Bestellung
doppelt anzulegen. Idempotenz (mehrfaches Verarbeiten derselben Bestellung ändert das Ergebnis nicht) hilft hier.

**EN:** **Step 3 – Plan failover and recovery.** For critical components consider a failover: is there a
replacement instance of the order intake that takes over? Just as important is recovery: when catalog or store
come back, buffered orders must be post-processed cleanly without creating an order twice. Idempotency
(processing the same order multiple times does not change the result) helps here.

**DE:** **Schritt 4 – Blast-Radius begrenzen.** Frage je Szenario: Wie weit reicht der Schaden? Ein Ausfall des
Katalogdienstes darf nicht die ganze Bestellannahme mitreißen. Die Segmentierung und Vertrauenszonen aus Einheit
04 helfen, den Blast-Radius klein zu halten: Störung bleibt möglichst lokal. Notiere je Szenario die
Gegenmaßnahme, die den Radius begrenzt.

**EN:** **Step 4 – Limit the blast radius.** For each scenario ask: how far does the damage reach? A catalog
service outage must not take down the whole order intake. The segmentation and trust zones from unit 04 help keep
the blast radius small: a disturbance stays as local as possible. For each scenario note the countermeasure that
limits the radius.

**DE:** **Schritt 5 – Restrisiken ehrlich benennen und nachweisen.** Nicht jedes Risiko lässt sich beseitigen.
Dokumentiere, was offen bleibt, und wie du Resilienz nachweist – zum Beispiel durch einen Test, der einen
Katalog-Ausfall simuliert und zeigt, dass die Pipeline sicher degradiert. Beschreibe Ausfälle didaktisch, nicht
als Angriffsanleitung, und stelle Restrisiken nicht als behoben dar.

**EN:** **Step 5 – Name residual risks honestly and evidence them.** Not every risk can be eliminated. Document
what stays open and how you evidence resilience – for example with a test that simulates a catalog outage and
shows the pipeline degrades safely. Describe outages didactically, not as an attack manual, and do not present
residual risks as resolved.

**DE:** **Typische Fehler.** Nur den Normalbetrieb betrachten. Bei Störung „bestätigt" statt „noch nicht
bestätigt" melden (keine Fail-Safe). Wiederanlauf ohne Idempotenz, sodass Bestellungen doppelt entstehen. Den
Blast-Radius nicht begrenzen. Ausfälle als Angriffsanleitung ausformulieren. Restrisiken beschönigen. Nicht
anwendbare Standards still weglassen statt als `N/A` mit Begründung.

**EN:** **Common mistakes.** Considering only normal operation. On disturbance reporting "confirmed" instead of
"not yet confirmed" (no fail-safe). Recovery without idempotency, so orders are created twice. Not limiting the
blast radius. Writing outages as an attack manual. Glossing over residual risks. Silently dropping non-applicable
standards instead of documenting them as `N/A` with a rationale.

### Beispiel / Example

```text
Ausfallszenario-Tabelle (Auszug):
  Szenario                Reaktion (degradiert)          Blast-Radius   Gegenmassnahme
  Katalog faellt aus      Bestellung puffern;            1 Dienst       "angenommen, nicht bestaetigt"
                          keine falsche Bestaetigung
  Netzpartition Ablage    Bestellungen lokal puffern;    Teilnetz       Nachverarbeitung + Idempotenz
                          Merge nach Wiederanlauf
  Bestellannahme aus      Failover-Instanz uebernimmt;   Eingang        Failover + begrenzte Queue
                          Client sieht Wiederholung
  Ablage voll             Schreibstopp, Alarm;           zentral        Fail-Safe: ablehnen statt verlieren
                          keine stille Bestellverluste

Wiederanlauf:  idempotente Nachverarbeitung; keine doppelte Bestellung (Order-Key)
Fail-Safe:     "noch nicht bestaetigt" statt falsch "abgeschlossen"
Restrisiko:    lange Partition -> gepufferte Bestellungen altern | Eintritt: mittel | Wirkung: mittel -> beobachten
Nachweis:      Ausfall-Simulationstest zeigt sichere Degradation; Secrets nur <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11d**
ist primär, weil Resilienz entscheidet, wie Bestellannahme, Katalog und relationale Ablage bei Störung, Partition
oder Ausfall sicher weiterlaufen; LF 3 und LF 9 sind berührt, weil Clienteinbindung und Dienstbereitstellung das
Ausfallverhalten prägen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
11d** is primary because resilience decides how order intake, catalog, and relational store continue safely under
disturbance, partition, or outage; LF 3 and LF 9 are touched because client integration and service provisioning
shape the failure behavior.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Ausfallszenarien und Resilienz der Bestell-Pipeline gehören zum sicheren Betrieb vernetzter Systeme. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Das Ausfall- und Wiederanlaufverhalten der Bestellannahme betrifft die Netzeinbindung der Clients. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Failover und degradierter Betrieb sind Teil einer belastbaren Bereitstellung der Pipeline-Dienste. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Defense in Depth, Fail-Safe Defaults, Resilienz,
Angriffsflächenreduktion und Review-Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_04` (Bedrohungsmodellierung/Testmanagement), `CL_08` (Sicherheits-Code-Review) und
`CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Bei Störung fällt die
Pipeline in einen sicheren Zustand (Fail-Safe), meldet ehrlich „noch nicht bestätigt", begrenzt den Blast-Radius
und läuft idempotent wieder an.* A11Y-Aspekt: Ausfallszenario- und Blast-Radius-Tabellen müssen als reiner Text
mit Kopfzeile lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: defense in depth, fail-safe defaults, resilience, attack
surface reduction, and review evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling/test management), `CL_08` (security code review), and `CL_12`
(evidence and closure). The security decision of this unit is: *on disturbance the pipeline falls into a safe
state (fail-safe), honestly reports "not yet confirmed", limits the blast radius, and recovers idempotently.*
Accessibility aspect: failure-scenario and blast-radius tables must be readable as plain text with a header row,
without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was bedeutet degradierter Betrieb bei einem Ausfall des Katalogdienstes? /
   **EN:** (DV) What does degraded operation mean on a catalog service failure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Bestellannahme puffert Bestellungen zwischen und kennzeichnet sie als „angenommen, noch nicht
   bestätigt" statt als „abgeschlossen". Die Pipeline arbeitet eingeschränkt, aber sicher weiter, ohne falsche
   Bestätigungen.
   **EN:** The order intake buffers orders and marks them as "accepted, not yet confirmed" instead of
   "completed". The pipeline continues with limitations but safely, without false confirmations.

   </details>

2. **DE:** (DV) Warum ist eine Netzpartition zur relationalen Ablage besonders heikel? /
   **EN:** (DV) Why is a network partition to the relational store especially tricky?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einer Partition erreicht die Bestellannahme die Ablage nicht mehr, nimmt aber lokal weiter
   Bestellungen an. Nach dem Wiederanlauf müssen die gepufferten Bestellungen nachverarbeitet werden, ohne doppelt
   anzulegen; dafür braucht es Idempotenz über einen Order-Key.
   **EN:** In a partition the order intake no longer reaches the store but keeps accepting orders locally. After
   recovery the buffered orders must be post-processed without duplication; that requires idempotency via an order
   key.

   </details>

3. **DE:** Warum muss degradierter Betrieb in einen sicheren und nicht in einen offenen Zustand fallen? /
   **EN:** Why must degraded operation fall into a safe and not an open state?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein offener Zustand könnte falsche Bestätigungen aussprechen oder Zugriffe zulassen, die sonst
   gesperrt sind. Fail-Safe meldet ehrlich „noch nicht bestätigt" und hält Sicherheitsgrenzen ein, auch bei
   Störung.
   **EN:** An open state could issue false confirmations or allow access that is otherwise blocked. Fail-safe
   honestly reports "not yet confirmed" and keeps security boundaries even under disturbance.

   </details>

4. **DE:** Warum hilft Idempotenz beim Wiederanlauf nach einer Störung? /
   **EN:** Why does idempotency help during recovery after a disturbance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Idempotenz bedeutet, dass mehrfaches Verarbeiten derselben Bestellung das Ergebnis nicht verändert.
   Beim Nachverarbeiten gepufferter Bestellungen entstehen so keine Doppelbestellungen, und bestehende Datensätze
   werden nicht falsch überschrieben.
   **EN:** Idempotency means that processing the same order multiple times does not change the result. When
   post-processing buffered orders, no duplicate orders arise and existing records are not wrongly overwritten.

   </details>

5. **DE:** (SI) Wie weist man nach, dass die Pipeline bei einem Ausfall sicher degradiert? /
   **EN:** (SI) How do you evidence that the pipeline degrades safely on an outage?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Ausfall-Simulationstest: Man schaltet gezielt den Katalogdienst oder die Ablage ab und
   prüft, dass die Bestellannahme eingeschränkt, aber sicher weiterläuft und keine falschen Bestätigungen
   ausspricht.
   **EN:** With an outage simulation test: you deliberately shut off the catalog service or the store and check
   that the order intake continues with limitations but safely and issues no false confirmations.

   </details>

6. **DE:** (DPA) Welche Aussagegrenze entsteht für Kennzahlen im degradierten Betrieb der Bestellannahme? /
   **EN:** (DPA) Which limit of validity arises for metrics in degraded order-intake operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werden Bestellungen nur gepuffert und noch nicht bestätigt, gilt eine Kennzahl wie „abgeschlossene
   Bestellungen" nur für die tatsächlich persistierten Vorgänge. Die Grenze („gilt nur für bestätigte Bestellungen
   während der Störung") muss ausdrücklich mitgeführt werden.
   **EN:** If orders are only buffered and not yet confirmed, a metric like "completed orders" holds only for the
   actually persisted cases. The limit ("valid only for confirmed orders during the disturbance") must be carried
   along explicitly.

   </details>

7. **DE:** Warum werden Restrisiken benannt und nicht als behoben dargestellt? /
   **EN:** Why are residual risks named and not presented as resolved?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein als behoben dargestelltes Risiko wird nicht mehr beobachtet und trifft dann unvorbereitet. Ehrlich
   benannt mit Eintritt und Wirkung bleibt es im Blick und kann bei Bedarf behandelt werden.
   **EN:** A risk presented as resolved is no longer watched and then strikes unprepared. Named honestly with
   occurrence and impact, it stays in view and can be treated when needed.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die wichtigsten Ausfallszenarien der Bestell-Pipeline benennen.
- [ ] degradierten Betrieb je Szenario als Fail-Safe definieren.
- [ ] Failover und idempotenten Wiederanlauf planen.
- [ ] den Blast-Radius je Szenario begrenzen.
- [ ] Resilienz durch einen Ausfall-Simulationstest nachweisen.
- [ ] Restrisiken ehrlich mit Eintritt und Wirkung dokumentieren.

**EN:** I can …

- [ ] name the main failure scenarios of the order pipeline.
- [ ] define degraded operation per scenario as fail-safe.
- [ ] plan failover and idempotent recovery.
- [ ] limit the blast radius per scenario.
- [ ] evidence resilience with an outage simulation test.
- [ ] document residual risks honestly with occurrence and impact.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`. Sie baut auf den
Betriebs- und Netznachweisen (Einheit 08) auf und liefert die Grundlage für das Netz-Review und den Abschluss
(Einheit 10). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`. It builds on the
operational and network evidence (unit 08) and provides the basis for the network review and closure (unit 10).
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
