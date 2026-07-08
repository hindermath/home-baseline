# Lastenheft: Secure OrderDesk Operations Track 10 - Betriebs-Review, Runbook und Abschluss

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

**DE:** Der Betrieb der Handelsplattform Secure OrderDesk wird abschließend bewertet: ein Betriebs-Review, ein kundenverständliches Runbook, offene Punkte, Restrisiken, Akzeptanz und eine Übergabeempfehlung an Secure Trader. Lernende fassen die Betriebssicht als prüfbaren Abschluss zusammen. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** The operation of the Secure OrderDesk trading platform is finally assessed: an operations review, a customer-understandable runbook, open items, residual risks, acceptance, and a handover recommendation to Secure Trader. Learners summarize the operational view as a testable closure. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Welche Betriebsentscheidung und welches Restrisiko müssen bei der Übergabe an Secure Trader sichtbar sein? |
| AE | mittel | Welche technische Schuld sollte im Abschluss dokumentiert werden? |
| DPA | mittel | Welche Kennzahlen belegen den geordneten Betrieb der Handelsplattform? |
| DV | mittel bis hoch | Welche Schnittstellen oder Abhängigkeiten (inkl. Datenbank) muss die Übergabe benennen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe schließt die SI-Spezialisierung im 3. Lehrjahr ab. Sie verbindet Systemintegration, Betriebsübergabe, kundenverständliche Dokumentation und auditfähige Abschlussnachweise für eine relationale Handelsplattform.

**EN:** The task closes third-year SI specialization. It connects system integration, operational handover, customer-understandable documentation, and audit-ready closure evidence for a relational trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12b („Kundenspezifische Systemintegration durchführen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Begründung: Ein Betriebs-Review mit Runbook und Übergabe an Secure Trader ist eine kundenspezifische Systemintegrationsaufgabe; Restrisiken und Betriebsnachweise verweisen auf den Schutzbedarf. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12b ("Kundenspezifische Systemintegration durchführen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Rationale: an operations review with runbook and handover to Secure Trader is a customer-specific system-integration task; residual risks and operational evidence point to the protection need. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** auditfähige Evidenz, ehrliche Restrisiken, kundenverständliche Übergabe, N/A-Begründung.
- **Checklisten:** CL_01, CL_07, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Testmanagement, Zugangssteuerung, Betriebs- und Übergabedokumentation.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Betriebsabschluss des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: ein Betriebs-Review über die Einheiten 06 bis 09 (CI/CD, Backup/Recovery, Supply Chain, Sandbox), ein kundenverständliches Runbook mit den wichtigsten Betriebsabläufen (Start, Stopp, Restore der Handelsdatenbank, Alarm-Reaktion), eine Liste offener Punkte und Restrisiken, Akzeptanzkriterien und eine Übergabeempfehlung an Secure Trader. Nutze `ALFKI` als fiktives Beispiel in Beleg- und Testverweisen. Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** Prepare a focused specification for the operational closure of the Secure OrderDesk for the SI - System Integration specialization. Consider: an operations review across units 06 to 09 (CI/CD, backup/recovery, supply chain, sandbox), a customer-understandable runbook with the most important operational procedures (start, stop, restore of the trading database, alarm response), a list of open items and residual risks, acceptance criteria, and a handover recommendation to Secure Trader. Use `ALFKI` as a fictional example in evidence and test references. Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Das Betriebs-Review fasst die zentralen Betriebsentscheidungen der vorangehenden Einheiten zusammen.
- **R-02:** Ein Runbook benennt die wichtigsten Betriebsabläufe (Start, Stopp, Restore, Alarm-Reaktion) verständlich.
- **R-03:** Offene Punkte und Restrisiken sind mit Folgeaktion dokumentiert.
- **R-04:** Akzeptanzkriterien und eine Übergabeempfehlung an Secure Trader sind formuliert.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Kunden- oder Bestelldaten und keine echten Secrets; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`, Testdaten fiktiv (Northwind-Layout inkl. `ALFKI`).
- Betriebsnachweise, Runbook und Übergabe als mögliche Vertrauensgrenzen prüfen; keine internen Zustände unnötig offenlegen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Review-, Runbook- und Übergabevertrag bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Betriebswerkzeuge dürfen genannt, müssen aber begründet werden.
- MSL-Status ersetzt keine Betriebs-, Sicherheits- oder Übergabeprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für das Betriebs-Review und die Übergabe dieser Aufgabe.
- `plan.md` mit Review-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Runbook- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Betriebs-Review-Zusammenfassung, Runbook, Restrisiko-Liste, Akzeptanzkriterien, Übergabenotiz.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Betriebs-Review, Runbook, Restrisiken und Übergabeempfehlung sind getrennt sichtbar.
- [ ] Der Bezug zu den Einheiten 06 bis 09 ist erkennbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein Betriebs-Review, ein kundenverständliches Runbook, Restrisiken und eine Übergabeempfehlung der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
