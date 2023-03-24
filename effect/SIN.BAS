'Don't remove these rem line..................................................
'Download from http://toyshop.cc.st
'E-mail:toyclub@sina.com
'Produce by FFB
'..............................................................................
SCREEN 12
    LINE (1, 8)-(600, 8), 3
    LINE (1, 390)-(600, 390), 3
DO
FOR x = 1 TO 600
    IF INKEY$ = CHR$(27) THEN GOTO a:
    y = 177 * COS(x * 150 + 50) + 200
    FOR r = 1 TO 15
    CIRCLE (x, y), r, 2
    NEXT
    CIRCLE (x, y), 15, 0
NEXT

LOOP WHILE INKEY$ = ""
a:
CLS
SCREEN 12
    LINE (1, 8)-(600, 8), 3
    LINE (1, 390)-(600, 390), 3
DO
FOR x = 1 TO 600
    y = 50 * TAN(x * 150) + 200
    FOR r = 1 TO 15
    CIRCLE (x, y), r, 2
    NEXT
    CIRCLE (x, y), 15, 0
NEXT

LOOP WHILE INKEY$ = ""


m:
CLS
x1 = 550
FOR x = 100 TO 325
    y = 84 * SIN(x * (.02)) + 200
    y1 = y: x1 = x1 - 1
    FOR r = 1 TO 10
        CIRCLE (x, y), r, 2
    NEXT
    FOR r = 1 TO 10
        CIRCLE (x1, y1), r, 2
    NEXT
    FOR t = 0 TO 100: NEXT
NEXT
'''''''''''''''''''''''''''''''''''
FOR r = 1 TO 640
    CIRCLE (2, 1), r, 0
NEXT
FOR r = 1 TO 640
    CIRCLE (639, 1), r, 0
NEXT
'----------------------------------------------------------
CLS
FOR x = 1 TO 640
    y = 84 * SIN(x * (.02)) + 200
    FOR r = 1 TO 10
        CIRCLE (x, y), r, 2
    NEXT
NEXT
DO
FOR x = 1 TO 640
    y = 84 * SIN(x * (.02)) + 200
    FOR r = 1 TO 10
        CIRCLE (x, y), r, 2
    NEXT
    FOR r = 1 TO 10
        CIRCLE (x, y), r, 0
    NEXT

NEXT
LOOP WHILE INKEY$ = ""

