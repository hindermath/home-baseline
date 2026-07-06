# Lernbegleiter: Secure ServiceHarvester Operations Track 03 – Konfiguration, Secrets und sichere Defaults / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst braucht **Konfiguration**: Wo liegen Daten? Wie oft wird gesammelt? Welche Endpunkte gelten?
Manche dieser Werte sind harmlos, andere sind **Secrets** – zum Beispiel Zugangsdaten oder Schlüssel.
Konfiguration und Secrets gehören **nicht** in den Quellcode und nicht in Git. Als Systemintegrator*in trennst
du drei Dinge sauber: den Code, die Konfiguration je Umgebung und die Secrets im geschützten Secret-Store.
Zusätzlich sorgst du für **sichere Standardwerte**: Im Zweifel ist etwas aus, verboten oder eng, nicht offen.

**EN:** A service needs **configuration**: where does data live? How often does it collect? Which endpoints
apply? Some of these values are harmless, others are **secrets** – for example credentials or keys.
Configuration and secrets do **not** belong in source code or in Git. As a system integrator you cleanly
separate three things: the code, the configuration per environment, and the secrets in a protected secret
store. In addition you ensure **secure default values**: when in doubt, something is off, denied, or narrow,
not open.

**DE:** In dieser Einheit lernst du, Konfigurationsebenen mit Vorrangfolge zu bauen, sichere Defaults nach dem
Prinzip „deny by default" zu setzen, Secrets im plattformgeeigneten Store zu halten und je Wert die Herkunft
zu dokumentieren. In der Dokumentation erscheinen Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** In this unit you learn to build configuration layers with a precedence order, set secure defaults by
the "deny by default" principle, keep secrets in a platform-appropriate store, and document the origin per
value. In documentation, secrets appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Konfiguration / Configuration | Einstellbare Werte, die das Verhalten des Dienstes je Umgebung steuern. |
| Konfigurationsebene / Configuration layer | Quelle mit Vorrang, z. B. Standard, Umgebungsvariable, Override-Datei. |
| Secret / Secret | Schützenswerter Wert wie Zugangsdaten, Token oder Schlüssel. |
| Secret-Store / Secret store | Geschützter Speicher für Secrets, z. B. Keychain oder Credential Manager. |
| Sicherer Default / Secure default | Standardwert, der im Zweifel eng oder deaktiviert ist (deny by default). |
| Herkunft / Origin | Dokumentierte Quelle, aus der ein Konfigurationswert stammt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Konfigurationsebenen mit Vorrang.** Lege fest, aus welchen Quellen Werte kommen und
welche Quelle gewinnt: z. B. eingebaute Standardwerte < Konfigurationsdatei < Umgebungsvariable < expliziter
Override. Eine klare Vorrangfolge macht nachvollziehbar, warum ein Wert im Betrieb genau so gilt.

**EN:** **Step 1 – Configuration layers with precedence.** Define which sources values come from and which
source wins: e.g. built-in defaults < configuration file < environment variable < explicit override. A clear
precedence order makes it traceable why a value applies exactly as it does in operation.

**DE:** **Schritt 2 – Sichere Defaults (deny by default).** Wähle Standardwerte so, dass sie im Zweifel
sicher sind: Zugriff verweigern statt erlauben, Feature aus statt an, Timeouts gesetzt statt unendlich. Wer
mehr Offenheit braucht, muss sie bewusst und dokumentiert einschalten. So ist eine vergessene Einstellung
nicht automatisch ein Risiko.

**EN:** **Step 2 – Secure defaults (deny by default).** Choose default values so they are safe when in doubt:
deny access instead of allow, feature off instead of on, timeouts set instead of infinite. Whoever needs more
openness must enable it deliberately and documented. This way a forgotten setting is not automatically a risk.

