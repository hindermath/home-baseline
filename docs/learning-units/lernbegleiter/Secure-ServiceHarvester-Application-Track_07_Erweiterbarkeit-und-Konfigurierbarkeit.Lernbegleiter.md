# Lernbegleiter: Secure ServiceHarvester Application Track 07 – Erweiterbarkeit und Konfigurierbarkeit / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst, der lange lebt, muss sich anpassen lassen, ohne dass man ihn jedes Mal umbaut.
**Erweiterbarkeit** heißt: Neue Fähigkeiten (z. B. eine weitere Sammel-Quelle oder ein anderer
Persistenz-Speicher) lassen sich hinzufügen, ohne den Kern zu ändern. **Konfigurierbarkeit** heißt: Verhalten
lässt sich über Einstellungen steuern, ohne den Code neu zu schreiben. Bild dazu: eine Bohrmaschine mit
Wechselaufsätzen. Das Gerät bleibt gleich; die Aufsätze (Adapter) machen den Unterschied. Wichtig ist, dass
der **Anschluss** – der Vertrag – stabil bleibt.

**EN:** A service that lives long must be adaptable without being rebuilt each time. **Extensibility** means:
new capabilities (e.g. another collection source or a different persistence store) can be added without
changing the core. **Configurability** means: behavior can be steered through settings without rewriting the
code. The picture: a drill with interchangeable bits. The device stays the same; the bits (adapters) make the
difference. What matters is that the **socket** – the contract – stays stable.

**DE:** Du lernst, Erweiterungspunkte als stabile Verträge (Ports) zu schneiden, austauschbare Bausteine
(Adapter) davon zu trennen, Konfiguration als nicht vertrauenswürdige Eingabe zu behandeln und Secrets aus dem
Quellcode herauszuhalten. Jede Erweiterungsstelle ist ein Trade-off zwischen Flexibilität und Angriffsfläche.
Als C#-Referenz dient `InventarWorkerService`; der Entwurf bleibt sprachneutral.

**EN:** You learn to cut extension points as stable contracts (ports), separate replaceable building blocks
(adapters) from them, treat configuration as untrusted input, and keep secrets out of source code. Each
extension point is a trade-off between flexibility and attack surface. `InventarWorkerService` serves as a C#
reference, but the design stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Erweiterbarkeit / Extensibility | Fähigkeit, neue Funktionen hinzuzufügen, ohne den Kern zu ändern. |
| Konfigurierbarkeit / Configurability | Steuerung des Verhaltens über Einstellungen statt über Codeänderung. |
| Port / Port | Stabiler Vertrag (Interface), an dem austauschbare Bausteine andocken. |
| Adapter / Adapter | Austauschbarer Baustein, der einen Port für eine konkrete Technik umsetzt. |
| Sicherer Default / Secure default | Voreinstellung, die ohne gültige Konfiguration den sichersten Zustand wählt. |
| Angriffsfläche / Attack surface | Summe aller Stellen, an denen ein System angegriffen werden kann. |
| Secret-Store / Secret store | Geschützter Ort für Geheimnisse, z. B. Keychain oder Key Vault. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Erweiterungspunkte als Ports schneiden.** Frage dich: Was wird sich wahrscheinlich ändern?
Genau dort setzt du einen **Port** – einen kleinen, stabilen Vertrag. Beispiel: ein `SnapshotStore`-Port mit
`speichern` und `laden`. Ob dahinter eine Datei, eine Datenbank oder ein Testspeicher steckt, ist ein Adapter.
Der Kern kennt nur den Port.

**EN:** **Step 1 – Cut extension points as ports.** Ask yourself: what is likely to change? Exactly there you
place a **port** – a small, stable contract. Example: a `SnapshotStore` port with `save` and `load`. Whether a
file, a database, or a test store sits behind it is an adapter. The core knows only the port.

**DE:** **Schritt 2 – Bausteine austauschbar halten.** Jeder Adapter setzt genau einen Port um und bleibt
ersetzbar. So kannst du eine Technik gegen eine andere tauschen, ohne den Kern zu berühren (Separation of
Concerns). Für Tests nutzt du oft einen einfachen In-Memory-Adapter.

**EN:** **Step 2 – Keep building blocks replaceable.** Each adapter implements exactly one port and stays
replaceable. This lets you swap one technology for another without touching the core (separation of concerns).
For tests you often use a simple in-memory adapter.

**DE:** **Schritt 3 – Konfiguration als nicht vertrauenswürdige Eingabe behandeln.** Konfiguration kommt von
außen und kann falsch, unvollständig oder manipuliert sein. Validiere jeden Wert: Typ, erlaubter Bereich,
Pflichtangabe. Ein ungültiger Wert führt zu einem sicheren Fehlverhalten, nicht zu einem stillen falschen
Standard. Warum? Weil eine falsche Konfiguration sonst unbemerkt Sicherheit aushebeln kann.

