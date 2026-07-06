# Lernbegleiter: Secure ServiceHarvester Application Track 02 – API-Erweiterung und Ressourcenmodell / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester stellt Statusdaten über eine API bereit. Jetzt sollen neue **Ressourcen** dazu:
etwa `machines` und deren `snapshots`. Eine API ist ein **Vertrag** zwischen dem Dienst und seinen Clients.
Ändert man einen Vertrag unbedacht, brechen bestehende Clients. Deshalb entwirfst du das **Ressourcenmodell**
sorgfältig: klare Pfade, passende HTTP-Methoden, konsistente Statuscodes und eine Strategie, wie neue Felder
und Endpunkte hinzukommen, ohne alte Nutzer zu stören (**Rückwärtskompatibilität**).

**EN:** The ServiceHarvester provides status data via an API. Now new **resources** should be added: e.g.
`machines` and their `snapshots`. An API is a **contract** between the service and its clients. Changing a
contract carelessly breaks existing clients. Therefore you design the **resource model** carefully: clear
paths, suitable HTTP methods, consistent status codes, and a strategy for how new fields and endpoints are
added without disturbing existing users (**backward compatibility**).

**DE:** Du lernst, Ressourcen sauber zu schneiden, Endpunkte und Statuscodes konsistent zu wählen, additive
von brechenden Änderungen zu unterscheiden und eine begründete Versionierungsstrategie zu wählen. Sicherheit
ist dabei kein Zusatz: Jede Eingabe an der API-Grenze gilt als nicht vertrauenswürdig.

**EN:** You learn to cut resources cleanly, choose endpoints and status codes consistently, distinguish
additive from breaking changes, and select a justified versioning strategy. Security is not an add-on here:
every input at the API boundary is treated as untrusted.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Ressource / Resource | Ein benanntes Ding, das die API bereitstellt, z. B. eine Maschine oder ein Snapshot. |
| Ressourcenmodell / Resource model | Struktur der Ressourcen, ihrer Felder und Beziehungen. |
| Endpunkt / Endpoint | Pfad plus HTTP-Methode, über den eine Ressource angesprochen wird. |
| Statuscode / Status code | Standardisierte Antwort über Erfolg oder Fehler eines Aufrufs. |
| Idempotenz / Idempotency | Ein Aufruf, der mehrfach ausgeführt dasselbe Ergebnis liefert, ohne Schaden. |
| Rückwärtskompatibilität / Backward compatibility | Neue Version stört bestehende Clients nicht. |
| Additive Änderung / Additive change | Neue Felder/Endpunkte hinzufügen, ohne bestehende zu ändern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ressourcen benennen und schneiden.** Bestimme die Substantive der Domäne: `machines`,
`snapshots`. Ressourcen sind Dinge, keine Tätigkeiten. Ein guter Test: Pfade sollten Substantive sein
(`/machines/{id}/snapshots`), Methoden drücken die Tätigkeit aus (GET, POST).

**EN:** **Step 1 – Name and cut resources.** Determine the nouns of the domain: `machines`, `snapshots`.
Resources are things, not actions. A good test: paths should be nouns (`/machines/{id}/snapshots`), methods
express the action (GET, POST).

**DE:** **Schritt 2 – Methoden und Statuscodes konsistent wählen.** Ordne jeder Aktion eine Methode und
sinnvolle Statuscodes zu: `200` für Erfolg, `201` für Erzeugtes, `400` für ungültige Eingabe, `404` für nicht
gefunden, `409` für Konflikt. Konsistenz senkt Fehler auf der Clientseite.

**EN:** **Step 2 – Choose methods and status codes consistently.** Assign each action a method and meaningful
status codes: `200` for success, `201` for created, `400` for invalid input, `404` for not found, `409` for
conflict. Consistency reduces client-side errors.

**DE:** **Schritt 3 – Idempotenz bedenken.** GET-Aufrufe verändern nichts und sind natürlich idempotent. Bei
schreibenden Aufrufen überlegst du, ob ein wiederholter Aufruf (etwa nach Netzwerkabbruch) doppelt wirkt.
Idempotenz macht einen Dienst robuster gegen Wiederholungen.

**EN:** **Step 3 – Consider idempotency.** GET calls change nothing and are naturally idempotent. For writing
calls, consider whether a repeated call (e.g. after a network drop) has a double effect. Idempotency makes a
service more robust against retries.

