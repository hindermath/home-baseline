# Lernbegleiter: Secure OrderDesk v2 09 – Sichere Konfiguration, Secrets und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk braucht **Konfiguration** (z. B. Datenbankadresse, Ports) und **Secrets** (z. B.
Datenbank-Verbindungszeichenkette, API-Schlüssel). Die zentrale Regel dieser Einheit lautet: **Secrets gehören
nie in den Quellcode und nie in git-verfolgte Konfigurationsdateien**, sondern in einen plattformgeeigneten
**Secret-Store** (z. B. macOS Keychain, Windows Credential Manager, ein Vault). Konfiguration und Secrets werden
getrennt. In diesem Material und in deinen Nachweisen erscheinen Zugangsdaten nur als
`<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** The Secure OrderDesk needs **configuration** (e.g. database address, ports) and **secrets** (e.g.
database connection string, API key). The central rule of this unit is: **secrets never belong in source code
and never in git-tracked configuration files**, but in a platform-appropriate **secret store** (e.g. macOS
Keychain, Windows Credential Manager, a vault). Configuration and secrets are kept separate. In this material
and your evidence, credentials appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**DE:** Zusätzlich planst du **Schreibgrenzen** (wohin darf der Dienst schreiben?) und **Betriebsnachweise**
(wie belegst du, dass Konfiguration und Secrets sicher behandelt werden?). Ein Bezug ist die öffentliche
Referenz **`absdd-image-sandbox`**. Im 2. Lehrjahr ist die Sandbox ein **vorbereitetes** Konzept: Ihre
praktische Nutzung kann begründet `Applicable`, `N/A` oder `Open` sein. Allgemeine Codearbeit und IDE-Nutzung
(JetBrains, VS Code, Visual Studio) dürfen außerhalb der Sandbox stattfinden; ab dem 3. Lehrjahr wird sichere
Sandbox-Nutzung für KI-gestützte Schreibarbeit wichtiger.

**EN:** In addition, you plan **write limits** (where may the service write?) and **operational evidence** (how
do you prove configuration and secrets are handled safely?). One reference is the public
**`absdd-image-sandbox`**. In year 2 the sandbox is a **prepared** concept: its practical use may be
`Applicable`, `N/A`, or `Open` with justification. General code work and IDE use (JetBrains, VS Code, Visual
Studio) may happen outside the sandbox; from year 3 secure sandbox use becomes more important for AI-assisted
write work.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Konfiguration / Configuration | Einstellbare Werte ohne Geheimnis (z. B. Host, Port, Log-Ebene). |
| Secret / Secret | Geheimer Wert wie Passwort, Token, Verbindungszeichenkette. |
| Secret-Store / Secret store | Sicherer Ort für Secrets außerhalb von Code und Git. |
| Platzhalter / Placeholder | `<PLATZHALTER-KEIN-ECHTER-WERT>` statt eines echten Secrets. |
| Schreibgrenze / Write limit | Regel, wohin der Dienst schreiben darf und wohin nicht. |
| Betriebsnachweis / Operational evidence | Belegt, dass Konfiguration/Secrets sicher behandelt werden. |
| Sandbox / Sandbox | Isolierte Umgebung; hier `absdd-image-sandbox` als Referenz. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Konfiguration und Secrets trennen.** Liste alle Werte und markiere: geheim oder nicht.
Datenbankadresse ist Konfiguration; das Passwort in der Verbindungszeichenkette ist Secret. **Warum wichtig:**
Nur getrennt kann man Secrets besonders schützen.

**EN:** **Step 1 – Separate configuration and secrets.** List all values and mark: secret or not. The database
address is configuration; the password in the connection string is a secret. **Why it matters:** only when
separated can secrets get special protection.

**DE:** **Schritt 2 – Secret-Store statt Quellcode.** Lege fest, dass Secrets aus einem Secret-Store oder aus
sicher gesetzten Umgebungswerten kommen, nie aus dem Code oder aus git-verfolgten Dateien. **Warum wichtig:**
Ein Secret im Repository ist dauerhaft und für alle mit Repo-Zugriff sichtbar.

**EN:** **Step 2 – Secret store instead of source code.** Decide that secrets come from a secret store or from
safely set environment values, never from code or git-tracked files. **Why it matters:** a secret in the
repository is permanent and visible to everyone with repo access.

**DE:** **Schritt 3 – Platzhalter in Nachweisen.** In Beispielen, `spec.md`, `plan.md` und
`.env.example`-artigen Dateien stehen nur `<PLATZHALTER-KEIN-ECHTER-WERT>`. **Warum wichtig:** So kann kein
echtes Secret versehentlich in die Dokumentation oder ins Git gelangen.

**EN:** **Step 3 – Placeholders in evidence.** In examples, `spec.md`, `plan.md`, and `.env.example`-like files
only `<PLATZHALTER-KEIN-ECHTER-WERT>` appears. **Why it matters:** this way no real secret can accidentally
reach the documentation or Git.

**DE:** **Schritt 4 – Schreibgrenzen definieren.** Bestimme, wohin der Dienst schreiben darf (z. B. Datenbank,
definiertes Log-Verzeichnis) und wohin nicht. **Warum wichtig:** Klare Grenzen verhindern, dass ein Fehler oder
Angriff an unerwartete Orte schreibt.

**EN:** **Step 4 – Define write limits.** Determine where the service may write (e.g. the database, a defined
log directory) and where not. **Why it matters:** clear limits prevent an error or attack from writing to
unexpected places.

**DE:** **Schritt 5 – Sandbox-Anwendbarkeit begründen.** Entscheide für diesen Lauf: praktische
Sandbox-Nutzung `Applicable`, `N/A` oder `Open`, jeweils mit Begründung. Nenne die Public-Referenz
`https://github.com/hindermath/absdd-image-sandbox` und grenze IDE-/Editor-Arbeit außerhalb der Sandbox ab.
**Warum wichtig:** Im 2. Lehrjahr wird die Sandbox vorbereitet, nicht erzwungen; ab Jahr 3 wird sie wichtiger.

