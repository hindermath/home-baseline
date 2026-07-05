# Lernbegleiter: Secure CaseTracker v2 03 – API- und Service-Vertrag / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_03_API-und-Service-Vertrag.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Sobald ein System nicht mehr allein arbeitet, sondern von anderen Programmen aufgerufen wird,
braucht es einen klaren **Vertrag**: Welche Operationen gibt es, welche Eingaben werden erwartet, welche
Ausgaben kommen zurück, und was passiert im Fehlerfall? Dieser Vertrag ist die **API** (Application
Programming Interface) oder Service-Schnittstelle. Ein guter Vertrag ist wie eine Speisekarte mit klaren
Preisen: Beide Seiten wissen genau, was sie bekommen. Ein unklarer Vertrag führt zu Missverständnissen –
und über eine Schnittstelle kommen auch bösartige Aufrufe.

**EN:** As soon as a system no longer works alone but is called by other programs, it needs a clear
**contract**: which operations exist, which inputs are expected, which outputs come back, and what happens in
case of error? This contract is the **API** (Application Programming Interface) or service interface. A good
contract is like a menu with clear prices: both sides know exactly what they get. An unclear contract leads
to misunderstandings – and malicious calls also arrive through an interface.

**DE:** In dieser Einheit beschreibst du **Operationen** (was kann man tun), **Eingaben** und **Ausgaben**
(mit Typ und Format), die **Validierung** an der Schnittstelle und die **Netzwerkgrenzen**. Weil eine
Schnittstelle eine Vertrauensgrenze ist, gilt: Jeder eingehende Aufruf ist zunächst nicht vertrauenswürdig.

**EN:** In this unit you describe **operations** (what can be done), **inputs** and **outputs** (with type
and format), the **validation** at the interface, and the **network boundaries**. Because an interface is a
trust boundary, the rule is: every incoming call is initially not trustworthy.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Service-Vertrag / Service contract | Verbindliche Beschreibung von Operationen, Ein- und Ausgaben. |
| Operation / Operation | Eine aufrufbare Funktion der Schnittstelle, z. B. „Fall anlegen“. |
| Idempotenz / Idempotency | Eigenschaft, dass ein mehrfacher gleicher Aufruf dasselbe Ergebnis erzeugt. |
| Statuscode / Status code | Kurzes Signal über Erfolg oder Art des Fehlers einer Operation. |
| Versionierung / Versioning | Kennzeichnung von Vertragsständen, damit Änderungen verträglich bleiben. |
| Netzwerkgrenze / Network boundary | Vertrauensgrenze zwischen Aufrufer und Dienst über das Netz. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Operationen benennen.** Liste jede Aktion, die die Schnittstelle anbietet, mit klarem
Namen und Zweck: Fall anlegen, Fall lesen, Status ändern, Notiz hinzufügen. **Warum wichtig:** Nur benannte
Operationen kann man prüfen, berechtigen und testen. Alles andere ist ein versteckter Eingang.

**EN:** **Step 1 – Name the operations.** List every action the interface offers, with a clear name and
purpose: create case, read case, change status, add note. **Why it matters:** only named operations can be
checked, authorized, and tested. Everything else is a hidden entrance.

**DE:** **Schritt 2 – Ein- und Ausgaben festlegen.** Beschreibe je Operation die erwarteten Felder mit Typ,
Format und Grenzen (z. B. Höchstlänge, Allowlist) sowie die Rückgabe. **Warum wichtig:** Ein klarer Vertrag
erlaubt strikte Validierung. Prüfe an der Schnittstelle *und* in der Kernlogik – die Oberfläche des
Aufrufers ist kein Schutz.

**EN:** **Step 2 – Define inputs and outputs.** Describe per operation the expected fields with type, format,
and limits (e.g. maximum length, allow-list) as well as the return. **Why it matters:** a clear contract
allows strict validation. Check at the interface *and* in the core logic – the caller's UI is no protection.

**DE:** **Schritt 3 – Fehlervertrag definieren.** Lege fest, wie Fehler zurückgemeldet werden: ein
maschinenlesbarer Statuscode plus eine sichere Meldung. Die Meldung sagt *was* falsch war, aber niemals
interne Details (Stack-Trace, Pfad, DB-Meldung). **Warum wichtig:** Ein einheitlicher Fehlervertrag macht
Aufrufer robust und verrät keinem Angreifer Interna.

