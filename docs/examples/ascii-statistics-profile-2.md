# ASCII-Statistikprofil 2 / ASCII Statistics Profile 2

Diese Beispiele sind visuelle Akzeptanzfixtures fuer den Statistikrenderer.
Zahlen, Skalen und Textalternativen muessen aus Repositorydaten berechnet
werden; die Darstellung darf nicht allein durch Farbe oder Symboldichte wirken.

*These examples are visual acceptance fixtures for the statistics renderer.
Values, scales, and text alternatives must be derived from repository data;
the presentation must not rely on color or symbol density alone.*

## Tagesaktivitaet / Daily Activity

```text
Wochen / Weeks 01..09 | 2026-05-24..2026-07-25
So/Su  0 2 0 4 0 4 4 4 4
Mo/Mo  0 0 0 0 0 4 4 4 -
Di/Tu  3 0 0 0 0 2 4 4 -
Mi/We  0 1 0 4 0 4 4 4 -
Do/Th  2 1 4 0 0 2 4 3 -
Fr/Fr  2 2 1 4 2 3 4 3 -
Sa/Sa  0 0 0 4 4 4 4 4 -
```

**DE:** `0 = keine Aenderung`, `1 = 1..79`, `2 = 80..399`,
`3 = 400..1599`, `4 = 1600+ geaenderte Textzeilen`,
`- = noch nicht abgelaufen`.

**EN:** `0 = no change`, `1 = 1..79`, `2 = 80..399`,
`3 = 400..1599`, `4 = 1600+ changed text lines`, `- = not elapsed`.

## Beschleunigung / Acceleration

```text
Scale: 0..100x
80 lines/day       [###########.........] 52.7x
100 lines/day      [########............] 42.1x
```

**DE:** Exakte Zahlen bleiben die primaere Aussage. Die Balken zeigen die
relative Position beider Werte innerhalb derselben Skala.

**EN:** Exact values remain the primary result. The bars show the relative
position of both values within the same scale.

## Phasen und kumulativer Verlauf / Phases and Cumulative Development

```text
Phasenvolumen / Phase volume
   cap 3600 | . . . #
        3000 | # . # #
        2500 | # # # #
        2000 | # # # #
           0 +---------
             00 01 02 03
```

```text
Kumulative Entwicklung / Cumulative development
  cap 15000 | . . . .
       10000 | . . . #
        7500 | . . # #
        5000 | . # # #
        2500 | # # # #
           0 +---------
             00 01 02 03
```

**DE:** Das erste Diagramm vergleicht einzelne Einheiten. Das zweite zeigt
ihren laufend aufsummierten Umfang. Eine begleitende Tabelle nennt immer die
genauen Werte.

**EN:** The first chart compares individual units. The second shows their
running total. A companion table always provides exact values.
