# Lernbegleiter: Secure ServiceHarvester v2 09 – Sichere Konfiguration, Secrets und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst braucht **Konfiguration**: Wo liegt die Ablage? Wie oft sammelt der Harvester? Manche
dieser Werte sind harmlos, andere sind **Geheimnisse (Secrets)** wie Passwörter oder Zugangstokens. Die
wichtigste Regel dieser Einheit lautet: **Secrets gehören nie in den Quellcode und nie ins Git-Repository.**
Sie kommen aus einem **Secret-Store** – einem plattformgeeigneten sicheren Speicher wie macOS Keychain,
Windows Credential Manager oder einem Vault. In der Lernreihe schreibst du echte Secrets nie hin, sondern nur
den Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** A service needs **configuration**: where is the storage? How often does the harvester collect? Some of
these values are harmless, others are **secrets** like passwords or access tokens. The most important rule of
this unit is: **secrets never belong in source code and never in the Git repository.** They come from a
**secret store** – a platform-appropriate secure storage such as macOS Keychain, Windows Credential Manager,
or a vault. In the learning series you never write real secrets, only the placeholder
`<PLATZHALTER-KEIN-ECHTER-WERT>`.

**DE:** Dazu gehören **Schreibgrenzen** (der Dienst darf nur in erlaubte Pfade schreiben) und
**Betriebsnachweise** (dokumentierte Belege, dass die Regeln eingehalten werden). Die
**`absdd-image-sandbox`** ist eine öffentliche Referenz für sicheres Arbeiten. Im 2. Lehrjahr ist sie ein
vorbereitetes Konzept: Du planst sie mit, ihre praktische Nutzung darf aber begründet `N/A` oder `Open`
bleiben. Ab dem 3. Lehrjahr wird sichere Sandbox-Nutzung wichtiger.

**EN:** This includes **write limits** (the service may write only to allowed paths) and **operational
evidence** (documented proof that the rules are followed). The **`absdd-image-sandbox`** is a public reference
for secure work. In year 2 it is a prepared concept: you plan for it, but its practical use may remain `N/A`
or `Open` with justification. From year 3 onward, secure sandbox use becomes more important.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Konfiguration / Configuration | Einstellbare Werte eines Dienstes, z. B. Pfade, Intervalle, Endpunkte. |
| Secret / Secret | Geheimer Wert wie Passwort oder Token, der nie öffentlich werden darf. |
| Secret-Store / Secret store | Sicherer Speicher für Secrets, getrennt von Code und Repository. |
| Schreibgrenze / Write limit | Regel, in welche Pfade der Dienst schreiben darf. |
| Betriebsnachweis / Operational evidence | Dokumentierter Beleg, dass Betriebsregeln eingehalten werden. |
| Sandbox / Sandbox | Abgeschottete Umgebung für sicheres Ausführen und Nachweisen. |
| Platzhalter / Placeholder | Ersatztext wie `<PLATZHALTER-KEIN-ECHTER-WERT>` statt eines echten Secrets. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Konfiguration und Secrets trennen.** Teile alle Werte in zwei Gruppen: harmlose
Konfiguration (Pfade, Intervalle) und Secrets (Passwörter, Tokens). **Warum wichtig:** Nur wer die beiden
trennt, kann Secrets gezielt schützen, statt sie versehentlich mit der Konfiguration zu veröffentlichen.

**EN:** **Step 1 – Separate configuration and secrets.** Divide all values into two groups: harmless
configuration (paths, intervals) and secrets (passwords, tokens). **Why it matters:** only by separating the
two can you protect secrets specifically instead of accidentally publishing them with the configuration.

**DE:** **Schritt 2 – Secrets in den Secret-Store legen.** Secrets kommen zur Laufzeit aus einem sicheren
Speicher, nicht aus dem Code und nicht aus einer getrackten Datei. In der Doku steht nur der Platzhalter.
**Warum wichtig:** Ein Secret im Repository ist dauerhaft kompromittiert, auch nach dem Löschen, weil die
Git-Historie es bewahrt.

**EN:** **Step 2 – Put secrets into the secret store.** Secrets come at runtime from a secure storage, not from
the code and not from a tracked file. The documentation contains only the placeholder. **Why it matters:** a
secret in the repository is permanently compromised, even after deletion, because the Git history preserves it.

**DE:** **Schritt 3 – Schreibgrenzen festlegen.** Bestimme, in welche Pfade der Dienst schreiben darf (z. B.
das Ablage-Verzeichnis und ein Log-Verzeichnis) und dass alles andere verboten ist. **Warum wichtig:** Enge
Schreibgrenzen begrenzen den Schaden, wenn der Dienst manipuliert wird (Least Privilege).

