# Secure InventoryHub Lernreihe / Secure InventoryHub Learning Series

**Stand / Date:** 2026-06-28
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 2. Lehrjahr / IT specialist apprentices from the second training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** EuFPA benötigt einen Secure InventoryHub, um Geräte, Software, Versionen, Verantwortliche, Wartungsstatus und einfache Risikoansichten nachvollziehbar zu verwalten.

**EN:** EuFPA needs a Secure InventoryHub to manage devices, software, versions, owners, maintenance status, and simple risk views in a traceable way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE - Anwendungsentwicklung | Datenmodell, Rollen, Suche, Import/Export, Tests und sichere Schnittstellen. |
| SI - Systemintegration | Inventar, Betrieb, Patchstand, Wartung, Toolchain, SBOM und Betriebsnachweise. |
| DPA - Daten- und Prozessanalyse | Datenqualität, Kennzahlen, Aussagegrenzen, Datenschutz und Risikoansichten. |

## Lernziele / Learning Goals

- Inventardaten fachlich und datenschutzbewusst modellieren.
- Verantwortlichkeiten, Rollen und Statusübergänge sicher planen.
- Import, Export, Audit, Patch- und Risikoansichten mit Nachweisen verbinden.
- Supply-Chain-, SBOM- und Betriebsbezug didaktisch sauber einordnen.

*English summary: learners practice architecture, persistence, interfaces, tests, operation, and audit-ready documentation at second-year depth.*

## Arbeitsmodell / Working Model

**DE:** Diese Reihe wird jetzt nur als kanonisches Level-0-Lernmaterial vorbereitet. Level-1- und Level-2-Repositories werden später separat angelegt. Die späteren Level-2-Pfade nutzen C#, Go, Java, Python, Rust und Swift und führen die Secure-Development-Basis lokal mit.

**EN:** This series is currently prepared only as canonical level-0 learning material. Level-1 and level-2 repositories will be created later in a separate step. Later level-2 paths use C#, Go, Java, Python, Rust, and Swift and carry the secure-development baseline locally.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 01 | Kundenauftrag, Scope und Inventarobjekte | AE, SI, DPA |
| 02 | Asset- und Software-Datenmodell und Status | AE, DPA |
| 03 | Verantwortlichkeiten und Rollen | AE, SI |
| 04 | Suche, Filter und Datenqualität | AE, DPA |
| 05 | Import, Export und Datenbereinigung | AE, DPA |
| 06 | Audit-Logging und Datenschutz | SI, DPA |
| 07 | Patch-, Wartungs- und Risikoansicht | SI, DPA |
| 08 | Supply Chain, SBOM und Dependency-Bezug | SI, AE |
| 09 | Teststrategie, Sandbox und Betriebsnachweise | AE, SI |
| 10 | Review, Kennzahlen und Abschlussbewertung | AE, SI, DPA |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die sechs Governance-Presets aus der zentralen Matrix sind für spätere MSL-Level-2-Repos Voraussetzung.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.
- Offene Punkte werden als `Open` mit Folgeaktion, Risiko und Priorität dokumentiert.
- Jede positive Aussage zur Einhaltung verweist auf konkrete Evidenz.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Das Master-Lastenheft beschreibt die Gesamtlandkarte und wird nicht als Sammellauf gestartet.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.
