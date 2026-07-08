# Lernbegleiter: Secure OrderDesk Application Track 05 – Viewer- oder Client-Oberfläche / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Kunden, Produkte und Bestellungen der Handelsplattform von Secure Trader sollen für Menschen sichtbar werden – über einen **Viewer** oder **Client**. Das kann eine Kommandozeilen-Ausgabe (CLI) oder ein kleiner Web-Viewer sein. Zwei Dinge sind hier zentral. Erstens **Barrierefreiheit**: Die Oberfläche muss mit Tastatur bedienbar und mit Screenreader oder Braille-Zeile nutzbar sein, und Informationen wie der Bestellzustand dürfen nicht allein über Farbe transportiert werden. Zweitens **sichere Ausgabe**: Die angezeigten Bestelldaten (z. B. der Firmenname von Kunde `ALFKI`) gelten als nicht vertrauenswürdig; in einem Web-Viewer müssen sie vor der Anzeige encodiert werden, sonst droht Cross-Site Scripting (XSS).

**EN:** The customers, products, and orders of Secure Trader's trading platform should become visible to people – via a **viewer** or **client**. This can be a command-line output (CLI) or a small web viewer. Two things are central here. First **accessibility**: the interface must be keyboard-operable and usable with a screen reader or Braille display, and information such as the order state must not be conveyed by color alone. Second **secure output**: the displayed order data (e.g. the company name of customer `ALFKI`) is treated as untrusted; in a web viewer it must be encoded before display, otherwise cross-site scripting (XSS) threatens.

**DE:** Du lernst, eine wartbare Oberfläche mit Master-Detail (Bestellliste zu Positionen) zu strukturieren, zwischen CLI und Web-Viewer begründet zu wählen, Ausgaben kontextgerecht zu encodieren und die Barrierefreiheit als prüfbaren Nachweis zu behandeln. Nur benötigte Kundenfelder werden gezeigt (Datenminimierung).

**EN:** You learn to structure a maintainable interface with master-detail (order list to order lines), to choose between CLI and web viewer with a rationale, to encode outputs contextually, and to treat accessibility as verifiable evidence. Only required customer fields are shown (data minimization).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Viewer / Client | Oberfläche, die Kunden-, Produkt- und Bestelldaten für Menschen darstellt. |
| Master-Detail / Master-detail | Bestellliste (Master) mit aufklappbaren Positionen (Detail) zu jeder Bestellung. |
| Barrierefreiheit / Accessibility | Nutzbarkeit für alle, u. a. mit Tastatur, Screenreader und Braille-Zeile. |
| Output-Encoding / Output encoding | Umwandeln von Sonderzeichen vor der Ausgabe, damit sie als Text erscheinen. |
| XSS / XSS | Cross-Site Scripting: eingeschleuster Code, der im Anzeigekontext ausgeführt wird. |
| Tastaturbedienbarkeit / Keyboard operability | Alle Funktionen sind ohne Maus erreichbar. |
| Datenminimierung / Data minimization | Nur die wirklich benötigten Kundenfelder werden angezeigt. |
| Nicht vertrauenswürdig / Untrusted | Daten, die vor der Anzeige geprüft und encodiert werden müssen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Informationsstruktur planen.** Überlege, welche Daten sichtbar sein müssen (Kunde, Bestellung, Position, Produkt) und wie sie geordnet sind. Eine klare Struktur (Überschriften, Tabellen, Listen, Master-Detail von `Orders` zu `Order Details`) hilft allen Nutzenden und ist zugleich die Grundlage für Screenreader-Tauglichkeit.

**EN:** **Step 1 – Plan the information structure.** Consider which data must be visible (customer, order, order line, product) and how it is ordered. A clear structure (headings, tables, lists, master-detail from `Orders` to `Order Details`) helps all users and is at the same time the basis for screen-reader support.

**DE:** **Schritt 2 – CLI oder Web-Viewer wählen.** Eine CLI ist schlank, gut skriptbar und für Braille-Zeilen und Textbrowser sehr zugänglich. Ein Web-Viewer bietet mehr Darstellung, bringt aber XSS-Risiken und mehr Barrierefreiheits-Pflichten mit. Wähle begründet und notiere den Trade-off.

