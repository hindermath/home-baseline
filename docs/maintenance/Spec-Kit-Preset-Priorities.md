# Spec-Kit-Preset-Prioritäten verstehen

Diese Anleitung richtet sich an Lernende und Nutzende, die mehrere
Spec-Kit-Presets gemeinsam einsetzen. Vorkenntnisse über Template-Auflösung
oder Preset-Komposition sind nicht erforderlich.

*This guide is for learners and users who combine multiple Spec Kit presets.
No prior knowledge of template resolution or preset composition is required.*

## Kurzantwort

Eine Preset-Priorität bestimmt, **welches installierte Preset bei einer
Überschneidung zuerst berücksichtigt wird**.

```text
Kleinere Zahl = höhere Priorität = frühere Berücksichtigung
```

Ein Preset mit Priorität `10` hat deshalb Vorrang vor einem Preset mit
Priorität `40`. Die Zahl ist weder eine Qualitätsnote noch eine
Ausführungsfreigabe.

*A preset priority determines which installed preset is considered first when
their contributions overlap. A lower number means higher precedence. The
number is neither a quality score nor permission to execute anything.*

## Was ist ein Preset?

Ein Preset ist ein versioniertes Paket für Spec Kit. Es kann beispielsweise
folgende Inhalte bereitstellen:

- Templates für Spezifikation, Plan, Aufgaben oder Agent-Guidance;
- Ergänzungen zu vorhandenen Templates;
- gewrappte oder zusätzliche Spec-Kit-Befehle;
- Validatoren, Skripte und Evidence-Vorlagen;
- Regeln für Sicherheit, Architektur, A11Y oder den Ablauf autonomer Läufe.

Mehrere Presets können als **Preset-Stack** gemeinsam installiert sein. Die
Prioritäten machen die Auflösung dieses Stacks reproduzierbar.

*A preset is a versioned Spec Kit package. It may provide templates, addenda,
wrapped or additional commands, validators, scripts, and governance rules.
Several installed presets form a preset stack. Priorities make resolution of
that stack reproducible.*

## Was die Priorität tatsächlich steuert

Spec Kit ordnet aktivierte Presets aufsteigend nach ihrer Prioritätszahl:

```text
10 → 20 → 30 → 40 → 50 → 60 → 64 → 65 → 66 → 70 → 80
```

Diese Reihenfolge wird relevant, wenn mehrere Presets denselben Namen für ein
Template, einen Befehl oder ein Addendum verwenden. Das Preset mit der
kleineren Zahl wird zuerst betrachtet.

Projektlokale Overrides stehen außerhalb dieser Preset-Reihenfolge und werden
vor installierten Presets aufgelöst. Die Priorität `10` kann daher keinen
bewussten lokalen Projekt-Override verdrängen.

Bei gleicher Prioritätszahl sortiert die verwendete Spec-Kit-Version
deterministisch nach Preset-ID. Gleiche Prioritäten sollten trotzdem vermieden
werden: Unterschiedliche Zahlen zeigen die beabsichtigte Schichtung deutlicher
und erleichtern Reviews.

*Spec Kit sorts enabled presets by ascending priority number. The order matters
when presets provide the same template, command, or addendum name. Project
overrides are resolved before installed presets and are not displaced by
priority `10`. Equal priorities are resolved deterministically by preset ID,
but distinct numbers communicate intent more clearly.*

## Die Kompositionsstrategie entscheidet mit

Priorität allein sagt noch nicht, ob nur ein Inhalt gewinnt oder mehrere
Inhalte kombiniert werden. Das bestimmt die Strategie des jeweiligen
Preset-Bausteins:

| Strategie | Wirkung |
|---|---|
| `replace` | Der Inhalt mit der höchsten Priorität ersetzt die niedrigeren Beiträge vollständig. |
| `prepend` | Der Beitrag wird vor den Inhalt niedriger priorisierter Schichten gesetzt. |
| `append` | Der Beitrag wird nach den Inhalt niedriger priorisierter Schichten gesetzt. |
| `wrap` | Der Beitrag umschließt den niedrigeren beziehungsweise den Core-Inhalt an einem vorgesehenen Platzhalter. |

Beispiel: Security und A11Y können denselben Plan-Befehl ergänzen. Bei
komponierbaren Addenda bleiben beide Anforderungen erhalten; Security wird
wegen Priorität `10` vor A11Y mit Priorität `40` berücksichtigt. Verwendet der
höchste Beitrag dagegen `replace`, gewinnt dieser Inhalt vollständig.

*Priority alone does not decide whether content is replaced or combined. The
component strategy does: `replace` selects the highest-precedence content,
while `prepend`, `append`, and `wrap` compose layers in defined positions.*

