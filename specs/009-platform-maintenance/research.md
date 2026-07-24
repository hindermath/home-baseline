# Research: Platformübergreifende Ein-Kommando-Wartung

## R-001: Native entrypoints with shared contract engine

**Decision**: Bash und PowerShell bleiben native öffentliche Oberflächen.
Manifestvalidierung, Git-Zielentscheidung und JSON-Bericht werden einmalig in
einem Python-3-Standardbibliothekskern implementiert.

**Rationale**: Python ist auf Unix und Windows bereits als erforderliche
Flotten-CLI registriert. Der Kern verhindert doppelte sicherheitskritische
Pfad-, Remote- und Zustandslogik, während native Hilfe-, WhatIf- und
Toolchain-Erwartungen erhalten bleiben.

**Alternatives considered**: Zwei vollständige native Implementierungen wurden
wegen des höheren Drift- und Testaufwands verworfen. Ein vollständiger Python-
Orchestrator wurde ebenfalls verworfen, weil Plattformhilfe und Paketmanager-
Integration nativ bleiben sollen.

## R-002: Desired state before discovery

**Decision**: Das versionierte Fleet-Manifest ist die portable Sollquelle.
Lokale Discovery und Registry sind Ist-Evidence und dürfen das Soll nicht
stillschweigend erweitern.

**Rationale**: Clone-on-missing ist nur mit explizitem Pfad, Remote, Branch und
Wartungsklasse sicher.

**Alternatives considered**: Ausschließlich dynamische Verzeichnissuche kann
fehlende Ziele nicht unterscheiden und wurde deshalb abgelehnt.

## R-003: Transactional clone

**Decision**: Fehlende Ziele werden in ein eindeutiges Geschwisterverzeichnis
geklont, geprüft und atomar an den Zielpfad verschoben.

**Rationale**: Teilklone dürfen keinen scheinbar gültigen Zielzustand
hinterlassen.

**Alternatives considered**: Direktes Klonen in den Zielpfad wurde wegen
unvollständiger Fehlerzustände verworfen.

## R-004: Isolated failure continuation

**Decision**: Jede Stufe und jedes Ziel erzeugt zuerst ein Ergebnisobjekt.
Nur deklarierte Abhängige werden gesperrt; unabhängige Prüfungen laufen weiter.

**Rationale**: Ein Fehler darf den finalen Bericht nicht verhindern.

**Alternatives considered**: Globales `set -e` ohne Ergebnisgrenze ist für
fortsetzbare Wartung ungeeignet.

## R-005: Exit-code compatibility

**Decision**: Der neue Hauptvertrag nutzt 0/1/2. Der bestehende Exitcode 3 für
erfolgreiches `--repair-drift` bleibt aus Kompatibilitätsgründen erhalten und
wird im Bericht als erfolgreicher Reparaturzustand erklärt.

**Rationale**: Die Intake-Semantik bleibt eindeutig, ohne bestehende Aufrufer
unnötig zu brechen.

**Alternatives considered**: Exitcode 3 sofort zu entfernen wäre eine
unbegründete inkompatible Änderung.

## R-006: Durable report boundary

**Decision**: Run-ID, Log und JSON-Bericht werden vor mutierenden Stufen
initialisiert. Ein Abschluss-Handler schreibt den bestmöglichen Bericht auch
bei isolierten Fehlern.

**Rationale**: Diagnose und Resume benötigen persistente, korrelierbare
Evidence.

**Alternatives considered**: Nur Terminalausgabe ist weder maschinenlesbar
noch nach einem Abbruch zuverlässig.

## R-007: Safe fixture strategy

**Decision**: Tests verwenden temporäre HOME-Verzeichnisse und lokale Bare-Git-
Remotes. Paketmanager und echte Flottenziele werden nie angesprochen.

**Rationale**: Damit sind Clone-, Fetch- und Fast-forward-Pfade deterministisch
und ohne Providerrechte prüfbar.

**Alternatives considered**: Live-GitHub-Fixtures sind langsam, flüchtig und
würden unnötige Remote-Autorität verlangen.

## R-008: Position-4 boundary

**Decision**: Feature 009 liefert Status- und Reportfelder, die ein späteres
flottenweites Remote-Freshness-Gate auswerten kann. Es beansprucht jedoch
weder vollständige Vorab-Fetch-Barriere noch beliebige Default-Branch- oder
verwaiste-Worktree-Bereinigung.

**Rationale**: Das erhält die festgelegte Intake-Reihenfolge und verhindert
Scope-Verschmelzung.

**Alternatives considered**: Die spätere Härtung vorzuziehen würde zwei
akzeptierte Lastenhefte vermischen.