**DE:** **Schritt 3 – Secrets in den Store.** Secrets gehören nie in den Quellcode, nie in Git-getrackte
Dateien und nie in Logs. Nutze den plattformgeeigneten Secret-Store (macOS Keychain, Windows Credential
Manager, geschützte Umgebungsgeheimnisse) und lade Secrets erst zur Laufzeit. In Beispielen und Dokumentation
steht nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** **Step 3 – Secrets into the store.** Secrets never belong in source code, in Git-tracked files, or in
logs. Use the platform-appropriate secret store (macOS Keychain, Windows Credential Manager, protected
environment secrets) and load secrets only at runtime. In examples and documentation only
`<PLATZHALTER-KEIN-ECHTER-WERT>` appears.

**DE:** **Schritt 4 – Herkunft je Wert dokumentieren.** Führe eine kleine Tabelle: Für jeden wichtigen
Konfigurationswert notierst du Quelle, Vorrang, ob es ein Secret ist und wo es liegt. So ist im Audit
nachvollziehbar, woher jeder Betriebswert kommt, und Fehlkonfigurationen fallen früher auf.

**EN:** **Step 4 – Document the origin per value.** Keep a small table: for each important configuration value
note source, precedence, whether it is a secret, and where it lives. This makes it traceable in an audit where
each operational value comes from, and misconfigurations surface earlier.