**EN:** **Step 5 – Justify sandbox applicability.** Decide for this run: practical sandbox use `Applicable`,
`N/A`, or `Open`, each with justification. Name the public reference
`https://github.com/hindermath/absdd-image-sandbox` and delimit IDE/editor work outside the sandbox. **Why it
matters:** in year 2 the sandbox is prepared, not enforced; from year 3 it becomes more important.

**DE:** **Typische Fehler.** Ein Passwort in der Verbindungszeichenkette im Code oder in einer committeten
Datei lassen. Echte Secrets statt Platzhalter in Beispiele schreiben. Konfiguration und Secrets vermischen.
Sandbox-Nutzung stillschweigend voraussetzen oder ohne Begründung weglassen.

**EN:** **Common mistakes.** Leaving a password in the connection string in code or in a committed file.
Writing real secrets instead of placeholders into examples. Mixing configuration and secrets. Silently assuming
sandbox use or omitting it without justification.

### Beispiel / Example

```text
Konfiguration (nicht geheim, darf ins Repo):
  db_host=localhost  db_port=5432  db_name=orderdesk  log_ebene=info

Secret (nur aus Secret-Store, nie ins Repo):
  db_verbindungszeichenkette=<PLATZHALTER-KEIN-ECHTER-WERT>
  api_schluessel=<PLATZHALTER-KEIN-ECHTER-WERT>

Schreibgrenze:
  erlaubt: Datenbank orderdesk, Verzeichnis ./logs
  verboten: Systemverzeichnisse, Home des Nutzers, beliebige Pfade aus Eingaben

Sandbox-Entscheidung (Jahr 2):
  praktische Nutzung = N/A (Begruendung: Fokus auf Konfig-/Secret-Konzept; IDE-Arbeit ausserhalb erlaubt)
  Referenz = https://github.com/hindermath/absdd-image-sandbox
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Sichere Konfiguration, Secret-Handhabung und Betriebsnachweise gehören zum sicheren Bereitstellen des Dienstes. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der Schutzbedarf von Secrets und Schreibpfaden wird analysiert und umgesetzt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Supply-Chain- und Betriebssicherheit,
Datenschutz und Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07`
(Konfiguration/Betrieb), `CL_08` (Sicherheits-Code-Review), `CL_09` (Betriebs-/Nachweisbezug), `CL_12`
(Lieferkette/Übergabe). Die Sicherheitsentscheidung dieser Einheit lautet: *Secrets liegen im Secret-Store, in
Code und Nachweisen stehen nur Platzhalter, und Schreibgrenzen begrenzen den Wirkungsbereich des Dienstes.*
A11Y-Aspekt: Konfigurations- und Nachweisdokumente bleiben textbasiert, ohne reine Farbsignale; Platzhalter
sind als Text klar erkennbar, damit Screenreader und Braille-Zeile sie wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure configuration, supply-chain and operational
security, privacy, and evidence. Matching checklists: `CL_01` (standards applicability), `CL_07`
(configuration/operation), `CL_08` (security code review), `CL_09` (operational/evidence relation), `CL_12`
(supply chain/handover). The security decision of this unit is: *secrets live in the secret store, code and
evidence contain only placeholders, and write limits bound the service's reach.* Accessibility aspect:
configuration and evidence documents stay text-based, free of color-only signals; placeholders are clearly
recognizable as text, so a screen reader and Braille display can convey them.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehören Secrets nie in den Quellcode oder in git-verfolgte Dateien? /
   **EN:** Why do secrets never belong in source code or git-tracked files?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret im Repository ist dauerhaft in der Historie und für alle mit Repo-Zugriff sichtbar. Es
   gehört in einen Secret-Store außerhalb von Code und Git.
   **EN:** A secret in the repository is permanently in the history and visible to everyone with repo access. It
   belongs in a secret store outside code and Git.

   </details>

