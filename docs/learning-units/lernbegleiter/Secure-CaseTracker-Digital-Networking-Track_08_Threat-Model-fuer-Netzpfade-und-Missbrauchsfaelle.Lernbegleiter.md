# Lernbegleiter: Secure CaseTracker Digital Networking Track 08 – Threat Model für Netzpfade und Missbrauchsfälle / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_08_Threat-Model-fuer-Netzpfade-und-Missbrauchsfaelle.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bisher hast du beschrieben, wie das vernetzte System *funktionieren soll*. Ein **Threat Model**
(Bedrohungsmodell) dreht die Perspektive um: Wie könnte jemand das System *missbrauchen*? Für Netzpfade heißt
das: Welche Verbindung könnte belauscht, gefälscht oder überlastet werden? Ein bewährtes Raster ist
**STRIDE** — sechs Bedrohungskategorien, die man systematisch durchgeht. Zusätzlich helfen **CAPEC**-Muster,
bekannte Angriffswege zu benennen. Wichtig im dritten Lehrjahr und in einer Übung: Missbrauchsfälle werden
didaktisch beschrieben, nicht als Angriffsanleitung. Und Restrisiken werden ehrlich als offen ausgewiesen,
nicht als behoben dargestellt.

**EN:** So far you described how the networked system *should work*. A **threat model** turns the perspective
around: how could someone *misuse* the system? For network paths this means: which connection could be
eavesdropped, forged, or overloaded? A proven grid is **STRIDE** — six threat categories you go through
systematically. In addition, **CAPEC** patterns help to name known attack paths. Important in the third year
and in an exercise: abuse cases are described didactically, not as an attack manual. And residual risks are
honestly marked as open, not presented as fixed.

**DE:** In dieser Einheit lernst du, die wichtigsten Netzpfade und Assets zu benennen, sie mit STRIDE zu
prüfen, relevante CAPEC-Muster für die risikoreichsten Pfade zu nutzen, Gegenmaßnahmen zuzuordnen und
Restrisiken sichtbar zu halten.

**EN:** In this unit you learn to name the most important network paths and assets, to check them with
STRIDE, to use relevant CAPEC patterns for the highest-risk paths, to assign countermeasures, and to keep
residual risks visible.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Threat Model / Threat model | Strukturierte Analyse, wie ein System bedroht oder missbraucht werden kann. |
| STRIDE / STRIDE | Sechs Bedrohungskategorien: Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege. |
| CAPEC / CAPEC | Katalog bekannter Angriffsmuster als Referenz für reale Angriffswege. |
| Missbrauchsfall / Abuse case | Beschreibung, wie eine Funktion absichtlich schädlich genutzt werden könnte. |
| Gegenmaßnahme / Countermeasure | Maßnahme, die eine Bedrohung verhindert oder abschwächt. |
| Restrisiko / Residual risk | Verbleibendes Risiko nach den Gegenmaßnahmen; muss ehrlich benannt sein. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Netzpfade und Assets benennen.** Greife auf die Kommunikationsmatrix (Einheit 02) und
die Segmentierung (Einheit 03) zurück. Welche Pfade tragen personenbezogene Daten oder Secrets? Diese Pfade
und die dahinterliegenden Assets (Falldatenbank, Secrets) sind die wichtigsten Ziele.

**EN:** **Step 1 – Name network paths and assets.** Use the communication matrix (unit 02) and the
segmentation (unit 03). Which paths carry personal data or secrets? These paths and the assets behind them
(case database, secrets) are the most important targets.

**DE:** **Schritt 2 – STRIDE je Pfad durchgehen.** Für jeden wichtigen Pfad fragst du: Kann sich jemand als
ein anderer ausgeben (Spoofing)? Können Daten unterwegs verändert werden (Tampering)? Kann jemand eine Aktion
abstreiten (Repudiation)? Können Daten mitgelesen werden (Information Disclosure)? Kann der Dienst überlastet
werden (Denial of Service)? Kann jemand mehr Rechte erlangen (Elevation of Privilege)? Was nicht zutrifft,
begründest du als `N/A`.

**EN:** **Step 2 – Go through STRIDE per path.** For each important path you ask: can someone impersonate
another (spoofing)? Can data be changed in transit (tampering)? Can someone deny an action (repudiation)? Can
data be read along the way (information disclosure)? Can the service be overloaded (denial of service)? Can
someone gain more rights (elevation of privilege)? Whatever does not apply you justify as `N/A`.