**DE:** **Typische Fehler.** Secrets in `appsettings`, `.env` oder Code committen. Defaults offen lassen
(„erlaube alles"), damit „es erstmal läuft". Keine Vorrangfolge, sodass niemand weiß, welcher Wert gewinnt.
Secrets in Logs oder Fehlermeldungen ausgeben. Konfiguration und Secrets vermischen.

**EN:** **Common mistakes.** Committing secrets into `appsettings`, `.env`, or code. Leaving defaults open
("allow everything") so "it runs for now". No precedence order so nobody knows which value wins. Printing
secrets in logs or error messages. Mixing configuration and secrets.

### Beispiel / Example

```text
Vorrangfolge:   eingebauter Default  <  Konfigurationsdatei  <  Umgebungsvariable  <  Override

Wert                | Quelle/Vorrang        | Secret? | Ablage
--------------------|-----------------------|---------|----------------------------------
sammel_intervall    | Konfigurationsdatei   | nein    | config/harvester.conf
log_level           | eingebauter Default   | nein    | Standard = "info" (deny-by-default: kein debug)
backend_zugang      | Umgebungsvariable     | ja      | Secret-Store; Wert = <PLATZHALTER-KEIN-ECHTER-WERT>
netz_zugriff        | eingebauter Default   | nein    | Standard = deaktiviert (bewusst freischalten)
Nachweis:           Konfigurationsebenen-Tabelle + Default-Matrix; kein Secret im Repo/Log
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Sichere Konfiguration, sichere Defaults und Secret-Schutz sind Kern der Betriebssicherheit. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf entscheidet, welche Werte als Secret behandelt werden. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Fail-Safe Defaults und auditfähige
Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung), `CL_08`
(Sicherheits-Review), `CL_10` (Datenschutz) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung
dieser Einheit lautet: *Secrets liegen im Store, Defaults verweigern im Zweifel, und jede Herkunft ist
belegt.* A11Y-Aspekt: Konfigurationstabellen müssen als klarer Text lesbar sein, ohne reine Farbmarkierung,
damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure configuration, fail-safe defaults, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (access control),
`CL_08` (security review), `CL_10` (privacy), and `CL_12` (documentation/N-A). The security decision of this
unit is: *secrets live in the store, defaults deny when in doubt, and every origin is evidenced.*
Accessibility aspect: configuration tables must be readable as clear text, without color-only marking, so
they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehören Secrets nicht in den Quellcode oder in Git? /
   **EN:** Why do secrets not belong in source code or in Git?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Quellcode und Git sind einsehbar, werden kopiert und bleiben in der History erhalten. Ein einmal
   committetes Secret gilt als kompromittiert. Secrets gehören in einen geschützten Store und werden erst zur
   Laufzeit geladen.
   **EN:** Source code and Git are visible, get copied, and persist in history. A once-committed secret is
   considered compromised. Secrets belong in a protected store and are loaded only at runtime.

   </details>

2. **DE:** Was bedeutet „deny by default" bei Konfigurationswerten? /
   **EN:** What does "deny by default" mean for configuration values?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Standardwerte sind im Zweifel eng: Zugriff verweigert, Feature aus, Timeouts gesetzt. Mehr
   Offenheit muss bewusst eingeschaltet werden. So ist eine vergessene Einstellung nicht automatisch ein
   Sicherheitsrisiko.
   **EN:** Default values are narrow when in doubt: access denied, feature off, timeouts set. More openness
   must be enabled deliberately. This way a forgotten setting is not automatically a security risk.

   </details>

3. **DE:** (SI) Wozu dient eine dokumentierte Vorrangfolge der Konfigurationsebenen im Betrieb? /
   **EN:** (SI) What is a documented precedence order of configuration layers good for in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie macht nachvollziehbar, welcher Wert im Betrieb gewinnt, wenn mehrere Quellen denselben
   Schlüssel setzen. Ohne Vorrangfolge sind Fehlkonfigurationen schwer zu erklären und zu reproduzieren. Mit
   ihr ist der wirksame Wert eindeutig.
   **EN:** It makes traceable which value wins in operation when several sources set the same key. Without a
   precedence order, misconfigurations are hard to explain and reproduce. With it, the effective value is
   unambiguous.

   </details>

4. **DE:** (SI) Wie hältst du Secrets plattformübergreifend sicher? /
   **EN:** (SI) How do you keep secrets secure across platforms?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über den plattformgeeigneten Secret-Store: macOS Keychain, Windows Credential Manager oder
   geschützte Umgebungsgeheimnisse. Der Dienst lädt sie erst zur Laufzeit. In Repo, Logs und Doku steht nur
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Via the platform-appropriate secret store: macOS Keychain, Windows Credential Manager, or protected
   environment secrets. The service loads them only at runtime. In repo, logs, and docs only
   `<PLATZHALTER-KEIN-ECHTER-WERT>` appears.

   </details>

5. **DE:** (DPA) Wie entscheidest du, ob ein Konfigurationswert ein Secret ist? /
   **EN:** (DPA) How do you decide whether a configuration value is a secret?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über den Schutzbedarf: Würde das Bekanntwerden des Werts Vertraulichkeit, Zugang oder Integrität
   gefährden, ist er ein Secret. Zugangsdaten, Token und Schlüssel sind Secrets; ein Sammelintervall in der
   Regel nicht.
   **EN:** Via the protection need: if disclosure of the value would endanger confidentiality, access, or
   integrity, it is a secret. Credentials, tokens, and keys are secrets; a collection interval usually is not.

   </details>

6. **DE:** Warum darf kein Secret in Logs oder Fehlermeldungen erscheinen? /
   **EN:** Why must no secret appear in logs or error messages?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logs werden gespeichert, weitergeleitet und oft von vielen gelesen. Ein Secret im Log ist damit
   verbreitet und gilt als kompromittiert. Fehlermeldungen dürfen zudem keine internen Zustände preisgeben.
   **EN:** Logs are stored, forwarded, and often read by many. A secret in a log is thereby spread and
   considered compromised. Error messages must also not reveal internal state.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Konfigurationsebenen mit einer klaren Vorrangfolge beschreiben.
- [ ] sichere Standardwerte nach „deny by default" wählen und begründen.
- [ ] Secrets im plattformgeeigneten Secret-Store statt im Code halten.
- [ ] je Konfigurationswert die Herkunft dokumentieren.
- [ ] sicherstellen, dass kein echtes Secret in Repo, Logs oder Doku steht.

**EN:** I can …

- [ ] describe configuration layers with a clear precedence order.
- [ ] choose and justify secure default values by "deny by default".
- [ ] keep secrets in the platform-appropriate secret store instead of code.
- [ ] document the origin per configuration value.
- [ ] ensure no real secret appears in repo, logs, or docs.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
