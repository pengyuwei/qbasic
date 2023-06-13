DECLARE SUB menu (x1!, y1!, xl!, yl!, s$, two!)
CONST backcolor = 1
CONST textcolor = 7
CONST sbackcolor = 0
CONST stextcolor = 10
CLS
menu 1, 1, 80, 20, "Run Time", 2

SUB menu (x1, y1, xl, yl, s$, two)
'c1 = 4: c0 = 3
cs0 = textcolor: cs1 = backcolor
COLOR cs0, cs1
IF x1 + xl > 80 THEN x1 = 1: xl = 79
FOR yy = y1 TO y1 + yl
    FOR xx = x1 TO x1 + xl
        LOCATE yy, xx
        PRINT " ";
    NEXT
NEXT
LOCATE y1 + 1, x1 + (xl - LEN(s$)) / 2
PRINT s$
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
LOCATE y1 + 2, x1 + 1
PRINT "ว"
FOR i = x1 + 1 TO x1 + xl - 1
    LOCATE y1 + 2, i
    PRINT "ฤ";
NEXT

'ษออออออออออออออออออออออออออออออออออออออป"
'บ                                      บ"
'ศออออออออออออออออออออออออออออออออออออออผ"



END SUB

