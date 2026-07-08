# Secure Trader Sandbox-Preflight: Container-First fuer KI-Agenten / Container-First for AI Agents

## Metadaten / Metadata

- **Stand / Date:** 2026-07-08
- **Uebungsfirma / Training company:** EuFPA - Europaeische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Gilt fuer / Applies to:** Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker (Basis, v2, Professional Tracks)
- **Lehrjahr / Training year:** verbindlich ab dem 1. Lehrjahr, Unit 00 / binding from the first training year, unit 00
- **Referenzprofil / Reference profile:** `absdd-image-sandbox`, oeffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>
- **Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zweck / Purpose

**DE:** Dieses Dokument ist das gemeinsame Preflight-Gate der drei Lernreihen-Familien. Es legt eine einzige,
verbindliche Regel fest, die **vor dem ersten Start eines KI-Agenten** erfuellt sein muss, und erklaert sie so,
dass sie schon im 1. Lehrjahr in Alltagssprache verstanden werden kann. Es ergaenzt die mitgeltende
`docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md` und die Checkliste
`docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`; bei Widerspruch gelten Leitlinie und
Checkliste.

**EN:** This document is the shared preflight gate of the three learning-series families. It defines a single
binding rule that must be satisfied **before the first AI agent is started**, and explains it so it is
understandable in everyday language already in the first training year. It complements the related
`Leitlinie_Sichere-Entwicklungs-Sandbox.md` and the checklist `CL_12_Agentische-KI-Sandbox.md`; in case of
conflict, the guideline and the checklist take precedence.

## Kernregel / Core Rule

**DE:** Jeder Aufruf eines KI-Agenten (zum Beispiel Codex, Claude, Copilot, Gemini oder OpenCode) fuer Arbeit
an einem Secure-Trader-System erfolgt **im Container bzw. in der freigegebenen Sandbox** — **niemals direkt auf
dem Arbeitsplatz-Rechner oder Laptop der Auszubildenden**, auf gemeinsam genutzten Servern oder in
produktionsnahen Umgebungen. Diese Regel ist ein Gate: Sie gilt, **bevor** der erste Agent gestartet wird, und
nicht erst als spaeteres Zusatzthema.

**EN:** Every invocation of an AI agent (for example Codex, Claude, Copilot, Gemini, or OpenCode) for work on a
Secure Trader system happens **inside the container or the approved sandbox** — **never directly on the
apprentice's workstation or laptop**, on shared servers, or in production-near environments. This rule is a
gate: it applies **before** the first agent is started, not as a later add-on topic.

## Warum das wichtig ist / Why This Matters

**DE:** Ein KI-Agent kann Dateien lesen und schreiben, Befehle ausfuehren und auf das Netzwerk zugreifen. Ohne
Isolation trifft dieses Verhalten den echten Arbeitsplatz-Rechner mit seinen privaten Daten, Zugangsdaten und
anderen Projekten. Ein Container/eine Sandbox setzt klare Grenzen: nur bestimmte Ordner sind sichtbar
(Mounts), Schreibrechte sind begrenzt, das Netzwerk ist eingeschraenkt, und ein Fehlgriff bleibt in der
Sandbox statt auf dem ganzen Geraet.

**EN:** An AI agent can read and write files, run commands, and access the network. Without isolation this
behaviour hits the real workstation with its private data, credentials, and other projects. A
container/sandbox sets clear limits: only certain folders are visible (mounts), write permission is bounded,
the network is restricted, and a mistake stays inside the sandbox instead of affecting the whole device.

**DE:** In Organisationen mit ISO/IEC 27001 (oder gleichwertiger Zertifizierung) ist das kein Komfort, sondern
ein Kontrollpunkt. Relevante Controls aus ISO/IEC 27001:2022 Annex A: A.5.23 (Nutzung von Cloud-Diensten),
A.8.25 (sicherer Entwicklungszyklus), A.8.28 (sichere Programmierung) und A.8.31 (Trennung von Entwicklungs-,
Test- und Produktionsumgebungen). Container-First fuer Agenten ist damit zugleich professioneller Default und
pruefbare Massnahme.

**EN:** In organizations with ISO/IEC 27001 (or equivalent certification) this is not a convenience but a
control point. Relevant controls from ISO/IEC 27001:2022 Annex A: A.5.23 (use of cloud services), A.8.25
(secure development lifecycle), A.8.28 (secure coding), and A.8.31 (separation of development, test, and
production environments). Container-first for agents is therefore both a professional default and an auditable
measure.

## Geltung nach Lehrjahr / Applicability by Training Year

**DE:** Das **Gate** (Agenten nur im Container) gilt ab Unit 00 verbindlich. Was ueber die Jahre **waechst**,
ist die Tiefe der eigenen Sandbox-Profilierung, nicht die Frage, ob das Gate gilt.

