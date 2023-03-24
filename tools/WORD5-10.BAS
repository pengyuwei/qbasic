DECLARE FUNCTION judge! (ff!, a$)
DECLARE SUB endgame (r!, w!)
DECLARE SUB help ()
DECLARE SUB pal ()
DECLARE SUB save ()
DECLARE SUB clk ()
DECLARE SUB light (x1!, y1!, XL!, yl!)
DECLARE SUB lightline ()
DECLARE SUB lightbox ()
DECLARE SUB clr (l)
DECLARE SUB luan (f!)
DECLARE SUB getchr (x0!, y0!, leng!)
DECLARE SUB disappear (q!)
DIM SHARED word(99) AS STRING
DIM SHARED dis AS STRING
DIM SHARED disap AS INTEGER
DIM SHARED in AS STRING
DIM SHARED which AS INTEGER
DIM SHARED ar, aw
CONST true = -1
CONST false = 0
CONST inx = 10
CONST iny = 10
CONST f1 = 72
CONST altx = 11
RANDOMIZE TIMER
IF COMMAND$ = "//" OR COMMAND$ = "/?" THEN help
file = 0
SCREEN 12
lightbox
CLS
'getchr 10, 10, 50
LOCATE 12, 1
COLOR 5
INPUT "How many times do you want to exercise?(Enter=20)", many$
howmany = VAL(many$) - 1
IF howmany = -1 THEN howmany = 20
IF many$ = "00" THEN howmany = flase: LOCATE 13, 1: PRINT "You can press ALT-X to exit": a$ = INPUT$(1)
CLS
GOSUB restorewords:
'------------------------------------------------------main()                        '00108801cc09
which = 1
'LINE (210, 220)-(265, 240), 1, B
DO
many = many + 1
COLOR 3
LOCATE iny - 1, inx + 1: PRINT word(which); : clr (0)
getchr inx, iny, 50
in = RTRIM$(in)
in = LTRIM$(in)
SELECT CASE judge(file, in)
CASE 0
    LOCATE iny + 5, inx + 18: PRINT "wrong!"
    light 210, 220, 55, 20
    w = w + 1
    aw = aw + 5
CASE -1
    LOCATE iny + 5, inx + 18: PRINT "Right"
    light 210, 220, 55, 20
    r = r + 1
    ar = ar + 5
CASE ELSE
END SELECT
IF (r / (r + w)) * 100 = 100 THEN COLOR 14
IF ar + ar > 0 THEN LOCATE 20, 30: PRINT USING "###.#%"; (ar / (ar + aw)) * 100; : clr (5)
COLOR 7
LOCATE 20, 50: PRINT r; "/"; r + w; : clr (4)
which = which + 1
IF which >= file THEN GOSUB restorewords
clk
IF howmany THEN IF many > howmany THEN EXIT DO
LOOP
endgame r, w

restorewords:
file = 0
many = 0: which = 1
RESTORE
DO
file = file + 1
READ word(file)
IF word(file) = "EOF" THEN file = file - 1: EXIT DO
LOOP
luan file
RETURN






















DATA "dir","dir/p","dir/w"
DATA "play"
DATA "cd game","cls"
DATA "abcd"
DATA "edit config.sys"
DATA "regedit","linux","tc"
DATA "speak"
DATA "say","dog","cat"
DATA "19791234"
DATA "mem"
DATA "mem/c/p"
DATA "msd","time","date"
DATA "windows"
DATA "win"
DATA "format"
DATA "copy"
DATA "copy a:\."
DATA "cd windows"
DATA "arj","rar"
DATA "net"
DATA "word","office"
DATA "edit autoexec.bat"
DATA "abcdefghijklmnopqrstuvwxyz"
DATA "China","English","Germany","Russia"
DATA "program","main","print","debug","file"
DATA "edit"
DATA "ls -l"
DATA "search","help"
DATA "lock","shift","enter","screen","include"
DATA "data","read","list","ucdos"
DATA "system"
DATA "tools","image"
DATA "69643145","62394625"



