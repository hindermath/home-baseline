# Lernbegleiter: Secure OrderDesk Digital & Networking Track 05 – Transportsicherheit und Endpunkt-Authentifizierung / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`
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
sicherst du diesen Verkehr auf dem Weg: **Transportsicherheit** heißt, dass Bestelldaten zwischen Bestell-Client,
Bestellannahme, Katalog und relationaler Ablage (Northwind-Schema) verschlüsselt übertragen werden, damit niemand
sie unterwegs mitlesen oder verändern kann. Dazu kommt die **Endpunkt-Authentifizierung**: Beide Seiten müssen
sicher wissen, mit wem sie sprechen. Bei gegenseitiger Authentifizierung (**mTLS**) weist nicht nur der Dienst seine
Identität nach, sondern auch der Client. Klartext für sensible Daten wie personenbezogene Kundendaten (z. B.
`ContactName` von `ALFKI`) ist ausgeschlossen, und die Zertifikatsprüfung darf nie abgeschaltet werden.

**EN:** The segmentation from unit 04 says *which* traffic may flow through which choke point. Now you secure this
traffic in transit: **transport security** means order data between order client, order intake, catalog, and the
relational store (Northwind schema) is transmitted encrypted so that no one can read or alter it on the way. Added
to this is **endpoint authentication**: both sides must reliably know whom they are talking to. With mutual
authentication (**mTLS**) not only the service proves its identity, but also the client. Plaintext for sensitive
data such as personal customer data (e.g. `ContactName` of `ALFKI`) is excluded, and certificate validation must
never be turned off.

**DE:** In dieser Einheit lernst du, TLS mit aktuellen Algorithmen zu begründen, gegenseitige Authentifizierung
über Zertifikate zu beschreiben, einen kontrollierten Trust Store und eine Rotationsstrategie zu planen und
Klartext auszuschließen. mutual TLS, API-Keys oder Tokens sind als Konzept zu unterscheiden; echte Schlüssel,
Tokens und Zertifikate kommen nie in Beispiele, Secrets stehen nur als `<PLATZHALTER-KEIN-ECHTER-WERT>` (etwa
`<API_KEY>` oder `token=REDACTED`). Die C#-Referenz `InventarWorkerService` dient als Orientierung; die Lösung
bleibt sprachneutral.

