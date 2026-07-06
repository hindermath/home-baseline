# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 09 – Ausfallszenarien und Resilienz / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein verteiltes Sammelsystem läuft nie störungsfrei: Ein Agent fällt aus, das Netz wird geteilt
(Partition), oder der zentrale Sammler-Dienst ist kurz nicht erreichbar. **Resilienz** ist die Fähigkeit, solche
Störungen sicher zu überstehen, statt komplett auszufallen oder – schlimmer – unbemerkt falsche Daten zu liefern.
In dieser Einheit betrachtest du **Ausfallszenarien** systematisch und entscheidest, wie das System reagiert:
Läuft es eingeschränkt weiter (**degradierter Betrieb**)? Springt eine Ersatzkomponente ein (**Failover**)? Wie
kommt es nach der Störung sauber zurück (**Wiederanlauf**)? Und wie groß ist der Schaden im schlimmsten Fall
(**Blast-Radius**)?

**EN:** A distributed collection system never runs without disturbance: an agent fails, the network is split
(partition), or the central collector service is briefly unreachable. **Resilience** is the ability to survive
such disturbances safely, instead of failing completely or – worse – silently delivering wrong data. In this unit
you look at **failure scenarios** systematically and decide how the system reacts: does it keep running with
limitations (**degraded operation**)? Does a replacement component step in (**failover**)? How does it come back
cleanly after the disturbance (**recovery**)? And how large is the damage in the worst case (**blast radius**)?

**DE:** Der wichtigste Grundsatz ist **Fail-Safe**: Bei einer Störung fällt das System in einen **sicheren**
Zustand, nicht in einen offenen. Lieber ehrlich „Daten unvollständig" melden als stillschweigend falsche Zahlen
zeigen. Restrisiken werden ehrlich benannt, nicht beschönigt. Die C#-Referenz `InventarWorkerService` dient als
Orientierung; die Lösung bleibt sprachneutral.

**EN:** The most important principle is **fail-safe**: on a disturbance the system falls into a **safe** state, not
an open one. Better to honestly report "data incomplete" than to silently show wrong numbers. Residual risks are
named honestly, not glossed over. The C# reference `InventarWorkerService` serves as orientation; the solution
stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Resilienz / Resilience | Fähigkeit, Störungen sicher zu überstehen und sich zu erholen. |
| Ausfallszenario / Failure scenario | Konkrete Störung wie Agent-, Netz- oder Dienstausfall. |
| Netzpartition / Network partition | Das Netz zerfällt in Teile, die einander nicht erreichen. |
| Degradierter Betrieb / Degraded operation | Eingeschränkter, aber sicherer Weiterbetrieb bei Störung. |
| Failover / Failover | Umschalten auf eine Ersatzkomponente bei Ausfall. |
| Wiederanlauf / Recovery | Geordnete Rückkehr in den Normalbetrieb nach der Störung. |
| Blast-Radius / Blast radius | Reichweite des Schadens, den eine Störung auslösen kann. |
| Fail-Safe / Fail-safe | Verhalten, das im Fehlerfall in einen sicheren Zustand fällt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ausfallszenarien systematisch sammeln.** Gehe die verteilte Sammlung durch und benenne die
wichtigsten Störungen: einzelner Agent fällt aus, Netzpartition zwischen Agenten und Sammler, zentraler
Sammler-Dienst nicht erreichbar, Datenhaltung langsam oder voll. Erst wer die Szenarien benennt, kann sie
absichern.

**EN:** **Step 1 – Collect failure scenarios systematically.** Go through the distributed collection and name the
main disturbances: a single agent fails, network partition between agents and collector, central collector service
unreachable, storage slow or full. Only by naming the scenarios can you protect against them.

**DE:** **Schritt 2 – Degradierten Betrieb definieren.** Kläre je Szenario: Was soll noch funktionieren, was nicht?
Fällt ein Agent aus, sammelt der Rest weiter, und die betroffene Maschine wird als „unbekannt/veraltet"
gekennzeichnet – nicht als „läuft". Wichtig: Der eingeschränkte Betrieb muss in einen **sicheren** Zustand fallen
(Fail-Safe), keine falschen Vollständigkeitsaussagen machen.

**EN:** **Step 2 – Define degraded operation.** For each scenario clarify: what should still work, what not? If an
agent fails, the rest keeps collecting, and the affected machine is marked as "unknown/stale" – not as "running".
Important: the limited operation must fall into a **safe** state (fail-safe), making no false completeness claims.

**DE:** **Schritt 3 – Failover und Wiederanlauf planen.** Für kritische Komponenten überlegst du einen Failover:
Gibt es eine Ersatzinstanz, die übernimmt? Genauso wichtig ist der Wiederanlauf: Wenn ein Agent oder der Dienst
zurückkommt, muss er sich sauber wieder einklinken, ohne Daten doppelt zu zählen oder alte Zustände zu
überschreiben. Idempotenz (mehrfaches Melden ändert das Ergebnis nicht) hilft hier.

