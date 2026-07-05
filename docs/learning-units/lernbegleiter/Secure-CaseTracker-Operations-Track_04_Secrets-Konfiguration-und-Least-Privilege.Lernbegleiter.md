# Lernbegleiter: Secure CaseTracker Operations Track 04 – Secrets, Konfiguration und Least Privilege / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_04_Secrets-Konfiguration-und-Least-Privilege.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein betriebenes System braucht Zugangsdaten: Datenbank-Passwörter, API-Schlüssel, Zertifikate.
Solche Werte heißen **Secrets**. Sie sind wie Schlüssel zu einem Gebäude: Wer sie hat, kommt hinein. Deshalb
dürfen Secrets niemals im Quellcode, in Logs oder in versionierten Konfigurationsdateien stehen. Sie gehören
in einen geschützten **Secret-Speicher** und werden erst zur Laufzeit eingelesen. Dazu kommt das Prinzip
**Least Privilege**: Jeder Dienst und jede Rolle bekommt nur die minimal nötigen Rechte – nicht mehr.

**EN:** An operated system needs credentials: database passwords, API keys, certificates. Such values are
called **secrets**. They are like keys to a building: whoever has them gets in. Therefore secrets must never
be in the source code, in logs, or in versioned configuration files. They belong in a protected **secret
store** and are read only at runtime. Add to this the principle of **least privilege**: every service and
every role gets only the minimum required permissions – no more.

**DE:** In dieser Einheit lernst du, Secrets sauber von Konfiguration zu trennen, sichere Defaults zu wählen,
Berechtigungen nach Least Privilege zu vergeben und Rotationsannahmen (wie oft ein Secret gewechselt wird)
zu planen.

**EN:** In this unit you learn to separate secrets cleanly from configuration, choose secure defaults, grant
permissions by least privilege, and plan rotation assumptions (how often a secret is changed).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Secret / Secret | Vertraulicher Wert wie Passwort, API-Schlüssel oder privates Zertifikat. |
| Secret-Speicher / Secret store | Geschützter Ort für Secrets (z. B. Keychain, Key Vault, Umgebungsdienst). |
| Konfiguration / Configuration | Nicht geheime Einstellungen, die das Verhalten des Systems steuern. |
| Least Privilege / Least privilege | Jede Rolle und jeder Dienst erhält nur die minimal nötigen Rechte. |
| Sichere Defaults / Secure defaults | Voreinstellungen, die im Zweifel den sichereren Weg wählen. |
| Rotation / Rotation | Regelmäßiges Wechseln eines Secrets, um Schäden bei Verlust zu begrenzen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Secrets von Konfiguration trennen.** Nicht jeder Einstellwert ist geheim. Eine
Log-Stufe oder ein Zeitlimit ist Konfiguration und darf versioniert werden. Ein Passwort ist ein Secret und
darf es nicht. Ordne jeden Wert klar zu: geheim oder nicht geheim. Nur so weißt du, was besonders geschützt
werden muss.

**EN:** **Step 1 – Separate secrets from configuration.** Not every setting is secret. A log level or a
timeout is configuration and may be versioned. A password is a secret and must not be. Classify each value
clearly: secret or not secret. Only then do you know what needs special protection.

**DE:** **Schritt 2 – Secrets in den Secret-Speicher.** Geheime Werte gehören in einen geschützten Speicher
und werden erst zur Laufzeit gelesen. Im Code steht nur ein Verweis, nie der Wert selbst. So landet ein
Secret nicht in Git, nicht in Logs und nicht in einem Backup der Quelldateien.

**EN:** **Step 2 – Put secrets in the secret store.** Secret values belong in a protected store and are read
only at runtime. The code holds only a reference, never the value itself. This keeps a secret out of Git, out
of logs, and out of a backup of the source files.

