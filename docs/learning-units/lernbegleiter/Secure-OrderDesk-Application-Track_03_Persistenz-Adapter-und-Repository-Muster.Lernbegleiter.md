# Lernbegleiter: Secure OrderDesk Application Track 03 – Persistenz-Adapter und Repository-Muster / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Deine Bestellplattform muss Kunden, Produkte, Bestellungen und Positionen speichern und laden. Wenn der Fachkern direkt an eine bestimmte Datenbank gebunden ist, wird er schwer testbar und schwer austauschbar. Das **Repository-Muster** trennt das: Der Fachkern kennt nur einen **Port** (eine abstrakte Schnittstelle), und ein **Adapter** setzt diesen Port konkret um – etwa gegen eine relationale Datenbank oder eine Datei. So bleibt der Kern technikfrei und du kannst für Tests einen In-Memory-Fake mit `ALFKI` einsetzen.

**EN:** Your ordering platform must store and load customers, products, orders, and lines. If the business core is bound directly to a specific database, it becomes hard to test and hard to replace. The **repository pattern** separates this: the core knows only a **port** (an abstract interface), and an **adapter** implements this port concretely – e.g. against a relational database or a file. This keeps the core free of technology and lets you use an in-memory fake with `ALFKI` for tests.

**DE:** Ein Kernpunkt bleibt bei jedem Adapter gleich: Datenzugriffe erfolgen **nur parametrisiert**. Kein Feldname und kein Wert aus Eingaben wird per String-Verkettung in SQL gebaut – das ist die zentrale Abwehr gegen SQL-Injection (CWE-89).

**EN:** One core point stays the same for every adapter: data access is **parameterized only**. No field name and no value from input is built into SQL by string concatenation – this is the central defense against SQL injection (CWE-89).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Port / Port | Abstrakte Schnittstelle im Fachkern, die den Datenvertrag beschreibt. |
| Adapter / Adapter | Konkrete Umsetzung des Ports gegen ein Backend (DB, Datei). |
| Repository / Repository | Sammlung von Zugriffsmethoden für eine Entität (z. B. `OrderRepository`). |
| Abhängigkeitsrichtung / Dependency direction | Regel, dass der Kern den Port kennt, nicht den Adapter. |
| Parametrisierter Zugriff / Parameterized access | Datenzugriff mit gebundenen Parametern statt String-Verkettung. |
| In-Memory-Fake / In-memory fake | Testadapter, der Daten (z. B. `ALFKI`) im Speicher hält. |
| Transaktionsgrenze / Transaction boundary | Abschnitt, in dem zusammengehörige Änderungen gemeinsam gelten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Port entwerfen.** Definiere im Fachkern eine abstrakte Schnittstelle, z. B. `OrderRepository` mit Methoden wie `findById`, `findByCustomer`, `save`. Der Port beschreibt nur *was* möglich ist, nicht *wie* es gespeichert wird.

**EN:** **Step 1 – Design the port.** Define an abstract interface in the business core, e.g. `OrderRepository` with methods like `findById`, `findByCustomer`, `save`. The port describes only *what* is possible, not *how* it is stored.

**DE:** **Schritt 2 – Abhängigkeitsrichtung festlegen.** Der Kern hängt nur vom Port ab. Adapter hängen vom Port ab und setzen ihn um. So zeigt die Abhängigkeit immer nach innen zum Kern; der Kern kennt kein konkretes Backend.

**EN:** **Step 2 – Fix the dependency direction.** The core depends only on the port. Adapters depend on the port and implement it. So the dependency always points inward to the core; the core knows no concrete backend.

**DE:** **Schritt 3 – Mindestens zwei Adapter denken.** Skizziere zwei denkbare Adapter, z. B. einen Datei-Adapter und einen relationalen DB-Adapter. Beide erfüllen denselben Port. Das beweist, dass der Kern austauschbar ist.

**EN:** **Step 3 – Think of at least two adapters.** Sketch two conceivable adapters, e.g. a file adapter and a relational DB adapter. Both fulfill the same port. This proves the core is replaceable.

