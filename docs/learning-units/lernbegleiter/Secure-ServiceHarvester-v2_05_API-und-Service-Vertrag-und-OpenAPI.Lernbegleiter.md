# Lernbegleiter: Secure ServiceHarvester v2 05 – API- und Service-Vertrag und OpenAPI / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Sobald der ServiceHarvester seine gesammelten Daten anderen Programmen bereitstellt, braucht er einen
klaren **Vertrag**: Welche Operationen gibt es, welche Eingaben werden erwartet, welche Ausgaben kommen
zurück, und was passiert im Fehlerfall? Dieser Vertrag ist die **API** (Application Programming Interface).
Ein guter Vertrag ist wie eine Speisekarte mit klaren Preisen: Beide Seiten wissen genau, was sie bekommen.
Damit Mensch und Maschine den Vertrag gleich verstehen, beschreibt man ihn maschinenlesbar als
**OpenAPI/Swagger**.

**EN:** As soon as the ServiceHarvester provides its collected data to other programs, it needs a clear
**contract**: which operations exist, which inputs are expected, which outputs come back, and what happens in
case of error? This contract is the **API** (Application Programming Interface). A good contract is like a menu
with clear prices: both sides know exactly what they get. So that humans and machines understand the contract
alike, you describe it in a machine-readable way as **OpenAPI/Swagger**.

**DE:** In dieser Einheit beschreibst du **Operationen** (was kann man tun), **Eingaben** und **Ausgaben** (mit
Typ und Format), die **Validierung** an der Schnittstelle, die **Netzwerkgrenzen** und einen **Fehlervertrag**,
der niemals interne Details preisgibt. Weil eine Schnittstelle eine Vertrauensgrenze ist, gilt: Jeder
eingehende Aufruf ist zunächst nicht vertrauenswürdig.

**EN:** In this unit you describe **operations** (what can be done), **inputs** and **outputs** (with type and
format), the **validation** at the interface, the **network boundaries**, and an **error contract** that never
exposes internal details. Because an interface is a trust boundary, the rule is: every incoming call is
initially not trustworthy.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Service-Vertrag / Service contract | Verbindliche Beschreibung von Operationen, Ein- und Ausgaben. |
| OpenAPI/Swagger / OpenAPI/Swagger | Maschinenlesbare Beschreibung einer API, die Mensch und Werkzeug lesen. |
| Operation / Operation | Eine aufrufbare Funktion der Schnittstelle, z. B. „Snapshots lesen“. |
| Fehlervertrag / Error contract | Feste Regeln, wie Fehler mit Statuscode und sicherer Meldung zurückkommen. |
| Statuscode / Status code | Kurzes Signal über Erfolg oder Art des Fehlers einer Operation. |
| Netzwerkgrenze / Network boundary | Vertrauensgrenze zwischen Aufrufer und Dienst über das Netz. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Operationen benennen.** Liste jede Aktion, die die API anbietet, mit klarem Namen und
Zweck: Maschinen auflisten, neuesten Snapshot einer Maschine lesen, Health-Status abfragen. **Warum wichtig:**
Nur benannte Operationen kann man prüfen, berechtigen und testen. Alles andere ist ein versteckter Eingang.

**EN:** **Step 1 – Name the operations.** List every action the API offers, with a clear name and purpose: list
machines, read the latest snapshot of a machine, query the health status. **Why it matters:** only named
operations can be checked, authorized, and tested. Everything else is a hidden entrance.

**DE:** **Schritt 2 – Ein- und Ausgaben festlegen.** Beschreibe je Operation die erwarteten Felder mit Typ,
Format und Grenzen (z. B. Allowlist, Höchstlänge) sowie die Rückgabe. **Warum wichtig:** Ein klarer Vertrag
erlaubt strikte Validierung. Prüfe an der Schnittstelle *und* in der Fachlogik – die Oberfläche des Aufrufers
ist kein Schutz.

**EN:** **Step 2 – Define inputs and outputs.** Describe per operation the expected fields with type, format,
and limits (e.g. allow-list, maximum length) as well as the return. **Why it matters:** a clear contract
allows strict validation. Check at the interface *and* in the business logic – the caller's UI is no
protection.

**DE:** **Schritt 3 – Fehlervertrag definieren.** Lege fest, wie Fehler zurückgemeldet werden: ein
maschinenlesbarer Statuscode plus eine sichere Meldung. Die Meldung sagt *was* falsch war, aber niemals
interne Details (Stack-Trace, Pfad, Verbindungszeichenkette, Datenbankmeldung). **Warum wichtig:** Ein
einheitlicher Fehlervertrag macht Aufrufer robust und verrät keinem Angreifer Interna.

