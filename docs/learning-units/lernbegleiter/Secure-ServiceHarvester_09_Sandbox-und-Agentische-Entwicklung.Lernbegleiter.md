# Lernbegleiter: Secure ServiceHarvester 09 – Sandbox und agentische Entwicklung / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_09_Sandbox-und-Agentische-Entwicklung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine **Sandbox** ist ein abgegrenzter Spielbereich: Was darin passiert, kann den Rest des Systems
nicht beschädigen. Wenn KI-Agenten (Codex, Copilot, Claude, Gemini) beim Entwickeln des Sammel-Dienstes
helfen, sollen riskantere Schritte in einer freigegebenen Sandbox wie `absdd-image-sandbox` ablaufen – mit
klaren **Mounts** (Schreibbereichen), **Schreibgrenzen**, **Netzwerkannahmen** und **Secret-Regeln**. In
dieser Einheit planst du, wie Secure-ServiceHarvester-Aufgaben später in oder mit dieser Sandbox bearbeitet
werden. Wichtig: Das **Container-First-Gate** gilt ab Unit 00 verbindlich — jeder KI-Agenten-Aufruf erfolgt
im Container/der Sandbox, **nie** auf dem Arbeitsplatz-Rechner (Grundlage `Secure-Trader-Sandbox-Preflight.md`).
Nur agentenlose Arbeit — allgemeine Entwicklung, Lesen und Review — darf außerhalb stattfinden, z. B. mit
VS Code oder JetBrains-IDEs. Diese Einheit vertieft die vollständige Sandbox-Profilierung.

**EN:** A **sandbox** is a fenced-off play area: what happens inside cannot damage the rest of the system. When
AI agents (Codex, Copilot, Claude, Gemini) help develop the collection service, riskier steps should run in an
approved sandbox like `absdd-image-sandbox` – with clear **mounts** (write areas), **write boundaries**,
**network assumptions**, and **secret rules**. In this unit you plan how Secure ServiceHarvester tasks can
later be worked on in or with this sandbox. Important: the **container-first gate** is binding from unit 00 —
every AI-agent invocation happens inside the container/sandbox, **never** on the workstation (basis
`Secure-Trader-Sandbox-Preflight.md`). Only agent-free work — general development, reading, and review — may
happen outside, e.g. with VS Code or JetBrains IDEs. This unit deepens the full sandbox profiling.

**DE:** Du dokumentierst außerdem eine MSL-Support-Matrix (Status `Supported`, `Open` oder `N/A` je Sprache)
und klare Grenzen für KI-Agenten, die für alle Agenten gleichwertig verständlich sind.

**EN:** You also document an MSL support matrix (status `Supported`, `Open`, or `N/A` per language) and clear
boundaries for AI agents that are equally understandable for all agents.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox | Abgegrenzte Umgebung, die den Host vor Fehlern und Angriffen schützt. |
| Mount | Verzeichnis, das in die Sandbox eingebunden und beschreibbar ist. |
| Schreibgrenze / Write boundary | Regel, wo ein Agent oder Prozess schreiben darf. |
| KI-Agent / AI agent | Werkzeug wie Codex, Copilot, Claude oder Gemini, das beim Entwickeln hilft. |
| Isolation | Trennung der Sandbox vom Host, damit Fehler nicht überspringen. |
| Reproduzierbarkeit / Reproducibility | Gleicher Lauf liefert auf gleicher Basis gleiches Ergebnis. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Sandbox-Einordnung planen.** Beschreibe, welche Aufgaben später in `absdd-image-sandbox`
laufen sollen: riskantere Experimente, KI-Agentenläufe, reproduzierbare Toolchains, das Starten des laufenden
Dienstes. Warum? Die Sandbox ist das Zielbild für Arbeit mit klaren Schreib- und Netzwerkgrenzen; einfaches
Lesen und Review braucht sie nicht.

**EN:** **Step 1 – Plan sandbox classification.** Describe which tasks should later run in `absdd-image-sandbox`:
riskier experiments, AI agent runs, reproducible toolchains, starting the running service. Why? The sandbox is
the target picture for work with clear write and network boundaries; simple reading and review do not need it.

**DE:** **Schritt 2 – Mounts, Schreibgrenzen und Netzwerk festlegen.** Dokumentiere, welche Verzeichnisse
eingebunden werden, wo ein Agent schreiben darf und ob Netzwerkzugriff nötig ist. Ein Sammel-Dienst spricht
mit anderen Maschinen; deshalb wird das Netzwerk begrenzt oder als bewusste Risikoentscheidung dokumentiert.
Warum? Enge Grenzen schützen den Host: Ein Agent kann nur in freigegebenen Bereichen Schaden anrichten.

**EN:** **Step 2 – Define mounts, write boundaries, and network.** Document which directories are mounted,
where an agent may write, and whether network access is needed. A collection service talks to other machines;
therefore the network is limited or documented as a deliberate risk decision. Why? Tight boundaries protect
the host: an agent can only cause damage in approved areas.

