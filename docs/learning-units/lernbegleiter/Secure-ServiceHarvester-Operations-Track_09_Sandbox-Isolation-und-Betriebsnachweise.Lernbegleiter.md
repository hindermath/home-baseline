# Lernbegleiter: Secure ServiceHarvester Operations Track 09 – Sandbox, Isolation und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst, der dauerhaft läuft und Daten sammelt, ist ein lohnendes Ziel. Fällt der Dienst in falsche
Hände oder enthält er einen Fehler, soll der Schaden begrenzt bleiben. Dafür sorgt **Isolation**: Der Dienst
läuft in einer abgegrenzten Umgebung, einer **Sandbox**, mit möglichst wenigen Rechten. Er darf nur die Pfade
lesen und schreiben, die er wirklich braucht, und nur die Netzwege nutzen, die erlaubt sind. So wird die
**Angriffsfläche** klein. Zusätzlich braucht der Betrieb **Nachweise**: Beweise, dass der Dienst sauber startet,
gesund läuft und geordnet stoppt.

**EN:** A service that runs continuously and collects data is a worthwhile target. If the service falls into the
wrong hands or contains a flaw, the damage should stay limited. **Isolation** ensures this: the service runs in
a delimited environment, a **sandbox**, with as few privileges as possible. It may only read and write the
paths it really needs and use only the network paths that are allowed. This keeps the **attack surface** small.
In addition, operation needs **evidence**: proof that the service starts cleanly, runs healthily, and stops in
an orderly way.

**DE:** In dieser Einheit lernst du, ein Isolationsprofil zu beschreiben (Mounts, Schreibgrenzen, Netzregeln),
Least Privilege umzusetzen, Secret-Regeln zu benennen und Betriebsnachweise zu führen. Als öffentliche Referenz
dient die `absdd-image-sandbox`; als C#-Referenz `InventarWorkerService`. Die Idee bleibt für C#, Go, Java,
Python, Rust und Swift vergleichbar. Sie betreibt die Artefakte aus Einheit 06 und liefert Nachweise für das
Betriebs-Review in Einheit 10.

**EN:** In this unit you learn to describe an isolation profile (mounts, write boundaries, network rules),
implement least privilege, name secret rules, and keep operational evidence. The public reference is the
`absdd-image-sandbox`; the C# reference is `InventarWorkerService`. The idea stays comparable across C#, Go,
Java, Python, Rust, and Swift. It operates the artifacts from unit 06 and delivers evidence for the operations
review in unit 10.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox / Sandbox | Abgegrenzte Umgebung, in der ein Dienst mit begrenzten Rechten läuft. |
| Isolation / Isolation | Trennung des Dienstes von der übrigen Umgebung, um Schaden zu begrenzen. |
| Least Privilege / Least privilege | Grundsatz: nur die wirklich nötigen Rechte und Pfade vergeben. |
| Mount / Mount | Ein in die Sandbox eingebundener Pfad, meist mit Lese- oder Schreibgrenze. |
| Angriffsfläche / Attack surface | Summe aller Wege, über die ein Angreifer eindringen könnte. |
| Fail-Safe Default / Fail-safe default | Standard: verweigern; nur explizit Erlaubtes ist zugelassen. |
| Betriebsnachweis / Operational evidence | Beleg, dass Start, Health und Stopp geordnet funktionieren. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Isolationsprofil beschreiben.** Lege fest, welche Pfade der Dienst braucht (Mounts) und
ob er sie lesen oder schreiben darf. Trenne Daten, Konfiguration und Logs. Was nicht gebraucht wird, wird nicht
eingebunden. So sieht man auf einen Blick, worauf der Dienst überhaupt zugreifen kann.

**EN:** **Step 1 – Describe the isolation profile.** Define which paths the service needs (mounts) and whether
it may read or write them. Separate data, configuration, and logs. What is not needed is not mounted. This shows
at a glance what the service can access at all.

**DE:** **Schritt 2 – Least Privilege umsetzen.** Der Dienst läuft nicht als Administrator, sondern mit einem
eigenen, schwach berechtigten Konto. Netzwege werden auf das Nötige begrenzt (Fail-Safe: alles verboten, außer
erlaubt). Weniger Rechte bedeuten weniger möglichen Schaden.