**EN:** In this unit you learn to justify TLS with current algorithms, to describe mutual authentication via
certificates, to plan a controlled trust store and a rotation strategy, and to exclude plaintext. Mutual TLS,
API keys, or tokens are to be distinguished as concepts; real keys, tokens, and certificates never appear in
examples, secrets appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>` (e.g. `<API_KEY>` or `token=REDACTED`). The C#
reference `InventarWorkerService` serves as orientation; the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Transportsicherheit / TLS | Schutz von Bestelldaten während der Übertragung durch Verschlüsselung; TLS ist das Protokoll dafür. |
| Verschlüsselung in Transit / Encryption in transit | Daten sind nur auf dem Netzweg zwischen den Endpunkten verschlüsselt, nicht nur ruhend. |
| Zertifikat / Certificate | Digitaler Ausweis, der eine Identität an einen öffentlichen Schlüssel bindet. |
| Endpunkt-Authentifizierung / Endpoint authentication | Nachweis, dass ein Endpunkt (Client oder Dienst) wirklich der ist, der er zu sein vorgibt. |
| mutual TLS / mutual TLS | Gegenseitige TLS-Authentifizierung: beide Endpunkte weisen sich per Zertifikat aus. |
| Sichere Defaults / Secure defaults | Voreinstellungen, die von sich aus stark sind (TLS 1.2+/1.3, keine schwachen Cipher). |
| Downgrade-Angriff / Downgrade attack | Versuch, eine Verbindung auf ein veraltetes, schwaches Protokoll (z. B. TLS 1.0) zu drücken. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Sensible Pfade bestimmen.** Übernimm aus Einheit 03/04, welche Verbindungen der
Bestell-Pipeline sensible Daten oder Secrets tragen, etwa der Weg vom Bestell-Client zur Bestellannahme oder von
der Bestellannahme zur Northwind-Ablage. Genau diese Pfade brauchen zwingend Transportverschlüsselung. Notiere je
Pfad, welche Datenklasse fließt und warum Verschlüsselung Pflicht ist.

**EN:** **Step 1 – Determine sensitive paths.** Take from units 03/04 which connections of the order pipeline
carry sensitive data or secrets, e.g. the path from order client to order intake or from order intake to the
Northwind store. Exactly these paths strictly need transport encryption. For each path note which data class flows
and why encryption is mandatory.

**DE:** **Schritt 2 – TLS mit aktuellen Algorithmen und sicheren Defaults begründen.** Wähle aktuelle, starke
Verfahren (TLS 1.2+ oder 1.3, z. B. AES-256, SHA-256+, Ed25519). Veraltete Protokolle wie TLS 1.0/1.1 und schwache
Verfahren wie MD5, SHA-1 für Signaturen, DES oder RC4 sind tabu – höchstens mit ausdrücklicher Risikobegründung.
Ein Angreifer versucht sonst einen Downgrade-Angriff. Schreibe je Pfad Protokollversion und Cipher-Annahme auf,
damit die Wahl prüfbar ist.

**EN:** **Step 2 – Justify TLS with current algorithms and secure defaults.** Choose current, strong methods (TLS
1.2+ or 1.3, e.g. AES-256, SHA-256+, Ed25519). Outdated protocols like TLS 1.0/1.1 and weak methods like MD5,
SHA-1 for signatures, DES, or RC4 are off-limits – at most with an explicit risk justification. Otherwise an
attacker attempts a downgrade attack. For each path write down the protocol version and cipher assumption so the
choice is checkable.

**DE:** **Schritt 3 – Endpunkt-Authentifizierung festlegen.** Serverseitige Authentifizierung reicht nicht immer:
Für kritische Bestellpfade weist auch der Client seine Identität nach – per Zertifikat (mTLS) oder als Konzept per
API-Key/Token. So kann sich kein fremder Client als vertrauenswürdiger Bestell-Endpunkt ausgeben. Lege je Pfad
fest, wer sich wem gegenüber ausweisen muss.

**EN:** **Step 3 – Set endpoint authentication.** Server-side authentication is not always enough: for critical
order paths the client also proves its identity – via certificate (mTLS) or, as a concept, via API key/token. This
way no foreign client can impersonate a trusted order endpoint. For each path define who must authenticate to
whom.

**DE:** **Schritt 4 – Zertifikatsprüfung und Trust Store.** Die Gegenseite gilt nur als vertrauenswürdig, wenn ihr
Zertifikat gegen einen kontrollierten Trust Store geprüft wird. Die Prüfung (Gültigkeit, Aussteller, Name) darf nie
deaktiviert werden – ein häufiger, gefährlicher Fehler. Beschreibe, welche Zertifikate/CAs der Trust Store enthält
und wie er gepflegt wird.

**EN:** **Step 4 – Certificate validation and trust store.** The counterpart is trusted only if its certificate is
checked against a controlled trust store. The check (validity, issuer, name) must never be disabled – a common,
dangerous mistake. Describe which certificates/CAs the trust store contains and how it is maintained.

**DE:** **Schritt 5 – Rotation planen und Klartext ausschließen.** Zertifikate, API-Keys und Tokens laufen ab oder
werden ungültig; plane ihren Austausch **vor** Ablauf (Rotation), ohne dass die Bestell-Pipeline stehen bleibt. Und
stelle sicher, dass es keinen Fallback auf unverschlüsselten Klartext gibt: Schlägt die gesicherte Verbindung fehl,
wird sie abgelehnt, nicht heimlich unverschlüsselt fortgesetzt (Fail-Safe). Ein Negativtest belegt, dass Klartext
verweigert wird.

**EN:** **Step 5 – Plan rotation and exclude plaintext.** Certificates, API keys, and tokens expire or become
invalid; plan their replacement **before** expiry (rotation) without the order pipeline stopping. And ensure there
is no fallback to unencrypted plaintext: if the secured connection fails, it is refused, not silently continued
unencrypted (fail-safe). A negative test proves that plaintext is refused.

**DE:** **Typische Fehler.** Zertifikatsprüfung „zum Testen" abschalten und vergessen. Nur den Dienst, nicht den
Client authentifizieren, wo mTLS nötig wäre. TLS 1.0/1.1 oder veraltete Cipher zulassen. Keinen Rotationsplan
haben, bis das Zertifikat abläuft. Stillen Fallback auf Klartext erlauben. Echte Schlüssel, API-Keys oder Tokens in
Beispiele oder Repos schreiben statt `<PLATZHALTER-KEIN-ECHTER-WERT>`, `<API_KEY>` oder `token=REDACTED`.

**EN:** **Common mistakes.** Turning off certificate validation "for testing" and forgetting it. Authenticating
only the service, not the client, where mTLS is needed. Allowing TLS 1.0/1.1 or outdated ciphers. Having no
rotation plan until the certificate expires. Allowing a silent fallback to plaintext. Writing real keys, API keys,
or tokens into examples or repos instead of `<PLATZHALTER-KEIN-ECHTER-WERT>`, `<API_KEY>`, or `token=REDACTED`.

### Beispiel / Example

```text
Transportsicherheits-Tabelle (Auszug):
  Pfad                     Protokoll   Cipher/Alg.       Authentifizierung   Klartext
  Bestell-Client -> Annah. TLS 1.3     AES-256/Ed25519   mTLS (beidseitig)   verboten
  Annahme -> Northwind-DB  TLS 1.3     AES-256           serverseitig+       verboten
  Katalog -> Bestell-Cl.   TLS 1.2+    AES-256           serverseitig        verboten
  Admin -> Bestellannahme  TLS 1.3     AES-256           mTLS (Pruefung!)    verboten

