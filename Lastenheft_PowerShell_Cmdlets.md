<!-- intake-authoring:begin -->
# Lastenheft: PowerShell Cmdlets (Advanced Functions)

## 1. Einleitung / Introduction
Dieses Lastenheft beschreibt die Anforderungen für die Umwandlung der bestehenden PowerShell-Skripte in PowerShell Cmdlets (Advanced Functions). Ziel ist es, die Skripte einfacher in die tägliche Arbeit in der PowerShell zu integrieren, indem sie als native Befehle zur Verfügung gestellt werden.

*This specification describes the requirements for converting existing PowerShell scripts into PowerShell Cmdlets (Advanced Functions). The goal is to integrate the scripts more easily into daily PowerShell work by making them available as native commands.*

## 2. Funktionale Anforderungen / Functional Requirements

### 2.1 Umwandlung der Skripte in Cmdlets
- Jedes PowerShell-Skript (`.ps1`) im Verzeichnis `scripts/` soll zusätzlich (oder alternativ) als PowerShell Advanced Function (Cmdlet) bereitgestellt werden.
- Die Benennung soll dem PowerShell-Standard `Verb-Noun` folgen (z. B. `New-HBWorkspace` statt `bootstrap-workspace.ps1`).
- Alle Skripte sollen `[CmdletBinding()]` nutzen, um Standardparameter wie `-Verbose`, `-Debug`, `-WhatIf` und `-Confirm` zu unterstützen.
- Die kommentarbasierte Hilfe (`.SYNOPSIS`, `.DESCRIPTION`, etc.) muss vollständig erhalten bleiben und ggf. für die Cmdlet-Struktur angepasst werden.

### 2.2 Bereitstellung als Modul oder Script-Library
- Es soll ein Mechanismus geschaffen werden (z. B. ein Verzeichnis `scripts/lib/cmdlets/` oder eine zentrale `HB-Cmdlets.psm1`), der alle Cmdlets bündelt.
- Dieser Mechanismus muss es ermöglichen, alle Funktionen mit einem einzigen Befehl in die aktuelle Sitzung zu laden.

### 2.3 Dauerhafte Verfügbarkeit (PowerShell Profil)
- Es muss eine Dokumentation erstellt werden, wie der Benutzer diese Cmdlets dauerhaft in seine PowerShell-Umgebung einbinden kann.
- Dies erfolgt in der Regel über das Editieren des `$PROFILE` (z. B. `Microsoft.PowerShell_profile.ps1`).
- Die Dokumentation muss den genauen PowerShell-Code enthalten, der in das Profil eingefügt werden muss, um die Cmdlets beim Start automatisch zu laden.

## 3. Dokumentation in der README.md
Die zentrale `README.md` im Root-Verzeichnis muss um einen Abschnitt "PowerShell Integration" erweitert werden:
- Anleitung zur Installation/Einbindung der Cmdlets.
- Beispielcode für das PowerShell-Profil (`$PROFILE`).
- Erläuterung der Vorteile der Cmdlet-Nutzung gegenüber dem direkten Skriptaufruf.
- Auflistung der verfügbaren Cmdlets mit ihren entsprechenden Skript-Pendants.

## 4. Nicht-funktionale Anforderungen / Non-functional Requirements
- **Abwärtskompatibilität**: Die bestehenden Skripte sollten weiterhin auch direkt aufrufbar bleiben (z. B. durch ein Wrapper-Muster oder indem das Skript die Funktion exportiert).
- **Fehlerbehandlung**: Konsistente Nutzung von `try-catch` und `$ErrorActionPreference = 'Stop'`.
- **Bilingualität**: Die Hilfe innerhalb der Cmdlets sowie die Dokumentation in der README müssen dem `DE / EN` Standard entsprechen.

## 5. Infrastruktur-Änderungen / Infrastructure Changes

### 5.1 Verfassung (`constitution.md`)
- Ergänzung der Regeln, dass für jedes neue PowerShell-Skript auch ein entsprechendes Cmdlet (Advanced Function) mit standardkonformer Benennung (`Verb-Noun`) erstellt werden muss.

### 5.2 KI-Agenten Richtlinien
- Aktualisierung der Agenten-Anweisungen, um bei der Erstellung von PowerShell-Logik die Cmdlet-Struktur zu bevorzugen.

