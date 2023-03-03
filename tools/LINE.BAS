'Don't remove these REM line..................................................
'+ - to change line number
'Download from http://toyclub.myrice.com/
'E-mail:toyclub@sina.com
'Toyshop Studio
'Produce by FFB
'..............................................................................
DECLARE SUB drawline ()
DECLARE SUB pal ()
DECLARE SUB CLl ()
DECLARE SUB w (ti AS SINGLE)
DIM SHARED x(99) AS INTEGER
DIM SHARED y(99)  AS INTEGER
DIM SHARED ax(99)  AS INTEGER
DIM SHARED ay(99)  AS INTEGER
DIM SHARED movx(99)  AS INTEGER
DIM SHARED movy(99)  AS INTEGER
DIM SHARED c AS INTEGER
DIM SHARED total AS INTEGER
RANDOMIZE TIMER
total = 4
SCREEN 12
FOR i = 1 TO total
    x(i) = INT(RND * 600): y(i) = INT(RND * 400)
    ax(i) = INT(RND * 600): ay(i) = INT(RND * 400)
    IF ax(i) > x(i) THEN movx(i) = 1 ELSE movx(i) = -1
    IF ay(i) > y(i) THEN movy(i) = 1 ELSE movy(i) = -1
NEXT
c = INT(RND * 15) + 1
c = 14
DO
FOR i = 1 TO total
       IF x(i) <> ax(i) AND y(i) <> ay(i) THEN
          x(i) = x(i) + movx(i): y(i) = y(i) + movy(i)
       ELSE
       CLl
          ax(i) = INT(RND * 600): ay(i) = INT(RND * 400)
          IF ax(i) > x(i) THEN movx(i) = -1 ELSE movx(i) = 1
          IF ay(i) > y(i) THEN movy(i) = -1 ELSE movy(i) = 1
       END IF
    IF ax(i) > x(i) THEN movx(i) = 1 ELSE movx(i) = -1
    IF ay(i) > y(i) THEN movy(i) = 1 ELSE movy(i) = -1

NEXT
CLl
drawline
pal
w .01
a$ = INKEY$
SELECT CASE a$
 CASE CHR$(27):
      END
 CASE "":
      CLS
 CASE "=", "+":
     total = total + 1
     CLS : PRINT total
 CASE "-":
     total = total - 1
     CLS : PRINT total
 CASE ELSE
END SELECT
LOOP

SUB CLl
'x1,y1      ,x2,y2
'x3,y3      x4,y4
FOR i = 1 TO total - 1
    LINE (x(i) - movx(i), y(i) - movy(i))-(x(i + 1) - movx(i + 1), y(i + 1) - movy(i + 1)), 0
NEXT
LINE (x(i) - movx(i), y(i) - movy(i))-(x(1) - movx(1), y(1) - movy(1)), 0
END SUB

SUB drawline
'''''''''''''''''''''''''''''''''
FOR i = 1 TO total - 1
    LINE (x(i), y(i))-(x(i + 1), y(i + 1)), c
NEXT
LINE (x(i), y(i))-(x(1), y(1)), c
END SUB

SUB pal
STATIC r AS INTEGER, g AS INTEGER, b AS INTEGER, psw AS INTEGER, add AS INTEGER
IF add = 0 THEN add = 1: r = 11: g = 11: b = 11
PALETTE 14, 65535 * r + 256 * g + b
r = r + add: g = g + add: b = b + add
IF (r > 40 OR g > 40 OR b > 40) THEN add = -add
IF r < 5 OR g < 5 OR b < 5 THEN add = -add
'PRINT r, g, b
END SUB

SUB w (ti AS SINGLE)
t = TIMER
WHILE TIMER - t < ti: WEND
END SUB

