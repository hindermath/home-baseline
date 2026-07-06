# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 05 – Transportsicherheit und Endpunkt-Authentifizierung / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Segmentierung aus Einheit 04 sagt, *welcher* Verkehr über welchen Choke Point fließen darf. Jetzt
sicherst du diesen Verkehr auf dem Weg: **Transportsicherheit** heißt, dass Daten zwischen Sammel-Agent und
Sammler-Dienst verschlüsselt übertragen werden, damit niemand sie unterwegs mitlesen oder verändern kann. Dazu
kommt die **Endpunkt-Authentifizierung**: Beide Seiten müssen sicher wissen, mit wem sie sprechen. Bei
gegenseitiger Authentifizierung (**mTLS**) weist nicht nur der Dienst seine Identität nach, sondern auch der
Agent. Klartext für sensible Daten ist ausgeschlossen, und die Zertifikatsprüfung darf nie abgeschaltet werden.

**EN:** The segmentation from unit 04 says *which* traffic may flow through which choke point. Now you secure this
traffic in transit: **transport security** means data between collection agent and collector service is
transmitted encrypted so that no one can read or alter it on the way. Added to this is **endpoint
authentication**: both sides must reliably know whom they are talking to. With mutual authentication (**mTLS**)
not only the service proves its identity, but also the agent. Plaintext for sensitive data is excluded, and
certificate validation must never be turned off.

**DE:** In dieser Einheit lernst du, TLS mit aktuellen Algorithmen zu begründen, gegenseitige Authentifizierung
über Zertifikate zu beschreiben, einen kontrollierten Trust Store und eine Rotationsstrategie zu planen und
Klartext auszuschließen. Echte Schlüssel und Zertifikate kommen nie in Beispiele; Secrets stehen nur als
`<PLATZHALTER-KEIN-ECHTER-WERT>`. Die C#-Referenz `InventarWorkerService` dient als Orientierung; die Lösung
bleibt sprachneutral.

