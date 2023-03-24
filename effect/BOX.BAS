DECLARE SUB w (wt!)
DIM x(4) AS INTEGER
DIM y(4) AS INTEGER
DIM rundll AS INTEGER
SCREEN 12
l = 150: add = 1      'this var = 1 to 15
x0 = 200
x(1) = 200: y(1) = 150
x(2) = x(1) + l: y(2) = y(1)
x(3) = x(1): y(3) = y(1) + l
x(4) = x(1) + l: y(4) = y(1) + l
t = TIMER
DO
 LINE (x(1), y(1))-(x(2), y(2)), 7
 LINE (x(2), y(2))-(x(4), y(4))
 LINE (x(4), y(4))-(x(3), y(3))
 LINE (x(3), y(3))-(x(1), y(1))
 w .01
 LINE (x(1), y(1))-(x(2), y(2)), 0
 LINE (x(2), y(2))-(x(4), y(4)), 0
 LINE (x(4), y(4))-(x(3), y(3)), 0
 LINE (x(3), y(3))-(x(1), y(1)), 0
 SELECT CASE rundll
'x1,y1      x2,y2
'     l=150
'x3,y3      x4,y4
  CASE 0:               
    y(1) = y(1) - add / 4: y(3) = y(3) + add / 4: x(1) = x(1) + add: x(3) = x(3) + add
    y(2) = y(2) + add / 4: y(4) = y(4) - add / 4: x(2) = x(2) - add: x(4) = x(4) - add
    IF x(1) - l / 2 >= x0 THEN rundll = rundll + 1
  CASE 1:
    y(1) = y(1) + add / 4: y(3) = y(3) - add / 4: x(1) = x(1) + add: x(3) = x(3) + add
    y(2) = y(2) - add / 4: y(4) = y(4) + add / 4: x(2) = x(2) - add: x(4) = x(4) - add
    IF x(1) - l >= x0 THEN
       SWAP x(1), x(2)
       SWAP x(3), x(4)
       SWAP y(1), y(2)
       SWAP y(3), y(4)
       rundll = rundll - 1
    END IF
  CASE ELSE
 END SELECT
'LOCATE 1, 1: PRINT x(1); x(2); x(3); x(4)
'LOCATE 2, 1: PRINT y(1); y(2); y(3); y(4)
IF TIMER - t > .8 THEN
  IF add < 15 THEN add = add + 1
  t = TIMER
END IF
LOOP UNTIL INKEY$ = CHR$(27)
COLOR 0

SUB w (wt)
    t = TIMER
    WHILE TIMER - t < wt: WEND
END SUB