**EN:** **Step 3 – Define the error contract.** Set how errors are reported: a machine-readable status code
plus a safe message. The message says *what* was wrong, but never internal details (stack trace, path,
connection string, database message). **Why it matters:** a uniform error contract makes callers robust and
reveals no internals to an attacker.

**DE:** **Schritt 4 – Vertrag als OpenAPI/Swagger beschreiben.** Fasse Operationen, Eingaben, Ausgaben und
Fehlercodes in einer maschinenlesbaren OpenAPI/Swagger-Beschreibung zusammen. **Warum wichtig:** Eine solche
Beschreibung ist eine einzige Quelle der Wahrheit: Aufrufer, Tests und Dokumentation lesen dasselbe, und
Widersprüche fallen früh auf. Notiere zusätzlich Netzwerkgrenzen: Transportverschlüsselung, Timeouts,
Größenlimits, Versionierung. Für Web-/API-Anteile ist der ASVS-Bezug zu prüfen und, falls nicht anwendbar, als
`N/A` zu begründen.

**EN:** **Step 4 – Describe the contract as OpenAPI/Swagger.** Summarize operations, inputs, outputs, and error
codes in a machine-readable OpenAPI/Swagger description. **Why it matters:** such a description is a single
source of truth: callers, tests, and documentation read the same thing, and contradictions show up early. Also
note network boundaries: transport encryption, timeouts, size limits, versioning. For web/API parts, the ASVS
relation must be checked and, if not applicable, justified as `N/A`.

**DE:** **Schritt 5 – Datenminimierung in Ausgaben und Negativtests planen.** Gib nur die wirklich nötigen
Felder zurück, keine internen Kennungen oder überflüssigen personenbezogenen Daten. Plane Negativtests:
ungültige Eingabe, unbekannte Operation, zu großer Aufruf – jeweils mit erwartetem sicherem Fehlercode.
**Warum wichtig:** Nur Erfolgspfade zu testen beweist nicht, dass der Vertrag Angriffe und Fehler richtig
behandelt.

**EN:** **Step 5 – Plan data minimization in outputs and negative tests.** Return only the truly necessary
fields, no internal identifiers or superfluous personal data. Plan negative tests: invalid input, unknown
operation, oversized call – each with an expected safe error code. **Why it matters:** testing only success
paths does not prove the contract handles attacks and errors correctly.

**DE:** **Typische Fehler.** Versteckte, undokumentierte Operationen. Eingaben nur beim Aufrufer prüfen.
Fehlermeldungen mit internen Details. Keine Größenlimits oder Timeouts. Vertragsänderung ohne Versionierung.
Alle Felder „für alle Fälle“ ausgeben.

**EN:** **Common mistakes.** Hidden, undocumented operations. Checking inputs only at the caller. Error
messages with internal details. No size limits or timeouts. Contract change without versioning. Returning all
fields "just in case".

### Beispiel / Example

