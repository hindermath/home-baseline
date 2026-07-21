# Lastenheft: Spec Kit Intake Authoring Governance

**Status:** Verbindlicher Bootstrap-Intake / Binding bootstrap intake
**Version:** 1.0
**Datum / Date:** 2026-07-21

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt das optionale Spec-Kit-Preset
`intake-authoring-governance` v0.1.0. Es wandelt einen eingegebenen Prompt,
eingefuegten Planungstext oder geordnete UTF-8-Textdateien in genau einen
Spec-Kit-tauglichen Markdown-Intake um und speichert dazu ein kleines,
maschinenpruefbares Receipt.

*This intake defines the optional `intake-authoring-governance` v0.1.0 preset.
It turns an entered prompt, pasted planning text, or ordered UTF-8 text files
into exactly one Spec Kit-ready Markdown intake plus a small machine-verifiable
receipt.*

Das Preset ist eine eigenstaendige Vorstufe zu
`intake-review-governance`. Es startet weder Review noch Specify noch einen
autonomen oder parallelen Lauf.

*The preset is a standalone authoring stage before `intake-review-governance`.
It starts no review, Specify command, autonomous run, or parallel campaign.*

## 2. Zielgruppe / Audience

- Anwendungsentwicklerinnen und Anwendungsentwickler, die eine Planung in einen
  belastbaren Spec-Kit-Intake ueberfuehren wollen.
- Lernende, Ausbildende und Maintainer, die strukturierte, verstaendliche und
  barrierearme Aufgabenstellungen benoetigen.
- Autonome und parallele Spec-Kit-Orchestrierung, die nur gespeicherte und
  nachvollziehbare Intakes konsumieren darf.

*The audience includes application developers, learners, instructors,
maintainers, and autonomous consumers that require stored and traceable input.*

## 3. Ausgangslage und Zielzustand / Current And Target State

Planungen liegen heute als Chattext, Notiz, Markdown oder mehrere lose
Textquellen vor. Der Mensch muss Ziel, Scope, Nicht-Ziele, Anforderungen,
Nachweise und Einstiegsprompts manuell konsolidieren. Unterschiedliche
Agentenoberflaechen und unklare Delivery Authority erhoehen das Fehlerrisiko.

*Planning currently exists as chat text, notes, Markdown, or several loose text
sources. Manual consolidation of scope, evidence, and entry prompts is
error-prone, especially across agent surfaces and delivery authorities.*

Der Zielzustand ist ein portabler Intake-Kern mit optionalem Projektprofil,
CEFR-B2-Sprache, anwendbarer WCAG-2.2-AA-Pruefung, reproduzierbarer Provenienz
und sicheren Prompt-Grenzen.

## 4. Scope

### 4.1 Eingaben

- direkt eingegebener Text;
- eingefuegter Planungstext;
- eine oder mehrere ausdruecklich benannte UTF-8-Textdateien;
- gemischte Eingaben in ausdruecklicher Reihenfolge;
- optionaler Zielpfad, Projektprofil und ausdrueckliche Update-Autoritaet.

Dateiendungen sind fuer lesbare UTF-8-Texte nicht normativ. Plain Text,
Markdown, AsciiDoc, reStructuredText, JSON und YAML sind typische Beispiele.
Bekannte Binaer- und Dokumentcontainer wie PDF und DOCX sind nicht zulaessig.

### 4.2 Ausgaben

- genau ein Markdown-Intake;
- genau ein JSON-Receipt unter
  `specs/intake-authoring-receipts/<slug>.json`;
- ein kopierbarer Specify-Prompt;
- ein kopierbarer Autonomous-Prompt;
- `$speckit-intake-review` als einzige empfohlene Folgeaktion.

Ohne Projektprofil gilt `intakes/<slug>.md`. Ein vorhandenes Ziel wird nur mit
ausdruecklicher Update-Autoritaet geaendert.

## 5. Nicht-Ziele / Non-Goals

- keine PDF-, DOCX- oder OCR-Extraktion;
- kein eigener deterministischer Textgenerator;
- kein automatischer Review;
- kein automatischer Specify-, Autonomous- oder Parallel-Autonomous-Start;
- keine implizite Commit-, Push-, PR-, Merge-, Bypass- oder Provider-Autoritaet;
- keine Aenderung der Standard-Acht-Preset-Matrix;
- kein stilles Ueberschreiben oder Abschneiden grosser Quellen.

## 6. Funktionale Anforderungen / Functional Requirements

- **FR-001:** `$speckit-intake-create` verarbeitet genau einen Ziel-Intake je
  Aufruf.
- **FR-002:** Alle Quellen werden in Benutzerreihenfolge erfasst. Keine Quelle
  ueberschreibt eine andere ohne dokumentierte Entscheidung.
- **FR-003:** Jede Datei wird strikt als UTF-8 gelesen. Ein UTF-8-BOM wird fuer
  den Hash einmal entfernt; CRLF und CR werden zu LF normalisiert.
- **FR-004:** Binaerinhalt, nicht gueltiges UTF-8 und bekannte Binaerformate
  werden vor der Erzeugung abgelehnt.