**EN:** **Step 2 – Implement least privilege.** The service does not run as administrator but with its own,
low-privileged account. Network paths are limited to what is necessary (fail-safe: everything forbidden except
what is allowed). Fewer privileges mean less possible damage.

**DE:** **Schritt 3 – Secret-Regeln benennen.** Secrets (z. B. Zugangsdaten) gehören nie in Code, Config oder
Logs innerhalb der Sandbox. Im Text stehen nur Platzhalter; echte Werte kommen aus einem Secret-Store. So kann
ein veröffentlichter Nachweis kein echtes Geheimnis verraten.

**EN:** **Step 3 – Name secret rules.** Secrets (e.g. credentials) never belong in code, config, or logs inside
the sandbox. The text contains only placeholders; real values come from a secret store. This way a published
piece of evidence can leak no real secret.

**DE:** **Schritt 4 – Betriebsnachweise führen.** Belege, dass der Dienst in der Sandbox sauber startet, einen
Health-Zustand meldet und auf ein Stopp-Signal geordnet endet. Diese Nachweise zeigen, dass Isolation und
Betrieb wirklich funktionieren – nicht nur behauptet werden. Ist praktische Sandbox-Nutzung am Ausbildungsplatz
noch nicht möglich, wird dies als `N/A` mit Begründung dokumentiert.

**EN:** **Step 4 – Keep operational evidence.** Prove that the service starts cleanly in the sandbox, reports a
health state, and ends in an orderly way on a stop signal. This evidence shows that isolation and operation
really work – not just claimed. If practical sandbox use is not yet possible at the training site, this is
documented as `N/A` with a rationale.

**DE:** **Typische Fehler.** Den Dienst mit vollen Rechten laufen lassen. Alle Pfade schreibbar einbinden.
Netzzugriff pauschal erlauben. Secrets in Config oder Logs ablegen. Behaupten, der Betrieb sei sicher, ohne
Start-, Health- und Shutdown-Nachweis. Nichtnutzung der Sandbox stillschweigend weglassen statt als `N/A` zu
begründen.

**EN:** **Common mistakes.** Running the service with full privileges. Mounting all paths as writable. Allowing
network access broadly. Storing secrets in config or logs. Claiming operation is safe without start, health,
and shutdown evidence. Silently omitting non-use of the sandbox instead of justifying it as `N/A`.

### Beispiel / Example

