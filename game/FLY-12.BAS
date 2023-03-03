DECLARE SUB drawone (cl!)
DECLARE SUB copyright ()
DECLARE SUB show (x!, y!)
DECLARE SUB getchr (x0!, y0!, leng!, x!, y!, dis!)
DECLARE SUB pause ()
DECLARE SUB menu (x1!, y1!, xl!, yl!, s$, two!, cl!)
DECLARE FUNCTION map! ()
DECLARE SUB drawmap (xx!)
DECLARE SUB posinv (x!, y!)
DECLARE SUB one (x!, y!)
DECLARE SUB initstore ()
CONST false = 0
CONST true = NOT false
CONST backcolor = 0
CONST textcolor = 7
CONST sbackcolor = 4
CONST stextcolor = 0
CONST leng = 9 'box leng
CONST high = 9 'box high
CONST x0 = 4
CONST y0 = 6
DIM SHARED m1(20, 20) AS STRING
DIM SHARED m2(20, 20) AS STRING
DIM SHARED m3(20, 20) AS STRING

DIM SHARED c1(20, 20) AS INTEGER
DIM SHARED c2(20, 20) AS INTEGER
DIM SHARED c3(20, 20) AS INTEGER

DIM SHARED in AS STRING
DIM SHARED flycolor AS INTEGER
DIM SHARED xx(5) AS INTEGER
DIM SHARED which AS INTEGER
DIM SHARED getchar AS STRING
DIM SHARED Mark AS STRING * 1
DIM SHARED passwd AS STRING
DIM SHARED copyrighttime AS DOUBLE
up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
lef$ = CHR$(0) + CHR$(75): righ$ = CHR$(0) + CHR$(77)
x = 5: y = 5
initstore
CLS
menu 1, 1, 65, 18, "Hit Plane on line", 2, 1
menu 68, 1, 11, 8, "", 1, 1
drawmap (xx(1))
drawmap (xx(2))
drawmap (xx(3))
drawone (1)
one x, y
COLOR 8
LOCATE 21, 5: PRINT "Toyshop Studio 1999.6.18 19:26   E-mail:Toyclub@sina.com"'
copyrighttime = TIMER
DO
IF TIMER - copyrighttime > 25 THEN copyright
in = UCASE$(INKEY$)
show x, y
posinv x, y
SELECT CASE in
  CASE CHR$(27): pause
  CASE lef$, "A":
          IF x > 1 THEN
             one x, y
             x = x - 1
             one x, y
          END IF
          IF in = "A" THEN in = " "
  CASE righ$, "D":
          IF x < leng THEN
             one x, y
             x = x + 1
             one x, y
          END IF
          IF in = "D" THEN in = " "
  CASE up$, "W":
          IF y > 1 THEN
             one x, y
             y = y - 1
             one x, y
          END IF
          IF in = "W" THEN in = " "
  CASE down$, "S":
          IF y < high THEN
             one x, y
             y = y + 1
             one x, y
          END IF
          IF in = "S" THEN in = " "
  CASE CHR$(9):  one x, y
                 drawone (0)
                 which = which + 1
                 IF which > 3 THEN which = 1
                 drawone (1)
                 one x, y
  CASE "M", "m":
                LOCATE 6, 69: PRINT "Mark:   ";
                getchr 74, 6, 1, x, y, 1
                Mark = getchar
  CASE "c", "C":
                LOCATE 4, 69: PRINT "Color=   ";
                getchr 74, 4, 2, x, y, 1
                flycolor = VAL(getchar)
                IF flycolor = 0 THEN flycolor = 7
  CASE "x", "X":
                COLOR 7
                LOCATE 2, 69: PRINT "x=  ";
                getchr 70, 2, 1, x, y, 1
                one x, y
                x = VAL(getchar)
                IF x = 0 THEN x = 1
                LOCATE 3, 69: PRINT "y=  ";
                getchr 70, 3, 1, x, y, 1
                one x, y
                y = VAL(getchar)
                IF y = 0 THEN y = 1
  CASE "`": flycolor = 25
  CASE "-": flycolor = 11
  CASE "=": flycolor = 12
  CASE "\": flycolor = 13
  CASE "0": flycolor = 14
  CASE CHR$(8): flycolor = 10
  CASE "1" TO "9": flycolor = VAL(in)
  CASE CHR$(0) + CHR$(45): CLS : LOCATE 11, 1: END 'alt-x
  CASE ELSE
END SELECT
IF in = " " THEN
           SELECT CASE which
             CASE 1: m$ = m1(x, y)
             CASE 2: m$ = m2(x, y)
             CASE 3: m$ = m3(x, y)
           CASE ELSE
           END SELECT
           IF m$ = "0" THEN
              SELECT CASE which
                     CASE 1: m1(x, y) = Mark: c1(x, y) = flycolor
                     CASE 2: m2(x, y) = Mark: c2(x, y) = flycolor
                     CASE 3: m3(x, y) = Mark: c3(x, y) = flycolor
              CASE ELSE
              END SELECT
           ELSE
              SELECT CASE which
                     CASE 1: m1(x, y) = "0": c1(x, y) = 7
                     CASE 2: m2(x, y) = "0": c2(x, y) = 7
                     CASE 3: m3(x, y) = "0": c3(x, y) = 7
              CASE ELSE
              END SELECT
           END IF
