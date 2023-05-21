DECLARE SUB cdisp (say AS STRING)
DECLARE SUB rec (disp AS STRING)
DECLARE SUB help ()
DIM show AS STRING
dosy = CSRLIN: dosx = POS(0)
show = COMMAND$
IF COMMAND$ = "" THEN help
IF LEFT$(LTRIM$(COMMAND$), 2) = "/R" THEN
   show = LTRIM$(RIGHT$(LTRIM$(COMMAND$), LEN(LTRIM$(COMMAND$)) - 2))
   rec show
ELSE
   cdisp show
END IF
LOCATE dosy, dosx
END

SUB cdisp (say AS STRING)
COLOR 10
FOR i = 1 TO LEN(say)
    IF MID$(say, i, 1) = "%" THEN
       i = i + 1
       COLOR VAL(MID$(say, i, 1))
    ELSE
       PRINT MID$(say, i, 1);
    END IF
NEXT
END SUB

SUB help
PRINT
PRINT "Cshow information1%1-0information2"
PRINT "Cshow /r X1,Y1-X2,Y2,Color"
PRINT
PRINT "201 Studio 1999.12.05"
END
END SUB

SUB rec (disp AS STRING)
'disp=x1,y1-x2,y2,color      -->    11,22-33,44,7
DIM c(9) AS INTEGER
p = 1: d$ = ""
FOR i = 1 TO LEN(disp)
    IF MID$(disp, i, 1) = "," OR MID$(disp, i, 1) = "-" THEN
       c(p) = VAL(d$)
       p = p + 1: d$ = ""
    ELSE
       d$ = d$ + MID$(disp, i, 1)
    END IF
NEXT
COLOR VAL(d$)
FOR y = c(2) TO c(4)
    FOR x = c(1) TO c(3)
        c = SCREEN(y, x)
        LOCATE y, x
        PRINT CHR$(c);
    NEXT
NEXT
END SUB

