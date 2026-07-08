# Lastenheft: Secure OrderDesk v2 07 - Rollen-, Autorisierung und Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Rollen, erlaubte und verbotene Aktionen, sichere Defaults, Missbrauchsfälle und ein datenschutzbewusstes Audit-Logging ohne Secrets und ohne Kundendaten im Klartext werden zusammen modelliert. Wer den Secure OrderDesk bedient (z. B. Bestellungen anlegen, Katalog pflegen, Umsätze auswerten), darf nur die vorgesehenen Aktionen ausführen, und jede sicherheitsrelevante Aktion ist nachvollziehbar.

**EN:** Roles, allowed and forbidden actions, secure defaults, abuse cases, and a privacy-aware audit log without secrets and without customer data in clear text are modeled together. Whoever operates the Secure OrderDesk (e.g. creating orders, maintaining the catalog, reporting revenue) may perform only the intended actions, and every security-relevant action is traceable.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk v2"): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk v2"): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Rollen, Autorisierung und Audit-Logging des Secure OrderDesk eine fokussierte Spezifikation. Berücksichtige: eine Rechtematrix mit sicheren Defaults (Deny-by-default) für typische Handelsrollen (z. B. Bestellerfassung, Katalogpflege, Auswertung), Missbrauchsfälle (z. B. fremde Kundenbestellungen einsehen), eine Audit-Event-Liste mit erlaubten und verbotenen Logfeldern sowie die klare Regel, dass weder Secrets noch personenbezogene Kundendaten ins Audit-Log gelangen. Nutze `ALFKI` als fiktives Beispiel. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** Prepare a focused specification for roles, authorization, and audit logging of the Secure OrderDesk. Consider a permission matrix with secure defaults (deny-by-default) for typical trading roles (e.g. order entry, catalog maintenance, reporting), abuse cases (e.g. viewing another customer's orders), an audit event list with allowed and forbidden log fields, and the clear rule that neither secrets nor personal customer data reach the audit log. Use `ALFKI` as a fictional example. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang (Rollen, Rechtematrix, Audit-Events) ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert; Deny-by-default ist begründet.
- **R-03:** Test- oder Reviewpfade für erlaubte und verbotene Aktionen sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Kundenbezug bleibt fiktiv (`ALFKI`).
- Rollen, Service-Aufrufe, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Keine Secrets, Tokens, Passwörter oder personenbezogenen Kundendaten in Audit-Logs schreiben.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag (Rechtematrix, Audit-Event-Modell) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Rechtematrix, Deny-by-default-Begründung, Missbrauchsfälle, Audit-Event-Liste mit erlaubten/verbotenen Feldern, Reviewpfad.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Rollen, Autorisierung und Audit-Logging der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
