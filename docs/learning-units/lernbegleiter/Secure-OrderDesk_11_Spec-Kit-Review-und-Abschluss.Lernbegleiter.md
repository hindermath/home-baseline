# Lernbegleiter: Secure OrderDesk 11 – Spec-Kit-Review und Abschluss / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_11_Spec-Kit-Review-und-Abschluss.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende der Arbeit an der Secure-OrderDesk-Plattform kommt der **Abschluss**: Man prüft, ob alles Nötige
da ist, fasst die Ergebnisse zusammen und übergibt sie verständlich an die Kundin oder den Kunden. In dieser
Einheit planst du das Abschlussreview eines Spec-Kit-Laufs. Kern ist eine **Evidenzmatrix**: eine Übersicht,
die für jede Lerneinheit zeigt, ob eine Anforderung `Applicable`, `N/A` oder `Open` ist – jeweils mit
Begründung, Nachweis (Evidenz) und Restrisiko. Besonders wichtig sind hier die sicherheitskritischen Themen der
Handelsplattform: parametrisierte Datenzugriffe (kein SQL-Injection-Risiko), geprüfte Bestelleingaben,
Datenschutz der Kundendaten und belastbare Auswertungen. Kein offener Sicherheitsbefund wird verschwiegen.
`N/A` braucht einen Grund, `Open` braucht Owner, Trigger oder Folgeaufgabe. Am Ende steht eine kurze,
kundenverständliche Präsentation aus Sicht der Übungsfirma EuFPA für Secure Trader.

**EN:** At the end of the work on the Secure OrderDesk platform comes the **closure**: you check that everything
necessary is there, summarize the results, and hand them over understandably to the customer. In this unit you
plan the closing review of a Spec Kit run. The core is an **evidence matrix**: an overview that shows, for each
learning unit, whether a requirement is `Applicable`, `N/A`, or `Open` – each with a justification, evidence,
and residual risk. Especially important here are the security-critical topics of the trading platform:
parameterized data access (no SQL injection risk), validated order input, privacy of customer data, and
reliable evaluations. No open security finding is hidden. `N/A` needs a reason, `Open` needs an owner, trigger,
or follow-up. The result is a short, customer-understandable presentation from EuFPA's perspective for Secure
Trader.

**DE:** Der Abschluss bewertet fachliche Ergebnisse, Sicherheitsentscheidungen und Evidenz unabhängig von der
Zielprogrammiersprache. Sprachspezifische Unterschiede sind Lernpunkte, keine Fehler.

**EN:** The closure assesses functional results, security decisions, and evidence independently of the target
programming language. Language-specific differences are learning points, not errors.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Abschlussreview / Closing review | Systematische Prüfung aller Ergebnisse am Ende eines Laufs. |
| Evidenz / Evidence | Nachweis, der eine Aussage belegt (z. B. `spec.md`, Test, Review). |
| Evidenzmatrix / Evidence matrix | Übersicht der Anforderungen mit Status, Begründung und Nachweis. |
| Restrisiko / Residual risk | Risiko, das nach allen Maßnahmen bewusst bestehen bleibt. |
| Applicable / N/A / Open | Statuswerte: zutreffend, nicht anwendbar, noch offen. |
| Folgeaufgabe / Follow-up | Geplante nächste Aufgabe mit Owner und Auslöser. |
| SQL-Sicherheit / SQL security | Nachweis, dass Datenzugriffe parametrisiert sind und kein dynamisches SQL nutzen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Artefakte einsammeln.** Prüfe, ob für jede gestartete Lerneinheit die Artefakte
auffindbar sind: `spec.md`, `plan.md`, `tasks.md`, Checklisten, Reviews, Testnachweise. Warum? Ein Abschluss
ohne auffindbare Nachweise ist nur eine Behauptung; Evidenz macht ihn belastbar.

**EN:** **Step 1 – Collect artifacts.** Check that the artifacts are findable for each started learning unit:
`spec.md`, `plan.md`, `tasks.md`, checklists, reviews, test evidence. Why? A closure without findable evidence
is only a claim; evidence makes it reliable.