**EN:** In this unit you learn to justify TLS with current algorithms, to describe mutual authentication via
certificates, to plan a controlled trust store and a rotation strategy, and to exclude plaintext. Real keys and
certificates never appear in examples; secrets appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`. The C# reference
`InventarWorkerService` serves as orientation; the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Transportsicherheit / Transport security | Schutz von Daten während der Übertragung durch Verschlüsselung. |
| TLS / TLS | Protokoll, das Verkehr verschlüsselt und die Gegenseite prüft. |
| mTLS / mTLS | Gegenseitige TLS-Authentifizierung: beide Endpunkte weisen sich aus. |
| Zertifikat / Certificate | Digitaler Ausweis, der eine Identität an einen Schlüssel bindet. |
| Trust Store / Trust store | Kontrollierte Liste vertrauenswürdiger Zertifikate/CAs. |
| Zertifikatsrotation / Certificate rotation | Geplanter Austausch von Zertifikaten vor Ablauf. |
| Klartext / Plaintext | Unverschlüsselte Übertragung; für sensible Daten verboten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Sensible Pfade bestimmen.** Übernimm aus Einheit 03/04, welche Verbindungen sensible Daten
oder Secrets tragen. Genau diese Pfade brauchen zwingend Transportverschlüsselung. Notiere je Pfad, welche
Datenklasse fließt und warum Verschlüsselung Pflicht ist.

**EN:** **Step 1 – Determine sensitive paths.** Take from units 03/04 which connections carry sensitive data or
secrets. Exactly these paths strictly need transport encryption. For each path note which data class flows and why
encryption is mandatory.

**DE:** **Schritt 2 – TLS mit aktuellen Algorithmen begründen.** Wähle aktuelle, starke Verfahren (z. B. AES-256,
SHA-256+, Ed25519). Veraltete Verfahren wie MD5, SHA-1 für Signaturen, DES oder RC4 sind tabu – höchstens mit
ausdrücklicher Risikobegründung. Schreibe je Pfad Protokollversion und Cipher-Annahme auf, damit die Wahl prüfbar
ist.

**EN:** **Step 2 – Justify TLS with current algorithms.** Choose current, strong methods (e.g. AES-256, SHA-256+,
Ed25519). Outdated methods like MD5, SHA-1 for signatures, DES, or RC4 are off-limits – at most with an explicit
risk justification. For each path write down the protocol version and cipher assumption so the choice is
checkable.

**DE:** **Schritt 3 – Endpunkt-Authentifizierung festlegen.** Serverseitige Authentifizierung reicht nicht immer:
Für kritische Sammelpfade weist auch der Agent seine Identität per Zertifikat nach (mTLS). So kann sich kein
fremder Client als Agent ausgeben. Lege je Pfad fest, wer sich wem gegenüber ausweisen muss.

**EN:** **Step 3 – Set endpoint authentication.** Server-side authentication is not always enough: for critical
collection paths the agent also proves its identity via certificate (mTLS). This way no foreign client can
impersonate an agent. For each path define who must authenticate to whom.

**DE:** **Schritt 4 – Zertifikatsprüfung und Trust Store.** Die Gegenseite gilt nur als vertrauenswürdig, wenn ihr
Zertifikat gegen einen kontrollierten Trust Store geprüft wird. Die Prüfung (Gültigkeit, Aussteller, Name) darf
nie deaktiviert werden – ein häufiger, gefährlicher Fehler. Beschreibe, welche Zertifikate/CAs der Trust Store
enthält und wie er gepflegt wird.

**EN:** **Step 4 – Certificate validation and trust store.** The counterpart is trusted only if its certificate is
checked against a controlled trust store. The check (validity, issuer, name) must never be disabled – a common,
dangerous mistake. Describe which certificates/CAs the trust store contains and how it is maintained.

**DE:** **Schritt 5 – Rotation planen und Klartext ausschließen.** Zertifikate laufen ab; plane ihren Austausch
**vor** Ablauf (Rotation), ohne dass der Dienst stehen bleibt. Und stelle sicher, dass es keinen Fallback auf
unverschlüsselten Klartext gibt: Schlägt die gesicherte Verbindung fehl, wird sie abgelehnt, nicht heimlich
unverschlüsselt fortgesetzt (Fail-Safe). Ein Negativtest belegt, dass Klartext verweigert wird.

**EN:** **Step 5 – Plan rotation and exclude plaintext.** Certificates expire; plan their replacement **before**
expiry (rotation) without the service stopping. And ensure there is no fallback to unencrypted plaintext: if the
secured connection fails, it is refused, not silently continued unencrypted (fail-safe). A negative test proves
that plaintext is refused.

**DE:** **Typische Fehler.** Zertifikatsprüfung „zum Testen" abschalten und vergessen. Nur den Server, nicht den
Client authentifizieren, wo mTLS nötig wäre. Veraltete Cipher zulassen. Keinen Rotationsplan haben, bis das
Zertifikat abläuft. Stillen Fallback auf Klartext erlauben. Echte Schlüssel in Beispiele oder Repos schreiben statt
`<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** **Common mistakes.** Turning off certificate validation "for testing" and forgetting it. Authenticating
only the server, not the client, where mTLS is needed. Allowing outdated ciphers. Having no rotation plan until
the certificate expires. Allowing a silent fallback to plaintext. Writing real keys into examples or repos instead
of `<PLATZHALTER-KEIN-ECHTER-WERT>`.

### Beispiel / Example

