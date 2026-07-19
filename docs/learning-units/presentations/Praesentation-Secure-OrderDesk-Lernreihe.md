---
lang: de
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk

## Einführung in sichere Entwicklung mit Spec Kit, MSL und Sandbox

EuFPA – Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

Fachinformatiker*innen in Ausbildung · 1. Lehrjahr · DE-first · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation ist die Einführung zur Secure-OrderDesk-Basis-Lernreihe
für das 1. Lehrjahr. Sie ersetzt keinen Spec-Kit-Lauf. Sie erklärt den Rahmen,
die Rollen, die Reihenfolge und die erwarteten Nachweise. Die Bestell-/Handelsplattform
bleibt im 1. Lehrjahr bewusst einfach.
:::


---

# Ziel der Lernreihe

- Sichere Softwareentwicklung Schritt für Schritt verstehen
- Anforderungen zuerst klären, dann planen, dann umsetzen
- Datenschutz, Informationssicherheit und Tests sichtbar machen
- SQL sicher und parametrisiert nutzen
- Spec Kit als Lernstruktur nutzen
- Verantwortlich mit agentischer KI arbeiten
- Entscheidungen so dokumentieren, dass andere sie prüfen können

::: notes
Die Reihe soll Lernende nicht direkt in Code schicken.
Der zentrale Lernpunkt ist: Gute Entwicklung beginnt mit einem klaren Auftrag,
begründeten Entscheidungen und prüfbaren Nachweisen. Weil die Domäne relational ist,
sind SQL-Sicherheit und Datenschutz von Anfang an präsent.
:::


---

# Ausgangslage

- Die Handelsfirma **Secure Trader** benötigt eine Secure-OrderDesk-Plattform
- Die Software-Schmiede **EuFPA** baut und betreut sie
- Die Plattform verwaltet Kunden, Produkte und Bestellungen
- Sie speichert die Daten über eine austauschbare relationale Ablage
- Sie stellt einfache Auswertungen bereit
- Das Beispiel bleibt klein, aber die Arbeitsweise ist professionell

::: notes
EuFPA und Secure Trader sind fiktiv. Der fachliche Rahmen ist bewusst einfach,
damit Sicherheit, Datenschutz, Dokumentation und Tests im Vordergrund stehen.
Im 1. Lehrjahr geht es um Grundlagen, nicht um ein produktives Handelssystem.
:::


---

# Was ist Secure OrderDesk?

- Eine relationale Bestell-/Handelsplattform als Lernobjekt
- Sie führt Kunden, Produkte, Bestellungen und Bestellpositionen
- Jede Bestellung verweist auf Kunde, Produkte und Zeitraum
- Daten werden über eine austauschbare relationale Ablage gespeichert
- Rollen entscheiden, wer erfassen, lesen oder verwalten darf
- Audit-Logs zeigen später, was mit den Daten geschehen ist

::: notes
Secure OrderDesk ist kein produktives Warenwirtschaftssystem.
Es ist ein Lernobjekt, an dem typische Entscheidungen für relationale Anwendungen
sichtbar werden: Datenmodell, SQL-Zugriff, Ablage und Nachvollziehbarkeit.
:::


---

# Datenbasis: Northwind und ALFKI

- Verbindliche Datenbasis ist die klassische **Northwind-Sample-Datenbank**
- Layout und Daten inklusive Pflicht-Datensatz **`ALFKI`**
- Original-Bestelldaten (~1996–1998), erweitert um fiktive Datensätze bis 2026
- Alle Daten sind fiktiv und werden markenneutral genutzt
- „Microsoft“ wird nur als historischer Quellhinweis erwähnt

::: notes
Die Northwind-Datenbank ist eine bekannte, gut dokumentierte Beispielbasis.
Der Datensatz ALFKI ist Pflicht, damit alle Sprachpfade denselben Bezugspunkt haben.
Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::


---

# Gemeinsamer Kernvertrag

- Kunden, Produkte, Bestellungen und Positionen im Northwind-Layout führen (inkl. `ALFKI`)
- Bestell- und Kundeneingaben validieren; Eingaben gelten als nicht vertrauenswürdig
- Daten über eine austauschbare relationale Ablage speichern
- Datenzugriffe nur parametrisiert halten (keine SQL-Injection)
- Rollen `learner`, `developer` und `reviewer` unterscheiden
- Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen
- Einfache Auswertungen berechnen: Umsatz je Kategorie, Top-Produkte, Bestellungen je Zeitraum
- Tests und Sicherheitsnachweise erzeugen

::: notes
Alle Sprachpfade nutzen denselben fachlichen Kernvertrag.
Die technische Umsetzung darf sich unterscheiden, aber das Verhalten muss
vergleichbar bleiben. Die parametrisierten Datenzugriffe sind ein bewusster Lernpunkt.
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
Es begleitet die SDD-Aufgaben, ersetzt aber nicht Berufsschule oder Betrieb.
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

