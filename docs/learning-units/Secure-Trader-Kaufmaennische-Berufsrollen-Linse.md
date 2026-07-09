# Kaufmaennische Berufsrollen-Linse / Commercial IT-Occupation Role Lens

**Stand / Date:** 2026-07-09
**Bezug / Scope:** Secure-OrderDesk-, Secure-ServiceHarvester- und Secure-CaseTracker-Familie
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA
**Betrifft / Applies to:** Kaufmann/-frau fuer IT-System-Management (KITSM), Kaufmann/-frau fuer Digitalisierungsmanagement (KDM)

## Hinweis zur Einordnung / Note on Classification

**DE:** Diese Linse ist eine didaktische Unterrichtshilfe. Sie ersetzt keine Ausbildungsordnung,
keinen Rahmenlehrplan, keine Berufsschule, keine betriebliche Ausbildung, keine Ausbilderentscheidung
und keine Pruefungsvorbereitung. Sie erzeugt keine neuen Repositories: KITSM und KDM arbeiten an
denselben Secure-Trader-Systemen wie die Fachinformatiker-Fachrichtungen, nur in einer anderen Rolle.

**EN:** This lens is a didactic teaching aid. It does not replace training regulations, the curriculum,
vocational school, workplace training, instructor decisions, or exam preparation. It creates no new
repositories: KITSM and KDM work on the same Secure Trader systems as the IT-specialist directions,
only in a different role.

## Worum geht es? / What Is This About?

**DE:** Fuer die beiden kaufmaennischen IT-Berufe stellt sich die Frage: Wie viel **Programmierung**
gehoert zum agentischen Arbeiten mit Spec-Driven Development (GitHub Spec Kit)? Diese Linse beantwortet
sie und zeigt, **wie** dieselben Lernaufgaben in der kaufmaennischen Rolle gefahren werden. Kurzfassung:
Der Beitrag liegt vor allem auf **Spezifikation, Governance und Abnahme**, nicht auf dem Schreiben
grosser Codemengen. Trotzdem fassen beide Berufe mindestens einmal aktiv Code an.

**EN:** For the two commercial IT occupations the question is: how much **programming** belongs to
agentic work with Spec-Driven Development (GitHub Spec Kit)? This lens answers it and shows **how** the
same learning tasks are run in the commercial role. In short: the contribution is mainly on
**specification, governance, and acceptance**, not on writing large amounts of code. Still, both
occupations touch code actively at least once.

## Kernthese / Core Thesis

**DE:** Spec-Driven Development dreht die klassische Barriere um. Frueher hielt fehlendes
Programmieren-Koennen kaufmaennische IT-Berufe vom Software-Bauen fern. Agentische KI und Spec Kit
verschieben den menschlichen Beitrag nach oben: auf die Spezifikations-, Governance- und Abnahmeebene.
Genau dort liegen die Kernkompetenzen von KITSM und KDM (Anforderungen, Vertraege, Kosten/Nutzen,
Geschaeftsprozesse, Datenschutz, Kennzahlen).

**EN:** Spec-Driven Development inverts the classic barrier. Previously, lack of programming skill kept
commercial IT occupations away from building software. Agentic AI and Spec Kit move the human
contribution upward: to the specification, governance, and acceptance level. That is exactly where the
core competencies of KITSM and KDM live (requirements, contracts, cost/benefit, business processes,
privacy, key figures).

## Sechs tragende Prinzipien / Six Guiding Principles

**DE:**

1. **Barriere-Umkehr.** SDD verschiebt den menschlichen Beitrag auf Spezifikation, Governance und
   Abnahme; der Agent traegt den imperativen Code.
2. **Zwei getrennte Faehigkeiten.** Code *schreiben* (bewusst klein) und Code *lesen und abnehmen*
   (hoch, pruefbar) sind unterschiedliche Kompetenzen. Die zweite ist der eigentliche Lerngegenstand.
3. **SQL als gemeinsame deklarative Bruecke.** Beide Berufe fassen SQL mindestens einmal aktiv
   (schreibend) an. SQL sagt „was ich will", nicht „wie" - dasselbe Denkmuster wie SDD.
4. **Code-Boden ungleich null.** Es gibt keinen reinen Zuschauer-Pfad; jede lernende Person hat
   verpflichtend „Haende im Code".
5. **Evidenzbasierte Abnahme.** Eine bewusst eingebaute Abweichung je Einheit verhindert
   „Abnahme-Theater" (blindes Durchwinken von Agenten-Ausgabe).
6. **Solo-Enabler.** Der Agent macht die Auftraggeber- und Abnehmer-Rolle fuer eine einzelne lernende
   Person spielbar - ohne Agent ginge das nur im Team.

**EN:**

1. **Barrier inversion.** SDD moves the human contribution to specification, governance, and
   acceptance; the agent carries the imperative code.
