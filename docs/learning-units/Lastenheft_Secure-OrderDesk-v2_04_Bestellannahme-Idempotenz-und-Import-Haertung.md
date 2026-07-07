# Lastenheft: Secure OrderDesk v2 04 - Bestellannahme: Idempotenz und Import-Härtung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Bestellannahme mit Idempotenz bei Wiederholungen, gehärteter Bestell-Import (Dateiformate per Allowlist, Größenlimits, Pfadprüfung, sichere Deserialisierung) und die Behandlung nicht vertrauenswürdiger Bestell- und Positionsdaten werden beschrieben. Lernende machen die Bestellannahme des Secure OrderDesk wiederholbar und robust; ein doppelt eingereichter Auftrag für `ALFKI` erzeugt keine Doppelbuchung.

**EN:** Order intake with idempotency on repeats, a hardened order import (file formats via allow-list, size limits, path checking, safe deserialization), and handling of untrusted order and line data are described. Learners make the Secure OrderDesk order intake repeatable and robust; an order submitted twice for `ALFKI` does not create a double booking.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk v2"): **primär LF 8 („Daten systemübergreifend bereitstellen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk v2"): **primary LF 8 ("Daten systemübergreifend bereitstellen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_04, CL_08, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für eine gehärtete, wiederholbare Bestellannahme eine fokussierte Spezifikation. Berücksichtige: Idempotenz (ein doppelt eingereichter Auftrag – z. B. gleiche Client-/Auftrags-ID – verändert das Ergebnis nicht, kein doppelter `Order`-Kopf), Import-Härtung für Bestell-Batches (Dateiformate wie CSV/JSON per Allowlist, Größenlimits, Pfadprüfung/Kanonisierung, sichere Deserialisierung), Validierung nicht vertrauenswürdiger Bestell- und Positionsdaten (unbekannte `CustomerID`/`ProductID`, negative Menge, unplausibler Rabatt) und Negativtests werden beschrieben. `ALFKI` dient als fester Testanker.

**EN:** Prepare a focused specification for a hardened, repeatable order intake. Consider: idempotency (an order submitted twice – e.g. same client/order ID – does not change the result, no duplicate `Order` header), import hardening for order batches (file formats such as CSV/JSON via allow-list, size limits, path checking/canonicalization, safe deserialization), validation of untrusted order and line data (unknown `CustomerID`/`ProductID`, negative quantity, implausible discount), and negative tests. `ALFKI` serves as a fixed test anchor. Keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und der Bestellannahme-Ablauf sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Eingereichte Bestellungen, Importdateien, Client-/Auftrags-IDs, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen; Fehler geben keine internen Details an Endnutzer.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Idempotenz-Regel (Schlüssel/Upsert für Bestellungen), Import-Härtungsregeln, Validierungsregeln für Bestell-/Positionsdaten, Negativtests (Doppeleinreichung, manipulierte Datei), Datenschutzprüfung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Idempotenz-Regel für eine doppelt eingereichte Bestellung ist benannt.
- [ ] Mindestens ein Negativtest für gehärteten Import oder ungültige Bestelldaten ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine gehärtete, wiederholbare Bestellannahme mit Idempotenz und Import-Härtung der EuFPA-Lernreihe Secure OrderDesk v2 (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