**DE:** **Schritt 4 – Zugriffe parametrisieren und Grenzen ziehen.** Jeder DB-Zugriff nutzt gebundene Parameter. Setze klare Transaktions- und Fehlergrenzen: Eine Bestellung und ihre Positionen (Master-Detail) müssen gemeinsam konsistent gespeichert werden. Fehler geben keine internen Details (SQL-Text, Tabellennamen) preis.

**EN:** **Step 4 – Parameterize access and draw boundaries.** Every DB access uses bound parameters. Set clear transaction and error boundaries: an order and its lines (master-detail) must be stored consistently together. Errors reveal no internal details (SQL text, table names).

**DE:** **Schritt 5 – Testadapter mit ALFKI.** Baue einen In-Memory-Fake, der den Port erfüllt und `ALFKI` als festen Testanker enthält. Damit werden Fachkern-Tests schnell und unabhängig von einer echten Datenbank. Verbindungszeichenketten stehen nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** **Step 5 – Test adapter with ALFKI.** Build an in-memory fake that fulfills the port and contains `ALFKI` as a fixed test anchor. This makes core tests fast and independent of a real database. Connection strings appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**DE:** **Typische Fehler.** Den Kern direkt an ein ORM oder eine DB binden. Die Abhängigkeitsrichtung umdrehen. Dynamisches SQL aus Eingaben bauen. Master-Detail getrennt und inkonsistent speichern. Echte Zugangsdaten im Code. Keinen Testadapter vorsehen.

**EN:** **Common mistakes.** Binding the core directly to an ORM or DB. Reversing the dependency direction. Building dynamic SQL from input. Storing master-detail separately and inconsistently. Real credentials in code. Not providing a test adapter.

### Beispiel / Example

