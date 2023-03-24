'lineshow.bas
SCREEN 12
CLS
x1 = 10: y1 = 10: x2 = 10: y2 = 10
dx1 = 2: dy1 = 2: dx2 = 3: dy2 = 3
c = 1: n = 0
WHILE INKEY$ = ""
LINE (x1, y1)-(x2, y2), c
x1 = x1 + dx1: y1 = y1 + dy1
x2 = x2 + dx2: y2 = y2 + dy2
IF x1 < 0 OR x1 > 639 THEN dx1 = -dx1
IF y1 < 0 OR y1 > 479 THEN dy1 = -dy1
IF x2 < 0 OR x2 > 639 THEN dx2 = -dx2
IF y2 < 0 OR y2 > 479 THEN dy2 = -dy2
n = n + 1
IF n > 400 THEN c = c + 1
IF n > 400 THEN n = 0
IF c > 15 THEN c = 0
WEND
END

