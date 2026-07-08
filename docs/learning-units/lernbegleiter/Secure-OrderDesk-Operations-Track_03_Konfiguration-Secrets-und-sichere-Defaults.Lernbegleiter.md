# Lernbegleiter: Secure OrderDesk Operations Track 03 – Konfiguration, Secrets und sichere Defaults / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Datenbank-Betrieb braucht viele Einstellungen: die Verbindungszeichenkette zur Datenbank, das
Datenbank-Konto, Ports, Zeitzonen, Grenzwerte. Manche dieser Werte sind harmlos, andere sind **Geheimnisse
(Secrets)**, zum Beispiel das Passwort des Datenbank-Kontos. Der wichtigste Grundsatz lautet: Konfiguration,
Secrets und Code sind drei getrennte Dinge. Secrets gehören nie in den Quellcode oder in eine Git-getrackte
Datei, sondern in einen **Secret-Store** (z. B. macOS Keychain, Windows Credential Manager oder ein
Umgebungsgeheimnis). Sichere Standardwerte („deny by default") sorgen dafür, dass ein vergessener Wert nicht
still eine Tür öffnet.

**EN:** A database operation needs many settings: the database connection string, the database account, ports,
time zones, limits. Some of these values are harmless, others are **secrets**, for example the password of the
database account. The most important principle is: configuration, secrets, and code are three separate things.
Secrets never belong in source code or a Git-tracked file but in a **secret store** (e.g. macOS Keychain,
Windows Credential Manager, or an environment secret). Secure default values ("deny by default") ensure that a
forgotten value does not silently open a door.

**DE:** In dieser Einheit lernst du, Konfigurationsebenen zu trennen, sichere Defaults zu setzen, die Herkunft
jedes Wertes zu dokumentieren und Secrets sauber auszulagern. In dieser Aufgabe steht kein einziges echtes
Secret in der Dokumentation, nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** In this unit you learn to separate configuration layers, set secure defaults, document the origin of
each value, and outsource secrets cleanly. In this task no real secret appears in the documentation, only
`<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Konfigurationsebene / Configuration layer | Getrennte Quelle für Einstellungen, z. B. Standard, Umgebung, Override, mit klarer Vorrangfolge. |
| Sichere Defaults / Secure defaults | Standardwerte, die im Zweifel den Zugriff verweigern („deny by default"). |
| Secret / Secret | Schützenswerter Wert wie ein Datenbank-Passwort, der nie in Code oder Git gehört. |
| Secret-Store / Secret store | Plattformgeeigneter, geschützter Speicher für Secrets (Keychain, Credential Manager, Umgebungsgeheimnis). |
| Verbindungszeichenkette / Connection string | Angabe, wie sich die Plattform mit der Datenbank verbindet; enthält oft ein Secret. |
| Herkunft / Origin | Nachweis, aus welcher Quelle ein Konfigurationswert stammt und wer ihn setzt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Konfigurationsebenen trennen.** Lege fest, welche Ebenen es gibt und welche Vorrang hat:
z. B. eingebaute Standardwerte (niedrigste), Umgebungswerte je Zielhost, ausdrückliche Overrides (höchste).
Eine klare Vorrangfolge verhindert, dass niemand mehr weiß, welcher Wert am Ende wirkt.

**EN:** **Step 1 – Separate configuration layers.** Define which layers exist and which takes precedence:
e.g. built-in defaults (lowest), environment values per target host, explicit overrides (highest). A clear
precedence prevents that nobody knows which value finally applies.

**DE:** **Schritt 2 – Sichere Defaults setzen.** Wähle für jeden sicherheitsrelevanten Wert einen sicheren
Standard nach dem Prinzip „deny by default": Fernzugriff aus, ausführliche Fehlermeldungen aus, minimale
Rechte, TLS erwartet. Ein fehlender Wert soll den Betrieb nicht öffnen, sondern eher verweigern.

**EN:** **Step 2 – Set secure defaults.** For every security-relevant value choose a secure default following
"deny by default": remote access off, verbose error messages off, minimal rights, TLS expected. A missing
value should not open operation but rather deny it.

**DE:** **Schritt 3 – Secrets auslagern.** Die Verbindungszeichenkette und das Datenbank-Passwort gehören in
den Secret-Store, nicht in eine `appsettings`-Datei im Repository. Der Code liest das Secret zur Laufzeit aus
dem Store. In der Dokumentation steht nur `<PLATZHALTER-KEIN-ECHTER-WERT>`. Prüfe, dass kein Secret versehentlich
in ein Beispiel, ein Log oder eine Fehlermeldung gerät.

**EN:** **Step 3 – Outsource secrets.** The connection string and the database password belong in the secret
store, not in an `appsettings` file in the repository. The code reads the secret at runtime from the store.
The documentation only shows `<PLATZHALTER-KEIN-ECHTER-WERT>`. Check that no secret accidentally ends up in an
example, a log, or an error message.

**DE:** **Schritt 4 – Herkunft dokumentieren.** Führe je Konfigurationswert nach, aus welcher Ebene und aus
welcher Quelle er stammt und ob er ein Secret ist. So bleibt nachvollziehbar, warum ein Wert so gesetzt ist,
und ein Review kann die Trennung von Konfiguration, Secrets und Code prüfen. Nicht Anwendbares wird als `N/A`
mit Begründung notiert.

**EN:** **Step 4 – Document the origin.** For each configuration value, track from which layer and source it
comes and whether it is a secret. This keeps traceable why a value is set the way it is, and a review can check
the separation of configuration, secrets, and code. What is not applicable is recorded as `N/A` with a
rationale.

**DE:** **Typische Fehler.** Passwörter oder Verbindungszeichenketten im Repository. Unsichere Defaults, die
im Zweifel öffnen statt verweigern. Secrets in Logs oder Fehlermeldungen ausgeben. Unklare Vorrangfolge, sodass
niemand weiß, welcher Wert gilt. Ein Secret „nur für den Test" fest im Code, das dann in Produktion landet.

**EN:** **Common mistakes.** Passwords or connection strings in the repository. Unsafe defaults that open
rather than deny in doubt. Printing secrets in logs or error messages. Unclear precedence so nobody knows which
value applies. A secret "just for testing" hard-coded, which then ends up in production.

### Beispiel / Example

```text
Wert                    | Ebene      | Herkunft / Quelle            | Secret? | Default (deny by default)
------------------------|------------|------------------------------|---------|--------------------------
DB-Host                 | Umgebung   | Umgebungsvariable je Host    | nein    | localhost
DB-Port                 | Standard   | eingebauter Standard         | nein    | interner Port
DB-Benutzer             | Umgebung   | Umgebungsvariable je Host    | nein    | least-privilege-Konto
DB-Passwort             | Secret     | Secret-Store (Keychain/CM)   | ja      | <PLATZHALTER-KEIN-ECHTER-WERT>
Verbindungszeichenkette | Secret     | Secret-Store zusammengesetzt | ja      | <PLATZHALTER-KEIN-ECHTER-WERT>
Fernzugriff             | Standard   | eingebauter Standard         | nein    | aus (deny by default)
Nachweis                | docs/security/ + Konfig-Herkunftstabelle; kein Secret in Logs/Beispielen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b;
berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b;
touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Sichere Betriebskonfiguration, Zugangssteuerung und Secret-Handling sichern den laufenden Betrieb. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf entscheidet, welche Werte Secrets sind und wie streng die Defaults ausfallen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Fail-Safe Defaults, Least Privilege
und Datenschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung/Rechte),
`CL_08` (Sicherheits-Review), `CL_10` (Logging/Nachweise) und `CL_12` (Dokumentation/N-A). Die
Sicherheitsentscheidung dieser Einheit lautet: *Secrets liegen im Secret-Store, Defaults verweigern im
Zweifel, und jede Herkunft ist belegt.* A11Y-Aspekt: Die Konfigurations- und Herkunftstabelle muss als
Text-Tabelle lesbar sein, nicht nur als Screenshot, damit sie mit Screenreader und Braille-Zeile nutzbar
bleibt.

