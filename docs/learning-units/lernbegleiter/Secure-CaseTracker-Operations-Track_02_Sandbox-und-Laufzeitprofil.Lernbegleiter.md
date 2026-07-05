# Lernbegleiter: Secure CaseTracker Operations Track 02 – Sandbox und Laufzeitprofil / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Software läuft nicht im luftleeren Raum. Sie braucht eine **Laufzeitumgebung**: ein Betriebssystem,
Bibliotheken, Schreibrechte auf bestimmte Ordner, vielleicht Netzwerkzugang. Im 3. Lehrjahr planst du diese
Umgebung bewusst und grenzt sie ein. Eine **Sandbox** ist eine abgeschottete Umgebung, in der ein Programm
nur das darf, was du erlaubst. Sie begrenzt den Schaden, wenn etwas schiefgeht – besonders wichtig, wenn
KI-Agenten mitschreiben oder riskantere Experimente laufen.

**EN:** Software does not run in a vacuum. It needs a **runtime environment**: an operating system,
libraries, write permissions to certain folders, maybe network access. In the third training year you plan
this environment deliberately and delimit it. A **sandbox** is a walled-off environment in which a program
may only do what you allow. It limits the damage when something goes wrong – especially important when AI
agents co-author or higher-risk experiments run.

**DE:** In dieser Einheit lernst du, das Laufzeitprofil des CaseTracker zu beschreiben, Schreib- und
Netzwerkgrenzen festzulegen, die Toolchain reproduzierbar zu machen und zu entscheiden, welche Arbeit in
oder mit der öffentlichen Referenz `absdd-image-sandbox` läuft und welche begründet außerhalb bleibt.

