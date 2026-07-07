# Lernbegleiter: Secure OrderDesk 05 – Rollen und Berechtigungen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_05_Rollen-und-Berechtigungen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nicht jede Person darf alles. In einer Handelsfirma darf nicht jede Person Kundendaten exportieren oder
Bestellungen löschen. In Software regeln **Rollen und Berechtigungen**, wer welche Aktion ausführen darf. Für
Secure OrderDesk legst du fest, welche Rolle Kunden und Produkte pflegen, Bestellungen erfassen und ändern,
Auswertungen ausführen, Kundendaten exportieren oder Audit-Einträge ansehen darf. Zwei Prinzipien leiten dich:
**Least Privilege** (jede Rolle bekommt nur die minimal nötigen Rechte) und **sichere Defaults** (die
Standardrolle darf am wenigsten). Wichtig ist außerdem: Eine Rolle darf niemals ungeprüft aus einem
Eingabeparameter übernommen werden, sonst kann jemand seine Rechte einfach hochsetzen (Privilege Escalation).

**EN:** Not everyone may do everything. In a trading company, not every person may export customer data or
delete orders. In software, **roles and permissions** decide who may perform which action. For Secure OrderDesk
you define which role may maintain customers and products, capture and change orders, run reports, export
customer data, or view audit entries. Two principles guide you: **least privilege** (each role gets only the
minimum required rights) and **secure defaults** (the default role may do the least). Also important: a role
must never be taken from an input parameter unchecked, otherwise someone could simply raise their rights
(privilege escalation).

**DE:** Besonders sensibel sind Export und Audit-Einsicht, weil sie personenbezogene Kundendaten aus Northwind
(z. B. `ALFKI` mit Kontaktname und Anschrift) berühren. Eine vollständige Produktiv-Authentifizierung ist in
dieser Einheit nicht Pflicht. Wenn sie nicht umgesetzt wird, muss dies als `N/A` mit Begründung dokumentiert
werden. Die Plattform bleibt im 1. Lehrjahr bewusst einfach.

**EN:** Export and audit view are especially sensitive because they touch personal customer data from Northwind
(e.g. `ALFKI` with contact name and address). A full production authentication is not mandatory in this unit.
If it is not implemented, this must be documented as `N/A` with a justification. The platform stays
deliberately simple in year 1.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Rolle / Role | Ein Bündel von Rechten für eine bestimmte Aufgabe. |
| Berechtigung / Permission | Erlaubnis, eine bestimmte Aktion auf Kunden- oder Bestelldaten auszuführen. |
| Least Privilege | Jede Rolle erhält nur die minimal nötigen Rechte. |
| Sichere Defaults / Secure defaults | Standard verweigert; Rechte werden bewusst gewährt. |
| Autorisierung / Authorization | Prüfung, ob eine Rolle eine Aktion ausführen darf. |
| Privilege Escalation | Unerlaubtes Hochsetzen der eigenen Rechte, oft über Eingaben. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollenmatrix aufstellen.** Erstelle eine Tabelle mit den Rollen `learner`, `developer`
und `reviewer` und den Aktionen (Kunde pflegen, Bestellung erfassen, Bestellung ändern, Auswertung ausführen,
Kundendaten exportieren, Audit ansehen). Trage für jede Kombination „erlaubt" oder „verboten" ein. Warum eine
Matrix? Sie macht lückenlos sichtbar, wer was darf, und verhindert vergessene Fälle.

**EN:** **Step 1 – Build a role matrix.** Create a table with the roles `learner`, `developer`, and `reviewer`
and the actions (maintain customer, capture order, change order, run report, export customer data, view audit).
Mark each combination "allowed" or "forbidden". Why a matrix? It makes fully visible who may do what and
prevents forgotten cases.

**DE:** **Schritt 2 – Sichere Defaults setzen.** Die Standardrolle hat minimale Rechte. Zugriff wird
standardmäßig verweigert und nur bewusst gewährt (Fail-Safe Default). Warum? Wenn im Zweifel abgelehnt wird,
entsteht kein versehentlicher Zugriff auf sensible Aktionen wie den Export von Kundendaten oder die
Audit-Einsicht.

**EN:** **Step 2 – Set secure defaults.** The default role has minimal rights. Access is denied by default and
granted only deliberately (fail-safe default). Why? If access is denied when in doubt, no accidental access to
sensitive actions such as exporting customer data or the audit view occurs.