**EN:** **Step 3 – Treat configuration as untrusted input.** Configuration comes from outside and can be wrong,
incomplete, or manipulated. Validate each value: type, allowed range, required. An invalid value leads to safe
failing behavior, not to a silent wrong default. Why? Because a wrong configuration could otherwise silently
undermine security.

**DE:** **Schritt 4 – Sichere Defaults setzen.** Solange keine gültige abweichende Einstellung vorliegt, gilt
der sicherste Wert: Zugriff verweigert, Sammelintervall konservativ, ausführliche Debug-Ausgaben aus. So ist
das System auch ohne vollständige Konfiguration nicht unsicher (Fail-Safe-Defaults).

**EN:** **Step 4 – Set secure defaults.** As long as no valid deviating setting exists, the safest value
applies: access denied, collection interval conservative, verbose debug output off. This way the system is not
insecure even without complete configuration (fail-safe defaults).

**DE:** **Schritt 5 – Secrets und Angriffsfläche im Blick.** Secrets (Zugangsdaten, Schlüssel) gehören in einen
Secret-Store, niemals in Quellcode oder getrackte Konfigurationsdateien. Im Repository stehen nur Platzhalter
wie `<PLATZHALTER-KEIN-ECHTER-WERT>`. Reduziere außerdem die Angriffsfläche: Deaktiviere oder entferne
ungenutzte Erweiterungspunkte. Jeder offene Port, den niemand braucht, ist ein unnötiges Risiko.

**EN:** **Step 5 – Keep secrets and attack surface in view.** Secrets (credentials, keys) belong in a secret
store, never in source code or tracked configuration files. The repository holds only placeholders like
`<PLATZHALTER-KEIN-ECHTER-WERT>`. Also reduce the attack surface: disable or remove unused extension points.
Every open port that no one needs is an unnecessary risk.

**DE:** **Typische Fehler.** Erweiterungspunkte überall verstreuen statt gezielt setzen. Adapter-Details in den
Kern lecken lassen. Konfiguration ungeprüft übernehmen. Unsichere Defaults (z. B. Zugriff standardmäßig
erlaubt). Secrets im Code. Ungenutzte Erweiterungspunkte offen lassen.

**EN:** **Common mistakes.** Scattering extension points everywhere instead of placing them deliberately.
Letting adapter details leak into the core. Accepting configuration unchecked. Insecure defaults (e.g. access
allowed by default). Secrets in code. Leaving unused extension points open.

### Beispiel / Example