**DE:** **Schritt 4 – Kompatibilität und Versionierung.** Unterscheide additive Änderungen (neues optionales
Feld, neuer Endpunkt) von brechenden Änderungen (Feld entfernen, Bedeutung ändern). Additive Änderungen sind
meist rückwärtskompatibel. Für brechende Änderungen wählst du eine Versionierung (z. B. `/v2/` im Pfad) und
begründest den Trade-off: Pfad-Version ist sichtbar und einfach, kostet aber Pflege paralleler Versionen.

**EN:** **Step 4 – Compatibility and versioning.** Distinguish additive changes (new optional field, new
endpoint) from breaking changes (removing a field, changing meaning). Additive changes are usually backward
compatible. For breaking changes you choose a versioning scheme (e.g. `/v2/` in the path) and justify the
trade-off: a path version is visible and simple but costs maintaining parallel versions.

**DE:** **Schritt 5 – Eingaben validieren, Fehler sauber melden.** Jede Eingabe an der API-Grenze ist nicht
vertrauenswürdig: Typen, Wertebereiche und Pflichtfelder prüfen. Fehlerantworten geben eine klare, aber
harmlose Meldung zurück – nie Stack-Traces, interne Pfade oder Verbindungszeichenketten.

**EN:** **Step 5 – Validate inputs, report errors cleanly.** Every input at the API boundary is untrusted:
check types, value ranges, and required fields. Error responses return a clear but harmless message – never
stack traces, internal paths, or connection strings.

**DE:** **Typische Fehler.** Tätigkeiten in Pfade packen (`/getMachine`). Statuscodes beliebig verwenden.
Brechende Änderungen ohne Version. Interne Fehlerdetails preisgeben. Eingaben ungeprüft übernehmen.
Kompatibilität nur behaupten, ohne einen Testpfad zu nennen.

**EN:** **Common mistakes.** Putting actions into paths (`/getMachine`). Using status codes arbitrarily.
Breaking changes without a version. Exposing internal error details. Accepting inputs unchecked. Claiming
compatibility without naming a test path.

### Beispiel / Example

```text
Ressourcen:   machines, snapshots (snapshot gehoert zu genau einer machine)

Endpunkte:
  GET  /machines                      -> 200 Liste (idempotent)
  GET  /machines/{id}                 -> 200 | 404
  GET  /machines/{id}/snapshots       -> 200 Liste
  POST /machines/{id}/snapshots       -> 201 erzeugt | 400 ungueltig

Kompatibilitaet:
  additiv    : neues optionales Feld "last_contact" -> rueckwaertskompatibel
  brechend   : Feld "os" umbenennen -> nur mit neuer Version /v2/

ADR-Kandidat: "Versionierung ueber Pfad (/v2/) statt Header"
  Alternative: Header-Version | Trade-off: sichtbar/einfach vs. Pflege paralleler Versionen

Fehler:       400 { "error": "field 'os' required" }  (keine internen Details)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11a**
ist primär, weil eine neue API-Funktionalität sicher realisiert wird; LF 5 ist berührt, weil die über die API
sichtbare Datenverwaltung erweitert und angepasst wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`).
**LF 11a** is primary because new API functionality is realized securely; LF 5 is touched because the data
management visible through the API is extended and adapted.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Die API-Erweiterung realisiert neue Funktionalität über einen sicheren Vertrag. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Ressourcen und Felder erweitern die über die API zugängliche Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabevalidierung an Vertrauensgrenzen, sichere
Fehlerbehandlung und sichere Architektur. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede Eingabe an der API-Grenze gilt als nicht vertrauenswürdig,
Fehlerantworten bleiben harmlos, und Kompatibilität wird mit einem Testpfad belegt.* A11Y-Aspekt:
Endpunkt- und Statuscode-Tabellen müssen als klarer Text lesbar sein, ohne reine Farbmarkierung, damit sie mit
Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: input validation at trust boundaries, secure error
handling, and secure architecture. Matching checklists: `CL_01` (standards applicability), `CL_03` (input
validation), `CL_08` (security code review), and `CL_12` (evidence and closure). The security decision of this
unit is: *every input at the API boundary is untrusted, error responses stay harmless, and compatibility is
evidenced with a test path.* Accessibility aspect: endpoint and status-code tables must be readable as clear
text, without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollten Pfade Substantive und Methoden die Tätigkeit ausdrücken? /
   **EN:** Why should paths be nouns and methods express the action?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ressourcen sind Dinge; die Methode (GET, POST) beschreibt, was mit ihnen geschieht. Diese Trennung
   hält die API vorhersehbar und konsistent und vermeidet Wildwuchs wie `/getMachine` neben `/machineGet`.
   **EN:** Resources are things; the method (GET, POST) describes what happens to them. This separation keeps
   the API predictable and consistent and avoids sprawl like `/getMachine` next to `/machineGet`.

   </details>