END IF
LOOP

CLS

LOCATE 10, 1
END

SUB copyright
STATIC runtime, rundll, g
IF runtime = 0 THEN runtime = TIMER
IF TIMER - runtime < .01 THEN EXIT SUB
x = 5
y = 21
s$ = "Toyshop Studio 1999.6.18 19:26   E-mail:Toyclub@sina.com"
l = LEN(s$)
SELECT CASE rundll
CASE 0:
       COLOR 8
       LOCATE y, x: PRINT s$
       rundll = rundll + 1
CASE 1:
       COLOR 7
       LOCATE y, x + g: PRINT MID$(s$, g + 1, 1)
       IF g < l - 2 THEN
          COLOR 15
          LOCATE y, x + g + 1: PRINT MID$(s$, g + 2, 1)
       END IF
       IF g < l - 3 THEN
          COLOR 7
          LOCATE y, x + g + 2: PRINT MID$(s$, g + 3, 1)
       END IF
       IF g > 0 THEN
          COLOR 8
          LOCATE y, x + g - 1: PRINT MID$(s$, g, 1)
       END IF
       g = g + 1
       IF g > l THEN rundll = rundll + 1
CASE 2:
       COLOR 8
       LOCATE y, x + l - 1: PRINT MID$(s$, l, 1)
       g = 0
       rundll = 0
       copyrighttime = TIMER
CASE ELSE
END SELECT
runtime = TIMER
END SUB

SUB drawmap (xx)
COLOR 3
LOCATE y0 - 1, x0 + 1 + xx
FOR x = 1 TO 9: PRINT HEX$(x); : NEXT
yy = 1
FOR y = 1 TO 9
    LOCATE y + y0 - 1, xx + x0 - 2
    IF y <> 10 THEN COLOR 3: PRINT yy;
    yy = yy + 1
    IF y = 10 THEN yy = 1
    FOR x = 1 TO 9
        SELECT CASE which
          CASE 1: m$ = m1(x, y): c = c1(x, y)
          CASE 2: m$ = m2(x, y): c = c2(x, y)
          CASE 3: m$ = m3(x, y): c = c3(x, y)
          CASE ELSE
       END SELECT
         COLOR c
         PRINT m$;
    NEXT
   
    PRINT
NEXT
END SUB

SUB drawone (cl)
menu xx(which) + x0 - 3, y0 - 2, 14, 12, "", 1, cl
COLOR 7, 0
drawmap (xx(which))
END SUB

SUB getchr (x0, y0, leng, x, y, dis)
STATIC p$, inv, t, music
IF p$ = "" THEN p$ = "_"
IF t = 0 THEN t = TIMER
l = 0
COLOR 7
usetime = TIMER
DO
IF x > 0 AND y > 0 THEN posinv x, y
a$ = INKEY$
IF a$ = CHR$(17) OR a$ = CHR$(0) + CHR$(45) THEN END               '^q || ALT-X
IF a$ = CHR$(19) THEN
   a$ = ""
   music = NOT music     '^s
   IF music THEN onoff$ = "ON" ELSE onoff$ = "OFF"
END IF
IF a$ = "`" THEN a$ = "": IF p$ = "_" THEN p$ = CHR$(179) ELSE p$ = "_"
IF (a$ >= " " AND a$ <= "z") AND l < leng THEN
   ar = ar + 1
   s$ = s$ + a$
   l = l + 1
   IF dis <> 0 THEN LOCATE y0, x0 + l: PRINT a$;
END IF
IF a$ = CHR$(8) AND l >= 1 THEN
  IF dis <> 0 THEN LOCATE y0, x0 + l: PRINT "  ":
  l = l - 1
  s$ = LEFT$(s$, l)
END IF
'IF a$ = CHR$(27) THEN
'   LOCATE y0, x0: PRINT SPACE$(leng);
'   l = 0
'   s$ = ""
'END IF
IF TIMER - t > .1 THEN GOSUB position:
LOOP UNTIL a$ = CHR$(13)
getchar = s$
IF dis <> 0 THEN LOCATE y0, x0 + l + 1: PRINT " ":
'LOCATE y0, 1: PRINT SPACE$(80);
EXIT SUB

position:
inv = NOT inv
IF dis <> 0 THEN
IF inv THEN LOCATE y0, x0 + l + 1: PRINT p$
IF NOT inv THEN LOCATE y0, x0 + l + 1: PRINT " "
END IF
t = TIMER
RETURN

END SUB