## Was die Priorität nicht bedeutet

Eine Preset-Priorität:

- installiert oder aktiviert kein Preset;
- startet keinen Spec-Kit-Befehl;
- führt keinen Intake, Review oder autonomen Lauf automatisch aus;
- erteilt keine Commit-, Push-, PR-, Merge-, Bypass- oder Provider-Rechte;
- ersetzt keine Abhängigkeit oder Kompatibilitätsprüfung;
- bewertet nicht, welches Fachgebiet allgemein „wichtiger“ ist;
- verändert keine Runtime-Reihenfolge der entwickelten Anwendung.

Security steht mit `10` an der Basis, weil Sicherheitsregeln bei
Überschneidungen früh berücksichtigt werden sollen. A11Y mit `40` bleibt
trotzdem verbindlich, wenn es auf das konkrete Artefakt anwendbar ist.

*Priority does not install, enable, or run a preset. It grants no remote or
administrative authority, replaces no dependency check, and does not rank the
general importance of quality concerns.*

## Die Matrix dieser Workspace-Familie

| Priorität | Preset | Rolle im Stack |
|---:|---|---|
| `10` | `security-governance` | Sicherheitsbasis und sichere Code-Erzeugung |
| `20` | `architecture-governance` | Sichere Architektur und Threat Modeling |
| `30` | `isaqb-architecture-governance` | Allgemeine Architektur nach iSAQB und arc42 |
| `40` | `a11y-governance` | Barrierefreiheit, Inklusion und didaktische Verständlichkeit |
| `50` | `cross-platform-governance` | macOS-, Linux- und Windows-Parität |
| `60` | `agent-parity-governance` | Parität der Agenten- und Command-Oberflächen |
| `64` | `intake-authoring-governance` | Optional: Intake erzeugen oder kontrolliert aktualisieren |
| `65` | `intake-review-governance` | Optional: gespeicherten Intake unabhängig prüfen |
| `66` | `intake-sequencing-governance` | Optional: Reihenfolge, Abhängigkeiten und nächste Kandidaten verwalten |
| `70` | `autonomous-run-governance` | Lebenszyklus eines ausdrücklich delegierten autonomen Laufs |
| `80` | `parallel-autonomous-run-governance` | Koordination mehrerer isolierter autonomer Läufe |

Die Abstände sind absichtlich gewählt. Zwischen `60` und `70` konnten die
optionalen Intake-Schichten mit `64`, `65` und `66` eingefügt werden, ohne die
bestehende Standardmatrix neu zu nummerieren.

Die Zahlen `64`, `65`, `66`, `70` und `80` spiegeln zusätzlich eine fachlich sinnvolle
Schichtung:

```text
Intake erstellen → Intake prüfen → Reihe steuern → Einzel-Lauf steuern → Kampagne koordinieren
```

Das ist eine Modellierung des Stacks, **keine automatische Befehlskette**.
Jeder Übergang benötigt weiterhin den passenden Befehl und die erforderliche
Autorität.

*The gaps are intentional. Optional intake layers could be inserted at `64`,
`65`, and `66` without renumbering the standard stack. The sequence from authoring
through review and autonomous coordination describes conceptual layering, not
an automatically executed command chain.*

## Wie die fünf Workflow-Presets zusammenarbeiten

Die Presets mit den Prioritäten `64`, `65`, `66`, `70` und `80` können eine
durchgängige Qualitätskette bilden. Sie bleiben trotzdem unabhängig
installierbar und werden nur aktiv, wenn ein Mensch oder eine verbindliche
Repository-Policy den jeweiligen Schritt verlangt.

```text
Rohtext oder geordnete Quelldateien
  |
  |  $speckit-intake-create
  v
Intake + Authoring-Receipt (`ReadyForReview`)
  |
  |  $speckit-intake-review
  v
Review-Ergebnis (`Ready` oder akzeptiertes `ReadyWithAcceptedRisks`)
  |
  |  $speckit-intake-series-status / $speckit-intake-series-next
  v
Geprüfte Reihenfolge + startfähige Kandidaten oder konkrete Blocker
  |
  +--> $speckit-autonomous          Ein Feature-Lauf
  |
  +--> $speckit-parallel-autonomous Mehrere isolierte Feature-Läufe
```

Die Pfeile zeigen empfohlene **manuelle Übergaben**. Kein Preset ruft den
nächsten Befehl selbst auf. Eine niedrigere oder höhere Prioritätszahl ändert
daran nichts.

### Intake Sequencing verwaltet die Reihe, nicht die Intake-Inhalte

