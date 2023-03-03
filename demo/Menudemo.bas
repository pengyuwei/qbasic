DECLARE SUB drawone (a!)
DECLARE SUB clm ()
DECLARE SUB drawmenu ()
DECLARE SUB initstore ()
DECLARE SUB clr ()
DECLARE SUB menu (x1!, y1!, xl!, yl!, s$, two)
DIM SHARED main(10) AS STRING
DIM SHARED mainx(10) AS INTEGER
DIM SHARED m(20, 20) AS STRING * 15
DIM SHARED ml(10) AS INTEGER
DIM SHARED mx(10) AS INTEGER
DIM SHARED x AS INTEGER
DIM SHARED y AS INTEGER
DIM SHARED c0 AS INTEGER     'menu color
DIM SHARED c1 AS INTEGER
DIM SHARED cs0 AS INTEGER  'select color
DIM SHARED cs1 AS INTEGER

up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
lef$ = CHR$(0) + CHR$(75): righ$ = CHR$(0) + CHR$(77)
initstore
CLS
clm
FOR i = 1 TO 80
    a$ = CHR$(SCREEN(1, i))
    COLOR 0, cs1
    IF a$ >= "A" AND a$ <= "Z" THEN COLOR cs0, cs1
    LOCATE 1, i
    PRINT a$;
NEXT
x = 1: x0 = 8
y = 2: y0 = 12
drawmenu
drawone (1)
DO
in$ = INKEY$
IF in$ = righ$ AND x < x0 THEN
   clm
   drawone (1)
   clm
   x = x + 1
   y = 2
   drawmenu
   drawone (1)
   y0 = ml(x)
END IF
IF in$ = lef$ AND x > 1 THEN
   clm
   drawone (0)
   clm
   x = x - 1
   y = 2
   drawmenu
   drawone (1)
   y0 = ml(x)
END IF
IF in$ = down$ AND y < y0 + 1 THEN drawone (0): y = y + 1: drawone (1)
IF in$ = up$ AND y > 2 THEN drawone (0): y = y - 1: drawone (1)
IF in$ = CHR$(13) AND x = 1 AND y - 1 = y0 THEN END
'LOCATE 20, 1
'PRINT "y="; y, "x="; x
'PRINT "ml="; ml(x), "Mx="; mx(x)
'PRINT "y0="; y0
LOOP

SUB clm
COLOR 7, 0
VIEW PRINT 2 TO 20
CLS
VIEW PRINT
COLOR c1, c0
LOCATE 1, 1: clr
FOR i = 1 TO 8
    LOCATE 1, mainx(i)
    COLOR 0, c0
    PRINT main(i);
NEXT
FOR i = 1 TO 80
    a$ = CHR$(SCREEN(1, i))
    COLOR 0, c0
    IF a$ >= "A" AND a$ <= "Z" THEN COLOR cs0, cs1
    LOCATE 1, i
    PRINT a$;
NEXT

END SUB

SUB clr
FOR i = POS(0) TO 80
PRINT " ";
NEXT
END SUB

SUB drawmenu
a = mainx(x) - 2
B = ml(x) + 1
menu a, 2, 16, B, " ", 1
FOR i = 3 TO ml(x) + 2
    LOCATE i, mx(x) + 1
    COLOR 0, c0
    PRINT m(x, i - 2);
NEXT
COLOR cs0, cs1
'LOCATE 1, mx(x) + 1
'PRINT "ณ"
'LOCATE 1, mx(x) + LEN(main(x)) + 2
'PRINT "ณ"
COLOR 15, 0
LOCATE 1, mx(x) + 1
PRINT " "; main(x); " ";

END SUB

SUB drawone (a)
'drawmenu
   LOCATE y + 1, mx(x) + 1
   COLOR cs1, cs0
   IF a = 0 THEN COLOR 0, cs1
   PRINT m(x, y - 1);
END SUB

SUB initstore
c0 = 7
c1 = 0
cs0 = 1
cs1 = 7