Trust Store:   nur interne CA von Secure Trader; Zertifikatspruefung immer aktiv
Sichere Def.:  min. TLS 1.2, kein TLS 1.0/1.1, keine schwachen Cipher (Downgrade abgelehnt)
Rotation:      Zertifikate 30 Tage vor Ablauf erneuern; ueberlappende Gueltigkeit
Negativtest:   Verbindungsversuch ohne TLS -> abgelehnt (Fail-Safe), protokolliert
Secrets/Keys:  in Beispielen nur <PLATZHALTER-KEIN-ECHTER-WERT>, <API_KEY>, token=REDACTED
Beispielkunde: ALFKI (fiktiv, Northwind)
Open:          exakte Cipher-Suite-Liste fuer Swift-Client noch zu bestaetigen -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Transportverschlüsselung und Endpunkt-Authentifizierung der Bestell-Pipeline sind Kern des sicheren Betriebs vernetzter Systeme. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Zertifikatsprüfung und mTLS wirken direkt auf den sicheren Verbindungsaufbau der Bestell-Clients. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Trust Store, Rotation und TLS-Konfiguration gehören zur sicheren Bereitstellung von Bestellannahme und Katalog. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Kryptografie, Trust Boundaries, Fail-Safe Defaults,
sichere Konfiguration und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_05` (Kryptografie), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Sensible Bestell- und Kundendaten
fließen nur verschlüsselt mit aktuellen Algorithmen (TLS 1.2+/1.3, AES, Ed25519), Endpunkte authentifizieren sich,
die Zertifikatsprüfung bleibt aktiv, und es gibt keinen Fallback auf Klartext.* Kryptografie-Hinweis: Nutze aktuelle
Verfahren; veraltete (TLS 1.0/1.1, MD5, SHA-1 für Signaturen, DES, RC4) nur mit ausdrücklicher Risikobegründung.
A11Y-Aspekt: Die Transportsicherheits-Tabelle muss als echte Tabelle mit Kopfzeile in reinem Text lesbar sein, ohne
Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: secure cryptography, trust boundaries, fail-safe defaults,
secure configuration, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_05` (cryptography), `CL_08` (security code review), `CL_10` (data protection), and
`CL_12` (evidence and closure). The security decision of this unit is: *sensitive order and customer data flow only
encrypted with current algorithms (TLS 1.2+/1.3, AES, Ed25519), endpoints authenticate, certificate validation
stays active, and there is no fallback to plaintext.* Cryptography note: use current methods; outdated ones (TLS
1.0/1.1, MD5, SHA-1 for signatures, DES, RC4) only with an explicit risk justification. Accessibility aspect: the
transport-security table must be readable as a real table with a header row in plain text, without color coding, so
it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was unterscheidet serverseitige Authentifizierung von mTLS? /
   **EN:** (DV) What distinguishes server-side authentication from mTLS?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei serverseitiger Authentifizierung weist nur der Dienst (z. B. die Bestellannahme) seine Identität
   nach. Bei mTLS weisen sich beide Seiten aus, auch der Bestell-Client. So kann sich kein fremder Client als
   vertrauenswürdiger Endpunkt ausgeben.
   **EN:** With server-side authentication only the service (e.g. order intake) proves its identity. With mTLS both
   sides authenticate, including the order client. This way no foreign client can impersonate a trusted endpoint.

   </details>

