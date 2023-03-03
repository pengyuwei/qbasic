'Http://quickbasic.126.com/
'Toyshop Studio 2000
DECLARE SUB light (x!, y!, l!)
DECLARE FUNCTION msgbox! (x0!, y0!, title$, msg$)
DECLARE SUB back (x1!, y1!, x2!, y2!, ascii$)
DECLARE SUB help ()
DECLARE SUB w (wt!)
DECLARE SUB big (x1!, y1!, x2!, y2!)
DECLARE SUB black (x1!, y1!, x2!, y2!, c!, c0!)
DECLARE SUB center (y!, say$)
DECLARE SUB menu (x1!, y1!, xl!, yl!, s$, two!)
DIM SHARED getchar AS STRING
DIM SHARED dd AS STRING
x1 = 2: y1 = 11: x2 = 78: y2 = 11 + 7
dosy = CSRLIN
dd = MID$(DATE$, 4, 2)
IF COMMAND$ = "/?" THEN help
IF COMMAND$ <> "/F" THEN
   IF NOT (dd = "25" OR dd = "26") THEN PRINT "Toyshop Studio 1999": END'rem this line when you will run this program
END IF
PCOPY 0, 1
IF COMMAND$ = "/BLUE" THEN black 1, 1, 80, 23, 7, 9
big 1, 1, 80, 23
IF COMMAND$ = "/B" THEN back 2, 3, 79, 23, "ฑ"
black x1 + 2, y1 + 1, x2 + 2, y2 + 1, 8, 0
COLOR 7, 1
FOR i = 2 TO 5
    menu 2, 11, 76, i, "", 1
    w .01
NEXT
menu 2, 11, 76, 7, "Warning!!!", 1
center 14, "Today is {" + dd + "}th."
center 15, "Be careful [CIH] virus!!!"
center 16, "(C) to continue."
center 17, "Press <CTRL>+<ALT>+<DEL> to restart and change CMOS clock to 27."
DO
WHILE a$ <> "C"
 a$ = INKEY$
 light 14, 17, LEN("<CTRL>+<ALT>+<DEL>")
WEND
a$ = ""
PCOPY 0, 2
yn = msgbox(15, 5, "Loading Windows", "Are you sure continue loading Windows98?(Y/N)")
IF yn = 1 THEN
   PCOPY 1, 0
   LOCATE dosy, 1, 1, 1, 12
   END
ELSE
   PCOPY 2, 0
END IF

LOOP

SUB back (x1, y1, x2, y2, ascii$)
a = 1
menu 2, 2, 79, 22, "", 1
FOR y = y1 TO y2
    FOR x = x1 TO x2
        LOCATE y, x
        PRINT MID$(ascii$, a, 1);
        a = a + 1: IF a > LEN(ascii$) THEN a = 1
    NEXT
NEXT
LOCATE 1, 1
COLOR 0, 3
PRINT "   File  Edit  View  Search  Run  Debug  Calls                          F1=Help "
FOR i = 1 TO 80
    a$ = CHR$(SCREEN(1, i))
    IF a$ >= "A" AND a$ <= "Z" THEN COLOR 4, 3: LOCATE 1, i: PRINT a$
NEXT
END SUB

SUB big (x1, y1, x2, y2)
FOR y = y1 TO y2
    FOR x = x1 TO x2
        c = SCREEN(y, x)
        LOCATE y, x
        PRINT UCASE$(CHR$(c));
    NEXT
NEXT
END SUB

SUB black (x1, y1, x2, y2, c, c0)
COLOR c, c0
FOR y = y1 TO y2
    FOR x = x1 TO x2
        c = SCREEN(y, x)
        LOCATE y, x
        PRINT CHR$(c);
    NEXT
NEXT

END SUB

SUB center (y, say$)
LOCATE y, 40 - LEN(say$) / 2
FOR i = 1 TO LEN(say$)
    s$ = MID$(say$, i, 1)
    SELECT CASE s$
     CASE "[": COLOR 10
     CASE "]": COLOR 7
     CASE "{": COLOR 15
     CASE "}": COLOR 7
     CASE "(": COLOR 0
     CASE ")": COLOR 7
     'CASE "<": COLOR 5
     'CASE ">": COLOR 7
     CASE ELSE: PRINT s$;
    END SELECT
NEXT
END SUB

SUB getchr (x0, y0, leng, dis)
STATIC p$, inv, t, music
IF p$ = "" THEN p$ = "_"
IF t = 0 THEN t = TIMER
l = 0
COLOR 7
usetime = TIMER
DO
a$ = INKEY$
IF a$ = CHR$(17) OR a$ = CHR$(0) + CHR$(45) THEN END               '^q || ALT-X
IF a$ = CHR$(19) THEN
   a$ = ""
   music = NOT music     '^s
   IF music THEN onoff$ = "ON" ELSE onoff$ = "OFF"
