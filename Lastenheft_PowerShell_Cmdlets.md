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
