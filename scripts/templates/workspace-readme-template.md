# {{WORKSPACE_NAME}} — Workspace Baseline

Dieses Repository enthält die gemeinsame Konfiguration und Infrastruktur für alle Projekte im Workspace **{{WORKSPACE_NAME}}**.

*This repository contains the shared configuration and infrastructure for all projects within the **{{WORKSPACE_NAME}}** workspace.*

---

## Workspace-Übersicht / Workspace overview

| Projekt / Project | Beschreibung / Description | Status |
|---|---|---|
<!-- project-table-end -->

---

## Für Entwickler & Nutzende / For Developers & Users

### Wichtige Befehle / Important Commands

Hier sind die am häufigsten benötigten Befehle für die Arbeit in diesem Workspace:

*Here are the most commonly used commands for working in this workspace:*

#### 1. Neues Projekt anlegen / Create a new project
```bash
# macOS / Linux
bash ~/scripts/bootstrap-project.sh <ProjektName> <WorkspacePfad>

# Beispiel:
bash ~/scripts/bootstrap-project.sh MeinNeuesProjekt ~/{{WORKSPACE_NAME}}
```

#### 2. Compliance prüfen / Check compliance
Prüft, ob alle Projekte im Workspace den Standards entsprechen.
```bash
bash ~/scripts/check-homogeneity.sh ~/{{WORKSPACE_NAME}}
```

#### 3. STATS.md aktualisieren / Update STATS.md
Erzeugt eine statistische Übersicht über den Code-Bestand im Workspace.
```bash
bash ~/scripts/init-stats.sh
```

---

## Für Auszubildende / For IT Apprentices

Herzlich willkommen in deinem Workspace! Ein **Workspace** ist wie ein großer Ordner für ein bestimmtes Thema (z. B. "C#-Projekte" oder "Webentwicklung"). 

### Warum haben wir dieses Verzeichnis? / Why this directory?

Dieser Ordner ist dein **Zuhause für Projekte**. Er sorgt dafür, dass:
- Alle deine Projekte die gleichen **Sicherheits-Checks** haben.
- Deine Arbeit automatisch auf **GitHub** gesichert wird.
- Du KI-Agenten (wie Claude oder Copilot) nutzen kannst, die dein Projekt verstehen.

### So arbeitest du hier / How to work here

1.  **Projekte anlegen:** Nutze immer das `bootstrap-project.sh` Skript (siehe oben). Es richtet alles fix und fertig für dich ein.
2.  **Sicherheit:** In jedem Projekt gibt es einen "Wächter" (den `pre-push`-Hook). Er verhindert, dass du aus Versehen Passwörter oder geheime Schlüssel hochlädst.
3.  **Versionsverwaltung:** Speichere deine Arbeit regelmäßig mit Git-Commits.
    ```bash
    git add .
    git commit -m "feat: erklärung was ich getan habe"
    git push
    ```

### Glossar / Glossary
- **Baseline:** Die Grundausstattung, die jedes Projekt von uns bekommt.
- **Hook:** Ein kleiner automatischer Helfer, der beim Speichern (Commit) oder Hochladen (Push) aufpasst.
- **Remote:** Deine Kopie des Projekts in der Cloud (auf GitHub).

---

## Plattform-Übersicht / Platform overview

| Plattform | Unterstützt | Voraussetzung |
|---|---|---|
| macOS | ✅ nativ | – |
| Linux | ✅ nativ | – |
| Windows | ✅ PowerShell Core | Git for Windows + pwsh >= 7 |

---
