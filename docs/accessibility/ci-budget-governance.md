# Barrierefreiheit der CI-Budget-Governance / CI Budget Governance Accessibility

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Accessibility Reviewer
**Restrisiko / Residual risk**: Native Linux-/Windows-Ausgaben wurden in diesem Lauf nicht manuell geprüft.
**Follow-up**: Native Plattformprüfung bei der nächsten Wrapper- oder Plattformänderung.
**Re-Evaluation**: Bei CLI-, Hilfe-, Ausgabe-, Sprache- oder Navigationsänderungen.

## Prüfstatus / Review Status

Pass für die anwendbaren WCAG-2.2-AA-Kriterien der textorientierten CLI und
Dokumentation. Die Oberfläche besitzt keine Maus-, Zeiger-, Zeit-, Video- oder
Drag-and-drop-Interaktion; diese Kriterien sind `N/A` und werden bei einer
späteren grafischen Oberfläche neu bewertet.

*Pass for the applicable WCAG 2.2 AA criteria of a text-based CLI and its
documentation. Pointer, timing, media, and drag-and-drop criteria are N/A until
a graphical surface is introduced.*

## Text- und Bedienvertrag / Text and Interaction Contract

- Für Stage B ist die Reihenfolge immer: `Run-ID / Run ID`,
  `Autoritaet / Authority`, `Welle / Wave`, `Repository-ID`,
  `Profil / Profile`, `Entscheidung / Decision`, `Status`, `Blocker` und
  `Naechste Aktion / Next action`. Der lokale CI-Gate ergänzt danach
  Gate-Set-Hash, Einzelschritte und Evidence-Ziel.
- Bedeutung hängt nicht von Farbe, Cursorposition oder räumlicher Anordnung ab.
- Alle Aufrufe sind vollständig per Tastatur ausführbar; Ausgaben können
  kopiert, in Screenreadern linear gelesen, auf Braille-Zeilen dargestellt und
  in Textbrowsern beziehungsweise Logs ausgewertet werden.
- Deutsch steht zuerst, Englisch folgt unmittelbar. Sätze bleiben ungefähr auf
  CEFR-B2-Niveau. `Gate`, `Evidence`, `HEAD` und `Remote-Konvergenz` werden beim
  ersten fachlichen Auftreten erklärt.
- Fehler nennen Status, stabilen Blocker und nächste Aktion ohne Stacktrace,
  Credential, Home-Pfad oder Farbsignal.
- Codeblöcke verwenden Sprachkennzeichnungen. Diagramme benötigen eine
  unmittelbar folgende Textalternative; diese Seite verwendet keine
  informationsabhängigen Grafiken.

Damit sind insbesondere WCAG 2.2 AA 1.3.1 (lineare Beziehungen), 1.4.1
(keine reine Farbbedeutung), 2.1.1 (Tastatur), 2.4.6 (Überschriften und Labels),
3.1.2 (Sprachwechsel im bilingualen Textkontext), 3.2.4 (konsistente
Bezeichnung) und 4.1.2 (für die textorientierte Schnittstelle durch stabile
Labels und Exitcodes) berücksichtigt. Zeiger-, Drag-and-drop-, Zeit-, Audio-
und Videokriterien sind `N/A`, weil die CLI diese Interaktionen nicht anbietet.
Eine spätere GUI oder neue Interaktionsform löst eine erneute Prüfung aus.

*The linear labels, keyboard-only operation, color-independent meaning, stable
naming, and exit codes cover the applicable WCAG 2.2 AA criteria. Pointer,
drag-and-drop, timing, audio, and video criteria are N/A for this CLI and must
be reassessed if a graphical or timed interaction is added.*

## Didaktischer Kommentarcheck / Didactic Comment Review

Die neue nicht triviale Logik kommentiert Sicherheitsgrenzen, atomare
Publikation, macOS-Pfadalias und bewusste Denormalisierung. Offensichtliche
Einzelschritte bleiben unkommentiert. Reviewer: Accessibility Reviewer.
Re-Evaluation: jede Änderung an Ausgabe, Begriffen, Reihenfolge, Sprache oder
Interaktionsform.