```text
Port (stabiler Vertrag):   SnapshotStore { speichern(snapshot); laden(id) }
Adapter (austauschbar):    DateiStore | DatenbankStore | InMemoryStore (Test)

Konfiguration (validiert):
  store.typ           = "datei"        -> erlaubt: {datei, datenbank}   sonst: Start abgelehnt
  sammel.intervall_s  = 60             -> erlaubt: 10..3600             sonst: sicherer Default 300
  debug.verbose       = false          -> Default: false (sicher)

Secret:  store.datenbank.passwort = <PLATZHALTER-KEIN-ECHTER-WERT>   (aus Secret-Store, nicht im Repo)

Trade-off-Notiz:
  Port SnapshotStore erhöht Flexibilität (Speicher tauschbar),
  Kosten: eine zusätzliche Schnittstelle als Angriffs-/Testfläche -> bewusst akzeptiert, validiert getestet.
Ungenutzt: Port "RemotePush" derzeit nicht gebraucht -> deaktiviert (Angriffsfläche reduziert).
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Erweiterbarkeit und Konfiguration ermöglichen die kundenspezifische Anpassung des Dienstes ohne Kernumbau. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Konfiguration, Secrets und Erweiterungspunkte bestimmen Schutzbedarf und Angriffsfläche. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Least Privilege, Fail-Safe-Defaults,
Angriffsflächenreduktion und Separation of Concerns. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (Eingabe-/Konfigurationsvalidierung), `CL_08` (Sicherheits-Code-Review) und
`CL_11` (sichere Konfiguration und Secrets). Die Sicherheitsentscheidung dieser Einheit lautet:
*Erweiterungspunkte bleiben stabile, minimale Verträge, Konfiguration wird validiert, Defaults sind sicher und
Secrets liegen im Secret-Store.* A11Y-Aspekt: Konfigurationsoptionen und Trade-off-Tabellen werden als klarer,
strukturierter Text dargestellt, damit sie mit Screenreader und Braille-Zeile nachvollziehbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure configuration, least privilege, fail-safe defaults,
attack surface reduction, and separation of concerns. Matching checklists: `CL_01` (standards applicability),
`CL_02` (input/configuration validation), `CL_08` (security code review), and `CL_11` (secure configuration and
secrets). The security decision of this unit is: *extension points stay stable, minimal contracts,
configuration is validated, defaults are secure, and secrets live in the secret store.* Accessibility aspect:
configuration options and trade-off tables are presented as clear, structured text so they remain followable
with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist der Unterschied zwischen einem Port und einem Adapter? /
   **EN:** What is the difference between a port and an adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Port ist der stabile Vertrag (Interface), an dem der Kern andockt. Ein Adapter ist die
   austauschbare Umsetzung dieses Vertrags für eine konkrete Technik. Der Kern kennt nur den Port.
   **EN:** A port is the stable contract (interface) the core docks to. An adapter is the replaceable
   implementation of that contract for a concrete technology. The core knows only the port.

   </details>

2. **DE:** Warum wird Konfiguration als nicht vertrauenswürdige Eingabe behandelt? /
   **EN:** Why is configuration treated as untrusted input?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie kommt von außen und kann falsch oder manipuliert sein. Eine ungeprüfte Konfiguration kann
   unbemerkt Sicherheit aushebeln. Deshalb werden Werte validiert und ungültige Werte sicher abgelehnt.
   **EN:** It comes from outside and can be wrong or manipulated. Unchecked configuration can silently undermine
   security. Therefore values are validated and invalid values safely rejected.

   </details>

3. **DE:** Warum ist ein sicherer Default wichtig, wenn eine Einstellung fehlt? /
   **EN:** Why is a secure default important when a setting is missing?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne sichere Defaults wäre das System bei unvollständiger Konfiguration unsicher. Der sicherste Wert
   (z. B. Zugriff verweigert) gilt, bis eine gültige abweichende Einstellung vorliegt.
   **EN:** Without secure defaults, the system would be insecure with incomplete configuration. The safest value
   (e.g. access denied) applies until a valid deviating setting exists.

   </details>

4. **DE:** Warum reduziert das Entfernen ungenutzter Erweiterungspunkte das Risiko? /
   **EN:** Why does removing unused extension points reduce risk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder offene Erweiterungspunkt vergrößert die Angriffsfläche und muss getestet und gepflegt werden.
   Was niemand braucht, wird deaktiviert oder entfernt – weniger Angriffsfläche, weniger Wartung.
   **EN:** Every open extension point enlarges the attack surface and must be tested and maintained. What no one
   needs is disabled or removed – less attack surface, less maintenance.

   </details>

5. **DE:** Warum gehören Secrets nicht in den Quellcode? /
   **EN:** Why do secrets not belong in source code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Quellcode wird kopiert, geteilt und versioniert; ein Secret darin ist praktisch veröffentlicht.
   Secrets gehören in einen Secret-Store, im Repo stehen nur Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Source code is copied, shared, and versioned; a secret in it is practically published. Secrets belong
   in a secret store; the repo holds only placeholders like `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

6. **DE:** (AE) Wieso ist eine Erweiterungsstelle immer auch ein Trade-off? /
   **EN:** (AE) Why is an extension point always also a trade-off?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie bringt Flexibilität, kostet aber eine zusätzliche Schnittstelle, mehr Testfläche und mehr
   mögliche Angriffspunkte. Man wägt Nutzen gegen Aufwand und Risiko ab und begründet die Entscheidung.
   **EN:** It brings flexibility but costs an extra interface, more test surface, and more possible attack
   points. You weigh benefit against effort and risk and justify the decision.

   </details>

7. **DE:** (SI) Wie hilft ein In-Memory-Adapter beim Testen und Betrieb? /
   **EN:** (SI) How does an in-memory adapter help testing and operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er setzt denselben Port ohne echte Infrastruktur um. Tests laufen schnell und reproduzierbar, ohne
   Datenbank oder Netzwerk, und der Kern bleibt unverändert.
   **EN:** It implements the same port without real infrastructure. Tests run fast and reproducibly, without a
   database or network, and the core stays unchanged.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Erweiterungspunkte als stabile, minimale Ports schneiden.
- [ ] austauschbare Adapter vom Kern trennen.
- [ ] Konfiguration als nicht vertrauenswürdige Eingabe validieren.
- [ ] sichere Defaults setzen und begründen.
- [ ] Secrets im Secret-Store halten und Angriffsfläche reduzieren.

**EN:** I can …

- [ ] cut extension points as stable, minimal ports.
- [ ] separate replaceable adapters from the core.
- [ ] validate configuration as untrusted input.
- [ ] set and justify secure defaults.
- [ ] keep secrets in the secret store and reduce attack surface.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
