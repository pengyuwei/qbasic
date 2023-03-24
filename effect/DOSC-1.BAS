DECLARE SUB w (ti AS SINGLE)
DECLARE SUB pause ()
DIM SHARED dos(25) AS STRING
DIM SHARED in AS STRING
RANDOMIZE TIMER
PCOPY 0, 1
FOR y = 1 TO 22
    FOR x = 1 TO 80
        c = SCREEN(y, x)
        dos(y) = dos(y) + CHR$(c)
    NEXT
NEXT
y = 1
add = 1
col = INT(RND * 15)
DO
IF COMMAND$ = "TIME" THEN LOCATE 1, 70: COLOR 7, 0: PRINT TIME$
IF COMMAND$ = "DATE" THEN LOCATE 1, 70: COLOR 7, 0: PRINT DATE$
IF COMMAND$ = "" THEN COLOR 7, 1: LOCATE y, 1: PRINT dos(y);  ELSE COLOR 15, 0: LOCATE y, 1: PRINT dos(y);
     w .01
COLOR col, 0: LOCATE y, 1: PRINT dos(y);
y = y + add
IF y >= 22 OR y <= 1 THEN add = -add: col = INT(RND * 16)
in = INKEY$
SELECT CASE in
     CASE CHR$(27): EXIT DO
     CASE CHR$(7): PRINT TAB(8);
     CASE CHR$(8): in = ""
     CASE ELSE: PRINT in;
END SELECT
LOOP
PCOPY 1, 0

LOCATE 23, 1
END

SUB pause
a$ = INPUT$(1)
END SUB

SUB w (ti AS SINGLE)
     t# = TIMER
     WHILE TIMER - t# < ti: WEND
END SUB

