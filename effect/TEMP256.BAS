y = 50
SCREEN 13
FOR x = 10 TO 350
    'LINE (x, y)-(x, y + 100), INT(RND * 256)
    'LINE (x - 20, y)-(x - 20, y + 100), 0
    CIRCLE (x, y), 155, INT(RND * 256)
    'CIRCLE (x - 20, y), 55, 0
'FOR t = 0 TO 9999: NEXT
NEXT

SUB w (t)
t0 = TIMER
WHILE TIMER - t0 < t: WEND
END SUB

