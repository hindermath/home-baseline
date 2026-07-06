# Lernbegleiter: Secure ServiceHarvester Application Track 03 – Persistenz-Adapter und Repository-Muster / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester speichert gesammelte Statusdaten irgendwo – in einer Datei, einer Datenbank oder
einem anderen Backend. Wenn die Fachlogik direkt mit einer bestimmten Datenbank spricht, ist sie schwer zu
testen und kaum austauschbar. Das **Repository-Muster** löst das: Der Fachkern kennt nur einen **Port** (eine
abstrakte Schnittstelle wie `MachineRepository`), und ein **Adapter** setzt diesen Port für ein konkretes
Backend um. So bleibt der Kern technikfrei, und du kannst das Backend wechseln oder für Tests durch einen
**In-Memory-Fake** ersetzen.

**EN:** The ServiceHarvester stores collected status data somewhere – in a file, a database, or another
backend. If the business logic talks directly to a specific database, it is hard to test and barely
replaceable. The **repository pattern** solves this: the business core knows only a **port** (an abstract
interface like `MachineRepository`), and an **adapter** implements this port for a concrete backend. This
keeps the core free of technology, and you can swap the backend or replace it with an **in-memory fake** for
tests.

**DE:** Du lernst, einen Persistenz-Port zu entwerfen, die Abhängigkeit so zu drehen, dass der Kern nur den
Port kennt, Transaktions- und Fehlergrenzen zu setzen und Datenzugriffe gegen Injection zu schützen.

**EN:** You learn to design a persistence port, to invert the dependency so the core knows only the port, to
set transaction and error boundaries, and to protect data access against injection.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Repository / Repository | Sammelstelle für den Zugriff auf gespeicherte Objekte über eine klare Schnittstelle. |
| Port / Port | Abstrakte Schnittstelle, die der Fachkern kennt und aufruft. |
| Adapter / Adapter | Konkrete Umsetzung eines Ports für ein Backend (Datei, Datenbank). |
| Abhängigkeitsrichtung / Dependency direction | Der Kern hängt vom Port ab, der Adapter vom Kern – nicht umgekehrt. |
| Transaktionsgrenze / Transaction boundary | Bereich, in dem Änderungen gemeinsam gelten oder gemeinsam scheitern. |
| In-Memory-Fake / In-memory fake | Test-Adapter, der Daten nur im Speicher hält, für schnelle, isolierte Tests. |
| Parametrisierter Zugriff / Parameterized access | Datenzugriff mit gebundenen Parametern statt Zeichenkettenverkettung. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Port entwerfen.** Beschreibe die fachlichen Operationen, die der Kern braucht, z. B.
`add(machine)`, `find(id)`, `list(filter)`, `save(snapshot)`. Der Port nennt nur **was**, nicht **wie**. Er
enthält keine SQL-Begriffe und keinen Dateipfad.

**EN:** **Step 1 – Design the port.** Describe the business operations the core needs, e.g. `add(machine)`,
`find(id)`, `list(filter)`, `save(snapshot)`. The port states only **what**, not **how**. It contains no SQL
terms and no file path.

**DE:** **Schritt 2 – Abhängigkeit drehen.** Der Fachkern hängt vom Port ab, nie vom konkreten Adapter. Der
Adapter kennt den Kern (bzw. den Port), aber der Kern kennt den Adapter nicht. Diese Richtung macht den Kern
austauschbar und testbar. Zyklen sind ein Warnsignal.

**EN:** **Step 2 – Invert the dependency.** The business core depends on the port, never on the concrete
adapter. The adapter knows the core (or the port), but the core does not know the adapter. This direction
makes the core replaceable and testable. Cycles are a warning sign.

**DE:** **Schritt 3 – Mindestens zwei Adapter denken.** Skizziere z. B. einen Datei-Adapter und einen
Datenbank-Adapter. Schon das Durchdenken zweier Adapter zeigt, ob der Port wirklich technikfrei ist. Wenn ein
Adapter den Port verbiegen müsste, ist der Port noch nicht gut geschnitten.

**EN:** **Step 3 – Think at least two adapters.** Sketch e.g. a file adapter and a database adapter. Merely
thinking through two adapters reveals whether the port is truly technology-free. If an adapter would have to
bend the port, the port is not yet well cut.