`intake-sequencing-governance` v0.1.0 verwendet Priorität `66`. Es übernimmt
bereits vorhandene und unabhängig geprüfte Intakes, dokumentiert ihre sichtbare
Reihenfolge, Roots, bindenden Vorgänger und reine
Shared-Writer-Serialisierungen. Die Commands `read`, `status` und `next`
bleiben read-only. `next` nennt alle derzeit startfähigen Ziele oder deren
konkrete Blocker, startet aber keinen Review, kein Specify und keinen
autonomen Lauf.

*Intake Sequencing at priority `66` manages the order and lifecycle of existing
intakes. It distinguishes binding predecessors from delivery-only
serialization. Its read, status, and next commands are read-only, and next
never starts downstream work.*

### 1. Intake Authoring bereitet die fachliche Grundlage vor

`intake-authoring-governance` v0.2.0 verwaltet Intakes mit getrennten
Create-, Read-, Update- und Delete-Befehlen. Create erzeugt neue Ziele aus
ausdrücklich benanntem Rohtext, Planungen, UTF-8-Dateien oder begrenzten
öffentlichen HTTPS-Snapshots. Read fasst standardmäßig nur zusammen. Update
braucht aktuelle Autorität und archiviert den Vorgänger. Delete entfernt keine
Historie, sondern verschiebt Ziel und Receipt in ein hashgebundenes Archiv und
legt einen Tombstone an.

Wenn der Quellenumfang fachlich mehrere Intakes rechtfertigt, wird zuerst ein
vollständiger Series-Vorschlag mit Quellenabdeckung, Reihenfolge, Rollen,
Abhängigkeiten und Überschneidungsentscheidungen erzeugt. Erst eine
ausdrückliche Freigabe erlaubt die transaktionale Veröffentlichung aller
Mitglieder. Eine teilweise veröffentlichte Reihe gilt als Fehler.

Der Status `ReadyForReview` bedeutet nur:

- der Authoring-Schritt ist intern konsistent;
- keine materielle Authoring-Frage ist mehr offen;
- der gespeicherte Intake kann an eine unabhängige Prüfung übergeben werden.

`ReadyForReview` ist **keine fachliche Freigabe** für Specify oder einen
autonomen Lauf. Bei `NeedsClarification` bleiben die erzeugten Prompts sichtbar,
sind aber ausdrücklich gesperrt.

Die Priorität `64` bedeutet dabei nur, dass Authoring-Bausteine vor Review
(`65`) aufgelöst werden. Sie startet weder Create noch einen anderen
Lifecycle-Befehl automatisch.

### 2. Intake Review prüft unabhängig

`intake-review-governance` verändert den Intake nicht. Es prüft unter anderem
Ziel, Zielgruppe, Scope, Nicht-Ziele, atomare Anforderungen, messbare
Abnahmekriterien, Reihenfolge, Risiken, Sicherheit, A11Y, Plattformgrenzen,
Evidence und Delivery Authority. Das Ergebnis bindet die normalisierten Hashes
der geprüften Ziele.

Die möglichen Ergebnisse sind:

| Ergebnis | Bedeutung für einen folgenden autonomen Lauf |
|---|---|
| `Ready` | Der aktuelle Intake darf das Review-Gate passieren. |
| `ReadyWithAcceptedRisks` | Nur mit dokumentierten Medium-/Low-Risiken und ausdrücklicher menschlicher Akzeptanz zulässig. |
| `NeedsClarification` | Wesentliche Antworten fehlen; der Lauf bleibt gesperrt. |
| `NeedsRemediation` | Der Intake muss vor dem Lauf gezielt verbessert werden. |
| `Rejected` | Der geprüfte Intake ist in dieser Form nicht ausführbar. |

Critical- oder High-Findings blockieren immer. Ein autonomer Agent darf Risiken
nicht selbst akzeptieren.

### 3. Autonomous Run nutzt das Review als optionales Start-Gate

`autonomous-run-governance` v0.3.2 prüft vor Branch-, Feature- und
Specify-Erstellung, ob Intake Review installiert und laut Repository-Policy
verpflichtend ist:

- Ist das Gate nicht anwendbar, wird es nachvollziehbar als `N/A` erfasst.
- Ist es verpflichtend, muss genau ein aktuelles Ergebnis zum verbindlichen
  Intake vorhanden sein.
- Der normalisierte Intake-Hash muss mit dem Review-Ergebnis übereinstimmen.
- Nur `Ready` oder ein menschlich akzeptiertes `ReadyWithAcceptedRisks`
  passiert das Gate.
