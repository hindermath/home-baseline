---
lang: de
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure CaseTracker

## Einführung in sichere Entwicklung mit Spec Kit, MSL und Sandbox

EuFPA – Europäische Firma Programmiert Alles

Fachinformatiker*innen in Ausbildung · DE-first · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation ist die Einführung zur Secure-CaseTracker-Lernreihe.
Sie ersetzt keinen Spec-Kit-Lauf. Sie erklärt den Rahmen, die Rollen,
die Reihenfolge und die erwarteten Nachweise.
:::


---

# Ziel der Lernreihe

- Sichere Softwareentwicklung Schritt für Schritt verstehen
- Anforderungen zuerst klären, dann planen, dann umsetzen
- Datenschutz, Informationssicherheit und Tests sichtbar machen
- Spec Kit als Lernstruktur nutzen
- Entscheidungen so dokumentieren, dass andere sie prüfen können

::: notes
Die Reihe soll Lernende nicht direkt in Code schicken.
Der zentrale Lernpunkt ist: Gute Entwicklung beginnt mit einem klaren Auftrag,
begründeten Entscheidungen und prüfbaren Nachweisen.
:::


---

# Ausgangslage

- Die Übungsfirma **EuFPA** benötigt einen Secure CaseTracker
- Das System verwaltet Kundenanfragen, betroffene Assets und Bearbeitungsnotizen
- Zusätzlich sollen einfache Prozesskennzahlen entstehen
- Das Beispiel bleibt klein, aber die Arbeitsweise ist professionell

::: notes
EuFPA ist fiktiv. Der fachliche Rahmen ist bewusst einfach,
damit Sicherheit, Datenschutz, Dokumentation und Tests im Vordergrund stehen.
:::


---

# Was ist ein CaseTracker?

- Ein Fall beschreibt eine Anfrage oder ein Problem
- Jeder Fall hat Status, Notizen und betroffene Daten
- Rollen entscheiden, wer was sehen oder ändern darf
- Audit-Logs zeigen später, was passiert ist
- Kennzahlen helfen, den Prozess zu verstehen

::: notes
Der CaseTracker ist kein Ticket-System für den echten Betrieb.
Er ist ein Lernobjekt, an dem typische Entscheidungen sichtbar werden.
:::


---

# Gemeinsamer Kernvertrag

- Fälle anlegen, ändern und schließen
- Kundendaten datensparsam speichern
- Eingaben validieren und verständliche Fehlermeldungen liefern
- Rollen `learner`, `developer` und `reviewer` unterscheiden
- Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen
- Daten sicher importieren und exportieren
- Tests und Sicherheitsnachweise erzeugen

::: notes
Alle Sprachpfade nutzen denselben fachlichen Kernvertrag.
Die technische Umsetzung darf sich unterscheiden, aber das Verhalten muss vergleichbar bleiben.
:::


---

# Warum Spec Kit?

- Spec Kit strukturiert Arbeit in Spezifikation, Planung, Aufgaben und Review
- Der erste Schritt ist nicht Code, sondern ein prüfbarer Auftrag
- Jede Aufgabe erzeugt nachvollziehbare Artefakte
- Governance-Presets halten Security, Architektur, A11Y und Agentenregeln präsent
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert

::: notes
Spec Kit ist hier nicht nur Werkzeug. Es ist ein didaktisches Gerüst,
das verhindert, dass wichtige Prüfungen stillschweigend übersprungen werden.
:::


---

# Drei Ebenen

| Ebene | Zweck |
|---|---|
| Level 0 | Zentrale Lernmaterialien, Richtlinie, Checklisten und Presets |
| Level 1 | Koordination der Lernreihe und Vergleich der Sprachpfade |
| Level 2 | Praktische Arbeit je Sprache mit eigenen Spec-Kit-Artefakten |

::: notes
Level 0 bleibt die Quelle. Level 1 koordiniert. Level 2 ist der Ort,
an dem später die eigentlichen Spec-Kit-Läufe und Implementierungen stattfinden.
:::


---

# Repo-Struktur

| Rolle | Lokaler Ordner | GitHub-Slug |
|---|---|---|
| Koordination | `SecureCaseTrackerProjects` | `secure-casetracker-baseline` |
| Referenz | `SecureCaseTracker-CSharp` | `securecasetracker-csharp` |
| Vergleich | `SecureCaseTracker-Go` | `securecasetracker-go` |
| Vergleich | `SecureCaseTracker-Java` | `securecasetracker-java` |
| Vergleich | `SecureCaseTracker-Python` | `securecasetracker-python` |
| Vergleich | `SecureCaseTracker-Rust` | `securecasetracker-rust` |
| Vergleich | `SecureCaseTracker-Swift` | `securecasetracker-swift` |

::: notes
Lokale Ordner nutzen CamelCase.
Die GitHub-Slugs werden durch die Bootstrap-Skripte lowercase erzeugt.
:::


---

# Sechs MSL-Pfade

