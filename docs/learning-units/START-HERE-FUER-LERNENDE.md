# Start hier fuer Lernende / Start Here for Learners

<!-- include-everyone-guiding-principle -->
> **Leitsatz:** `Programmierung #include<everyone>`.
>
> **Guiding principle:** `Programming #include<everyone>`.
>
> **DE:** Wir gestalten Software, Dokumentation und Lernwege inklusiv und
> barrierefrei. WCAG 2.2 AA, Tastaturbedienung, Screenreader- und
> Texttauglichkeit werden von Anfang an beruecksichtigt und geprueft.
>
> **EN:** We design software, documentation, and learning paths to be inclusive
> and accessible. WCAG 2.2 AA, keyboard operation, screen-reader support, and
> text usability are considered and verified from the start.

## Ziel / Goal

**DE:** Für diese Anleitung gilt die
[Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md). Sie richtet sich ab
dem 1. Lehrjahr an Fachinformatiker*innen, Kaufleute für
IT-System-Management und Kaufleute für Digitalisierungsmanagement.

**EN:** This guide follows the
[Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md). It addresses IT
specialist apprentices, IT system management trainees, and digitalisation
management trainees from training year 1.

**DE:** Diese Anleitung fuehrt dich vom ersten Terminalfenster bis zu einem
kontrollierten KI-Agentenlauf in der Podman-Sandbox. Du brauchst keine
Vorkenntnisse mit Containern oder KI-Agenten. Arbeite die Schritte der Reihe nach
ab. Befehle mit **Host** laufen auf deinem Rechner. Befehle mit **Sandbox** laufen
erst nach dem Wechsel in den Container.

**EN:** This guide takes you from the first terminal window to a controlled AI
agent run inside the Podman sandbox. You do not need prior container or AI-agent
experience. Follow the steps in order. Commands marked **Host** run on your
computer. Commands marked **Sandbox** run only after entering the container.

## Sicherheitsregel vor dem Start / Safety Rule Before You Start

**DE:** Bei Secure OrderDesk, Secure ServiceHarvester und Secure CaseTracker darf
ein KI-Agent nur in der freigegebenen Sandbox gestartet werden. Lesen, Review und
allgemeine Entwicklung ohne Agenten duerfen auf dem Host stattfinden. Wenn du
keinen Agenten verwendest, dokumentierst du das Sandbox-Gate begruendet als
`N/A`. Lies vor dem ersten Agentenstart den
[Secure-Trader-Sandbox-Preflight](Secure-Trader-Sandbox-Preflight.md).

**EN:** For Secure OrderDesk, Secure ServiceHarvester, and Secure CaseTracker, an
AI agent may only be started inside the approved sandbox. Reading, review, and
general development without an agent may happen on the host. If you do not use an
agent, document the sandbox gate as justified `N/A`. Read the
[Secure Trader Sandbox Preflight](Secure-Trader-Sandbox-Preflight.md) before the
first agent start.

## 1. Betriebssystem und Shell bestimmen / Identify OS and Shell

**Host - macOS/Linux:**

```bash
uname -s
printf '%s\n' "$SHELL"
```

**Host - Windows, PowerShell 7:**

```powershell
$PSVersionTable.OS
$PSVersionTable.PSVersion
```

**Erfolg / Success:** Du kennst dein Betriebssystem. Unter Windows verwendest du
PowerShell 7 und `.ps1`-Skripte. Unter macOS/Linux verwendest du Bash und
`.sh`-Skripte.

## 2. Minimale Host-Werkzeuge installieren / Install Minimum Host Tools