**EN:** Relation to the Secure Development Guideline: secure configuration, fail-safe defaults, least
privilege, and privacy. Matching checklists: `CL_01` (standards applicability), `CL_05` (access
control/rights), `CL_08` (security review), `CL_10` (logging/evidence), and `CL_12` (documentation/N-A). The
security decision of this unit is: *secrets live in the secret store, defaults deny in doubt, and every origin
is evidenced.* Accessibility aspect: the configuration and origin table must be readable as a text table, not
only as a screenshot, so it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sind Konfiguration, Secrets und Code drei getrennte Dinge? /
   **EN:** Why are configuration, secrets, and code three separate things?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil sie unterschiedlich schützenswert sind und unterschiedlich oft geändert werden. Code ist im
   Repository, Konfiguration wechselt je Umgebung, Secrets sind hoch schützenswert und gehören in einen
   Secret-Store. Vermischt man sie, landet ein Secret schnell in Git.
   **EN:** Because they have different protection needs and change at different rates. Code is in the
   repository, configuration varies per environment, secrets are highly sensitive and belong in a secret
   store. Mixing them quickly puts a secret into Git.

   </details>

2. **DE:** (SI) Was bedeutet „deny by default" für einen sicheren Standardwert? /
   **EN:** (SI) What does "deny by default" mean for a secure default value?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein fehlender oder unklarer Wert soll den Betrieb eher verweigern als öffnen. Beispiel: Fernzugriff
   ist standardmäßig aus und muss ausdrücklich freigegeben werden. So öffnet ein vergessener Wert nicht still
   eine Tür.
   **EN:** A missing or unclear value should rather deny than open operation. Example: remote access is off by
   default and must be enabled explicitly. This way a forgotten value does not silently open a door.

   </details>

