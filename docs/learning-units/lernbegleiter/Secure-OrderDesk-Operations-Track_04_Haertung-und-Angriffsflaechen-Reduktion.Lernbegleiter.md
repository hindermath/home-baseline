# Lernbegleiter: Secure OrderDesk Operations Track 04 – Härtung und Angriffsflächen-Reduktion / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Jeder betriebene Datenbank-Dienst und jede Bestell-/Handelsplattform hat eine **Angriffsfläche**: alle Stellen, an denen ein Angreifer ansetzen könnte – offene Datenbank-Ports, API-Endpunkte, Debug-Funktionen, mitgelieferte Beispieldatenbanken, Standardkonten, weite Dateirechte. Härtung bedeutet, diese Fläche systematisch zu **verkleinern**: Was der Betrieb von Secure OrderDesk nicht braucht, wird abgeschaltet; was bleibt, läuft mit minimalen Rechten und ist durch mehrere Schichten geschützt. Als Systemintegrator*in gehst du nicht punktuell vor („da könnte man was machen"), sondern erst Bestandsaufnahme, dann begründete Entscheidung, dann Nachweis.

**EN:** Every operated database service and every ordering/trading platform has an **attack surface**: all the places an attacker could target – open database ports, API endpoints, debug features, shipped sample databases, default accounts, wide file permissions. Hardening means systematically **shrinking** this surface: what the operation of Secure OrderDesk does not need is disabled; what remains runs with minimal rights and is protected by several layers. As a system integrator you do not proceed ad hoc ("one could do something there"), but first an inventory, then a justified decision, then evidence.

**DE:** In dieser Einheit lernst du, die Angriffsfläche des OrderDesk-Betriebs aufzunehmen, ungenutzte Flächen begründet abzuschalten, das Least-Privilege-Prinzip auf Datenbank-Rollen anzuwenden und für kritische Assets – die Kunden- und Bestelldaten – mindestens zwei unabhängige Schutzschichten (Defense in Depth) vorzusehen. Die in v2 gebaute Plattform mit der Northwind-Datenbasis inkl. Kunde `ALFKI` dient als Beispiel für einen zu härtenden Datenbank-Betrieb. „Microsoft“ ist dabei nur der Herkunftshinweis der Northwind-Beispieldaten.

**EN:** In this unit you learn to inventory the attack surface of the OrderDesk operation, disable unused surfaces with justification, apply the least-privilege principle to database roles, and provide at least two independent protection layers (defense in depth) for critical assets – the customer and order data. The platform built in v2 with the Northwind data base including customer `ALFKI` serves as an example of a database operation to be hardened. "Microsoft" here is only the origin note for the Northwind sample data.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Angriffsfläche / Attack surface | Summe aller Stellen, über die die Plattform oder der Datenbank-Dienst angegriffen werden kann. |
| Härtung / Hardening | Systematisches Verkleinern der Angriffsfläche und Verstärken der Schutzmaßnahmen. |
| Least Privilege / Least privilege | Jede Komponente und jede Datenbank-Rolle erhält nur die minimal nötigen Rechte. |
| Defense in Depth / Defense in depth | Mehrere unabhängige Schutzschichten für ein kritisches Asset wie die Bestelldaten. |
| Angriffsflächen-Bestandsaufnahme / Attack-surface inventory | Vollständige Liste offener Flächen als Ausgangspunkt der Härtung. |
| Beispieldatenbank / Sample database | Mitgelieferte Demo-Datenbank oder Demo-Schema, das im Produktivbetrieb nichts zu suchen hat. |
| Fail-Safe Default / Fail-safe default | Grundzustand, der im Fehler- oder Zweifelsfall sicher (geschlossen) ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Bestandsaufnahme.** Liste zuerst alles auf, was angreifbar sein könnte: offene Datenbank-Ports, API-Endpunkte der Bestellplattform, Health-/Debug-Schnittstellen, Dateirechte, Beispieldatenbanken, Standardkonten (z. B. `sa`, Demo-Logins), Verwaltungszugänge. Ohne vollständige Liste härtest du blind. Die Liste ist der Ausgangszustand, gegen den du jede Maßnahme misst.

**EN:** **Step 1 – Inventory.** First list everything that could be attackable: open database ports, API endpoints of the ordering platform, health/debug interfaces, file permissions, sample databases, default accounts (e.g. `sa`, demo logins), management access. Without a complete list you harden blindly. The list is the baseline against which you measure every measure.

