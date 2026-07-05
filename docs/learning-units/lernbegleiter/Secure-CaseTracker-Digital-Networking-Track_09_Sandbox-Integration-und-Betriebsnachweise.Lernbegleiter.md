# Lernbegleiter: Secure CaseTracker Digital Networking Track 09 – Sandbox-Integration und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine **Sandbox** ist eine abgeschottete Arbeitsumgebung mit klaren Grenzen: begrenzter
Netzwerkzugriff, begrenzte Schreibbereiche, kontrollierte Werkzeuge. Für den Digital Networking Track ist
die `absdd-image-sandbox` das Referenzprofil, in dem später gearbeitet wird. In dieser Einheit geht es darum,
den Bezug zur Sandbox zu klären und **Betriebsnachweise** zu planen: nachvollziehbare Belege, dass die
Toolchain funktioniert, welche Netzwerkzugriffe erlaubt sind und wo bewusst von der Referenz abgewichen wird.
Der Leitgedanke im dritten Lehrjahr: Grenzen und Abweichungen werden nicht verschwiegen, sondern begründet.
Eine Abweichung ohne Begründung ist ein Risiko; eine begründete Abweichung ist eine bewusste Entscheidung.

**EN:** A **sandbox** is a sealed-off working environment with clear boundaries: limited network access,
limited write areas, controlled tools. For the Digital Networking track, the `absdd-image-sandbox` is the
reference profile in which work happens later. This unit is about clarifying the sandbox relation and
planning **operational evidence**: traceable proof that the toolchain works, which network access is allowed,
and where you deliberately deviate from the reference. The guiding idea in the third year: boundaries and
deviations are not hidden but justified. A deviation without justification is a risk; a justified deviation
is a conscious decision.

**DE:** In dieser Einheit lernst du, das Sandbox-Zielbild und die genutzten Grenzen zu dokumentieren,
Netzwerkzugriffe, Mounts und Schreibbereiche nachvollziehbar zu beschreiben, Toolchain- und Test-Nachweise
zu benennen und Risiken bei Arbeit außerhalb der Sandbox als `N/A`, `Open` oder Restrisiko zu begründen.

**EN:** In this unit you learn to document the sandbox target picture and the used boundaries, to describe
network access, mounts, and write areas traceably, to name toolchain and test evidence, and to justify risks
of working outside the sandbox as `N/A`, `Open`, or residual risk.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox / Sandbox | Abgeschottete Umgebung mit begrenztem Netz-, Datei- und Werkzeugzugriff. |
| Mount / Mount | Eingebundenes Verzeichnis, das in der Sandbox sichtbar oder beschreibbar ist. |
| Schreibgrenze / Write boundary | Festgelegter Bereich, in den geschrieben werden darf; alles andere bleibt schreibgeschützt. |
| Toolchain / Toolchain | Zusammenspiel der Werkzeuge (Compiler, Tests, Scanner), das reproduzierbar sein soll. |
| Betriebsnachweis / Operational evidence | Nachvollziehbarer Beleg, dass ein Ablauf oder Werkzeug wie erwartet funktioniert. |
| Begründete Abweichung / Justified deviation | Bewusst dokumentierte Abweichung von der Referenz mit Grund und Restrisiko. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Sandbox-Zielbild klären.** Halte fest, dass die spätere Arbeit in der
`absdd-image-sandbox` stattfinden soll und warum: kontrollierter Netzwerkzugriff, begrenzte Schreibbereiche,
reproduzierbare Werkzeuge. Das Zielbild ist der Maßstab, an dem Abweichungen sichtbar werden.

**EN:** **Step 1 – Clarify the sandbox target picture.** Record that later work should happen in the
`absdd-image-sandbox` and why: controlled network access, limited write areas, reproducible tools. The target
picture is the yardstick against which deviations become visible.

**DE:** **Schritt 2 – Netzwerkzugriffe mit Zweck und Grenze beschreiben.** Welche Verbindungen braucht die
Sandbox wirklich? Jeder Netzwerkzugriff bekommt Zweck und Grenze. Standard ist so wenig Netz wie möglich.
Warum? Weniger Netzzugriff bedeutet weniger Angriffsfläche und weniger Wege, über die Daten abfließen können.

**EN:** **Step 2 – Describe network access with purpose and limit.** Which connections does the sandbox
really need? Each network access gets a purpose and a limit. The default is as little network as possible.
Why? Less network access means less attack surface and fewer paths through which data can leak.

