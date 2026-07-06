# Lernbegleiter: Secure ServiceHarvester Application Track 05 – Viewer- oder Client-Oberfläche / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die gesammelten Statusdaten sollen für Menschen sichtbar werden – über einen **Viewer** oder
**Client**. Das kann eine Kommandozeilen-Ausgabe (CLI) oder ein kleiner Web-Viewer sein. Zwei Dinge sind hier
zentral. Erstens **Barrierefreiheit**: Die Oberfläche muss mit Tastatur bedienbar und mit Screenreader oder
Braille-Zeile nutzbar sein, und Informationen dürfen nicht allein über Farbe transportiert werden. Zweitens
**sichere Ausgabe**: Die angezeigten Daten stammen aus dem Sammelprozess und gelten als nicht vertrauenswürdig;
in einem Web-Viewer müssen sie vor der Anzeige encodiert werden, sonst droht Cross-Site Scripting (XSS).

**EN:** The collected status data should become visible to people – via a **viewer** or **client**. This can be
a command-line output (CLI) or a small web viewer. Two things are central here. First **accessibility**: the
interface must be keyboard-operable and usable with a screen reader or Braille display, and information must
not be conveyed by color alone. Second **secure output**: the displayed data comes from the collection process
and is treated as untrusted; in a web viewer it must be encoded before display, otherwise cross-site scripting
(XSS) threatens.

**DE:** Du lernst, eine wartbare Oberfläche zu strukturieren, zwischen CLI und Web-Viewer begründet zu wählen,
Ausgaben kontextgerecht zu encodieren und die Barrierefreiheit als prüfbaren Nachweis zu behandeln.

**EN:** You learn to structure a maintainable interface, to choose between CLI and web viewer with a rationale,
to encode outputs contextually, and to treat accessibility as verifiable evidence.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Viewer / Client | Oberfläche, die gesammelte Daten für Menschen darstellt. |
| Barrierefreiheit / Accessibility | Nutzbarkeit für alle, u. a. mit Tastatur, Screenreader und Braille-Zeile. |
| Output-Encoding / Output encoding | Umwandeln von Sonderzeichen vor der Ausgabe, damit sie als Text erscheinen. |
| XSS / XSS | Cross-Site Scripting: eingeschleuster Code, der im Anzeigekontext ausgeführt wird. |
| Tastaturbedienbarkeit / Keyboard operability | Alle Funktionen sind ohne Maus erreichbar. |
| Semantische Struktur / Semantic structure | Bedeutungstragende Auszeichnung (Überschriften, Tabellen, Listen). |
| Nicht vertrauenswürdig / Untrusted | Daten, die vor der Anzeige geprüft und encodiert werden müssen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Informationsstruktur planen.** Überlege, welche Daten sichtbar sein müssen (Maschine,
Status, letzter Kontakt) und wie sie geordnet sind. Eine klare Struktur (Überschriften, Tabellen, Listen) hilft
allen Nutzenden und ist zugleich die Grundlage für Screenreader-Tauglichkeit.

**EN:** **Step 1 – Plan the information structure.** Consider which data must be visible (machine, status, last
contact) and how it is ordered. A clear structure (headings, tables, lists) helps all users and is at the same
time the basis for screen-reader support.

**DE:** **Schritt 2 – CLI oder Web-Viewer wählen.** Eine CLI ist schlank, gut skriptbar und für Braille-Zeilen
und Textbrowser sehr zugänglich. Ein Web-Viewer bietet mehr Darstellung, bringt aber XSS-Risiken und mehr
Barrierefreiheits-Pflichten mit. Wähle begründet und notiere den Trade-off.

**EN:** **Step 2 – Choose CLI or web viewer.** A CLI is lean, easily scriptable, and very accessible for
Braille displays and text browsers. A web viewer offers richer presentation but brings XSS risks and more
accessibility duties. Choose with a rationale and note the trade-off.

**DE:** **Schritt 3 – Ausgaben als nicht vertrauenswürdig behandeln.** Die angezeigten Werte stammen aus dem
Sammelprozess. In einem Web-Viewer encodierst du sie kontextgerecht (HTML-Encoding), damit ein Maschinenname
wie `<script>` als Text erscheint und nicht ausgeführt wird. In einer CLI achtest du auf Steuerzeichen.

**EN:** **Step 3 – Treat outputs as untrusted.** The displayed values come from the collection process. In a
web viewer you encode them contextually (HTML encoding) so a machine name like `<script>` appears as text and
is not executed. In a CLI you watch for control characters.