**DE:** **Schritt 3 – Least Privilege vergeben.** Jeder Dienst bekommt genau die Rechte, die er braucht. Ein
Dienst, der nur liest, braucht kein Schreibrecht. Ein Konto für Backups braucht keinen Administratorzugang.
Weniger Rechte bedeuten weniger Schaden, wenn ein Konto missbraucht wird.

**EN:** **Step 3 – Grant least privilege.** Each service gets exactly the permissions it needs. A service
that only reads needs no write permission. An account for backups needs no administrator access. Fewer
permissions mean less damage if an account is misused.

**DE:** **Schritt 4 – Sichere Defaults und Rotation planen.** Voreinstellungen sollen im Zweifel den
sichereren Weg wählen: Verschlüsselung an, Fremdzugriff aus, ausführliche Fehlerdetails aus. Plane außerdem,
wie oft ein Secret gewechselt wird (Rotation) und was passiert, wenn eines kompromittiert ist. Ein Secret,
das nie wechselt, ist ein wachsendes Risiko.

**EN:** **Step 4 – Plan secure defaults and rotation.** Defaults should choose the safer path in doubt:
encryption on, external access off, verbose error details off. Also plan how often a secret is changed
(rotation) and what happens if one is compromised. A secret that never changes is a growing risk.

**DE:** **Typische Fehler.** Passwörter im Code oder in `.env`-Dateien im Repo. Ein Dienstkonto mit
Administratorrechten „zur Sicherheit". Secrets, die in Logs auftauchen. Defaults, die offen statt sicher
sind. Kein Plan, was bei einem geleakten Secret zu tun ist.

**EN:** **Common mistakes.** Passwords in the code or in `.env` files in the repo. A service account with
admin rights "just to be safe". Secrets appearing in logs. Defaults that are open instead of secure. No plan
for what to do when a secret leaks.

### Beispiel / Example

```text
Wert:                DB-Passwort         -> Einstufung: SECRET  -> Secret-Speicher, nur Verweis im Code
Wert:                Log-Stufe "info"    -> Einstufung: KONFIG  -> versionierbar
Berechtigung:        Report-Dienst liest Fälle -> nur Leserecht (kein Schreibrecht)
Sicherer Default:    Fremdzugriff = aus, Verschlüsselung = an, Stack-Trace an Nutzer = aus
Rotation:            DB-Passwort alle 90 Tage; bei Leak sofort neu setzen + Zugriffe prüfen
Nachweis:            Config-/Secret-Matrix, Least-Privilege-Prüfung, N/A mit Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Secret-Schutz, sichere Defaults und Least Privilege sichern den laufenden Betrieb. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Rechte- und Secret-Einstufung setzt den zuvor bewerteten Schutzbedarf um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Zugangssteuerung, Least Privilege
und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(Zugangssteuerung/Rollen), `CL_07` (sichere Konfiguration), `CL_08` (Sicherheits-Review) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Secrets liegen nie im Code oder in
Git; jede Rolle erhält nur minimale Rechte.* A11Y-Aspekt: Die Secret-/Config-Matrix wird als klare
Text-Tabelle geführt, ohne dass die Einstufung nur über Farbe erkennbar ist.

**EN:** Relation to the Secure Development Guideline: secure configuration, access control, least privilege,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_03` (access
control/roles), `CL_07` (secure configuration), `CL_08` (security review), and `CL_12` (documentation/N-A).
The security decision of this unit is: *secrets never live in code or Git; each role gets only minimal
permissions.* Accessibility aspect: the secret/config matrix is kept as a clear text table, so the
classification is not recognizable by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet ein Secret von normaler Konfiguration? /
   **EN:** What distinguishes a secret from normal configuration?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret ist ein vertraulicher Wert (Passwort, Schlüssel, Zertifikat), dessen Kenntnis Zugang
   verschafft. Konfiguration ist nicht geheim (z. B. Log-Stufe). Secrets brauchen besonderen Schutz, Konfig
   darf versioniert werden.
   **EN:** A secret is a confidential value (password, key, certificate) whose knowledge grants access.
   Configuration is not secret (e.g. log level). Secrets need special protection, configuration may be
   versioned.

   </details>