2. **DE:** (DV) Warum darf die Zertifikatsprüfung nie deaktiviert werden? /
   **EN:** (DV) Why must certificate validation never be disabled?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Prüfung akzeptiert der Endpunkt jedes Zertifikat, auch ein gefälschtes. Ein Angreifer kann sich dann
   als Gegenseite ausgeben (Man-in-the-Middle) und Bestelldaten mitlesen oder verändern. Die Prüfung von Gültigkeit,
   Aussteller und Name ist der Kern des Vertrauens.
   **EN:** Without validation the endpoint accepts any certificate, including a forged one. An attacker can then
   impersonate the counterpart (man-in-the-middle) and read or alter order data. Checking validity, issuer, and name
   is the core of trust.

   </details>

3. **DE:** (DPA) Welche Datenklasse verlangt zwingend Transportverschlüsselung und warum? /
   **EN:** (DPA) Which data class strictly requires transport encryption, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Kundendaten (z. B. `ContactName`, Adresse von `ALFKI`) und Secrets. Unverschlüsselt
   könnten sie auf dem Netzweg mitgelesen oder verändert werden. Verschlüsselung schützt Vertraulichkeit und
   Integrität an der Vertrauensgrenze.
   **EN:** Personal customer data (e.g. `ContactName`, address of `ALFKI`) and secrets. Unencrypted, they could be
   read or altered in transit. Encryption protects confidentiality and integrity at the trust boundary.

   </details>

4. **DE:** Warum sind aktuelle Verfahren (z. B. TLS 1.3, AES-256, Ed25519) statt veralteter (TLS 1.0, MD5, RC4) zu
   wählen? /
   **EN:** Why choose current methods (e.g. TLS 1.3, AES-256, Ed25519) instead of outdated ones (TLS 1.0, MD5, RC4)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Veraltete Protokolle und Verfahren gelten als gebrochen oder schwach und lassen sich mit vertretbarem
   Aufwand angreifen, etwa per Downgrade-Angriff. Aktuelle Verfahren bieten heute noch Schutz. Veraltete nur mit
   ausdrücklicher Risikobegründung.
   **EN:** Outdated protocols and methods are considered broken or weak and can be attacked with reasonable effort,
   e.g. via a downgrade attack. Current methods still provide protection today. Outdated ones only with an explicit
   risk justification.

   </details>

