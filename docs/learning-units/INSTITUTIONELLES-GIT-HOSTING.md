# Institutionelles Git-Hosting fuer Lernreihen / Institutional Git Hosting for Learning Series

## Zweck / Purpose

**DE:** Dieser Leitfaden richtet sich an Ausbildende und Administratoren. Er
beschreibt, wie die Lernumgebung aus der GitHub-Referenz in ein institutionelles
GitLab-, Forgejo-, Codeberg- oder anderes Git-System uebertragen wird. Lernende
benoetigen danach nur ein persoenliches Konto im verwendeten Git-System.

**EN:** This guide is for instructors and administrators. It explains how to
transfer the learning environment from its GitHub reference to an institutional
GitLab, Forgejo, Codeberg, or other Git system. Learners then only need a
personal account in that Git system.

## 1. Benoetigte Repositories bestimmen / Select Required Repositories

Mindestens bereitzustellen sind:

1. `home-baseline` als Level-0-Quelle;
2. `absdd-image-sandbox` als freigegebene Sandbox-Referenz;
3. das zugewiesene Level-1-Repository der Lernreihe;
4. nur die tatsaechlich benoetigten Level-2-Sprach-Repositories.

Die Git-Historie, Branches und Tags werden erhalten. Issues, Pull Requests,
Releases und CI-Historie werden nur uebertragen, wenn der Unterricht sie
benoetigt. Die Plattformdokumentation beschreibt die moeglichen Importwege:

- GitLab: <https://docs.gitlab.com/user/project/import/github/>
- Codeberg/Forgejo: <https://docs.codeberg.org/advanced/migrating-repos/>

## 2. Institutionelle Referenzen schuetzen / Protect Institutional References

- Der Standardbranch der Referenz ist gegen direkte Lernenden-Pushes geschuetzt.
- Lernende erhalten Leserechte auf die Referenz und Schreibrechte nur auf ihr
  persoenliches Repository.
- Plattformseitiger Branch-Schutz, Runner, Secrets und formelle Freigaben werden
  von berechtigten Administratoren eingerichtet und nicht als durch ein Skript
  erledigt behauptet.
- Bei privaten GitHub-Quellen wird fuer den Import ein kurzlebiger,
  minimal berechtigter Token verwendet und danach widerrufen.

## 3. Persoenliche Lernenden-Repositories / Personal Learner Repositories

GitLab, Codeberg und Forgejo koennen einen nativen Fork im persoenlichen
Namensraum bereitstellen. Unterstuetzt das institutionelle System keine Forks,
legt die Administration ein persoenliches Repository mit derselben Git-Historie
an. In beiden Faellen gilt lokal:

```text
origin   -> persoenliches Lernenden-Repository, normales Push-Ziel
upstream -> institutionelle Referenz, nur fuer freigegebene Aktualisierungen
```

Gemeinschaftskonten und direkte Schreibrechte auf `upstream` sind nicht Teil des
Einsteigerwegs.

## 4. URL-Tabelle fuer den Kurs / Course URL Table

Vor dem ersten Termin wird eine Tabelle mit mindestens diesen Werten
bereitgestellt:

| Zweck / Purpose | Institutionelle URL / Institutional URL |
|---|---|
| `home-baseline` Referenz / reference | `<HTTPS-URL>` |
| Sandbox-Referenz / sandbox reference | `<HTTPS-URL>` |
| Level-1-Lernreihe / learning series | `<HTTPS-URL>` |
| zugewiesene Level-2-Repositories / assigned repositories | `<HTTPS-URL-LISTE>` |

Die Tabelle enthaelt keine Tokens, Passwoerter oder privaten Schluessel.

## 5. Aktualisierungsmodell / Update Model

Die Institution waehlt genau ein dokumentiertes Verfahren:

- einen kontrollierten Read-only-Mirror von GitHub;
- einen periodischen, geprueften Import;
- einen manuellen Pull/Push durch eine verantwortliche Person in einer
  administrativen Arbeitsumgebung.

Neue Referenzstaende werden erst nach lokaler Pruefung und institutioneller
Freigabe an Lernende verteilt. Lernende aktualisieren ihren Fork nur per
Fast-forward. Bei Divergenz stoppen sie und holen Unterstuetzung; Force-Push und
Hard Reset sind kein Einsteigerweg.

## 6. Konten und Agenten / Accounts and Agents

| Funktion / Function | Erforderliches Konto / Required account |
|---|---|
| Institutionelles Repository | Konto im institutionellen Git-System |
| Direkte GitHub-Nutzung | GitHub-Konto |
| GitHub Copilot CLI | GitHub-Konto mit Copilot-Berechtigung |
| Codex, Claude oder Antigravity (`agy`) | Nur Konto/Berechtigung des ausgewaehlten, freigegebenen Anbieters |
| OpenCode oder Gemini CLI | Nur bei zusaetzlicher Freigabe; Konto/Berechtigung des ausgewaehlten Anbieters |

Die vier Required-Agenten-CLIs `codex`, `claude`, `agy` und `copilot` sowie die
zusaetzlichen Oberflaechen OpenCode und Gemini CLI duerfen technisch installiert
und versionsgeprueft sein. Fuer einen Lernendenlauf reicht ein freigegebener,
authentifizierter Agent. Die Sandbox-Regel gilt unabhaengig vom
Git-Hosting-Anbieter.

## 7. CI und vollstaendige Entkopplung / CI and Full Decoupling

GitHub Actions, GitLab CI und Forgejo Actions werden nicht ungeprueft als
gleichwertig behandelt. Die Institution prueft Workflow-Syntax, externe Actions,
Runner-Vertrauen, Secrets und Pull-Request-Sicherheit separat. Bis dahin bleiben
die dokumentierten lokalen Checks verbindlich.

Dieser Leitfaden entfernt die Pflicht zu einem GitHub-Konto fuer Lernende. Er
beschreibt keinen vollstaendig air-gapped Betrieb. Ein solcher Betrieb benoetigt
zusaetzlich interne Mirrors fuer Container-Images, Paketregistries, Spec Kit und
freigegebene KI-Provider oder lokale Modelle.