SUB initstore
FOR y = 1 TO 9
    FOR x = 1 TO 9
         m1(x, y) = "0"
         m2(x, y) = "0"
         m3(x, y) = "0"
         c1(x, y) = 7
         c2(x, y) = 7
         c3(x, y) = 7
    NEXT
NEXT
flycolor = 10

xx(1) = 2     '3 box's  x
xx(2) = 25
xx(3) = 47
which = 1
Mark = "X"
PRINT "Password:";
getchr POS(0), CSRLIN, 20, 0, 0, 0
passwd = getchar
END SUB

FUNCTION map
SELECT CASE which
 CASE 1: m$ = m1(x, y)
 CASE 2: m$ = m2(x, y)
 CASE 3: m$ = m3(x, y)
 CASE ELSE
END SELECT
map = ASC(m$)
END FUNCTION

SUB menu (x1, y1, xl, yl, s$, two, cl)
'c1 = 4: c0 = 3
cs0 = textcolor: cs1 = backcolor
COLOR cs0, cs1
IF cl = 0 THEN COLOR 0, 0
IF x1 + xl > 80 THEN x1 = 1: xl = 79
'FOR yy = y1 TO y1 + yl
'    FOR xx = x1 TO x1 + xl
'        LOCATE yy, xx
'        PRINT " ";
'    NEXT
'NEXT
LOCATE y1 + 1, x1 + (xl - LEN(s$)) / 2
PRINT s$;
LOCATE y1, x1
IF two = 2 THEN PRINT "ษ";  ELSE PRINT "ฺ";
FOR i = x1 + 1 TO x1 + xl - 1
    LOCATE y1, i
    IF two = 2 THEN PRINT "อ";  ELSE PRINT "ฤ";
    LOCATE y1 + yl, i
    IF two = 2 THEN PRINT "อ";  ELSE PRINT "ฤ";
NEXT
LOCATE y1, x1 + xl
IF two = 2 THEN PRINT "ป" ELSE PRINT "ฟ";
FOR i = y1 + 1 TO y1 + yl - 1
    LOCATE i, x1
    IF two = 2 THEN PRINT "บ";  ELSE PRINT "ณ";
    LOCATE i, x1 + xl
    IF two = 2 THEN PRINT "บ";  ELSE PRINT "ณ";
NEXT
LOCATE y1 + yl, x1
IF two = 2 THEN PRINT "ศ" ELSE PRINT "ภ";
LOCATE y1 + yl, x1 + xl
IF two = 2 THEN PRINT "ผ" ELSE PRINT "ู";
'
IF s$ <> "" THEN
LOCATE y1 + 2, x1 + 1
PRINT "ว";
FOR i = x1 + 1 TO x1 + xl - 1
    LOCATE y1 + 2, i
    PRINT "ฤ";
NEXT
END IF
'ษออออออออออออออออออออออออออออออออออออออป"
'บ                                      บ"
'ศออออออออออออออออออออออออออออออออออออออผ"


END SUB

SUB one (x, y)
SELECT CASE which
 CASE 1: m$ = m1(x, y): c = c1(x, y)
 CASE 2: m$ = m2(x, y): c = c2(x, y)
 CASE 3: m$ = m3(x, y): c = c3(x, y)
 CASE ELSE
END SELECT
IF m$ = "0" THEN COLOR 7 ELSE COLOR c
LOCATE y + y0 - 1, x + x0 + xx(which)
PRINT m$;
END SUB

SUB pause
PCOPY 0, 1
CLS
LOCATE 10, 10
PRINT "Password:";
DO
getchr POS(0), CSRLIN, 20, 0, 0, 0
IF getchar = passwd THEN EXIT DO
LOOP
CLS
PCOPY 1, 0
END SUB

SUB posinv (x, y)
STATIC p$, inv, t
IF p$ = "" THEN p$ = CHR$(219)
IF t = 0 THEN t = TIMER

IF TIMER - t < .1 THEN EXIT SUB
inv = NOT inv
IF inv THEN LOCATE y0 + y - 1, x0 + x + xx(which): PRINT p$;
SELECT CASE which
 CASE 1: m$ = m1(x, y): c = c1(x, y)
 CASE 2: m$ = m2(x, y): c = c2(x, y)
 CASE 3: m$ = m3(x, y): c = c3(x, y)
 CASE ELSE
END SELECT
IF m$ = "0" THEN COLOR 7 ELSE COLOR c
IF NOT inv THEN LOCATE y0 + y - 1, x0 + x + xx(which): PRINT m$;
t = TIMER
END SUB

SUB show (x, y)
COLOR 7
LOCATE 2, 69: PRINT "x="; x;
LOCATE 3, 69: PRINT "y="; y;
LOCATE 5, 69: PRINT "box "; which;
LOCATE 6, 69: PRINT "Mark: "; Mark;
LOCATE 8, 69: PRINT TIME$
LOCATE 22, 69: PRINT "ALT-X QUIT"
COLOR flycolor
LOCATE 4, 69: PRINT "Color="; flycolor;
END SUB

