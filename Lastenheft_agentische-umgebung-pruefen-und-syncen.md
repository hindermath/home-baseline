# Feature Specification: agentische-umgebung-pruefen-und-syncen
# Lastenheft: Agentische Umgebung pruefen und syncen

**Feature Branch**: `noch-offen / pending` *(wird nach Spec-Kit-Lauf aktualisiert / updated after Spec-Kit run)*
**Erstellt / Created**: 2026-04-24
**Status**: Draft
**Konstitutions-Version / Constitution Version**: 1.6.0
**Autor / Author**: Thorsten Hindermann / KI-Agent-Unterstuetzung

---

## Zielbild / Target State

Die gesamte agentische Arbeitsumgebung ueber alle drei Ebenen soll mit den
vorhandenen Skripten pruefbar, aktualisierbar und operational nachvollziehbar
sein.

*The full agentic working environment across all three levels must be
inspectable, updatable, and operationally traceable using the existing scripts.*

Betroffene Ebenen:

| Ebene / Level | Beschreibung / Description |
|---|---|
| Level 0 | `~/home-baseline-tmp` und die lokale Kopie `~/` |
| Level 1 | Workspaces wie `C64Projects`, `DataGripProjects`, `RiderProjects` |
| Level 2 | Projekte innerhalb der Workspaces |

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

### Originaltext (DE)

> 1. die gesamte agentische Umgebung (Level-0-home-baseline, Level-1-Workspaces,
> Level-2-Projekcts) pruefen und wenn notwendig aktualisieren mit den vorhandenen
> Skripten.
>
> 2. In den Ebenen Level-0-home-baseline, Level-1-Workspaces, Level-2-Projects,
> prueft, was zu committen, zu pushen, zu fetchen, zu pullen und zu syncen ist.

### Interpretation / Interpretation

- Es sollen ausschliesslich die im Workspace vorhandenen Skripte als
  Pruef- und Aktualisierungswerkzeuge genutzt werden, soweit diese den
  Anwendungsfall abdecken.
- Die Ergebnisse muessen fuer alle drei Ebenen getrennt erkennbar sein.
- Operative Git-Zustaende (`commit`, `push`, `fetch`, `pull`, `sync`) muessen
  nachvollziehbar pro Repo bzw. Ebene ausgewiesen werden.
- Home-Level-Synchronisation nach `~/` ist als eigener Schritt zu behandeln.

*Only the scripts already available in the workspace shall be used as the
primary inspection and update tools wherever they cover the use case. Results
must be distinguishable per level. Operational Git states (`commit`, `push`,
`fetch`, `pull`, `sync`) must be reported per repository or level. Home-level
sync to `~/` is a separate concern.*

---

## Systemkontext / System Context

Die Aufgabe bewegt sich in einer mehrstufigen Infrastruktur mit folgenden
Steuerungsartefakten:

*The task operates in a multi-level infrastructure with the following control
artefacts:*

