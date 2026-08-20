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

- Die Reihenfolge ist immer: `Profil / Profile`, `Entscheidung / Decision`,
  `Status`, `Blocker`, `Naechste Aktion / Next action`, Gate-Set-Hash,
  Einzelschritte und Evidence-Ziel.
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

## Didaktischer Kommentarcheck / Didactic Comment Review

Die neue nicht triviale Logik kommentiert Sicherheitsgrenzen, atomare
Publikation, macOS-Pfadalias und bewusste Denormalisierung. Offensichtliche
Einzelschritte bleiben unkommentiert. Reviewer: Accessibility Reviewer.
Re-Evaluation: jede Änderung an Ausgabe, Begriffen, Reihenfolge, Sprache oder
Interaktionsform.