2. **Two separate skills.** *Writing* code (deliberately small) and *reading and accepting* code
   (high, verifiable) are different competencies. The second is the actual learning object.
3. **SQL as the shared declarative bridge.** Both occupations touch SQL actively (writing) at least
   once. SQL states "what I want", not "how" - the same mindset as SDD.
4. **Code floor not zero.** There is no pure spectator path; every learner has mandatory "hands in the
   code".
5. **Evidence-based acceptance.** A deliberately built-in deviation per unit prevents "acceptance
   theatre" (blindly waving through agent output).
6. **Solo enabler.** The agent makes the client and acceptor role playable for a single learner -
   without an agent this would only work in a team.

## Code-Naehe je Spec-Kit-Phase / Code Proximity per Spec Kit Phase

**DE:** Die Tabelle zeigt, wo im SDD-Fluss die kaufmaennische Rolle beitraegt. „Nur lesen" heisst:
verstehen und beurteilen, nicht schreiben.

**EN:** The table shows where in the SDD flow the commercial role contributes. "Read only" means:
understand and judge, not write.

| Phase | KITSM | KDM | Taetigkeit / Activity |
|---|---|---|---|
| `/constitution` | hoch, kein Code / high, no code | hoch, kein Code / high, no code | SLA, Lizenz, Datenschutz, Wirtschaftlichkeit als Regeln / rules |
| `/specify` | hoch, kein Code / high, no code | hoch, kein Code / high, no code | Kundenanforderung in Spezifikation / requirement into spec |
| `/clarify` | hoch, kein Code / high, no code | hoch, kein Code / high, no code | Rueckfragen, Anforderungen schaerfen / sharpen requirements |
| `/plan` | nur lesen / read only | nur lesen / read only | Machbarkeit und Kosten beurteilen / judge feasibility, cost |
| `/tasks` | nur lesen / read only | lesen und schaetzen / read and estimate | Zerlegung, Aufwand, Uebergabe planen / plan handover |
| `/implement` | Abnahme plus SQL-Schreib-Touch / acceptance plus SQL write touch | Abnahme plus SQL-Authoring / acceptance plus SQL authoring | Agent schreibt; Rolle prueft und fasst SQL an / agent writes; role checks and touches SQL |
| `/analyze` | nur lesen / read only | nur lesen / read only | Konsistenzbericht als Nachweis / consistency report as evidence |

## Berufsspezifische Kalibrierung / Occupation-Specific Calibration

**DE:** Die Baender sind **relativ**, nicht absolut. Sie sagen „wo im SDD-Fluss traegt der Mensch bei",
nicht „so viele Zeilen". Zum Vergleich: Fachinformatiker Anwendungsentwicklung laege bei denselben
Reihen eher bei 50-70 Prozent Authoring.

**EN:** The bands are **relative**, not absolute. They say "where in the SDD flow the human
contributes", not "this many lines". For comparison: IT specialists for application development would be
closer to 50-70 percent authoring on the same series.

| Merkmal / Trait | KITSM (System-Management) | KDM (Digitalisierungsmanagement) |
|---|---|---|
| Authoring-Band / band | ~5-10 % | ~15-25 % |
| Pflicht-Touch / mandatory touch | Konfig-/Parameter-Aenderung plus minimaler SQL-Schreib-Touch | SQL-Authoring als primaere Flaeche (Kennzahlen) |
| SQL-Rolle / SQL role | einmal aktiv, sonst lesend / once active, else reading | Kernkompetenz, wiederholt / core skill, repeated |
| Sicherheitsbezug / security link | Betrieb, Uebergabe (SLA, Timeouts) | parametrisierte Queries (SQL-Injection-Abwehr) |
| LF-Anschluss / learning-field link | LF 1, 5, 6 | LF 5, plus Prozess- und Kennzahlen-Naehe |

## SQL als Bruecken-Programmiersprache / SQL as Bridge Programming Language

**DE:** SQL ist eine Programmier- und Skriptsprache fuer relationale Daten. Sie ist **deklarativ**: Man
beschreibt das gewuenschte Ergebnis, nicht den Ablauf. Das passt doppelt: zur Domaene der kaufmaennischen
Berufe (relationale Geschaeftsdaten) und zu ihrer SDD-Rolle (Absicht formulieren, das „Wie" dem Agenten
ueberlassen). Deshalb ist SQL die gemeinsame Bruecke, an der beide Berufe Programmierung wenigstens
einmal aktiv erleben. Bei Secure OrderDesk ist die entscheidende Sicherheitsregel dabei: **jeder Zugriff
parametrisiert, kein dynamisches SQL aus Eingaben** (SQL-Injection, CWE-89).