**EN:** In this unit you learn to describe the CaseTracker's runtime profile, set write and network
boundaries, make the toolchain reproducible, and decide which work runs in or with the public reference
`absdd-image-sandbox` and which stays outside with a documented rationale.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox / Sandbox | Abgeschottete Umgebung, die einem Programm nur erlaubte Aktionen gestattet. |
| Laufzeitprofil / Runtime profile | Beschreibung von OS, Bibliotheken, Rechten, Netz und Ressourcen zur Laufzeit. |
| Schreibgrenze / Write boundary | Festlegung, in welche Ordner ein Prozess schreiben darf und in welche nicht. |
| Netzwerkgrenze / Network boundary | Regel, welche Verbindungen erlaubt sind; Standard ist „nichts erlaubt". |
| Reproduzierbare Toolchain / Reproducible toolchain | Werkzeugsatz mit festen Versionen, der überall gleich baut. |
| Agenten-Grenze / Agent boundary | Regel, was ein KI-Agent in der Umgebung darf und was nicht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Laufzeitprofil beschreiben.** Notiere, was das System zur Laufzeit braucht:
Basis-Image oder OS, Sprachlaufzeit (C#, Go, Java, Python, Rust oder Swift), Bibliotheken mit festen
Versionen, benötigte Ordner und Ressourcen. Dieses Profil ist die Grundlage für Reproduzierbarkeit.

**EN:** **Step 1 – Describe the runtime profile.** Note what the system needs at runtime: base image or OS,
language runtime (C#, Go, Java, Python, Rust, or Swift), libraries with fixed versions, required folders and
resources. This profile is the basis for reproducibility.

**DE:** **Schritt 2 – Schreib- und Netzwerkgrenzen setzen.** Nach dem Prinzip der geringsten Rechte
(Least Privilege) darf ein Prozess nur in klar benannte Ordner schreiben und nur nötige Verbindungen
öffnen. Standard ist „verboten", Erlaubnis ist die Ausnahme mit Begründung. So begrenzt du den Schaden bei
einem Fehler oder Angriff.

**EN:** **Step 2 – Set write and network boundaries.** Following least privilege, a process may only write to
clearly named folders and open only necessary connections. The default is "denied", permission is the
exception with a rationale. This limits the damage of an error or attack.

**DE:** **Schritt 3 – Toolchain reproduzierbar machen.** Feste Versionen für Compiler, Paketmanager und
Prüfwerkzeuge sorgen dafür, dass der Build auf jedem Gerät gleich läuft. Reproduzierbarkeit ist die Basis
für auditfähige Nachweise: Wer denselben Stand baut, bekommt dasselbe Ergebnis.

**EN:** **Step 3 – Make the toolchain reproducible.** Fixed versions for compiler, package manager, and
check tools ensure the build runs the same on every machine. Reproducibility is the basis for audit-ready
evidence: whoever builds the same state gets the same result.

**DE:** **Schritt 4 – Agenten- und IDE-Grenzen klären.** Lesen, Review, Navigation und Debugging dürfen
außerhalb der Sandbox mit IDE oder Editor laufen. KI-gestützte Schreibarbeit, riskante Experimente und
reproduzierbare Prüfungen sollen im 3. Lehrjahr in oder mit der Sandbox erfolgen. Jede Abweichung wird
begründet dokumentiert – nicht verboten, aber sichtbar.

**EN:** **Step 4 – Clarify agent and IDE boundaries.** Reading, review, navigation, and debugging may run
outside the sandbox with an IDE or editor. AI-assisted write work, risky experiments, and reproducible
checks should happen in or with the sandbox from the third training year. Every deviation is documented with
a rationale – not forbidden, but visible.

**DE:** **Typische Fehler.** Alles darf schreiben und ins Netz. Werkzeuge ohne feste Version. Sandbox nur
behaupten, aber nirgends definieren. KI-Agenten ungebremst schreiben lassen. Die öffentliche Referenz
nennen, aber die eigenen Grenzen nicht darauf abbilden.

**EN:** **Common mistakes.** Everything may write and reach the network. Tools without fixed versions.
Claiming a sandbox but defining it nowhere. Letting AI agents write without limits. Naming the public
reference but not mapping your own boundaries onto it.

### Beispiel / Example

```text
Laufzeitprofil:      Basis-Image X, Sprachlaufzeit fest (z. B. Go 1.x), Libs mit gepinnten Versionen
Schreibgrenze:       schreibbar nur ./data und ./out; ./src und System schreibgeschützt
Netzwerkgrenze:      Standard = keine Verbindung; Ausnahme = Paket-Registry beim Build (begründet)
Toolchain:           Compiler + Paketmanager + Scanner mit fixierten Versionen (reproduzierbar)
Agenten-Grenze:      KI-Schreibarbeit in/mit absdd-image-sandbox; IDE-Review außerhalb erlaubt
Abweichung:          "Debugging in IDE außerhalb Sandbox" -> dokumentiert mit Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Laufzeitprofil, Container- und Toolchain-Annahmen sind Kern der Bereitstellung von Diensten. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Schreib-, Netz- und Agenten-Grenzen setzen den Schutzbedarf praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Least Privilege, reproduzierbare
Umgebung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07`
(sichere Konfiguration/Umgebung), `CL_08` (Sicherheits-Review), `CL_09` (Supply-Chain/Toolchain) und
`CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Standard ist verboten;
Schreib-, Netz- und Agentenrechte sind Ausnahmen mit Begründung.* A11Y-Aspekt: Das Laufzeitprofil und die
Grenzen werden als Text-Tabelle dokumentiert, damit sie ohne grafisches Tool und ohne Farbcodierung lesbar
bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, least privilege, reproducible
environment, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_07`
(secure configuration/environment), `CL_08` (security review), `CL_09` (supply chain/toolchain), and
`CL_12` (documentation/N-A). The security decision of this unit is: *default is denied; write, network, and
agent permissions are exceptions with a rationale.* Accessibility aspect: the runtime profile and boundaries
are documented as a text table so they stay readable without a graphical tool and without color coding.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Sandbox, und wozu dient sie im Betrieb? /
   **EN:** What is a sandbox, and what is it for in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Sandbox ist eine abgeschottete Umgebung, die einem Programm nur erlaubte Aktionen gestattet.
   Sie begrenzt den Schaden, wenn ein Fehler, ein Angriff oder ein KI-Agent etwas Ungewolltes tut.
   **EN:** A sandbox is a walled-off environment that allows a program only permitted actions. It limits the
   damage when an error, an attack, or an AI agent does something unwanted.

   </details>

2. **DE:** Warum ist „Standard = verboten" bei Schreib- und Netzgrenzen sinnvoll? /
   **EN:** Why is "default = denied" sensible for write and network boundaries?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nach Least Privilege bekommt jeder Prozess nur die minimal nötigen Rechte. Wenn der Standard
   verbietet, muss jede Erlaubnis bewusst und begründet erteilt werden. So bleibt die Angriffsfläche klein.
   **EN:** By least privilege each process gets only the minimum required permissions. If the default denies,
   every permission must be granted deliberately and with a rationale. This keeps the attack surface small.

   </details>

3. **DE:** Warum ist eine reproduzierbare Toolchain für auditfähige Nachweise wichtig? /
   **EN:** Why is a reproducible toolchain important for audit-ready evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Feste Versionen sorgen dafür, dass derselbe Stand überall dasselbe Ergebnis baut. Nur so ist ein
   Nachweis überprüfbar: Ein Prüfer kann den Build wiederholen und dasselbe Artefakt erhalten.
   **EN:** Fixed versions ensure the same state builds the same result everywhere. Only then is evidence
   verifiable: a reviewer can repeat the build and obtain the same artifact.

   </details>

4. **DE:** (SI) Welche Arbeit darf im 3. Lehrjahr außerhalb der Sandbox bleiben, welche nicht? /
   **EN:** (SI) Which work may stay outside the sandbox in year 3, which may not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Lesen, Review, Navigation und Debugging dürfen außerhalb mit IDE laufen. KI-gestützte
   Schreibarbeit, riskante Experimente und reproduzierbare Prüfungen sollen in/mit der Sandbox erfolgen;
   Abweichungen werden begründet dokumentiert.
   **EN:** Reading, review, navigation, and debugging may run outside with an IDE. AI-assisted write work,
   risky experiments, and reproducible checks should happen in/with the sandbox; deviations are documented
   with a rationale.

   </details>

5. **DE:** (SI) Warum braucht ein KI-Agent in der Laufzeitumgebung eine eigene Grenze? /
   **EN:** (SI) Why does an AI agent need its own boundary in the runtime environment?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Agent schreibt Dateien und führt Befehle aus. Ohne Grenze könnte er ungewollt Systemdateien
   ändern oder ins Netz gehen. Eine klare Agenten-Grenze schränkt Schreib- und Netzrechte ein und macht sein
   Handeln nachvollziehbar.
   **EN:** An agent writes files and runs commands. Without a boundary it could unintentionally change system
   files or reach the network. A clear agent boundary restricts write and network rights and makes its actions
   traceable.

   </details>

6. **DE:** (SI) Wie dokumentierst du eine bewusste Abweichung von der Sandbox-Nutzung? /
   **EN:** (SI) How do you document a deliberate deviation from sandbox use?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als kurzen Eintrag mit Grund, Umfang und Risiko: was außerhalb lief, warum es nötig war und wie das
   Restrisiko begrenzt wurde. So bleibt die Abweichung sichtbar und prüfbar statt still.
   **EN:** As a short entry with reason, scope, and risk: what ran outside, why it was necessary, and how the
   residual risk was limited. This keeps the deviation visible and reviewable instead of silent.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] das Laufzeitprofil des Systems (OS, Laufzeit, Libs, Ressourcen) beschreiben.
- [ ] Schreib- und Netzwerkgrenzen nach Least Privilege festlegen.
- [ ] erklären, warum feste Werkzeugversionen reproduzierbare Nachweise ermöglichen.
- [ ] die Grenze zwischen Sandbox-Arbeit und erlaubter IDE-Arbeit außerhalb ziehen.
- [ ] eine bewusste Abweichung von der Sandbox begründet dokumentieren.

**EN:** I can …

- [ ] describe the system's runtime profile (OS, runtime, libs, resources).
- [ ] set write and network boundaries following least privilege.
- [ ] explain why fixed tool versions enable reproducible evidence.
- [ ] draw the line between sandbox work and permitted IDE work outside.
- [ ] document a deliberate deviation from the sandbox with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md`. The copy-paste prompt for
a later, manually started Spec Kit run is provided there.
