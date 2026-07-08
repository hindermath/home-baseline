# Lastenheft: Secure OrderDesk Application Track 07 - Erweiterbarkeit und Konfigurierbarkeit

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

**DE:** Die Bestell-/Handelsplattform für Secure Trader wird gezielt erweiterbar und sicher konfigurierbar gestaltet. Lernende trennen stabile Verträge von austauschbaren Bausteinen (z. B. Persistenz- oder Report-Adapter), validieren Konfiguration als nicht vertrauenswürdige Eingabe und begründen jede Erweiterungsstelle als bewussten Architektur-Trade-off. Datenbank-Verbindungswerte und Secrets bleiben aus dem Quellcode heraus.

**EN:** The ordering/trading platform for Secure Trader is made deliberately extensible and securely configurable. Learners separate stable contracts from replaceable building blocks (e.g. persistence or report adapters), validate configuration as untrusted input, and justify each extension point as a conscious architectural trade-off. Database connection values and secrets stay out of the source code.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (primär) | Welche Erweiterungsstelle bleibt stabil und welcher Baustein ist austauschbar? |
| SI | mittel | Wie werden Datenbank-Konfiguration und Secrets in der Zielumgebung sicher bereitgestellt? |
| DPA | mittel | Welche Konfigurationswerte beeinflussen Datenumfang, Kundenfelder oder Zweckbindung? |
| DV | mittel | Welche Erweiterung verändert Schnittstellen oder Kommunikationswege der Bestell-Pipeline? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die kundenspezifische Anwendungsentwicklung im 3. Lehrjahr. Sie verbindet Erweiterungspunkte, sichere Konfiguration und begründete Entwurfsentscheidungen mit dem Schutzbedarf von Konfiguration, Datenbank-Zugangsdaten und Secrets.

**EN:** The task supports customer-specific application development in the third year. It connects extension points, secure configuration, and justified design decisions with the protection need of configuration, database credentials, and secrets.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks", Application Track): **primär LF 12a („Kundenspezifische Anwendungsentwicklung durchführen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") und LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks", Application Track): **primary LF 12a ("Kundenspezifische Anwendungsentwicklung durchführen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") and LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Konfiguration, Least Privilege, Separation of Concerns, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Konfigurations- und Secret-Handhabung, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Erweiterbarkeit und Konfigurierbarkeit des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung AE - Anwendungsentwicklung. Berücksichtige: klar geschnittene Erweiterungspunkte (Ports/Adapter, z. B. austauschbarer Persistenz- oder Report-Adapter über der Northwind-Bestelldomäne), stabile Verträge, sichere Defaults, Validierung der Konfiguration als nicht vertrauenswürdige Eingabe und die Ablage von Datenbank-Verbindungszeichenketten und Secrets im Secret-Store statt im Quellcode. Jede Erweiterungsstelle wird als bewusster Trade-off zwischen Flexibilität und Angriffsfläche begründet. Der fachliche Datenvertrag (Customer, Product, Order, OrderLine inkl. `ALFKI`) bleibt sprachneutral; alle Daten bleiben fiktiv.

**EN:** Prepare a focused specification for the extensibility and configurability of the Secure OrderDesk for the AE - Application Development specialization. Consider: well-scoped extension points (ports/adapters, e.g. a replaceable persistence or report adapter over the Northwind ordering domain), stable contracts, secure defaults, validation of configuration as untrusted input, and storing database connection strings and secrets in a secret store instead of source code. Each extension point is justified as a conscious trade-off between flexibility and attack surface. The ordering-domain contract (Customer, Product, Order, OrderLine including `ALFKI`) stays language-neutral; all data stays fictitious.

## Anforderungen / Requirements

- **R-01:** Erweiterungspunkte sind als stabile Verträge (Ports/Interfaces) beschrieben und von austauschbaren Bausteinen getrennt.
- **R-02:** Konfiguration wird als nicht vertrauenswürdige Eingabe validiert; ungültige Werte führen zu sicherem Fehlverhalten.
- **R-03:** Sichere Defaults gelten, solange keine gültige abweichende Konfiguration vorliegt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-/`ALFKI`-Quelle ist als fiktiver Testanker benannt.
- **R-05:** Datenbank-Verbindungszeichenketten und Secrets liegen im Secret-Store; im Repository stehen nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Kundendaten bleiben fiktiv (`ALFKI`).
- Konfiguration, Erweiterungs-Adapter, Importe, Logs, Datenbank-Zugangsdaten und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Angriffsfläche reduzieren: ungenutzte Erweiterungspunkte deaktivieren oder entfernen.
- Least Privilege für Datenbank-Zugriffe: nur benötigte Rechte und Kundenfelder werden konfiguriert.
- Positive Sicherheitsaussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Ports-und-Adapter-Modell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Erweiterungsmechanismen (Interfaces, Traits, Protokolle, Plugins) dürfen gewählt, müssen aber begründet werden.
- Der fachliche Datenvertrag (Customer, Product, Order, OrderLine inkl. `ALFKI`) bleibt für alle sechs Sprachpfade gleich.
- MSL-Status ersetzt keine sichere Konfigurations-, Auth-, Logging-, SQL- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Erweiterungs-, Konfigurations-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Erweiterungspunkt-Katalog, Konfigurations-Validierungsmatrix, Default-Tabelle, Secret- und Verbindungszeichenketten-Handhabungsnotiz.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung AE ist klar sichtbar.
- [ ] Stabile Verträge und austauschbare Bausteine sind getrennt sichtbar.
- [ ] Jede Erweiterungsstelle ist als Trade-off begründet.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Erweiterbarkeit und Konfigurierbarkeit der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