**DE:** **Schritt 4 – Transaktions- und Fehlergrenzen setzen.** Lege fest, welche Operationen gemeinsam gelten
müssen (Transaktion) und wie Fehler nach außen gemeldet werden. Der Port meldet fachliche Fehler (nicht
gefunden, Konflikt), nicht technische Datenbankdetails. So bleibt der Kern von Technik frei.

**EN:** **Step 4 – Set transaction and error boundaries.** Define which operations must hold together
(transaction) and how errors are reported outward. The port reports business errors (not found, conflict), not
technical database details. This keeps the core free of technology.

**DE:** **Schritt 5 – Sicher und testbar zugreifen.** Datenzugriffe nur parametrisiert – nie Feldnamen oder
Werte in eine Abfrage einsetzen. Zugangsdaten und Verbindungszeichenketten gehören in einen Secret-Store, im
Lernmaterial nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`. Für Tests baust du einen In-Memory-Fake, der denselben
Port erfüllt – so testest du die Fachlogik ohne echtes Backend.

**EN:** **Step 5 – Access securely and testably.** Data access only parameterized – never insert field names
or values into a query. Credentials and connection strings belong in a secret store, in learning material only
as `<PLATZHALTER-KEIN-ECHTER-WERT>`. For tests you build an in-memory fake that fulfills the same port – this
lets you test the business logic without a real backend.

**DE:** **Typische Fehler.** SQL- oder Dateipfad-Begriffe im Port. Der Kern importiert den Adapter direkt.
Zeichenketten in Abfragen verketten. Verbindungszeichenketten im Quellcode. Kein Testadapter, sodass Tests ein
echtes Backend brauchen. Technische Fehler bis in den Kern durchreichen.

**EN:** **Common mistakes.** SQL or file-path terms in the port. The core importing the adapter directly.
Concatenating strings in queries. Connection strings in source code. No test adapter, so tests need a real
backend. Leaking technical errors into the core.

### Beispiel / Example

```text
Port (Fachkern kennt nur das):
  MachineRepository:
    add(machine) ; find(id) -> machine? ; list(filter) -> [machine] ; save(snapshot)

Adapter (konkret):
  FileMachineRepository   -> speichert als Datei
  DbMachineRepository     -> speichert in Datenbank (nur parametrisierte Statements)
  InMemoryMachineRepository (Test-Fake) -> haelt Daten im Speicher

Abhaengigkeitsregel: Fachkern -> Port ; Adapter -> Port. Kern kennt Adapter NICHT.

Secrets: connection string = <PLATZHALTER-KEIN-ECHTER-WERT> (nie im Code, nie in Git)