- **FR-005:** Materielle Widersprueche, Scope-, Sicherheits- und
  Berechtigungsfragen werden nicht geraten.
- **FR-006:** Pro Durchgang werden hoechstens fuenf materielle Fragen genau
  einzeln gestellt.
- **FR-007:** Bleiben danach Fragen offen, wird ein gesperrter Entwurf mit
  Receipt-Status `NeedsClarification` gespeichert.
- **FR-008:** Ein vollstaendiger Intake erhaelt `ReadyForReview`; nur Preset 9
  darf spaeter `Ready` oder einen anderen Review-Ausgang vergeben.
- **FR-009:** Der portable Kern enthaelt Identitaet, Zielgruppe, Zweck,
  Ausgangslage, Zielzustand, Scope, Nicht-Ziele, atomare Anforderungen,
  Qualitaetsgrenzen, Abhaengigkeiten, Risiken, Artefakte, Evidence,
  Abnahmekriterien, Annahmen und offene Fragen.
- **FR-010:** Projektprofile duerfen den Kern erweitern, aber keine
  Sicherheits-, Provenienz- oder Autoritaetsgrenze abschwaechen.
- **FR-011:** Die Repository-Sprachregel ist verbindlich. Ohne Regel bleibt die
  dominante Quellsprache erhalten.
- **FR-012:** Nutzerseitige Erklaerungen verwenden CEFR B2. Anwendbare
  WCAG-2.2-AA-Anforderungen gelten fuer Struktur und beschriebenes Ergebnis.
- **FR-013:** Das Receipt bindet Ziel, Quellen, Entscheidungen, Profil,
  Sprache, Agentensyntax und Authority an normalisierte Hashes.
- **FR-014:** Repository-interne Quellen werden relativ gespeichert. Bei
  externen Quellen werden keine privaten absoluten Pfade persistiert.
- **FR-015:** Secrets oder unnoetige personenbezogene Daten blockieren die
  Erzeugung; sie werden nicht still kopiert oder automatisch umgedeutet.
- **FR-016:** Ein Update zeichnet Ziel-Vorgaengerhash und abgeloestes Receipt
  auf und benoetigt ausdrueckliche Autoritaet.
- **FR-017:** `$speckit-intake-create-status` prueft Receipt, Zielhash,
  pruefbare Quellen und Prompt-Zustand read-only.
- **FR-018:** Die sichtbare Befehlssyntax entspricht der aktiven
  Agentenoberflaeche. Das Receipt speichert die portablen IDs
  `speckit.specify` und `speckit.autonomous`.
- **FR-019:** Ohne ausdrueckliche hoehere Authority verwendet der erzeugte
  Autonomous-Prompt `LocalImplementation`.
- **FR-020:** Die einzige automatische Abschlussausgabe ist die exakte naechste
  Aktion `$speckit-intake-review`; sie wird nicht ausgefuehrt.

## 7. Receipt-Vertrag / Receipt Contract

Schema `1.0` enthaelt mindestens Receipt-ID, Erzeugungsversion, UTC-Zeit,
Status, Zielpfad und Zielhash, geordnete Quellen, Profil, Sprachregel,
Entscheidungen, offene Entscheidungs-IDs, Fragenzaehler, Agentensyntax,
Delivery Authority, Prompt-Zustand, Vorgaengerbezug und naechste Aktion.

Erlaubte Statuswerte sind `ReadyForReview` und `NeedsClarification`.
Erlaubte Prompt-Zustaende sind `Enabled` und `Blocked`. Ein gesperrter Entwurf
enthaelt keine ausfuehrbare Spec-Kit-Befehlszeile.

## 8. Prompt-Vertrag / Prompt Contract

Der Specify-Prompt nennt den exakten Intake-Pfad, behandelt ihn als
verbindliche Eingabe und untersagt Implementierung und Remote-Schreibaktionen.

Der Autonomous-Prompt nennt denselben Pfad und genau einen Delivery-Modus.
Ohne ausdrueckliche Freigabe gilt `LocalImplementation`. Allgemeine Autonomie
erteilt keine Remote-, Merge-, Bypass-, Secret-, Provider- oder
Administratorberechtigung. Nach Abschluss wird kein weiterer Intake gestartet.

## 9. Sicherheit, Datenschutz und A11Y / Security, Privacy And A11Y

- Kein Receipt speichert Zugangsdaten oder private absolute Quellpfade.
- Quellen ausserhalb des Repositorys muessen einzeln benannt sein.
- Das Preset fuehrt keinen Quellcode und keine Quelldatei als Skript aus.
- Markdown bleibt mit Tastatur, Screenreader, Braille-Zeile und Textbrowser
  nutzbar; Farbe oder Layout sind nie alleiniger Informationstraeger.
- Gesperrte Prompt-Bloecke tragen den sichtbaren Text
  `BLOCKED - DO NOT RUN`.
- Uebergrosse Eingaben werden nicht still gekuerzt, sondern mit einer
  handlungsfaehigen Fehlermeldung abgelehnt.