**DE:** **Schritt 2 – Evidenzmatrix füllen.** Trage je Anforderung `Applicable`, `N/A` oder `Open` ein, jeweils
mit Begründung und Evidenzpfad. Positive Aussagen zu Sicherheit (z. B. „Datenzugriffe sind parametrisiert" oder
„Bestelleingaben werden validiert") brauchen konkrete Evidenz. Warum? Nur nachprüfbare Aussagen zählen; eine
Behauptung ohne Nachweis hilft niemandem.

**EN:** **Step 2 – Fill the evidence matrix.** Enter `Applicable`, `N/A`, or `Open` per requirement, each with a
justification and evidence path. Positive statements about security (e.g. "data access is parameterized" or
"order input is validated") need concrete evidence. Why? Only verifiable statements count; a claim without
evidence helps no one.

**DE:** **Schritt 3 – Restrisiken und Folgeaufgaben sichtbar machen.** Kein offener Sicherheitsbefund wird
verschwiegen. `Open` bekommt Owner, Trigger oder geplanten nächsten Spec-Kit-Lauf; Restrisiken werden benannt.
Warum? Ehrliche offene Punkte lassen sich planen; versteckte Punkte werden zu bösen Überraschungen.

**EN:** **Step 3 – Make residual risks and follow-ups visible.** No open security finding is hidden. `Open` gets
an owner, trigger, or planned next Spec Kit run; residual risks are named. Why? Honest open points can be
planned; hidden points become nasty surprises.

**DE:** **Schritt 4 – Kundengerechte Präsentation.** Baue eine kurze Präsentation aus EuFPA-Sicht für Secure
Trader: Was leistet die Handelsplattform, welche Kundendaten wurden minimiert, welche Grenzen gelten (z. B.
Aussagegrenzen der Auswertungen), welche Risiken bleiben. Offene Risiken werden verständlich zusammengefasst,
nicht versteckt. Warum? Kund*innen brauchen eine ehrliche, verständliche Sicht, keine Fachsprache und keine
geschönte Darstellung.

**EN:** **Step 4 – Customer-oriented presentation.** Build a short presentation from EuFPA's perspective for
Secure Trader: what the trading platform delivers, which customer data was minimized, which limits apply (e.g.
limits of interpretation of the evaluations), which risks remain. Open risks are summarized understandably, not
hidden. Why? Customers need an honest, understandable view, not jargon and not a whitewashed picture.

**DE:** **Typische Fehler.** Aussagen ohne Evidenz. `N/A` ohne Begründung. `Open` ohne Owner. Ein
SQL-Injection-Risiko oder eine ungeprüfte Bestelleingabe in der Präsentation verschweigen. Nur eine Sprache
prüfen und die anderen ignorieren, obwohl sie gestartet wurden.

**EN:** **Common mistakes.** Statements without evidence. `N/A` without a reason. `Open` without an owner.
Hiding a SQL injection risk or an unvalidated order input in the presentation. Reviewing only one language and
ignoring the others although they were started.

### Beispiel / Example

```text
Evidenzmatrix (Auszug):
  Anforderung                   Status       Begruendung / Evidenz                 Restrisiko / Follow-up
  Parametrisierte Datenzugriffe Applicable   Query-Review + Negativtests in tests/ gering
  Eingabevalidierung Bestellung Applicable   Negativtests (negative Menge/Rabatt)  gering
  Datenschutz Kundendaten (04)  Applicable   Datenminimierungs-Review              gering
  Auswertungen/Kennzahlen (10)  Applicable   Kennzahlentests + Aussagegrenzen      gering
  Rollenmodell (05)             Open         Rechte noch nicht final               Owner: reviewer, Trigger: v2
Praesentation (EuFPA -> Secure Trader):
  "Handelsdaten sicher verwaltet, SQL parametrisiert, Kundendaten minimiert, 1 offener Punkt (Rollenmodell)."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Der Serviceabschluss und die kundenverständliche Übergabe der Plattform sind Kern der Einheit. |
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Berührt / Touched | Die Abschlusspräsentation ordnet Ergebnis und Rolle im Betrieb EuFPA für Secure Trader verständlich ein. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: die gesamte Richtlinie dient als Abschlussmaßstab. Passende
Checklisten: `CL_01` bis `CL_12`, je Aufgabe als `Applicable`, `N/A` oder `Open` bewertet, mit besonderem Blick
auf `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement) und `CL_10` (Datenschutz). Die
Sicherheitsentscheidung dieser Einheit lautet: *Kein offener Sicherheitsbefund wird verschwiegen; jede Aussage
hat Evidenz, jedes `N/A` einen Grund und jedes `Open` einen Owner.* A11Y-Aspekt: Die Evidenzmatrix und die
Präsentation sind textbasiert, in einfacher Sprache und ohne reine Farbsignale, damit sie mit Screenreader und
Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: the entire guideline serves as the closing benchmark.
Matching checklists: `CL_01` to `CL_12`, assessed per task as `Applicable`, `N/A`, or `Open`, with special
attention to `CL_08` (security code review), `CL_09` (test management), and `CL_10` (privacy). The security
decision of this unit is: *no open security finding is hidden; every statement has evidence, every `N/A` a
reason, and every `Open` an owner.* Accessibility aspect: the evidence matrix and the presentation are
text-based, in plain language, and without color-only signals, so they remain understandable with a screen
reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum braucht jede positive Aussage im Abschluss konkrete Evidenz? /
   **EN:** Why does every positive statement in the closure need concrete evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Nachweis ist eine Aussage nur eine Behauptung. Evidenz wie Tests, Reviews oder Checklisten macht
   das Ergebnis nachprüfbar und belastbar.
   **EN:** Without evidence a statement is only a claim. Evidence such as tests, reviews, or checklists makes the
   result verifiable and reliable.

   </details>

