DECLARE SUB www (x1!, y1!, x2!, y2!, cl!, l!)
SCREEN 13
s$ = "ToyshopStudio1999"
CLS
FOR y = 1 TO 200
    LINE (0, y)-(20, y), y
'    LOCATE 1, 1: PRINT y
'    a$ = INPUT$(1)
NEXT
LOCATE 10, 10
PALETTE 3, 0
COLOR 3
PRINT s$
LINE (20, 50)-(220, 100), 0, B
www 20, 50, 220, 100, 8, 2

SUB www (x1, y1, x2, y2, cl, l)
cc = 32   '16-50
FOR y = y1 TO y2
    FOR x = x1 TO x2
       c = POINT(x, y)
       IF c = 3 THEN PSET (x, y), cc
   NEXT
   cc = cc - 1.7            '.8  1.5   1.6
   IF cc < 16 THEN cc = 32
NEXT
'main()
FOR x = x1 TO x2
   FOR y = y1 TO y2
       c = POINT(x, y)
       IF c <> 0 THEN PSET (x, y - l), cl: y = y2
   NEXT
   FOR y = y2 + l TO y1 STEP -1
       c = POINT(x, y)
'       IF c <> 0 THEN PSET (x, y + l), cl: y = y1
   NEXT
NEXT
FOR y = y1 TO y2
    FOR x = x1 TO x2
       c = POINT(x, y)
       IF c <> 0 THEN PSET (x - l, y), cl: x = x2
   NEXT
    FOR x = x2 + l TO x1 STEP -1
       c = POINT(x, y)
 '      IF c <> 0 THEN PSET (x + l, y), cl: x = x1
   NEXT
NEXT
END SUB

