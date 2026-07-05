# Lernbegleiter: Secure CaseTracker Digital Networking Track 03 – Trust Boundaries und Segmentierung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In Einheit 02 hast du festgehalten, wer mit wem spricht. Jetzt teilst du das Netz bewusst in Zonen
auf. **Segmentierung** bedeutet, das Netz in getrennte Segmente zu zerlegen, sodass ein Problem in einem
Segment nicht sofort das ganze System betrifft. Die **Vertrauensgrenze** (Trust Boundary) ist die Linie
zwischen zwei Zonen mit unterschiedlichem Schutzbedarf. Ein Bild dazu: In einem Gebäude gibt es einen
öffentlichen Empfang, dann Büros und ganz innen einen Tresorraum. Nicht jeder darf überall hin, und jede
Tür ist ein kontrollierter Übergang.

**EN:** In unit 02 you recorded who talks to whom. Now you deliberately divide the network into zones.
**Segmentation** means splitting the network into separate segments so that a problem in one segment does not
immediately affect the whole system. The **trust boundary** is the line between two zones with different
protection needs. A picture: a building has a public reception, then offices, and deep inside a vault. Not
everyone may go everywhere, and each door is a controlled crossing.

**DE:** In dieser Einheit lernst du, Segmente zu benennen, ihren Schutzbedarf zu bestimmen, erlaubte
Übergänge zu begründen und alle anderen Übergänge bewusst zu blockieren. Grundregel ist **deny by default**:
Ein Übergang ist verboten, solange er nicht ausdrücklich erlaubt und begründet ist.

**EN:** In this unit you learn to name segments, determine their protection need, justify allowed
transitions, and deliberately block all other transitions. The base rule is **deny by default**: a
transition is forbidden until it is explicitly allowed and justified.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Segmentierung / Segmentation | Aufteilung eines Netzes in getrennte Zonen mit eigenen Regeln. |
| Vertrauensgrenze / Trust boundary | Linie zwischen Zonen mit unterschiedlichem Schutzbedarf. |
| Deny by default / Deny by default | Grundhaltung: Alles ist verboten, außer es ist ausdrücklich erlaubt. |
| Defense in Depth / Defense in depth | Mehrere unabhängige Schutzschichten statt einer einzigen Grenze. |
| Least Privilege / Least privilege | Jeder Übergang erlaubt nur das minimal Nötige. |
| Blast Radius / Blast radius | Reichweite eines Schadens, wenn eine Zone kompromittiert wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Segmente bilden.** Fasse Knoten mit ähnlichem Schutzbedarf zu Zonen zusammen:
öffentliche Zone, Anwendungszone, Datenzone, Monitoring-Zone. Warum? Ein Angreifer, der eine Zone erreicht,
soll nicht automatisch alle anderen erreichen. Das begrenzt den Blast Radius.

**EN:** **Step 1 – Form segments.** Group nodes with similar protection needs into zones: public zone,
application zone, data zone, monitoring zone. Why? An attacker who reaches one zone should not automatically
reach all others. This limits the blast radius.

**DE:** **Schritt 2 – Schutzbedarf je Segment bestimmen.** Die Datenzone mit personenbezogenen Falldaten hat
den höchsten Schutzbedarf, die Monitoring-Zone mit reinen Zählwerten einen geringeren. Der Schutzbedarf
steuert, wie streng die Grenze zu diesem Segment kontrolliert wird.

**EN:** **Step 2 – Determine protection need per segment.** The data zone with personal case data has the
highest protection need, the monitoring zone with plain counters a lower one. The protection need drives how
strictly the boundary to that segment is controlled.

**DE:** **Schritt 3 – Erlaubte Übergänge begründen.** Für jeden erlaubten Übergang notierst du Zweck,
Richtung, Datenklasse und minimale Erlaubnis. Beispiel: Die Anwendungszone darf lesend und schreibend auf die
Datenzone zugreifen, aber die Monitoring-Zone darf die Datenzone gar nicht erreichen. Least Privilege heißt:
so wenig Übergang wie möglich.

