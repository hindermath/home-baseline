# Lastenheft: Secure OrderDesk Operations Track 09 - Sandbox, Isolation und Betriebsnachweise

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Ein Sandbox- und Isolationsprofil für die Handelsplattform Secure OrderDesk wird geplant: begrenzte Rechte, Schreib- und Netzgrenzen, Regeln für den Zugriff auf die fiktive Testdatenbank (Northwind inkl. `ALFKI`), Secret-Regeln und belastbare Betriebsnachweise. Lernende begründen, warum Isolation die Angriffsfläche verkleinert und wie Betrieb belegbar wird. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** A sandbox and isolation profile for the Secure OrderDesk trading platform is planned: limited privileges, write and network boundaries, rules for accessing the fictitious test database (Northwind incl. `ALFKI`), secret rules, and robust operational evidence. Learners justify why isolation reduces the attack surface and how operation becomes evidenced. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie weist du nach, dass die Plattform nur mit den nötigen Rechten, Pfaden und Datenbankverbindungen läuft? |
| AE | mittel | Welche Programm-Annahme bricht, wenn Schreib- oder Netzzugriff eingeschränkt wird? |
| DPA | mittel | Welche Kunden- oder Bestelldaten dürfen die Sandbox verlassen und welche nicht? |
| DV | mittel bis hoch | Welche Netzsegmente und Kommunikationswege zur Datenbank sind für die Plattform erlaubt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Isolation, Least Privilege, Angriffsflächen-Reduktion und auditfähige Betriebsnachweise für den sicheren Betrieb der Handelsplattform.

**EN:** The task supports third-year SI specialization. It connects isolation, least privilege, attack-surface reduction, and audit-ready operational evidence for secure operation of the trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Sandbox und Isolation sind Sicherheitsmaßnahmen des laufenden Betriebs; die kontrollierte Bereitstellung der isolierten Plattform berührt die Dienstbereitstellung. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: sandbox and isolation are security measures of the running operation; the controlled provisioning of the isolated platform touches service provisioning. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Isolation, Least Privilege, Angriffsflächen-Reduktion, Fail-Safe Defaults, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_07, CL_08, CL_09, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere-Entwicklungs-Sandbox, Richtlinie Secure Development Life Cycle, Zugangssteuerung, sichere Konfiguration.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Sandbox-Einordnung und Isolation des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Public-Referenz `absdd-image-sandbox`, Mounts und Schreibgrenzen, erlaubte Netzwerkannahmen (inkl. Datenbankverbindung), Secret-Regeln (z. B. Datenbank-Verbindungszeichenkette), Regeln für die fiktive Testdatenbank (Northwind inkl. `ALFKI`), Least-Privilege-Profil und belastbare Betriebsnachweise. Halte das Container-First-Gate fest: Jeder KI-Agenten-Aufruf erfolgt im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner (verbindlich ab Unit 00, Grundlage `Secure-Trader-Sandbox-Preflight.md`); dokumentiere Abweichungen als begründetes Restrisiko. Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** Prepare a focused specification for the sandbox classification and isolation of the Secure OrderDesk for the SI - System Integration specialization. Consider: public reference `absdd-image-sandbox`, mounts and write boundaries, allowed network assumptions (incl. database connection), secret rules (e.g. database connection string), rules for the fictitious test database (Northwind incl. `ALFKI`), a least-privilege profile, and robust operational evidence. Record the container-first gate: every AI-agent invocation runs in the container/sandbox, never on the workstation (binding from unit 00, basis `Secure-Trader-Sandbox-Preflight.md`); document any deviation as a justified residual risk. Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Das Isolationsprofil benennt Mounts, Schreibgrenzen und erlaubte Netzwerkwege inklusive Datenbankverbindung.
- **R-02:** Least Privilege ist beschrieben: die Plattform läuft mit minimalen Rechten, Pfaden und Datenbank-Berechtigungen.
- **R-03:** Secret-Regeln sind benannt (inkl. Datenbank-Zugangsdaten); keine echten Secrets, nur Platzhalter.
- **R-04:** Betriebsnachweise (z. B. Start-, Health- und Shutdown-Beleg innerhalb der Sandbox) sind benannt.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Kunden- oder Bestelldaten und keine echten Secrets verwenden; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`, Testdaten fiktiv (Northwind-Layout inkl. `ALFKI`).
- Mounts, Netzwerkwege, Datenbankverbindung, Konfiguration und Logs innerhalb der Sandbox als Vertrauensgrenzen prüfen.
- Fail-Safe Defaults: standardmäßig verweigern, explizit erlauben.
- Positive Sicherheitsaussagen nur mit Nachweis; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Isolations- und Nachweisprofil bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Eine MSL-Support-Matrix je Sprache darf ergänzt, muss aber begründet werden.
- MSL-Status ersetzt keine Isolation, keine Rechtebeschränkung und keine Betriebsprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Sandbox- und Isolationseinordnung dieser Aufgabe.
- `plan.md` mit Isolations-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Isolations-, Prüf- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Isolationsprofil, Mount-/Netz-Tabelle, Secret-Regeln, Betriebsnachweisliste, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Isolationsprofil, Least Privilege, Secret-Regeln und Betriebsnachweise sind getrennt sichtbar.
- [ ] Der Bezug zur Public-Referenz `absdd-image-sandbox` ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Sandbox-Einordnung, Isolation, Least-Privilege-Profil, Secret-Regeln, Regeln für die fiktive Testdatenbank und Betriebsnachweise der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
