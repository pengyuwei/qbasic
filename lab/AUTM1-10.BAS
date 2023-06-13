DECLARE FUNCTION center! (wc$)
DECLARE SUB light ()
DECLARE SUB menuit (x1!, y1!, xl!, yl!, s$, two!, fen!)
DECLARE SUB posinv (x0!, y0!)
DECLARE SUB scrpro ()
DECLARE SUB pause ()
DECLARE SUB say (s$)
DECLARE SUB clr ()
DECLARE SUB drawmenu ()
DECLARE SUB drawone ()
DECLARE SUB initstore ()
DIM SHARED menu(20) AS STRING '* 40
DIM SHARED about(20) AS STRING * 70
DIM SHARED leng AS INTEGER
DIM SHARED y AS INTEGER
DIM SHARED dosy AS INTEGER
DIM SHARED dosx AS INTEGER
DIM SHARED fontcolor
DIM SHARED fontbackcolor
CONST true = -1
CONST false = 0
CONST c0 = 1    '3
CONST c = 7      '0
CONST x = 5
fontcolor = 7
fontbackcolor = 0
dosy = CSRLIN
dosx = POS(0)
RANDOMIZE TIMER
initstore
up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
PCOPY 0, 1
IF COMMAND$ <> "" THEN
   OPEN "c:\Boot.txt" FOR OUTPUT AS #1 LEN = 10
        PRINT #1, DATE$, TIME$
        FOR dy = 1 TO 24
            scr$ = ""
            FOR dx = 1 TO 80
                temp$ = CHR$(SCREEN(dy, dx))
                IF temp$ = "," THEN temp$ = CHR$(1)
                scr$ = scr$ + temp$
            NEXT
            PRINT #1, scr$
        NEXT
   CLOSE
   autoend = true
ELSE
   autoend = false
END IF
CLS
PRINT "1 system processer at 80486DX-2,system clock is "; DATE$; " "; LEFT$(TIME$, 5)
PRINT "Free memory is "; FRE(-1); "  Stack space is "; FRE(-2)
PRINT
PRINT "#201 Windows97 MS-DOS PROMPT Menu:"
y0 = CSRLIN
menuit 1, y0, 70, leng + 1, "", two, fen
drawmenu
a$ = COMMAND$
IF VAL(a$) <= 10 AND VAL(a$) >= 1 THEN y = VAL(a$) ELSE y = 10
drawone
  
   an = y
   FOR i = 1 TO an
       drawmenu
       y = i
       drawone
       FOR t = 0 TO 12999: NEXT
   NEXT


loadtime = TIMER
autoendtime = 10
scrprotime = TIMER   'screen protect after 15 seconds
DO
LOCATE 2, 1
PRINT "Free memory is "; FRE(-1); "  Stack space is "; FRE(-2)
a$ = INKEY$
IF a$ <> "" THEN
   autoend = flase
   LOCATE 3, 40: clr
   scrprotime = TIMER
END IF
IF a$ = "d" THEN PCOPY 0, 5: PCOPY 1, 0: a$ = INPUT$(1): PCOPY 5, 0
IF LCASE$(a$) = "m" THEN
   SELECT CASE a$
   CASE "m"
       PCOPY 0, 3
       CLS
       SHELL "mem"
       a$ = INPUT$(1)
       CLS
       PCOPY 3, 0
   CASE "M"
       PCOPY 0, 3
       CLS
       SHELL "mem/c/p"
       a$ = INPUT$(1)
       CLS
       PCOPY 3, 0
   CASE ELSE
   END SELECT
END IF
IF a$ = "`" THEN
   fontbackcolor = 1
   fontcolor = 7
   menuit 1, y0, 70, leng + 1, "", two, fen
   drawmenu
   drawone
END IF
IF a$ = up$ THEN
   drawmenu
   y = y - 1
   IF y < 1 THEN y = leng
   drawone
END IF
IF a$ = down$ THEN
   drawmenu
   y = y + 1
   IF y > leng THEN y = 1
   drawone
END IF

IF (VAL(a$) >= 1 AND VAL(a$) <= leng) OR a$ = CHR$(27) THEN
   an = VAL(a$)
   IF an > y THEN s = 1 ELSE s = -1
   IF a$ = CHR$(27) THEN s = 1: an = leng
   FOR i = y TO an STEP s
       drawmenu
       y = i
       drawone
       FOR t = 0 TO 17999: NEXT
   NEXT
END IF
COLOR 7, 0: LOCATE y0 + 2 + leng, 60: PRINT TIME$
IF autoend THEN
   COLOR 7, 0: LOCATE 3, 60: PRINT USING "## second"; autoendtime - INT(TIMER - loadtime)
   IF TIMER - loadtime > autoendtime THEN PCOPY 1, 0: LOCATE dosy, dosx: END
