# Lernbegleiter: Secure CaseTracker Digital Networking Track 07 – Konfiguration, Secrets und Rollout-Pfade / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein vernetztes System verhält sich je nach **Konfiguration** unterschiedlich: welche Adresse ein
Dienst hat, welcher Port offen ist, ob Verschlüsselung an ist. Konfiguration entscheidet über Sicherheit,
oft mehr als der Code selbst. **Secrets** sind besonders schützenswerte Konfigurationswerte wie Schlüssel
oder Tokens. Die goldene Regel: Secrets gehören nie in den Quellcode oder in git-verfolgte Dateien, sondern
in einen geeigneten Secret-Store. Der **Rollout-Pfad** beschreibt, wie eine neue Konfiguration ausgerollt und
im Notfall wieder zurückgenommen wird (**Rollback**). Ein Konfigurationsfehler darf nie eine offene
Kommunikation oder erweiterte Rechte auslösen.

**EN:** A networked system behaves differently depending on its **configuration**: which address a service
has, which port is open, whether encryption is on. Configuration decides security, often more than the code
itself. **Secrets** are especially sensitive configuration values such as keys or tokens. The golden rule:
secrets never belong in source code or git-tracked files, but in a suitable secret store. The **rollout
path** describes how a new configuration is deployed and, in an emergency, taken back (**rollback**). A
configuration error must never cause open communication or escalated permissions.

**DE:** In dieser Einheit lernst du, Konfigurationsquellen und Secret-Grenzen zu trennen, erlaubte und
verbotene Speicherorte festzulegen, Rollout- und Rückfallpfade nachvollziehbar zu planen und
Änderungsnachweise vorzusehen. Es werden ausschließlich eindeutig synthetische Beispielwerte verwendet.

**EN:** In this unit you learn to separate configuration sources from secret boundaries, define allowed and
forbidden storage locations, plan rollout and rollback paths traceably, and provide change evidence. Only
clearly synthetic example values are used.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Konfiguration / Configuration | Einstellwerte, die das Verhalten eines Systems steuern. |
| Secret / Secret | Besonders schützenswerter Wert wie Schlüssel, Token oder Passwort. |
| Secret-Store / Secret store | Geschützter Speicher für Secrets, getrennt vom Quellcode. |
| Rollout / Rollout | Geordnetes Ausrollen einer neuen Konfiguration oder Version. |
| Rollback / Rollback | Geplante Rücknahme auf einen vorherigen, funktionierenden Stand. |
| Änderungsnachweis / Change evidence | Nachvollziehbarer Beleg, wer wann was geändert hat. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Konfigurationsquellen trennen.** Woher kommen Einstellwerte? Aus einer Datei, aus
Umgebungsvariablen, aus einem zentralen Dienst? Trenne normale Konfiguration (z. B. Adresse eines Dienstes)
klar von Secrets. Beide werden völlig unterschiedlich behandelt.

**EN:** **Step 1 – Separate configuration sources.** Where do settings come from? From a file, from
environment variables, from a central service? Clearly separate normal configuration (e.g. a service address)
from secrets. Both are handled completely differently.

**DE:** **Schritt 2 – Erlaubte und verbotene Speicherorte festlegen.** Normale Konfiguration darf in
git-verfolgte Dateien. Secrets dürfen das nie. Verbotene Orte für Secrets: Quellcode, Markdown, Logs,
Testdaten, git-Historie. Erlaubter Ort: ein Secret-Store (z. B. Plattform-Schlüsselbund). Warum so streng?
Ein Secret in git ist praktisch für immer offen, auch nach dem Löschen.

**EN:** **Step 2 – Define allowed and forbidden storage locations.** Normal configuration may go into
git-tracked files. Secrets never may. Forbidden places for secrets: source code, markdown, logs, test data,
git history. Allowed place: a secret store (e.g. a platform keychain). Why so strict? A secret in git is
practically exposed forever, even after deletion.

**DE:** **Schritt 3 – Sichere Defaults setzen.** Die Standardkonfiguration muss sicher sein: Verschlüsselung
an, unnötige Ports zu, minimale Rechte. Warum? Wer eine Einstellung vergisst, soll auf der sicheren Seite
landen (Fail-Safe Default), nicht auf der offenen.

