# Secure OrderDesk Application Track Lernreihe / Application Track Learning Series

**Stand / Date:** 2026-07-07
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Kundenfirma / Client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
**Zielgruppe / Audience:** Fachinformatiker*innen der Fachrichtung Anwendungsentwicklung ab dem 3. Lehrjahr / IT specialists in Application Development from the third training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung / Placement

**DE:** Dieser Track ist die AE-Spezialisierung der [Professional Tracks (Jahr 3)](Secure-OrderDesk-Professional-Tracks-Lernreihe.md) der Familie Secure OrderDesk. Er baut auf [v2 (Jahr 2)](Secure-OrderDesk-v2-Lernreihe.md) auf.

**EN:** This track is the Application Development specialization of the [Professional Tracks (year 3)](Secure-OrderDesk-Professional-Tracks-Lernreihe.md) of the Secure OrderDesk family. It builds on [v2 (year 2)](Secure-OrderDesk-v2-Lernreihe.md).

## Zielbild / Target Picture

**DE:** Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung der Bestell-/Handelsplattform für Secure Trader: Die Plattform erhält gut geschnittene Funktionen auf der Northwind-Bestelldomäne (Kunden, Produkte, Bestellungen, Bestellpositionen), saubere Persistenz-Adapter mit parametrisierten Queries, eine wartbare Oberfläche (Viewer oder CLI) und belastbare Tests. Im Mittelpunkt stehen Erweiterbarkeit, klare Verträge und begründete Entwurfsentscheidungen.

**EN:** The Application Track deepens secure feature and interface development of the ordering/trading platform for Secure Trader: the platform gains well-scoped functions on the Northwind ordering domain (customers, products, orders, order lines), clean persistence adapters with parameterized queries, a maintainable interface (viewer or CLI), and robust tests. The focus is extensibility, clear contracts, and justified design decisions.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit |
|---:|---|
| 01 | Track-Baseline und Feature-Zielbild |
| 02 | API-Erweiterung und Ressourcenmodell |
| 03 | Persistenz-Adapter und Repository-Muster |
| 04 | Query-, Filter- und Paginierungslogik |
| 05 | Viewer- oder Client-Oberfläche (barrierefrei) |
| 06 | Fehlerbehandlung und Validierung vertieft |
| 07 | Erweiterbarkeit und Konfigurierbarkeit |
| 08 | Sichere Serialisierung und Schnittstellenverträge |
| 09 | Teststrategie: Unit, Integration und Contract-Tests |
| 10 | Feature-Review, Trade-offs und Abschluss |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente als lokale Nachweisbasis.
- Sieben Governance-Presets aus der zentralen Matrix; Nachweis über `specify preset list`.
- Nicht anwendbare Punkte als `N/A` mit Begründung; offene Punkte als `Open` mit Folgeaktion.
- Positive Aussagen zu Sicherheit, Qualität oder Compliance nur mit konkreter Evidenz.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