**DE:** **Schritt 3 – Secret-Regeln und Datenschutz.** Secrets gehören nicht in Prompts, Logs, Screenshots
oder Projektdateien und erscheinen nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`. Keine echten
personenbezogenen Daten in Agentenläufe. Logs aus Sandbox- oder Agentenläufen werden auf sensible Inhalte
geprüft. Warum? KI-Agenten verarbeiten viel Text; ein Secret im Prompt kann leicht in ein Log oder einen Cache
gelangen.

**EN:** **Step 3 – Secret rules and privacy.** Secrets do not belong in prompts, logs, screenshots, or project
files and appear only as the placeholder `<PLATZHALTER-KEIN-ECHTER-WERT>`. No real personal data in agent
runs. Logs from sandbox or agent runs are checked for sensitive content. Why? AI agents process a lot of text;
a secret in a prompt can easily end up in a log or cache.

**DE:** **Schritt 4 – MSL-Support-Matrix und Agenten-Grenzen.** Gib jeder der sechs Sprachen einen Status
`Supported`, `Open` oder `N/A`. Fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit
Folgeaufgabe notiert. Die Agenten-Grenzen müssen für Codex, Copilot, Claude und Gemini gleichwertig
verständlich sein. Warum? Reproduzierbarkeit und Fairness verlangen, dass die Regeln unabhängig vom Agenten
gelten.

**EN:** **Step 4 – MSL support matrix and agent boundaries.** Give each of the six languages a status
`Supported`, `Open`, or `N/A`. Missing toolchains are not hidden but noted as `Open` with a follow-up. The
agent boundaries must be equally understandable for Codex, Copilot, Claude, and Gemini. Why? Reproducibility
and fairness require that the rules apply independently of the agent.

**DE:** **Typische Fehler.** Einen KI-Agenten direkt auf dem Arbeitsplatz-Rechner statt im Container starten.
Secrets in Prompts oder Logs. Unbegrenzte Schreib- oder Netzwerkzugriffe. Fehlende Toolchains verschweigen.
Agenten-Regeln nur für einen Agenten schreiben. Agenten-Caches ins Projekt committen.

**EN:** **Common mistakes.** Starting an AI agent directly on the workstation instead of inside the container.
Secrets in prompts or logs. Unlimited write or network access. Hiding missing toolchains. Writing agent rules
for only one agent. Committing agent caches to the project.

### Beispiel / Example

```text
Sandbox:        absdd-image-sandbox (oeffentliches Referenz-Repo)
Mounts:         ./workspace (rw)   ./docs (ro)      -> Schreiben nur im Workspace
Netzwerk:       offline geplant -> N/A (bewusst), sonst begrenzte, dokumentierte Freigabe
Secrets:        keine echten Werte; nur <PLATZHALTER-KEIN-ECHTER-WERT> in Prompt/Log/Projektdatei
MSL-Matrix:     C#=Supported  Go=Supported  Java=Open(Toolchain)  Python=Supported  Rust=Supported  Swift=Open
Agenten-Grenze: Agent darf nur ./workspace aendern; Caches/Sessions bleiben ausserhalb des Projekts.
Jahr 1:         Praktische Sandbox-Nutzung = N/A (Container-/Mount-Kenntnisse noch nicht behandelt), begruendet.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Isolation, Schreibgrenzen und Secret-Regeln sind eine Schutzbedarfsentscheidung. |
| LF 2 Arbeitsplätze nach Kundenwunsch ausstatten | Berührt / Touched | Sandbox und Toolchains sind Teil der sicheren Ausstattung des Arbeitsplatzes. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Netzwerkannahmen und reproduzierbare Toolchains betreffen den bereitgestellten Dienst. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Entwicklungsumgebung, KI-Codeerzeugung und
Sandbox-Freigabe. Passende Checklisten: `CL_09` (Testmanagement/Reproduzierbarkeit), `CL_10`
(Kompetenz/Nachweis) und `CL_12` (sichere Sandbox/Umgebung). Die Sicherheitsentscheidung dieser Einheit
lautet: *Jeder KI-Agenten-Aufruf läuft im Container/der Sandbox — nie auf dem Arbeitsplatz-Rechner — mit klaren
Schreib-, Netzwerk- und Secret-Grenzen; dieses Gate gilt ab Unit 00 verbindlich (in ISO-27001-zertifizierten
Organisationen ein pruefbarer Kontrollpunkt, u. a. A.8.25, A.8.31).* A11Y-Aspekt: Die
MSL-Support-Matrix und die Agenten-Grenzen werden als Texttabellen mit klaren Statuswörtern geführt, nicht nur
farblich, damit sie mit Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure development environment, AI code generation, and
sandbox approval. Matching checklists: `CL_09` (test management/reproducibility), `CL_10` (competence/
evidence), and `CL_12` (secure sandbox/environment). The security decision of this unit is: *every AI-agent
invocation runs inside the container/sandbox — never on the workstation — with clear write, network, and secret
boundaries; this gate is binding from unit 00 (an auditable control point in ISO-27001-certified organizations,
e.g. A.8.25, A.8.31).* Accessibility aspect: the MSL support matrix and the agent
boundaries are kept as text tables with clear status words, not only by color, so they remain readable with a
screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dient eine Sandbox bei agentischer Entwicklung? /
   **EN:** What is a sandbox for in agentic development?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie grenzt riskantere Schritte ab, sodass Fehler oder Angriffe den Host nicht beschädigen. Schreib-
   und Netzwerkgrenzen begrenzen den möglichen Schaden.
   **EN:** It fences off riskier steps so that errors or attacks cannot damage the host. Write and network
   boundaries limit the possible damage.

   </details>