```text
Fachkern  ---kennt--->  Port: OrderRepository { findById, findByCustomer(customerId), save(order) }
                              ^                     ^
                              |                     |
                    Adapter A: Datei        Adapter B: relationale DB (parametrisiert)
                                                     |
                    save(order): INSERT ... VALUES (@id, @customerId, @date)  -- gebundene Parameter
                    findByCustomer("ALFKI"): SELECT ... WHERE CustomerID = @cid  -- kein String-Concat

Test: In-Memory-Fake haelt ALFKI (Alfreds Futterkiste) -> Kern-Tests ohne echte DB
Regel: Order + OrderLines in einer Transaktion (Master-Detail konsistent)
Secret: ConnectionString = <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). Für den Persistenz-Adapter ist **LF 11a** primär, weil wartbare Funktionalität mit klarer Architektur realisiert wird; LF 5 ist berührt, weil die Datenverwaltung der Bestelldomäne über austauschbare Adapter angepasst wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). For the persistence adapter **LF 11a** is primary, because maintainable functionality is realized with a clear architecture; LF 5 is touched, because the data management of the ordering domain is adapted through replaceable adapters.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Das Repository-Muster realisiert wartbaren, testbaren Datenzugriff im Fachkern. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Austauschbare Adapter passen die relationale Bestelldatenverwaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Separation of Concerns und sichere Programmierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (sichere Architektur), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Der Fachkern bleibt technikfrei, jeder Datenzugriff ist parametrisiert, und Secrets stehen nie im Code.* A11Y-Aspekt: Port-/Adapter-Skizzen und Beispieltabellen müssen als klarer Text lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, separation of concerns, and secure coding. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure architecture), `CL_08` (security code review), and `CL_12` (evidence and closure). The security decision of this unit is: *the business core stays technology-free, every data access is parameterized, and secrets never appear in code.* Accessibility aspect: port/adapter sketches and example tables must be readable as clear text, without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum darf der Fachkern nur den Port und nicht den Adapter kennen? /
   **EN:** Why may the business core know only the port and not the adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** So bleibt der Kern unabhängig von der Speichertechnik. Man kann das Backend austauschen (Datei, DB) oder für Tests einen Fake einsetzen, ohne den Kern zu ändern. Die Abhängigkeit zeigt nach innen zum Kern.
   **EN:** This keeps the core independent of the storage technology. You can swap the backend (file, DB) or use a fake for tests without changing the core. The dependency points inward to the core.

   </details>

2. **DE:** (AE) Warum sind ausschließlich parametrisierte Zugriffe Pflicht? /
   **EN:** (AE) Why is parameterized access strictly mandatory?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Parametrisierte Zugriffe trennen Code von Daten; Eingaben können nicht als SQL interpretiert werden. Das ist die zentrale Abwehr gegen SQL-Injection (CWE-89). String-Verkettung von Werten oder Feldnamen ist deshalb verboten.
   **EN:** Parameterized access separates code from data; input cannot be interpreted as SQL. This is the central defense against SQL injection (CWE-89). String concatenation of values or field names is therefore forbidden.

   </details>

3. **DE:** (AE) Wozu dient ein In-Memory-Fake mit ALFKI? /
   **EN:** (AE) What is an in-memory fake with ALFKI for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er erfüllt denselben Port und hält Testdaten (z. B. `ALFKI`) im Speicher. So laufen Fachkern-Tests schnell, deterministisch und ohne echte Datenbank; die Testbarkeit steigt.
   **EN:** It fulfills the same port and holds test data (e.g. `ALFKI`) in memory. This makes core tests fast, deterministic, and independent of a real database; testability improves.

   </details>

4. **DE:** Warum müssen Bestellung und Positionen in einer Transaktion gespeichert werden? /
   **EN:** Why must an order and its lines be stored in one transaction?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie bilden ein Master-Detail. Würde nur der Kopf oder nur ein Teil der Positionen gespeichert, entstünde ein inkonsistenter Zustand. Eine Transaktion sorgt dafür, dass alles gemeinsam gilt oder gemeinsam zurückgerollt wird.
   **EN:** They form a master-detail. If only the header or only some lines were stored, an inconsistent state would arise. A transaction ensures everything applies together or is rolled back together.

   </details>

5. **DE:** (SI) Wo gehören Verbindungszeichenketten hin und wo nicht? /
   **EN:** (SI) Where do connection strings belong and where not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht in den Quellcode und nicht in Git-getrackte Dateien. Sie gehören in einen Secret-Store oder eine Konfiguration außerhalb der Versionskontrolle. In Beispielen stehen sie nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Not in source code and not in Git-tracked files. They belong in a secret store or a configuration outside version control. In examples they appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

6. **DE:** (DPA) Welche Konsistenzregel gehört in den Adapter? /
   **EN:** (DPA) Which consistency rule belongs in the adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Referenzielle Integrität, z. B. dass eine Position (`OrderLine`) nur zu einer existierenden Bestellung und einem existierenden Produkt gehört. Der Adapter setzt Fremdschlüssel und Transaktionsgrenzen technisch um.
   **EN:** Referential integrity, e.g. that a line (`OrderLine`) belongs only to an existing order and an existing product. The adapter implements foreign keys and transaction boundaries technically.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung. Beispiel: verteilte Transaktionen über mehrere Datenbanken sind `N/A`, weil der Adapter zunächst ein einzelnes Backend bedient. Die Prüfung bleibt sichtbar.
   **EN:** As `N/A` with a short technical justification. Example: distributed transactions across multiple databases are `N/A` because the adapter first serves a single backend. The check stays visible.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Persistenz-Port im Fachkern entwerfen.
- [ ] die Abhängigkeitsrichtung (Kern → Port, Adapter → Port) erklären.
- [ ] mindestens zwei Adapter (Datei, DB) skizzieren, die denselben Port erfüllen.
- [ ] Datenzugriffe ausschließlich parametrisiert und Master-Detail transaktional beschreiben.
- [ ] einen In-Memory-Fake mit `ALFKI` als Testpfad benennen.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] design a persistence port in the business core.
- [ ] explain the dependency direction (core → port, adapter → port).
- [ ] sketch at least two adapters (file, DB) fulfilling the same port.
- [ ] describe data access as parameterized only and master-detail as transactional.
- [ ] name an in-memory fake with `ALFKI` as a test path.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
