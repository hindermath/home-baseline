# Git-Start für Lernende / Git Start for Learners

## Zweck / Purpose

**DE:** Diese Datei erklärt, wie du ein entpacktes Lernpaket bewusst unter deine eigene Git-Kontrolle stellst. Das Paket enthält absichtlich keine ursprünglichen `.git`-Verzeichnisse und keine ursprünglichen Remote-URLs. Du startest also mit einem neuen, eigenen Git-Verlauf.

**EN:** This file explains how to put an extracted learning package under your own Git control deliberately. The package intentionally contains no original `.git` directories and no original remote URLs. You therefore start with a new Git history of your own.

## 1. In den entpackten Ordner wechseln / Enter the Extracted Folder

```bash
cd <Lernpaket-Ordner>
```

**DE:** Ersetze `<Lernpaket-Ordner>` durch den Namen des entpackten Ordners. `cd` wechselt in diesen Ordner. Alle folgenden Git-Befehle gelten nur dort.

**EN:** Replace `<Lernpaket-Ordner>` with the extracted folder name. `cd` changes into that folder. All following Git commands apply only there.

## 2. Neues Git-Repository anlegen / Create a New Git Repository

```bash
git init
git branch -M main
```

**DE:** `git init` erstellt ein neues lokales Git-Repository. `git branch -M main` nennt den Standard-Branch `main`. Es wird dabei kein GitHub- oder GitLab-Remote verbunden.

**EN:** `git init` creates a new local Git repository. `git branch -M main` names the default branch `main`. This does not connect a GitHub or GitLab remote.

## 3. Status prüfen / Check the Status

```bash
git status
```

**DE:** `git status` zeigt dir, welche Dateien Git sieht. Direkt nach `git init` sind die Dateien noch nicht committed.

**EN:** `git status` shows which files Git sees. Directly after `git init`, the files are not committed yet.

## 4. Dateien vormerken / Stage Files

```bash
git add .
git status
```

**DE:** `git add .` merkt alle Dateien im aktuellen Ordner für den ersten Commit vor. Der zweite `git status` zeigt, welche Dateien gleich committed werden.

**EN:** `git add .` stages all files in the current folder for the first commit. The second `git status` shows which files will be committed.

## 5. Ersten Commit erstellen / Create the First Commit

```bash
git commit -m "Initialer Stand Lernpaket"
```

**DE:** `git commit` speichert den aktuellen Stand in deinem lokalen Git-Verlauf. Die Nachricht beschreibt kurz, was dieser Commit enthält.

**EN:** `git commit` saves the current state in your local Git history. The message briefly describes what this commit contains.

## 6. Optional: Eigenes Remote verbinden / Optional: Connect Your Own Remote

**DE:** Diesen Schritt brauchst du nur, wenn deine Lehrperson ein GitHub-/GitLab-Repository vorgibt oder du selbst ein eigenes Repository erstellt hast. Ersetze `<URL>` durch die URL deines eigenen Repositories.

**EN:** You only need this step if your instructor provides a GitHub/GitLab repository or if you created your own repository. Replace `<URL>` with the URL of your own repository.

```bash
git remote add origin <URL>
git push -u origin main
```

**DE:** `git remote add origin <URL>` verbindet dein lokales Repository mit deinem eigenen Remote. `git push -u origin main` lädt deinen Commit dorthin hoch und merkt sich die Verbindung für spätere Pushes.

**EN:** `git remote add origin <URL>` connects your local repository with your own remote. `git push -u origin main` uploads your commit and remembers the connection for later pushes.

## Wichtige Grenzen / Important Boundaries

- **DE:** Diese Befehle starten keinen Spec-Kit-Lauf.
- **DE:** Diese Befehle erstellen keine GitHub- oder GitLab-Repositories automatisch.
- **DE:** Die ursprünglichen privaten Remotes aus der Vorbereitung werden nicht übernommen.
- **DE:** Lehrende entscheiden, ob jede Person ein eigenes Remote nutzt oder ob es ein gemeinsames Kurs-Remote gibt.
- **EN:** These commands do not start a Spec Kit run.
- **EN:** These commands do not automatically create GitHub or GitLab repositories.
- **EN:** The original private remotes from preparation are not included.
- **EN:** Instructors decide whether each person uses their own remote or whether there is a shared course remote.
