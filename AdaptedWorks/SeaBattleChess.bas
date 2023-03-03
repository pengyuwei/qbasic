DECLARE SUB flash ()
DECLARE SUB clk ()
DECLARE SUB palete (c%)
DECLARE SUB drawline (a%)
DECLARE SUB Pspace ()
DIM SHARED p, p0, n, n0, m, x, y, c, x0, y0
p = 0: n = 1: n0 = 1: m = n0
DIM SHARED a1(120), a2(120), a3(50), a4(299)
CLS : SCREEN 12
LOCATE 2, 20: COLOR 5: PRINT "Flying bomb(Toyshop Changed 2000.4.21)"
DO
FOR i = 1 TO 10: a3(i) = -1: NEXT i
RANDOMIZE TIMER
FOR j = 1 TO n0: a4(j) = INT(RND * 100): NEXT j
LINE (50, 80)-(349, 379), 2, BF
FOR i = 0 TO 99: x = INT(i / 10): y = i - x * 10: LINE (x * 30 + 50, y * 30 + 80)-STEP(29, 29), 0, B: NEXT i
GET (50, 80)-(79, 109), a1 'box
'draw zhun xing
CIRCLE (65, 95), 7, 1: LINE (55, 95)-(75, 95), 1: LINE (65, 85)-(65, 105), 1: GET (50, 80)-(79, 109), a2
x0 = 50: y0 = 80: p0 = p
COLOR 7: LOCATE 6, 50: PRINT "Report:"
LOCATE 7, 50: PRINT "Found object: " + STR$(n0)
LOCATE 8, 50: PRINT "Mission:Destory all object."
PALETTE 10, 0
DO
w$ = INKEY$
SELECT CASE w$
   CASE CHR$(0) + "H": IF p >= 1 THEN p = p - 1
   CASE CHR$(0) + "P": IF p <= 98 THEN p = p + 1
   CASE CHR$(0) + "K": IF p >= 10 THEN p = p - 10
   CASE CHR$(0) + "M": IF p <= 89 THEN p = p + 10
   CASE " ": Pspace
   CASE CHR$(27): m = -1: EXIT DO
   CASE ELSE
 END SELECT
 IF p <> p0 THEN
 c = INT(p / 10): x = c * 30 + 50: y = (p - c * 10) * 30 + 80
 SELECT CASE p
    CASE a3(1), a3(2), a3(3), a3(4), a3(5), a3(6), a3(7), a3(8), a3(9), a3(10)
     PUT (x0, y0), a1, PSET: GET (x, y)-(x + 29, y + 29), a1
     PUT (x, y), a2, XOR
   CASE ELSE
     PUT (x0, y0), a1, PSET: GET (x, y)-(x + 29, y + 29), a1
     PUT (x, y), a2, PSET
 END SELECT
 x0 = x: y0 = y: p0 = p: w$ = ""
 END IF
 flash
LOOP UNTIL n = 51 OR m = 0

IF m = 0 THEN
   COLOR 10
   LOCATE 20, 50: PRINT "Mission accomplish!"
   n0 = n0 + 1: m = n0: n = 1: p = 0
   palete 45
ELSE
   IF m <> -1 THEN
      COLOR 10
      LOCATE 20, 50: PRINT "Mission failed!"
      m = n0: p = 0: n = 1
      palete 45
   END IF
END IF

z$ = INPUT$(1): z$ = UCASE$(z$)
FOR t = 9 TO 20: LOCATE t, 50: PRINT SPACE$(25): NEXT t
IF m <> -1 THEN palete 0
LOOP UNTIL n0 = 9 OR z$ = "Q" OR z$ = "q" OR z$ = CHR$(27)

SELECT CASE n0
CASE 1: LOCATE 18, 50: PRINT "You are foolish.(1)"
CASE 2: LOCATE 18, 50: PRINT "You are Microsoft.(2)"
CASE 3: LOCATE 18, 50: PRINT "You are dog (3)"
CASE 4: LOCATE 18, 50: PRINT "(4)"
CASE 5: LOCATE 18, 50: PRINT "(5)"
CASE 6: LOCATE 18, 50: PRINT "(6)"
CASE 7: LOCATE 18, 50: PRINT "You are you(7)"
CASE 8: LOCATE 18, 50: PRINT "You are COMMAND&CONQUER(8)"
CASE ELSE:
END SELECT
clk
z$ = INPUT$(1)
END

SUB clk
WHILE INKEY$ <> "": WEND
END SUB

SUB drawline (dd AS INTEGER)
FOR i = 1 TO dd
    PRINT CHR$(254);
NEXT
FOR i = dd TO 5
    PRINT " ";
NEXT
END SUB

SUB flash
STATIC r, add
IF r = 0 THEN r = 40
IF add = 0 THEN add = 1
PALETTE 4, 65535 * r + 256 * r + r
IF r > 40 OR r < 10 THEN add = -add
r = r + add
END SUB

SUB palete (c AS INTEGER)
SELECT CASE c
CASE 0:
FOR i = 45 TO 0 STEP -1
    PALETTE 10, 65535 * i + 256 * i + i
    t = TIMER
    WHILE TIMER - t < .01: WEND
    flash
NEXT
CASE ELSE:
FOR i = 0 TO 45
    PALETTE 10, 65535 * i + 256 * i + i
    t = TIMER
    WHILE TIMER - t < .01: WEND
    flash
NEXT
END SELECT
COLOR 7
clk
END SUB

SUB Pspace
LOCATE 9, 50: PRINT "You send " + STR$(n);
LINE (519, 129)-(571, 141), 1, B
LINE (520, 130)-(520 + n, 140), 4, BF
'WHILE INKEY$ = ""
FOR i = 0 TO 14: CIRCLE (x0 + 15, y0 + 15), i, 4: NEXT i
PUT (x0, y0), a1, PSET
'flash
'WEND
PAINT (x0 + 15, y0 + 15), 4, 0
a3(n) = p: n = n + 1: GET (x0, y0)-(x0 + 29, y0 + 29), a1
FOR j = 1 TO n0
IF p = a4(j) THEN
m = m - 1: k = j: a4(j) = -1
LOCATE 10 + j, 50: PRINT SPACE$(25)
LOCATE 10 + j, 50: PRINT STR$(j) + " destoryed"
LINE (x0, y0)-(x0 + 29, y0 + 29), 0
LINE (x0 + 29, y0)-(x0, y0 + 29), 0
GET (x0, y0)-(x0 + 29, y0 + 29), a1
ELSE
IF a4(j) <> -1 THEN
x1 = INT(a4(j) / 10): y1 = a4(j) - x1 * 10
x2 = c: y2 = p0 - c * 10
dd = INT(SQR((x1 - x2) ^ 2 + (y1 - y2) ^ 2))
SELECT CASE dd
CASE 1: jg$ = "Bomb"
CASE 2: jg$ = "fire"
CASE 3: jg$ = "Warning"
CASE 4: jg$ = "Afraid"
CASE ELSE: jg$ = "None!"
END SELECT
LOCATE 10 + j, 50: PRINT SPACE$(25)
LOCATE 10 + j, 50: PRINT "Object:" + STR$(j) + " " + jg$ + ""; : drawline (dd)
END IF
END IF
NEXT j

END SUB