**DE:** **Schritt 3 – Autorisierung in der Kernlogik prüfen.** Jede geschützte Aktion hat eine
Autorisierungsregel, die dort geprüft wird, wo die Aktion wirklich passiert – in der Kernlogik oder der
Datenzugriffsschicht, nicht nur in der Oberfläche oder im CLI. Warum? UI oder CLI lassen sich umgehen; eine
Plattform kann auch über direkte Aufrufe angesteuert werden. Nur eine Prüfung in der Kernlogik schützt
zuverlässig.

**EN:** **Step 3 – Check authorization in the core logic.** Every protected action has an authorization rule
checked where the action really happens – in the core logic or the data access layer, not only in the UI or
CLI. Why? UI or CLI can be bypassed; a platform can also be triggered via direct calls. Only a check in the
core logic protects reliably.

**DE:** **Schritt 4 – Rechte nicht aus Eingaben übernehmen.** Die Rolle darf nie ungeprüft aus einem
Request-Parameter, einem Konfigurationsfeld oder einer CLI-Option kommen. Warum? Sonst schreibt jemand einfach
`role=reviewer` und erhält Zugriff auf den Kundendaten-Export. Die Rolle muss aus einer vertrauenswürdigen,
geprüften Quelle stammen.

**EN:** **Step 4 – Do not take rights from input.** The role must never come unchecked from a request
parameter, a configuration field, or a CLI option. Why? Otherwise someone simply writes `role=reviewer` and
gains access to the customer-data export. The role must come from a trustworthy, verified source.

**DE:** **Typische Fehler.** Standardrolle mit zu vielen Rechten. Autorisierung nur in der UI oder im CLI.
Rolle aus einem Eingabewert übernehmen. Kundendaten-Export und Audit-Einsicht nicht besonders schützen.
Vereinfachte Lern-Authentifizierung nicht klar von echter Produktiv-Authentifizierung trennen.

**EN:** **Common mistakes.** Default role with too many rights. Authorization only in the UI or CLI. Taking the
role from an input value. Not specially protecting customer-data export and audit view. Not clearly separating
simplified learning authentication from real production authentication.

### Beispiel / Example

```text
Rollenmatrix (erlaubt = ja / verboten = nein):
  Aktion                   learner   developer   reviewer
  Kunde pflegen              nein       ja          nein
  Bestellung erfassen        nein       ja          nein
  Bestellung aendern         nein       ja          nein
  Auswertung ausfuehren      ja         ja          ja
  Kundendaten exportieren    nein       nein        ja
  Audit ansehen              nein       nein        ja
Default-Rolle:  learner (minimale Rechte)
Verboten:       role aus Request uebernehmen -> "?role=reviewer" wird ignoriert, Rolle kommt gepruft.
Pruefung:       in der Kernlogik/Datenzugriffsschicht vor jeder geschuetzten Aktion, nicht nur in UI oder CLI.
Beispielkunde:  ALFKI (fiktiv, aus Northwind) -> Export nur fuer reviewer.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Basis"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Zugangssteuerung, sichere Defaults und Least Privilege sind zentrale Schutzmaßnahmen für Kundendaten. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Rollen bestimmen, wer welche Kunden- und Bestelldaten pflegen, exportieren oder einsehen darf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Least Privilege, sichere Defaults und Zugangssteuerung.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Zugangssteuerung/Kompetenznachweis). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede geschützte
Aktion wird in der Kernlogik autorisiert, Kundendaten-Export und Audit-Einsicht sind besonders restriktiv, und
die Rolle stammt nie ungeprüft aus einer Eingabe.* A11Y-Aspekt: Die Rollenmatrix wird als Texttabelle mit
klaren Wörtern („erlaubt"/„verboten") geführt, nicht nur mit Farben oder Symbolen, damit sie mit Screenreader
und Braille-Zeile verständlich bleibt.

**EN:** Relation to the Secure Development Guideline: least privilege, secure defaults, and access control.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_10` (access
control/competence evidence). The security decision of this unit is: *every protected action is authorized in
the core logic, customer-data export and audit view are especially restrictive, and the role never comes
unchecked from an input.* Accessibility aspect: the role matrix is kept as a text table with clear words
("allowed"/"forbidden"), not only with colors or symbols, so it stays understandable with a screen reader and
Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Least Privilege, und warum ist es für Secure OrderDesk sinnvoll? /
   **EN:** What does least privilege mean, and why is it useful for Secure OrderDesk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Rolle erhält nur die minimal nötigen Rechte. Das begrenzt den Schaden, wenn ein Konto
   missbraucht wird, und reduziert versehentliche gefährliche Aktionen wie den Export sämtlicher Kundendaten.
   **EN:** Each role gets only the minimum required rights. This limits the damage if an account is misused and
   reduces accidental dangerous actions such as exporting all customer data.

   </details>

