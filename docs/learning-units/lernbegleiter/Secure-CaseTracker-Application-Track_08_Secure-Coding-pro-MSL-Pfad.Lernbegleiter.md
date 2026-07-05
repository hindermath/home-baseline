# Lernbegleiter: Secure CaseTracker Application Track 08 – Secure Coding pro MSL-Pfad / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_08_Secure-Coding-pro-MSL-Pfad.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Dieselbe sichere Idee sieht in jeder Programmiersprache etwas anders aus. Eine **speichersichere
Sprache** (Memory-Safe Language, MSL) wie C#, Go, Java, Python, Rust oder Swift nimmt dir zwar viele klassische
Speicherfehler ab, aber sie garantiert **keinen** sicheren Code: Eingabeprüfung, Autorisierung, sichere
Deserialisierung, Krypto und Abhängigkeitspflege bleiben deine Aufgabe. In dieser Einheit machst du je
Zielsprache die passenden **Secure-Coding-Regeln** sichtbar und vergleichst sie in einer Matrix. Bild dazu:
verschiedene Werkstätten mit unterschiedlichem Werkzeug. Die Sicherheitsregel „trage Schutzbrille" gilt
überall, aber der konkrete Griff zum richtigen Werkzeug ist je Werkstatt anders.

**EN:** The same secure idea looks a bit different in each programming language. A **memory-safe language**
(MSL) like C#, Go, Java, Python, Rust, or Swift relieves you of many classic memory errors, but it guarantees
**no** secure code: input validation, authorization, safe deserialization, crypto, and dependency care remain
your job. In this unit you surface the matching **secure-coding rules** per target language and compare them
in a matrix. The picture: different workshops with different tools. The safety rule "wear goggles" applies
everywhere, but the concrete grip for the right tool differs per workshop.

**DE:** Du lernst, dass MSL-Status ein Vorteil ist, aber kein Freibrief – und dass Secure Coding sprachnah,
konkret und mit Abhängigkeitsprüfung belegt sein muss.

**EN:** You learn that MSL status is an advantage but no free pass – and that secure coding must be
language-specific, concrete, and backed by a dependency check.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| MSL / MSL | Speichersichere Sprache; verhindert viele, aber nicht alle Sicherheitsfehler. |
| Secure Coding / Secure coding | Programmierpraktiken, die bekannte Schwachstellen vermeiden. |
| Deserialisierung / Deserialization | Umwandlung von Daten in Objekte; ein häufiger Angriffspunkt. |
| Dependency-Prüfung / Dependency check | Kontrolle von Bibliotheken auf bekannte kritische Schwachstellen (CVEs). |
| Secure-Coding-Matrix / Secure-coding matrix | Vergleich der Regeln je Sprache und Risikofeld. |
| Krypto-Mindestvorgabe / Crypto minimum requirement | Regel, aktuelle Algorithmen zu nutzen, veraltete zu vermeiden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Risikofelder festlegen.** Bestimme die Themen, die in jeder Sprache geprüft werden:
Eingabeprüfung, Deserialisierung, Autorisierung, Fehler-/Logging-Verhalten, Krypto, Abhängigkeiten. So bleibt
der Vergleich fair und vollständig.

**EN:** **Step 1 – Define the risk fields.** Determine the topics checked in each language: input validation,
deserialization, authorization, error/logging behavior, crypto, dependencies. This keeps the comparison fair
and complete.

**DE:** **Schritt 2 – Regeln je Sprache konkret machen.** Beispiele: In **Rust** wird `unsafe` isoliert und
begründet, Panics aus fremdem Input werden vermieden. In **Go** werden Timeouts und `context` gesetzt,
`crypto/rand` genutzt, `govulncheck` gefahren. In **Python** wird unsichere Deserialisierung und dynamische
Ausführung vermieden, `subprocess` eingeschränkt. In **C#** werden Queries parametrisiert und Ausgaben gegen
XSS kodiert. In **Java/Kotlin** werden DTOs validiert und Deserialisierung beschränkt. In **Swift** werden
Force-Unwraps auf fremden Daten vermieden. Warum konkret? „Sei sicher" hilft niemandem; die sprachnahe Regel
ist prüfbar.

