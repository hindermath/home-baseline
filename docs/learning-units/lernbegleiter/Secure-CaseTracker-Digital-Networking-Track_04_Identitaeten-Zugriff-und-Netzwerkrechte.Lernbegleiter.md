# Lernbegleiter: Secure CaseTracker Digital Networking Track 04 – Identitäten, Zugriff und Netzwerkrechte / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Segmentierung sagt, welche *Zonen* miteinander sprechen dürfen. Identitäten und Netzwerkrechte sagen,
*wer* etwas tun darf. In einem vernetzten System gibt es nicht nur menschliche Nutzer, sondern auch
**technische Konten**: Ein Dienst meldet sich bei einem anderen Dienst an (Service-zu-Service). Jede
Identität braucht genau die Rechte, die sie für ihre Aufgabe benötigt, und keine mehr. Dieses Prinzip heißt
**Least Privilege**. Ein technisches Konto mit zu vielen Rechten ist ein beliebtes Angriffsziel, weil ein
einziger gestohlener Zugang dann weit reicht.

**EN:** Segmentation says which *zones* may talk to each other. Identities and network permissions say *who*
may do what. A networked system has not only human users but also **technical accounts**: one service logs
in to another (service-to-service). Every identity needs exactly the permissions it requires for its task and
no more. This principle is called **least privilege**. A technical account with too many permissions is a
favorite target, because one stolen access then reaches far.

**DE:** In dieser Einheit lernst du, Rollen, technische Konten und Servicezugriffe getrennt zu beschreiben,
jeder Berechtigung Zweck, Gültigkeit und Grenze zu geben und den Entzug (Revocation) und die Rotation von
Zugängen von Anfang an mitzuplanen. Wichtig: In der Übung werden keine echten Zugangsdaten, Tokens oder
Secrets verwendet.

**EN:** In this unit you learn to describe roles, technical accounts, and service access separately, to give
each permission a purpose, validity, and limit, and to plan revocation and rotation of access from the
start. Important: the exercise uses no real credentials, tokens, or secrets.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Identität / Identity | Nachweisbarer Akteur (Mensch oder Dienst), der Zugriff erhält. |
| Technisches Konto / Technical account | Nicht-menschliches Konto, mit dem ein Dienst handelt. |
| Least Privilege / Least privilege | Jede Identität erhält nur die minimal nötigen Rechte. |
| Revocation / Revocation | Geregelter Entzug einer Berechtigung, wenn sie nicht mehr gebraucht wird. |
| Rotation / Rotation | Regelmäßiger Austausch von Zugängen oder Schlüsseln. |
| Service-zu-Service / Service-to-service | Zugriff eines Dienstes auf einen anderen ohne menschlichen Nutzer. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Identitätsarten trennen.** Liste menschliche Rollen (Sachbearbeitung, Administration)
und technische Konten (Dienst A ruft Dienst B) getrennt auf. Warum? Menschen und Dienste haben
unterschiedliche Lebenszyklen und Risiken. Ein technisches Konto wird oft vergessen und lebt zu lange.

**EN:** **Step 1 – Separate identity types.** List human roles (case worker, administration) and technical
accounts (service A calls service B) separately. Why? Humans and services have different life cycles and
risks. A technical account is often forgotten and lives too long.

**DE:** **Schritt 2 – Jeder Berechtigung Zweck und Grenze geben.** Für jede Berechtigung notierst du: Wozu?
Auf welchen Netzpfad oder welche Ressource? Wie lange gültig? Eine Berechtigung ohne Zweck ist verdächtig
und sollte entfernt werden. Least Privilege heißt: im Zweifel weniger.

**EN:** **Step 2 – Give each permission a purpose and a limit.** For each permission you note: for what? On
which network path or resource? How long valid? A permission without a purpose is suspicious and should be
removed. Least privilege means: when in doubt, less.

**DE:** **Schritt 3 – Servicezugriffe eng führen.** Ein Dienst, der nur Zählwerte an das Monitoring sendet,
braucht keinen Schreibzugriff auf die Falldatenbank. Beschreibe Service-zu-Service-Zugriffe mit Richtung und
Datenklasse, genau wie in der Kommunikationsmatrix, aber jetzt mit der handelnden Identität.