**EN:** **Step 3 – Plan failover and recovery.** For critical components consider a failover: is there a
replacement instance that takes over? Just as important is recovery: when an agent or the service comes back, it
must rejoin cleanly without double-counting data or overwriting old states. Idempotency (reporting multiple times
does not change the result) helps here.

**DE:** **Schritt 4 – Blast-Radius begrenzen.** Frage je Szenario: Wie weit reicht der Schaden? Ein kompromittierter
oder ausgefallener Agent darf nicht den ganzen Dienst mitreißen. Die Segmentierung aus Einheit 04 hilft, den
Blast-Radius klein zu halten: Störung bleibt möglichst lokal. Notiere je Szenario die Gegenmaßnahme, die den Radius
begrenzt.

**EN:** **Step 4 – Limit the blast radius.** For each scenario ask: how far does the damage reach? A compromised or
failed agent must not take down the whole service. The segmentation from unit 04 helps keep the blast radius small:
a disturbance stays as local as possible. For each scenario note the countermeasure that limits the radius.

**DE:** **Schritt 5 – Restrisiken ehrlich benennen und nachweisen.** Nicht jedes Risiko lässt sich beseitigen.
Dokumentiere, was offen bleibt, und wie du Resilienz nachweist – zum Beispiel durch einen Test, der einen Ausfall
simuliert und zeigt, dass das System sicher degradiert. Beschreibe Ausfälle didaktisch, nicht als Angriffsanleitung,
und stelle Restrisiken nicht als behoben dar.

**EN:** **Step 5 – Name residual risks honestly and evidence them.** Not every risk can be eliminated. Document what
stays open and how you evidence resilience – for example with a test that simulates an outage and shows the system
degrades safely. Describe outages didactically, not as an attack manual, and do not present residual risks as
resolved.

**DE:** **Typische Fehler.** Nur den Normalbetrieb betrachten. Bei Störung „läuft" statt „unbekannt" melden (keine
Fail-Safe). Wiederanlauf ohne Idempotenz, sodass Daten doppelt zählen. Den Blast-Radius nicht begrenzen. Ausfälle
als Angriffsanleitung ausformulieren. Restrisiken beschönigen. Nicht anwendbare Standards still weglassen statt als
`N/A` mit Begründung.

**EN:** **Common mistakes.** Considering only normal operation. On disturbance reporting "running" instead of
"unknown" (no fail-safe). Recovery without idempotency, so data is double-counted. Not limiting the blast radius.
Writing outages as an attack manual. Glossing over residual risks. Silently dropping non-applicable standards
instead of documenting them as `N/A` with a rationale.

### Beispiel / Example

```text
Ausfallszenario-Tabelle (Auszug):
  Szenario                Reaktion (degradiert)          Blast-Radius   Gegenmassnahme
  Ein Agent faellt aus    Rest sammelt weiter;           1 Maschine     Maschine als "stale" markieren
                          Maschine als "unbekannt"
  Netzpartition           Teilmenge sammelt lokal;       Teilnetz       Nachmeldung + Idempotenz beim Merge
                          Merge nach Wiederanlauf
  Sammler-Dienst aus      Agenten puffern kurz;          zentral        Failover-Instanz + begrenzte Queue
                          keine falschen "laeuft"-Werte
  Datenhaltung voll       Schreibstopp, Alarm;           zentral        Fail-Safe: ablehnen statt ueberschreiben
                          kein stiller Datenverlust

Wiederanlauf:  idempotentes Nachmelden; keine doppelte Zaehlung
Fail-Safe:     unbekannt/veraltet statt falsch "laeuft"
Restrisiko:    lange Partition -> Daten veralten | Eintritt: mittel | Wirkung: mittel -> beobachten
Nachweis:      Ausfall-Simulationstest zeigt sichere Degradation; Secrets nur <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11d** ist
primär, weil Resilienz entscheidet, wie Clients und Dienste bei Störung, Partition oder Ausfall sicher weiterlaufen;
LF 3 und LF 9 sind berührt, weil Clienteinbindung und Dienstbereitstellung das Ausfallverhalten prägen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11d**
is primary because resilience decides how clients and services continue safely under disturbance, partition, or
outage; LF 3 and LF 9 are touched because client integration and service provisioning shape the failure behavior.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Ausfallszenarien und Resilienz gehören zum sicheren Betrieb vernetzter Systeme. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Das Ausfall- und Wiederanlaufverhalten der Agenten betrifft die Netzeinbindung der Clients. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Failover und degradierter Betrieb sind Teil einer belastbaren Dienstbereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Defense in Depth, Fail-Safe Defaults, Resilienz,
Angriffsflächenreduktion und Review-Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_04` (Bedrohungsmodellierung/Testmanagement), `CL_08` (Sicherheits-Code-Review) und `CL_12`
(Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Bei Störung fällt das System in einen
sicheren Zustand (Fail-Safe), meldet ehrlich Unvollständigkeit, begrenzt den Blast-Radius und läuft idempotent
wieder an.* A11Y-Aspekt: Ausfallszenario- und Blast-Radius-Tabellen müssen als reiner Text mit Kopfzeile lesbar
sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: defense in depth, fail-safe defaults, resilience, attack
surface reduction, and review evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling/test management), `CL_08` (security code review), and `CL_12`
(evidence and closure). The security decision of this unit is: *on disturbance the system falls into a safe state
(fail-safe), honestly reports incompleteness, limits the blast radius, and recovers idempotently.* Accessibility
aspect: failure-scenario and blast-radius tables must be readable as plain text with a header row, without color
coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was bedeutet degradierter Betrieb bei einem Agent-Ausfall? /
   **EN:** (DV) What does degraded operation mean on an agent failure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Rest der Agenten sammelt weiter, und die betroffene Maschine wird als „unbekannt/veraltet"
   gekennzeichnet statt als „läuft". Das System arbeitet eingeschränkt, aber sicher weiter.
   **EN:** The remaining agents keep collecting, and the affected machine is marked as "unknown/stale" instead of
   "running". The system continues with limitations but safely.

   </details>