**EN:** **Step 3 – Justify allowed transitions.** For each allowed transition you note purpose, direction,
data class, and minimal permission. Example: the application zone may read from and write to the data zone,
but the monitoring zone must not reach the data zone at all. Least privilege means: as little transition as
possible.

**DE:** **Schritt 4 – Alles andere blockieren.** Nach deny by default ist jeder nicht genannte Übergang
verboten. Schreibe das ausdrücklich hin. Ein nicht modellierter Übergang darf nie stillschweigend als sicher
gelten. So entsteht Defense in Depth: mehrere Grenzen hintereinander statt einer einzigen.

**EN:** **Step 4 – Block everything else.** Under deny by default every unnamed transition is forbidden.
Write that down explicitly. A non-modeled transition must never silently count as safe. This creates defense
in depth: several boundaries in sequence instead of a single one.

**DE:** **Schritt 5 – Übergänge mit Personenbezug gesondert prüfen.** Jeder Übergang, über den
personenbezogene Daten oder Secrets fließen, bekommt eine eigene Prüfnotiz: Ist Verschlüsselung nötig? Wird
protokolliert? Wer darf ihn nutzen? Diese Notizen sind später der Nachweis im Bedrohungsmodell.

**EN:** **Step 5 – Check personal-data transitions separately.** Every transition carrying personal data or
secrets gets its own check note: is encryption needed? Is it logged? Who may use it? These notes are later
the evidence in the threat model.

**DE:** **Typische Fehler.** Alle Knoten in eine große Zone werfen. Übergänge erlauben, ohne den Zweck zu
begründen. Nicht modellierte Übergänge als sicher annehmen. Monitoring-Zone Zugriff auf Falldaten geben.
Schutzbedarf nicht je Segment unterscheiden.

**EN:** **Common mistakes.** Throwing all nodes into one big zone. Allowing transitions without justifying
the purpose. Assuming non-modeled transitions are safe. Giving the monitoring zone access to case data. Not
differentiating protection needs per segment.

### Beispiel / Example

