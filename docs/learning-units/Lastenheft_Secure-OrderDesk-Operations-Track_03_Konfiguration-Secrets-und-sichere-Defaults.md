# Lastenheft: Secure OrderDesk Operations Track 03 - Konfiguration, Secrets und sichere Defaults

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

**DE:** Die Betriebskonfiguration der Bestell-/Handelsplattform wird sicher gestaltet: getrennte Konfigurationsebenen, sichere Standardwerte, Datenbank-Verbindungszeichenketten und Zugangsgeheimnisse im Secret-Store statt im Quellcode und nachvollziehbare Konfigurationsentscheidungen. Lernende trennen Konfiguration, Secrets und Code sauber voneinander.

**EN:** The operational configuration of the ordering/trading platform is designed securely: separated configuration layers, secure default values, database connection strings and access secrets in a secret store instead of source code, and traceable configuration decisions. Learners cleanly separate configuration, secrets, and code.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welche Konfigurations- und Secret-Herkunft je Umgebung (Verbindungszeichenkette, Datenbank-Konto) muss auditfähig dokumentiert werden? |
| AE | mittel | Wie liest die Datenzugriffsschicht Konfiguration ein, ohne Secrets im Repository zu speichern? |
| DPA | mittel | Welche schützenswerte Angabe zu Kunden- oder Zugangsdaten darf nicht in Klartext-Konfiguration landen? |
| DV | mittel | Welche Endpunkt- oder Datenbank-Zugangskonfiguration berührt Netzgrenzen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet sichere Betriebskonfiguration, Zugangssteuerung und sichere Standardwerte mit auditfähiger Betriebsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects secure operational configuration, access control, and secure defaults with audit-ready operational documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Konfiguration, Fail-Safe Defaults, Least Privilege, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Zugangssteuerung, Kryptografie- und Secret-Handling-Bezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Konfiguration, Secrets und sichere Defaults der Bestell-/Handelsplattform Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: getrennte Konfigurationsebenen (Standard, Umgebung, Override), sichere Standardwerte (deny by default), Datenbank-Verbindungszeichenketten und Datenbank-Konten im plattformgeeigneten Secret-Store (z. B. Keychain, Credential Manager, Umgebungsgeheimnisse) statt im Quellcode, und eine dokumentierte Herkunft je Konfigurationswert. Alle Secrets in der Dokumentation nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**EN:** Prepare a focused specification for configuration, secrets, and secure defaults of the Secure OrderDesk ordering/trading platform for the System Integration specialization. Consider: separated configuration layers (default, environment, override), secure default values (deny by default), database connection strings and database accounts in a platform-appropriate secret store (e.g. Keychain, Credential Manager, environment secrets) instead of source code, and a documented origin per configuration value. All secrets in documentation only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Anforderungen / Requirements

- **R-01:** Konfigurationsebenen und ihre Vorrangfolge sind klar beschrieben.
- **R-02:** Sichere Standardwerte gelten nach dem Prinzip „deny by default".
- **R-03:** Verbindungszeichenketten und Zugangsgeheimnisse liegen im Secret-Store, nie in Git-getrackten Dateien oder im Quellcode.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Das Konfigurationsmodell bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten und keine echten Secrets verwenden; nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Konfigurationsquellen, Secret-Zugriff, Datenbank-Zugangsdaten, Defaults und Overrides als Vertrauensgrenzen prüfen.
- Kein Secret und keine Verbindungszeichenkette in Logs, Fehlermeldungen oder Beispielausgaben.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Konfigurations- und Secret-Modell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Konfigurations- und Secret-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Secret-, Default- und Konfigurationsprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Konfigurations-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Konfigurationsebenen-Tabelle, Default-Matrix (deny by default), Secret-/Verbindungszeichenketten-Herkunftsnachweis, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Konfigurationsebenen, sichere Defaults und Secret-/Verbindungsherkunft sind getrennt dokumentiert.
- [ ] Kein echtes Secret und keine echte Verbindungszeichenkette erscheint in Dokumentation, Logs oder Beispielen.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Konfiguration, Secrets und sichere Defaults der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
