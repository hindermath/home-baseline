# Lernbegleiter: Secure OrderDesk Operations Track 09 – Sandbox-Isolation und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Handelsplattform Secure OrderDesk verarbeitet Bestellungen und greift dauerhaft auf eine
relationale Datenbank (Northwind-Layout inkl. Kunde `ALFKI`) zu. Ein laufender Bestelldienst ist ein
lohnendes Ziel: Fällt er in falsche Hände oder enthält er einen Fehler, soll der Schaden begrenzt bleiben.
Dafür sorgt **Isolation**: Die Plattform läuft in einer abgegrenzten Umgebung, einer **Sandbox**, mit
möglichst wenigen Rechten. Sie darf nur die Pfade lesen und schreiben, die sie wirklich braucht, und nur die
Netzwege nutzen, die erlaubt sind – vor allem die eine Verbindung zur Bestelldatenbank. So bleibt die
**Angriffsfläche** klein. Zusätzlich braucht der Betrieb **Nachweise**: Belege, dass die Plattform sauber
startet, gesund läuft und geordnet stoppt.

**EN:** The Secure OrderDesk trading platform processes orders and continuously accesses a relational database
(Northwind layout incl. customer `ALFKI`). A running order service is a worthwhile target: if it falls into the
wrong hands or contains a flaw, the damage should stay limited. **Isolation** ensures this: the platform runs in
a delimited environment, a **sandbox**, with as few privileges as possible. It may only read and write the paths
it really needs and use only the network paths that are allowed – above all the single connection to the order
database. This keeps the **attack surface** small. In addition, operation needs **evidence**: proof that the
platform starts cleanly, runs healthily, and stops in an orderly way.

**DE:** In dieser Einheit lernst du, ein Isolationsprofil zu beschreiben (Mounts, Schreibgrenzen, Netzregeln
inkl. Datenbankverbindung), Least Privilege umzusetzen, Secret-Regeln für die Datenbank-Verbindungszeichenkette
zu benennen und Betriebsnachweise zu führen. Als öffentliche Referenz dient die `absdd-image-sandbox`; als
C#-Referenz `InventarWorkerService`. Die Idee bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar. Die
Einheit isoliert die Artefakte aus Einheit 06 und liefert Nachweise für das Betriebs-Review in Einheit 10.

**EN:** In this unit you learn to describe an isolation profile (mounts, write boundaries, network rules incl.
database connection), implement least privilege, name secret rules for the database connection string, and keep
operational evidence. The public reference is the `absdd-image-sandbox`; the C# reference is
`InventarWorkerService`. The idea stays comparable across C#, Go, Java, Python, Rust, and Swift. The unit
isolates the artifacts from unit 06 and delivers evidence for the operations review in unit 10.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox / Sandbox | Abgegrenzte Umgebung, in der die Bestellplattform mit begrenzten Rechten läuft. |
| Isolation / Isolation | Trennung der Plattform von der übrigen Umgebung, um Schaden zu begrenzen. |
| Least Privilege / Least privilege | Grundsatz: nur die wirklich nötigen Rechte, Pfade und DB-Berechtigungen vergeben. |
| Mount / Mount | Ein in die Sandbox eingebundener Pfad, meist mit Lese- oder Schreibgrenze. |
| Datenbankverbindung / Database connection | Erlaubter Netzweg zur Bestelldatenbank (Northwind inkl. `ALFKI`). |
| Angriffsfläche / Attack surface | Summe aller Wege, über die ein Angreifer eindringen könnte. |
| Fail-Safe Default / Fail-safe default | Standard: verweigern; nur explizit Erlaubtes ist zugelassen. |
| Betriebsnachweis / Operational evidence | Beleg, dass Start, Health und Stopp der Plattform geordnet funktionieren. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Isolationsprofil beschreiben.** Lege fest, welche Pfade die Plattform braucht (Mounts)
und ob sie sie lesen oder schreiben darf. Trenne Daten, Konfiguration und Logs. Was nicht gebraucht wird, wird
nicht eingebunden. So sieht man auf einen Blick, worauf die Bestellplattform überhaupt zugreifen kann.

**EN:** **Step 1 – Describe the isolation profile.** Define which paths the platform needs (mounts) and whether
it may read or write them. Separate data, configuration, and logs. What is not needed is not mounted. This shows
at a glance what the order platform can access at all.