main(1) = "File"
main(2) = "Edit"
main(3) = "View"
main(4) = "Search"
main(5) = "Run"
main(6) = "Debug"
main(7) = "Calls"
main(8) = "Help"
mainx(1) = 3
FOR i = 2 TO 8
    mainx(i) = LEN(main(i - 1)) + mainx(i - 1) + 2
NEXT
'mainx(8) = 70
ml(1) = 12: mx(1) = 1
m(1, 1) = " New Program"
m(1, 2) = " Open Program"
m(1, 3) = " Merge"
m(1, 4) = " Save"
m(1, 5) = " Save As"
m(1, 6) = " Save all"
m(1, 7) = " Print"
m(1, 8) = " Load file"
m(1, 9) = " Unload file"
m(1, 10) = " Close"
m(1, 11) = " Dos shell"
m(1, 12) = " Exit"

ml(2) = 8: mx(2) = 7
m(2, 1) = " Undo"
m(2, 2) = " Cut"
m(2, 3) = " Copy"
m(2, 4) = " Paste"
m(2, 5) = " Clear"
m(2, 6) = " New Sub"
m(2, 7) = " New Function"
m(2, 8) = " Syntax Checking"
ml(3) = 6: mx(3) = 13
m(3, 1) = " Subs"
m(3, 2) = " Cut"
m(3, 3) = " Copy"
m(3, 4) = " Paste"
m(3, 5) = " Clear"
m(3, 6) = " New Sub"
m(4, 1) = "Find"
ml(4) = 1: mx(4) = mainx(4) - 2
m(5, 1) = "Start"
ml(5) = 1: mx(5) = mainx(5) - 2
m(6, 1) = "Trace"
ml(6) = 1: mx(6) = mainx(6) - 2
m(7, 1) = "*.bas"
ml(7) = 1: mx(7) = mainx(7) - 2
m(8, 1) = "Index"
ml(8) = 1: mx(8) = mainx(8) - 2
END SUB

SUB menu (x1, y1, xl, yl, s$, two)
'c1 = 4: c0 = 3
COLOR cs0, cs1
IF x1 + xl > 70 THEN x1 = 70: xl = 10
FOR yy = y1 TO y1 + yl
    FOR xx = x1 TO x1 + xl
        LOCATE yy, xx
        PRINT " ";
    NEXT
NEXT
'LOCATE y1 + 1, x1 + 1
'PRINT s$
LOCATE y1, x1
IF two = 2 THEN PRINT "ษ";  ELSE PRINT "ฺ";
FOR i = x1 + 1 TO x1 + xl - 1
    LOCATE y1, i
    IF two = 2 THEN PRINT "อ";  ELSE PRINT "ฤ";
    LOCATE y1 + yl, i
    IF two = 2 THEN PRINT "อ";  ELSE PRINT "ฤ";
NEXT
LOCATE y1, x1 + xl
IF two = 2 THEN PRINT "ป" ELSE PRINT "ฟ"
FOR i = y1 + 1 TO y1 + yl - 1
    LOCATE i, x1
    IF two = 2 THEN PRINT "บ";  ELSE PRINT "ณ";
    LOCATE i, x1 + xl
    IF two = 2 THEN PRINT "บ";  ELSE PRINT "ณ";
NEXT
LOCATE y1 + yl, x1
IF two = 2 THEN PRINT "ศ" ELSE PRINT "ภ"
LOCATE y1 + yl, x1 + xl
IF two = 2 THEN PRINT "ผ" ELSE PRINT "ู"
'
'LOCATE y1 + 2, x1 + 1
'PRINT "ว"
'FOR i = x1 + 1 TO x1 + xl - 1
'    LOCATE y1 + 2, i
'    PRINT "ฤ";
'NEXT

'ษออออออออออออออออออออออออออออออออออออออป"
'บ                                      บ"
'ศออออออออออออออออออออออออออออออออออออออผ"



END SUB