2. **DE:** (SI) Welche technische Grenze schützt den Host vor Fehlern in der Sandbox? /
   **EN:** (SI) Which technical boundary protects the host from errors in the sandbox?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Isolation mit klaren Mounts und Schreibgrenzen sowie begrenztem Netzwerk. Ein Agent kann nur in
   freigegebenen Verzeichnissen schreiben und nicht beliebig auf das Host-System zugreifen.
   **EN:** The isolation with clear mounts and write boundaries plus limited network. An agent can write only
   in approved directories and cannot access the host system freely.

   </details>

3. **DE:** (AE) Welche Projektdateien darf ein Agent im Dienst-Repo verändern? /
   **EN:** (AE) Which project files may an agent modify in the service repo?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die freigegebenen, beschreibbaren Bereiche (z. B. `./workspace`). Spec-Kit-Artefakte bleiben im
   Projekt, Agenten-Caches und Sessions nicht.
   **EN:** Only the approved, writable areas (e.g. `./workspace`). Spec Kit artifacts stay in the project,
   agent caches and sessions do not.

   </details>

4. **DE:** (DPA) Welche Daten dürfen einem KI-Agenten nicht übergeben werden? /
   **EN:** (DPA) Which data must not be handed to an AI agent?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte personenbezogene Daten und Secrets. Testdaten bleiben fiktiv und datensparsam, damit nichts
   Sensibles in Prompts, Logs oder Caches gelangt.
   **EN:** Real personal data and secrets. Test data stays fictitious and data-minimal, so nothing sensitive
   ends up in prompts, logs, or caches.

   </details>

5. **DE:** (DV) Warum muss die Netzwerkannahme eines Sammel-Dienstes besonders dokumentiert werden? /
   **EN:** (DV) Why must the network assumption of a collection service be documented especially carefully?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst spricht mit anderen Maschinen, also überschreitet er Systemgrenzen. Ob und wie Netzwerk
   freigegeben ist, ist eine bewusste Risikoentscheidung und wird begrenzt oder ausdrücklich dokumentiert.
   **EN:** The service talks to other machines, so it crosses system boundaries. Whether and how the network is
   opened is a deliberate risk decision and is limited or explicitly documented.

   </details>

6. **DE:** Warum gilt das Container-First-Gate schon ab Unit 00, auch wenn die Sandbox-Technik erst hier vertieft wird? /
   **EN:** Why does the container-first gate already apply from unit 00, even though the sandbox technology is only deepened here?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil das Risiko am Agenten-Aufruf entsteht, nicht am Kursfortschritt: Sobald ein KI-Agent Dateien
   schreibt oder Befehle ausführt, muss das isoliert im Container geschehen. Das Gate (Agent nur im Container)
   ist deshalb ab der ersten Nutzung verbindlich; was in dieser Einheit wächst, ist die Tiefe der eigenen
   Sandbox-Profilierung (Mounts, Egress, Nachweise), nicht die Frage, ob das Gate gilt.
   **EN:** Because the risk arises at the agent invocation, not with course progress: as soon as an AI agent
   writes files or runs commands, it must happen isolated in the container. The gate (agent only in the
   container) is therefore binding from first use; what grows in this unit is the depth of your own sandbox
   profiling (mounts, egress, evidence), not whether the gate applies.

   </details>

7. **DE:** Warum müssen die Agenten-Grenzen für alle Agenten gleichwertig verständlich sein? /
   **EN:** Why must the agent boundaries be equally understandable for all agents?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Reproduzierbarkeit und Fairness verlangen, dass die Regeln unabhängig vom Agenten gelten. Codex,
   Copilot, Claude und Gemini müssen dieselben Grenzen einhalten.
   **EN:** Reproducibility and fairness require that the rules apply independently of the agent. Codex,
   Copilot, Claude, and Gemini must respect the same boundaries.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] erklären, wozu eine Sandbox bei agentischer Entwicklung dient.
- [ ] Mounts, Schreibgrenzen und Netzwerkannahmen dokumentieren.
- [ ] Secret- und Datenschutzregeln für Agentenläufe formulieren.
- [ ] eine MSL-Support-Matrix mit Status je Sprache erstellen.
- [ ] das Container-First-Gate erklären: KI-Agenten nur im Container starten, nie auf dem Arbeitsplatz-Rechner.

**EN:** I can …

- [ ] explain what a sandbox is for in agentic development.
- [ ] document mounts, write boundaries, and network assumptions.
- [ ] formulate secret and privacy rules for agent runs.
- [ ] create an MSL support matrix with a status per language.
- [ ] explain the container-first gate: start AI agents only inside the container, never on the workstation.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_09_Sandbox-und-Agentische-Entwicklung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_09_Sandbox-und-Agentische-Entwicklung.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