- `constitution.md`
- `.specify/memory/constitution.md`
- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.github/copilot-instructions.md`
- `docs/project-statistics.md`
- Skripte unter `scripts/`

Wesentliche vorhandene Skripte:

*Key existing scripts:*

- `scripts/check-homogeneity.sh` / `.ps1`
- `scripts/scan-agent-secrets.sh` / `.ps1`
- `scripts/sync-constitution.sh` / `.ps1`
- `scripts/sync-home.sh` / `.ps1`
- `scripts/audit-agent-changes.sh` / `.ps1`

---

## Anwendungsszenarien & Tests / User Scenarios & Testing

### Szenario 1 - Skriptbasierte Gesamtpruefung und Aktualisierung (Prioritaet: P1)

Ein Entwickler oder KI-Agent prueft die agentische Umgebung auf Level 0 bis 2
mit den vorhandenen Skripten und fuehrt daraus ableitbare Aktualisierungen
gezielt aus.

*A developer or AI agent inspects the agentic environment on levels 0 to 2
using the existing scripts and performs the resulting targeted updates.*

**Warum diese Prioritaet / Why this priority**:
Ohne eine verlässliche, skriptbasierte Ist-Pruefung ist keine sichere
Aktualisierung oder Homogenisierung moeglich.

*Without a reliable script-based state inspection, safe updates and
homogenisation are not possible.*

**Unabhaengiger Test / Independent Test**:
Die Skripte liefern einen reproduzierbaren Bericht ueber den Zustand aller
Ebenen; notwendige Folgeaenderungen lassen sich daraus direkt ableiten.

*The scripts produce a reproducible report over all levels, and required
follow-up changes can be derived directly from that report.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** eine bestehende Level-0/1/2-Struktur,
   **wenn** der Prueflauf mit den vorhandenen Skripten gestartet wird,
   **dann** entsteht ein nachvollziehbarer Status je Ebene und je Repo.

   *Given an existing level-0/1/2 structure, when the inspection run starts
   using the existing scripts, then a traceable status per level and repository
   is produced.*

2. **Gegeben** Abweichungen in Verfassungen, Agenten-Dateien oder
   skriptpruefbaren Artefakten,
   **wenn** geeignete Aktualisierungsschritte ausgefuehrt werden,
   **dann** reduziert sich die Abweichung bis zum compliant Zustand oder sie
   wird explizit als Skriptgrenze dokumentiert.

   *Given deviations in constitutions, agent files, or other script-checkable
   artefacts, when suitable update steps are executed, then the deviation is
   reduced until compliant state or explicitly documented as a script boundary.*

3. **Gegeben** eine Level-2-Projektumgebung mit lokaler Spezialisierung,
   **wenn** Verfassungsinhalte aktualisiert werden,
   **dann** bleibt die projektspezifische lokale Information erhalten oder wird
   gezielt integriert statt blind ersetzt.

   *Given a level-2 project environment with local specialisation, when
   constitution content is updated, then project-specific local information is
   preserved or integrated intentionally instead of being blindly replaced.*

---

### Szenario 2 - Git- und Sync-Bedarfe transparent ausweisen (Prioritaet: P1)

Ein Entwickler oder KI-Agent moechte fuer Level 0, Level 1 und Level 2 sehen,
welche Repositories lokale Aenderungen, Push-Bedarf, Pull-Bedarf oder
Home-Sync-Bedarf haben.

*A developer or AI agent wants to see for levels 0, 1, and 2 which repositories
have local changes, need pushing, need pulling, or need home sync.*

**Warum diese Prioritaet / Why this priority**:
Aktualisierungen ohne saubere Git-Lageanalyse fuehren schnell zu
Non-Fast-Forward-Situationen, vergessenen lokalen Aenderungen oder inkonsistentem
`~/`-Sync.

*Updates without a clean Git state analysis quickly lead to non-fast-forward
situations, forgotten local changes, or inconsistent `~/` sync.*

**Unabhaengiger Test / Independent Test**:
Nach einer Statuspruefung liegt pro Repo eine klare Aussage vor:
`clean`, `commit needed`, `push needed`, `pull needed`, `sync needed`.

*After a status inspection, each repository has a clear state:
`clean`, `commit needed`, `push needed`, `pull needed`, `sync needed`.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** mehrere Repositories mit unterschiedlichem Zustand,
   **wenn** die Git- und Sync-Pruefung ausgefuehrt wird,
   **dann** wird pro Repo eindeutig ausgewiesen, ob `commit`, `push`, `fetch`,
   `pull` oder `sync` notwendig ist.

   *Given multiple repositories in different states, when the Git and sync check
   is executed, then each repository clearly shows whether `commit`, `push`,
   `fetch`, `pull`, or `sync` is required.*

2. **Gegeben** `~/home-baseline-tmp` und `~/` sind unterschiedlich,
   **wenn** die Home-Sync-Pruefung erfolgt,
   **dann** wird `sync-home.sh --no-pull` als separater lokaler Synchronisations-
   schritt erkennbar.

   *Given `~/home-baseline-tmp` and `~/` differ, when the home sync inspection is
   performed, then `sync-home.sh --no-pull` is shown as a separate local sync step.*

3. **Gegeben** ein Repo ist bereits sauber und mit dem Remote synchron,
   **wenn** die Pruefung abgeschlossen ist,
   **dann** wird kein unnoetiger Pull-, Push- oder Sync-Schritt empfohlen.

   *Given a repository is already clean and in sync with its remote, when the
   inspection is complete, then no unnecessary pull, push, or sync step is
   recommended.*

---

## Randfaelle / Edge Cases

- Ein Skript deckt den angefragten Zustand nur teilweise ab; die Grenze muss
  explizit dokumentiert werden.
- Level-2-Repositories koennen projektspezifische Verfassungs-Addenda besitzen,
  die bei Updates erhalten bleiben muessen.
- `~/` hat kein Remote und darf nicht wie ein normales Push-Repo behandelt
  werden.
- GitHub- und GitLab-Repositories koennen parallel in derselben Level-1-Struktur
  vorkommen.
- Fetch kann Neben-Branches aktualisieren, ohne dass der aktive Branch betroffen
  ist.

*Some scripts may cover the requested state only partially and the limitation
must be documented explicitly. Level-2 repositories may contain project-specific
constitution addenda that must survive updates. `~/` has no remote and must not
be treated like a normal push repository. GitHub and GitLab repositories may
coexist in one level-1 structure. Fetch may update side branches without
affecting the active branch.*

---

## Anforderungen / Requirements

### Funktionale Anforderungen / Functional Requirements

- **FR-001**: Das System MUSS die agentische Umgebung ueber Level 0, Level 1
  und Level 2 mit den vorhandenen Skripten pruefbar machen.
- **FR-002**: Das System MUSS das Ergebnis der Skriptpruefung pro Ebene und pro
  Repository nachvollziehbar ausweisen.
- **FR-003**: Das System MUSS, soweit skriptseitig moeglich, notwendige
  Aktualisierungsschritte aus den Pruefergebnissen ableiten koennen.
- **FR-004**: Das System MUSS bei Verfassungsaktualisierungen vorhandene lokale
  Level-2-Ergaenzungen gezielt erhalten oder integrieren.
- **FR-005**: Das System MUSS fuer alle relevanten Repositories ausweisen, ob
  `commit`, `push`, `fetch`, `pull` oder `sync` erforderlich ist.
- **FR-006**: Das System MUSS `~/home-baseline-tmp` und `~/` als getrennte
  Ebenen mit unterschiedlichem Git-/Sync-Verhalten behandeln.
- **FR-007**: Das System MUSS GitHub- und GitLab-Repositories innerhalb derselben
  Gesamtpruefung unterstuetzen.
- **FR-008**: Das System MUSS Skriptgrenzen offen benennen, wenn ein Zustand
  nicht vollstaendig durch vorhandene Skripte abgedeckt ist.

### Verfassungs- und Governance-Anforderungen / Constitution and Governance Requirements

- **CR-001**: Die Pruefung MUSS die aktuelle `constitution.md` sowie
  `.specify/memory/constitution.md` je Ebene als relevante Steuerungsartefakte
  beruecksichtigen.
- **CR-002**: Die Pruefung MUSS `Programmierung #include<everyone>`,
  DE-first/EN-second und WCAG-2.2-AA-relevante Artefakte als Compliance-Kontext
  mitdenken, soweit die vorhandenen Skripte dies abdecken.
