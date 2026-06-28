# Secure CaseTracker Application Track Lernreihe / Secure CaseTracker Application Track Learning Series

**Stand / Date:** 2026-06-28
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 3. Lehrjahr / IT specialist apprentices from the third training year onward
**Spezialisierung / Specialization:** AE - Anwendungsentwicklung / Application Development
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Der Application Track erweitert den CaseTracker fachlich und technisch. Lernende planen professionelle Features, Architekturentscheidungen, API-Kompatibilität, sichere Feature-Gates, Testpyramide und Security-ADRs.

**EN:** The Application Track extends the CaseTracker functionally and technically. Learners plan professional features, architecture decisions, API compatibility, secure feature gates, a test pyramid, and security ADRs.

## Lernziele / Learning Goals

- komplexe Features sicher spezifizieren
- Architekturentscheidungen begründen
- MSL-spezifische Secure-Coding-Regeln anwenden
- Test- und Review-Nachweise auditfähig planen

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Schwerpunkt |
|---:|---|---|
| 01 | Erweiterungs-Scope und Fachdomäne | Feature-Scope, Nicht-Ziele, fachliche Regeln und Schutzbedarf werden für eine professionelle CaseTracker-Erweiterung getrennt. |
| 02 | Modul- und Komponentenarchitektur | Komponenten, Modulgrenzen, Abhängigkeiten, Trust Boundaries und ADR-Kandidaten werden entworfen. |
| 03 | API-Versionierung und Kompatibilität | API-Änderungen, Versionierung, Kompatibilität, Fehlerverträge und Migrationspfade werden spezifiziert. |
| 04 | Rollen, Rechte und sichere Feature-Gates | Feature-Zugriff, Rollen, Rechte, sichere Defaults und Missbrauchsfälle werden geprüft. |
| 05 | Validierung, Fehlerbehandlung und Response-Modell | Eingaben, Validierung, technische Fehler, fachliche Fehler, Response-Modell und Logging-Grenzen werden getrennt. |
| 06 | Persistenz, Migrationen und Datenintegrität | Persistenzänderungen, Migrationen, Integritätsregeln, Rollback-Annahmen und Testdaten werden geplant. |
| 07 | Testpyramide und Negativtests | Unit-, Integrations-, End-to-End-, Security- und Negativtests werden als prüfbare Testpyramide formuliert. |
| 08 | Secure Coding pro MSL-Pfad | Sprachspezifische Secure-Coding-Regeln für C#, Go, Java, Python, Rust und Swift werden sichtbar gemacht. |
| 09 | Security-ADR und Architektur-Trade-offs | Sicherheitsrelevante Architekturentscheidungen werden als ADR mit Alternativen, Trade-offs und Evidenz dokumentiert. |
| 10 | Abschlussreview mit Restrisiken und Übergabe | Ergebnisse, Restrisiken, offene Punkte, Testnachweise und Übergabeempfehlung werden zusammengeführt. |

## Governance und Nachweise / Governance and Evidence

- Dieser Track nutzt `Secure CaseTracker` und `Secure CaseTracker v2` als fachliche Vorarbeit.
- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die sechs Governance-Presets aus der zentralen Matrix sind Voraussetzung für spätere MSL-Level-2-Repos.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.
- Offene Punkte werden als `Open` mit Folgeaktion, Risiko und Priorität dokumentiert.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.