END IF
IF a$ = CHR$(13) THEN
   COLOR 3
   LOCATE 19, 1
   SELECT CASE y
   CASE 1
       PRINT "d:"
       PRINT "cd\tc"
       PRINT "tc.exe"
       pause
       SHELL "d:"
       SHELL "cd\tc"
       RUN "tc.exe"
       END
   CASE 2
       PRINT "cd d:\basic\qb"
       PRINT "qb.exe"
       pause
       SHELL "d:"
       SHELL "cd\basic\qb"
       RUN "qb.exe"
       END
   CASE 3
       PRINT "cd\dos"
       PRINT "b.exe"
       pause
       'CLS
       'LOCATE 6, 1
       'PRINT "Hot key:": PRINT
       'PRINT "'Enter'-start      '['-select": PRINT
       'say "  2P                               1P             "
       'say "  [W]                                [UP]          "
       'say "[A]   [D]   [F]-Fire                 [LEFT]  [RIGHT]    [Ins]-Fire"
       'say "  [S]     [G]-Jump                    [DOWN]        [Del]-Jump"
       'PRINT
       'say "[ALT+Q]-EXIT GAME                  [ALT+R]-Reset game"
       'say "TYPE '{Fc}' to run nesticle"
       RUN "c:\dos\b.exe"
       END
   CASE 4
       PRINT "cd d:cai\happy6"
       pause
       SHELL "d:"
       SHELL "cd\cai\happy6"
       PCOPY 1, 0: LOCATE dosy, dosx
       say ("TYPE '[CAI]' to run")
       END
   CASE 5
       PRINT "cd d:\cai\xdz"
       pause
       SHELL "d:"
       SHELL "cd\cai\xdz"
       PCOPY 1, 0: LOCATE dosy, dosx
       say ("TYPE '[CAI]' to run")
       END
   CASE 6
       PRINT "c:\dos\word.exe"
       pause
       RUN "c:\dos\word.exe"
       END
   CASE 7
       CHDIR "c:\windows"
       PCOPY 1, 0: LOCATE dosy, dosx
       say "If you are in Windows then type '[exit]'to return to Windows,else"
       say ("TYPE '{WIN}' to run Windows 97")
       END
   CASE 8
       PRINT "c:\dos\snow.exe"
       pause
       RUN "c:\dos\snow.exe"
   CASE 9
       PRINT "c:\dos\t.exe"
       pause
       RUN "c:\dos\t.exe"
   CASE 10
       PCOPY 1, 0: LOCATE dosy, dosx
       END
   CASE ELSE
   END SELECT
END IF
LOCATE 8 + leng, 1: PRINT USING "Now,you selected:## "; y; : px = POS(0): py = CSRLIN
IF TIMER - scrprotime > 15 THEN scrpro: scrprotime = TIMER
posinv px, py
LOOP

FUNCTION center (wc$)
center = 30 - LEN(wc$) / 2
END FUNCTION

SUB clr
FOR i = POS(0) TO 80
    PRINT " ";
NEXT
END SUB

SUB drawmenu
COLOR fontcolor, fontbackcolor
FOR i = 1 TO leng
    LOCATE 5 + i, center(menu(i))
    PRINT STR$(i); "."; menu(i);
NEXT
END SUB

SUB drawone
LOCATE y + 5, center(menu(y))
COLOR c, c0
PRINT STR$(y); "."; menu(y)
COLOR fontcolor, fontbackcolor
LOCATE 24, 1: PRINT about(y);
END SUB

SUB initstore
leng = 10
menu(1) = "TurboC 2.0 "
menu(2) = "Quick Basic 4.0 "
menu(3) = "Game  "
menu(4) = "DosCai  "
menu(5) = "hand CAI  "
menu(6) = "Word exercise  "
menu(7) = "Windows 97 OEM VER "
menu(8) = "Screen protect. 1(snow) "
menu(9) = "Screen protect. 2(BMOB) "
menu(10) = "Exit to DOS"

about(1) = "Boland Turbo C 2.0               C:\CAI\TC"
about(2) = "Microsoft Quick Basic 4.0        C:\BASIC\QB "
about(3) = "I love this game!                C:\GAME\FC"
about(4) = "Tell you how to use DOS          C:\CAI\Happy6"
about(5) = "Keyboard CAI                     C:\CAI\Xdz"
about(6) = "A Toyshop's soft                 C:\DOS\WORD"
about(7) = "This Windows 97 OEM OSR/2        C:\Windows"
about(8) = "Toyshop 's snow                  C:\DOS\S.EXE"
about(9) = "Toyshop's screen protect         C:\DOS\T.EXE"
about(10) = "Exit to DOS"

END SUB

SUB light
PCOPY 0, 2
x1 = 1: x2 = 80: x0 = 1

FOR ly = 1 TO yy
    FOR lx = 1 TO 80
        s$ = CHR$(SCREEN(ly, lx))
        IF LCASE$(COMMAND$) <> "loop" THEN COLOR 8
        LOCATE ly, lx
        PRINT s$;
    NEXT
NEXT
FOR lx = x1 TO x2 STEP x0
    FOR ly = 1 TO yy
        s$ = CHR$(SCREEN(ly, lx))
        COLOR 7
        LOCATE ly, lx
        PRINT s$;
        IF lx > 1 AND lx < 80 THEN
           COLOR 15
           IF LCASE$(COMMAND$) = "loop" THEN COLOR INT(RND * 15)
           LOCATE ly, lx + 1
           PRINT CHR$(SCREEN(ly, lx + 1))
        END IF
        IF lx > 2 AND lx < 79 THEN
           COLOR 7
           LOCATE ly, lx + 2
           PRINT CHR$(SCREEN(ly, lx + 2))
        END IF
        IF INKEY$ <> "" THEN EXIT SUB
    NEXT
    t = TIMER
    WHILE TIMER - t < .01: WEND
NEXT
SWAP x1, x2
x0 = -x0
END SUB

SUB menuit (x1, y1, xl, yl, s$, two, fen)
COLOR fontcolor, fontbackcolor
FOR yy = y1 TO y1 + yl
    FOR xx = x1 TO x1 + xl
        LOCATE yy, xx
        PRINT " ";
    NEXT
NEXT
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

IF fen THEN
   LOCATE y1 + 2, x1 + 1
   PRINT "ว"
   FOR i = x1 + 1 TO x1 + xl - 1
       LOCATE y1 + 2, i
       PRINT "ฤ";
   NEXT
   LOCATE y1 + 1, x1 + xl / 2 - LEN(s$) / 2
   PRINT s$
ELSE
   LOCATE y1, x1 + xl / 2 - LEN(s$) / 2
   PRINT s$
END IF
'ษอออออออออออออออ123ออออออออออออออออออออป"
'บ                                      บ"
'ศออออออออออออออออออออออออออออออออออออออผ"
END SUB

SUB pause
PRINT "Press any key to continue..."
a$ = INPUT$(1)
PCOPY 1, 0
LOCATE dosy, dosx
END SUB

SUB posinv (x0, y0)
STATIC p$, inv, t
IF p$ = "" THEN p$ = CHR$(RND * 4 + 2)
IF t = 0 THEN t = TIMER
IF TIMER - t > .1 THEN
   inv = NOT inv
   IF inv THEN LOCATE y0, x0: PRINT p$;
   IF NOT inv THEN LOCATE y0, x0: PRINT " ";
   t = TIMER
END IF
END SUB

SUB say (s$)
COLOR 7
FOR i = 1 TO LEN(s$)
    p$ = MID$(s$, i, 1)
    IF p$ = "[" THEN p$ = "": COLOR 5
    IF p$ = "]" THEN p$ = "": COLOR 7
    IF p$ = "{" THEN p$ = "": COLOR 10
    IF p$ = "}" THEN p$ = "": COLOR 7
    PRINT p$;
NEXT
PRINT
END SUB

SUB scrpro
backy = CSRLIN: backx = POS(0)
aa$ = "Toyshop"
bb$ = "Toyshop"
d$ = "       "
PCOPY 0, 2
CLS
DO
COLOR INT(RND * 10) + 1
FOR py = 1 TO 23
x1 = 37 + INT(SIN(299 / 23 * py) * 20)
x2 = 37 + INT(SIN(299 / 23 * py + 8) * 20)
LOCATE py, x1: PRINT aa$;
LOCATE py, x2: PRINT bb$;
t = TIMER
WHILE TIMER - t < .1: WEND
  IF x1 + LEN(aa$) >= x2 AND x2 + LEN(bb$) >= x1 THEN
     COLOR INT(RND * 10) + 1
     LOCATE py, x1 + i: PRINT aa$;
     LOCATE py, x2 + i: PRINT bb$;
  END IF
LOCATE py, x1: PRINT d$;
LOCATE py, x2: PRINT d$;
a$ = INKEY$
IF a$ <> "" THEN
  PCOPY 2, 0
  LOCATE 1, 1
  EXIT SUB
END IF
NEXT
LOOP
COLOR 3
END SUB