```text
Transportsicherheits-Tabelle (Auszug):
  Pfad                    Protokoll   Cipher/Alg.       Authentifizierung   Klartext
  Agent -> Sammler        TLS 1.3     AES-256/Ed25519   mTLS (beidseitig)   verboten
  Sammler -> Datenhaltung TLS 1.3     AES-256           serverseitig+       verboten
  Auswertung -> Datenh.   TLS 1.3     AES-256           serverseitig        verboten
  Admin -> Sammler        TLS 1.3     AES-256           mTLS (Pruefung!)    verboten

Trust Store:   nur interne CA der EuFPA; Zertifikatspruefung immer aktiv
Rotation:      Zertifikate 30 Tage vor Ablauf erneuern; ueberlappende Gueltigkeit
Negativtest:   Verbindungsversuch ohne TLS -> abgelehnt (Fail-Safe), protokolliert
Secrets/Keys:  in Beispielen nur <PLATZHALTER-KEIN-ECHTER-WERT>
Open:          exakte Cipher-Suite-Liste fuer Swift-Client noch zu bestaetigen -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Transportverschlüsselung und Endpunkt-Authentifizierung sind Kern des sicheren Betriebs vernetzter Systeme. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Zertifikatsprüfung und mTLS wirken direkt auf den sicheren Verbindungsaufbau der Clients. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Trust Store, Rotation und TLS-Konfiguration gehören zur sicheren Bereitstellung von Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Kryptografie, Trust Boundaries, Fail-Safe Defaults,
sichere Konfiguration und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_05` (Kryptografie), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Sensible Daten fließen nur
verschlüsselt mit aktuellen Algorithmen, Endpunkte authentifizieren sich, die Zertifikatsprüfung bleibt aktiv, und
es gibt keinen Fallback auf Klartext.* A11Y-Aspekt: Die Transportsicherheits-Tabelle muss als echte Tabelle mit
Kopfzeile in reinem Text lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleibt.

