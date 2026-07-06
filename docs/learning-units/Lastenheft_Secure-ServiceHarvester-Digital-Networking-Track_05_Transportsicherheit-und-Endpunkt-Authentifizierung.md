# Lastenheft: Secure ServiceHarvester Digital Networking Track 05 - Transportsicherheit und Endpunkt-Authentifizierung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Primär geeignet für / Primary fit:** DV (Schwerpunkt); berührt SI, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Der Verkehr zwischen Sammel-Agenten und Sammler-Dienst wird transportgesichert und beidseitig authentifiziert. Lernende begründen TLS mit aktuellen Cipher Suites, gegenseitige Authentifizierung (mTLS) über Zertifikate, strenge Zertifikatsprüfung und einen kontrollierten Trust Store. Klartext-Übertragung sensibler Daten wird ausgeschlossen.

**EN:** Traffic between collection agents and the collector service is transport-secured and mutually authenticated. Learners justify TLS with current cipher suites, mutual authentication (mTLS) via certificates, strict certificate validation, and a controlled trust store. Plaintext transmission of sensitive data is excluded.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welcher Endpunkt muss sich wem gegenüber authentifizieren und wie wird das nachgewiesen? |
| SI | hoch | Welche TLS-/Zertifikatsannahme muss als Betriebs- und Rotationsnachweis geprüft werden? |
| AE | mittel bis hoch | Wie wirkt sich die Zertifikatsprüfung auf den Verbindungsaufbau im Client-Code aus? |
| DPA | mittel bis hoch | Welche Datenklasse verlangt zwingend Transportverschlüsselung und warum? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet den sicheren Betrieb vernetzter Systeme, die Netzeinbindung von Clients, sichere Kryptografie und auditfähige Dokumentation. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Kryptografie, Trust Boundaries, Fail-Safe Defaults, sichere Konfiguration und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Zugangssteuerung und Kryptografie-Vorgaben.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Transportsicherheit und Endpunkt-Authentifizierung eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: TLS mit aktuellen Algorithmen (z. B. AES-256, Ed25519), gegenseitige Authentifizierung (mTLS), Zertifikatsausstellung und -prüfung, Trust Store, Zertifikatsrotation, Ausschluss von Klartext und den Umgang mit Secrets als `<PLATZHALTER-KEIN-ECHTER-WERT>`. Baue auf der Segmentierung aus Einheit 04 auf.

**EN:** Prepare a focused specification for transport security and endpoint authentication for the Digital Networking specialization. Consider TLS with current algorithms (e.g. AES-256, Ed25519), mutual authentication (mTLS), certificate issuance and validation, trust store, certificate rotation, exclusion of plaintext, and handling secrets as `<PLATZHALTER-KEIN-ECHTER-WERT>`. Build on the segmentation from unit 04.

## Anforderungen / Requirements

- **R-01:** Transportverschlüsselung mit aktuellen Cipher Suites ist für jeden sensiblen Pfad festgelegt.
- **R-02:** Endpunkt-Authentifizierung (mindestens serverseitig, für kritische Pfade gegenseitig) ist beschrieben.
- **R-03:** Zertifikatsprüfung, Trust Store und Rotationsstrategie sind dokumentiert; Klartext ist ausgeschlossen.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten und keine echten Zertifikate/Schlüssel; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Aktuelle Algorithmen verwenden (AES-256, RSA >= 3072, SHA-256+, Ed25519); veraltete (MD5, SHA-1 für Signaturen, DES, RC4) nur mit expliziter Risikobegründung.
- Zertifikatsprüfung darf nicht deaktiviert werden; jede positive Sicherheitsaussage braucht einen Nachweis.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das TLS-/mTLS-Vertragsmodell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische TLS-Bibliotheken (z. B. Standard-Runtime, `rustls`, Keychain/CryptoKit) dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Crypto-, Zertifikats-, I/O- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Krypto-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Transportsicherheits-Tabelle (Pfad/Protokoll/Cipher/Authentifizierung), Zertifikats- und Trust-Store-Beschreibung, Rotationsplan, Negativtest gegen Klartext.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Klartext-Übertragung sensibler Daten ist ausgeschlossen und die Zertifikatsprüfung ist verpflichtend.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_05_Transportsicherheit-und-Endpunkt-Authentifizierung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Transportsicherheit und Endpunkt-Authentifizierung der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