**DE:** **Schritt 4 – Barrierefreiheit sicherstellen.** Alle Funktionen müssen mit der Tastatur erreichbar
sein. Farbe darf nie die einzige Information sein (ein „roter" Status braucht auch Text wie „offline").
Kontraste, Fokus-Sichtbarkeit und sinnvolle Beschriftungen gehören dazu. Ziel ist WCAG 2.2 Level AA.

**EN:** **Step 4 – Ensure accessibility.** All functions must be reachable with the keyboard. Color must never
be the only information (a "red" status also needs text like "offline"). Contrast, focus visibility, and
meaningful labels belong to it. The goal is WCAG 2.2 Level AA.

**DE:** **Schritt 5 – Fehler sauber anzeigen.** Fehlermeldungen sind für Menschen verständlich, aber harmlos:
keine Stack-Traces, internen Pfade oder Verbindungszeichenketten. Zeige, was der Nutzende tun kann, nicht, wie
das System innen aussieht.

**EN:** **Step 5 – Display errors cleanly.** Error messages are understandable for people but harmless: no
stack traces, internal paths, or connection strings. Show what the user can do, not what the system looks like
inside.

**DE:** **Typische Fehler.** Angezeigte Daten ungeprüft in HTML setzen (XSS). Status nur über Farbe zeigen.
Funktionen nur mit Maus erreichbar. Fehlermeldungen mit internen Details. CLI oder Web-Viewer wählen, ohne die
Barrierefreiheit zu bedenken oder den Trade-off zu nennen.

**EN:** **Common mistakes.** Putting displayed data into HTML unchecked (XSS). Showing status by color only.
Functions reachable only with a mouse. Error messages with internal details. Choosing CLI or web viewer
without considering accessibility or naming the trade-off.

### Beispiel / Example

