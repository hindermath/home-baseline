<!-- intake-authoring:begin -->
# Lastenheft: Level-0-Checkout und Public-Template-Erstellung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-05
**Reihenfolge:** sichtbare Position 38, aktiver Manifestplatz 33, `Pending`
**Delivery Mode:** `LocalImplementation`
**Zielgruppe:** Neueinsteiger*innen, Lernende, tägliche Nutzende, Maintainer und Reviewer

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine spätere, nicht dringliche
Dokumentationskorrektur für den Level-0-Einstieg. Die Einstiegshilfe muss zwei
verschiedene Vorgänge getrennt erklären:

1. den Checkout der bestehenden kanonischen Level-0-Quelle; und
2. die Erstellung eines eigenen Repositories aus dem GitHub Public Template.

Die Trennung verhindert, dass ein gewöhnlicher Repository-Checkout mit der
serverseitigen Template-Erstellung verwechselt wird. Dieses Lastenheft ändert
die Einstiegshilfe noch nicht und startet keinen Spec-Kit-Lauf.

*This intake defines a later, non-urgent documentation correction for the
Level 0 entry path. The guide must distinguish checking out the existing
canonical source from creating a separate repository from the GitHub public
template. This intake does not yet change the guide or start downstream work.*

## 2. Ausgangslage und Zielbild / Current and Target State

`docs/getting-started.md` zeigt unter „Level 0 einrichten“ derzeit einen
direkten `git clone` des öffentlichen Repositorys nach
`~/home-baseline-source`. Dieser Befehl ist für den Checkout der bestehenden
Level-0-Quelle korrekt. Die Überschrift und der umgebende Text erklären aber
nicht ausdrücklich, dass die GitHub-Template-Funktion ein anderer Vorgang ist.

Das Zielbild bietet zwei klar benannte, selbstständig verständliche Wege. Jeder
Weg erklärt Zweck, Voraussetzungen, Befehl, Ergebnis, Remote-Beziehung,
Historie und nächste Aktion. Eine Person ohne vorherige Spec-Kit-Erfahrung muss
vor dem Kopieren eines Befehls erkennen können, welcher Weg zu ihrem Ziel passt.

*The current command correctly clones the existing repository but does not
clearly separate that operation from GitHub template creation. The target
documentation offers two named paths and explains the result of each before a
reader copies a command.*

## 3. Begriffe / Terms

- **Checkout / Clone:** lokale Arbeitskopie eines bestehenden Git-Repositorys
  einschließlich seiner erreichbaren Historie und Remote-Konfiguration.
- **Public Template:** ein auf der Hosting-Plattform als Vorlage markiertes
  Repository, aus dessen Inhalt ein eigenständiges neues Repository erzeugt
  werden kann.
- **`origin`:** der standardmäßige Name des primären Remote-Repositorys einer
  lokalen Arbeitskopie.
- **`upstream`:** ein optionaler, manuell oder durch einen Fork-Workflow
  eingerichteter Remote-Name für eine maßgebliche Referenz.
- **Deklariert `Eligible`:** der von der Series-Governance ausdrücklich
  bevorzugte nächste Intake; `Pending` erteilt keine Startautorität.

*A clone is a working copy of an existing repository. A public template is a
hosting-platform feature that creates a distinct repository from template
content. Template creation is not automatically a fork or upstream link.*

## 4. Umfang / Scope

Die spätere Umsetzung prüft und aktualisiert mindestens:

- `docs/getting-started.md` als deutsche Einstiegshilfe;
- `docs/getting-started.en.md` als inhaltlich gleichwertige englische Fassung;
- vorhandene Navigation oder Querverweise nur dann, wenn die getrennten Wege
  sonst nicht auffindbar wären;
- statische Befehls-, Link-, Sprach- und Barrierefreiheitsprüfungen für die
  geänderten Dokumente.

Die konkrete Dokumentationsänderung erhält die Entscheidung
`UpdateRequired`. Kanonische Quelle, Owner, betroffene Dokumente und Evidence
werden nach `docs/documentation-governance.md` festgehalten.

*The later implementation primarily updates the German and English getting
started guides. Navigation changes are limited to what is necessary to make
both paths discoverable.*

## 5. Anforderungen / Requirements

- **L0T-001:** Die Einstiegshilfe MUSS den Checkout eines bestehenden
  Repositorys und die Erstellung aus einem Public Template als zwei getrennte
  Anwendungsfälle darstellen.
- **L0T-002:** Der Checkout-Weg MUSS `git clone` als korrekten
  plattformübergreifenden Grundbefehl zeigen.
- **L0T-003:** Der Checkout-Weg SOLL `gh repo clone` als gleichwertige optionale
  GitHub-CLI-Alternative nennen.
- **L0T-004:** Der Checkout-Weg MUSS erklären, dass `origin` weiterhin auf das
  ausgecheckte bestehende Repository zeigt und dessen Historie erhalten bleibt.
- **L0T-005:** Der Template-Weg MUSS für GitHub den CLI-Vertrag
  `gh repo create <owner>/<name> --template hindermath/home-baseline
  --public|--private --clone` verständlich und kopierbar dokumentieren.
