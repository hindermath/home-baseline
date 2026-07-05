# Lastenheft: Secure CaseTracker Digital Networking Track 04 - Identitäten, Zugriff und Netzwerkrechte

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Identitäten, technische Konten, Rollen, Servicezugriffe und Least-Privilege-Regeln werden spezifiziert.

**EN:** Learners specify identities, technical accounts, roles, service access, and least-privilege rules.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit ist eine begleitende Struktur für Anforderungen und Nachweise, kein Ersatz für Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports Digital Networking in year 3. Spec Kit is a companion structure for requirements and evidence, not a replacement for vocational assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Least Privilege, Zugangssteuerung, sichere Konfiguration, Nachvollziehbarkeit und Datenschutz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Zugangssteuerung, Leitlinie Sicheres Softwaredesign und Richtlinie Secure Development Life Cycle.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Identitäten, Zugriff und Netzwerkrechte. Berücksichtige Benutzerrollen, technische Konten, Service-zu-Service-Zugriffe, Netzpfade, Rechtevergabe, Revocation, Audits und offene Risiken.

**EN:** Prepare a specification for identities, access, and network permissions. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Rollen, technische Konten und Servicezugriffe sind getrennt beschrieben.
- **R-02:** Jede Berechtigung hat Zweck, Gültigkeit und Begrenzung.
- **R-03:** Entzug, Rotation oder Deaktivierung sind als Prozess berücksichtigt.
- **R-04:** `Applicable`, `N/A` und `Open` Punkte werden begründet.
- **R-05:** Sprachpfade bleiben vergleichbar, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Zugangsdaten, Tokens oder personenbezogenen Daten verwenden.
- Keine Secrets in Markdown, Code, Logs oder Testdaten aufnehmen.
- Zugriff standardmäßig verweigern und explizit begründen.
- Audit-Informationen ohne unnötige personenbezogene Daten planen.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Identitäts-, Zugriffs- und Reviewpfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Rollenmatrix, Servicezugriffsliste, Least-Privilege-Begründungen, Revocation-Notiz.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Zugriffsmodell und Netzrechte sind nachvollziehbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Keine echten Secrets oder produktiven Zugänge werden genutzt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_04_Identitaeten-Zugriff-und-Netzwerkrechte.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Identitäten, Zugriff und Netzwerkrechte der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
