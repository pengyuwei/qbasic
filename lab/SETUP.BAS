DECLARE SUB setup1 (x1!, y1!, x2!, y2!, n!)
SCREEN 12
PALETTE 0, 65536 * 42 + 256 * 42 + 42
PALETTE 2, 0
PAINT (1, 1), 1
setup1 20, 20, 600, 400, 0
setup1 24, 24, 596, 396, 1
COLOR 2
LOCATE 13, 10
setup1 40, 200, 580, 350, 0
PRINT "install.."
setup1 60, 250, 560, 300, 1
FOR i = 60 TO 560 - 1
    LINE (60, 251)-(i, 299), 1, BF
    FOR k = 1 TO 2000: NEXT
NEXT

SUB setup1 (x1, y1, x2, y2, n)
LINE (x1, y1)-(x2, y2), 0, BF
IF n = 0 THEN
   LINE (x1 - 1, y1 - 1)-(x2 + 1, y1), 15, BF
   LINE (x1 - 1, y1 - 1)-(x1, y2 + 1), 15, BF
   LINE (x1 - 1, y2)-(x2 + 1, y2 + 1), 2, BF
   LINE (x2, y1 - 2)-(x2 + 1, y2 + 1), 2, BF
END IF
IF n = 1 THEN
   LINE (x1 - 1, y1 - 1)-(x2 + 1, y1), 2, BF
   LINE (x1 - 1, y1 - 1)-(x1, y2 + 1), 2, BF
   LINE (x1 - 1, y2)-(x2 + 1, y2 + 1), 15, BF
   LINE (x2, y1 - 2)-(x2 + 1, y2 + 1), 15, BF
END IF


END SUB