- **CR-003**: Erkenntnisse zu Git- und Sync-Bedarfen duerfen keine lokalen
  projektspezifischen Spezialisierungen ueberschreiben.

---

## Erfolgskriterien / Success Criteria

- **SC-001**: Fuer alle Level-0-, Level-1- und Level-2-Repositories liegt nach
  der Pruefung ein klarer Statusbericht vor.
- **SC-002**: Notwendige Aktualisierungsschritte koennen aus dem Bericht
  nachvollziehbar abgeleitet oder direkt ausgefuehrt werden.
- **SC-003**: Git-/Sync-Bedarfe sind fuer jedes Repo eindeutig klassifizierbar.
- **SC-004**: Verfassungsbezogene Aktualisierungen erhalten lokale Level-2-
  Spezialisierungen und dokumentieren zentrale Governance-Aenderungen konsistent.

---

## Annahmen / Assumptions

- Die vorhandenen Skripte bleiben das primaere Mittel; ad-hoc-Logik ist nur
  zulaessig, wenn Skriptgrenzen transparent benannt werden.
- `check-homogeneity`, `scan-agent-secrets`, `sync-constitution`,
  `sync-home` und verwandte Skripte bilden den Kern des Zielprozesses.
- Die operative Ausfuehrung kann je nach Repo Schreibrechte, Netzwerkzugriff
  oder Remote-Zugriff benoetigen.
- Das Lastenheft beschreibt Soll-Verhalten und Entscheidungslogik, nicht bereits
  die konkrete technische Implementierung jedes Einzelschritts.

---

## Abgrenzung / Non-Goals

- Keine Einfuehrung neuer externer Werkzeuge, wenn vorhandene Skripte den
  Bedarf abdecken.
- Keine pauschale Vollautomatisierung aller Git-Operationen ohne vorherige
  Statuspruefung.
- Kein blindes Ueberschreiben projektspezifischer Level-2-Verfassungsinhalte.