**EN:** **Step 2 – Make rules concrete per language.** Examples: in **Rust**, `unsafe` is isolated and
justified, panics from untrusted input are avoided. In **Go**, timeouts and `context` are set, `crypto/rand`
is used, `govulncheck` is run. In **Python**, unsafe deserialization and dynamic execution are avoided,
`subprocess` is restricted. In **C#**, queries are parameterized and output is encoded against XSS. In
**Java/Kotlin**, DTOs are validated and deserialization is restricted. In **Swift**, force-unwraps on
untrusted data are avoided. Why concrete? "Be secure" helps no one; the language-specific rule is verifiable.

**DE:** **Schritt 3 – Gemeinsames sichtbar halten.** Trotz Unterschieden gelten überall: Eingaben an
Vertrauensgrenzen prüfen, Autorisierung serverseitig, keine Interna in Fehlern, aktuelle Krypto (AES-256,
SHA-256+, Ed25519), keine veralteten Verfahren (MD5, SHA-1 für Signaturen) ohne begründete Ausnahme.

**EN:** **Step 3 – Keep the common part visible.** Despite differences, everywhere applies: check inputs at
trust boundaries, authorize server-side, no internals in errors, current crypto (AES-256, SHA-256+, Ed25519),
no deprecated methods (MD5, SHA-1 for signatures) without a justified exception.

**DE:** **Schritt 4 – Abhängigkeiten prüfen und N/A begründen.** Führe je Sprache eine Dependency-Prüfung
durch (z. B. `cargo audit`, `govulncheck`, `pip-audit`). Was nicht anwendbar ist, wird als `N/A` mit kurzer
technischer Begründung dokumentiert, nicht still weggelassen.

**EN:** **Step 4 – Check dependencies and justify N/A.** Run a dependency check per language (e.g. `cargo
audit`, `govulncheck`, `pip-audit`). Whatever is not applicable is documented as `N/A` with a short technical
rationale, not silently omitted.

**DE:** **Typische Fehler.** MSL-Status als „automatisch sicher" missverstehen. Regeln zu allgemein halten.
Deserialisierung und dynamische Ausführung unterschätzen. Veraltete Krypto ohne Begründung nutzen.
Abhängigkeiten ungeprüft übernehmen. Nichtanwendbarkeit still übergehen statt `N/A` zu begründen.

**EN:** **Common mistakes.** Misreading MSL status as "automatically secure". Keeping rules too general.
Underestimating deserialization and dynamic execution. Using deprecated crypto without justification. Taking
dependencies unchecked. Silently passing over non-applicability instead of justifying `N/A`.

### Beispiel / Example