2. **DE:** (AE) Welche technische Entscheidung würdest du im Review der Handelsplattform besonders erklären? /
   **EN:** (AE) Which technical decision would you especially explain in the trading platform review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine, die Sicherheit oder das Datenmodell betrifft, z. B. dass alle Datenzugriffe parametrisiert sind
   und wo Bestelleingaben validiert werden. Solche Entscheidungen sind für Nachvollziehbarkeit zentral.
   **EN:** One that affects security or the data model, e.g. that all data access is parameterized and where
   order input is validated. Such decisions are central to traceability.

   </details>

3. **DE:** (DPA) Welche Auswertung oder Kennzahl würdest du Kund*innen nur mit Warnhinweis zeigen? /
   **EN:** (DPA) Which evaluation or metric would you show customers only with a warning?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Auswertung aus wenigen oder unvollständigen Daten, z. B. Top-Produkte über nur einen laufenden
   Monat. Der Warnhinweis nennt die Datenbasis, den Zeitraum und die Aussagegrenze.
   **EN:** An evaluation from few or incomplete data, e.g. top products over only a running month. The warning
   names the data basis, the period, and the limit of interpretation.

   </details>

4. **DE:** (SI) Welche Umgebungs- oder Toolchain-Frage bleibt bei einer Handelsplattform typischerweise als Risiko offen? /
   **EN:** (SI) Which environment or toolchain question typically stays open as a risk for a trading platform?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel die konkrete Datenbank-Betriebsumgebung, ein noch offener Audit-Weg je Sprache oder
   fehlendes Dependency-Audit-Werkzeug. Solche Punkte werden als `Open` mit Owner und Trigger geführt, nicht
   verschwiegen.
   **EN:** For example the concrete database operating environment, an audit path still open per language, or a
   missing dependency-audit tool. Such points are kept as `Open` with owner and trigger, not hidden.

   </details>