```text
Operation: GetLatestSnapshot
  Eingabe:  machine_id  (Format: feste Kennung, Allowlist bekannter Maschinen)
  Ausgabe:  { machine_id, os, collected_at }   (nur noetige Felder, Datenminimierung)
  Regeln:   machine_id wird an der Schnittstelle UND in der Fachlogik geprueft
  Limits:   Aufruf-Timeout, max. Nachrichtengroesse gesetzt

Fehlervertrag:
  Statuscode 400  "Ungueltige machine_id."                          (sicher)
  Statuscode 404  "Maschine nicht gefunden."                        (sicher)
  NICHT:          "SqlException: connection string = ...:5432/db"   (Interna/Secret!)

OpenAPI/Swagger (Skizze):
  paths:
    /machines/{machine_id}/latest:
      get: -> 200 Snapshot ; 400 Fehler ; 404 Fehler

Versionierung: v1 bleibt stabil; neue Pflichtfelder erst in v2
ASVS: fuer die Leseschnittstelle Level pruefen oder als N/A mit kurzer Begruendung dokumentieren
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Der API-/Service-Vertrag mit OpenAPI ist die Grundlage systemübergreifender Datenbereitstellung. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Operationen und Fehlervertrag bilden Serviceanfragen nachvollziehbar ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Programmierung, Validierung an
Vertrauensgrenzen, sichere Fehlerbehandlung und auditfähige Nachweise. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_03` (sichere Architektur), `CL_05` (Zugangssteuerung/Autorisierung), `CL_08`
(Sicherheits-Code-Review) und `CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit
lautet: *Jeder eingehende Aufruf wird gegen den Vertrag geprüft, und Fehlermeldungen geben nie interne Details
preis.* A11Y-Aspekt: Der Vertrag, die OpenAPI-Beschreibung und die Fehlermeldungen müssen klar, textbasiert und
ohne reine Farbsignale verständlich sein, damit auch Screenreader- und Braille-Nutzende Statuscodes und
Meldungen erfassen.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure coding, validation at trust
boundaries, safe error handling, and auditable evidence. Matching checklists: `CL_01` (standards
applicability), `CL_03` (secure architecture), `CL_05` (access control / authorization), `CL_08` (security code
review), and `CL_12` (evidence / N/A rationale). The security decision of this unit is: *every incoming call is
checked against the contract, and error messages never expose internal details.* Accessibility aspect: the
contract, the OpenAPI description, and the error messages must be clear, text-based, and understandable without
color-only signals, so screen-reader and Braille users can grasp status codes and messages.

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

2. **DE:** Wozu dient eine OpenAPI/Swagger-Beschreibung? /
   **EN:** What is an OpenAPI/Swagger description for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie beschreibt Operationen, Ein- und Ausgaben sowie Fehlercodes maschinenlesbar. So lesen Aufrufer,
   Tests und Dokumentation dieselbe Quelle der Wahrheit, und Widersprüche fallen früh auf.
   **EN:** It describes operations, inputs, outputs, and error codes in a machine-readable way. So callers,
   tests, and documentation read the same source of truth, and contradictions show up early.

   </details>

3. **DE:** (AE) Warum reicht eine Validierung beim Aufrufer nicht, und wo muss sie zusätzlich liegen? /
   **EN:** (AE) Why is validation at the caller not enough, and where must it also live?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Aufrufer lässt sich umgehen (direkter Netzaufruf). Die verbindliche Prüfung muss an der
   Schnittstelle und in der Fachlogik liegen, wo die Daten wirklich verarbeitet werden.
   **EN:** The caller can be bypassed (direct network call). The binding check must live at the interface and in
   the business logic, where the data is really processed.

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

   **DE:** Weniger ausgegebene Daten bedeuten weniger Preisgabe personenbezogener oder interner Informationen
   und bessere Datenqualität. Übermäßige Ausgabe ist ein Datenschutz- und Missbrauchsrisiko.
   **EN:** Fewer returned fields mean less exposure of personal or internal information and better data quality.
   Excessive output is a privacy and misuse risk.

   </details>

6. **DE:** (DV) Warum ist Versionierung des Vertrags für zusammenarbeitende Systeme wichtig? /
   **EN:** (DV) Why is versioning of the contract important for cooperating systems?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Versionierung erlaubt Änderungen, ohne bestehende Aufrufer plötzlich zu brechen. Neue Pflichtfelder
   kommen in eine neue Version; die alte bleibt verträglich, sodass gekoppelte Systeme weiter funktionieren.
   **EN:** Versioning allows changes without suddenly breaking existing callers. New mandatory fields go into a
   new version; the old one stays compatible, so coupled systems keep working.

   </details>

7. **DE:** Was gehört in einen guten Fehlervertrag, und was nicht? /
   **EN:** What belongs in a good error contract, and what does not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein maschinenlesbarer Statuscode und eine sichere Meldung, die sagt, *was* falsch war. Nicht hinein
   gehören interne Details wie Stack-Traces, Pfade, Verbindungszeichenketten oder Datenbankmeldungen.
   **EN:** A machine-readable status code and a safe message that says *what* was wrong. Internal details like
   stack traces, paths, connection strings, or database messages do not belong in it.

   </details>

8. **DE:** Warum muss der ASVS-Bezug für Web-/API-Anteile geprüft und ggf. als `N/A` begründet werden? /
   **EN:** Why must the ASVS relation for web/API parts be checked and, if needed, justified as `N/A`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** ASVS ist der Verifikationsstandard für Web-/API-/Auth-Dienste. Man benennt den passenden Level oder
   begründet mit kurzer technischer Erklärung, warum er hier nicht anwendbar ist – ohne stille Auslassung.
   **EN:** ASVS is the verification standard for web/API/auth services. You name the matching level or justify
   with a short technical explanation why it does not apply here – without silent omission.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] alle Operationen der API mit Zweck benennen.
- [ ] Ein- und Ausgaben mit Typ, Format und Grenzen beschreiben.
- [ ] einen Vertrag als OpenAPI/Swagger skizzieren.
- [ ] einen sicheren Fehlervertrag ohne interne Details von einem unsicheren unterscheiden.
- [ ] Timeouts, Limits, Versionierung und den ASVS-Bezug prüfen oder begründet als `N/A` einordnen.

**EN:** I can …

- [ ] name all API operations with their purpose.
- [ ] describe inputs and outputs with type, format, and limits.
- [ ] sketch a contract as OpenAPI/Swagger.
- [ ] tell a safe error contract without internal details from an unsafe one.
- [ ] check timeouts, limits, versioning, and the ASVS relation or classify it as justified `N/A`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