2. **DE:** Warum darf ein Secret nicht im Quellcode oder in Git stehen? /
   **EN:** Why must a secret not be in the source code or in Git?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Code und Git-Historie werden kopiert, geteilt und gesichert. Ein einmal eingecheckter Secret-Wert
   bleibt in der Historie, auch nach dem Löschen. Er gehört in einen Secret-Speicher, im Code steht nur ein
   Verweis.
   **EN:** Code and Git history are copied, shared, and backed up. A secret value once committed stays in the
   history even after deletion. It belongs in a secret store; the code holds only a reference.

   </details>

3. **DE:** Was bedeutet Least Privilege konkret für ein Dienstkonto? /
   **EN:** What does least privilege mean concretely for a service account?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Konto erhält nur die Rechte, die es für seine Aufgabe braucht. Ein nur lesender Dienst bekommt
   kein Schreibrecht, ein Backup-Konto keinen Administratorzugang. Weniger Rechte begrenzen den Schaden bei
   Missbrauch.
   **EN:** The account gets only the permissions it needs for its task. A read-only service gets no write
   permission, a backup account no admin access. Fewer permissions limit the damage if misused.

   </details>

4. **DE:** (SI) Warum sind sichere Defaults wichtiger als spätere Nachbesserung? /
   **EN:** (SI) Why are secure defaults more important than later corrections?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein System läuft oft in der Voreinstellung. Ist der Default offen, ist das System vom ersten Moment
   an unsicher, bis jemand nachbessert. Ein sicherer Default schützt sofort, auch wenn niemand aktiv etwas
   ändert.
   **EN:** A system often runs in its default. If the default is open, the system is insecure from the first
   moment until someone fixes it. A secure default protects immediately, even if nobody actively changes
   anything.

   </details>

5. **DE:** (SI) Warum plant man Rotation für Secrets? /
   **EN:** (SI) Why do you plan rotation for secrets?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret kann unbemerkt geleakt werden. Regelmäßiges Wechseln begrenzt das Zeitfenster, in dem
   ein altes Secret nutzbar ist. Zusätzlich braucht man einen Plan, ein kompromittiertes Secret sofort zu
   ersetzen.
   **EN:** A secret can leak unnoticed. Regular rotation limits the time window in which an old secret is
   usable. In addition you need a plan to replace a compromised secret immediately.

   </details>

6. **DE:** (SI) Wie verhinderst du, dass Secrets in Logs auftauchen? /
   **EN:** (SI) How do you prevent secrets from appearing in logs?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Secrets werden nie direkt in Log-Ausgaben geschrieben; sensible Felder werden maskiert oder
   ausgelassen. Fehlermeldungen zeigen keine Verbindungszeichenketten. Ein Review prüft Logausgaben gezielt
   auf geheime Werte.
   **EN:** Secrets are never written directly into log output; sensitive fields are masked or omitted. Error
   messages show no connection strings. A review specifically checks log output for secret values.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] jeden Einstellwert klar als Secret oder Konfiguration einstufen.
- [ ] erklären, warum Secrets in einen Secret-Speicher und nicht in Git gehören.
- [ ] Berechtigungen nach Least Privilege vergeben und begründen.
- [ ] sichere Defaults für ein betriebenes System benennen.
- [ ] Rotation und das Vorgehen bei einem geleakten Secret planen.

**EN:** I can …

- [ ] classify each setting clearly as secret or configuration.
- [ ] explain why secrets belong in a secret store and not in Git.
- [ ] grant permissions by least privilege and justify them.
- [ ] name secure defaults for an operated system.
- [ ] plan rotation and the procedure for a leaked secret.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_04_Secrets-Konfiguration-und-Least-Privilege.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_04_Secrets-Konfiguration-und-Least-Privilege.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