**EN:** **Step 3 – Define write limits.** Determine which paths the service may write to (e.g. the storage
directory and a log directory) and that everything else is forbidden. **Why it matters:** tight write limits
limit the damage if the service is compromised (least privilege).

**DE:** **Schritt 4 – Betriebsnachweise planen.** Lege fest, wie du belegst, dass die Regeln gelten: eine
Konfigurationsprüfung, ein Test, dass kein Secret im Code steht, eine Prüfliste für Schreibpfade. **Warum
wichtig:** Sicherheitsaussagen ohne Nachweis sind nur Behauptungen.

**EN:** **Step 4 – Plan operational evidence.** Define how you prove the rules hold: a configuration check, a
test that no secret is in the code, a checklist for write paths. **Why it matters:** security claims without
evidence are only assertions.

**DE:** **Schritt 5 – Sandbox-Anwendbarkeit entscheiden.** Prüfe, ob praktische Sandbox-Nutzung für diesen
Lauf `Applicable`, `N/A` oder `Open` ist, und begründe die Entscheidung. Verweise auf die Public-Referenz
`absdd-image-sandbox`. **Warum wichtig:** Eine ausdrückliche, begründete Entscheidung ist ehrlicher als ein
stilles Weglassen und bereitet auf Jahr 3 vor.

**EN:** **Step 5 – Decide sandbox applicability.** Check whether practical sandbox use for this run is
`Applicable`, `N/A`, or `Open`, and justify the decision. Refer to the public reference `absdd-image-sandbox`.
**Why it matters:** an explicit, justified decision is more honest than a silent omission and prepares for
year 3.

**DE:** **Typische Fehler.** Secrets in Code oder Config-Dateien schreiben. Echte Werte statt Platzhalter
dokumentieren. Schreibgrenzen weglassen. Sandbox-Nutzung stillschweigend voraussetzen oder ganz übergehen.
Betriebsregeln ohne Nachweis behaupten.

**EN:** **Common mistakes.** Writing secrets into code or config files. Documenting real values instead of
placeholders. Omitting write limits. Silently assuming or ignoring sandbox use. Asserting operational rules
without evidence.

### Beispiel / Example

```text
Konfiguration (harmlos, darf ins Repo):
  ablage_pfad = "./data"
  sammel_intervall_min = 15
  api_port = 8080

Secret (NICHT ins Repo, nur aus Secret-Store):
  ablage_passwort = <PLATZHALTER-KEIN-ECHTER-WERT>   -> zur Laufzeit aus Keychain/Vault

Schreibgrenze:
  erlaubt: ./data, ./logs
  verboten: alles andere (z. B. Systempfade)

Sandbox-Entscheidung (Jahr 2):
  praktische Nutzung = N/A -> Begruendung: Konzept vorbereitet, harte Nutzung erst ab Jahr 3
  Referenz: https://github.com/hindermath/absdd-image-sandbox
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Sichere Konfiguration, Secret-Handling und Betriebsnachweise gehören zur sicheren Bereitstellung des Dienstes. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Secret-Schutz und Schreibgrenzen setzen den Schutzbedarf von Zugangsdaten und Betriebsumgebung um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Secret-Management,
Least-Privilege-Schreibgrenzen, Betrieb und auditfähige Evidenz. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_07` (Betrieb und Deployment), `CL_08` (Sicherheits-Code-Review), `CL_09`
(Konfiguration/Secrets) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit
lautet: *Secrets kommen aus einem Secret-Store, nie aus Code oder Repository, und jede Betriebsregel erhält
einen Nachweis.* A11Y-Aspekt: Konfigurations- und Nachweistabellen müssen als klarer Text ohne reine
Farbmarkierung lesbar sein, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure configuration, secret management,
least-privilege write limits, operation, and audit-ready evidence. Matching checklists: `CL_01` (standards
applicability), `CL_07` (operation and deployment), `CL_08` (security code review), `CL_09`
(configuration/secrets), and `CL_12` (evidence and closure). The security decision of this unit is: *secrets
come from a secret store, never from code or repository, and every operational rule gets evidence.*
Accessibility aspect: configuration and evidence tables must be readable as clear text without color-only
marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum dürfen Secrets nie in den Quellcode oder ins Git-Repository? /
   **EN:** Why must secrets never enter source code or the Git repository?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret im Repository ist dauerhaft kompromittiert, weil die Git-Historie es bewahrt – auch nach
   dem Löschen. Jeder mit Zugriff auf das Repo könnte es lesen. Secrets gehören deshalb nur in einen
   Secret-Store.
   **EN:** A secret in the repository is permanently compromised because the Git history preserves it – even
   after deletion. Anyone with access to the repo could read it. Therefore secrets belong only in a secret
   store.

   </details>