- Fehlende Evidence, Hashdrift, offene Fragen oder blockierende Findings
  stoppen den Lauf, bevor Implementierungsarbeit beginnt.

Das akzeptierte Review und die Zielhashes werden in den `acceptedArtifacts`
des autonomen Run-States aufgenommen. Status und Resume können dadurch später
erkennen, ob die ursprünglich akzeptierte Grundlage noch unverändert ist.

### 4. Parallel Autonomous prüft zusätzlich die Kampagne

`parallel-autonomous-run-governance` v0.2.3 koordiniert mehrere Worker, führt
deren einzelne Feature-Läufe aber nicht selbst aus. Jeder reale Worker benötigt
Preset 7 für seinen vollständigen Lebenszyklus.

Bei einer Kampagne mit aktiviertem Intake-Review-Gate:

- wird jeder eindeutige Intake genau einmal semantisch geprüft;
- erhält trotzdem jeder Worker genau eine eigene Applicability-Zeile;
- müssen Review, Worker-Ziele, Abhängigkeiten, Handoffs und Kampagnen-DAG
  übereinstimmen;
- wird das Review vor der ersten Worktree-Erstellung geprüft;
- wird der gespeicherte Review-Hash bei Resume erneut validiert.

Damit starten parallele Worker nicht mit unterschiedlichen oder veralteten
Anforderungsständen. Preset 8 koordiniert Isolation, Reihenfolge und
Konsolidierung; Preset 7 schützt weiterhin jeden einzelnen Worker-Lauf.

### Welcher Umfang ist sinnvoll?

| Situation | Empfohlene Presets |
|---|---|
| Ein vorhandener, bereits geprüfter Intake soll lokal umgesetzt werden | Autonomous Run |
| Ein vorhandener Intake braucht zuerst eine unabhängige Qualitätsprüfung | Intake Review + Autonomous Run |
| Rohmaterial soll strukturiert und anschließend geprüft werden | Intake Authoring + Intake Review |
| Rohmaterial soll bis zum einzelnen autonomen Feature-Lauf geführt werden | Intake Authoring + Intake Review + Autonomous Run |
| Mehrere geprüfte Intakes sollen isoliert koordiniert werden | Intake Review + Autonomous Run + Parallel Autonomous |
| Eine vollständige Kampagne beginnt mit Rohmaterial | Alle vier Presets |

Die strengere Kette verursacht zusätzliche Evidence und Prüfschritte. Dieser
Aufwand lohnt sich besonders bei langen autonomen Läufen, mehreren Quellen,
abhängigen Features, Parallelität oder hohen Sicherheits- und
Nachweisanforderungen. Für einen kleinen, bereits eindeutigen lokalen Intake
kann die Repository-Policy Authoring oder Review bewusst als `N/A` behandeln.

### Gemeinsame Sicherheitsgrenzen

Keiner der vier Schritte darf aus einer Priorität oder einem älteren Receipt
neue Autorität ableiten. Ohne aktuelle ausdrückliche Freigabe bleibt
`LocalImplementation` der sichere Autonomous-Standard. Commit, Push, PR,
Merge, Admin-Bypass, Secrets und Provider-Administration benötigen jeweils
eine eigene zulässige Autorität.

Hashbindung schützt nur die nachgewiesene Identität des Inhalts. Sie ersetzt
keine fachliche Prüfung, keine Tests und keine menschliche Risikoentscheidung.

## How the four workflow presets cooperate

The presets at priorities `64`, `65`, `70`, and `80` can form one traceable
quality chain while remaining independently installable. A user or binding
repository policy must request each transition.

1. **Intake Authoring** creates one structured intake plus a hash-bound receipt
   from explicit ordered sources. `ReadyForReview` confirms authoring
   consistency only; it is not review acceptance.
2. **Intake Review** evaluates the saved intake without modifying it. Only
   `Ready` or human-approved `ReadyWithAcceptedRisks` can pass an enabled
   downstream gate. Critical/High findings and unanswered material questions
   block.
3. **Autonomous Run** checks the optional policy gate before creating a branch,
   feature, or Specify artifact. It binds the accepted review and target hashes
   into `acceptedArtifacts`, so drift can be detected during status or resume.
4. **Parallel Autonomous** validates campaign-wide review coverage before
   creating worktrees. It reviews each unique intake once, retains one
   applicability row per worker, checks the campaign DAG, and revalidates the
   review hash on resume. Preset 8 coordinates; Preset 7 still governs every
   worker lifecycle.

