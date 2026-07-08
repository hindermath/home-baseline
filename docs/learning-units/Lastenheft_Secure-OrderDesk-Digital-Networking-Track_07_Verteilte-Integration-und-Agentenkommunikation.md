# Lastenheft: Secure OrderDesk Digital Networking Track 07 - Verteilte Integration und Agentenkommunikation

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Verteilte Integration der Bestell-Pipeline, Nachrichtenverträge zwischen Bestellannahme, Katalog und relationaler Ablage, Agenten-Authentifizierung, Reihenfolge, Deduplizierung und Zustellgarantien werden entworfen und getrennt dokumentiert.

**EN:** Learners design and separately document distributed integration of the order pipeline, message contracts between order intake, catalog, and relational store, agent authentication, ordering, deduplication, and delivery guarantees.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | hoch | Welche Kommunikationsannahme, Systemgrenze oder Zustellgarantie prägt die verteilte Bestell-Pipeline? |
| AE | mittel bis hoch | Welche Implementierungsentscheidung folgt aus Nachrichtenvertrag und Deduplizierung? |
| SI | mittel bis hoch | Welche Betriebs-, Datenbank- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel | Welche Datenqualität oder Aussagegrenze entsteht durch verteilte Integration von Bestelldaten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Der Entwurf der verteilten Integration und ihrer Kommunikation ist Entwicklungsarbeit an einem cyber-physischen, vernetzten System; deshalb steht der Entwicklungsbezug im Vordergrund. Spec-Kit begleitet die Spezifikation und Nachweise, ersetzt aber nicht klassische Lern- und Prüfungsanteile.

**EN:** The task supports Digital Networking in year 3. Designing distributed integration and its communication is development work on a cyber-physical networked system; therefore the development relation is central. Spec Kit accompanies specification and evidence but does not replace conventional training and assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): **primär LF 10d („Cyber-physische Systeme entwickeln")**; berührt LF 3 („Clients in Netzwerke einbinden") und LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: die Bestell-Pipeline wird als vernetztes System entwickelt, dessen Dienste als Clients eingebunden und deren Nachrichten bereitgestellt werden. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): **primary LF 10d ("Cyber-physische Systeme entwickeln")**; touched LF 3 ("Clients in Netzwerke einbinden") and LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: the order pipeline is developed as a networked system whose services are integrated as clients and whose messages are provided. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Trust Boundaries, Least Privilege, sichere Kommunikation und Review-Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sicheres Softwaredesign, Richtlinie Secure Development Life Cycle, Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für die verteilte Integration und die Agentenkommunikation der Bestell-Pipeline. Berücksichtige Dienste bzw. Agenten je Aufgabe (Bestellannahme, Katalogabfrage, Persistenz in der relationalen Ablage), Nachrichtenvertrag und Schema, Agenten-Authentifizierung, Korrelations-IDs (z. B. je Bestellvorgang), Reihenfolge, Deduplizierung, Zustellgarantien (mindestens einmal gegenüber höchstens einmal) und Vertrauensgrenzen. Diese Einheit baut auf Verfügbarkeit und Wiederholung (Einheit 06) auf und liefert die Grundlage für Betriebs- und Netznachweise (Einheit 08).

**EN:** Prepare a specification for the distributed integration and agent communication of the order pipeline. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Rolle und Grenze der Dienste bzw. Agenten (Bestellannahme, Katalog, relationale Ablage) sind benannt.
- **R-02:** Nachrichtenvertrag, Schema und Korrelations-ID je Bestellvorgang sind beschrieben.
- **R-03:** Agenten-Authentifizierung und Least-Privilege-Zugriff sind dokumentiert.
- **R-04:** Reihenfolge, Deduplizierung und die gewählte Zustellgarantie sind begründet.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten und keine echten Secrets in Nachrichten verwenden; Kundendaten wie `ALFKI` bleiben fiktiv.
- Nachrichten zwischen Diensten gelten als nicht vertrauenswürdig und werden an der Vertrauensgrenze validiert.
- Jeder Dienst erhält nur die minimal nötigen Rechte; ein kompromittierter Dienst darf keinen Vollzugriff auf die relationale Ablage bedeuten.
- Zustellgarantien dürfen nicht zu unbemerkten Doppelbestellungen oder Datenverlust führen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Nachrichtenvertrag, Schema und Zustelllogik bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Transport-, Messaging- oder Serialisierungsbibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Kommunikations-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Dienst-/Systemgrenzen-Skizze, Nachrichtenschema, Auth-Regeln, Dedup-/Zustell-Notiz, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Kommunikationsentscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Die gewählte Zustellgarantie ist begründet und ihre Grenze benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für verteilte Integration und Agentenkommunikation der EuFPA-Lernreihe Secure OrderDesk Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
