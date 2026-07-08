# Lastenheft: Secure OrderDesk Application Track 08 - Sichere Serialisierung und Schnittstellenverträge

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** AE - Anwendungsentwicklung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Serialisierung und Schnittstellenverträge der Bestell-/Handelsplattform für Secure Trader werden sicher gestaltet. Lernende definieren stabile Datenverträge für Kunden, Produkte, Bestellungen und Bestellpositionen (Schema, Versionierung, Kompatibilität), härten die Deserialisierung nicht vertrauenswürdiger Bestell- und Importdaten und weisen die Vertragstreue mit Tests nach.

**EN:** Serialization and interface contracts of the ordering/trading platform for Secure Trader are designed securely. Learners define stable data contracts for customers, products, orders, and order lines (schema, versioning, compatibility), harden the deserialization of untrusted order and import data, and evidence contract fidelity with tests.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (primär) | Welches Schema ist der stabile Vertrag der Bestelldomäne und wie bleibt es abwärtskompatibel? |
| SI | mittel | Wie wirkt sich ein Vertragswechsel auf Datenbank-Betrieb und Rollout aus? |
| DPA | mittel | Welche Felder eines Kunden- oder Bestellvertrags sind schützenswert oder personenbezogen? |
| DV | mittel bis hoch | Welche Serialisierung überschreitet welche Systemgrenze der Bestell-Pipeline? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe vertieft die sichere Realisierung von Anwendungsfunktionalität im 3. Lehrjahr. Sie verbindet stabile Datenverträge, sichere Deserialisierung und Kompatibilitätsdenken mit dem Anpassen der zugrunde liegenden relationalen Datenverwaltung (Northwind-Bestelldomäne inkl. `ALFKI`).

**EN:** The task deepens the secure realization of application functionality in the third year. It connects stable data contracts, secure deserialization, and compatibility thinking with adapting the underlying relational data management (Northwind ordering domain including `ALFKI`).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks", Application Track): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen") und LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks", Application Track): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen") and LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Trust Boundaries, sichere Deserialisierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Schnittstellen- und Datenvertrags-Vorgaben, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die sichere Serialisierung und die Schnittstellenverträge des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung AE - Anwendungsentwicklung. Berücksichtige: ein explizites Schema als Vertrag für Customer, Product, Order und OrderLine (Northwind-Layout inkl. `ALFKI`), Versionierung mit Abwärts- und Vorwärtskompatibilität, Validierung beim Deserialisieren (Whitelist von Typen/Feldern, Größen- und Tiefenlimits) und den Umgang mit unbekannten oder zusätzlichen Feldern. Keine unsichere Deserialisierung nicht vertrauenswürdiger Bestell- oder Importdaten. Der fachliche Datenvertrag bleibt sprachneutral; alle Daten bleiben fiktiv.

**EN:** Prepare a focused specification for the secure serialization and interface contracts of the Secure OrderDesk for the AE - Application Development specialization. Consider: an explicit schema as contract for Customer, Product, Order, and OrderLine (Northwind layout including `ALFKI`), versioning with backward and forward compatibility, validation on deserialization (whitelist of types/fields, size and depth limits), and handling of unknown or extra fields. No insecure deserialization of untrusted order or import data. The domain contract stays language-neutral; all data stays fictitious.

## Anforderungen / Requirements

- **R-01:** Ein explizites Schema definiert den Datenvertrag der Schnittstelle für Customer, Product, Order und OrderLine.
- **R-02:** Versionierung und Kompatibilitätsregeln (abwärts/vorwärts) sind festgelegt.
- **R-03:** Deserialisierung nicht vertrauenswürdiger Daten wird validiert und mit Limits geschützt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-/`ALFKI`-Quelle ist als fiktiver Testanker benannt.
- **R-05:** Der Umgang mit unbekannten Feldern ist eindeutig geregelt (ablehnen oder ignorieren, begründet).

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Kundendaten bleiben fiktiv (`ALFKI`).
- Serialisierte Eingaben, Bestellimporte, externe Antworten, Konfiguration und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Keine dynamische Typkonstruktion aus nicht vertrauenswürdigen Daten (Gadget-Chains vermeiden).
- Datenminimierung: nur benötigte Kundenfelder werden serialisiert und weitergegeben.
- Positive Sicherheitsaussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Datenvertrag (Customer, Product, Order, OrderLine im Northwind-Layout inkl. `ALFKI`) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Serialisierer dürfen gewählt werden, müssen aber auf sichere Konfiguration geprüft und begründet werden.
- MSL-Status ersetzt keine sichere Deserialisierungs-, Validierungs- oder Grenzprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Vertrags-, Serialisierungs-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Schema-/Vertragsdatei für die Bestelldomäne, Versionierungsregeln, Deserialisierungs-Härtungsnotiz, Kompatibilitätstestliste.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung AE ist klar sichtbar.
- [ ] Schema, Versionierung und Deserialisierungs-Härtung sind getrennt sichtbar.
- [ ] Mindestens ein Kompatibilitäts- und ein Härtungstest sind benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die sichere Serialisierung und die Schnittstellenverträge der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