DATA "application","algorithm","address","adapter","accuracy","channel","byte"
DATA "bubble sort","bootstrap","blank","binary","baud","compression","communication"
DATA "constant","default","dynamic","element","extent","field","flag"
DATA "program buffer","log on","logic","jumper","create disk","common user network"
DATA "comment", "boot virus", "shut down", "shut down the computer"
DATA "macro","macro command"

DATA "EOF"
DATA "EOF"
DATA "EOF"
DATA "EOF"
DATA "EOF"
DATA "EOF"

SUB clk
WHILE INKEY$ <> "": WEND
END SUB

SUB clr (l)
px = POS(0)
IF l > 80 THEN l = 80
IF l = 0 THEN l = 80 ELSE l = px + l
FOR i = px TO l
    PRINT " ";
NEXT
END SUB

SUB disappear (q)
STATIC palc
IF q THEN palc = true
x = 20: y = 18
IF LEN(dis) > 26 THEN dis = LEFT$(dis, 26)
IF palc <= 1 THEN PALETTE 15, 65535 * 45 + 256 * 45 + 45: palc = 45: LOCATE y, x: PRINT "  "; : dis = ""
COLOR 15
c = 45
LOCATE y, x + 5: PRINT dis;
IF LEN(dis) > 10 THEN clr (0) ELSE clr (50 - POS(0))
PALETTE 15, 65535 * INT(palc) + 256 * INT(palc) + INT(palc)
IF palc > 20 THEN palc = palc - 6 ELSE palc = palc - .5
COLOR 7
IF palc <= 1 THEN disap = flase: LOCATE y, x: clr (50 - POS(0)): PALETTE 15, 0: dis = ""
LOCATE y, x - 10: PRINT "Last input is: ";
END SUB

SUB endgame (r, w)
IF w = 0 THEN lightline
clk
LOCATE 22, 1
CLS
LOCATE 10, 21
PRINT "Exercise successfully!!"
LOCATE 12, 21
PRINT "Press <ESC> to return to the Windows"
COLOR 10
LOCATE 14, 21: PRINT "Right : "; r;
IF w = 0 THEN PRINT "   100%" ELSE PRINT
LOCATE 15, 21: PRINT "Wrong : "; w
COLOR 6
LOCATE 17, 21: PRINT "Total : "; r + w
LOCATE 18, 21: PRINT USING "Rate:###.#%"; (ar / (ar + aw)) * 100;
DO
lightbox
LOOP UNTIL INKEY$ = CHR$(27)
END
END SUB

SUB getchr (x0, y0, leng)
STATIC p$, inv, t, music
IF p$ = "" THEN p$ = "_"
IF t = 0 THEN t = TIMER
l = 0
COLOR 14
LOCATE 1, 24
PRINT "Toyshop studio 1999.3.29"
COLOR 7
usetime = TIMER
DO
a$ = INKEY$
IF a$ = CHR$(17) OR a$ = CHR$(0) + CHR$(45) THEN END               '^q || ALT-X
IF a$ = CHR$(19) THEN
   a$ = ""
   music = NOT music     '^s
   IF music THEN onoff$ = "ON" ELSE onoff$ = "OFF"
   disap = true
   disappear (true)
   dis = "Sound " + onoff$
END IF
IF a$ = "`" THEN a$ = "": IF p$ = "_" THEN p$ = CHR$(179) ELSE p$ = "_"
IF (a$ >= " " AND a$ <= "z") AND l < leng THEN
   ar = ar + 1
   s$ = s$ + a$
   l = l + 1
   LOCATE y0, x0 + l
   IF a$ = MID$(word(which), l, 1) THEN
      COLOR 7
   ELSE
      COLOR 4
      IF music THEN SOUND 1937, .2
      aw = aw + 1
   END IF
   PRINT a$
   disap = true
   disappear (true)
   dis = a$
   IF a$ = " " THEN dis = "Space"
END IF
IF a$ = CHR$(8) AND l >= 1 THEN
  LOCATE y0, x0 + l
  PRINT "  ":
  l = l - 1
  s$ = LEFT$(s$, l)
  disap = true
  disappear (true)
  dis = "Back"
END IF
IF a$ = CHR$(27) THEN
   LOCATE y0, 1: PRINT SPACE$(80);
   l = 0
   s$ = ""
   disap = true
   disappear (true)
   dis = "ESC"