5. **DE:** (DV) Welche Schnittstellen- oder Systemgrenzenannahme bleibt oft als Restrisiko offen? /
   **EN:** (DV) Which interface or system-boundary assumption often stays open as a residual risk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel, wie die Plattform Daten importiert oder exportiert und wo die Grenze zwischen
   Datenquelle und Anwendung liegt. Solche Annahmen werden als `Open` mit Trigger notiert, damit sie im nächsten
   Lauf geprüft werden.
   **EN:** For example how the platform imports or exports data and where the boundary between data source and
   application lies. Such assumptions are noted as `Open` with a trigger so they are checked in the next run.

   </details>

6. **DE:** Warum bekommt jedes `Open` einen Owner, Trigger oder eine Folgeaufgabe? /
   **EN:** Why does every `Open` get an owner, trigger, or follow-up?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein offener Punkt ohne Verantwortung bleibt liegen. Owner, Trigger oder Folgeaufgabe sorgen dafür,
   dass er später wirklich bearbeitet wird.
   **EN:** An open point without ownership is left undone. Owner, trigger, or follow-up ensure it is really
   addressed later.

   </details>

7. **DE:** Warum werden offene Risiken in der Präsentation verständlich zusammengefasst statt versteckt? /
   **EN:** Why are open risks summarized understandably in the presentation instead of hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kund*innen müssen fundiert entscheiden können. Versteckte Risiken zerstören Vertrauen; eine ehrliche,
   verständliche Zusammenfassung ist fachlich und rechtlich sauber.
   **EN:** Customers must be able to decide well-informed. Hidden risks destroy trust; an honest, understandable
   summary is professionally and legally sound.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] alle Artefakte je gestarteter Lerneinheit auf Auffindbarkeit prüfen.
- [ ] eine Evidenzmatrix mit `Applicable`, `N/A` und `Open` samt Begründung füllen.
- [ ] Restrisiken und Folgeaufgaben mit Owner und Trigger sichtbar machen.
- [ ] positive Sicherheitsaussagen (z. B. parametrisierte Zugriffe) mit Evidenz belegen.
- [ ] eine kurze, kundenverständliche und datenschutzfreundliche Präsentation für Secure Trader aufbauen.

**EN:** I can …

- [ ] check all artifacts per started learning unit for findability.
- [ ] fill an evidence matrix with `Applicable`, `N/A`, and `Open` including justification.
- [ ] make residual risks and follow-ups visible with owner and trigger.
- [ ] back positive security statements (e.g. parameterized access) with evidence.
- [ ] build a short, customer-understandable, privacy-friendly presentation for Secure Trader.

## Kaufmännische Rollen-Umschaltung / Commercial Role Switch

**DE:** Review und Abschluss sind die **Abnahme-/Übergabe-Einheit** — die Kernrolle beider
kaufmännischen Berufe (Grundlage:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
Der Agent hat entwickelt; du nimmst ab und übergibst.

- **KITSM:** Erstelle ein kurzes **Abnahmeprotokoll/Übergabedokument** (erfüllte Kriterien, offene
  Punkte, Service-/SLA-Hinweise, Kosten/Nutzen). Prüfe jeden Punkt gegen die Spec, nicht gegen das Gefühl.
- **KDM:** Rechne die zentralen **Kennzahlen** gegen (`ALFKI` als Anker) und dokumentiere
  **Datenschutz** und **Aussagegrenzen** in der Übergabe.
- **Abnahme (evidenzbasiert), eingebaute Abweichung:** Die Zusammenfassung des Agenten behauptet ein
  **erfülltes Kriterium, das nicht erfüllt ist**. Finde es über Ausführen/Gegenprüfen und verweigere die
  Freigabe, bis es stimmt.

**EN:** Review and closure are the **acceptance/handover unit** — the core role of both commercial
occupations (basis:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
KITSM writes a short acceptance/handover record (met criteria, open points, SLA notes, cost/benefit),
checking each point against the spec. KDM re-computes the key figures (`ALFKI` as anchor) and documents
privacy and the limits of the statement in the handover. Evidence-based acceptance: the agent's summary
claims a met criterion that is not met — find it by running/checking and withhold release until correct.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_11_Spec-Kit-Review-und-Abschluss.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_11_Spec-Kit-Review-und-Abschluss.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