**DE:** **Schritt 3 – Mounts und Schreibgrenzen festlegen.** Bestimme, welche Verzeichnisse eingebunden sind
und wohin geschrieben werden darf. Alles andere bleibt schreibgeschützt. So kann ein Fehler oder ein Agent
nicht unbeabsichtigt außerhalb des erlaubten Bereichs schreiben.

**EN:** **Step 3 – Define mounts and write boundaries.** Determine which directories are mounted and where
writing is allowed. Everything else stays read-only. This way an error or an agent cannot unintentionally
write outside the allowed area.

**DE:** **Schritt 4 – Toolchain- und Test-Nachweise benennen.** Welche Werkzeuge müssen laufen (z. B.
Secret-Scan, Tests), und wie belegt man, dass sie funktionieren? Ein Betriebsnachweis ist zum Beispiel eine
Notiz „Secret-Scan lief, 0 Funde" oder „Tests grün". Behauptungen ohne Nachweis zählen nicht.

**EN:** **Step 4 – Name toolchain and test evidence.** Which tools must run (e.g. secret scan, tests), and
how do you prove they work? Operational evidence is, for example, a note "secret scan ran, 0 findings" or
"tests green". Claims without evidence do not count.

**DE:** **Schritt 5 – Abweichungen begründen.** Wenn ausnahmsweise außerhalb der Sandbox gearbeitet wird
oder eine Grenze anders gesetzt ist, wird das nicht verschwiegen. Notiere Grund, Auswirkung und Restrisiko
als `Open` oder begründetes `N/A`. Keine produktiven Daten und keine Secrets kommen in Sandbox- oder
Agentenläufe.

**EN:** **Step 5 – Justify deviations.** If, by way of exception, work happens outside the sandbox or a
boundary is set differently, this is not hidden. Note the reason, effect, and residual risk as `Open` or a
justified `N/A`. No production data and no secrets go into sandbox or agent runs.

**DE:** **Typische Fehler.** Zu viel Netzzugriff „zur Sicherheit" erlauben. Schreibgrenzen offen lassen.
Toolchain-Erfolg behaupten ohne Nachweis. Abweichungen verschweigen. Produktive Daten oder Secrets in die
Sandbox geben.

**EN:** **Common mistakes.** Allowing too much network access "just in case". Leaving write boundaries open.
Claiming toolchain success without evidence. Hiding deviations. Putting production data or secrets into the
sandbox.

### Beispiel / Example