**EN:** **Step 2 – Choose CLI or web viewer.** A CLI is lean, easily scriptable, and very accessible for Braille displays and text browsers. A web viewer offers richer presentation but brings XSS risks and more accessibility duties. Choose with a rationale and note the trade-off.

**DE:** **Schritt 3 – Ausgaben als nicht vertrauenswürdig behandeln.** Die angezeigten Werte stammen aus der Bestelldatenbank und Importen. In einem Web-Viewer encodierst du sie kontextgerecht (HTML-Encoding), damit ein Kundenname wie `<script>` als Text erscheint und nicht ausgeführt wird. In einer CLI achtest du auf Steuerzeichen. Zeige nur benötigte Felder (Datenminimierung).

**EN:** **Step 3 – Treat outputs as untrusted.** The displayed values come from the order database and imports. In a web viewer you encode them contextually (HTML encoding) so a customer name like `<script>` appears as text and is not executed. In a CLI you watch for control characters. Show only required fields (data minimization).

**DE:** **Schritt 4 – Barrierefreiheit sicherstellen.** Alle Funktionen müssen mit der Tastatur erreichbar sein. Farbe darf nie die einzige Information sein (ein „offener" Bestellzustand braucht auch Text wie „offen"/„versendet"). Kontraste, Fokus-Sichtbarkeit und sinnvolle Beschriftungen gehören dazu. Ziel ist WCAG 2.2 Level AA.

**EN:** **Step 4 – Ensure accessibility.** All functions must be reachable with the keyboard. Color must never be the only information (an "open" order state also needs text like "open"/"shipped"). Contrast, focus visibility, and meaningful labels belong to it. The goal is WCAG 2.2 Level AA.

**DE:** **Schritt 5 – Fehler sauber anzeigen.** Fehlermeldungen sind für Menschen verständlich, aber harmlos: keine Stack-Traces, SQL-Texte, internen Pfade oder Verbindungszeichenketten. Zeige, was der Nutzende tun kann, nicht, wie das System innen aussieht.

**EN:** **Step 5 – Display errors cleanly.** Error messages are understandable for people but harmless: no stack traces, SQL texts, internal paths, or connection strings. Show what the user can do, not what the system looks like inside.

**DE:** **Typische Fehler.** Angezeigte Kunden- oder Bestelldaten ungeprüft in HTML setzen (XSS). Bestellzustand nur über Farbe zeigen. Funktionen nur mit Maus erreichbar. Alle Kundenfelder anzeigen statt nur der benötigten. Fehlermeldungen mit internen Details oder SQL-Text. CLI oder Web-Viewer wählen, ohne den Trade-off zu nennen.

**EN:** **Common mistakes.** Putting displayed customer or order data into HTML unchecked (XSS). Showing order state by color only. Functions reachable only with a mouse. Showing all customer fields instead of only the required ones. Error messages with internal details or SQL text. Choosing CLI or web viewer without naming the trade-off.

### Beispiel / Example

```text
Informationsstruktur (Viewer, Master-Detail):
  Ueberschrift: "Bestelluebersicht Secure Trader"
  Tabelle Orders: OrderID | Kunde | Zustand (Text!) | Bestelldatum
    10643 | ALFKI | versendet | 1997-08-25
    10692 | ALFKI | offen     | 1997-10-03
  Detail Order Details (zu 10643): Produkt | Menge | Einzelpreis
    Rossle Sauerkraut | 15 | 45.60

Sichere Ausgabe (Web): Kundenname "<script>alert(1)</script>"
  -> HTML-encodiert als "&lt;script&gt;alert(1)&lt;/script&gt;" (erscheint als Text)

Barrierefreiheit:
  - jede Funktion per Tastatur erreichbar
  - Zustand als Text "offen"/"versendet", nicht nur rot/gruen
  - sichtbarer Fokus, ausreichender Kontrast (WCAG 2.2 AA)
  - Datenminimierung: nur benoetigte Kundenfelder anzeigen

ADR-Kandidat: "CLI-Viewer als barrierearme Standardausgabe"
  Alternative: Web-Viewer | Trade-off: sehr gute A11Y/Skriptbarkeit vs. weniger Darstellung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). **LF 10a** ist primär, weil eine Benutzerschnittstelle für die Bestelldomäne gestaltet und entwickelt wird; LF 4 ist berührt, weil der Schutzbedarf der angezeigten Kunden- und Bestelldaten und die sichere, harmlose Ausgabe betrachtet werden.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). **LF 10a** is primary because a user interface for the ordering domain is designed and developed; LF 4 is touched because the protection need of the displayed customer and order data and the secure, harmless output are considered.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10a Benutzerschnittstellen gestalten und entwickeln | Primär / Primary | Die Viewer-/Client-Oberfläche für Kunden, Produkte und Bestellungen wird gestaltet, entwickelt und barrierefrei gemacht. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Angezeigte Bestelldaten gelten als nicht vertrauenswürdig; Encoding, Datenminimierung und harmlose Fehler sind Schutzmaßnahmen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung (Output-Encoding), Barrierefreiheit, sichere Fehlerbehandlung und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review), `CL_11` (Barrierefreiheit) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Angezeigte Kunden- und Bestelldaten gelten als nicht vertrauenswürdig und werden encodiert, es werden nur benötigte Felder gezeigt, und die Oberfläche ist ohne Maus und ohne reine Farbe nutzbar.* A11Y-Aspekt: Die gesamte Einheit ist selbst ein Barrierefreiheits-Nachweis; Struktur, Tastaturbedienung und textliche Zustandsangaben (z. B. „offen"/„versendet") werden gegen WCAG 2.2 AA geprüft und dokumentiert.

**EN:** Relation to the Secure Development Guideline: secure programming (output encoding), accessibility, secure error handling, and testability. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_11` (accessibility), and `CL_12` (evidence and closure). The security decision of this unit is: *displayed customer and order data is untrusted and gets encoded, only required fields are shown, and the interface is usable without a mouse and without color alone.* Accessibility aspect: the whole unit is itself an accessibility proof; structure, keyboard operation, and textual state labels (e.g. "open"/"shipped") are checked against WCAG 2.2 AA and documented.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (AE) Warum müssen angezeigte Kunden- und Bestelldaten in einem Web-Viewer encodiert werden? /
   **EN:** (AE) Why must displayed customer and order data be encoded in a web viewer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Daten stammen aus der Bestelldatenbank und aus Importen und sind nicht vertrauenswürdig. Ohne Encoding könnte ein Wert wie `<script>` als Code interpretiert und ausgeführt werden (XSS). Encoding sorgt dafür, dass er als Text erscheint.
   **EN:** The data comes from the order database and from imports and is untrusted. Without encoding, a value like `<script>` could be interpreted and executed as code (XSS). Encoding ensures it appears as text.

   </details>

2. **DE:** Warum darf Farbe nie die einzige Information für einen Bestellzustand sein? /
   **EN:** Why must color never be the only information for an order state?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Menschen mit Farbfehlsichtigkeit oder Nutzende von Braille-Zeilen und Textbrowsern nehmen Farbe nicht wahr. Ein Zustand muss deshalb auch als Text („offen", „versendet") vorhanden sein, sonst geht die Information verloren.
   **EN:** People with color vision deficiency or users of Braille displays and text browsers do not perceive color. A state must therefore also exist as text ("open", "shipped"), otherwise the information is lost.

   </details>

3. **DE:** (AE) Welchen Trade-off haben CLI und Web-Viewer aus Sicht der Barrierefreiheit? /
   **EN:** (AE) What trade-off do CLI and web viewer have from an accessibility perspective?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine CLI ist textbasiert, gut skriptbar und sehr zugänglich für Braille und Textbrowser, bietet aber weniger Darstellung. Ein Web-Viewer kann mehr zeigen (z. B. Master-Detail-Bestelllisten), erfordert aber sorgfältige Barrierefreiheit und Encoding. Die Wahl hängt von Zielgruppe und Einsatz ab.
   **EN:** A CLI is text-based, easily scriptable, and very accessible for Braille and text browsers but offers less presentation. A web viewer can show more (e.g. master-detail order lists) but requires careful accessibility and encoding. The choice depends on audience and use.

   </details>

4. **DE:** Warum müssen alle Funktionen des Bestell-Viewers mit der Tastatur erreichbar sein? /
   **EN:** Why must all functions of the order viewer be reachable with the keyboard?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht alle Nutzenden können eine Maus verwenden; Screenreader-Nutzende arbeiten meist mit der Tastatur. Nur wenn jede Funktion (z. B. Position aufklappen) per Tastatur erreichbar ist, bleibt die Oberfläche für alle bedienbar (WCAG 2.2 AA).
   **EN:** Not all users can use a mouse; screen-reader users mostly work with the keyboard. Only if every function (e.g. expanding an order line) is keyboard-reachable does the interface stay operable for everyone (WCAG 2.2 AA).

   </details>

5. **DE:** (DPA) Warum sollte der Viewer nur benötigte Kundenfelder anzeigen? /
   **EN:** (DPA) Why should the viewer show only required customer fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datenminimierung: Je weniger Kundenfelder sichtbar sind, desto kleiner ist der Schaden bei Fehlkonfiguration oder unbefugtem Blick. Man zeigt nur, was für die Aufgabe nötig ist. Zudem sind alle Daten fiktiv (Northwind inkl. `ALFKI`).
   **EN:** Data minimization: the fewer customer fields are visible, the smaller the harm on misconfiguration or unauthorized viewing. You show only what the task needs. Also, all data is fictional (Northwind incl. `ALFKI`).

   </details>

6. **DE:** Warum dürfen Fehlermeldungen keine internen Details oder SQL-Texte zeigen? /
   **EN:** Why must error messages not show internal details or SQL texts?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces, SQL-Texte, interne Pfade oder Verbindungszeichenketten helfen Angreifern und verwirren Nutzende. Eine gute Meldung sagt, was zu tun ist; technische Details gehören ins interne Log.
   **EN:** Stack traces, SQL texts, internal paths, or connection strings help attackers and confuse users. A good message says what to do; technical details belong in the internal log.

   </details>

7. **DE:** (DV) Warum ist es wichtig, wie der Client die Daten der Bestellplattform bezieht? /
   **EN:** (DV) Why does it matter how the client obtains the data from the ordering platform?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Bezugsweg (API-Aufruf, Datei, Datenbank) ist eine Vertrauensgrenze und eine Schnittstelle. Wie er gestaltet ist, bestimmt Zuverlässigkeit, Fehlerverhalten und welche Bestelldaten überhaupt sichtbar werden – das gehört klar beschrieben.
   **EN:** The retrieval path (API call, file, database) is a trust boundary and an interface. Its design determines reliability, error behavior, and which order data becomes visible at all – this must be clearly described.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine klare Informationsstruktur mit Master-Detail (Bestellungen zu Positionen) planen.
- [ ] zwischen CLI und Web-Viewer begründet wählen.
- [ ] angezeigte Kunden- und Bestelldaten als nicht vertrauenswürdig behandeln und encodieren.
- [ ] Tastaturbedienbarkeit und textliche Zustandsangaben sicherstellen.
- [ ] Barrierefreiheit gegen WCAG 2.2 AA als Nachweis dokumentieren.
- [ ] Fehlermeldungen verständlich und harmlos halten (keine SQL-/Internas).

**EN:** I can …

- [ ] plan a clear information structure with master-detail (orders to order lines).
- [ ] choose between CLI and web viewer with a rationale.
- [ ] treat displayed customer and order data as untrusted and encode it.
- [ ] ensure keyboard operability and textual state labels.
- [ ] document accessibility against WCAG 2.2 AA as evidence.
- [ ] keep error messages understandable and harmless (no SQL/internals).

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