**EN:** **Step 3 – Set secure defaults.** The default configuration must be secure: encryption on, unneeded
ports closed, minimal rights. Why? Whoever forgets a setting should land on the safe side (fail-safe
default), not the open one.

**DE:** **Schritt 4 – Rollout und Rollback planen.** Beschreibe die Schritte, in denen eine neue
Konfiguration ausgerollt wird, und den Rückweg, falls etwas schiefgeht. Ein Rollout ohne geplanten Rollback
ist ein Risiko: Man kommt nicht mehr sauber zurück. Rollout-Entscheidungen brauchen Review- oder
Testevidenz.

**EN:** **Step 4 – Plan rollout and rollback.** Describe the steps in which a new configuration is deployed
and the way back if something goes wrong. A rollout without a planned rollback is a risk: you cannot return
cleanly. Rollout decisions need review or test evidence.

**DE:** **Schritt 5 – Änderungsnachweis vorsehen.** Jede Konfigurationsänderung soll nachvollziehbar sein:
Wer hat wann was geändert und warum? Dieser Änderungsnachweis ist wichtig für Fehlersuche und Audit, ganz im
Sinne von Change Management.

**EN:** **Step 5 – Provide change evidence.** Every configuration change should be traceable: who changed
what, when, and why? This change evidence is important for troubleshooting and audit, in the spirit of change
management.

**DE:** **Typische Fehler.** Secrets in git oder Logs. Beispielwerte, die echt aussehen. Unsichere Defaults
(z. B. Verschlüsselung aus). Rollout ohne Rollback. Keine Änderungsnachweise. Konfigurationsfehler, der
Rechte erweitert oder Kommunikation öffnet.

**EN:** **Common mistakes.** Secrets in git or logs. Example values that look real. Insecure defaults (e.g.
encryption off). Rollout without rollback. No change evidence. A configuration error that escalates
permissions or opens communication.

### Beispiel / Example

```text
Konfigurations- und Secret-Matrix (Auszug):
  Wert                    Art            Speicherort erlaubt?     Default
  Adresse Falldienst      Konfiguration  git-Datei: ja            verschluesselt
  Offener Port            Konfiguration  git-Datei: ja            nur benoetigter Port
  API-Schluessel          SECRET         git/Log/Code: NEIN       nur Secret-Store
  DB-Passwort             SECRET         git/Log/Code: NEIN       nur Secret-Store

Beispielwert (synthetisch): API_KEY = <PLATZHALTER-KEIN-ECHTER-WERT>
Rollout: Stufe 1 Testzone -> Stufe 2 Betrieb; Rollback: vorherige Konfig zurueckspielen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Sichere Konfiguration, Secret-Schutz und kontrollierter Rollout sind zentrale Betriebs- und Sicherheitsaufgaben vernetzter Systeme. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Konfiguration von Adressen, Ports und Verschlüsselung gehört zur sicheren Bereitstellung von Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Least Privilege, Change Management
und Secret-Schutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_05` (Konfiguration/Secrets), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Betrieb/Konfiguration). Die
Sicherheitsentscheidung dieser Einheit lautet: *Secrets liegen nur in einem Secret-Store; Standardwerte sind
sicher, und jede Änderung ist nachvollziehbar mit Rückfallpfad.* A11Y-Aspekt: Die Konfigurations- und
Secret-Matrix ist eine beschriftete Tabelle mit den Wörtern „ja" und „NEIN"; Verbote werden nicht nur farbig
markiert, damit sie mit Screenreader und Braille-Zeile klar bleiben.