```text
Mounts:          /data (rw), /config (ro), /logs (rw); alles andere nicht eingebunden
Netz:            nur ausgehend zu Sammelquelle erlaubt; sonst alles verboten (Fail-Safe)
Least Privilege: eigenes schwaches Dienstkonto, kein Administrator
Secrets:         nur Platzhalter <PLATZHALTER-KEIN-ECHTER-WERT>; echte Werte im Secret-Store
Betriebsnachweis: Start-Log + Health = ok + geordneter Shutdown auf Stopp-Signal
Referenz:        absdd-image-sandbox (public);  C#-Referenz InventarWorkerService
N/A-Fall:        praktische Sandbox am Ausbildungsplatz noch nicht möglich -> N/A mit Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Isolation, Least Privilege und Betriebsnachweise sichern den laufenden Dienst. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Der isolierte Dienst wird kontrolliert bereitgestellt und betrieben. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Isolation, Least Privilege, Angriffsflächen-Reduktion,
Fail-Safe Defaults und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07`
(sichere Konfiguration), `CL_08` (Sicherheits-Review), `CL_09` (Umgebung/Reproduzierbarkeit) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Der Dienst läuft mit minimalen Rechten
in einer Sandbox; alles ist verboten außer explizit erlaubt; Betrieb gilt nur mit Start-, Health- und
Shutdown-Nachweis als belegt.* A11Y-Aspekt: Isolationsprofil und Netzregeln werden als klare Textliste
dokumentiert, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: isolation, least privilege, attack-surface reduction,
fail-safe defaults, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_07`
(secure configuration), `CL_08` (security review), `CL_09` (environment/reproducibility), and `CL_12`
(documentation/N-A). The security decision of this unit is: *the service runs with minimal privileges in a
sandbox; everything is forbidden except what is explicitly allowed; operation is only evidenced with start,
health, and shutdown proof.* Accessibility aspect: isolation profile and network rules are documented as a clear
text list, without color-only marking, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Least Privilege und warum verkleinert es den Schaden? /
   **EN:** What does least privilege mean and why does it reduce damage?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Least Privilege heißt, nur die wirklich nötigen Rechte und Pfade zu vergeben. Wird der Dienst
   kompromittiert, kann ein Angreifer nur das erreichen, wozu der Dienst ohnehin berechtigt ist – der Schaden
   bleibt begrenzt.
   **EN:** Least privilege means granting only the truly necessary privileges and paths. If the service is
   compromised, an attacker can only reach what the service is authorized for anyway – the damage stays
   limited.

   </details>

2. **DE:** Warum wird die Angriffsfläche durch Isolation kleiner? /
   **EN:** Why does isolation make the attack surface smaller?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Isolation bindet nur nötige Pfade ein und erlaubt nur nötige Netzwege. Je weniger zugänglich ist,
   desto weniger Wege gibt es, über die ein Angreifer eindringen oder Daten abziehen kann.
   **EN:** Isolation mounts only necessary paths and allows only necessary network paths. The less is
   accessible, the fewer ways there are for an attacker to enter or exfiltrate data.

   </details>

3. **DE:** (SI) Was bedeutet ein Fail-Safe Default für Netz- und Dateizugriff? /
   **EN:** (SI) What does a fail-safe default mean for network and file access?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Standardmäßig ist alles verboten; nur explizit Erlaubtes ist zugelassen. Fehlt eine Regel, gilt
   „verweigern", nicht „erlauben". So entsteht keine Lücke durch Vergessen.
   **EN:** By default everything is forbidden; only what is explicitly allowed is permitted. If a rule is
   missing, "deny" applies, not "allow". This prevents a gap through forgetting.

   </details>

4. **DE:** (SI) Welche Betriebsnachweise zeigen, dass der isolierte Dienst wirklich sauber läuft? /
   **EN:** (SI) Which operational evidence shows that the isolated service really runs cleanly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Start-Nachweis, ein gemeldeter Health-Zustand während des Laufs und ein Nachweis über einen
   geordneten Shutdown auf ein Stopp-Signal. Erst diese drei Belege machen den Betrieb prüfbar.
   **EN:** A start proof, a reported health state during the run, and proof of an orderly shutdown on a stop
   signal. Only these three make operation verifiable.

   </details>

5. **DE:** Warum dürfen Secrets nicht in Config oder Logs innerhalb der Sandbox stehen? /
   **EN:** Why must secrets not be in config or logs inside the sandbox?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Config und Logs werden oft ausgelesen, kopiert oder als Nachweis veröffentlicht. Ein Secret dort
   landet schnell in fremden Händen. Deshalb: nur Platzhalter, echte Werte im Secret-Store.
   **EN:** Config and logs are often read, copied, or published as evidence. A secret there quickly ends up in
   the wrong hands. Therefore: only placeholders, real values in the secret store.

   </details>

6. **DE:** (SI) Wie dokumentierst du, wenn eine praktische Sandbox-Nutzung noch nicht möglich ist? /
   **EN:** (SI) How do you document when practical sandbox use is not yet possible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung und einer Folgeaktion, nicht durch stilles Weglassen. So
   bleibt sichtbar, dass die Sandbox geprüft wurde und warum sie hier noch nicht genutzt wird.
   **EN:** As `N/A` with a short technical rationale and a follow-up action, not by silent omission. This keeps
   visible that the sandbox was considered and why it is not yet used here.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein Isolationsprofil mit Mounts, Schreibgrenzen und Netzregeln beschreiben.
- [ ] Least Privilege für einen langlaufenden Dienst umsetzen.
- [ ] einen Fail-Safe Default für Netz- und Dateizugriff erklären.
- [ ] Secret-Regeln mit Platzhaltern statt echten Werten anwenden.
- [ ] Betriebsnachweise (Start, Health, Shutdown) benennen und `N/A`-Fälle begründen.

**EN:** I can …

- [ ] describe an isolation profile with mounts, write boundaries, and network rules.
- [ ] implement least privilege for a long-running service.
- [ ] explain a fail-safe default for network and file access.
- [ ] apply secret rules with placeholders instead of real values.
- [ ] name operational evidence (start, health, shutdown) and justify `N/A` cases.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