- C# als erster Referenzpfad
- Go, Java, Python, Rust und Swift als Vergleichspfade
- Alle sechs Sprachen gelten in dieser Reihe als Memory-Safe Languages
- MSL reduziert bestimmte Speicherfehler
- MSL ersetzt keine Prüfung von Eingaben, I/O, Auth, Crypto, Logging oder Dependencies

::: notes
Ein wichtiger Lernpunkt ist: Eine speichersichere Sprache ist hilfreich,
aber keine vollständige Sicherheitsgarantie.
:::


---

# Fachrichtungsbezug

| Fachrichtung | Schwerpunkt |
|---|---|
| Anwendungsentwicklung | Modell, Validierung, Berechtigungen, Persistenz, Tests |
| Systemintegration | Sandbox, Toolchain, Logging, Secrets, Supply Chain |
| Daten- und Prozessanalyse | Datenschutz, Datenqualität, Kennzahlen, Aussagegrenzen |

::: notes
Die Lernreihe ist gemeinsam nutzbar.
Je nach Klasse können einzelne Aufgaben stärker gewichtet werden.
:::


---

# Sichere Entwicklung als Leitanker

- Richtlinie Sichere Entwicklung
- Leitlinie Sichere Programmierung
- Leitlinie Sichere Entwicklungs-Sandbox
- 12 Checklisten und Sammelband
- sechs installierte Spec-Kit-Governance-Presets
- Auditfähige Dokumentation mit Status, Evidenz und Begründung

::: notes
Die Lernenden sollen sehen, dass Sicherheit nicht nur ein einzelner Test ist.
Sicherheit entsteht aus Anforderungen, Architektur, Code, Tests, Betrieb und Nachweisen.
:::


---

# Die sechs Governance-Presets

| Preset | Fokus |
|---|---|
| security-governance | sichere Entwicklung, Standards, Supply Chain |
| architecture-governance | Architektur, Cloud, C3A/C5 |
| isaqb-architecture-governance | Architekturqualität und iSAQB-Bezug |
| a11y-governance | Barrierefreiheit und didaktische Kommentare |
| cross-platform-governance | plattformübergreifende Nutzbarkeit |
| agent-parity-governance | Agenten-Parität und nachvollziehbare Arbeitsweise |

::: notes
Die Presets liefern keine fertige Lösung.
Sie werden aus der zentralen Matrix installiert und sorgen dafür, dass wichtige Qualitätsfragen in Spec-Kit-Artefakten sichtbar bleiben.
:::


---

# Reihenfolge der Aufgaben

| Nr. | Aufgabe | Schwerpunkt |
|---:|---|---|
| 01 | Kundenauftrag und Scope | Auftrag klären |
| 02 | Domänenmodell und Zustände | Fachmodell |
| 03 | Eingabevalidierung und Trust Boundaries | Sicherheit an Grenzen |
| 04 | Datenschutz und Audit-Logging | Daten und Nachvollziehbarkeit |
| 05 | Rollen und Berechtigungen | Least Privilege |
| 06 | Persistenz, Import und Export | Daten sicher speichern |

::: notes
Diese Folie zeigt die erste Hälfte der Lernreihe.
Sie beginnt bewusst mit Auftrag und Modell, nicht mit Implementierung.
:::


---

# Reihenfolge der Aufgaben

| Nr. | Aufgabe | Schwerpunkt |
|---:|---|---|
| 07 | Testbarkeit und Qualität | Nachweise statt Behauptungen |
| 08 | Supply Chain und MSL-Bewertung | Abhängigkeiten und Sprachen |
| 09 | Sandbox und agentische Entwicklung | sichere Arbeitsumgebung |
| 10 | Prozessanalyse und Kennzahlen | Datenqualität |
| 11 | Spec-Kit-Review und Abschluss | Review und Präsentation |

::: notes
Die zweite Hälfte macht deutlich: Sichere Entwicklung endet nicht beim Code.
Toolchain, Sandbox, Kennzahlen und Abschlussreview gehören dazu.
:::


---

# Manuelle Spec-Kit-Läufe

- Spec-Kit-Läufe werden später bewusst manuell gestartet
- Pro Level-2-Repo wird ein konkretes Aufgaben-Lastenheft gewählt
- Das Master-Lastenheft ist nur Gesamtlandkarte
- Ein Lauf erzeugt Spezifikation, Plan, Aufgaben und Prüfartefakte
- Keine automatische Implementierung ohne bewusste Entscheidung

::: notes
Diese Grenze ist wichtig: Vorbereitung ist noch keine Umsetzung.
Lernende sollen den Start eines Spec-Kit-Laufs bewusst auslösen und verstehen.
:::


---