```text
Secure-Coding-Matrix (Auszug)
Risikofeld        | Rust                 | Go                   | Python
Deserialisierung  | validiertes Parsen   | strikte Typen        | kein pickle auf Fremddaten
Nebenläufigkeit   | unsafe isolieren     | context + Timeout    | subprocess einschränken
Abhängigkeiten    | cargo audit          | govulncheck          | pip-audit

Gemeinsam (alle Sprachen): Eingaben an der Grenze prüfen, Autorisierung serverseitig,
   keine Interna in Fehlern, aktuelle Krypto (AES-256/SHA-256+/Ed25519).

N/A-Beispiel: "Kein SQL im Projekt -> SQL-Parametrisierung N/A (dateibasierte Persistenz)."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Sprachnahes Secure Coding ist die konkrete, sichere Umsetzung von Funktionalität in der jeweiligen Zielsprache. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Secure-Coding-Matrix ordnet Schutzmaßnahmen den Risikofeldern des eigenen Arbeitsbereichs zu. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung je Sprache, Krypto-Mindestvorgaben
und Lieferkettenpflege. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(Krypto-Mindestvorgaben) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit
lautet: *MSL-Status entbindet nicht von Secure Coding; jede Sprache bekommt konkrete, geprüfte Regeln.*
A11Y-Aspekt: Die Secure-Coding-Matrix ist eine echte Texttabelle mit Zeilen- und Spaltenüberschriften; die
Bedeutung einer Zelle darf nicht allein über Farbe oder ein Symbol signalisiert werden, damit sie mit
Screenreader und Braille-Zeile lesbar bleibt.

**EN:** Relation to the Secure Development Guideline: secure programming per language, crypto minimum
requirements, and supply-chain care. Matching checklists: `CL_01` (standards applicability), `CL_03` (crypto
minimum requirements), and `CL_08` (security code review). The security decision of this unit is: *MSL status
does not release you from secure coding; every language gets concrete, checked rules.* Accessibility aspect:
the secure-coding matrix is a real text table with row and column headers; the meaning of a cell must not be
signalled by color or a symbol alone, so it stays readable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum bedeutet MSL nicht „automatisch sicher"? /
   **EN:** Why does MSL not mean "automatically secure"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** MSL verhindert viele Speicherfehler, aber nicht Fehler in Eingabeprüfung, Autorisierung,
   Deserialisierung, Krypto oder Abhängigkeiten. Diese bleiben in der Verantwortung der Entwicklung.
   **EN:** MSL prevents many memory errors, but not errors in input validation, authorization, deserialization,
   crypto, or dependencies. These remain the developer's responsibility.

   </details>

2. **DE:** Warum müssen Secure-Coding-Regeln sprachnah und konkret sein? /
   **EN:** Why must secure-coding rules be language-specific and concrete?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Sei sicher" ist nicht prüfbar. Eine konkrete Regel (z. B. `govulncheck` in Go) lässt sich anwenden,
   testen und im Review belegen.
   **EN:** "Be secure" is not verifiable. A concrete rule (e.g. `govulncheck` in Go) can be applied, tested,
   and evidenced in review.

   </details>

3. **DE:** Warum ist unsichere Deserialisierung ein besonderes Risiko? /
   **EN:** Why is unsafe deserialization a special risk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Beim Umwandeln fremder Daten in Objekte kann Angriffscode oder unerwartete Struktur eingeschleust
   werden. Deshalb dürfen Fremddaten nur validiert und beschränkt deserialisiert werden.
   **EN:** When turning untrusted data into objects, attack code or unexpected structure can be injected.
   Therefore untrusted data may only be deserialized validated and restricted.

   </details>

4. **DE:** Welche Krypto-Mindestvorgaben gelten sprachübergreifend? /
   **EN:** Which crypto minimum requirements apply across languages?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aktuelle Verfahren wie AES-256, SHA-256 oder stärker und Ed25519; veraltete wie MD5 oder SHA-1 für
   Signaturen nur mit ausdrücklicher, begründeter Ausnahme.
   **EN:** Current methods like AES-256, SHA-256 or stronger, and Ed25519; deprecated ones like MD5 or SHA-1
   for signatures only with an explicit, justified exception.

   </details>

5. **DE:** Warum dokumentierst du Nichtanwendbarkeit als `N/A` mit Begründung? /
   **EN:** Why do you document non-applicability as `N/A` with a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit ein Prüfer sieht, dass der Punkt bewusst bewertet und nicht vergessen wurde. Stilles Weglassen
   sieht aus wie eine Lücke.
   **EN:** So a reviewer sees the point was deliberately assessed and not forgotten. Silent omission looks like
   a gap.

   </details>

6. **DE:** Wie belegst du, dass die Abhängigkeiten keine bekannten kritischen Schwachstellen haben? /
   **EN:** How do you prove the dependencies have no known critical vulnerabilities?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch eine dokumentierte Dependency-Prüfung mit einem Werkzeug je Sprache (z. B. cargo audit,
   govulncheck, pip-audit) und dem festgehaltenen Ergebnis als Evidenz.
   **EN:** Through a documented dependency check with a per-language tool (e.g. cargo audit, govulncheck,
   pip-audit) and the recorded result as evidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Risikofelder für den Sprachvergleich benennen.
- [ ] je Zielsprache mindestens eine konkrete Secure-Coding-Regel angeben.
- [ ] das sprachübergreifend Gemeinsame (Grenze, Krypto, Fehler) nennen.
- [ ] eine Dependency-Prüfung je Sprache benennen.
- [ ] Nichtanwendbarkeit als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] name the risk fields for the language comparison.
- [ ] give at least one concrete secure-coding rule per target language.
- [ ] name the cross-language common part (boundary, crypto, errors).
- [ ] name a dependency check per language.
- [ ] document non-applicability as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_08_Secure-Coding-pro-MSL-Pfad.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_08_Secure-Coding-pro-MSL-Pfad.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