2. **DE:** Wie unterscheidest du Konfiguration von Secrets? /
   **EN:** How do you distinguish configuration from secrets?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Konfiguration sind einstellbare, nicht geheime Werte (Host, Port). Secrets sind geheime Werte
   (Passwort, Token, Verbindungszeichenkette). Nur Secrets brauchen den Secret-Store.
   **EN:** Configuration are adjustable, non-secret values (host, port). Secrets are secret values (password,
   token, connection string). Only secrets need the secret store.

   </details>

3. **DE:** (SI) Warum stehen in Beispielen und Nachweisen nur Platzhalter? /
   **EN:** (SI) Why do examples and evidence contain only placeholders?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit kein echtes Secret versehentlich in Dokumentation oder Git gelangt. `<PLATZHALTER-KEIN-ECHTER-WERT>`
   zeigt die Stelle, ohne einen echten Wert preiszugeben.
   **EN:** So that no real secret accidentally reaches documentation or Git. `<PLATZHALTER-KEIN-ECHTER-WERT>`
   marks the place without exposing a real value.

   </details>

4. **DE:** Wozu dienen Schreibgrenzen? /
   **EN:** What are write limits for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie legen fest, wohin der Dienst schreiben darf. So kann ein Fehler oder Angriff nicht an beliebige
   Orte schreiben; der Wirkungsbereich bleibt klein.
   **EN:** They define where the service may write. This prevents an error or attack from writing to arbitrary
   places; the reach stays small.

   </details>

5. **DE:** Warum ist die Sandbox-Nutzung im 2. Lehrjahr nicht erzwungen? /
   **EN:** Why is sandbox use not enforced in year 2?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im 2. Lehrjahr ist die Sandbox ein vorbereitetes Konzept. Praktische Nutzung kann begründet
   `Applicable`, `N/A` oder `Open` sein; ab dem 3. Lehrjahr wird sie wichtiger.
   **EN:** In year 2 the sandbox is a prepared concept. Practical use may be `Applicable`, `N/A`, or `Open` with
   justification; from year 3 it becomes more important.

   </details>

6. **DE:** (AE) Darf IDE-Arbeit außerhalb der Sandbox stattfinden? /
   **EN:** (AE) May IDE work happen outside the sandbox?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ja. Allgemeine Codearbeit, Lesen, Review und die Bedienung von JetBrains, VS Code oder Visual Studio
   dürfen außerhalb der Sandbox stattfinden. KI-gestützte Schreibarbeit soll aber Sandbox-fähig geplant werden.
   **EN:** Yes. General code work, reading, review, and using JetBrains, VS Code, or Visual Studio may happen
   outside the sandbox. But AI-assisted write work should be planned to be sandbox-capable.

   </details>

7. **DE:** (DPA) Wie hängt sichere Secret-Handhabung mit Datenschutz zusammen? /
   **EN:** (DPA) How does secure secret handling relate to privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine geleakte Datenbank-Verbindungszeichenkette gibt Zugang zu allen Kundendaten. Sichere
   Secret-Handhabung schützt damit direkt die personenbezogenen Bestell- und Kundendaten.
   **EN:** A leaked database connection string grants access to all customer data. Secure secret handling
   therefore directly protects the personal order and customer data.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. So bleibt sichtbar, dass
   der Standard geprüft und bewusst als nicht anwendbar eingestuft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. This keeps visible that the
   standard was checked and deliberately classified as not applicable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Konfiguration von Secrets unterscheiden.
- [ ] begründen, warum Secrets in einen Secret-Store und nie in Code oder Git gehören.
- [ ] in Beispielen und Nachweisen nur `<PLATZHALTER-KEIN-ECHTER-WERT>` verwenden.
- [ ] Schreibgrenzen für den Dienst festlegen.
- [ ] die Sandbox-Anwendbarkeit für Jahr 2 als `Applicable`/`N/A`/`Open` begründen.
- [ ] IDE-/Editor-Arbeit außerhalb der Sandbox von KI-gestützter Schreibarbeit abgrenzen.

**EN:** I can …

- [ ] distinguish configuration from secrets.
- [ ] justify why secrets belong in a secret store and never in code or Git.
- [ ] use only `<PLATZHALTER-KEIN-ECHTER-WERT>` in examples and evidence.
- [ ] define write limits for the service.
- [ ] justify the sandbox applicability for year 2 as `Applicable`/`N/A`/`Open`.
- [ ] delimit IDE/editor work outside the sandbox from AI-assisted write work.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