2. **DE:** Was ist ein Secret-Store und wie unterscheidet er sich von einer Config-Datei? /
   **EN:** What is a secret store and how does it differ from a config file?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret-Store ist ein sicherer, getrennter Speicher (z. B. Keychain, Credential Manager, Vault),
   der Secrets zur Laufzeit bereitstellt. Eine Config-Datei liegt oft im Repo und darf nur harmlose Werte
   enthalten, keine Geheimnisse.
   **EN:** A secret store is a secure, separate storage (e.g. keychain, credential manager, vault) that
   provides secrets at runtime. A config file often lives in the repo and may contain only harmless values, no
   secrets.

   </details>

3. **DE:** (SI) Warum begrenzen enge Schreibgrenzen den Schaden bei einer Kompromittierung? /
   **EN:** (SI) Why do tight write limits reduce the damage in case of compromise?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Darf der Dienst nur in wenige erlaubte Pfade schreiben, kann ein Angreifer über ihn auch nur dort
   Schaden anrichten. Das ist Least Privilege: minimale Rechte begrenzen die Reichweite eines Angriffs.
   **EN:** If the service may write only to a few allowed paths, an attacker using it can also do damage only
   there. This is least privilege: minimal rights limit the reach of an attack.

   </details>

4. **DE:** Warum dokumentierst du Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`? /
   **EN:** Why do you document secrets only as `<PLATZHALTER-KEIN-ECHTER-WERT>`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Platzhalter zeigt, dass an dieser Stelle ein Secret erwartet wird, ohne einen echten Wert
   preiszugeben. So bleibt die Doku sicher, auch wenn sie öffentlich ist.
   **EN:** The placeholder shows that a secret is expected here, without revealing a real value. This keeps the
   documentation safe even when it is public.

   </details>

5. **DE:** (AE) Wie belegst du im Code, dass kein Secret enthalten ist? /
   **EN:** (AE) How do you prove in the code that no secret is contained?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel durch einen Secret-Scan oder eine Prüfung in der Pipeline, die nach secret-artigen
   Mustern sucht, plus ein Review. Das Ergebnis ist ein Betriebsnachweis, dass Code und Config secret-frei
   sind.
   **EN:** For example through a secret scan or a pipeline check that searches for secret-like patterns, plus a
   review. The result is operational evidence that code and config are secret-free.

   </details>

6. **DE:** (DPA) Warum ist ein ausdrückliches `N/A` mit Begründung besser als das stille Weglassen der
   Sandbox-Nutzung? / **EN:** (DPA) Why is an explicit `N/A` with justification better than silently omitting
   sandbox use?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein begründetes `N/A` zeigt, dass die Frage geprüft wurde, und macht die Entscheidung
   nachvollziehbar und auditierbar. Stilles Weglassen sieht aus wie Vergessen und schwächt die Aussagekraft der
   Nachweise.
   **EN:** A justified `N/A` shows the question was checked and makes the decision traceable and auditable.
   Silent omission looks like forgetting and weakens the evidential value.

   </details>

7. **DE:** Was ist ein Betriebsnachweis und wozu dient er in dieser Einheit? /
   **EN:** What is operational evidence and what is its purpose in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Betriebsnachweis ist ein dokumentierter Beleg, dass eine Betriebsregel eingehalten wird, z. B.
   dass Secrets aus dem Store kommen und Schreibgrenzen gelten. Er verwandelt eine Behauptung in eine prüfbare
   Aussage.
   **EN:** Operational evidence is documented proof that an operational rule is followed, e.g. that secrets come
   from the store and write limits apply. It turns an assertion into a verifiable statement.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Konfiguration und Secrets klar trennen.
- [ ] begründen, warum Secrets nie in Code oder Repository gehören.
- [ ] einen Secret-Store von einer Config-Datei unterscheiden.
- [ ] Schreibgrenzen nach Least Privilege festlegen.
- [ ] Betriebsnachweise für die Regeln planen.
- [ ] die Sandbox-Nutzung als `Applicable`/`N/A`/`Open` mit Begründung dokumentieren.

**EN:** I can …

- [ ] clearly separate configuration and secrets.
- [ ] justify why secrets never belong in code or repository.
- [ ] distinguish a secret store from a config file.
- [ ] define write limits following least privilege.
- [ ] plan operational evidence for the rules.
- [ ] document sandbox use as `Applicable`/`N/A`/`Open` with justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
