'----------------------------------机器猫------------------------------------
'-----------------------------大雄的宇宙开拓史-------------------------------
SCREEN 12
CLS
COLOR 7
LOCATE 10, 1
FOR i = 1 TO 18
    READ a$
    FOR k = 1 TO LEN(a$)
        LOCATE i, k
        PRINT MID$(a$, k, 1)
        b = TIMER
        'WHILE TIMER - b < .001: WEND
        IF INKEY$ = CHR$(27) THEN GOTO main
    NEXT
NEXT
FOR y = 2 TO 460 STEP 2
    LINE (0, y)-(320, y), 0
        b = TIMER
        WHILE TIMER - b < .01: WEND

NEXT
a$ = INPUT$(1)
FOR i = 63 TO 1 STEP -1
    PALETTE 7, 65536 * i + 256 * i + i
NEXT
CLS
PALETTE 7, 65536 * 40 + 256 * 40 + 40
DATA 你终于觉察到了吗?
DATA "昨天,你失去了什么东西."
DATA "虽然我不知道那是什么,"
DATA "但我知道,"
DATA "知道它的珍贵与意义."
DATA "你拼命地去追赶,"
DATA "伸开双手,"
DATA "但昨天已"
DATA "很遥远,"
DATA "终难企及."
DATA "你应去寻觅,"
DATA "满怀激情,满怀期翼."
DATA "去寻找你失落的东西吧!"
DATA "满怀激情,满怀期翼."
DATA "回归昨天,"
DATA "向着明日,"
DATA "满怀着激情与期翼."
DATA
'------------------------------------------------MAIN
main:
CLS
LOCATE 10, 30
PALETTE 7, 0
PRINT "大雄的宇宙开拓史"
FOR i = 1 TO 60
    PALETTE 7, 65536 * i + 256 * i + i
    FOR tmp = 0 TO 600: NEXT
NEXT
FOR i = 0 TO 5000: NEXT
FOR i = 60 TO 1 STEP -1
    PALETTE 7, 65536 * i + 256 * i + i
    FOR tmp = 0 TO 600: NEXT
NEXT
CLS
PALETTE 7, 0
RESTORE dat1
FOR i = 1 TO 3 STEP 2
     READ s$
     LOCATE i + 5, 2: PRINT s$
NEXT
FOR i = 1 TO 60
    PALETTE 7, 65536 * i + 256 * i + i
    FOR tmp = 0 TO 600: NEXT
NEXT
a$ = INPUT$(1)
FOR i = 60 TO 1 STEP -1
    PALETTE 7, 65536 * i + 256 * i + i
    FOR tmp = 0 TO 600: NEXT
NEXT

dat1:
DATA "帮尼人力定律:一个人在一分钟内可挖一个洞,六十个人在一秒钟内就办不到"
DATA "诺尔斯定律:辩论时间的长短与问题重要性成反比"