2. **DE:** (DV) Warum ist eine Netzpartition für ein verteiltes Sammelsystem besonders heikel? /
   **EN:** (DV) Why is a network partition especially tricky for a distributed collection system?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einer Partition erreichen sich Teile des Systems nicht mehr, sammeln aber lokal weiter. Nach dem
   Wiederanlauf müssen die Teilstände zusammengeführt werden, ohne doppelt zu zählen; dafür braucht es Idempotenz.
   **EN:** In a partition parts of the system no longer reach each other but keep collecting locally. After
   recovery the partial states must be merged without double-counting; that requires idempotency.

   </details>

3. **DE:** Warum muss degradierter Betrieb in einen sicheren und nicht in einen offenen Zustand fallen? /
   **EN:** Why must degraded operation fall into a safe and not an open state?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein offener Zustand könnte falsche Vollständigkeit vortäuschen oder Zugriffe zulassen, die sonst
   gesperrt sind. Fail-Safe meldet ehrlich Unvollständigkeit und hält Sicherheitsgrenzen ein, auch bei Störung.
   **EN:** An open state could fake completeness or allow access that is otherwise blocked. Fail-safe honestly
   reports incompleteness and keeps security boundaries even under disturbance.

   </details>

4. **DE:** Warum hilft Idempotenz beim Wiederanlauf nach einer Störung? /
   **EN:** Why does idempotency help during recovery after a disturbance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Idempotenz bedeutet, dass mehrfaches Melden desselben Zustands das Ergebnis nicht verändert. Beim
   Nachmelden nach einer Partition werden Daten so nicht doppelt gezählt, und alte Zustände werden nicht falsch
   überschrieben.
   **EN:** Idempotency means that reporting the same state multiple times does not change the result. When
   re-reporting after a partition, data is not double-counted and old states are not wrongly overwritten.

   </details>

5. **DE:** (SI) Wie weist man nach, dass das System bei einem Ausfall sicher degradiert? /
   **EN:** (SI) How do you evidence that the system degrades safely on an outage?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Ausfall-Simulationstest: Man schaltet gezielt einen Agenten oder den Dienst ab und prüft, dass
   das System eingeschränkt, aber sicher weiterläuft und keine falschen Vollständigkeitsaussagen macht.
   **EN:** With an outage simulation test: you deliberately shut off an agent or the service and check that the
   system continues with limitations but safely and makes no false completeness claims.

   </details>

6. **DE:** (DPA) Welche Aussagegrenze entsteht für Kennzahlen im degradierten Betrieb? /
   **EN:** (DPA) Which limit of validity arises for metrics in degraded operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fehlen Daten ausgefallener Agenten, gilt eine Kennzahl nur für die tatsächlich erreichten Maschinen. Die
   Grenze („gilt nur für erreichbare Agenten während der Störung") muss ausdrücklich mitgeführt werden.
   **EN:** If data from failed agents is missing, a metric holds only for the machines actually reached. The limit
   ("valid only for reachable agents during the disturbance") must be carried along explicitly.

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

- [ ] die wichtigsten Ausfallszenarien der verteilten Sammlung benennen.
- [ ] degradierten Betrieb je Szenario als Fail-Safe definieren.
- [ ] Failover und idempotenten Wiederanlauf planen.
- [ ] den Blast-Radius je Szenario begrenzen.
- [ ] Resilienz durch einen Ausfall-Simulationstest nachweisen.
- [ ] Restrisiken ehrlich mit Eintritt und Wirkung dokumentieren.

**EN:** I can …

- [ ] name the main failure scenarios of the distributed collection.
- [ ] define degraded operation per scenario as fail-safe.
- [ ] plan failover and idempotent recovery.
- [ ] limit the blast radius per scenario.
- [ ] evidence resilience with an outage simulation test.
- [ ] document residual risks honestly with occurrence and impact.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`. Sie baut auf den
Betriebs- und Netznachweisen (Einheit 08) auf und liefert die Grundlage für das Netz-Review und den Abschluss
(Einheit 10). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.md`. It builds on the
operational and network evidence (unit 08) and provides the basis for the network review and closure (unit 10). The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