**DE:** **Schritt 3 – CAPEC für die Top-Pfade nutzen.** Für die risikoreichsten Pfade benennst du ein
passendes bekanntes Angriffsmuster als Referenz, zum Beispiel Abhören einer unverschlüsselten Verbindung.
CAPEC macht die Bedrohung konkret und zeigt, dass sie real ist, nicht erfunden.

**EN:** **Step 3 – Use CAPEC for the top paths.** For the highest-risk paths you name a matching known attack
pattern as a reference, for example eavesdropping on an unencrypted connection. CAPEC makes the threat
concrete and shows that it is real, not invented.

**DE:** **Schritt 4 – Gegenmaßnahmen zuordnen.** Jeder erkannten Bedrohung ordnest du eine Gegenmaßnahme zu:
Verschlüsselung gegen Mitlesen, Authentifizierung gegen Spoofing, Segmentierung und Rate-Limit gegen
Überlast, Least Privilege gegen Rechteausweitung. Wichtig: viele Gegenmaßnahmen stehen schon in den früheren
Einheiten; hier wird geprüft, ob sie ausreichen.

**EN:** **Step 4 – Assign countermeasures.** To each recognized threat you assign a countermeasure:
encryption against eavesdropping, authentication against spoofing, segmentation and rate limiting against
overload, least privilege against escalation. Important: many countermeasures already exist in earlier units;
here you check whether they are sufficient.

**DE:** **Schritt 5 – Restrisiko ehrlich ausweisen.** Kein System ist völlig sicher. Was nach den
Gegenmaßnahmen übrig bleibt, ist Restrisiko und wird als `Open` mit Folgeaktion notiert. Ein Restrisiko als
behoben darzustellen wäre falsch und gefährlich.

**EN:** **Step 5 – State residual risk honestly.** No system is fully secure. Whatever remains after the
countermeasures is residual risk and is noted as `Open` with a follow-up action. Presenting residual risk as
fixed would be wrong and dangerous.

**DE:** **Typische Fehler.** Nur die eigenen Erfolgspfade betrachten. STRIDE-Kategorien überspringen statt
`N/A` zu begründen. Missbrauchsfälle als Schritt-für-Schritt-Anleitung ausformulieren. Restrisiken
verschweigen. Gegenmaßnahmen behaupten ohne Bezug zur konkreten Bedrohung.

**EN:** **Common mistakes.** Looking only at your own success paths. Skipping STRIDE categories instead of
justifying `N/A`. Writing abuse cases as step-by-step instructions. Hiding residual risks. Claiming
countermeasures without linking them to a concrete threat.

### Beispiel / Example

```text
Threat-Model-Tabelle (Auszug, Pfad: Fachdienst -> CaseTracker, personenbezogen):
  STRIDE-Kategorie        Bedrohung (didaktisch)         Gegenmassnahme            Rest?
  Spoofing                Fremder gibt sich als Dienst   gegenseitige Authentif.   Open (Prueflauf)
  Tampering               Daten unterwegs veraendert     Integritaetsschutz/TLS    -
  Information Disclosure  Verbindung mitgelesen          Verschluesselung          -
  Denial of Service       Dienst mit Anfragen geflutet   Rate-Limit, Timeout       Open (Lasttest)
  Elevation of Privilege  Konto erlangt mehr Rechte      Least Privilege           -

CAPEC-Referenz (Top-Pfad): Abhoeren einer unverschluesselten Verbindung
Restrisiko: DoS-Robustheit noch nicht durch Lasttest belegt -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Bedrohungsmodellierung von Netzpfaden ist die Kernmethode, um die Sicherheit vernetzter Systeme systematisch zu gewährleisten. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Die geprüften Netzpfade und Gegenmaßnahmen betreffen die sichere Bereitstellung von Netzwerken und Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Threat Modeling, Defense in Depth, Fail-Safe Defaults und
sichere Architektur. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_04` (Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser
Einheit lautet: *Jeder wichtige Netzpfad wird systematisch mit STRIDE geprüft, und Restrisiken bleiben
ehrlich offen.* A11Y-Aspekt: Missbrauchsfälle und Gegenmaßnahmen werden textlich und in einer beschrifteten
Tabelle dargestellt, ohne reine Farbkennzeichnung, damit die Analyse mit Screenreader und Braille-Zeile
prüfbar ist.

**EN:** Relation to the Secure Development Guideline: threat modeling, defense in depth, fail-safe defaults,
and secure architecture. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling), and `CL_08` (security code review). The security decision
of this unit is: *every important network path is checked systematically with STRIDE, and residual risks stay
honestly open.* Accessibility aspect: abuse cases and countermeasures are presented as text and in a labeled
table without color-only marking, so the analysis is auditable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wofür stehen die sechs Buchstaben von STRIDE? /
   **EN:** What do the six letters of STRIDE stand for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Spoofing (Identitätsfälschung), Tampering (Manipulation), Repudiation (Abstreiten), Information
   Disclosure (Offenlegung), Denial of Service (Dienstverweigerung), Elevation of Privilege
   (Rechteausweitung).
   **EN:** Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of
   Privilege.

   </details>