## 6. Abnahmekriterien / Acceptance Criteria
- Alle wesentlichen Skripte sind als `Verb-Noun` Funktionen verfügbar.
- Die `README.md` enthält eine verständliche Anleitung zur dauerhaften Profil-Integration.
- Ein Test in einer frischen PowerShell-Sitzung (nach Profil-Update) bestätigt die Verfügbarkeit der Befehle.
- Die Hilfe (`Get-Help Verb-Noun`) funktioniert einwandfrei.

---
**Status**: Entwurf / Draft | **ID**: 008-powershell-cmdlets | **Author**: Gemini CLI

## 7. Spec-Kit-Intake-Ergaenzung / Spec Kit Intake Addendum

Dieses Lastenheft beschreibt einen groesseren PowerShell-Integrationslauf. Fuer
einen Spec-Kit-Lauf muss der Scope bewusst schmal geschnitten werden: Erst wird
eine stabile Modul-/Cmdlet-Strategie spezifiziert, danach werden Skripte
schrittweise und rueckwaertskompatibel angebunden.

*This requirements document describes a larger PowerShell integration run. For a
Spec Kit run, the scope must be intentionally narrow: first define a stable
module/cmdlet strategy, then connect scripts step by step while preserving
backward compatibility.*

## 8. Aktualisierter Scope / Updated Scope

In Scope:

- Entscheidung fuer eine Modulstruktur, z. B. `HomeBaseline.psm1` plus Manifest.
- Namensmatrix von bestehenden Skripten zu `Verb-Noun`-Funktionen.
- Gemeinsame Parameterregeln: `CmdletBinding`, `SupportsShouldProcess`,
  `-WhatIf`, `-Confirm`, `-Verbose`, `-Debug`.
- Profil- und Ladeanleitung fuer Benutzende.
- Rueckwaertskompatible Skriptaufrufe bleiben erhalten.

Out of Scope:

- Sofortige Vollmigration aller PowerShell-Skripte ohne Priorisierung.
- Entfernung bestehender `.ps1`-Entry-Points.
- Automatische Veraenderung von Benutzerprofilen.

## 9. Erwartete Ergebnisartefakte / Expected Result Artefacts

| Artefakt | Erwartung |
|---|---|
| Cmdlet-Strategie | Modulname, Ladeweg, Namensschema und Kompatibilitaet sind entschieden |
| Mapping-Tabelle | Skriptname, Cmdlet-Name, Parameter und Status sind dokumentiert |
| Modul-/Library-Plan | Technischer Aufbau ist spezifiziert |
| README/Guidance | Nutzung und Profilintegration sind erklaert |
| Tests | Import, `Get-Command`, `Get-Help`, `-WhatIf` und direkte Skriptaufrufe bleiben pruefbar |

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_PowerShell_Cmdlets.md als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer eine PowerShell-Cmdlet- und Modulstrategie im home-baseline-Repository.

Ziel: Bestehende PowerShell-Skripte sollen langfristig als native Advanced Functions mit PowerShell-konformen `Verb-Noun`-Namen nutzbar werden, ohne die vorhandenen Skriptaufrufe zu brechen.

Pflichtpunkte:
- Erstelle eine Bestands- und Namensmatrix fuer alle relevanten `scripts/*.ps1`.
- Definiere Modulstruktur, Ladeweg, Profil-Hinweis und Rueckwaertskompatibilitaet.
- Lege Regeln fuer `CmdletBinding`, `SupportsShouldProcess`, `-WhatIf`, `-Confirm`, `-Verbose`, `-Debug`, Fehlerbehandlung und Hilfe fest.
- Plane eine schrittweise Umsetzung statt einer riskanten Vollmigration.
- Halte DE/EN, CEFR B2, WCAG-2.2-AA-freundliche Doku und PowerShell-Verb-Noun-Regeln ein.

Nicht-Ziele:
- Keine automatische Aenderung von Benutzerprofilen.
- Keine Entfernung bestehender `.ps1`-Entry-Points.
- Keine fachliche Skriptlogik-Aenderung ohne direkten Modul-/Cmdlet-Grund.

Erzeuge eine Spezifikation mit Scope, Nicht-Zielen, Modulentscheidung, Mapping-Artefakten, Anforderungen, Akzeptanzkriterien und Teststrategie.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_PowerShell_Cmdlets.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
