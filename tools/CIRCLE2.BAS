DECLARE SUB pal ()
DECLARE SUB help ()
DECLARE SUB delay (t!)
DECLARE SUB w (ti!)
DIM SHARED in AS STRING
DIM SHARED r(999) AS INTEGER
DIM SHARED c(999) AS INTEGER
DIM SHARED exe AS STRING
RANDOMIZE TIMER
exe = COMMAND$
IF exe = "/?" THEN help
IF exe <> "" THEN many = VAL(COMMAND$) ELSE many = 5
IF many < 2 THEN many = 2
'640*480
'centerx = 160 * 2: centery = 100 * 2:centertextx = 80: centertexty = 24
'320*200
centerx = 160: centery = 100: centertextx = 40: centertexty = 24
copyright$ = "Toyshop Studio(TM) "                         'copyright $
FOR rr = 1 TO 99
    r(rr) = INT(RND * 400) + 1
NEXT
SCREEN 13
DO
COLOR 14
LOCATE centertexty / 2, centertextx / 2 - LEN(TIME$) / 2: PRINT TIME$'copyright$
pal
FOR rr = 1 TO many
    r(rr) = r(rr) + 1
    IF r(rr) > 400 THEN
       CIRCLE (centerx, centery), r(rr) - 1, 0
       r(rr) = 1
    END IF
    'c(rr) = INT(RND * 255) + 1
    c(rr) = r(rr) / 2
    CIRCLE (centerx, centery), r(rr), c(rr)
    CIRCLE (centerx, centery), r(rr) - 1, 0
    'IF r(rr) > 100 THEN delay 10 ELSE delay 1000
       in = INKEY$
       IF in = CHR$(27) THEN END
       SELECT CASE in
           CASE "1": SCREEN 12: centerx = 160 * 2: centery = 100 * 2: centertextx = 80: centertexty = 24
           CASE "2": SCREEN 13: centerx = 160: centery = 100: centertextx = 40: centertexty = 24
           CASE ELSE
       END SELECT
NEXT
LOOP

SUB delay (t)
FOR i = 0 TO t: NEXT

END SUB

SUB help
PRINT
PRINT "Toyshop Studio 1999.7.16"
PRINT "D circle number"
PRINT
END
END SUB

SUB pal
STATIC pale, addp
IF addp = 0 THEN addp = .4
IF pale <= 0 THEN pale = 15
PALETTE 14, 65535 * INT(pale) + 256 * INT(pale) + INT(pale)
pale = pale + addp
IF pale > 40 OR pale < 15 THEN addp = -addp
END SUB

SUB w (ti AS SINGLE)
     t# = TIMER
     WHILE TIMER - t# < ti: WEND
END SUB

