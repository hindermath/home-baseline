# Lernbegleiter: Secure ServiceHarvester Operations Track 04 – Härtung und Angriffsflächen-Reduktion / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Jeder betriebene Dienst hat eine **Angriffsfläche**: alle Stellen, an denen ein Angreifer ansetzen
könnte – offene Ports, Endpunkte, Debug-Funktionen, weite Dateirechte, ungenutzte Zusatzdienste. Härtung
bedeutet, diese Fläche systematisch zu **verkleinern**: Was nicht gebraucht wird, wird abgeschaltet; was
bleibt, läuft mit minimalen Rechten und ist durch mehrere Schichten geschützt. Als Systemintegrator*in gehst
du dabei nicht punktuell vor („da könnte man was machen"), sondern erst Bestandsaufnahme, dann begründete
Entscheidung, dann Nachweis.

**EN:** Every operated service has an **attack surface**: all the places an attacker could target – open
ports, endpoints, debug features, wide file permissions, unused extra services. Hardening means
systematically **shrinking** this surface: what is not needed is disabled; what remains runs with minimal
rights and is protected by several layers. As a system integrator you do not proceed ad hoc ("one could do
something there"), but first an inventory, then a justified decision, then evidence.

**DE:** In dieser Einheit lernst du, die Angriffsfläche des ServiceHarvester aufzunehmen, ungenutzte Flächen
begründet abzuschalten, das Least-Privilege-Prinzip anzuwenden und für kritische Werte mindestens zwei
unabhängige Schutzschichten (Defense in Depth) vorzusehen. Die C#-Referenz `InventarWorkerService` dient als
Beispiel für einen zu härtenden Dienst.

**EN:** In this unit you learn to inventory the attack surface of the ServiceHarvester, disable unused
surfaces with justification, apply the least-privilege principle, and provide at least two independent
protection layers (defense in depth) for critical values. The C# reference `InventarWorkerService` serves as
an example of a service to be hardened.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Angriffsfläche / Attack surface | Summe aller Stellen, über die ein System angegriffen werden kann. |
| Härtung / Hardening | Systematisches Verkleinern der Angriffsfläche und Verstärken der Schutzmaßnahmen. |
| Least Privilege / Least privilege | Jede Komponente erhält nur die minimal nötigen Rechte. |
| Defense in Depth / Defense in depth | Mehrere unabhängige Schutzschichten für ein kritisches Asset. |
| Angriffsflächen-Bestandsaufnahme / Attack-surface inventory | Vollständige Liste offener Flächen als Ausgangspunkt der Härtung. |
| Fail-Safe Default / Fail-safe default | Grundzustand, der im Fehler- oder Zweifelsfall sicher (geschlossen) ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Bestandsaufnahme.** Liste zuerst alles auf, was angreifbar sein könnte: offene Ports,
Netzwerk-Endpunkte, Health-/Debug-Schnittstellen, Dateirechte, mitinstallierte Zusatzdienste, Konfigurations-
und Verwaltungszugänge. Ohne vollständige Liste härtest du blind. Die Liste ist der Ausgangszustand, gegen den
du Maßnahmen misst.

**EN:** **Step 1 – Inventory.** First list everything that could be attackable: open ports, network
endpoints, health/debug interfaces, file permissions, co-installed extra services, configuration and
management access. Without a complete list you harden blindly. The list is the baseline against which you
measure measures.

**DE:** **Schritt 2 – Ungenutztes begründet abschalten.** Für jede Fläche fragst du: Wird das im Betrieb
gebraucht? Wenn nein, schalte es ab und dokumentiere die Begründung. Besonders wichtig: Debug-Endpunkte,
ausführliche Fehlerausgaben und Test-Hintertüren gehören im Produktivbetrieb aus. Jede Abschaltung ist eine
bewusste, belegte Entscheidung.

**EN:** **Step 2 – Disable unused things with justification.** For each surface ask: is this needed in
operation? If not, disable it and document the rationale. Especially important: debug endpoints, verbose error
output, and test back doors must be off in production. Every disabling is a deliberate, evidenced decision.

**DE:** **Schritt 3 – Least Privilege anwenden.** Prüfe Rechte an allen Stellen: Dienstkonto, Dateizugriffe,
Netzrechte, Datenbankrechte. Jede Komponente bekommt nur, was sie braucht. Zu weite Rechte sind selbst eine
Angriffsfläche, weil ein Fehler oder Missbrauch weiter reicht.

**EN:** **Step 3 – Apply least privilege.** Check rights everywhere: service account, file access, network
rights, database rights. Each component gets only what it needs. Too-wide rights are themselves an attack
surface because an error or misuse reaches further.

**DE:** **Schritt 4 – Defense in Depth für kritische Assets.** Verlasse dich nicht auf eine einzige Schutz-
maßnahme. Für kritische Werte (z. B. gesammelte Statusdaten, Secrets) planst du mindestens zwei unabhängige
Schichten: etwa Rechteschutz *und* Validierung, oder Netz-Segmentierung *und* Authentisierung. Fällt eine
Schicht aus, hält die andere. Fehlermeldungen dürfen dabei keine internen Zustände verraten.

**EN:** **Step 4 – Defense in depth for critical assets.** Do not rely on a single protection measure. For
critical values (e.g. collected status data, secrets) you plan at least two independent layers: e.g.
permission protection *and* validation, or network segmentation *and* authentication. If one layer fails, the
other holds. Error messages must not reveal internal state.

**DE:** **Typische Fehler.** Härten ohne Bestandsaufnahme. Debug-Endpunkte im Betrieb offen lassen.
Fehlermeldungen mit Stack-Traces oder Verbindungszeichenketten. Sich auf eine einzige Schutzschicht verlassen.
Abschaltungen nicht dokumentieren, sodass später niemand weiß, ob etwas absichtlich oder versehentlich fehlt.

**EN:** **Common mistakes.** Hardening without an inventory. Leaving debug endpoints open in operation. Error
messages with stack traces or connection strings. Relying on a single protection layer. Not documenting
disablings, so later nobody knows whether something is missing deliberately or by accident.

### Beispiel / Example

```text
Fläche               | Gebraucht? | Maßnahme                       | Nachweis
---------------------|------------|--------------------------------|---------------------------
Debug-Endpunkt       | nein       | im Produktivprofil deaktiviert | Konfig-Diff + Testabfrage 404
Verbose-Fehlerausgabe| nein       | generische Fehlermeldung       | Fehler-Test ohne Stack-Trace
Verwaltungs-Port     | ja         | nur lokal + Authentisierung    | Portscan + Auth-Test
Datei-Schreibrechte  | eng        | nur Datenordner, Dienstkonto   | Rechte-Auflistung
Kritisch: Statusdaten| -          | Defense in Depth: Rechte + Validierung (2 Schichten)
Restrisiko/Open:     | verbleibende Punkte als Open mit Folgeaktion notiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Härtung und Angriffsflächen-Reduktion sichern den laufenden, vernetzten Dienst ab. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf entscheidet, welche Assets Defense in Depth brauchen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Angriffsfläche reduzieren, Least Privilege, Defense in Depth
und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung),
`CL_08` (Sicherheits-Review), `CL_11` (Bedrohungen/Härtung) und `CL_12` (Dokumentation/N-A). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nur benötigte Flächen bleiben offen, jede läuft rechtearm, und
kritische Assets sind mehrschichtig geschützt.* A11Y-Aspekt: Die Bestandsaufnahme muss als Text-Tabelle mit
gleich breiten Spalten lesbar sein, damit sie mit Screenreader und Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: attack-surface reduction, least privilege, defense in
depth, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (access
control), `CL_08` (security review), `CL_11` (threats/hardening), and `CL_12` (documentation/N-A). The
security decision of this unit is: *only needed surfaces stay open, each runs low-privilege, and critical
assets are protected in multiple layers.* Accessibility aspect: the inventory must be readable as a text table
with equal-width columns, so it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum beginnt Härtung mit einer Bestandsaufnahme der Angriffsfläche? /
   **EN:** Why does hardening begin with an inventory of the attack surface?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne vollständige Liste härtet man blind und übersieht Flächen. Die Bestandsaufnahme ist der
   Ausgangszustand, gegen den man Maßnahmen misst und im Audit nachweist, dass geprüft wurde.
   **EN:** Without a complete list you harden blindly and miss surfaces. The inventory is the baseline against
   which you measure measures and prove in an audit that a check happened.

   </details>

2. **DE:** (SI) Warum gehören Debug-Endpunkte und verbose Fehlerausgaben im Produktivbetrieb aus? /
   **EN:** (SI) Why must debug endpoints and verbose error output be off in production?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie geben Angreifern interne Informationen (Zustände, Pfade, Stack-Traces) und bieten zusätzliche
   Einstiegspunkte. Im Betrieb sind sie unnötige Angriffsfläche; Fehlermeldungen sollen generisch bleiben.
   **EN:** They give attackers internal information (state, paths, stack traces) and offer extra entry points.
   In operation they are unnecessary attack surface; error messages should stay generic.

   </details>

3. **DE:** (SI) Was bedeutet Defense in Depth und warum reicht eine Schutzschicht nicht? /
   **EN:** (SI) What does defense in depth mean and why is one protection layer not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Defense in Depth heißt mehrere unabhängige Schutzschichten. Fällt eine aus (Fehler, Umgehung), hält
   die andere. Eine einzige Schicht ist ein Single Point of Failure; kritische Assets brauchen mindestens zwei.
   **EN:** Defense in depth means several independent protection layers. If one fails (error, bypass), the
   other holds. A single layer is a single point of failure; critical assets need at least two.

   </details>

4. **DE:** Wie hängt Least Privilege mit der Angriffsfläche zusammen? /
   **EN:** How is least privilege connected to the attack surface?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu weite Rechte sind selbst Angriffsfläche: Ein Fehler oder Missbrauch reicht weiter, wenn eine
   Komponente mehr darf als nötig. Minimale Rechte begrenzen den möglichen Schaden und verkleinern die Fläche.
   **EN:** Too-wide rights are themselves attack surface: an error or misuse reaches further if a component may
   do more than needed. Minimal rights limit the possible damage and shrink the surface.

   </details>

5. **DE:** (DV) Wie entscheidest du, welche Ports und Netzpfade offen bleiben dürfen? /
   **EN:** (DV) How do you decide which ports and network paths may stay open?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die, die der Betrieb nachweislich braucht, mit dokumentierter Richtung und Zweck. Alles andere
   bleibt zu. Offene Ports werden mit einem Portscan geprüft und mit dem benötigten Zweck begründet.
   **EN:** Only those the operation demonstrably needs, with documented direction and purpose. Everything else
   stays closed. Open ports are checked with a port scan and justified by the required purpose.

   </details>

6. **DE:** Warum wird jede Abschaltung dokumentiert und mit Nachweis belegt? /
   **EN:** Why is every disabling documented and backed by evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit später nachvollziehbar ist, dass eine Fläche absichtlich zu ist und nicht versehentlich
   fehlt. Ein Nachweis (z. B. Testabfrage, Konfig-Diff) zeigt, dass die Maßnahme wirkt. Restrisiken werden als
   `Open` mit Folgeaktion notiert.
   **EN:** So it is later traceable that a surface is closed on purpose and not missing by accident. Evidence
   (e.g. a test query, a config diff) shows the measure works. Residual risks are recorded as `Open` with a
   follow-up.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Angriffsfläche des Dienstes vollständig aufnehmen.
- [ ] ungenutzte Flächen begründet abschalten und die Maßnahme nachweisen.
- [ ] Least Privilege an Konto, Dateien und Netz anwenden.
- [ ] für kritische Assets mindestens zwei unabhängige Schutzschichten planen.
- [ ] Restrisiken als `Open` und nicht Anwendbares als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] fully inventory the service's attack surface.
- [ ] disable unused surfaces with justification and evidence the measure.
- [ ] apply least privilege to account, files, and network.
- [ ] plan at least two independent protection layers for critical assets.
- [ ] record residual risks as `Open` and non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