The arrows in the workflow are manual handoffs, not automatic calls. Priority
does not trigger Authoring, Review, Autonomous Run, or Parallel Autonomous and
grants no delivery authority. The full chain is most useful for long-running,
multi-source, dependent, parallel, or evidence-sensitive work. Repository
policy may legitimately mark optional gates `N/A` for a small, already
unambiguous local intake.

## Drei praktische Beispiele

### Beispiel 1: Keine Überschneidung

Security stellt eine Sicherheitscheckliste bereit, A11Y eine
Barrierefreiheitscheckliste. Die Namen unterscheiden sich. Beide Dateien
bleiben verfügbar; die Priorität entscheidet hier nichts Sichtbares.

### Beispiel 2: Gemeinsamer Plan-Befehl

Security, Architektur und A11Y ergänzen denselben Plan-Befehl mit
komponierbaren Strategien. Spec Kit bildet den Inhalt aus den geordneten
Schichten. Keine fachliche Anforderung soll allein wegen einer niedrigeren
Priorität verschwinden.

### Beispiel 3: Gleichnamiges `replace`-Template

Zwei Presets stellen dasselbe Template mit `replace` bereit. Das Preset mit der
kleineren Prioritätszahl gewinnt. Genau diesen Fall zeigt
`specify preset resolve`.

*If names do not overlap, both contributions remain available. Composable
strategies combine ordered layers. If two `replace` templates share a name,
the lower priority number wins.*

## Installation und wirksame Auflösung prüfen

Zuerst die installierte Matrix anzeigen:

```bash
specify preset list
```

Details eines Presets prüfen:

```bash
specify preset info security-governance
specify preset info intake-review-governance
```

Die wirksame Quelle eines konkreten Template-Namens prüfen:

```bash
specify preset resolve constitution-template.md
specify preset resolve agent-guidance-addendum-template.md
```

`resolve` beantwortet eine konkrete Namensfrage. Der Befehl beweist nicht
automatisch, dass alle fachlichen Anforderungen des gesamten Stacks erfüllt
sind. Dafür bleiben Checklisten, Analyze, Tests und Evidence notwendig.

*Use `list` for the installed stack, `info` for one preset, and `resolve` for
the effective source of one concrete template name. `resolve` does not replace
requirements review, tests, or evidence.*

## Eine Priorität sicher ändern

Eine vorhandene Priorität kann technisch geändert werden:

```bash
specify preset set-priority <preset-id> <neue-priorität>
```

Beispiel:

```bash
specify preset set-priority intake-review-governance 65
```

Eine solche Änderung ist Projekt-Policy und keine kosmetische Sortierung.
Danach sind mindestens diese Schritte erforderlich:

1. `specify preset list` ausführen.
2. Betroffene Namen mit `specify preset resolve` prüfen.
3. Generierte Commands und Skills auf Duplikate oder fehlende Beiträge prüfen.
4. `git diff` und die projektspezifischen Tests ausführen.
5. Matrix, Dokumentation und Evidence gemeinsam aktualisieren.

Prioritäten nicht spontan „optimieren“. Eine Änderung kann bei `replace`,
`prepend`, `append` oder `wrap` andere wirksame Inhalte erzeugen.

*Changing a priority changes project policy. Re-check the stack, effective
resolution, generated commands and skills, Git diff, tests, documentation, and
evidence. Do not treat reprioritisation as cosmetic.*

## Häufige Missverständnisse

**„Priorität 80 wird zuerst ausgeführt, weil 80 größer ist.“**

Nein. Kleinere Zahlen haben höhere Auflösungspriorität. Außerdem startet die
Priorität keinen Befehl.

**„Ein Preset mit Priorität 10 ist immer fachlich wichtiger.“**

Nein. Die Zahl steuert Konfliktauflösung. Anwendbare A11Y-, Architektur- oder
Plattformanforderungen bleiben verbindlich.

**„Priorität 64 startet vor 65 automatisch Intake Authoring.“**

Nein. Die Zahlen bilden nur die Schichten ab. Authoring und Review werden
getrennt aufgerufen.

**„Wenn `resolve` einen Gewinner zeigt, sind alle anderen Presets wirkungslos.“**

Nein. Andere Presets können andere Namen oder komponierbare Beiträge liefern.

**„Ich kann allen Presets dieselbe Zahl geben.“**

Technisch ist das möglich. Spec Kit sortiert dann nach Preset-ID. Für
nachvollziehbare Projekt-Governance sind eindeutige Zahlen besser.

## Merksatz

```text
Priorität ordnet Beiträge. Strategie kombiniert Beiträge.
Befehle starten Arbeit. Autorität erlaubt Arbeit.
```

*Priority orders contributions. Strategy composes contributions. Commands start
work. Authority permits work.*