| Rolle | Lokaler Ordner | Repository-Slug |
|---|---|---|
| Koordination | `SecureOrderDeskProjects` | `secure-orderdesk-baseline` |
| Referenz | `SecureOrderDesk-CSharp` | `secureorderdesk-csharp` |
| Vergleich | `SecureOrderDesk-Go` | `secureorderdesk-go` |
| Vergleich | `SecureOrderDesk-Java` | `secureorderdesk-java` |
| Vergleich | `SecureOrderDesk-Python` | `secureorderdesk-python` |
| Vergleich | `SecureOrderDesk-Rust` | `secureorderdesk-rust` |
| Vergleich | `SecureOrderDesk-Swift` | `secureorderdesk-swift` |

::: notes
Lokale Ordner nutzen CamelCase.
Die Repository-Slugs werden durch die Bootstrap-Skripte lowercase erzeugt.
Der C#-Referenzpfad wird als erste manuelle Referenz durch Lehrende umgesetzt.
:::


---

# Sechs MSL-Pfade

- C# als erster Referenzpfad
- Go, Java, Python, Rust und Swift als Vergleichspfade
- Alle sechs Sprachen gelten in dieser Reihe als Memory-Safe Languages
- MSL reduziert bestimmte Speicherfehler
- MSL ersetzt keine Prüfung von Eingaben, SQL, I/O, Auth, Crypto, Logging oder Dependencies

::: notes
Ein wichtiger Lernpunkt ist: Eine speichersichere Sprache ist hilfreich,
aber keine vollständige Sicherheitsgarantie. Die Bestellplattform zeigt das gut,
weil SQL-Zugriff, Validierung und I/O in jeder Sprache sauber abgesichert werden müssen.
:::


---

# Fachrichtungsbezug

| Fachrichtung | Schwerpunkt |
|---|---|
| Anwendungsentwicklung | Modell, Validierung, Berechtigungen, relationale Persistenz, Tests |
| Systemintegration | Sandbox, Toolchain, Datenbank-Betrieb, Logging, Supply Chain |
| Daten- und Prozessanalyse | Datenschutz, Datenqualität, Auswertungen, Aussagegrenzen |
| Digitale Vernetzung | Systemkontext, Schnittstellen, Bestellflüsse, Verfügbarkeit |

::: notes
Die Lernreihe ist gemeinsam nutzbar.
Je nach Klasse können einzelne Aufgaben stärker gewichtet werden.
Spec Kit begleitet die SDD-Aufgaben, ersetzt aber nicht das Berufsbildlernen.
:::


---

# Sichere Entwicklung als Leitanker

- Richtlinie Sichere Entwicklung
- Leitlinie Sichere Programmierung
- Leitlinie Sichere Entwicklungs-Sandbox
- 12 Checklisten und Sammelband
- acht installierte Spec-Kit-Governance-Presets
- Auditfähige Dokumentation mit Status, Evidenz und Begründung
- Besonderer Fokus: parametrisierte SQL-Zugriffe und Schutz von Kunden-/Bestelldaten

::: notes
Die Lernenden sollen sehen, dass Sicherheit nicht nur ein einzelner Test ist.
Sicherheit entsteht aus Anforderungen, Architektur, Code, Tests, Betrieb und Nachweisen.
Bei einer relationalen Domäne stehen SQL-Sicherheit und Datenschutz besonders im Vordergrund.
:::


---

# Die acht Governance-Presets

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
Sie werden aus der zentralen Matrix installiert und sorgen dafür, dass wichtige
Qualitätsfragen in Spec-Kit-Artefakten sichtbar bleiben.
:::


---

# Reihenfolge der Aufgaben

| Nr. | Aufgabe | Schwerpunkt |
|---:|---|---|
| 00 | Sprachrepo- und Projekt-Scaffold | Startpunkt schaffen |
| 01 | Kundenauftrag, Scope und Handelsdomäne | Auftrag klären |
| 02 | Domänenmodell Kunden, Produkte und Bestellungen | Fachmodell |
| 03 | Eingabevalidierung und Trust Boundaries | Sicherheit an Grenzen |
| 04 | Datenschutz und Audit-Logging | Daten und Nachvollziehbarkeit |
| 05 | Rollen und Berechtigungen | Least Privilege |
| 06 | Persistenz, SQL und sichere Datenzugriffe | parametrisierte Queries |

::: notes
Diese Folie zeigt die erste Hälfte der Lernreihe.
Sie beginnt bewusst mit Scaffold, Auftrag und Modell, nicht mit Implementierung.
Der Scaffold-Schritt sorgt für einen sauberen, reproduzierbaren Start.
:::


---

# Reihenfolge der Aufgaben

| Nr. | Aufgabe | Schwerpunkt |
|---:|---|---|
| 07 | Testbarkeit und Qualität | Nachweise statt Behauptungen |
| 08 | Lieferanten, Supply Chain und MSL-Bewertung | Abhängigkeiten und Sprachen |
| 09 | Sandbox und agentische Entwicklung | sichere Arbeitsumgebung |
| 10 | Auswertungen und Kennzahlen | Datenqualität und Betrieb |
| 11 | Spec-Kit-Review und Abschluss | Review und Präsentation |
| 12 | Jahr-2-Baseline und Track-Ableitung | Ausblick |