3. **DE:** (SI) Wohin gehört das Datenbank-Passwort und wohin nicht? /
   **EN:** (SI) Where does the database password belong and where not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** In den plattformgeeigneten Secret-Store (Keychain, Credential Manager, Umgebungsgeheimnis). Nicht in
   den Quellcode, nicht in eine Git-getrackte Konfigurationsdatei und nicht in Logs. In der Dokumentation steht
   nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** In the platform-appropriate secret store (Keychain, Credential Manager, environment secret). Not in
   source code, not in a Git-tracked configuration file, and not in logs. The documentation only shows
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

4. **DE:** Warum dokumentiert man die Herkunft jedes Konfigurationswertes? /
   **EN:** Why do you document the origin of each configuration value?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit nachvollziehbar bleibt, aus welcher Ebene ein Wert stammt, wer ihn setzt und ob er ein Secret
   ist. Ein Review kann so die Trennung prüfen und einen Fehler früh finden, etwa ein Secret an falscher
   Stelle.
   **EN:** So it stays traceable from which layer a value comes, who sets it, and whether it is a secret. A
   review can then check the separation and find an error early, e.g. a secret in the wrong place.

   </details>

5. **DE:** (DPA) Welche Angabe zu Kundendaten darf nicht in Klartext-Konfiguration oder Logs landen? /
   **EN:** (DPA) Which customer-data item must not end up in plaintext configuration or logs?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zugangsdaten zur Datenbank und alles, was Rückschluss auf echte Personen erlaubt. In dieser Reihe
   sind die Kundendaten fiktiv (`ALFKI`), aber das Muster gilt: keine personenbezogenen Daten und keine
   Zugangsgeheimnisse in Klartext-Konfiguration oder Logs.
   **EN:** Database access credentials and anything that allows conclusions about real persons. In this series
   the customer data is fictional (`ALFKI`), but the pattern holds: no personal data and no access secrets in
   plaintext configuration or logs.

   </details>

6. **DE:** (AE) Wie liest der Code ein Secret, ohne es im Repository zu speichern? /
   **EN:** (AE) How does the code read a secret without storing it in the repository?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er fragt das Secret zur Laufzeit beim Secret-Store oder aus einer Umgebungsvariablen ab und baut
   daraus die Verbindungszeichenkette zusammen. Im Repository steht nur der Verweis auf den Schlüsselnamen,
   nie der Wert selbst.
   **EN:** It queries the secret at runtime from the secret store or an environment variable and assembles the
   connection string from it. The repository only contains a reference to the key name, never the value
   itself.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Konfigurationsebenen mit klarer Vorrangfolge beschreiben.
- [ ] sichere Standardwerte nach „deny by default" setzen und begründen.
- [ ] Datenbank-Secrets in den Secret-Store auslagern und nur `<PLATZHALTER-KEIN-ECHTER-WERT>` dokumentieren.
- [ ] die Herkunft jedes Konfigurationswertes nachvollziehbar festhalten.
- [ ] prüfen, dass kein Secret in Logs, Fehlermeldungen oder Beispielen erscheint.

**EN:** I can …

- [ ] describe configuration layers with a clear precedence.
- [ ] set and justify secure default values following "deny by default".
- [ ] outsource database secrets to the secret store and document only `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- [ ] record the origin of each configuration value traceably.
- [ ] check that no secret appears in logs, error messages, or examples.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