## 10. Paket und Komposition / Package And Composition

Das optionale Preset benoetigt Spec Kit `>=0.8.3`, verwendet MIT und erhaelt
Prioritaet `64`: nach Agent Parity `60`, vor Intake Review `65`, Autonomous
`70` und Parallel Autonomous `80`. Die Standard-Acht- und das bestehende
Neun-Preset-Profil bleiben verfuegbar.

Die portable Publikation enthaelt Commands, Templates, Runbook, Agent-Guidance,
Receipt-Validatoren fuer Bash und PowerShell, Tests, Manpage und
Feldvalidierungszusammenfassung. Die semantische Intake-Erzeugung bleibt eine
Agentenaufgabe; Skripte pruefen nur den gespeicherten Vertrag.

## 11. Abnahmekriterien / Acceptance Criteria

- **AC-001:** Prompt, eingefuegte Planung, Einzeldatei, mehrere Dateien und
  gemischte Quellen erzeugen jeweils genau einen validierbaren Intake.
- **AC-002:** LF, CRLF und BOM fuehren zum gleichen normalisierten Quellhash.
- **AC-003:** Binaerdateien, ungueltiges UTF-8, Secrets, fehlende Ziele und
  unautorisierte Updates werden in Bash und PowerShell gleich abgelehnt.
- **AC-004:** Nach fuenf offenen Fragen ist der Entwurf gesperrt und enthaelt
  keine ausfuehrbare Prompt-Zeile.
- **AC-005:** Source- oder Ziel-Drift macht den Status ungültig, ohne Dateien
  zu aendern.
- **AC-006:** Ein `ReadyForReview`-Intake enthaelt beide aktiven Prompt-Bloecke,
  den exakten Zielpfad und eine eindeutige Authority.
- **AC-007:** Preset 9 kann den Intake unabhaengig pruefen; Preset 7 und 8
  werden nicht automatisch gestartet.
- **AC-008:** Alle zehn Presets lassen sich gemeinsam installieren, aufloesen,
  deaktivieren, neu installieren und entfernen.
- **AC-009:** Jede unterstuetzte Agentenoberflaeche zeigt beide neuen Commands
  genau einmal.
- **AC-010:** Die optionale Zehnerinstallation ist in allen registrierten
  Level-0-/1-/2-Repositories einschliesslich Lernreihen nachgewiesen, ohne den
  oeffentlichen Acht-Preset-Default zu aendern.

## 12. Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

### 12.1 `$speckit-specify`

```text
$speckit-specify Nutze Lastenheft_Spec-Kit-Intake-Authoring-Governance.md als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer das optionale Preset intake-authoring-governance v0.1.0 mit den Commands speckit.intake-create und speckit.intake-create-status. Uebernimm den UTF-8-Quellvertrag, das Receipt-Schema, die fuenf Fragen pro Durchgang, den gesperrten NeedsClarification-Entwurf, Projektprofile, CEFR B2, WCAG 2.2 AA, LocalImplementation als sichere Default-Authority und die getrennte Uebergabe an intake-review-governance. Aendere weder die Standard-Acht- noch die bestehende Neun-Preset-Matrix. Starte keine Implementierung oder Remote-Aktion.
```

### 12.2 `$speckit-autonomous`

```text
$speckit-autonomous Nutze Lastenheft_Spec-Kit-Intake-Authoring-Governance.md als verbindliche Eingabedatei und liefere intake-authoring-governance v0.1.0 vollstaendig aus.

Delivery authority: MergeAndSync ausschliesslich fuer Home Baseline, das neue eigene Preset-Repository und die registrierte optionale Flotteninstallation. Kein Admin-Bypass ist erteilt.

Erstelle Bootstrap-Evidence, kanonischen Scaffold und Publikationskopie. Implementiere Commands, Templates, Home-Baseline-Profile, Bash-/PowerShell-Validatoren, Tests, Manpage, bilinguale README und Feldvalidierung. Halte das Standard-Acht- und das bestehende Neun-Preset-Profil unveraendert und fuege ein separates Zehnerprofil mit Prioritaeten 10 bis 60, Authoring 64, Review 65, Autonomous 70 und Parallel 80 hinzu. Veröffentliche hindermath/spec-kit-preset-intake-authoring-governance als v0.1.0, pruefe die versionierte GitHub-ZIP-Datei, installiere das optionale Profil in allen registrierten Level-0-/1-/2- und Lernreihen-Repositories und reiche danach das Preset ueber das offizielle Community-Template ein. Starte weder Review, Specify noch autonome Folgelaeufe implizit.
```

## 13. Abschlussgrenze / Completion Boundary

Der Auftrag ist abgeschlossen, wenn Home Baseline und alle veraenderten eigenen
Repositories sauber synchronisiert sind, das Preset als `v0.1.0` installierbar
ist, die 33 aktuell registrierten Flottenziele das optionale Zehnerprofil
exakt aufloesen und die Community-Submission veroeffentlicht ist. Ein externer
Upstream-Merge ist keine lokale Abschlussbedingung.