- **L0T-006:** Die Sichtbarkeit MUSS als bewusste Auswahl dargestellt werden;
  die Dokumentation darf nicht still `public` oder `private` voraussetzen.
- **L0T-007:** Der Template-Weg MUSS erklären, dass zuerst ein eigenständiges
  Remote-Repository erstellt und dieses anschließend gewöhnlich geklont wird.
- **L0T-008:** Die Dokumentation MUSS klarstellen, dass Template-Erstellung
  weder automatisch einen Fork noch eine `upstream`-Beziehung erzeugt.
- **L0T-009:** `gh repo clone` DARF NICHT als Template-Erstellung beschrieben
  werden.
- **L0T-010:** `git clone --template` MUSS als anderes Git-Konzept abgegrenzt
  werden: Die Option bezeichnet ein lokales Git-Template-Verzeichnis und keine
  GitHub-Repository-Vorlage.
- **L0T-011:** GitHub-spezifische Befehle MÜSSEN als optionaler Hosting-Pfad
  markiert bleiben. GitLab, Codeberg, Forgejo und generische Git-Systeme dürfen
  nicht durch eine allgemeine GitHub-Kontopflicht ausgeschlossen werden.
- **L0T-012:** macOS-/Linux-/Bash- und Windows-/PowerShell-Beispiele MÜSSEN
  dieselben fachlichen Entscheidungen und Ergebnisse beschreiben.
- **L0T-013:** Befehle MÜSSEN sichere, erkennbare Platzhalter verwenden und
  dürfen keinen persönlichen Benutzernamen fest eincodieren.
- **L0T-014:** Die Dokumentation MUSS vor jedem Befehlsblock Zweck,
  Voraussetzungen und erwartetes Ergebnis nennen.
- **L0T-015:** Die deutsche und englische Fassung MÜSSEN dieselben Optionen,
  Grenzen, Risiken und nächsten Aktionen enthalten.
- **L0T-016:** Anwendbare WCAG-2.2-AA-Anforderungen MÜSSEN berücksichtigt
  werden. Bedeutung darf nicht allein durch Farbe, Symbol oder Layout
  vermittelt werden.
- **L0T-017:** Die Beispiele MÜSSEN statisch oder über Hilfeausgaben validiert
  werden, ohne ein echtes Test-Repository oder andere Remote-Ressourcen zu
  erzeugen.
- **L0T-018:** Die Umsetzung MUSS dokumentieren, ob vorhandene
  Einstiegspfade, README-Verweise oder Lernendenhinweise unverändert richtig
  bleiben oder begrenzt nachgezogen werden müssen.

## 6. Nicht-Ziele / Non-Goals

- Keine Änderung an Bootstrap-, Wartungs-, Sync- oder Teardown-Skripten.
- Keine neue CLI-Option und kein neues Repository-Erstellungsskript.
- Keine Änderung der GitHub-Template-Einstellung des Repositorys.
- Kein automatisches Anlegen, Löschen oder Veröffentlichen eines Repositorys.
- Keine Umdeutung eines Template-Repositorys in einen Fork-Workflow.
- Keine allgemeine Migration aller Git- oder Hosting-Dokumente.
- Kein Intake Review, Specify-, Autonomous- oder Folgelauf durch die Erstellung
  oder Fortschreibung dieses Lastenhefts.

*The work changes documentation only. It does not change scripts, repository
settings, hosting resources, or downstream Spec Kit state.*

## 7. Qualitäts- und Governance-Grenzen / Quality and Governance Boundaries

- Nutzerseitige Texte sind Deutsch zuerst und Englisch danach auf CEFR-B2-Niveau.
- Fachbegriffe werden bei der ersten Verwendung erklärt.
- Befehle und Unterschiede bleiben linear, textorientiert und mit Tastatur,
  Screenreader, Braille-Zeile und Textbrowser erfassbar.
- Sicherheitsrelevante Befehle verwenden eindeutige Platzhalter und keine
  Credentials, Tokens oder privaten absoluten Pfade.
- Die spätere Umsetzung prüft aktuelle lokale CLI-Hilfe oder offizielle
  Primärdokumentation, bevor sie zeitabhängige Optionsaussagen veröffentlicht.
- Eine deterministische Prüfung ersetzt nicht die semantische Prüfung, ob eine
  neue Person die beiden Wege tatsächlich unterscheiden kann.

*User-facing prose remains bilingual, text-first, accessible, and based on
verified CLI semantics. Deterministic checks do not replace semantic review.*

## 8. Risiken und Gegenmaßnahmen / Risks and Mitigations

| Risiko / Risk | Gegenmaßnahme / Mitigation |
|---|---|
| Ein Template wird weiterhin wie ein Clone verstanden. | Ergebnis und Remote-Beziehung vor jedem Befehl erklären. |
| `git clone --template` wird als passende Lösung übernommen. | Die Git-Option ausdrücklich als nicht verwandtes Konzept kennzeichnen. |
| GitHub wird als einzige Hosting-Voraussetzung dargestellt. | GitHub-Pfad kennzeichnen und provider-neutrale Grundregeln erhalten. |
| Ein Beispiel erzeugt versehentlich ein Remote-Repository. | Nur Hilfe- und statische Prüfungen ausführen. |
| DE- und EN-Fassung driften auseinander. | Bilinguale Inhaltsmatrix und Paritätsprüfung verlangen. |
| Weitere Befunde gehen vor der späteren Umsetzung verloren. | Fortschreibung ausschließlich über den unten beschriebenen Intake-Update-Vertrag. |