**EN:** SQL is a programming and scripting language for relational data. It is **declarative**: you
describe the desired result, not the procedure. This fits twice: the domain of the commercial
occupations (relational business data) and their SDD role (state intent, leave the "how" to the agent).
Therefore SQL is the shared bridge where both occupations experience programming actively at least once.
For Secure OrderDesk the decisive security rule is: **every access parameterized, no dynamic SQL from
input** (SQL injection, CWE-89).

## Das Abnahme-Paradox / The Acceptance Paradox

**DE:** „Kaum schreiben, aber abnehmen" hat einen Haken: Um Code abzunehmen, muss man ihn lesen koennen.
Die Kompetenz verschwindet nicht, sie verschiebt sich von *schreiben* zu *pruefen*. Verlangte untere
Grenze der Lesekompetenz: den Kontrollfluss grob nachvollziehen („was passiert mit der Kundeneingabe?"),
den Spec-Abgleich fuehren („erfuellt der Diff das Akzeptanzkriterium?") und **Warnzeichen** erkennen
(hartkodiertes Geheimnis, fehlende Eingabepruefung, ungepruefte SQL-Verkettung). Das ist lehrbar und
pruefbar - und klar unterscheidbar von „kann eine Funktion schreiben".

**EN:** "Barely write, but accept" has a catch: to accept code you must be able to read it. The
competency does not vanish, it shifts from *writing* to *checking*. The required lower bound of reading
skill: follow the control flow roughly ("what happens to the customer input?"), do the spec check ("does
the diff meet the acceptance criterion?"), and recognize **red flags** (hard-coded secret, missing
input check, unchecked SQL concatenation). This is teachable and testable - and clearly distinct from
"can write a function".

## Rollen-Split / Role Split

**DE:** Am realistischsten und pruefungsnah ist ein Rollenmodell: Die kaufmaennische Person ist
**Auftraggeberin und Abnehmerin**; der Agent ist **Entwickler**. Das bildet die Betriebsrealitaet ab -
Kaufleute beauftragen und nehmen ab, sie programmieren nicht durch. Weil der Agent den Code-Teil traegt,
ist dieses Rollenmodell auch fuer eine einzelne lernende Person spielbar.

**EN:** Most realistic and close to the exam is a role model: the commercial person is **client and
acceptor**; the agent is **developer**. This mirrors operational reality - commercial staff commission
and accept, they do not code through. Because the agent carries the code part, this role model is
playable even for a single learner.

## Leitsatz / Guiding Principle

**DE:** Die Programmiersprache folgt der kognitiven Heimat des Berufs. Kaufleute denken deklarativ
(SQL); Anwendungsentwicklung denkt imperativ und objektorientiert. SDD schliesst die imperative Luecke
ueber den Agenten - und SQL ist die Sprache, in der beide kaufmaennischen Berufe ihre Absicht ausfuehrbar
machen.

**EN:** The programming language follows the cognitive home of the occupation. Commercial staff think
declaratively (SQL); application development thinks imperatively and object-oriented. SDD closes the
imperative gap through the agent - and SQL is the language in which both commercial occupations make
their intent executable.

## Nutzung im Unterricht / Classroom Use

- **DE:** Diese Linse wird zusammen mit der `Rahmenlehrplan-Lernfeld-Mapping.md` und den drei
  `IT-Berufe-Secure-*-Mapping.md` genutzt. Die betroffenen Lernbegleiter tragen einen Abschnitt
  „Kaufmaennische Rollen-Umschaltung".
- **DE:** Der Pflicht-Touch (mindestens ein aktiver SQL-Schreib-Schritt) und die evidenzbasierte
  Abnahme mit eingebauter Abweichung sind fuer KITSM und KDM verbindlich.
- **DE:** „Passend" bedeutet Eignung, nicht Pflichtumfang. Lehrende waehlen Aufgaben passend zur Klasse.
- **EN:** This lens is used together with `Rahmenlehrplan-Lernfeld-Mapping.md` and the three
  `IT-Berufe-Secure-*-Mapping.md`. The affected study companions carry a "Commercial Role Switch"
  section. The mandatory touch and evidence-based acceptance are binding for KITSM and KDM.

## Quellenhinweis / Source Note

**DE:** Berufsbildbezeichnungen und Lernfelder folgen dem KMK-Rahmenlehrplan der IT-Berufe
(Beschluss 13.12.2019, gueltig ab 2020) und werden bei fachlicher Aktualisierung gegen offizielle
Quellen geprueft: KMK, BIBB „Ausbildung gestalten", BERUFENET sowie die Bildungsplaene der Laender.

**EN:** Occupation titles and learning fields follow the KMK curriculum for the IT occupations (decision
of 13 Dec 2019, effective from 2020) and are checked against official sources on updates: KMK, BIBB,
BERUFENET, and the state education plans.
