# Lastenheft: Secure OrderDesk Operations Track 04 - Härtung und Angriffsflächen-Reduktion

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Der betriebene Datenbank-Dienst und die Bestell-/Handelsplattform werden gehärtet: ungenutzte Endpunkte, Datenbank-Funktionen, Beispieldatenbanken, Standardkonten und Debug-Funktionen werden abgeschaltet, Rechte und Netzflächen minimiert, und jede Härtungsmaßnahme erhält einen Nachweis. Lernende reduzieren die Angriffsfläche systematisch statt punktuell.

**EN:** The operated database service and the ordering/trading platform are hardened: unused endpoints, database features, sample databases, default accounts, and debug features are disabled, rights and network surfaces minimized, and every hardening measure gets an evidence entry. Learners reduce the attack surface systematically rather than ad hoc.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welche abgeschaltete Fläche und welche Least-Privilege-Entscheidung am Datenbank-Konto muss auditfähig belegt werden? |
| AE | mittel | Welche Debug-/Testfunktion muss die Datenzugriffsschicht für den Produktivbetrieb deaktivieren? |
| DPA | niedrig bis mittel | Welche Datenexposition der Kunden-/Bestelldaten wird durch Härtung reduziert und wie wird das belegt? |
| DV | mittel | Welche Ports, Protokolle und Netzpfade zum Datenbank-Dienst bleiben nach der Härtung offen und warum? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Betriebssicherheit, Angriffsflächen-Reduktion und Least Privilege mit auditfähiger Härtungsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects operational security, attack-surface reduction, and least privilege with audit-ready hardening documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Angriffsfläche reduzieren, Least Privilege, Fail-Safe Defaults, Defense in Depth, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Zugangssteuerung, Betriebshärtungs- und Bedrohungsmodellbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Härtung und Angriffsflächen-Reduktion des Datenbank-Dienstes und der Bestell-/Handelsplattform Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: Bestandsaufnahme der Angriffsfläche (Endpunkte, Datenbank-Ports, Netzwerkbindung, Beispieldatenbanken, Standardkonten, Debug-Funktionen, Dateirechte), begründetes Abschalten ungenutzter Flächen, Least-Privilege-Datenbank-Rollen, mindestens zwei unabhängige Schutzschichten (Defense in Depth) für kritische Assets wie die Kunden- und Bestelldaten und je Maßnahme einen Nachweis. Nutze die in v2 gebaute Plattform mit Northwind-Datenbasis inkl. `ALFKI` als Beispiel für einen zu härtenden Datenbank-Betrieb.

**EN:** Prepare a focused specification for hardening and attack-surface reduction of the database service and the Secure OrderDesk ordering/trading platform for the System Integration specialization. Consider: an inventory of the attack surface (endpoints, database ports, network binding, sample databases, default accounts, debug features, file permissions), justified disabling of unused surfaces, least-privilege database roles, at least two independent protection layers (defense in depth) for critical assets such as customer and order data, and an evidence entry per measure. Use the platform built in v2 with the Northwind data base including `ALFKI` as an example of a database operation to be hardened.

## Anforderungen / Requirements

- **R-01:** Die Angriffsfläche ist als Bestandsaufnahme aufgelistet und bewertet.
- **R-02:** Ungenutzte Endpunkte, Datenbank-Funktionen, Beispieldatenbanken, Standardkonten und Debug-Funktionen sind begründet abgeschaltet.
- **R-03:** Kritische Assets (Kunden- und Bestelldaten) sind durch mindestens zwei unabhängige Schutzschichten gedeckt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Die Härtungslogik bleibt fachlich vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-/`ALFKI`-Daten bleiben fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Offene Flächen, Datenbank-Rechte, Debug-Pfade und Fehlerausgaben als Vertrauensgrenzen prüfen.
- Fehlermeldungen dürfen keine internen Zustände, SQL-Texte, Tabellennamen, Stack-Traces oder Verbindungszeichenketten preisgeben.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Bestandsaufnahme und Härtungsentscheidungen bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Härtungs- und Datenbank-Werkzeuge dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung offener Flächen, Datenbank-Rechte und Fehlerausgaben.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Härtungs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Angriffsflächen-Bestandsaufnahme, Abschalt-Matrix mit Begründung, Defense-in-Depth-Nachweis für Kunden-/Bestelldaten, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Die Angriffsfläche ist aufgenommen und ungenutzte Flächen sind begründet reduziert.
- [ ] Für kritische Assets sind mindestens zwei Schutzschichten belegt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Härtung und Angriffsflächen-Reduktion des Datenbank-Betriebs der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