5. **DE:** (SI) Warum braucht man eine Zertifikatsrotation und wie weist man sie nach? /
   **EN:** (SI) Why do you need certificate rotation, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zertifikate, API-Keys und Tokens laufen ab; ohne rechtzeitigen Austausch bricht die gesicherte
   Verbindung der Bestell-Pipeline. Rotation erneuert sie vorher, idealerweise mit überlappender Gültigkeit.
   Nachweis: ein Rotationsplan und ein Test, der die Erneuerung ohne Ausfall zeigt.
   **EN:** Certificates, API keys, and tokens expire; without timely replacement the secured connection of the order
   pipeline breaks. Rotation renews them beforehand, ideally with overlapping validity. Evidence: a rotation plan and
   a test showing renewal without outage.

   </details>

6. **DE:** Warum darf es keinen stillen Fallback auf Klartext geben? /
   **EN:** Why must there be no silent fallback to plaintext?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein stiller Fallback überträgt sensible Bestell- und Kundendaten unbemerkt unverschlüsselt und hebt den
   Schutz auf. Sicher ist: Schlägt die gesicherte Verbindung fehl, wird sie abgelehnt (Fail-Safe), nicht heimlich
   unverschlüsselt fortgesetzt.
   **EN:** A silent fallback transmits sensitive order and customer data unnoticed and unencrypted, nullifying the
   protection. The safe behavior is: if the secured connection fails, it is refused (fail-safe), not silently
   continued unencrypted.

   </details>

7. **DE:** (AE) Wie wirkt sich die Zertifikatsprüfung auf den Verbindungsaufbau im Client-Code aus? /
   **EN:** (AE) How does certificate validation affect connection setup in the client code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Bestell-Client baut die Verbindung nur auf, wenn das Server-Zertifikat gegen den Trust Store gültig
   ist; bei mTLS sendet er zusätzlich sein eigenes Zertifikat. Fehlerfälle müssen die Verbindung ablehnen, nicht
   umgehen; Secrets bleiben `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** The order client establishes the connection only if the server certificate is valid against the trust
   store; with mTLS it additionally sends its own certificate. Error cases must refuse the connection, not bypass it;
   secrets stay `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die sensiblen Pfade der Bestell-Pipeline bestimmen, die Transportverschlüsselung brauchen.
- [ ] TLS mit aktuellen Algorithmen und sicheren Defaults begründen und veraltete Protokolle ausschließen.
- [ ] serverseitige Authentifizierung von mTLS (und API-Keys/Tokens als Konzept) unterscheiden und je Pfad wählen.
- [ ] Zertifikatsprüfung und einen kontrollierten Trust Store beschreiben.
- [ ] eine Rotation planen und Klartext-Fallback ausschließen.
- [ ] Secrets, Schlüssel und Tokens nur als Platzhalter (`<PLATZHALTER-KEIN-ECHTER-WERT>`, `<API_KEY>`, `token=REDACTED`) verwenden und nicht anwendbare Punkte als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] determine the sensitive paths of the order pipeline that need transport encryption.
- [ ] justify TLS with current algorithms and secure defaults and exclude outdated protocols.
- [ ] distinguish server-side authentication from mTLS (and API keys/tokens as a concept) and choose per path.
- [ ] describe certificate validation and a controlled trust store.
- [ ] plan rotation and exclude a plaintext fallback.
- [ ] use secrets, keys, and tokens only as placeholders (`<PLATZHALTER-KEIN-ECHTER-WERT>`, `<API_KEY>`, `token=REDACTED`) and document non-applicable points as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`.
Sie baut auf Einheit 04 (`Segmentierung und Vertrauenszonen`) auf und sichert die dort freigegebenen Bestellflüsse
auf dem Transportweg. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md`.
It builds on unit 04 (`segmentation and trust zones`) and secures the order flows permitted there in transit. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