**EN:** The **gate** (agents only in the container) is binding from unit 00. What **grows** over the years is
the depth of your own sandbox profiling, not whether the gate applies.

```text
Jahr 1 / Year 1  (Unit 00 + 09): Gate verstehen und einhalten; Agent nur im Container starten;
                                 Mounts, Secret- und Schreibregeln lesen und anwenden.
Jahr 2 / Year 2  (v2):           Eigenes Sandbox-/Laufzeitprofil dokumentieren; Egress, Nachweise, Betrieb.
Jahr 3 / Year 3  (Tracks):       Sandbox-Isolation, Integration und Betriebsnachweise vertiefen und pruefen.
```

## Preflight-Checkliste / Preflight Checklist

**DE:** Vor dem ersten Agenten-Aufruf pruefen:

**EN:** Check before the first agent invocation:

- [ ] Eine freigegebene Sandbox/ein Container ist verfuegbar (Referenz: `absdd-image-sandbox`).
- [ ] Der Agent wird **im** Container gestartet, nicht auf dem Host.
- [ ] Nur benoetigte Ordner sind gemountet; Schreibrechte sind begrenzt und dokumentiert.
- [ ] Keine echten Secrets/Zugangsdaten in Prompts, Logs, Screenshots oder Projektdateien; nur Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- [ ] Netzwerkzugriff ist eingeschraenkt oder als Risikoentscheidung dokumentiert.
- [ ] Nur fiktive, datensparsame Testdaten (z. B. Northwind-Layout inkl. `ALFKI`); keine echten personenbezogenen Daten.
- [ ] Es ist klar, welche Nachweise spaeter erwartet werden (Isolationsnachweis, Mount-Liste, Netzwerkentscheidung).

## Runbook (host-agnostisch) / Runbook (Host-Agnostic)

**DE:** Die genauen Service-Namen, der Entrypoint und der konkrete Agenten-Aufruf stehen im
`absdd-image-sandbox`-README (Single Source of Truth). Das folgende Muster zeigt die Reihenfolge; `podman` und
`docker` sind austauschbar. Platzhalter `<sandbox-service>` und `<agent-cli>` gemaess README ersetzen.

**EN:** The exact service names, the entrypoint, and the concrete agent invocation are in the
`absdd-image-sandbox` README (single source of truth). The pattern below shows the order; `podman` and
`docker` are interchangeable. Replace the placeholders `<sandbox-service>` and `<agent-cli>` per the README.

```bash
# 1. Konfiguration pruefen / verify the compose configuration
podman compose config --no-interpolate      # oder / or: docker compose config

# 2. Sandbox-Image bauen (einmalig bzw. bei Aenderung) / build the sandbox image (once or on change)
podman compose build --pull                 # oder / or: docker compose build --pull

# 3. Sandbox starten / start the sandbox
podman compose up -d                        # oder / or: docker compose up -d

# 4. In die Sandbox wechseln und ERST DORT den KI-Agenten starten
#    enter the sandbox and start the AI agent ONLY there
podman compose exec <sandbox-service> bash  # oder / or: docker compose exec <sandbox-service> bash
#    -> im Container / inside the container:
#       <agent-cli>        # z. B. / e.g. codex | claude | opencode  --  Aufruf NUR hier / invoke ONLY here

# 5. Nach der Arbeit herunterfahren / shut down after work
podman compose down                         # oder / or: docker compose down
```

**DE:** Falsch waere, `<agent-cli>` direkt in einer Host-Shell (ausserhalb von Schritt 4) auszufuehren. Der
Agenten-Aufruf gehoert ausschliesslich in den Container.

**EN:** It would be wrong to run `<agent-cli>` directly in a host shell (outside step 4). The agent invocation
belongs exclusively inside the container.

## Was auf dem Host bleiben darf / What May Stay on the Host

**DE:** Lesen, Review und allgemeine Entwicklung ohne Agenten duerfen weiterhin auf dem Host erfolgen, zum
Beispiel mit VS Code, JetBrains-IDEs oder unter Windows mit Visual Studio. Die Grenze verlaeuft am
**Agenten-Aufruf**: Sobald ein KI-Agent Dateien oder Befehle ausfuehrt, geschieht das im Container.

**EN:** Reading, review, and general development without agents may still happen on the host, for example with
VS Code, JetBrains IDEs, or Visual Studio on Windows. The boundary is the **agent invocation**: as soon as an
AI agent runs files or commands, it happens inside the container.

## Bezug / References

- `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md`
- `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`
- `Lernreihen-Blueprint.md` (Grundregel Container-First)
- Unit 00 (`Sprachrepo-Projekt-Scaffold`) und Unit 09 (`Sandbox und agentische Entwicklung`) jeder Basis-Reihe
- `absdd-image-sandbox` README (konkrete Befehle und Service-Namen)