**DE:** **Schritt 2 – Least Privilege umsetzen.** Die Plattform läuft nicht als Administrator, sondern mit einem
eigenen, schwach berechtigten Konto. Der Netzzugriff wird auf das Nötige begrenzt: erlaubt ist die eine
Verbindung zur Bestelldatenbank, sonst nichts (Fail-Safe: alles verboten, außer erlaubt). Auch die
Datenbank-Berechtigungen bleiben minimal – nur die Tabellen und Operationen, die der Bestellbetrieb wirklich
braucht. Weniger Rechte bedeuten weniger möglichen Schaden.

**EN:** **Step 2 – Implement least privilege.** The platform does not run as administrator but with its own,
low-privileged account. Network access is limited to what is necessary: allowed is the single connection to the
order database, nothing else (fail-safe: everything forbidden except what is allowed). Database permissions too
stay minimal – only the tables and operations the order operation really needs. Fewer privileges mean less
possible damage.

**DE:** **Schritt 3 – Secret-Regeln benennen.** Die Datenbank-Verbindungszeichenkette und andere Zugangsdaten
gehören nie in Code, Config oder Logs innerhalb der Sandbox. Im Text stehen nur Platzhalter
`<PLATZHALTER-KEIN-ECHTER-WERT>`; echte Werte kommen aus einem Secret-Store. So kann ein veröffentlichter
Nachweis kein echtes Geheimnis und keinen Datenbankzugang verraten.

**EN:** **Step 3 – Name secret rules.** The database connection string and other credentials never belong in
code, config, or logs inside the sandbox. The text contains only placeholders `<PLATZHALTER-KEIN-ECHTER-WERT>`;
real values come from a secret store. This way a published piece of evidence can leak no real secret and no
database access.

**DE:** **Schritt 4 – Betriebsnachweise führen.** Belege, dass die Plattform in der Sandbox sauber startet, die
Datenbankverbindung aufbaut, einen Health-Zustand meldet und auf ein Stopp-Signal geordnet endet. Diese
Nachweise zeigen, dass Isolation und Betrieb wirklich funktionieren – nicht nur behauptet werden. Ist praktische
Sandbox-Nutzung am Ausbildungsplatz noch nicht möglich, wird dies als `N/A` mit Begründung dokumentiert.

**EN:** **Step 4 – Keep operational evidence.** Prove that the platform starts cleanly in the sandbox, opens the
database connection, reports a health state, and ends in an orderly way on a stop signal. This evidence shows
that isolation and operation really work – not just claimed. If practical sandbox use is not yet possible at the
training site, this is documented as `N/A` with a rationale.

**DE:** **Schritt 5 – Sprachneutral halten und `N/A` begründen.** Das Isolations- und Nachweisprofil bleibt für
C#, Go, Java, Python, Rust und Swift vergleichbar. Eine MSL-Support-Matrix je Sprache darf ergänzt werden, muss
aber begründet werden; MSL-Status ersetzt keine Isolation, keine Rechtebeschränkung und keine Betriebsprüfung.

**EN:** **Step 5 – Keep it language-neutral and justify `N/A`.** The isolation and evidence profile stays
comparable across C#, Go, Java, Python, Rust, and Swift. A per-language MSL support matrix may be added but must
be justified; MSL status replaces neither isolation, privilege restriction, nor operational verification.

**DE:** **Typische Fehler.** Die Plattform mit vollen Rechten laufen lassen. Alle Pfade schreibbar einbinden.
Netzzugriff pauschal erlauben statt nur die Bestelldatenbank. Die Verbindungszeichenkette in Config oder Logs
ablegen. Behaupten, der Betrieb sei sicher, ohne Start-, Health- und Shutdown-Nachweis. Nichtnutzung der Sandbox
stillschweigend weglassen statt als `N/A` zu begründen.

**EN:** **Common mistakes.** Running the platform with full privileges. Mounting all paths as writable. Allowing
network access broadly instead of only the order database. Storing the connection string in config or logs.
Claiming operation is safe without start, health, and shutdown evidence. Silently omitting non-use of the sandbox
instead of justifying it as `N/A`.

### Beispiel / Example