**EN:** **Step 3 – Keep service access tight.** A service that only sends counters to monitoring needs no
write access to the case database. Describe service-to-service access with direction and data class, just
like in the communication matrix, but now with the acting identity.

**DE:** **Schritt 4 – Entzug und Rotation mitplanen.** Zugänge müssen wieder verschwinden können. Plane von
Anfang an, wie eine Berechtigung entzogen (Revocation) und wie ein Zugang regelmäßig ausgetauscht wird
(Rotation). Ohne diesen Prozess sammeln sich alte, vergessene Zugänge, die niemand mehr kontrolliert.

**EN:** **Step 4 – Plan revocation and rotation.** Access must be able to disappear again. Plan from the
start how a permission is revoked and how access is regularly replaced (rotation). Without this process, old
forgotten accesses pile up that nobody controls anymore.

**DE:** **Schritt 5 – Audit ohne unnötigen Personenbezug.** Zugriffe sollen nachvollziehbar sein: Wer hat
wann welchen Übergang genutzt? Plane die Audit-Information so, dass sie prüfbar ist, aber keine unnötigen
personenbezogenen Daten und keine Secrets enthält. Zugriff wird standardmäßig verweigert und nur mit
Begründung gewährt (Fail-Safe Default).

**EN:** **Step 5 – Audit without unnecessary personal data.** Access should be traceable: who used which
transition when? Plan the audit information so that it is verifiable but contains no unnecessary personal
data and no secrets. Access is denied by default and granted only with justification (fail-safe default).

**DE:** **Typische Fehler.** Technische Konten mit Administrationsrechten ausstatten. Berechtigungen ohne
Ablauf vergeben. Revocation und Rotation vergessen. Echte Tokens oder Passwörter in Markdown, Code oder Logs
schreiben. Audit-Logs mit zu vielen personenbezogenen Daten füllen.

**EN:** **Common mistakes.** Giving technical accounts administration rights. Granting permissions without
expiry. Forgetting revocation and rotation. Writing real tokens or passwords into markdown, code, or logs.
Filling audit logs with too much personal data.

### Beispiel / Example

```text
Rollen- und Zugriffsmatrix (Auszug):
  Identität              Typ          Zugriff auf            Recht        Gültigkeit   Zweck
  rolle_sachbearbeitung  Mensch       Falldaten              lesen/schr.  Session      Fallbearbeitung
  konto_monitoring       technisch    Monitoring-Endpunkt    schreiben    90 Tage      Zaehlwerte senden
  konto_monitoring       technisch    Falldatenbank          -            -            VERWEIGERT (Least Privilege)

Revocation/Rotation:
  konto_monitoring: Zugang alle 90 Tage rotieren; bei Dienstende sofort entziehen
Hinweis: Alle Werte sind synthetisch; keine echten Secrets.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Identitäten, Least-Privilege-Rechte und Revocation sind Kernmaßnahmen für den sicheren Betrieb vernetzter Systeme. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Servicezugriffe und Netzrechte gehören zur sicheren Bereitstellung von Netzwerken und Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Least Privilege, Zugangssteuerung, sichere Konfiguration und
Fail-Safe Defaults. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_08` (Sicherheits-Code-Review) und `CL_10` (Betrieb/Konfiguration). Die Sicherheitsentscheidung dieser
Einheit lautet: *Zugriff wird standardmäßig verweigert; jede Berechtigung ist zweckgebunden, befristet und
entziehbar.* A11Y-Aspekt: Die Rollen- und Zugriffsmatrix ist eine beschriftete Tabelle. Verweigerung wird
mit dem Wort „VERWEIGERT" ausgedrückt, nicht nur mit Farbe, damit sie für alle klar erkennbar ist.