**EN:** Relation to the Secure Development Guideline: secure configuration, least privilege, change
management, and secret protection. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_05` (configuration/secrets), `CL_08` (security code review), and `CL_10`
(operations/configuration). The security decision of this unit is: *secrets live only in a secret store;
defaults are secure, and every change is traceable with a rollback path.* Accessibility aspect: the
configuration and secret matrix is a labeled table using the words "yes" and "NO"; prohibitions are not
marked by color alone, so they stay clear with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehören Secrets nie in git-verfolgte Dateien? /
   **EN:** Why do secrets never belong in git-tracked files?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret in git bleibt in der Historie praktisch für immer offen, auch nach dem Löschen. Es
   gehört in einen Secret-Store, getrennt vom Quellcode.
   **EN:** A secret in git stays practically exposed forever in the history, even after deletion. It belongs
   in a secret store, separate from source code.

   </details>

2. **DE:** Warum trennt man normale Konfiguration und Secrets? /
   **EN:** Why separate normal configuration from secrets?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie haben unterschiedlichen Schutzbedarf und unterschiedliche Speicherorte. Konfiguration darf in
   git, Secrets nur in den Secret-Store. Trennung verhindert versehentliche Secret-Lecks.
   **EN:** They have different protection needs and different storage locations. Configuration may go into
   git, secrets only into the secret store. Separation prevents accidental secret leaks.

   </details>

3. **DE:** (DV) Warum müssen Standardwerte sicher sein (Fail-Safe Default)? /
   **EN:** (DV) Why must default values be secure (fail-safe default)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wer eine Einstellung vergisst, soll auf der sicheren Seite landen: Verschlüsselung an, Ports zu,
   minimale Rechte. Unsichere Defaults öffnen das System schon ohne Angriff.
   **EN:** Whoever forgets a setting should land on the safe side: encryption on, ports closed, minimal
   rights. Insecure defaults open the system even without an attack.

   </details>

4. **DE:** Warum ist ein Rollout ohne geplanten Rollback riskant? /
   **EN:** Why is a rollout without a planned rollback risky?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn die neue Konfiguration Probleme macht, kommt man ohne Rollback nicht sauber auf den letzten
   funktionierenden Stand zurück. Der Rückfallpfad muss vorher feststehen.
   **EN:** If the new configuration causes problems, without a rollback you cannot cleanly return to the last
   working state. The rollback path must be defined in advance.

   </details>

5. **DE:** Warum müssen Beispielwerte eindeutig synthetisch sein? /
   **EN:** Why must example values be clearly synthetic?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein echt aussehender Beispielwert könnte ein echtes Secret sein oder für echt gehalten werden.
   Eindeutig synthetische Werte wie „BEISPIEL-NICHT-ECHT" vermeiden ein Leck und Verwechslungen.
   **EN:** A real-looking example value could be a real secret or be taken for real. Clearly synthetic values
   like "EXAMPLE-NOT-REAL" avoid a leak and confusion.

   </details>

6. **DE:** Wozu dient ein Änderungsnachweis bei Konfiguration? /
   **EN:** What is change evidence for in configuration?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er zeigt nachvollziehbar, wer wann was und warum geändert hat. Das hilft bei Fehlersuche und Audit
   und ist Teil von Change Management.
   **EN:** It shows traceably who changed what, when, and why. This helps with troubleshooting and audit and
   is part of change management.

   </details>

7. **DE:** Warum darf ein Konfigurationsfehler keine erweiterten Rechte auslösen? /
   **EN:** Why must a configuration error not cause escalated permissions?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Fehler soll in den sicheren Zustand fallen, nicht in einen offeneren. Rechteausweitung oder
   offene Kommunikation durch einen Fehler wäre eine gefährliche Sicherheitslücke.
   **EN:** An error should fall into the safe state, not a more open one. Permission escalation or open
   communication through an error would be a dangerous security hole.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Konfigurationsquellen und Secrets klar trennen.
- [ ] erlaubte und verbotene Speicherorte für Secrets benennen.
- [ ] sichere Defaults setzen und begründen.
- [ ] Rollout und Rollback nachvollziehbar planen.
- [ ] Änderungsnachweise vorsehen und nur synthetische Beispielwerte nutzen.

**EN:** I can …

- [ ] clearly separate configuration sources and secrets.
- [ ] name allowed and forbidden storage locations for secrets.
- [ ] set and justify secure defaults.
- [ ] plan rollout and rollback traceably.
- [ ] provide change evidence and use only synthetic example values.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