```text
Mounts:          /data (rw), /config (ro), /logs (rw); alles andere nicht eingebunden
Netz:            nur ausgehend zur Bestelldatenbank erlaubt; sonst alles verboten (Fail-Safe)
Least Privilege: eigenes schwaches Dienstkonto, kein Administrator; minimale DB-Rechte
Datenbank:       Northwind inkl. ALFKI; nur benötigte Tabellen/Operationen
Secrets:         Verbindungszeichenkette nur als <PLATZHALTER-KEIN-ECHTER-WERT>; echte Werte im Secret-Store
Betriebsnachweis: Start-Log + DB-Verbindung ok + Health = ok + geordneter Shutdown auf Stopp-Signal
Referenz:        absdd-image-sandbox (public);  C#-Referenz InventarWorkerService
N/A-Fall:        praktische Sandbox am Ausbildungsplatz noch nicht moeglich -> N/A mit Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Professional Tracks", Operations Track SI). Für die Sandbox- und Isolationseinordnung ist
**LF 11b** primär, weil Isolation, Least Privilege und Betriebsnachweise Sicherheitsmaßnahmen des laufenden
Betriebs sind; **LF 9** ist berührt, weil die kontrollierte Bereitstellung der isolierten Plattform die
Dienstbereitstellung betrifft.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section
"Secure OrderDesk Professional Tracks", Operations Track SI). For the sandbox and isolation classification
**LF 11b** is primary, because isolation, least privilege, and operational evidence are security measures of the
running operation; **LF 9** is touched, because the controlled provisioning of the isolated platform concerns
service provisioning.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Isolation, Least Privilege und Betriebsnachweise sichern die laufende Bestellplattform. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Die isolierte Plattform wird kontrolliert bereitgestellt und betrieben. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Isolation, Least Privilege, Angriffsflächen-Reduktion,
Fail-Safe Defaults und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07`
(sichere Konfiguration), `CL_08` (Sicherheits-Review), `CL_09` (Umgebung/Reproduzierbarkeit) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Die Bestellplattform läuft mit
minimalen Rechten in einer Sandbox; alles ist verboten außer explizit erlaubt (inkl. der einen
Datenbankverbindung); Betrieb gilt nur mit Start-, Health- und Shutdown-Nachweis als belegt.* A11Y-Aspekt:
Isolationsprofil, Mount- und Netzregeln werden als klare Textliste dokumentiert, ohne reine Farbmarkierung,
damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: isolation, least privilege, attack-surface reduction,
fail-safe defaults, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_07`
(secure configuration), `CL_08` (security review), `CL_09` (environment/reproducibility), and `CL_12`
(documentation/N-A). The security decision of this unit is: *the order platform runs with minimal privileges in
a sandbox; everything is forbidden except what is explicitly allowed (incl. the single database connection);
operation is only evidenced with start, health, and shutdown proof.* Accessibility aspect: isolation profile,
mount and network rules are documented as a clear text list, without color-only marking, so they stay usable
with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Least Privilege und warum verkleinert es den Schaden? /
   **EN:** What does least privilege mean and why does it reduce damage?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Least Privilege heißt, nur die wirklich nötigen Rechte, Pfade und Datenbank-Berechtigungen zu
   vergeben. Wird die Plattform kompromittiert, kann ein Angreifer nur das erreichen, wozu sie ohnehin
   berechtigt ist – der Schaden bleibt begrenzt.
   **EN:** Least privilege means granting only the truly necessary privileges, paths, and database permissions.
   If the platform is compromised, an attacker can only reach what it is authorized for anyway – the damage
   stays limited.

   </details>

2. **DE:** Warum wird die Angriffsfläche durch Isolation kleiner? /
   **EN:** Why does isolation make the attack surface smaller?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Isolation bindet nur nötige Pfade ein und erlaubt nur nötige Netzwege, etwa die eine
   Datenbankverbindung. Je weniger zugänglich ist, desto weniger Wege gibt es, über die ein Angreifer eindringen
   oder Bestelldaten abziehen kann.
   **EN:** Isolation mounts only necessary paths and allows only necessary network paths, such as the single
   database connection. The less is accessible, the fewer ways there are for an attacker to enter or exfiltrate
   order data.

   </details>

3. **DE:** (SI) Was bedeutet ein Fail-Safe Default für Netz- und Dateizugriff? /
   **EN:** (SI) What does a fail-safe default mean for network and file access?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Standardmäßig ist alles verboten; nur explizit Erlaubtes ist zugelassen, etwa die Verbindung zur
   Bestelldatenbank. Fehlt eine Regel, gilt „verweigern", nicht „erlauben". So entsteht keine Lücke durch
   Vergessen.
   **EN:** By default everything is forbidden; only what is explicitly allowed is permitted, such as the
   connection to the order database. If a rule is missing, "deny" applies, not "allow". This prevents a gap
   through forgetting.

   </details>

4. **DE:** (SI) Welche Betriebsnachweise zeigen, dass die isolierte Plattform wirklich sauber läuft? /
   **EN:** (SI) Which operational evidence shows that the isolated platform really runs cleanly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Start-Nachweis, ein Beleg für den Aufbau der Datenbankverbindung, ein gemeldeter Health-Zustand
   während des Laufs und ein Nachweis über einen geordneten Shutdown auf ein Stopp-Signal. Erst diese Belege
   machen den Betrieb prüfbar.
   **EN:** A start proof, proof of the database connection being established, a reported health state during the
   run, and proof of an orderly shutdown on a stop signal. Only these make operation verifiable.

   </details>

5. **DE:** (SI) Warum darf die Datenbank-Verbindungszeichenkette nicht in Config oder Logs stehen? /
   **EN:** (SI) Why must the database connection string not be in config or logs?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Config und Logs werden oft ausgelesen, kopiert oder als Nachweis veröffentlicht. Landet die
   Verbindungszeichenkette dort, ist der Datenbankzugang schnell in fremden Händen. Deshalb: nur Platzhalter,
   echte Werte im Secret-Store.
   **EN:** Config and logs are often read, copied, or published as evidence. If the connection string ends up
   there, the database access quickly falls into the wrong hands. Therefore: only placeholders, real values in
   the secret store.

   </details>

6. **DE:** (DPA) Welche Kunden- oder Bestelldaten dürfen die Sandbox verlassen und welche nicht? /
   **EN:** (DPA) Which customer or order data may leave the sandbox and which may not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Grundsätzlich verlassen keine Roh- oder Kundendaten unnötig die Sandbox; erlaubt sind nur die
   nötigen, geprüften Ausgaben. Die Testdaten sind ohnehin fiktiv (Northwind inkl. `ALFKI`), trotzdem gilt das
   Prinzip „nur was nötig ist, verlässt die Grenze".
   **EN:** In principle no raw or customer data leaves the sandbox unnecessarily; only the required, checked
   outputs are allowed. The test data is fictional anyway (Northwind incl. `ALFKI`), yet the principle "only
   what is necessary leaves the boundary" still applies.

   </details>

7. **DE:** (SI) Wie dokumentierst du, wenn eine praktische Sandbox-Nutzung noch nicht möglich ist? /
   **EN:** (SI) How do you document when practical sandbox use is not yet possible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung und einer Folgeaktion, nicht durch stilles Weglassen. So
   bleibt sichtbar, dass die Sandbox geprüft wurde und warum sie hier noch nicht genutzt wird.
   **EN:** As `N/A` with a short technical rationale and a follow-up action, not by silent omission. This keeps
   visible that the sandbox was considered and why it is not yet used here.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein Isolationsprofil mit Mounts, Schreibgrenzen und Netzregeln inkl. Datenbankverbindung beschreiben.
- [ ] Least Privilege für die laufende Bestellplattform umsetzen.
- [ ] einen Fail-Safe Default für Netz- und Dateizugriff erklären.
- [ ] Secret-Regeln für die Verbindungszeichenkette mit Platzhaltern statt echten Werten anwenden.
- [ ] Betriebsnachweise (Start, DB-Verbindung, Health, Shutdown) benennen.
- [ ] `N/A`-Fälle der Sandbox-Nutzung begründen und sprachneutral bleiben.

**EN:** I can …

- [ ] describe an isolation profile with mounts, write boundaries, and network rules incl. database connection.
- [ ] implement least privilege for the running order platform.
- [ ] explain a fail-safe default for network and file access.
- [ ] apply secret rules for the connection string with placeholders instead of real values.
- [ ] name operational evidence (start, DB connection, health, shutdown).
- [ ] justify `N/A` cases of sandbox use and stay language-neutral.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