2. **DE:** Warum begründet man nicht zutreffende STRIDE-Kategorien als `N/A`, statt sie zu überspringen? /
   **EN:** Why justify inapplicable STRIDE categories as `N/A` instead of skipping them?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein `N/A` mit Begründung zeigt, dass die Kategorie geprüft wurde. Ein einfaches Überspringen lässt
   offen, ob sie vergessen oder bewusst ausgeschlossen wurde.
   **EN:** An `N/A` with justification shows the category was checked. A plain skip leaves open whether it was
   forgotten or deliberately excluded.

   </details>

3. **DE:** (DV) Welche Gegenmaßnahme passt gegen das Mitlesen einer Verbindung? /
   **EN:** (DV) Which countermeasure fits against eavesdropping on a connection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verschlüsselung der Verbindung. Sie schützt personenbezogene Daten und Secrets vor dem Mitlesen
   (Information Disclosure), auch wenn jemand den Netzverkehr abgreift.
   **EN:** Encryption of the connection. It protects personal data and secrets from eavesdropping
   (information disclosure), even if someone taps the network traffic.

   </details>

4. **DE:** Warum werden Missbrauchsfälle didaktisch und nicht als Anleitung beschrieben? /
   **EN:** Why are abuse cases described didactically and not as instructions?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ziel ist Verständnis und Schutz, nicht die Ermöglichung von Angriffen. Eine
   Schritt-für-Schritt-Anleitung wäre eine Angriffsanleitung und unverantwortlich.
   **EN:** The goal is understanding and protection, not enabling attacks. A step-by-step guide would be an
   attack manual and irresponsible.

   </details>

5. **DE:** Wozu dient eine CAPEC-Referenz im Threat Model? /
   **EN:** What is a CAPEC reference for in the threat model?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie benennt ein bekanntes, dokumentiertes Angriffsmuster und zeigt, dass die Bedrohung real und
   nicht erfunden ist. Das stärkt die Priorisierung der risikoreichsten Pfade.
   **EN:** It names a known, documented attack pattern and shows that the threat is real, not invented. This
   strengthens the prioritization of the highest-risk paths.

   </details>

6. **DE:** Warum darf ein Restrisiko nicht als behoben dargestellt werden? /
   **EN:** Why must residual risk not be presented as fixed?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kein System ist völlig sicher. Ein als behoben dargestelltes Restrisiko täuscht Sicherheit vor und
   verhindert die nötige Folgeaktion. `Open` hält es ehrlich sichtbar.
   **EN:** No system is fully secure. Residual risk shown as fixed fakes security and prevents the needed
   follow-up. `Open` keeps it honestly visible.

   </details>

7. **DE:** Warum baut das Threat Model auf Kommunikationsmatrix und Segmentierung auf? /
   **EN:** Why does the threat model build on the communication matrix and segmentation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Diese Artefakte benennen die Pfade und Grenzen. Ohne sie wüsste man nicht, welche Netzpfade
   überhaupt existieren und welche Assets dahinter am schützenswertesten sind.
   **EN:** These artifacts name the paths and boundaries. Without them you would not know which network paths
   exist at all and which assets behind them are most worth protecting.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die wichtigsten Netzpfade und Assets benennen.
- [ ] jeden wichtigen Pfad mit STRIDE prüfen und `N/A` begründen.
- [ ] für die Top-Pfade ein passendes CAPEC-Muster benennen.
- [ ] jeder Bedrohung eine passende Gegenmaßnahme zuordnen.
- [ ] Restrisiken als `Open` mit Folgeaktion ehrlich ausweisen.

**EN:** I can …

- [ ] name the most important network paths and assets.
- [ ] check each important path with STRIDE and justify `N/A`.
- [ ] name a matching CAPEC pattern for the top paths.
- [ ] assign a fitting countermeasure to each threat.
- [ ] state residual risks honestly as `Open` with a follow-up.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_08_Threat-Model-fuer-Netzpfade-und-Missbrauchsfaelle.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_08_Threat-Model-fuer-Netzpfade-und-Missbrauchsfaelle.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