**EN:** Relation to the Secure Development Guideline: least privilege, access control, secure configuration,
and fail-safe defaults. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_08` (security code review), and `CL_10` (operations/configuration). The security decision of this unit
is: *access is denied by default; every permission is purpose-bound, time-limited, and revocable.*
Accessibility aspect: the role and access matrix is a labeled table. Denial is expressed with the word
"DENIED", not only with color, so it is clearly recognizable for everyone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum werden menschliche Rollen und technische Konten getrennt betrachtet? /
   **EN:** Why are human roles and technical accounts considered separately?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie haben unterschiedliche Lebenszyklen und Risiken. Technische Konten werden oft vergessen, leben
   zu lange und tragen zu viele Rechte. Getrennte Betrachtung macht beide Arten prüfbar.
   **EN:** They have different life cycles and risks. Technical accounts are often forgotten, live too long,
   and carry too many rights. Separate consideration makes both types auditable.

   </details>

2. **DE:** Was bedeutet Least Privilege für ein technisches Monitoring-Konto? /
   **EN:** What does least privilege mean for a technical monitoring account?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es erhält nur Schreibrecht auf den Monitoring-Endpunkt und keinen Zugriff auf die Falldatenbank.
   Mehr Rechte wären für die Aufgabe unnötig und würden das Risiko erhöhen.
   **EN:** It gets only write access to the monitoring endpoint and no access to the case database. More
   rights would be unnecessary for the task and would increase the risk.

   </details>

3. **DE:** (DV) Warum müssen Revocation und Rotation von Anfang an geplant werden? /
   **EN:** (DV) Why must revocation and rotation be planned from the start?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Prozess sammeln sich alte, vergessene Zugänge, die niemand kontrolliert. Revocation entzieht
   nicht mehr benötigte Rechte, Rotation tauscht Zugänge regelmäßig aus und begrenzt den Schaden bei
   Diebstahl.
   **EN:** Without a process, old forgotten accesses pile up that nobody controls. Revocation removes rights
   no longer needed, rotation regularly replaces access and limits the damage from theft.

   </details>

4. **DE:** Warum darf eine Berechtigung ohne erkennbaren Zweck als verdächtig gelten? /
   **EN:** Why may a permission without a recognizable purpose count as suspicious?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Zweck ist unklar, warum sie existiert. Sie kann ein Überbleibsel oder ein unbeabsichtigter
   Weg sein und sollte entfernt werden, bis der Zweck belegt ist.
   **EN:** Without a purpose it is unclear why it exists. It may be a leftover or an unintended path and
   should be removed until the purpose is proven.

   </details>

5. **DE:** Warum werden in dieser Übung keine echten Secrets verwendet? /
   **EN:** Why does this exercise use no real secrets?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Secrets in Markdown, Code oder Logs sind ein Datenleck. Synthetische Beispielwerte
   vermeiden das Risiko und lehren dennoch die Regeln der Zugangssteuerung.
   **EN:** Real secrets in markdown, code, or logs are a data leak. Synthetic example values avoid the risk
   while still teaching the access-control rules.

   </details>

6. **DE:** Wie plant man ein Audit, ohne den Datenschutz zu verletzen? /
   **EN:** How do you plan an audit without violating privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man protokolliert prüfbar, welche Identität wann welchen Übergang nutzte, aber ohne unnötige
   personenbezogene Daten und ohne Secrets. Datenminimierung bleibt Pflicht.
   **EN:** You log verifiably which identity used which transition when, but without unnecessary personal data
   and without secrets. Data minimization stays mandatory.

   </details>

7. **DE:** Was bedeutet Fail-Safe Default für die Zugriffsentscheidung? /
   **EN:** What does fail-safe default mean for the access decision?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zugriff wird standardmäßig verweigert und nur mit ausdrücklicher Begründung gewährt. Im Zweifel
   oder bei Fehlern bleibt das System im sicheren Zustand geschlossen.
   **EN:** Access is denied by default and granted only with explicit justification. When in doubt or on
   errors, the system stays closed in the safe state.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] menschliche Rollen und technische Konten getrennt beschreiben.
- [ ] jeder Berechtigung Zweck, Gültigkeit und Grenze geben.
- [ ] Servicezugriffe nach Least Privilege eng führen.
- [ ] Revocation und Rotation als Prozess mitplanen.
- [ ] ein Audit ohne unnötigen Personenbezug und ohne echte Secrets planen.

**EN:** I can …

- [ ] describe human roles and technical accounts separately.
- [ ] give each permission a purpose, validity, and limit.
- [ ] keep service access tight per least privilege.
- [ ] plan revocation and rotation as a process.
- [ ] plan an audit without unnecessary personal data and without real secrets.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