## 9. Erwartete Artefakte / Expected Artifacts

| Artefakt | Erwartung |
|---|---|
| `docs/getting-started.md` | Zwei getrennte deutsche Einstiegswege mit Zweck, Befehl und Ergebnis |
| `docs/getting-started.en.md` | Semantisch gleichwertige englische Fassung |
| Documentation-Impact-Nachweis | `UpdateRequired`, Owner, Quellen, betroffene Dokumente und Evidence |
| Validierungsnachweis | Statische Befehls-, Link-, Sprach-, A11Y- und CLI-Hilfe-Prüfung ohne Remote-Schreibzugriff |

## 10. Abnahmekriterien / Acceptance Criteria

- Eine neue Person kann vor dem Ausführen eines Befehls korrekt zwischen
  „bestehende Quelle auschecken“ und „eigenes Repository aus Vorlage erstellen“
  wählen.
- `git clone`, `gh repo clone` und `gh repo create --template ... --clone`
  werden fachlich richtig voneinander abgegrenzt.
- `git clone --template` wird an keiner Stelle als GitHub-Template-Checkout
  empfohlen.
- Remote-, Historien-, Fork- und `upstream`-Folgen werden wahrheitsgemäß
  beschrieben.
- GitHub-spezifische und provider-neutrale Wege widersprechen sich nicht.
- Deutsche und englische Fassung besitzen denselben Informationsgehalt.
- Befehle sind kopierbar, platzhalterbasiert und ohne echte Remote-Mutation
  validiert.
- Anwendbare A11Y- und Documentation-Impact-Gates sind erfüllt.

*Acceptance requires clear choice, correct CLI semantics, provider neutrality,
bilingual parity, accessible presentation, and validation without remote side
effects.*

## 11. Reihenfolge und spätere Fortschreibung / Order and Later Updates

Dieser Intake steht sichtbar auf Position 38 und als aktiver Manifestplatz 33
am Ende der aktuellen Reihe. Die Kante von Position 37 ist vom Typ
`PreferredSerialOrder` und nicht bindend. Position 38 bleibt `Pending` und wird
nicht zum deklarierten bevorzugten `Eligible`-Kandidaten. Die Einordnung
erteilt keine Start- oder Delivery-Autorität.

Weitere bis dahin entdeckte Dokumentationsbefunde werden mit aktueller
ausdrücklicher Autorität über folgenden Weg ergänzt:

```text
$speckit-intake-update Lastenheft_Level-0-Checkout-und-Public-Template-Erstellung.md
```

Der Update-Lauf bewahrt die Intake-Identität, archiviert Ziel und Receipt,
bindet neue Quellen und invalidiert einen gegebenenfalls vorhandenen Review.
Weil sich der Zielhash ändert, wird danach der Series-Hash mit einem begrenzten
`$speckit-intake-series-update` nachgeführt. Position, Rolle, Status und
beratende Kante bleiben dabei unverändert, sofern keine neue ausdrückliche
Entscheidung vorliegt.

*The intake is visible item 38 and active manifest slot 33. Its incoming
PreferredSerialOrder edge is advisory. Later findings use Intake Update and a
bounded series hash refresh while identity and order remain stable.*

## 12. Annahmen und offene Entscheidungen / Assumptions and Open Decisions

- Die aktuelle Korrektur ist vollständig spezifiziert, aber bewusst nicht
  dringend.
- Die spätere fachliche Umsetzung beginnt erst nach einem frischen Intake
  Review und ausdrücklicher Startautorität.
- Es bestehen keine offenen materiellen Entscheidungen in diesem Intake.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Level-0-Checkout-und-Public-Template-Erstellung.md als alleinige verbindliche Intake-Datei. Erstelle ausschließlich die Feature-Spezifikation für die getrennte Dokumentation des bestehenden Level-0-Checkouts und der GitHub-Public-Template-Erstellung. Bewahre die Position 38, den Status Pending, die provider-neutrale Hosting-Grenze, DE-/EN-Parität, WCAG 2.2 AA, Documentation Impact UpdateRequired und alle Nicht-Ziele. Verifiziere aktuelle CLI-Semantik, aber ändere keine Dokumentation, Skripte, Repository-Einstellungen oder Remote-Ressourcen und führe keine Implementierung oder Veröffentlichung aus.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Level-0-Checkout-und-Public-Template-Erstellung.md Fuehre den vollständigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre die getrennten Checkout-/Template-Wege, provider-neutrale Hosting-Grenzen, DE-/EN-Parität, WCAG 2.2 AA, Documentation Impact UpdateRequired und alle Nicht-Ziele. Erzeuge keine echten Test-Repositories, Commits, Pushes, Pull Requests oder Merges, verändere keine Remote-Zustände und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