::: notes
Die zweite Hälfte macht deutlich: Sichere Entwicklung endet nicht beim Code.
Toolchain, Sandbox, Auswertungen und Abschlussreview gehören dazu.
Einheit 12 bereitet die Weiterführung ins 2. Lehrjahr vor.
:::


---

# Familie der Lernreihe

- **Basis (1. Lehrjahr)**: einfache Bestellplattform, Grundlagen sicher gemacht
- **v2 (2. Lehrjahr)**: erweiterte Baseline, mehr Betrieb, mehr Nachweise
- **Professional Tracks (3. Lehrjahr)**: fachrichtungsspezifische Vertiefung
- Einheit 12 leitet die Jahr-2-Baseline und die Track-Ableitung ein
- Die Basis bleibt bewusst klein, damit Grundlagen sitzen

::: notes
Die Familie zeigt den roten Faden über die Ausbildung hinweg.
Im 1. Lehrjahr wird eine solide, einfache Basis gelegt.
Erst darauf bauen v2 und die Professional Tracks auf.
:::


---

# Verwandte Systeme bei Secure Trader

- **Secure OrderDesk**: die Bestell-/Handelsplattform selbst (diese Reihe)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jede Lernreihe bleibt eigenständig bearbeitbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme.
Das gemeinsame Universums- und Datenmodell steht in Secure-Trader-Systemlandschaft.md.
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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md
als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für
Kundenauftrag, Scope, Handelsdomäne, Rollen, Akzeptanzkriterien und erste
Datenschutz-/Sicherheitsannahmen der EuFPA-Lernreihe Secure OrderDesk.
Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```

::: notes
Der tatsächliche Prompt steht am Ende jedes Lastenhefts.
Er wird pro Aufgabe und pro Sprachrepo bewusst genutzt.
Einheit 00 (Scaffold) läuft dem fachlichen Start voraus.
:::


---

# Erwartete Nachweise

| Nachweis | Beispiel |
|---|---|
| Fachlich | Scope-Liste, Rollenmatrix, Northwind-Datenmodell |
| Sicherheit | Trust Boundaries, parametrisierte Queries, negative Tests |
| Datenschutz | Datenarten, Zweck, Minimierung, Log-Regeln |
| Spec Kit | `spec.md`, `plan.md`, `tasks.md`, Checklisten |
| Sandbox | Mounts, Netzwerkannahmen, Secret-Regeln |

::: notes
Nachweise müssen nicht perfekt sein.
Sie müssen ehrlich, prüfbar und verständlich sein.
Die parametrisierten Datenzugriffe sind ein zentraler Sicherheitsnachweis.
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

- Container-First-Gate: Jeder KI-Agenten-Aufruf im Container, nie auf dem Arbeitsplatz-Rechner
- Gilt ab Unit 00 verbindlich, bevor der erste Agent startet
- Public-Referenz: <https://github.com/hindermath/absdd-image-sandbox>
- Grundlage: `Secure-Trader-Sandbox-Preflight.md`
- Secrets und echte personenbezogene Daten gehören nicht in Prompts, Logs oder Git
- Netzwerk- und Mount-Regeln werden dokumentiert
- Ergebnisse werden durch Menschen geprüft
- Nur agentenlose Arbeit (Lesen, Review, IDEs) darf außerhalb der Sandbox laufen

::: notes
KI-Agenten sind Hilfsmittel, keine Freigabeinstanz.
Das Gate ist ab Unit 00 verbindlich; in ISO-27001-zertifizierten Organisationen ein pruefbarer Kontrollpunkt (A.8.25, A.8.31).
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
- SQL aus Eingaben zusammensetzen statt parametrisieren
- Datenschutz nur als juristischen Zusatz behandeln
- Tests nur für Erfolgspfade planen
- KI-Agenten ohne klare Grenzen nutzen
- `N/A` ohne Begründung setzen

::: notes
Diese Fehler sind didaktisch nützlich.
Sie können als Reviewfragen am Ende jeder Einheit genutzt werden.
Der SQL-Injection-Fehler ist in dieser Reihe besonders lehrreich.
:::


---

# Abschluss der Lernreihe

- Ergebnisse je Sprache vergleichen
- Sicherheitsentscheidungen und SQL-Zugriffe erklären
- Nachweise und offene Risiken zeigen
- Unterschiede der Toolchains sichtbar machen
- Kundengerechte Kurzpräsentation vorbereiten
- Folgeaufgaben und den Weg zur Jahr-2-Baseline transparent dokumentieren

::: notes
Der Abschluss ist nicht nur technisches Abhaken.
Lernende sollen ihr Ergebnis nachvollziehbar und kundenorientiert erklären können.
:::


---

# Pandoc-Nutzung

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-OrderDesk-Lernreihe.md \
  -o Secure-OrderDesk-Lernreihe.pptx
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
- Mit Aufgabe 00 (Scaffold) und dann 01 beginnen
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
- Sind alle Datenzugriffe parametrisiert?
- Welche Punkte sind `N/A`?
- Welche offenen Risiken bleiben sichtbar?

::: notes
Die Abschlussfolie kann als Übergang in Diskussion, Live-Demo oder ersten Spec-Kit-Lauf dienen.
:::