**DE:** **Schritt 2 – Ungenutztes begründet abschalten.** Für jede Fläche fragst du: Wird das im Betrieb von Secure OrderDesk gebraucht? Wenn nein, schalte es ab und dokumentiere die Begründung. Besonders wichtig: mitgelieferte Beispieldatenbanken entfernen, Standardkonten deaktivieren oder umbenennen, Debug-Endpunkte und ausführliche Fehlerausgaben im Produktivprofil ausschalten. Jede Abschaltung ist eine bewusste, belegte Entscheidung.

**EN:** **Step 2 – Disable unused things with justification.** For each surface ask: is this needed in Secure OrderDesk operation? If not, disable it and document the rationale. Especially important: remove shipped sample databases, disable or rename default accounts, turn off debug endpoints and verbose error output in the production profile. Every disabling is a deliberate, evidenced decision.

**DE:** **Schritt 3 – Least Privilege für Datenbank-Rollen.** Prüfe Rechte an allen Stellen: das Datenbank-Konto der Plattform, Dateizugriffe, Netzrechte, Tabellen- und Schema-Rechte. Das Anwendungskonto braucht meist nur Lese-/Schreibrechte auf die Bestell- und Kundentabellen, aber kein `DROP`, kein Schema-Recht und keine Administrationsrolle. Zu weite Rechte sind selbst eine Angriffsfläche, weil ein Fehler oder Missbrauch dann weiter reicht.

**EN:** **Step 3 – Least privilege for database roles.** Check rights everywhere: the platform's database account, file access, network rights, table and schema rights. The application account usually needs only read/write on the order and customer tables, but no `DROP`, no schema rights, and no admin role. Too-wide rights are themselves an attack surface, because an error or misuse then reaches further.

**DE:** **Schritt 4 – Defense in Depth für kritische Assets.** Verlasse dich nicht auf eine einzige Schutzmaßnahme. Für die Kunden- und Bestelldaten planst du mindestens zwei unabhängige Schichten: etwa Least-Privilege-Rolle *und* Netz-Segmentierung, oder Authentisierung am Endpunkt *und* Eingabevalidierung an der Datenzugriffsschicht. Fällt eine Schicht aus, hält die andere. Fehlermeldungen dürfen dabei keine internen Zustände, SQL-Texte oder Verbindungszeichenketten verraten.

**EN:** **Step 4 – Defense in depth for critical assets.** Do not rely on a single protection measure. For the customer and order data you plan at least two independent layers: e.g. a least-privilege role *and* network segmentation, or endpoint authentication *and* input validation at the data-access layer. If one layer fails, the other holds. Error messages must not reveal internal state, SQL text, or connection strings.

**DE:** **Schritt 5 – Je Maßnahme einen Nachweis.** Jede Härtungsentscheidung erhält einen Beleg: Konfig-Diff, Portscan, Rechte-Auflistung, Fehler-Test ohne Stack-Trace oder eine 404-Testabfrage auf einen abgeschalteten Endpunkt. So entsteht eine Abschalt-Matrix mit Begründung. Restrisiken werden als `Open` mit Folgeaktion notiert, nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung.

**EN:** **Step 5 – One evidence entry per measure.** Every hardening decision gets a proof: a config diff, a port scan, a rights listing, an error test without a stack trace, or a 404 test query against a disabled endpoint. This builds a disabling matrix with justification. Residual risks are recorded as `Open` with a follow-up, non-applicable standards as `N/A` with a short technical justification.

**DE:** **Typische Fehler.** Härten ohne Bestandsaufnahme. Beispieldatenbanken oder Standardkonten im Produktivbetrieb vergessen. Debug-Endpunkte offen lassen. Fehlermeldungen mit SQL-Text, Tabellennamen oder Verbindungszeichenketten. Dem Anwendungskonto Adminrechte geben. Sich auf eine einzige Schutzschicht verlassen. Abschaltungen nicht dokumentieren, sodass später niemand weiß, ob etwas absichtlich oder versehentlich fehlt.

**EN:** **Common mistakes.** Hardening without an inventory. Forgetting sample databases or default accounts in production. Leaving debug endpoints open. Error messages with SQL text, table names, or connection strings. Giving the application account admin rights. Relying on a single protection layer. Not documenting disablings, so later nobody knows whether something is missing deliberately or by accident.