END IF
'IF a$ = "`" THEN a$ = "": IF p$ = "_" THEN p$ = CHR$(179) ELSE p$ = "_"
IF (a$ >= " " AND a$ <= "z") AND l < leng THEN
   ar = ar + 1
   s$ = s$ + a$
   l = l + 1
   IF dis = 1 THEN LOCATE y0, x0 + l: PRINT a$;
   IF dis = -1 THEN LOCATE y0, x0 + l: PRINT "*";
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
EXIT SUB

position:
inv = NOT inv
IF dis <> 0 THEN
  IF inv THEN LOCATE y0, x0 + l + 1: PRINT p$;
  IF NOT inv THEN LOCATE y0, x0 + l + 1: PRINT " ";
ELSE
  IF inv THEN LOCATE y0, x0 + 1: PRINT p$;
  IF NOT inv THEN LOCATE y0, x0 + 1: PRINT " ";
END IF
t = TIMER
RETURN


END SUB

SUB help
PRINT "@Copydown Toyshop Studio(TM) 1999"
PRINT
PRINT "Warning for CIH virus."
PRINT "/B        show a back ground."
PRINT "/F        force to run."
PRINT "/BLUE     blue back ground."
PRINT "/?        this screen."
PRINT
PRINT "E-mail:Toyshop@263.net"
PRINT
END
END SUB

SUB hline (y, x1, x2)
FOR i = x1 TO x2
    LOCATE y, i
    PRINT CHR$(196);
NEXT

END SUB

SUB light (x, y, l)
STATIC runtime, rundll, g
IF runtime = 0 THEN runtime = TIMER
IF TIMER - runtime < .01 THEN EXIT SUB
'x = 28
'y = 17
FOR i = x TO x + l
    s$ = s$ + CHR$(SCREEN(y, i))
NEXT
SELECT CASE rundll
CASE 0:
       COLOR 5
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
          COLOR 5
          LOCATE y, x + g - 1: PRINT MID$(s$, g, 1)
       END IF
       g = g + 1
       IF g > l THEN rundll = rundll + 1
CASE 2:
       COLOR 5
       LOCATE y, x + l - 1: PRINT MID$(s$, l, 1)
       g = 0
       rundll = 0
       copyrighttime = TIMER
CASE ELSE
END SELECT
runtime = TIMER

END SUB

SUB menu (x1, y1, xl, yl, s$, two)
'c1 = 4: c0 = 3
'cs0 = textcolor: cs1 = backcolor
'COLOR cs0, cs1
IF x1 + xl > 80 THEN x1 = 1: xl = 79
FOR yy = y1 TO y1 + yl
    FOR xx = x1 TO x1 + xl
        LOCATE yy, xx
        PRINT " ";
    NEXT
NEXT
LOCATE y1 + 1, x1 + (xl - LEN(s$)) / 2
COLOR 26, 1: PRINT s$; : COLOR 7, 1
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
       IF two = 2 THEN PRINT "อ";  ELSE PRINT "ฤ";
   NEXT
END IF
'ษออออออออออออออออออออออออออออออออออออออป"
'บ                                      บ"
'ศออออออออออออออออออออออออออออออออออออออผ"
END SUB

FUNCTION msgbox (x0, y0, title$, msg$)
L1 = LEN(title$): L2 = LEN(msg$)
xl = L2 + 4
black x0 + 2, y0 + 1, L2 + 5 + x0, y0 + 4, 8, 0
COLOR 1, 0
FOR x = INT(xl / 2) + 1 TO 1 STEP -1     'show msgbox on MPEG
    FOR y = 1 TO 4
        LOCATE y0 + y - 1, x0 + x - 1
        PRINT CHR$(219);
        LOCATE y0 + y - 1, x0 + xl - x
        PRINT CHR$(219);
    NEXT
    IF RND > .88 THEN w .01
NEXT
'FOR y = 1 TO 4                  'show msgbox
'    LOCATE y0 + y - 1, x0
'    COLOR 1, 0
'    FOR x = 1 TO xl
'       PRINT CHR$(219);
'    NEXT
'NEXT

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
LOCATE y0, x0
COLOR 15, 15
FOR x = 1 TO xl
    PRINT " ";
    'PRINT CHR$(219);
NEXT
COLOR 0
LOCATE y0, x0 + L2 / 2 - L1 / 2: PRINT title$
COLOR 7, 1
LOCATE y0 + 2, x0 + 2: PRINT msg$
DO
a$ = INKEY$
light 14, 17, LEN("<CTRL>+<ALT>+<DEL>")
LOOP UNTIL a$ <> ""
SELECT CASE a$
  CASE "y": msgbox = 1
  CASE "n": msgbox = 0
  CASE ELSE: msgbox = -1
END SELECT
END FUNCTION

SUB sline (x, y1, y2)
FOR i = y1 TO y2
    LOCATE i, x
    PRINT CHR$(179);
NEXT
END SUB

SUB w (wt)
    t = TIMER
    WHILE TIMER - t < wt: WEND
END SUB