**EN:** Relation to the Secure Development Guideline: secure cryptography, trust boundaries, fail-safe defaults,
secure configuration, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_05` (cryptography), `CL_08` (security code review), `CL_10` (data protection), and
`CL_12` (evidence and closure). The security decision of this unit is: *sensitive data flows only encrypted with
current algorithms, endpoints authenticate, certificate validation stays active, and there is no fallback to
plaintext.* Accessibility aspect: the transport-security table must be readable as a real table with a header row
in plain text, without color coding, so it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was unterscheidet serverseitige Authentifizierung von mTLS? /
   **EN:** (DV) What distinguishes server-side authentication from mTLS?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei serverseitiger Authentifizierung weist nur der Dienst seine Identität nach. Bei mTLS weisen sich
   beide Seiten aus, auch der Agent. So kann sich kein fremder Client als vertrauenswürdiger Agent ausgeben.
   **EN:** With server-side authentication only the service proves its identity. With mTLS both sides authenticate,
   including the agent. This way no foreign client can impersonate a trusted agent.

   </details>

2. **DE:** (DV) Warum darf die Zertifikatsprüfung nie deaktiviert werden? /
   **EN:** (DV) Why must certificate validation never be disabled?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Prüfung akzeptiert der Endpunkt jedes Zertifikat, auch ein gefälschtes. Ein Angreifer kann sich
   dann als Gegenseite ausgeben (Man-in-the-Middle). Die Prüfung von Gültigkeit, Aussteller und Name ist der Kern
   des Vertrauens.
   **EN:** Without validation the endpoint accepts any certificate, including a forged one. An attacker can then
   impersonate the counterpart (man-in-the-middle). Checking validity, issuer, and name is the core of trust.

   </details>

3. **DE:** (DPA) Welche Datenklasse verlangt zwingend Transportverschlüsselung und warum? /
   **EN:** (DPA) Which data class strictly requires transport encryption, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sensible Daten und Secrets. Unverschlüsselt könnten sie auf dem Netzweg mitgelesen oder verändert
   werden. Verschlüsselung schützt Vertraulichkeit und Integrität an der Vertrauensgrenze.
   **EN:** Sensitive data and secrets. Unencrypted, they could be read or altered in transit. Encryption protects
   confidentiality and integrity at the trust boundary.

   </details>

4. **DE:** Warum sind aktuelle Algorithmen (z. B. AES-256, Ed25519) statt veralteter (MD5, RC4) zu wählen? /
   **EN:** Why choose current algorithms (e.g. AES-256, Ed25519) instead of outdated ones (MD5, RC4)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Veraltete Verfahren gelten als gebrochen oder schwach und lassen sich mit vertretbarem Aufwand
   angreifen. Aktuelle Verfahren bieten heute noch Schutz. Veraltete nur mit ausdrücklicher Risikobegründung.
   **EN:** Outdated methods are considered broken or weak and can be attacked with reasonable effort. Current
   methods still provide protection today. Outdated ones only with an explicit risk justification.

   </details>

5. **DE:** (SI) Warum braucht man eine Zertifikatsrotation und wie weist man sie nach? /
   **EN:** (SI) Why do you need certificate rotation, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zertifikate laufen ab; ohne rechtzeitigen Austausch bricht die gesicherte Verbindung. Rotation erneuert
   sie vorher, idealerweise mit überlappender Gültigkeit. Nachweis: ein Rotationsplan und ein Test, der die
   Erneuerung ohne Ausfall zeigt.
   **EN:** Certificates expire; without timely replacement the secured connection breaks. Rotation renews them
   beforehand, ideally with overlapping validity. Evidence: a rotation plan and a test showing renewal without
   outage.

   </details>

6. **DE:** Warum darf es keinen stillen Fallback auf Klartext geben? /
   **EN:** Why must there be no silent fallback to plaintext?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein stiller Fallback überträgt sensible Daten unbemerkt unverschlüsselt und hebt den Schutz auf. Sicher
   ist: Schlägt die gesicherte Verbindung fehl, wird sie abgelehnt (Fail-Safe), nicht heimlich unverschlüsselt
   fortgesetzt.
   **EN:** A silent fallback transmits sensitive data unnoticed and unencrypted, nullifying the protection. The
   safe behavior is: if the secured connection fails, it is refused (fail-safe), not silently continued
   unencrypted.

   </details>

7. **DE:** (AE) Wie wirkt sich die Zertifikatsprüfung auf den Verbindungsaufbau im Client-Code aus? /
   **EN:** (AE) How does certificate validation affect connection setup in the client code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Client baut die Verbindung nur auf, wenn das Server-Zertifikat gegen den Trust Store gültig ist; bei
   mTLS sendet er zusätzlich sein eigenes Zertifikat. Fehlerfälle müssen die Verbindung ablehnen, nicht umgehen.
   **EN:** The client establishes the connection only if the server certificate is valid against the trust store;
   with mTLS it additionally sends its own certificate. Error cases must refuse the connection, not bypass it.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die sensiblen Pfade bestimmen, die Transportverschlüsselung brauchen.
- [ ] TLS mit aktuellen Algorithmen begründen und veraltete ausschließen.
- [ ] serverseitige Authentifizierung von mTLS unterscheiden und je Pfad wählen.
- [ ] Zertifikatsprüfung und einen kontrollierten Trust Store beschreiben.
- [ ] eine Zertifikatsrotation planen und Klartext-Fallback ausschließen.
- [ ] Secrets und Schlüssel nur als `<PLATZHALTER-KEIN-ECHTER-WERT>` verwenden.

**EN:** I can …

- [ ] determine the sensitive paths that need transport encryption.
- [ ] justify TLS with current algorithms and exclude outdated ones.
- [ ] distinguish server-side authentication from mTLS and choose per path.
- [ ] describe certificate validation and a controlled trust store.
- [ ] plan certificate rotation and exclude a plaintext fallback.
- [ ] use secrets and keys only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`.
Sie baut auf Einheit 04 (`Segmentierung und Vertrauenszonen`) auf und sichert die dort freigegebenen Flüsse auf dem
Transportweg. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`.
It builds on unit 04 (`segmentation and trust zones`) and secures the flows permitted there in transit. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