```text
Trust-Boundary-Matrix (Auszug):
  Von-Segment        Nach-Segment      Erlaubt?   Zweck                       Datenklasse
  Anwendungszone     Datenzone         ja         Fall lesen/schreiben        personenbezogen
  Anwendungszone     Monitoring-Zone   ja         Zaehlwerte senden           Betriebsdaten
  Monitoring-Zone    Datenzone         NEIN        - (deny by default)         -
  Oeffentliche Zone  Datenzone         NEIN        - (deny by default)         -

Prüfnotiz (personenbezogener Übergang):
  Anwendungszone -> Datenzone: verschlüsselt, protokolliert, nur Anwendungskonten erlaubt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Segmentierung und Trust Boundaries sind zentrale Maßnahmen, um Sicherheit vernetzter Systeme zu gewährleisten. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Zonen, Übergänge und Zugriffspfade knüpfen an das Bereitstellen segmentierter Netze und Dienste an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Defense in Depth, Least Privilege, Fail-Safe Defaults und
Trust Boundaries. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_04` (Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser
Einheit lautet: *Jeder Übergang zwischen Segmenten ist standardmäßig verboten und wird nur mit Begründung
und minimaler Erlaubnis geöffnet.* A11Y-Aspekt: Die Trust-Boundary-Matrix arbeitet mit den Wörtern „ja" und
„NEIN", nicht mit Grün/Rot allein, damit die Entscheidung ohne Farbwahrnehmung erkennbar bleibt.

**EN:** Relation to the Secure Development Guideline: defense in depth, least privilege, fail-safe defaults,
and trust boundaries. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_04` (threat modeling), and `CL_08` (security code review). The security decision of this unit is: *every
transition between segments is forbidden by default and only opened with justification and minimal
permission.* Accessibility aspect: the trust-boundary matrix uses the words "yes" and "NO", not green/red
alone, so the decision stays recognizable without color perception.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist der Zweck von Segmentierung, und was ist der Blast Radius? /
   **EN:** What is the purpose of segmentation, and what is the blast radius?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Segmentierung teilt das Netz in Zonen, sodass ein Problem nicht sofort alles betrifft. Der Blast
   Radius ist die Reichweite eines Schadens; kleine Segmente halten ihn klein.
   **EN:** Segmentation divides the network into zones so a problem does not affect everything at once. The
   blast radius is the reach of a compromise; small segments keep it small.

   </details>

2. **DE:** Warum bestimmt der Schutzbedarf, wie streng eine Segmentgrenze kontrolliert wird? /
   **EN:** Why does the protection need decide how strictly a segment boundary is controlled?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zonen mit personenbezogenen Daten oder Secrets brauchen strengere Grenzen als Zonen mit reinen
   Zählwerten. Aufwand und Kontrolle richten sich nach dem Schaden, der bei Verletzung entstünde.
   **EN:** Zones with personal data or secrets need stricter boundaries than zones with plain counters.
   Effort and control follow the damage a breach would cause.

   </details>

3. **DE:** (DV) Warum darf die Monitoring-Zone nicht auf die Datenzone zugreifen? /
   **EN:** (DV) Why must the monitoring zone not access the data zone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Monitoring braucht nur Betriebsdaten, keine personenbezogenen Falldaten. Ein Zugriff wäre unnötig
   (Least Privilege) und würde die Angriffsfläche und den Datenschutzumfang vergrößern.
   **EN:** Monitoring needs only operational data, not personal case data. Access would be unnecessary (least
   privilege) and would enlarge the attack surface and privacy scope.

   </details>

4. **DE:** Was bedeutet deny by default für nicht modellierte Übergänge? /
   **EN:** What does deny by default mean for non-modeled transitions?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Übergang, der nicht ausdrücklich erlaubt ist, gilt als verboten. Nicht modellierte Übergänge
   dürfen nie stillschweigend als sicher angenommen werden.
   **EN:** A transition that is not explicitly allowed counts as forbidden. Non-modeled transitions must
   never be silently assumed safe.

   </details>

5. **DE:** Wie zeigt sich Defense in Depth in einer segmentierten Topologie? /
   **EN:** How does defense in depth show in a segmented topology?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mehrere Grenzen liegen hintereinander. Wer eine Zone überwindet, steht vor der nächsten Grenze.
   Eine einzige Grenze wäre ein einzelner Fehlerpunkt.
   **EN:** Several boundaries lie in sequence. Whoever passes one zone faces the next boundary. A single
   boundary would be one point of failure.

   </details>

6. **DE:** Warum bekommt jeder Übergang mit Personenbezug eine eigene Prüfnotiz? /
   **EN:** Why does every personal-data transition get its own check note?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Übergänge tragen den höchsten Schutzbedarf. Die Notiz klärt Verschlüsselung,
   Protokollierung und Berechtigung und dient später als Nachweis im Bedrohungsmodell.
   **EN:** Personal-data transitions carry the highest protection need. The note clarifies encryption,
   logging, and authorization and later serves as evidence in the threat model.

   </details>

7. **DE:** Warum nutzt die Trust-Boundary-Matrix „ja/NEIN" statt nur Farben? /
   **EN:** Why does the trust-boundary matrix use "yes/NO" instead of colors only?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Text trägt die Bedeutung auch ohne Farbwahrnehmung und ist mit Screenreader und Braille-Zeile
   lesbar. Reine Farbsignale verletzen WCAG 2.2 AA.
   **EN:** Text carries the meaning even without color perception and is readable with a screen reader and
   Braille display. Color-only signals violate WCAG 2.2 AA.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Knoten zu Segmenten mit ähnlichem Schutzbedarf zusammenfassen.
- [ ] den Schutzbedarf je Segment bestimmen und begründen.
- [ ] erlaubte Übergänge mit Zweck, Richtung und minimaler Erlaubnis dokumentieren.
- [ ] deny by default anwenden und nicht modellierte Übergänge als verboten kennzeichnen.
- [ ] Übergänge mit Personenbezug mit einer eigenen Prüfnotiz versehen.

**EN:** I can …

- [ ] group nodes into segments with similar protection needs.
- [ ] determine and justify the protection need per segment.
- [ ] document allowed transitions with purpose, direction, and minimal permission.
- [ ] apply deny by default and mark non-modeled transitions as forbidden.
- [ ] give personal-data transitions their own check note.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_03_Trust-Boundaries-und-Segmentierung.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
