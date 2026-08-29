# Barrierefreiheit der Copilot-Review-Governance

## Deutsch

Die Bedienoberfläche ist textorientiert und wird nach WCAG 2.2 Level AA
geprüft, soweit Kriterien auf eine CLI anwendbar sind. Entscheidungen folgen
linear der Reihenfolge `Repository -> Default Branch -> Zustand -> geplante
Aktion -> Ergebnis -> Blocker -> nächste sichere Aktion`. Farbe, Cursorposition,
Animation und räumliche Anordnung sind keine Bedeutungsträger.

- Tastatur: Alle Funktionen sind ohne Zeigegerät über Parameter erreichbar.
- Screenreader: stabile Bezeichnungen, vollständige Wörter und lineare Ausgabe.
- Braille: ASCII-Pfeile und maschinenlesbares JSON bleiben vollständig nutzbar.
- Textbrowser: Manpage, Quickstart und Evidence benötigen kein Skript im Browser.
- Sprache: Deutsch steht vor Englisch; technische Tokens bleiben stabil.
- Textalternativen: Zählwerte, Status und nächste Aktion werden ausgeschrieben.

Visuelle Kriterien zu Video, Zeigergesten, Hover oder Animation sind `N/A`, weil
kein grafisches UI erzeugt wird. Das ist keine stille Auslassung. Restrisiko:
Terminal- und Screenreader-Kombinationen können Wörter unterschiedlich
segmentieren. Owner: A11Y Owner; Reviewer: A11Y Reviewer. Re-Evaluation bei
Ausgabe-, Parameter-, Sprach-, Terminal- oder Evidence-Schemaänderung.

## English

The CLI is assessed against applicable WCAG 2.2 AA criteria. Every function is
keyboard accessible, output is linear and independent of colour, and JSON is
available to screen readers, Braille displays, and text browsers. Visual-only
criteria are explicitly not applicable because no graphical UI is produced.
Re-evaluate after output, parameter, language, terminal, or schema changes.