# Beispiel für den ersten Start

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md
als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für
Kundenauftrag, Scope, Rollen, Akzeptanzkriterien und erste Datenschutz-/
Sicherheitsannahmen der EuFPA-Lernreihe Secure CaseTracker.
Erzeuge keine Implementierung.
```

::: notes
Der tatsächliche Prompt steht am Ende jedes Lastenhefts.
Er wird pro Aufgabe und pro Sprachrepo bewusst genutzt.
:::


---

# Erwartete Nachweise

| Nachweis | Beispiel |
|---|---|
| Fachlich | Scope-Liste, Rollenmatrix, Zustandsmodell |
| Sicherheit | Trust Boundaries, negative Tests, Dependency-Audit |
| Datenschutz | Datenarten, Zweck, Minimierung, Log-Regeln |
| Spec Kit | `spec.md`, `plan.md`, `tasks.md`, Checklisten |
| Sandbox | Mounts, Netzwerkannahmen, Secret-Regeln |

::: notes
Nachweise müssen nicht perfekt sein.
Sie müssen ehrlich, prüfbar und verständlich sein.
:::


---

# `N/A`, `Open` und Evidenz

- `Done`: Prüfpunkt wurde bearbeitet und belegt
- `N/A`: Prüfpunkt ist nicht anwendbar und begründet
- `Open`: Prüfpunkt ist erkannt, aber noch offen
- Evidenz verweist auf Dateien, Tests, Entscheidungen oder Review-Ergebnisse
- Keine stillschweigenden Auslassungen

::: notes
Ein sauber begründetes N/A ist besser als eine Lücke.
Ein sichtbares Open ist besser als ein verstecktes Risiko.
:::


---

# Sandbox und KI-Agenten

- Die Sandbox begrenzt Umgebung, Tools und Schreibbereiche
- Agenten erhalten klare Repo-Anweisungen
- Secrets gehören nicht in Prompts, Logs oder Git
- Netzwerk- und Mount-Regeln werden dokumentiert
- Ergebnisse werden durch Menschen geprüft

::: notes
KI-Agenten sind Hilfsmittel, keine Freigabeinstanz.
Die Lernenden sollen Grenzen und Kontrollpunkte verstehen.
:::


---

# Barrierefreiheit und Sprache

- DE-first, EN-second
- CEFR B2 als Verständlichkeitsziel
- WCAG 2.2 AA als Orientierung
- Textorientierte Artefakte bleiben nutzbar
- Abkürzungen und Fachbegriffe werden erklärt
- Folien und Markdown sollen gut vorgelesen werden können

::: notes
Barrierefreiheit betrifft nicht nur Web-UIs.
Auch Markdown, Konsolenausgaben, Folien und Tabellen müssen verständlich bleiben.
:::


---

# Typische Fehler

- Zu früh implementieren
- MSL als vollständige Sicherheitsgarantie missverstehen
- Datenschutz nur als juristischen Zusatz behandeln
- Tests nur für Erfolgspfade planen
- KI-Agenten ohne klare Grenzen nutzen
- `N/A` ohne Begründung setzen

::: notes
Diese Fehler sind didaktisch nützlich.
Sie können als Reviewfragen am Ende jeder Einheit genutzt werden.
:::


---

# Abschluss der Lernreihe

- Ergebnisse je Sprache vergleichen
- Sicherheitsentscheidungen erklären
- Nachweise und offene Risiken zeigen
- Unterschiede der Toolchains sichtbar machen
- Kundengerechte Kurzpräsentation vorbereiten
- Folgeaufgaben transparent dokumentieren

::: notes
Der Abschluss ist nicht nur technisches Abhaken.
Lernende sollen ihr Ergebnis nachvollziehbar und kundenorientiert erklären können.
:::


---

# Pandoc-Nutzung

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Lernreihe.md \
  -o Secure-CaseTracker-Lernreihe.pptx
```

- Die Markdown-Datei bleibt die Quelle
- Die `.pptx`-Datei wird bei Bedarf erzeugt
- Erzeugte Präsentationen werden nicht automatisch versioniert

::: notes
Pandoc ist für die spätere Umwandlung gedacht.
Die gepflegte Quelle bleibt Markdown, weil sie diffbar und barriereärmer ist.
:::


---

# Nächster Schritt

- In ein Level-2-Repo wechseln
- Master-Lastenheft als Gesamtlandkarte lesen
- Mit Aufgabe 01 beginnen
- Spec-Kit-Artefakte prüfen
- Sicherheits- und Datenschutzentscheidungen belegen
- Ergebnisse erst nach Review weiterführen

::: notes
Für den ersten Durchlauf ist C# als Referenzpfad vorgesehen.
Die anderen Sprachpfade können danach als Vergleich genutzt werden.
:::


---

# Vielen Dank

## Fragen, Reviewpunkte und nächste Entscheidungen

- Was ist fachlich noch unklar?
- Welche Sicherheitsannahmen müssen wir belegen?
- Welche Punkte sind `N/A`?
- Welche offenen Risiken bleiben sichtbar?

::: notes
Die Abschlussfolie kann als Übergang in Diskussion, Live-Demo oder ersten Spec-Kit-Lauf dienen.
:::
