# Contract: Profile and Registry Evidence

## Profile Resolution

Der Profilname wird im Profilkatalog nachgeschlagen. Die referenzierte
Preset-Konfiguration muss innerhalb der Level-0-Quelle liegen und valide sein.
Preset-IDs und Anzahl werden aus den Daten abgeleitet. Ein zusätzliches
gültiges Preset benötigt keine Programmänderung.

## Registry Consistency

Die Prüfung vergleicht normalisierte Primärsprache, bekannten Sprachtyp und
deklarierten MSL-Status. Sie unterscheidet `Pass`, `Conflict` und
`JustifiedException`.

## Mutation Boundary

Die Registry bleibt bytegleich. Ein Konflikt nennt Repository, Sprache,
deklarierten Zustand, erwartete Klasse und eine Owner-Aktion. Es gibt keine
stille Korrektur und keinen Ziel-Commit, Push, Pull Request oder Merge.