### Beispiel / Example

```text
Fläche                 | Gebraucht? | Maßnahme                          | Nachweis
-----------------------|------------|-----------------------------------|---------------------------
Northwind-Demo-Schema  | nein       | im Produktivbetrieb entfernt      | Schema-Liste ohne Demo
Standardkonto (sa/demo)| nein       | deaktiviert / umbenannt           | Konten-Auflistung
Debug-/Diagnose-Endpunkt| nein      | im Produktivprofil deaktiviert    | Konfig-Diff + Testabfrage 404
Verbose-Fehlerausgabe  | nein       | generische Fehlermeldung          | Fehler-Test ohne SQL/Stack
Datenbank-Port         | ja         | nur intern + Auth + TLS           | Portscan + Auth-Test
App-DB-Konto Rechte    | eng        | nur SELECT/INSERT/UPDATE Bestellungen | Rechte-Auflistung
Kritisch: Kunden-/Bestelldaten | -  | Defense in Depth: Rolle + Netz-Segmentierung (2 Schichten)
Restrisiko/Open:       | verbleibende Punkte als Open mit Folgeaktion notiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Härtung und Angriffsflächen-Reduktion sichern den laufenden, vernetzten Datenbank- und Bestellbetrieb ab. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf der Kunden- und Bestelldaten entscheidet, welche Assets Defense in Depth brauchen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Angriffsfläche reduzieren, Least Privilege, Fail-Safe Defaults, Defense in Depth und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung/Rechte), `CL_08` (Sicherheits-Review), `CL_11` (Bedrohungen/Härtung) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Nur benötigte Flächen bleiben offen, jede läuft rechtearm, und die Kunden- und Bestelldaten sind mehrschichtig geschützt.* A11Y-Aspekt: Die Bestandsaufnahme und die Abschalt-Matrix müssen als Text-Tabelle mit gleich breiten Spalten lesbar sein, nicht nur als Screenshot, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: attack-surface reduction, least privilege, fail-safe defaults, defense in depth, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (access control/rights), `CL_08` (security review), `CL_11` (threats/hardening), and `CL_12` (documentation/N-A). The security decision of this unit is: *only needed surfaces stay open, each runs low-privilege, and the customer and order data are protected in multiple layers.* Accessibility aspect: the inventory and the disabling matrix must be readable as a text table with equal-width columns, not only as a screenshot, so they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum beginnt Härtung mit einer Bestandsaufnahme der Angriffsfläche? /
   **EN:** Why does hardening begin with an inventory of the attack surface?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne vollständige Liste härtet man blind und übersieht Flächen wie einen offenen Datenbank-Port oder ein Demo-Schema. Die Bestandsaufnahme ist der Ausgangszustand, gegen den man Maßnahmen misst und im Audit nachweist, dass geprüft wurde.
   **EN:** Without a complete list you harden blindly and miss surfaces such as an open database port or a demo schema. The inventory is the baseline against which you measure measures and prove in an audit that a check happened.

   </details>

2. **DE:** (SI) Warum gehören Beispieldatenbanken und Standardkonten im Produktivbetrieb entfernt oder deaktiviert? /
   **EN:** (SI) Why must sample databases and default accounts be removed or disabled in production?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sind allgemein bekannt und oft schwach geschützt (Standardpasswörter, weite Rechte). Ein Angreifer kennt Demo-Konten und Demo-Schemata und nutzt sie als Einstieg. Im Betrieb sind sie unnötige Angriffsfläche und werden abgeschaltet oder entfernt.
   **EN:** They are widely known and often weakly protected (default passwords, wide rights). An attacker knows demo accounts and demo schemas and uses them as an entry point. In operation they are unnecessary attack surface and are disabled or removed.

   </details>

3. **DE:** (SI) Was bedeutet Defense in Depth für die Kunden- und Bestelldaten und warum reicht eine Schutzschicht nicht? /
   **EN:** (SI) What does defense in depth mean for the customer and order data, and why is one layer not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Defense in Depth heißt mehrere unabhängige Schichten, z. B. eine Least-Privilege-Rolle *und* Netz-Segmentierung. Fällt eine aus (Fehler, Umgehung), hält die andere. Eine einzige Schicht ist ein Single Point of Failure; kritische Assets wie Kunden- und Bestelldaten brauchen mindestens zwei.
   **EN:** Defense in depth means several independent layers, e.g. a least-privilege role *and* network segmentation. If one fails (error, bypass), the other holds. A single layer is a single point of failure; critical assets like customer and order data need at least two.

   </details>

4. **DE:** Wie hängt Least Privilege am Datenbank-Konto mit der Angriffsfläche zusammen? /
   **EN:** How is least privilege on the database account connected to the attack surface?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Anwendungskonto mit Adminrechten kann bei Missbrauch Tabellen löschen oder das Schema ändern. Beschränkt man es auf die nötigen Lese-/Schreibrechte an den Bestelltabellen, begrenzt man den möglichen Schaden und verkleinert die Fläche.
   **EN:** An application account with admin rights can, if misused, drop tables or change the schema. Restricting it to the necessary read/write on the order tables limits the possible damage and shrinks the surface.

   </details>

5. **DE:** (DV) Wie entscheidest du, welche Datenbank-Ports und Netzpfade offen bleiben dürfen? /
   **EN:** (DV) How do you decide which database ports and network paths may stay open?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die, die der Betrieb nachweislich braucht, mit dokumentierter Richtung und Zweck. Der Datenbank-Port bleibt idealerweise nur intern erreichbar, authentisiert und über TLS. Alles andere bleibt zu; offene Ports werden mit einem Portscan geprüft und begründet.
   **EN:** Only those the operation demonstrably needs, with documented direction and purpose. The database port ideally stays reachable only internally, authenticated and over TLS. Everything else stays closed; open ports are checked with a port scan and justified.

   </details>

6. **DE:** (DPA) Welche Datenexposition der Kunden-/Bestelldaten wird durch Härtung reduziert? /
   **EN:** (DPA) Which exposure of customer/order data is reduced by hardening?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Härtung schließt Wege, über die Kunden- oder Bestelldaten (z. B. `ALFKI`) ungewollt abfließen könnten: offene Endpunkte, Debug-Ausgaben, zu weite Rechte, verbose Fehler mit SQL-Text. Die Daten sind fiktiv (Northwind), aber das Muster gilt: weniger offene Flächen bedeuten weniger Exposition.
   **EN:** Hardening closes paths through which customer or order data (e.g. `ALFKI`) could leak unintentionally: open endpoints, debug output, too-wide rights, verbose errors with SQL text. The data is fictional (Northwind), but the pattern holds: fewer open surfaces mean less exposure.

   </details>

7. **DE:** Warum wird jede Abschaltung dokumentiert und mit Nachweis belegt? /
   **EN:** Why is every disabling documented and backed by evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit später nachvollziehbar ist, dass eine Fläche absichtlich zu ist und nicht versehentlich fehlt. Ein Nachweis (Konfig-Diff, Testabfrage, Rechte-Auflistung) zeigt, dass die Maßnahme wirkt. Restrisiken werden als `Open` mit Folgeaktion und nicht Anwendbares als `N/A` mit Begründung notiert.
   **EN:** So it is later traceable that a surface is closed on purpose and not missing by accident. Evidence (a config diff, a test query, a rights listing) shows the measure works. Residual risks are recorded as `Open` with a follow-up and non-applicable items as `N/A` with a rationale.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Angriffsfläche des Datenbank-Betriebs und der Bestellplattform vollständig aufnehmen.
- [ ] ungenutzte Flächen wie Beispieldatenbanken, Standardkonten und Debug-Endpunkte begründet abschalten.
- [ ] Least Privilege auf Datenbank-Rollen, Dateien und Netz anwenden.
- [ ] für die Kunden- und Bestelldaten mindestens zwei unabhängige Schutzschichten planen.
- [ ] je Maßnahme einen Nachweis führen.
- [ ] Restrisiken als `Open` und nicht Anwendbares als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] fully inventory the attack surface of the database operation and the ordering platform.
- [ ] disable unused surfaces like sample databases, default accounts, and debug endpoints with justification.
- [ ] apply least privilege to database roles, files, and network.
- [ ] plan at least two independent protection layers for customer and order data.
- [ ] keep one evidence entry per measure.
- [ ] record residual risks as `Open` and non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