**EN:** **Step 3 – Define the error contract.** Set how errors are reported: a machine-readable status code
plus a safe message. The message says *what* was wrong, but never internal details (stack trace, path, DB
message). **Why it matters:** a uniform error contract makes callers robust and reveals no internals to an
attacker.

**DE:** **Schritt 4 – Netzwerk- und Vertragsgrenzen mitdenken.** Notiere Annahmen: Transportverschlüsselung,
Timeouts, Größenlimits, Versionierung. **Warum wichtig:** Über das Netz kommen unkontrollierte Aufrufe;
Timeouts und Limits verhindern, dass ein einzelner Aufruf den Dienst blockiert (Verfügbarkeit). Für
Web-/API-Anteile ist der ASVS-Bezug zu prüfen und, falls nicht anwendbar, als `N/A` zu begründen.

**EN:** **Step 4 – Consider network and contract boundaries.** Note assumptions: transport encryption,
timeouts, size limits, versioning. **Why it matters:** uncontrolled calls arrive over the network; timeouts
and limits prevent a single call from blocking the service (availability). For web/API parts, the ASVS
relation must be checked and, if not applicable, justified as `N/A`.

**DE:** **Typische Fehler.** Versteckte, undokumentierte Operationen. Eingaben nur beim Aufrufer prüfen.
Fehlermeldungen mit internen Details. Keine Größenlimits oder Timeouts. Vertragsänderung ohne Versionierung,
sodass bestehende Aufrufer plötzlich brechen.

**EN:** **Common mistakes.** Hidden, undocumented operations. Checking inputs only at the caller. Error
messages with internal details. No size limits or timeouts. Contract change without versioning, so existing
callers suddenly break.

### Beispiel / Example

```text
Operation: FallStatusAendern
  Eingabe:  fall_id  (Format: feste Kennung)
            status   (Allowlist: offen | in Arbeit | geschlossen)
  Ausgabe:  aktualisierter Fall (id, status, geaendert_am)
  Regeln:   status wird an der Schnittstelle UND in der Kernlogik geprueft
  Limits:   Aufruf-Timeout, max. Nachrichtengroesse gesetzt

Fehlervertrag:
  Statuscode 400  "Ungueltiger Status. Erlaubt: offen, in Arbeit, geschlossen."   (sicher)
  Statuscode 404  "Fall nicht gefunden."                                          (sicher)
  NICHT:          "NullPointerException at CaseService.java:88"                    (Interna!)

Versionierung: v1 bleibt stabil; neue Pflichtfelder erst in v2
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Der Service-/API-Vertrag ist die Grundlage systemübergreifender Datenbereitstellung. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Operationen und Fehlervertrag bilden Serviceanfragen nachvollziehbar ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Programmierung, Validierung an
Vertrauensgrenzen und auditfähige Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(sichere Architektur), `CL_05` (Zugangssteuerung/Autorisierung), `CL_08` (Sicherheits-Code-Review) und
`CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Jeder eingehende
Aufruf wird gegen den Vertrag geprüft, bevor er wirkt.* A11Y-Aspekt: Der Vertrag und die Fehlermeldungen
müssen klar, textbasiert und ohne reine Farbsignale verständlich sein, damit auch Screenreader- und
Braille-Nutzende Statuscodes und Meldungen erfassen.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure coding, validation at trust
boundaries, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure
architecture), `CL_05` (access control / authorization), `CL_08` (security code review), and `CL_12`
(evidence / N/A rationale). The security decision of this unit is: *every incoming call is checked against the
contract before it takes effect.* Accessibility aspect: the contract and error messages must be clear,
text-based, and understandable without color-only signals, so screen-reader and Braille users can grasp
status codes and messages.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Schnittstelle immer eine Vertrauensgrenze? /
   **EN:** Why is an interface always a trust boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über die Schnittstelle kommen Aufrufe von außen, die man nicht kontrolliert. Sie sind zunächst nicht
   vertrauenswürdig und müssen an dieser Grenze geprüft werden.
   **EN:** Calls arrive through the interface from outside, which you do not control. They are initially not
   trustworthy and must be checked at this boundary.

   </details>