Du brauchst zuerst Git und ripgrep. Die ausfuehrlichen Installationswege stehen
in den [Voraussetzungen](../getting-started.md#voraussetzungen-installieren). Die
GitHub CLI `gh` beziehungsweise die GitLab CLI `glab` darf bereits installiert
sein, wird aber nur im passenden Hosting-Profil angemeldet.

**Host:**

```bash
git --version
rg --version
```

**Erfolg / Success:** Beide Befehle zeigen eine Version.

## 3. Git-Hosting-Profil waehlen / Choose the Git Hosting Profile

Waehle den von deiner Lehr- oder Betreuungsperson vorgegebenen Weg:

| Profil / Profile | Konto / Account | Referenz / Reference |
|---|---|---|
| A: Institutionelles Git-Hosting | Konto im institutionellen GitLab-, Forgejo-, Codeberg- oder anderen Git-System | Von der Institution bereitgestellte URL |
| B: Direkte GitHub-Nutzung | Persoenliches GitHub-Konto | `hindermath/home-baseline` |

Ein GitHub-Konto ist in Profil A nicht erforderlich. Es wird nur fuer Profil B
oder fuer die spaetere, optionale Anmeldung bei GitHub Copilot benoetigt. Die
technische Installation einer CLI ist von der Anmeldung beim jeweiligen
Anbieter getrennt.

*A GitHub account is not required in profile A. It is only needed for profile B
or for the later optional GitHub Copilot sign-in. Installing a CLI and signing
in to its provider are separate steps.*

## 4. Persoenliches Lernenden-Repository anlegen / Create Your Learner Repository

### Profil A: Institutionelles Git-Hosting

Oeffne die von deiner Lehrperson bereitgestellte institutionelle
`home-baseline`-Referenz und waehle dort **Fork**. Der Fork liegt in deinem
persoenlichen Namensraum. Falls das verwendete Git-System keine Fork-Funktion
hat, stellt die Institution stattdessen ein persoenliches Repository mit
derselben Git-Historie bereit.

Notiere zwei HTTPS-URLs:

- die URL deines persoenlichen Repositorys fuer `origin`;
- die URL der institutionellen Referenz fuer `upstream`.

Verwende fuer HTTPS einen persoenlichen Zugriffstoken im Git-Credential-Helper.
Der Token gehoert niemals in die URL, einen Prompt, einen Screenshot oder eine
Repository-Datei.

Pruefe, ob ein sicherer Helper konfiguriert ist:

```bash
git config --global --get credential.helper
```

Auf macOS ist `osxkeychain`, unter Windows Git Credential Manager und unter
Linux ein von der Institution freigegebener Secret-Store vorgesehen. Fehlt die
Ausgabe, richte den Helper mit deiner Lehrperson ein, bevor du fortfaehrst.

### Profil B: Direkte GitHub-Nutzung

**Host:**

```bash
gh auth status
gh repo fork hindermath/home-baseline --clone=false
```

Falls die Anmeldung fehlt, fuehre `gh auth login` und `gh auth setup-git` in
einem interaktiven Terminal aus.

**Erfolg / Success:** Dein persoenlicher Namensraum enthaelt einen Fork oder ein
von der Institution bereitgestelltes persoenliches Repository. Du hast keinen
direkten Schreibzugriff auf die Referenzquelle noetig.

## 5. Persoenlichen Fork dauerhaft klonen / Clone Your Fork Permanently

### Profil A: Institutionelles Git-Hosting

Ersetze beide Platzhalter durch die von der Institution bereitgestellten
HTTPS-URLs.

**Host - macOS/Linux:**

```bash
LEARNER_REPO_URL="<HTTPS-URL-DEINES-PERSOENLICHEN-REPOSITORYS>"
INSTITUTION_UPSTREAM_URL="<HTTPS-URL-DER-INSTITUTIONELLEN-REFERENZ>"
git clone "$LEARNER_REPO_URL" "$HOME/home-baseline-source"
git -C "$HOME/home-baseline-source" remote add upstream "$INSTITUTION_UPSTREAM_URL"
git -C "$HOME/home-baseline-source" remote -v
```

**Host - Windows, PowerShell 7:**

```powershell
$LearnerRepoUrl = '<HTTPS-URL-DEINES-PERSOENLICHEN-REPOSITORYS>'
$InstitutionUpstreamUrl = '<HTTPS-URL-DER-INSTITUTIONELLEN-REFERENZ>'
git clone $LearnerRepoUrl "$HOME/home-baseline-source"
git -C "$HOME/home-baseline-source" remote add upstream $InstitutionUpstreamUrl
git -C "$HOME/home-baseline-source" remote -v
```

### Profil B: Direkte GitHub-Nutzung

**Host - macOS/Linux:**

```bash
GH_USER="$(gh api user --jq .login)"
gh repo clone "${GH_USER}/home-baseline" "$HOME/home-baseline-source"
git -C "$HOME/home-baseline-source" remote add upstream https://github.com/hindermath/home-baseline.git
git -C "$HOME/home-baseline-source" remote -v
```

Unter Windows verwendest du denselben Ablauf in PowerShell mit
`$GitHubUser = gh api user --jq '.login'`.

**Erfolg / Success:** `origin` zeigt auf dein persoenliches Lernenden-Repository.
`upstream` zeigt auf die institutionelle Referenz oder in Profil B auf
`https://github.com/hindermath/home-baseline.git`.
Vertausche diese beiden Remotes nicht. Der Ordner `~/home-baseline-source` wird nach
der Einrichtung nicht geloescht.

Falls `upstream` bereits existiert, pruefe nur seine URL. Fuehre keinen zweiten
`remote add`-Befehl aus.

## 6. Fork sicher aktualisieren / Update the Fork Safely

**Host:**

```bash
git -C "$HOME/home-baseline-source" status --short
git -C "$HOME/home-baseline-source" switch main
git -C "$HOME/home-baseline-source" fetch upstream
git -C "$HOME/home-baseline-source" merge --ff-only upstream/main
git -C "$HOME/home-baseline-source" push origin main
```

**Erfolg / Success:** Der Arbeitsbaum war vor dem Abgleich sauber, der
Fast-forward war erfolgreich und dein Fork ist aktuell. Wenn `--ff-only`
abbricht, verwende keinen Reset und keinen Force-Push. Bitte eine Lehr- oder
Betreuungsperson um Konflikthilfe.

## 7. Host-Wartung zuerst ansehen / Preview Host Maintenance

**Host - macOS/Linux:**

```bash
cd "$HOME/home-baseline-source"
bash scripts/maintain-agentic-brew-apps.sh --dry-run
```

**Host - Windows, PowerShell 7:**

```powershell
Set-Location "$HOME/home-baseline-source"
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -WhatIf
```

Lies die geplanten Installationen. `required` bedeutet verbindlich fuer die
Lernumgebung; `optional` wird nicht ohne eigene Zustimmung installiert.

## 8. Host-Wartung ausfuehren / Run Host Maintenance

**Host - macOS/Linux:**

```bash
bash scripts/maintain-agentic-brew-apps.sh
```

**Host - Windows, PowerShell 7:**

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1
```

Der Lauf installiert beziehungsweise prueft Podman, Syft, GitHub Spec Kit, die
sechs Lernsprachen und die vier Agenten-CLIs. Die Agenten auf dem Host sind fuer
Wartung und andere freigegebene Repositories vorhanden. Fuer Secure-Trader-Arbeit
startest du sie trotzdem nur in der Sandbox.

## 9. Required-Werkzeuge pruefen / Check Required Tools

**Host:**

```bash
podman --version
dotnet --version
go version
java -version
javac -version
python3 --version
cargo --version
rustc --version
swift --version
syft version
specify --version
codex --version
claude --version
agy --version
copilot --version
```

Unter Windows lautet der Python-Befehl `python --version`. Wenn eine Toolchain
auf deiner Plattform nicht automatisch installiert werden kann, muss die
Wartung sie als offene manuelle Luecke melden; sie darf nicht still fehlen.

## 10. Lokale Betriebskopie synchronisieren / Synchronize the Local Runtime Copy

**Host - macOS/Linux:**

```bash
bash "$HOME/home-baseline-source/scripts/install-hooks.sh"
bash "$HOME/home-baseline-source/scripts/sync-home.sh" --no-pull
```

**Host - Windows, PowerShell 7:**

```powershell
pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/install-hooks.ps1"
pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/sync-home.ps1" -NoPull
```

`~/home-baseline-source` bleibt die Git-Arbeitskopie mit `origin` und `upstream`.
`~/` ist die lokale Betriebskopie ohne Remote-Verbindung.

Loesche den Klon nach dem ersten Sync nicht. Nur dort koennen Updates aus
`upstream` nachvollziehbar uebernommen, eigene Aenderungen nach `origin`
gepusht und spaetere Home-Sync-Laeufe sicher geprueft werden. Vor einem echten
Sync kannst du den Zustand schreibfrei pruefen:

```bash
bash "$HOME/home-baseline-source/scripts/sync-home.sh" --check-only
```

```powershell
pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/sync-home.ps1" -CheckOnly
```

Im ABS-DD-Container nutzt du `~/home-baseline-source` direkt. Starte dort keinen
schreibenden Home-Sync; dieser gehoert auf den Host.

*Do not delete the clone after the first sync. It is the only place where you
can trace updates from `upstream`, push your changes to `origin`, and verify
later Home sync runs safely. Inside the ABS-DD container, use
`~/home-baseline-source` directly and run writing Home sync operations on the host.*

## 11. Referenz-Sandbox klonen / Clone the Reference Sandbox

Verwende in Profil A die institutionelle Sandbox-URL. Nur in Profil B oder wenn
deine Lehrperson es ausdruecklich vorgibt, verwendest du die oeffentliche
GitHub-Referenz.

**Host - macOS/Linux:**

```bash
mkdir -p "$HOME/container-images"
SANDBOX_REPO_URL="<INSTITUTIONELLE-SANDBOX-URL-ODER-HTTPS://GITHUB.COM/HINDERMATH/ABSDD-IMAGE-SANDBOX.GIT>"
git clone "$SANDBOX_REPO_URL" "$HOME/container-images/absdd-image-sandbox"
cd "$HOME/container-images/absdd-image-sandbox"
cp opencode.env.example opencode.env
```

**Host - Windows, PowerShell 7:**

```powershell
New-Item -ItemType Directory -Force -Path "$HOME/container-images" | Out-Null
$SandboxRepoUrl = '<INSTITUTIONELLE-SANDBOX-URL-ODER-HTTPS://GITHUB.COM/HINDERMATH/ABSDD-IMAGE-SANDBOX.GIT>'
git clone $SandboxRepoUrl "$HOME/container-images/absdd-image-sandbox"
Set-Location "$HOME/container-images/absdd-image-sandbox"
Copy-Item opencode.env.example opencode.env
```

Die Datei `opencode.env` bleibt lokal und darf keine echten Werte enthalten,
solange kein freigegebener Provider konfiguriert wird.

## 12. Podman vorbereiten / Prepare Podman

**Host - macOS/Windows:**

```bash
podman machine init
podman machine start
podman info
```

`podman machine init` wird nur beim ersten Mal benoetigt. Wenn die Maschine
bereits existiert, fahre mit `podman machine start` fort.

**Host - Linux:**

```bash
podman info
```

## 13. Sandbox pruefen, bauen und starten / Validate, Build, and Start

**Host, im Sandbox-Repository:**

```bash
podman-compose config
podman compose build --pull
podman compose up -d
podman compose exec ade bash
```

Wenn `podman compose` keinen Compose-Provider findet, installiere den im
Required-Wartungslauf vorgesehenen `podman-compose`-Provider und wiederhole den
Befehl. Docker oder Docker Desktop sind fuer diesen Lernweg nicht vorgesehen.

## 14. Container-Identitaet pruefen / Verify Container Identity

**Sandbox:**

```bash
whoami
pwd
test -f /.dockerenv || test -f /run/.containerenv
```

**Erfolg / Success:** `whoami` zeigt `adedev`; mindestens eine Container-Markierung
ist vorhanden. Starte keinen Agenten, solange diese Pruefung fehlschlaegt.

## 15. Sandbox-Smoke-Test ausfuehren / Run the Sandbox Smoke Test

**Sandbox:**

```bash
bash /ade-dev-sandbox/scripts/smoke-test-toolchains.sh
```

**Erfolg / Success:** Die sechs Sprach-Toolchains, Syft, Spec Kit, OpenCode sowie
Codex, Claude, Gemini und Copilot melden ihre Version und die Beispieltests enden
mit `Toolchain smoke tests passed.`

## 16. Level-2-Repository und Unit 00 oeffnen / Open Level 2 and Unit 00

**Sandbox:** Waehle genau den Mount und Sprachordner, den deine Lehrperson
vorgegeben hat, zum Beispiel:

```bash
cd /secure-case-tracker-projects/SecureCaseTracker-CSharp
git status --short
```

Lies danach im Repository:

1. `START-HERE-FUER-LERNENDE.md`;
2. den Unit-00-Lernbegleiter unter `docs/learning-units/lernbegleiter/`;
3. `docs/learning-units/Secure-Trader-Sandbox-Preflight.md`;
4. das Unit-00-Lastenheft.

Ein vorbereiteter Intake startet noch keinen Spec-Kit-Lauf.

## 17. Erster kontrollierter Agentenlauf / First Controlled Agent Run

### 17.1 Anmeldung nur in der Sandbox / Sign In Only Inside the Sandbox

**Sandbox:** Starte genau einen institutionell freigegebenen und fuer dich
zugelassenen Agenten mit `codex`, `claude`, `gemini` oder `copilot` und folge
dessen Login-Anleitung. Die vier CLIs sind technisch installiert; du benoetigst
nicht vier Anbieterkonten. Fuer `copilot` ist ein GitHub-Konto mit
Copilot-Berechtigung erforderlich, auch wenn dein Repository auf GitLab,
Codeberg oder Forgejo liegt. Speichere Tokens nur im dafuer vorgesehenen Named
Volume. Zeige Tokens weder im Terminalprotokoll noch in Git-Dateien.

### 17.2 Erster Auftrag: nur lesen / First Task: Read Only

Gib dem Agenten diesen Auftrag:

```text
Arbeite ausschliesslich lesend. Erklaere mir die Repository-Struktur, Unit 00 und
das Secure-Trader-Sandbox-Preflight in einfachen Worten. Aendere keine Datei,
installiere nichts und fuehre keine Git-Schreibaktion aus.
```

Beende den Agenten und pruefe selbst:

```bash
git status --short
```

**Erfolg / Success:** Es wird keine Aenderung angezeigt.

### 17.3 Zweiter Auftrag: genau eine Lernnachweis-Datei / Second Task: One File

Starte den Agenten erneut und gib ihm diesen begrenzten Auftrag:

```text
Lege ausschliesslich docs/learning-evidence/unit-00-first-agent.md an. Notiere
kurz: verwendeter Agent, Ziel des lesenden Laufs, meine geprueften Beobachtungen
und offene Fragen. Schreibe keine Tokens, Zugangsdaten oder Prompt-Verlaeufe.
Aendere keine andere Datei. Committe und pushe nichts.
```

Pruefe danach selbst:

```bash
git status --short
git diff -- docs/learning-evidence/unit-00-first-agent.md
git diff --check
```

Fuehre anschliessend die Tests aus, die im Unit-00-Lernbegleiter fuer deine
Sprache genannt sind. Commit und Push erfolgen erst nach menschlicher Pruefung
und nur zum persoenlichen beziehungsweise von der Lehrperson vorgegebenen Remote.

## 18. Sandbox kontrolliert beenden / Stop the Sandbox Safely

Verlasse zuerst die Sandbox-Shell mit `exit`. Fuehre danach auf dem Host im
Sandbox-Repository aus:

```bash
bash scripts/compose-down-with-audit.sh --podman
```

Ein normaler Stop erhaelt die Agenten-Volumes. Nur ein bewusst angeforderter
Reset verwendet `-v` und loescht die gespeicherten Agentenanmeldungen.

## Hilfe bei Fehlern / Troubleshooting

- Host-Wartung: [Betrieb und Wartung](../maintenance/README.md#sicherer-standardablauf)
- Git-Grundlagen im entpackten Lernpaket: [GIT-START-FUER-LERNENDE.md](GIT-START-FUER-LERNENDE.md)
- Institutionelles Git-Hosting: [INSTITUTIONELLES-GIT-HOSTING.md](INSTITUTIONELLES-GIT-HOSTING.md)
- Sandbox-Dokumentation: `docs/fuer-lernende/` im geklonten Sandbox-Repository
- Oeffentliche Sandbox-Referenz: <https://github.com/hindermath/absdd-image-sandbox>

Verwende bei Problemen keinen Force-Push, keinen Hard Reset und keine echten
Secrets als Diagnosebeispiel.