2. **DE:** (AE) Was unterscheidet eine additive von einer brechenden Änderung? /
   **EN:** (AE) What distinguishes an additive change from a breaking change?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine additive Änderung fügt etwas hinzu (neues optionales Feld, neuer Endpunkt), ohne Bestehendes zu
   ändern; sie ist meist rückwärtskompatibel. Eine brechende Änderung entfernt oder verändert Bestehendes und
   erfordert eine neue Version.
   **EN:** An additive change adds something (new optional field, new endpoint) without altering existing
   parts; it is usually backward compatible. A breaking change removes or alters existing parts and requires a
   new version.

   </details>

3. **DE:** (AE) Warum ist Idempotenz bei wiederholten Aufrufen wichtig? /
   **EN:** (AE) Why does idempotency matter for repeated calls?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Netzwerke sind unzuverlässig; Clients wiederholen Aufrufe. Ist ein Aufruf idempotent, richtet die
   Wiederholung keinen Schaden an (kein doppelter Datensatz). Das macht den Dienst robuster und einfacher zu
   betreiben.
   **EN:** Networks are unreliable; clients retry calls. If a call is idempotent, the retry causes no harm (no
   duplicate record). This makes the service more robust and easier to operate.

   </details>

4. **DE:** Warum dürfen Fehlerantworten keine internen Details enthalten? /
   **EN:** Why must error responses not contain internal details?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces, interne Pfade oder Verbindungszeichenketten helfen Angreifern und verraten die innere
   Struktur. Eine klare, aber harmlose Meldung genügt dem Client; Details gehören ins interne Log.
   **EN:** Stack traces, internal paths, or connection strings help attackers and reveal the internal
   structure. A clear but harmless message is enough for the client; details belong in the internal log.

   </details>

5. **DE:** (DV) Warum ist ein stabiler API-Vertrag für andere Systeme wichtig? /
   **EN:** (DV) Why is a stable API contract important for other systems?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Andere Systeme verlassen sich auf Pfade, Felder und Statuscodes. Ein stabiler, versionierter Vertrag
   erlaubt ihnen, zuverlässig zu integrieren, während der Dienst sich additiv weiterentwickeln kann.
   **EN:** Other systems rely on paths, fields, and status codes. A stable, versioned contract lets them
   integrate reliably while the service can evolve additively.

   </details>

6. **DE:** Wie belegst du, dass eine Änderung rückwärtskompatibel ist? /
   **EN:** How do you evidence that a change is backward compatible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Contract- oder Regressionstest, der einen bestehenden Client-Aufruf gegen die neue Version
   ausführt und zeigt, dass Antwortform und Statuscodes gleich bleiben. Eine bloße Behauptung genügt nicht.
   **EN:** With a contract or regression test that runs an existing client call against the new version and
   shows that response shape and status codes stay the same. A mere claim is not enough.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Ressourcen als Substantive schneiden und Beziehungen abbilden.
- [ ] Methoden und Statuscodes konsistent zuordnen.
- [ ] Idempotenz lesender und wiederholbarer Aufrufe einschätzen.
- [ ] additive von brechenden Änderungen unterscheiden.
- [ ] eine Versionierungsstrategie mit Trade-off begründen.
- [ ] Eingaben validieren und Fehlerantworten harmlos halten.

**EN:** I can …

- [ ] cut resources as nouns and map their relations.
- [ ] assign methods and status codes consistently.
- [ ] judge idempotency of read and repeatable calls.
- [ ] distinguish additive from breaking changes.
- [ ] justify a versioning strategy with a trade-off.
- [ ] validate inputs and keep error responses harmless.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