2. **DE:** Was gehört in einen guten Fehlervertrag, und was nicht? /
   **EN:** What belongs in a good error contract, and what does not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein maschinenlesbarer Statuscode und eine sichere Meldung, die sagt, *was* falsch war. Nicht hinein
   gehören interne Details wie Stack-Traces, Pfade oder Datenbankmeldungen.
   **EN:** A machine-readable status code and a safe message that says *what* was wrong. Internal details like
   stack traces, paths, or database messages do not belong in it.

   </details>

3. **DE:** (AE) Warum reicht eine Validierung beim Aufrufer nicht, und wo muss sie zusätzlich liegen? /
   **EN:** (AE) Why is validation at the caller not enough, and where must it also live?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Aufrufer lässt sich umgehen (direkter Netzaufruf). Die verbindliche Prüfung muss an der
   Schnittstelle und in der Kernlogik liegen, wo die Daten wirklich verarbeitet werden.
   **EN:** The caller can be bypassed (direct network call). The binding check must live at the interface and
   in the core logic, where the data is really processed.

   </details>

4. **DE:** (SI) Welche Betriebsannahmen (Timeouts, Limits) schützen die Verfügbarkeit des Dienstes? /
   **EN:** (SI) Which operational assumptions (timeouts, limits) protect the service's availability?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aufruf-Timeouts und Größenlimits verhindern, dass ein einzelner langsamer oder riesiger Aufruf den
   Dienst blockiert. Sie sind Teil des Vertrags und der Betriebsdokumentation.
   **EN:** Call timeouts and size limits prevent a single slow or huge call from blocking the service. They are
   part of the contract and the operational documentation.

   </details>

5. **DE:** (DPA) Warum sollten Ausgaben nur die wirklich nötigen Felder enthalten? /
   **EN:** (DPA) Why should outputs contain only the truly necessary fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weniger ausgegebene Daten bedeuten weniger Preisgabe personenbezogener Informationen und bessere
   Datenqualität. Übermäßige Ausgabe ist ein Datenschutz- und Auswertungsrisiko.
   **EN:** Fewer returned fields mean less exposure of personal information and better data quality. Excessive
   output is a privacy and analysis risk.

   </details>

6. **DE:** Warum ist Versionierung des Vertrags wichtig? /
   **EN:** Why is versioning of the contract important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Versionierung erlaubt Änderungen, ohne bestehende Aufrufer plötzlich zu brechen. Neue Pflichtfelder
   kommen in eine neue Version; die alte bleibt verträglich.
   **EN:** Versioning allows changes without suddenly breaking existing callers. New mandatory fields go into a
   new version; the old one stays compatible.

   </details>

7. **DE:** Warum muss der ASVS-Bezug für Web-/API-Anteile geprüft und ggf. als `N/A` begründet werden? /
   **EN:** Why must the ASVS relation for web/API parts be checked and, if needed, justified as `N/A`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** ASVS ist der Verifikationsstandard für Web-/API-/Auth-Dienste. Man benennt den passenden Level oder
   begründet mit kurzer technischer Erklärung, warum er hier nicht anwendbar ist – ohne stille Auslassung.
   **EN:** ASVS is the verification standard for web/API/auth services. You name the matching level or justify
   with a short technical explanation why it does not apply here – without silent omission.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] alle Operationen der Schnittstelle mit Zweck benennen.
- [ ] Ein- und Ausgaben mit Typ, Format und Grenzen beschreiben.
- [ ] einen sicheren Fehlervertrag von einem unsicheren unterscheiden.
- [ ] Timeouts, Limits und Versionierung als Vertragsbestandteil planen.
- [ ] den ASVS-Bezug prüfen oder begründet als `N/A` einordnen.

**EN:** I can …

- [ ] name all interface operations with their purpose.
- [ ] describe inputs and outputs with type, format, and limits.
- [ ] tell a safe error contract from an unsafe one.
- [ ] plan timeouts, limits, and versioning as part of the contract.
- [ ] check the ASVS relation or classify it as justified `N/A`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_03_API-und-Service-Vertrag.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_03_API-und-Service-Vertrag.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