END IF
IF a$ = CHR$(13) THEN
   disap = true
   disappear (true)
   dis = s$           '"Enter"
END IF
IF TIMER - t > .1 THEN GOSUB position: IF disap THEN disappear (0)
lightbox
pal
IF RND < .01 THEN LOCATE 25, 70: PRINT TIME$
LOOP UNTIL a$ = CHR$(13)
LOCATE 19, 10: PRINT USING "Use time :###.## "; TIMER - usetime
in = s$
LOCATE y0, x0 + l + 1
PRINT "  ":
LOCATE y0, 1: PRINT SPACE$(80);
EXIT SUB

position:
inv = NOT inv
IF inv THEN LOCATE y0, x0 + l + 1: PRINT p$
IF NOT inv THEN LOCATE y0, x0 + l + 1: PRINT " "
t = TIMER
RETURN
END SUB

SUB help
PRINT
PRINT "A MS-DOS program -- Tword.exe V0.10"
PRINT "Copyright Toyshop Studio 1999"
PRINT "BeiJing HaiDian"
PRINT "Tel: 62394625"
PRINT "E-main : Toyshop@263.net"
PRINT
PRINT "CTRL+S   Sound ON/OFF"
PRINT "ALT+X    Exit Program"
END

END SUB

FUNCTION judge (ff, a$)
judge = false
IF word(which) = a$ THEN judge = true
END FUNCTION

SUB light (x1, y1, XL, yl)
FOR y = y1 + yl TO y1 STEP -1
    FOR x = x1 TO x1 + XL
        cc = POINT(x, y)
        IF cc <> 0 THEN c = INT(RND * 14) + 1: PSET (x, y), c
    NEXT
NEXT
END SUB

SUB lightbox
STATIC t
IF t = 0 THEN t = TIMER
IF TIMER - t < 1 THEN EXIT SUB
'LINE (60, 80)-(500, 350), 1, B
FOR x = 60 TO 500
    PSET (x, 80), INT(RND * 14)
NEXT
FOR x = 60 TO 500
    PSET (x, 350), INT(RND * 14)
NEXT
FOR y = 80 TO 350
    PSET (60, y), INT(RND * 14)
NEXT
FOR y = 80 TO 350
    PSET (500, y), INT(RND * 14)
NEXT
END SUB

SUB lightline
y = 1
tt = 1
c0 = 15
DO
FOR a = 1 TO 3000
B = SIN(a)
y = B * 10 + 140
x = x + 1
IF x > 600 THEN x = 1
c = INT(RND * c0)
IF c0 <= 0 THEN c = 0
PSET (x, y), c
'FOR t = 0 TO 199: NEXT
IF RND > .999 THEN lightbox
NEXT
tt = tt + 1
IF tt / 2 = INT(tt / 2) THEN c0 = c0 - 1
LOOP UNTIL c0 < 0
END SUB

SUB luan (ff)
REDIM a(ff)
FOR k = 1 TO RND * 10
FOR i = 1 TO ff / 2
    wh = INT(RND * (ff + 1 - 2)) + 2
    IF NOT a(wh) THEN SWAP word(i), word(wh): a(wh) = flase: a(i) = false
NEXT
PRINT
NEXT
END SUB

SUB pal STATIC
IF note THEN GOTO here
t = TIMER
c14 = 40
note = -1
here:
IF TIMER - t < .02 THEN EXIT SUB
t = TIMER
IF add = 0 THEN add = -1
c14 = c14 + add
IF c14 > 50 OR c14 < 15 THEN add = -add
PALETTE 14, 65535 * INT(c14) + 256 * INT(c14) + INT(c14)


END SUB

SUB save
OPEN "d:\d.dat" FOR INPUT AS #1
IF EOF(1) THEN
    CLOSE
    OPEN n$ FOR OUTPUT AS #1
    PRINT #1, DATE$, B$
    CLOSE
ELSE
   INPUT #1, p$, B$
   B = VAL(B$)
   B = B + 1
   B$ = STR$(B)
   CLOSE
END IF
END SUB

