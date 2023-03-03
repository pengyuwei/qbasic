DECLARE SUB w (ti!)
DECLARE SUB initface ()
DECLARE SUB drawface (x!, y!, wf!)
DIM SHARED face1(11, 6) AS INTEGER
DIM SHARED face2(11, 6) AS INTEGER
DIM SHARED face3(11, 6) AS INTEGER
RANDOMIZE TIMER
dosy = CSRLIN
IF dosy < 1 THEN dosy = 1
initface
PCOPY 0, 1
DO
w .5
FOR i = 1 TO 5
 drawface 65, 1, 1
 w .2
 drawface 65, 1, 2
 w .2
NEXT
LOOP UNTIL INKEY$ <> ""
 drawface 65, 1, 3
 w 1
PCOPY 1, 0
LOCATE dosy, 1
IF RND > .5 THEN PRINT "Bye-bye!"
END
'face 1
'      1   2   3   4   5   6   7   8   9  10
'------------------------------------------------
DATA   0,177,177,177,177,177,177,177,  0,  0
DATA 124,  0, 47, 92,  0, 47, 92,  0,124,  0
DATA 124,  0,  0,111,  0,111,  0,  0,124,  0
DATA 124,  0,  0,  0,  0,  0,  0,  0,124,  0
DATA   0, 92, 95, 95, 95, 95, 95, 47,  0,  0

'face 2
'      1   2   3   4   5   6   7   8   9  10
'------------------------------------------------
DATA   0,177,177,177,177,177,177,177,  0,  0
DATA 124,  0, 45, 45,  0, 45, 45,  0,124,  0
DATA 124,  0,  0,111,  0,111,  0,  0,124,  0
DATA 124,  0,  0,  0,111,  0,  0,  0,124,  0
DATA   0, 92, 95, 95, 95, 95, 95, 47,  0,  0

'face 3
'      1   2   3   4   5   6   7   8   9  10
'------------------------------------------------
DATA   0,177,177,177,177,177,177,177,  0,  0
DATA 124,  0, 45, 45,  0, 45, 45,  0,124,  0
DATA 124,  0,  0, 46,  0, 46,  0,  0,124,  0
DATA 124,  0,  0,  0,  0,  0,  0,  0,124,  0
DATA   0, 92, 95, 95, 95, 95, 95, 47,  0,  0

SUB drawface (dx, dy, wf)
SELECT CASE wf
CASE 0: CLS
CASE 1:
   FOR y = 1 TO 5
       LOCATE dy + y - 1, dx
       FOR x = 1 TO 10
           f = face1(x, y): IF f = 0 THEN f = 32
           PRINT CHR$(f);
       NEXT
   NEXT
CASE 2:
   FOR y = 1 TO 5
       LOCATE dy + y - 1, dx
       FOR x = 1 TO 10
           f = face2(x, y): IF f = 0 THEN f = 32
           PRINT CHR$(f);
       NEXT
   NEXT
CASE 3:
   FOR y = 1 TO 5
       LOCATE dy + y - 1, dx
       FOR x = 1 TO 10
           f = face3(x, y): IF f = 0 THEN f = 32
           PRINT CHR$(f);
       NEXT
   NEXT
CASE ELSE
END SELECT

END SUB

SUB initface
FOR y = 1 TO 5
    FOR x = 1 TO 10
        READ face1(x, y)
    NEXT
NEXT
FOR y = 1 TO 5
    FOR x = 1 TO 10
        READ face2(x, y)
    NEXT
NEXT
FOR y = 1 TO 5
    FOR x = 1 TO 10
        READ face3(x, y)
    NEXT
NEXT




















'   ±±±±±±
' | /\  /\ |
' |  o  o  |
' |        |
'  \_____ /

END SUB

SUB w (ti)
t = TIMER
WHILE TIMER - t < ti: WEND
END SUB