```text
Informationsstruktur (Viewer):
  Ueberschrift: "Maschinen-Status"
  Tabelle: Name | Status (Text!) | Letzter Kontakt
    web-01 | offline | 2026-07-06 08:12
    web-02 | running | 2026-07-06 09:40

Sichere Ausgabe (Web): Name "<script>alert(1)</script>"
  -> HTML-encodiert als "&lt;script&gt;alert(1)&lt;/script&gt;" (erscheint als Text)

Barrierefreiheit:
  - jede Funktion per Tastatur erreichbar
  - Status als Text "offline"/"running", nicht nur rot/gruen
  - sichtbarer Fokus, ausreichender Kontrast (WCAG 2.2 AA)

ADR-Kandidat: "CLI-Viewer als barrierearme Standardausgabe"
  Alternative: Web-Viewer | Trade-off: sehr gute A11Y/Skriptbarkeit vs. weniger Darstellung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 10a**
ist primär, weil eine Benutzerschnittstelle gestaltet und entwickelt wird; LF 4 ist berührt, weil der
Schutzbedarf der angezeigten Daten und die sichere, harmlose Ausgabe betrachtet werden.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`).
**LF 10a** is primary because a user interface is designed and developed; LF 4 is touched because the
protection need of the displayed data and the secure, harmless output are considered.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10a Benutzerschnittstellen gestalten und entwickeln | Primär / Primary | Die Viewer-/Client-Oberfläche wird gestaltet, entwickelt und barrierefrei gemacht. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Angezeigte Daten gelten als nicht vertrauenswürdig; Encoding und harmlose Fehler sind Schutzmaßnahmen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung (Output-Encoding), Barrierefreiheit,
sichere Fehlerbehandlung und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_11` (Barrierefreiheit) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Angezeigte Daten gelten als nicht vertrauenswürdig und werden
encodiert, und die Oberfläche ist ohne Maus und ohne reine Farbe nutzbar.* A11Y-Aspekt: Die gesamte Einheit
ist selbst ein Barrierefreiheits-Nachweis; Struktur, Tastaturbedienung und textliche Statusangaben werden
gegen WCAG 2.2 AA geprüft und dokumentiert.

**EN:** Relation to the Secure Development Guideline: secure programming (output encoding), accessibility,
secure error handling, and testability. Matching checklists: `CL_01` (standards applicability), `CL_08`
(security code review), `CL_11` (accessibility), and `CL_12` (evidence and closure). The security decision of
this unit is: *displayed data is untrusted and gets encoded, and the interface is usable without a mouse and
without color alone.* Accessibility aspect: the whole unit is itself an accessibility proof; structure,
keyboard operation, and textual status labels are checked against WCAG 2.2 AA and documented.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (AE) Warum müssen angezeigte Statusdaten in einem Web-Viewer encodiert werden? /
   **EN:** (AE) Why must displayed status data be encoded in a web viewer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Daten stammen aus dem Sammelprozess und sind nicht vertrauenswürdig. Ohne Encoding könnte ein
   Wert wie `<script>` als Code interpretiert und ausgeführt werden (XSS). Encoding sorgt dafür, dass er als
   Text erscheint.
   **EN:** The data comes from the collection process and is untrusted. Without encoding, a value like
   `<script>` could be interpreted and executed as code (XSS). Encoding ensures it appears as text.

   </details>

2. **DE:** Warum darf Farbe nie die einzige Information sein? /
   **EN:** Why must color never be the only information?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Menschen mit Farbfehlsichtigkeit oder Nutzende von Braille-Zeilen und Textbrowsern nehmen Farbe nicht
   wahr. Ein Status muss deshalb auch als Text („offline") vorhanden sein, sonst geht die Information verloren.
   **EN:** People with color vision deficiency or users of Braille displays and text browsers do not perceive
   color. A status must therefore also exist as text ("offline"), otherwise the information is lost.

   </details>

3. **DE:** (AE) Welchen Trade-off haben CLI und Web-Viewer aus Sicht der Barrierefreiheit? /
   **EN:** (AE) What trade-off do CLI and web viewer have from an accessibility perspective?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine CLI ist textbasiert, gut skriptbar und sehr zugänglich für Braille und Textbrowser, bietet aber
   weniger Darstellung. Ein Web-Viewer kann mehr zeigen, erfordert aber sorgfältige Barrierefreiheit und
   Encoding. Die Wahl hängt von Zielgruppe und Einsatz ab.
   **EN:** A CLI is text-based, easily scriptable, and very accessible for Braille and text browsers but offers
   less presentation. A web viewer can show more but requires careful accessibility and encoding. The choice
   depends on audience and use.

   </details>

4. **DE:** Warum müssen alle Funktionen mit der Tastatur erreichbar sein? /
   **EN:** Why must all functions be reachable with the keyboard?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht alle Nutzenden können eine Maus verwenden; Screenreader-Nutzende arbeiten meist mit der
   Tastatur. Nur wenn jede Funktion per Tastatur erreichbar ist, bleibt die Oberfläche für alle bedienbar (WCAG
   2.2 AA).
   **EN:** Not all users can use a mouse; screen-reader users mostly work with the keyboard. Only if every
   function is keyboard-reachable does the interface stay operable for everyone (WCAG 2.2 AA).

   </details>

5. **DE:** Warum dürfen Fehlermeldungen keine internen Details zeigen? /
   **EN:** Why must error messages not show internal details?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces, interne Pfade oder Verbindungszeichenketten helfen Angreifern und verwirren
   Nutzende. Eine gute Meldung sagt, was zu tun ist; technische Details gehören ins interne Log.
   **EN:** Stack traces, internal paths, or connection strings help attackers and confuse users. A good
   message says what to do; technical details belong in the internal log.

   </details>

6. **DE:** (DV) Warum ist es wichtig, wie der Client die Daten des Dienstes bezieht? /
   **EN:** (DV) Why does it matter how the client obtains the data from the service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Bezugsweg (API-Aufruf, Datei) ist eine Vertrauensgrenze und eine Schnittstelle. Wie er gestaltet
   ist, bestimmt Zuverlässigkeit, Fehlerverhalten und welche Daten überhaupt sichtbar werden – das gehört klar
   beschrieben.
   **EN:** The retrieval path (API call, file) is a trust boundary and an interface. Its design determines
   reliability, error behavior, and which data becomes visible at all – this must be clearly described.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine klare Informationsstruktur für die Oberfläche planen.
- [ ] zwischen CLI und Web-Viewer begründet wählen.
- [ ] angezeigte Daten als nicht vertrauenswürdig behandeln und encodieren.
- [ ] Tastaturbedienbarkeit und textliche Statusangaben sicherstellen.
- [ ] Barrierefreiheit gegen WCAG 2.2 AA als Nachweis dokumentieren.
- [ ] Fehlermeldungen verständlich und harmlos halten.

**EN:** I can …

- [ ] plan a clear information structure for the interface.
- [ ] choose between CLI and web viewer with a rationale.
- [ ] treat displayed data as untrusted and encode it.
- [ ] ensure keyboard operability and textual status labels.
- [ ] document accessibility against WCAG 2.2 AA as evidence.
- [ ] keep error messages understandable and harmless.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