```text
Sandbox-Grenzliste (Auszug):
  Bereich            Einstellung                     Zweck                       Status
  Netzwerk           nur Paketquelle erlaubt         Werkzeuge installieren      erlaubt
  Netzwerk           Zugriff auf Falldienst          -                           NEIN (nicht noetig)
  Schreibbereich     Projektordner beschreibbar      Arbeit am Projekt           erlaubt
  Schreibbereich     Systempfade                     -                           schreibgeschuetzt

Betriebsnachweis: "Secret-Scan lief, 0 Funde"; "Testlauf gruen (Datum notiert)"
Abweichung (Open): Ein Schritt lief ausnahmsweise ausserhalb -> Grund + Restrisiko dokumentiert
Hinweis: keine produktiven Daten, keine echten Secrets in Sandbox-/Agentenlaeufen.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12d Kundenspezifisches cyber-physisches System optimieren | Primär / Primary | Sandbox-Integration und Betriebsnachweise optimieren die reproduzierbare, sichere Arbeitsweise am kundenspezifischen System. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Kontrollierte Netzwerkzugriffe und Toolchain-Nachweise gehören zur nachweisbaren Bereitstellung von Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Entwicklungsumgebung, Sandbox-Grenzen,
Cross-Platform-Nachweise und Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Betrieb/Konfiguration) und `CL_12` (Abschluss/Evidenz). Die
Sicherheitsentscheidung dieser Einheit lautet: *Netz- und Schreibzugriff der Arbeitsumgebung bleiben minimal
und nachweisbar; Abweichungen werden begründet, nicht verschwiegen.* A11Y-Aspekt: Betriebsnachweise werden
als lesbarer Text mit Datum und Ergebnis dokumentiert, nicht als Screenshot ohne Alternativtext, damit sie
mit Screenreader und Braille-Zeile prüfbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure development environment, sandbox boundaries,
cross-platform evidence, and evidence. Matching checklists: `CL_01` (standards applicability), `CL_08`
(security code review), `CL_10` (operations/configuration), and `CL_12` (closeout/evidence). The security
decision of this unit is: *network and write access of the working environment stay minimal and provable;
deviations are justified, not hidden.* Accessibility aspect: operational evidence is documented as readable
text with a date and result, not as a screenshot without alternative text, so it stays auditable with a
screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dienen die Grenzen einer Sandbox? /
   **EN:** What are the boundaries of a sandbox for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie begrenzen Netz-, Datei- und Werkzeugzugriff. So bleibt die Angriffsfläche klein und ein Fehler
   oder Agent kann nicht unbeabsichtigt außerhalb des erlaubten Bereichs wirken.
   **EN:** They limit network, file, and tool access. This keeps the attack surface small and an error or
   agent cannot unintentionally act outside the allowed area.

   </details>

2. **DE:** Warum ist „so wenig Netzzugriff wie möglich" die richtige Grundeinstellung? /
   **EN:** Why is "as little network access as possible" the right default?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weniger Netzzugriff bedeutet weniger Angriffsfläche und weniger Wege für Datenabfluss. Jeder
   Zugriff braucht einen Zweck; ohne Zweck kein Zugriff.
   **EN:** Less network access means less attack surface and fewer paths for data leakage. Every access needs
   a purpose; without a purpose, no access.

   </details>

3. **DE:** (DV) Was ist ein Betriebsnachweis, und warum reicht eine Behauptung nicht? /
   **EN:** (DV) What is operational evidence, and why is a claim not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Betriebsnachweis ist ein nachvollziehbarer Beleg wie „Secret-Scan lief, 0 Funde" oder „Tests
   grün mit Datum". Eine bloße Behauptung ohne Beleg lässt sich nicht prüfen.
   **EN:** Operational evidence is a traceable proof like "secret scan ran, 0 findings" or "tests green with
   date". A mere claim without proof cannot be checked.

   </details>

4. **DE:** Warum werden Abweichungen von der Sandbox begründet statt verschwiegen? /
   **EN:** Why are deviations from the sandbox justified instead of hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine verschwiegene Abweichung ist ein verstecktes Risiko. Eine begründete Abweichung mit Grund und
   Restrisiko ist eine bewusste, prüfbare Entscheidung.
   **EN:** A hidden deviation is a hidden risk. A justified deviation with reason and residual risk is a
   conscious, auditable decision.

   </details>

5. **DE:** Warum dürfen keine produktiven Daten oder Secrets in Sandbox- oder Agentenläufe? /
   **EN:** Why must no production data or secrets go into sandbox or agent runs?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Produktive Daten und Secrets könnten dort protokolliert oder unbeabsichtigt verbreitet werden. Die
   Übung nutzt nur synthetische, ungefährliche Daten.
   **EN:** Production data and secrets could be logged or unintentionally spread there. The exercise uses only
   synthetic, harmless data.

   </details>

6. **DE:** Welche Rolle spielen Schreibgrenzen für die Sicherheit? /
   **EN:** What role do write boundaries play for security?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur der erlaubte Bereich ist beschreibbar, der Rest bleibt schreibgeschützt. So kann ein Fehler
   oder Agent keine Systempfade oder fremde Bereiche verändern.
   **EN:** Only the allowed area is writable, the rest stays read-only. This way an error or agent cannot
   change system paths or foreign areas.

   </details>

7. **DE:** Warum ist ein Textnachweis besser als ein Screenshot ohne Alternativtext? /
   **EN:** Why is a text record better than a screenshot without alternative text?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Textnachweis mit Datum und Ergebnis ist mit Screenreader und Braille-Zeile lesbar. Ein
   Screenshot ohne Alternativtext ist für diese Nutzung unzugänglich und verletzt WCAG 2.2 AA.
   **EN:** A text record with date and result is readable with a screen reader and Braille display. A
   screenshot without alternative text is inaccessible for that use and violates WCAG 2.2 AA.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] das Sandbox-Zielbild und die genutzten Grenzen dokumentieren.
- [ ] Netzwerkzugriffe mit Zweck und Grenze beschreiben.
- [ ] Mounts und Schreibgrenzen festlegen.
- [ ] Toolchain- und Test-Nachweise als Betriebsnachweis benennen.
- [ ] Abweichungen mit Grund und Restrisiko begründen.

**EN:** I can …

- [ ] document the sandbox target picture and the used boundaries.
- [ ] describe network access with purpose and limit.
- [ ] define mounts and write boundaries.
- [ ] name toolchain and test evidence as operational evidence.
- [ ] justify deviations with reason and residual risk.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