2. **DE:** (AE) Wo muss Autorisierung geprüft werden, damit keine UI- oder CLI-Umgehung möglich ist? /
   **EN:** (AE) Where must authorization be checked so no UI or CLI bypass is possible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** In der Kernlogik oder Datenzugriffsschicht, wo die Aktion wirklich ausgeführt wird. UI oder CLI sind
   nur Auslöser und lassen sich über direkte Aufrufe umgehen.
   **EN:** In the core logic or data access layer, where the action is really executed. UI or CLI are only
   triggers and can be bypassed via direct calls.

   </details>

3. **DE:** Warum darf die Rolle nicht ungeprüft aus einem Eingabeparameter kommen? /
   **EN:** Why must the role not come unchecked from an input parameter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sonst kann jemand `role=reviewer` setzen und sich Zugriff auf Kundendaten-Export und Audit-Einsicht
   geben (Privilege Escalation). Die Rolle muss aus einer vertrauenswürdigen, geprüften Quelle stammen.
   **EN:** Otherwise someone can set `role=reviewer` and grant themselves access to customer-data export and
   audit view (privilege escalation). The role must come from a trustworthy, verified source.

   </details>

4. **DE:** Warum hat die Standardrolle bewusst minimale Rechte? /
   **EN:** Why does the default role deliberately have minimal rights?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sichere Defaults verweigern im Zweifel. So gibt es keinen versehentlichen Zugriff auf sensible
   Aktionen wie Kundendaten-Export oder Audit-Einsicht, wenn eine Rolle unklar ist.
   **EN:** Secure defaults deny when in doubt. This prevents accidental access to sensitive actions such as
   customer-data export or audit view when a role is unclear.

   </details>

5. **DE:** (DPA) Warum sind Kundendaten-Export und Audit-Einsicht besonders zu schützen? /
   **EN:** (DPA) Why do customer-data export and audit view need special protection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Beide legen personenbezogene Kundendaten offen (z. B. Kontaktname, Anschrift von `ALFKI`). Ein zu
   weiter Zugriff verletzt schnell den Datenschutz, daher sind diese Aktionen restriktiven Rollen vorbehalten.
   **EN:** Both disclose personal customer data (e.g. contact name, address of `ALFKI`). Too broad access
   quickly violates privacy, so these actions stay restricted to more privileged roles.

   </details>

6. **DE:** (SI) Welche Rollenannahmen wären für den Betrieb der Plattform zu dokumentieren? /
   **EN:** (SI) Which role assumptions should be documented for operating the platform?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Welche Rolle standardmäßig gilt, wie Rollen zugewiesen werden, wer Kundendaten exportieren darf und
   ob eine echte Authentifizierung `N/A` ist. So bleibt der Betrieb nachvollziehbar und prüfbar.
   **EN:** Which role applies by default, how roles are assigned, who may export customer data, and whether
   real authentication is `N/A`. This keeps operation traceable and reviewable.

   </details>

7. **DE:** Warum ist eine Rollenmatrix besser als verstreute Einzelprüfungen im Code? /
   **EN:** Why is a role matrix better than scattered individual checks in the code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Matrix macht lückenlos sichtbar, wer welche Aktion darf, und verhindert vergessene Fälle.
   Verstreute Prüfungen lassen leicht eine Aktion ungeschützt oder widersprüchlich.
   **EN:** The matrix makes fully visible who may perform which action and prevents forgotten cases. Scattered
   checks easily leave an action unprotected or inconsistent.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Rollenmatrix mit erlaubten und verbotenen Aktionen an Kunden- und Bestelldaten erstellen.
- [ ] sichere Defaults für die Standardrolle festlegen und begründen.
- [ ] erklären, warum Autorisierung in der Kernlogik geprüft werden muss.
- [ ] Privilege Escalation über Eingaben verhindern.
- [ ] Kundendaten-Export und Audit-Einsicht besonders schützen.
- [ ] nicht umgesetzte echte Authentifizierung als `N/A` begründen.

**EN:** I can …

- [ ] create a role matrix with allowed and forbidden actions on customer and order data.
- [ ] define and justify secure defaults for the default role.
- [ ] explain why authorization must be checked in the core logic.
- [ ] prevent privilege escalation via input.
- [ ] specially protect customer-data export and audit view.
- [ ] justify unimplemented real authentication as `N/A`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_05_Rollen-und-Berechtigungen.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_05_Rollen-und-Berechtigungen.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