ADR-Kandidat: "Repository-Port mit austauschbaren Adaptern"
  Alternative: direkte DB-Bindung im Kern
  Trade-off: Testbarkeit/Austauschbarkeit vs. eine zusaetzliche Abstraktionsschicht
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11a**
ist primär, weil eine wartbare Datenzugriffs-Funktionalität sicher realisiert wird; LF 5 ist berührt, weil der
Adapter bestimmt, wie die Datenverwaltung angebunden und angepasst wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`).
**LF 11a** is primary because maintainable data-access functionality is realized securely; LF 5 is touched
because the adapter determines how the data management is connected and adapted.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Das Repository-Muster realisiert wartbaren, testbaren Datenzugriff. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Der Persistenz-Adapter bestimmt, wie die Datenverwaltung angebunden und ausgetauscht wird. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Separation of Concerns, sichere Programmierung
(parametrisierte Zugriffe), sichere Konfiguration (Secrets) und Testbarkeit. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (sichere Architektur), `CL_08` (Sicherheits-Code-Review) und `CL_12`
(Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Der Kern hängt nur vom Port ab,
Datenzugriffe sind parametrisiert, und Secrets liegen nie im Code.* A11Y-Aspekt: Port-/Adapter-Skizzen brauchen
eine gleichwertige Textbeschreibung (Operationen, Richtungen), damit sie ohne Grafik verständlich bleiben;
Richtungen dürfen nicht allein über Farbe unterschieden werden.

**EN:** Relation to the Secure Development Guideline: separation of concerns, secure programming (parameterized
access), secure configuration (secrets), and testability. Matching checklists: `CL_01` (standards
applicability), `CL_02` (secure architecture), `CL_08` (security code review), and `CL_12` (evidence and
closure). The security decision of this unit is: *the core depends only on the port, data access is
parameterized, and secrets are never in code.* Accessibility aspect: port/adapter sketches need an equivalent
text description (operations, directions) so they stay understandable without graphics; directions must not be
distinguished by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (AE) Was unterscheidet einen Persistenz-Port von einem Persistenz-Adapter? /
   **EN:** (AE) What distinguishes a persistence port from a persistence adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Port ist die abstrakte Schnittstelle, die der Fachkern kennt (nur „was"); der Adapter ist die
   konkrete Umsetzung für ein Backend (das „wie"). Der Kern hängt nur vom Port ab, nicht vom Adapter.
   **EN:** The port is the abstract interface known to the business core (only "what"); the adapter is the
   concrete implementation for a backend (the "how"). The core depends only on the port, not the adapter.

   </details>

2. **DE:** (AE) Warum soll der Fachkern den konkreten Adapter nicht kennen? /
   **EN:** (AE) Why should the business core not know the concrete adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kennt der Kern den Adapter, ist er an eine Technik gebunden und schwer zu testen oder auszutauschen.
   Hängt er nur vom Port ab, kann man das Backend wechseln oder für Tests einen Fake einsetzen, ohne den Kern zu
   ändern.
   **EN:** If the core knows the adapter, it is bound to a technology and hard to test or replace. Depending
   only on the port lets you swap the backend or use a fake for tests without changing the core.

   </details>

3. **DE:** Warum ist ein In-Memory-Fake für Tests nützlich? /
   **EN:** Why is an in-memory fake useful for tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er erfüllt denselben Port, hält Daten aber nur im Speicher. So laufen Tests schnell, isoliert und
   ohne echtes Backend, und die Fachlogik lässt sich zuverlässig prüfen.
   **EN:** It fulfills the same port but keeps data only in memory. Tests then run fast, isolated, and without
   a real backend, and the business logic can be verified reliably.

   </details>

4. **DE:** Warum müssen Datenzugriffe parametrisiert sein? /
   **EN:** Why must data access be parameterized?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Parametrisierte Zugriffe trennen Code von Daten und verhindern Injection. Werden Werte oder
   Feldnamen in eine Abfrage eingesetzt, kann manipulierte Eingabe die Abfrage verändern.
   **EN:** Parameterized access separates code from data and prevents injection. If values or field names are
   inserted into a query, manipulated input can change the query.

   </details>

5. **DE:** (SI) Wo gehören Verbindungszeichenketten und Zugangsdaten hin? /
   **EN:** (SI) Where do connection strings and credentials belong?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** In einen plattformgeeigneten Secret-Store, nie in den Quellcode oder in Git-getrackte Dateien. Im
   Lernmaterial werden sie nur als `<PLATZHALTER-KEIN-ECHTER-WERT>` dargestellt.
   **EN:** In a platform-appropriate secret store, never in source code or Git-tracked files. In learning
   material they appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

6. **DE:** (DPA) Warum sollte der Port fachliche Fehler statt technischer Datenbankfehler melden? /
   **EN:** (DPA) Why should the port report business errors instead of technical database errors?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fachliche Fehler (nicht gefunden, Konflikt) sind für den Kern verständlich und stabil; technische
   Details wären an eine Technik gebunden und würden die Trennung verletzen. So bleibt der Kern technikfrei und
   die Datenintegrität nachvollziehbar.
   **EN:** Business errors (not found, conflict) are understandable and stable for the core; technical details
   would bind it to a technology and break the separation. This keeps the core technology-free and data
   integrity traceable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen technikfreien Persistenz-Port mit fachlichen Operationen entwerfen.
- [ ] die Abhängigkeitsrichtung Kern → Port festlegen und Zyklen vermeiden.
- [ ] mindestens zwei Adapter (z. B. Datei, Datenbank) durchdenken.
- [ ] Transaktions- und Fehlergrenzen benennen.
- [ ] Datenzugriffe parametrisieren und Secrets aus dem Code halten.
- [ ] einen In-Memory-Fake als Testpfad beschreiben.

**EN:** I can …

- [ ] design a technology-free persistence port with business operations.
- [ ] set the dependency direction core → port and avoid cycles.
- [ ] think through at least two adapters (e.g. file, database).
- [ ] name transaction and error boundaries.
- [ ] parameterize data access and keep secrets out of the code.
- [ ] describe an in-memory fake as a test path.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
