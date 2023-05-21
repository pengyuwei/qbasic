DECLARE SUB drawscore (PlayerNum%)
DECLARE SUB bomb (many%, fx#, fy#, delaytime%)
DECLARE SUB drawstar ()
DECLARE FUNCTION GetNum# (Row%, Col%, PlayerNum%)
DECLARE SUB DoExplosion (x#, y#, PlayerNum%)
DECLARE SUB restorekey (w%)
DECLARE SUB inverse (x%, y%, i$)
DECLARE SUB CLK ()
DECLARE SUB clr ()
DEFINT A-Z
DECLARE SUB DoSun (Mouth)
DECLARE SUB SetScreen ()
DECLARE SUB EndGame ()
DECLARE SUB Center (Row, Text$)
DECLARE SUB Intro ()
DECLARE SUB SparklePause ()
DECLARE SUB GetInputs (Player1$, Player2$, NumGames)
DECLARE SUB PlayGame (Player1$, Player2$, NumGames)

DECLARE SUB MakeCityScape (BCoor() AS ANY)
DECLARE SUB PlaceGorillas (BCoor() AS ANY)
DECLARE SUB UpdateScores (Record(), PlayerNum, Results)
DECLARE SUB DrawGorilla (x, y, arms)
DECLARE SUB GorillaIntro (Player1$, Player2$)
DECLARE SUB Rest (t#)
DECLARE SUB VictoryDance (Player)
DECLARE SUB ClearGorillas ()
DECLARE SUB DrawBan (xc#, yc#, r, bc)
DECLARE FUNCTION Scl (n!)
DECLARE FUNCTION DoShot (PlayerNum, x, y)
DECLARE FUNCTION ExplodeGorilla (x#, y#)
DECLARE FUNCTION Getn# (Row, Col)
DECLARE FUNCTION PlotShot (StartX, StartY, Angle#, Velocity, PlayerNum)
DECLARE FUNCTION CalcDelay! ()

'Make all arrays Dynamic
'$DYNAMIC

'User-Defined TYPEs

TYPE XYPoint
  XCoor AS INTEGER
  YCoor AS INTEGER
END TYPE

'Constants
CONST SPEEDCONST = 500
CONST true = -1
CONST false = NOT true
CONST HITSELF = 1
CONST BACKATTR = 0
CONST OBJECTCOLOR = 1
CONST WINDOWCOLOR = 14
CONST SUNATTR = 3
CONST SUNHAPPY = false
CONST SUNSHOCK = true
CONST RIGHTUP = 1
CONST LEFTUP = 2
CONST ARMSDOWN = 3
RANDOMIZE TIMER
'Global Variables
DEF FnRan (x) = INT(RND(1) * x) + 1
DO                                           'main(){
DIM SHARED GorillaX(1 TO 2)  'Location of the two gorillas
DIM SHARED GorillaY(1 TO 2)
DIM SHARED LastBuilding

DIM SHARED pi#
DIM SHARED LBan&(x), RBan&(x), UBan&(x), DBan&(x) 'Graphical picture of banana
DIM SHARED GorD&(120)        'Graphical picture of Gorilla arms down
DIM SHARED GorL&(120)        'Gorilla left arm raised
DIM SHARED GorR&(120)        'Gorilla right arm raised

DIM SHARED gravity#
DIM SHARED wind

'Screen Mode Variables
DIM SHARED ScrHeight
DIM SHARED ScrWidth
DIM SHARED Mode
DIM SHARED MaxCol

'Screen Color Variables
DIM SHARED ExplosionColor
DIM SHARED SunColor
DIM SHARED BackColor
DIM SHARED SunHit

DIM SHARED SunHt
DIM SHARED GHeight
DIM SHARED MachSpeed AS SINGLE
'toyshop set
DIM SHARED autorun AS INTEGER
DIM SHARED music AS INTEGER
DIM SHARED night AS INTEGER
DIM SHARED TotalWins(2)
DIM SHARED life(4)
DIM SHARED sx(400) AS INTEGER, sy(400)   AS INTEGER, sc(400) AS INTEGER
  RANDOMIZE TIMER
  GOSUB InitVars
  Intro
  GetInputs Name1$, Name2$, NumGames
  GorillaIntro Name1$, Name2$
  PlayGame Name1$, Name2$, NumGames
  CLEAR
  REM $DYNAMIC
  LOCATE 10, 25: PRINT "Do you want to play again?(Y/N)"
  a$ = INPUT$(1)
  IF a$ = "n" OR a$ = "N" THEN END
  LOOP                                                     '}
END

EGABanana:
  'BananaLeft
  DATA 458758,202116096,471604224,943208448,943208448,943208448,471604224,202116096,0
  'BananaDown
  DATA 262153, -2134835200, -2134802239, -2130771968, -2130738945,8323072, 8323199, 4063232, 4063294
  'BananaUp
  DATA 262153, 4063232, 4063294, 8323072, 8323199, -2130771968, -2130738945, -2134835200,-2134802239
  'BananaRight
  DATA 458758, -1061109760, -522133504, 1886416896, 1886416896, 1886416896,-522133504,-1061109760,0

InitVars:
  pi# = 4 * ATN(1#)

  'This is a clever way to pick the best graphics mode available
  Mode = 9
  SCREEN Mode
  MachSpeed = CalcDelay
    ScrWidth = 640
    ScrHeight = 350
    GHeight = 25
    RESTORE EGABanana
    REDIM LBan&(8), RBan&(8), UBan&(8), DBan&(8)

    FOR i = 0 TO 8
      READ LBan&(i)
    NEXT i

    FOR i = 0 TO 8
      READ DBan&(i)
    NEXT i

    FOR i = 0 TO 8
      READ UBan&(i)
    NEXT i

    FOR i = 0 TO 8
      READ RBan&(i)
    NEXT i

    SunHt = 39
life(1) = 10
life(2) = 10
   
    FOR i = 1 TO 400
        sx(i) = INT(RND * 600) + 2
        sy(i) = INT(RND * 300) + 2
        DO
        sc(i) = INT(RND * 15) + 1
        LOOP UNTIL sc(i) <> 1       '!=Mancolor!=ObjColor
    NEXT
RETURN

REM $STATIC
SUB bomb (many, fx#, fy#, delaytime)
DIM bx(800), by(800), br(800), r(800), bc(800), ok(800)
FOR k = 1 TO many
     GOSUB init
     ok(k) = false
NEXT
here:
allok = false
runtime# = TIMER
DO
FOR k = 1 TO many
    IF NOT ok(k) THEN
       CIRCLE (bx(k), by(k)), r(k), bc(k)
       r(k) = r(k) + 1           'add raudies
       IF r(k) > br(k) - 7 AND bc(k) = 7 THEN bc(k) = 9    'change color
       IF r(k) > br(k) - 5 AND bc(k) = 9 THEN bc(k) = 4
       IF r(k) > br(k) - 2 AND bc(k) = 4 THEN bc(k) = 1
       IF r(k) > br(k) AND bc(k) <> 0 THEN r(k) = 0: bc(k) = 0:  'will clean
       IF r(k) > br(k) AND bc(k) <> 7 THEN
          IF TIMER - runtime# > delaytime THEN ok(k) = true
          r(k) = 0
          GOSUB init
       END IF
    END IF
NEXT
allok = true
FOR k = 1 TO many
    IF ok(k) = false THEN allok = flase
NEXT
IF TIMER - runtime# > delaytime AND allok THEN EXIT DO
LOOP
EXIT SUB
init:
  bx(k) = INT(RND * 40 + 27) - 40 + fx#
  by(k) = INT(RND * 40 + 25) - 40 + fy#
  br(k) = INT(RND * 7) + 5
  bc(k) = 7
RETURN

END SUB

'CalcDelay:
'  Checks speed of the machine.
FUNCTION CalcDelay!

  s! = TIMER
  DO
    i! = i! + 1
  LOOP UNTIL TIMER - s! >= .5
  CalcDelay! = i!

END FUNCTION

' Center:
'   Centers and prints a text string on a given row
' Parameters:
'   Row - screen row number
'   Text$ - text to be printed
'
SUB Center (Row, Text$)
  Col = MaxCol \ 2
  LOCATE Row, Col - (LEN(Text$) / 2 + .5)
  PRINT Text$;
END SUB

SUB CLK
WHILE INKEY$ <> "": WEND
END SUB

SUB clr
FOR i = POS(0) TO 80
   PRINT " ";
NEXT
END SUB

' DoExplosion:
'   Produces explosion when a shot is fired
' Parameters:
'   X#, Y# - location of explosion
'
SUB DoExplosion (x#, y#, PlayerNum)
  IF PlayerNum = 2 THEN many = 5 ELSE many = 8
  REDIM bombx(many + 1)
  REDIM bombY(many + 1)
  IF music THEN PLAY "MBO0L32EFGEFDC"
 
  Radius = ScrHeight / 40
  IF RND > .85 THEN Radius = ScrHeight / 25
  IF PlayerNum = 2 AND RND > .6 THEN Radius = ScrHeight / 26
  IF PlayerNum = 2 AND RND > .3 THEN Radius = ScrHeight / 20

  IF Mode = 9 THEN Inc# = .5 ELSE Inc# = .41
  Temp! = RND
  'LOCATE 5, 1: PRINT "temp="; Temp!
  FOR i = 1 TO many
      bombx(i) = INT(RND * 40 + 20) - 40
      IF Temp! > .1 THEN bombY(i) = INT(RND * 40 + 20) - 40 ELSE bombY(i) = bombx(i)
  NEXT
  FOR PlayNum = 1 TO 2
  FOR i = 1 TO many    'hit myself??
      IF GorillaX(PlayNum) + 29 >= x# + bombx(i) AND GorillaX(PlayNum) - 29 <= bombx(i) + x# THEN
         IF GorillaY(PlayNum) + 29 >= y# + bombY(i) AND GorillaY(PlayNum) - 29 <= bombY(i) + y# THEN
            life(PlayNum) = life(PlayNum) - 1: drawscore (PlayNum)
         END IF
      END IF
  NEXT
  NEXT
  BombColor = ExplosionColor
  FOR c# = 0 TO Radius STEP Inc#
      
      CIRCLE (x#, y#), c#, BombColor
      FOR i = 1 TO many
          IF PlayerNum = 2 THEN BombColor = INT(RND * 15) + 1
          CIRCLE (x# + bombx(i), y# + bombY(i)), c#, BombColor
      NEXT
  NEXT c#
  PUT (GorillaX(1), GorillaY(1)), GorD&, PSET
  PUT (GorillaX(2), GorillaY(2)), GorD&, PSET
  'clean bomb:
  FOR c# = Radius TO 0 STEP (-1 * Inc#)
      CIRCLE (x#, y#), c#, BACKATTR
      FOR i = 1 TO many
          CIRCLE (x# + bombx(i), y# + bombY(i)), c#, BACKATTR
      NEXT
      Rest .005
  NEXT c#
  PUT (GorillaX(1), GorillaY(1)), GorD&, PSET
  PUT (GorillaX(2), GorillaY(2)), GorD&, PSET
  IF NOT night THEN
    DoSun true
    Rest .2
    DoSun false
  END IF
END SUB

' DoShot:
'   Controls banana shots by accepting player input and plotting
'   shot angle
' Parameters:
'   PlayerNum - Player
'   x, y - Player's gorilla position
'
FUNCTION DoShot (PlayerNum, x, y)

  'Input shot
  IF PlayerNum = 1 THEN
    LocateCol = 1
  ELSE
    IF Mode = 9 THEN
      LocateCol = 66
    ELSE
      LocateCol = 26
    END IF
  END IF
  'LOCATE 4, LocateCol: PRINT "LIFE:"; life(PlayerNum)
DO                                           'input data
  LOCATE 1, 39: PRINT LTRIM$(STR$(TotalWins(1))) + " : " + LTRIM$(STR$(TotalWins(2)))
  LOCATE 2, LocateCol
  PRINT "High:";
  Angle# = GetNum#(2, LocateCol + 5, PlayerNum)
  'IF Angle# = 0 THEN Angle# = 10          'auto run
  LOCATE 1, 39: PRINT LTRIM$(STR$(TotalWins(1))) + " : " + LTRIM$(STR$(TotalWins(2)))
  LOCATE 3, LocateCol
  PRINT "Far:";
  Velocity = GetNum#(3, LocateCol + 4, PlayerNum)
  'IF Velocity = 0 THEN Velocity = 99         'auto run
LOOP WHILE Velocity = 0 OR Angle# = 0      'end input data
  IF PlayerNum = 2 THEN
    Angle# = 180 - Angle#
  END IF
  LOCATE 1, 38: PRINT "       "
  DoSun false
  'Erase input
  FOR i = 1 TO 4
    LOCATE i, 1
    PRINT SPACE$(30 \ (80 \ MaxCol));
    LOCATE i, (50 \ (80 \ MaxCol))
    PRINT SPACE$(30 \ (80 \ MaxCol));
  NEXT
  IF night THEN drawstar
  SunHit = false
  'flying && Bomb SUB is PlotShot
  PlayerHit = PlotShot(x, y, Angle#, Velocity, PlayerNum)
  IF PlayerHit = 0 THEN
    DoShot = false
  ELSE
    DoShot = true
    IF PlayerHit = PlayerNum THEN PlayerNum = 3 - PlayerNum
    VictoryDance PlayerNum
  END IF
 
END FUNCTION

' DoSun:
'   Draws the sun at the top of the screen.
' Parameters:
'   Mouth - If TRUE draws "O" mouth else draws a smile mouth.
'
SUB DoSun (Mouth)
  'set position of sun
  x = ScrWidth \ 2: y = Scl(25)
  IF night THEN
     drawstar
     IF NOT Mouth THEN
        LINE (x + 20, y + 15)-(x + 80, y + 30), 0, BF
        LINE (x + 25, y + 15)-(x + 13, y + 10), 0       'katong
        LINE (x + 20, y + 20)-(x + 13, y + 10), 0

     PALETTE 3, 0
     x = ScrWidth \ 2: y = Scl(25)
     FOR r = 0 TO 15
         CIRCLE (x, y), r, SUNATTR
     NEXT
     FOR r = 0 TO 15
         CIRCLE (x - 1, y), r, SUNATTR
     NEXT
     FOR r = 0 TO 15
         CIRCLE (x - 10, y), r, 0
     NEXT
     FOR r = 0 TO 14
         CIRCLE (x - 9, y), r, 0
     NEXT
     PALETTE 3, 54
     ELSE
        CIRCLE (x, y), 15, SUNATTR
        COLOR 3
        LOCATE 4, 45: PRINT "Ah.."
        LINE (x + 20, y + 15)-(x + 80, y + 30), SUNATTR, B    'box
        LINE (x + 20, y + 15)-(x + 25, y + 20), 0, B
        LINE (x + 25, y + 15)-(x + 13, y + 10), SUNATTR       'katong
        LINE (x + 20, y + 20)-(x + 13, y + 10), SUNATTR
     END IF
     EXIT SUB
  END IF
  'clear old sun
  LINE (x - Scl(22), y - Scl(18))-(x + Scl(22), y + Scl(18)), BACKATTR, BF

  'draw new sun:
  'body
  CIRCLE (x, y), Scl(12), SUNATTR
  PAINT (x, y), SUNATTR

  'rays
  LINE (x - Scl(20), y)-(x + Scl(20), y), SUNATTR
  LINE (x, y - Scl(15))-(x, y + Scl(15)), SUNATTR

  LINE (x - Scl(15), y - Scl(10))-(x + Scl(15), y + Scl(10)), SUNATTR
  LINE (x - Scl(15), y + Scl(10))-(x + Scl(15), y - Scl(10)), SUNATTR

  LINE (x - Scl(8), y - Scl(13))-(x + Scl(8), y + Scl(13)), SUNATTR
  LINE (x - Scl(8), y + Scl(13))-(x + Scl(8), y - Scl(13)), SUNATTR

  LINE (x - Scl(18), y - Scl(5))-(x + Scl(18), y + Scl(5)), SUNATTR
  LINE (x - Scl(18), y + Scl(5))-(x + Scl(18), y - Scl(5)), SUNATTR

  'mouth
  IF Mouth THEN  'draw "o" mouth
    CIRCLE (x, y + Scl(5)), Scl(2.9), 0
    PAINT (x, y + Scl(5)), 0, 0
  ELSE           'draw smile
    CIRCLE (x, y), Scl(8), 0, (210 * pi# / 180), (330 * pi# / 180)
  END IF

  'eyes
  CIRCLE (x - 3, y - 2), 1, 0
  CIRCLE (x + 3, y - 2), 1, 0
  PSET (x - 3, y - 2), 0
  PSET (x + 3, y - 2), 0

END SUB

'DrawBan:
'  Draws the banana
'Parameters:
'  xc# - Horizontal Coordinate
'  yc# - Vertical Coordinate
'  r - rotation position (0-3). (  \_/  ) /-\
'  bc - if TRUE then DrawBan draws the banana ELSE it erases the banana
SUB DrawBan (xc#, yc#, r, bc)

SELECT CASE r
  CASE 0
    IF bc THEN PUT (xc#, yc#), LBan&, PSET ELSE PUT (xc#, yc#), LBan&, XOR
  CASE 1
    IF bc THEN PUT (xc#, yc#), UBan&, PSET ELSE PUT (xc#, yc#), UBan&, XOR
  CASE 2
    IF bc THEN PUT (xc#, yc#), DBan&, PSET ELSE PUT (xc#, yc#), DBan&, XOR
  CASE 3
    IF bc THEN PUT (xc#, yc#), RBan&, PSET ELSE PUT (xc#, yc#), RBan&, XOR
END SELECT
IF bc THEN PSET (xc#, 340), 1 ELSE PSET (xc#, 340), 0         'add
END SUB

'DrawGorilla:
'  Draws the Gorilla in either CGA or EGA mode
'  and saves the graphics data in an array.
'Parameters:
'  x - x coordinate of gorilla
'  y - y coordinate of the gorilla
'  arms - either Left up, Right up, or both down
SUB DrawGorilla (x, y, arms)
  DIM i AS SINGLE   ' Local index must be single precision

  'draw head
  LINE (x - Scl(4), y)-(x + Scl(2.9), y + Scl(6)), OBJECTCOLOR, BF
  LINE (x - Scl(5), y + Scl(2))-(x + Scl(4), y + Scl(4)), OBJECTCOLOR, BF

  'draw eyes/brow
  LINE (x - Scl(3), y + Scl(2))-(x + Scl(2), y + Scl(2)), 0

  'draw nose if ega
  IF Mode = 9 THEN
    FOR i = -2 TO -1
      PSET (x + i, y + 4), 0
      PSET (x + i + 3, y + 4), 0
    NEXT i
  END IF

  'neck
  LINE (x - Scl(3), y + Scl(7))-(x + Scl(2), y + Scl(7)), OBJECTCOLOR

  'body
  LINE (x - Scl(8), y + Scl(8))-(x + Scl(6.9), y + Scl(14)), OBJECTCOLOR, BF
  LINE (x - Scl(6), y + Scl(15))-(x + Scl(4.9), y + Scl(20)), OBJECTCOLOR, BF

  'legs
  FOR i = 0 TO 4
    CIRCLE (x + Scl(i), y + Scl(25)), Scl(10), OBJECTCOLOR, 3 * pi# / 4, 9 * pi# / 8
    CIRCLE (x + Scl(-6) + Scl(i - .1), y + Scl(25)), Scl(10), OBJECTCOLOR, 15 * pi# / 8, pi# / 4
  NEXT

  'chest
  CIRCLE (x - Scl(4.9), y + Scl(10)), Scl(4.9), 0, 3 * pi# / 2, 0
  CIRCLE (x + Scl(4.9), y + Scl(10)), Scl(4.9), 0, pi#, 3 * pi# / 2

  FOR i = -5 TO -1
    SELECT CASE arms
      CASE 1
        'Right arm up
        CIRCLE (x + Scl(i - .1), y + Scl(14)), Scl(9), OBJECTCOLOR, 3 * pi# / 4, 5 * pi# / 4
        CIRCLE (x + Scl(4.9) + Scl(i), y + Scl(4)), Scl(9), OBJECTCOLOR, 7 * pi# / 4, pi# / 4
        GET (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorR&
      CASE 2
        'Left arm up
        CIRCLE (x + Scl(i - .1), y + Scl(4)), Scl(9), OBJECTCOLOR, 3 * pi# / 4, 5 * pi# / 4
        CIRCLE (x + Scl(4.9) + Scl(i), y + Scl(14)), Scl(9), OBJECTCOLOR, 7 * pi# / 4, pi# / 4
        GET (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorL&
      CASE 3
        'Both arms down
        CIRCLE (x + Scl(i - .1), y + Scl(14)), Scl(9), OBJECTCOLOR, 3 * pi# / 4, 5 * pi# / 4
        CIRCLE (x + Scl(4.9) + Scl(i), y + Scl(14)), Scl(9), OBJECTCOLOR, 7 * pi# / 4, pi# / 4
        GET (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorD&
    END SELECT
  NEXT i
'29*29 Man
END SUB

SUB drawscore (PlayerNum)
l = life(PlayerNum) / 2
IF l > 5 THEN l = 5
IF l < 1 THEN l = 1
COLOR 15
SELECT CASE PlayerNum
CASE 1
   LOCATE 4, 1: PRINT "Life: "; ' life(PlayerNum);
   IF l = 1 THEN COLOR 4
   FOR i = 1 TO l
       PRINT CHR$(254);
   NEXT
   FOR i = 1 TO 6 - l: PRINT " "; : NEXT
CASE 2
   LOCATE 4, 66: PRINT "Life: "; ' life(PlayerNum);
   IF l = 1 THEN COLOR 4
   FOR i = 1 TO l
       PRINT CHR$(254);
   NEXT
   FOR i = 1 TO 6 - l: PRINT " "; : NEXT
CASE ELSE
END SELECT
COLOR 15
END SUB

SUB drawstar
    FOR i = 1 TO 400
        PSET (sx(i), sy(i)), sc(i)
        'PSET (sx(i), sy(i)), SUNATTR
    NEXT
END SUB

'ExplodeGorilla:
'  Causes gorilla explosion when a direct hit occurs
'Parameters:
'  X#, Y# - shot location
'player died
FUNCTION ExplodeGorilla (x#, y#)
  bomb 90, x#, y#, .5
  YAdj = Scl(12)
  XAdj = Scl(5)
  SclX# = ScrWidth / 320
  SclY# = ScrHeight / 200
  IF x# < ScrWidth / 2 THEN PlayerHit = 1 ELSE PlayerHit = 2
  IF music THEN PLAY "MBO0L16EFGEFDC"

  FOR i = 1 TO 8 * SclX#
    CIRCLE (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + 7 * SclY# + YAdj), i, ExplosionColor, , , -1.57
    LINE (GorillaX(PlayerHit) + 7 * SclX#, GorillaY(PlayerHit) + 9 * SclY# - i)-(GorillaX(PlayerHit), GorillaY(PlayerHit) + 9 * SclY# - i), ExplosionColor
    FOR Count = 1 TO 800: NEXT
  NEXT i

  FOR i = 1 TO 16 * SclX#
    IF i < (8 * SclX#) THEN CIRCLE (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + 7 * SclY# + YAdj), (8 * SclX# + 1) - i, BACKATTR, , , -1.57
    CIRCLE (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + YAdj), i, i MOD 2 + 1, , , -1.57
    FOR Count = 1 TO 1000: NEXT
  NEXT i

  FOR i = 24 * SclX# TO 1 STEP -1
    CIRCLE (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + YAdj), i, BACKATTR, , , -1.57
    FOR Count = 1 TO 6000: NEXT
  NEXT i
  life(1) = 10: life(2) = 10'add
  ExplodeGorilla = PlayerHit
END FUNCTION

'GetInputs:
'  Gets user inputs at beginning of game
'Parameters:
'  Player1$, Player2$ - player names
'  NumGames - number of games to play
SUB GetInputs (Player1$, Player2$, NumGames)
  COLOR 7, 0
  CLS
  IF autorun THEN
     Player1$ = "DuYanJun"
     Player2$ = "G.P"
     NumGames = 5
     gravity# = 9.8
     t = VAL(LEFT$(TIME$, 2)): IF t >= 18 OR t <= 6 THEN night = true ELSE night = false
     EXIT SUB
  END IF
  y = 6
  restorekey (0)
  LOCATE y, 15
  LINE INPUT "Name of Player 1 (Default = 'DuYanJun'): "; Player1$
  IF Player1$ = "" THEN
    Player1$ = "DuYanJun"
  ELSE
    Player1$ = LEFT$(Player1$, 10)
  END IF

  LOCATE y + 2, 15
  LINE INPUT "Name of Player 2 (Default = 'G.P'): "; Player2$
  IF Player2$ = "" THEN
    Player2$ = "G.P"
  ELSE
    Player2$ = LEFT$(Player2$, 10)
  END IF
  restorekey (1)
  DO
    LOCATE y + 4, 56: PRINT SPACE$(25);
    LOCATE y + 4, 13
    INPUT "Play to how many total points (Default = 5)"; game$
    NumGames = VAL(LEFT$(game$, 2))
  LOOP UNTIL NumGames > 0 AND LEN(game$) < 3 OR LEN(game$) = 0
  IF NumGames = 0 THEN NumGames = 5
  DO
    LOCATE y + 6, 53: PRINT SPACE$(28);
    LOCATE y + 6, 17
    grav = INT(RND * 20) + 1
    PRINT "Gravity in Meters/Sec (Earth =9.8):";
    INPUT "", grav$
    IF grav$ <> "" THEN grav = VAL(grav$)
    gravity# = grav
    LOCATE y + 6, 17
    PRINT "Gravity in Meters/Sec (Now ="; grav; "):           ";
  LOOP UNTIL gravity# > 0 OR LEN(grav$) = 0
  IF gravity# = 0 THEN gravity# = 9.8
   
    restorekey (2)
    LOCATE y + 8, 23
    INPUT "Night or Day(N/D)"; nd$
    SELECT CASE LCASE$(nd$)
    CASE "n", "night"
         night = true
    CASE "d", "day"
         night = false
    CASE ELSE
      t = VAL(LEFT$(TIME$, 2))
      IF t >= 18 OR t <= 6 THEN night = true ELSE night = false
    END SELECT
END SUB

'GetNum:
'  Gets valid numeric input from user
'Parameters:
'  Row, Col - location to echo input
FUNCTION GetNum# (Row, Col, PlayerNum)
 
  Result$ = ""
  Done = false
  'CLK                          'Clear keyboard buffer
  LOCATE 4, 45: PRINT "           "
  drawscore PlayerNum
  DO WHILE NOT Done
   
    LOCATE Row, Col
    PRINT Result$; CHR$(95); "     ";
    'PRINT Result$; CHR$(22); " ";

    Kbd$ = INKEY$
    SELECT CASE Kbd$
      CASE "s"
           music = NOT music
      CASE CHR$(0) + CHR$(45)
           END
      CASE "0" TO "9"
          IF LEN(Result$) < 5 AND POS(0) < 80 THEN Result$ = Result$ + Kbd$: IF music THEN SOUND 1937, .2
      CASE "."
          IF LEN(Result$) < 5 AND POS(0) < 80 THEN
             IF INSTR(Result$, ".") = 0 THEN
                Result$ = Result$ + Kbd$
             END IF
          END IF
      CASE CHR$(27)                      'ESC
          Result$ = ""
          LOCATE Row, Col
          PRINT Result$; CHR$(95); "      ";
      CASE CHR$(13)
        LOCATE Row, Col: clr
        'LOCATE 2, 1: clr
        DoSun false
        IF VAL(Result$) > 999 THEN '360
          Result$ = ""
          DoSun false
        ELSE
          Done = true
        END IF
      CASE CHR$(8), "\", "-", "/"
        IF LEN(Result$) > 0 THEN
          Result$ = LEFT$(Result$, LEN(Result$) - 1)
        END IF
      CASE ELSE
        IF LEN(Kbd$) > 0 THEN
           BEEP
        END IF
      END SELECT
  LOOP

  LOCATE Row, Col
  IF Result$ <> "" THEN PRINT Result$; " ";  ELSE PRINT "0 ";
  IF PlayerNum = 1 THEN
     IF Row = 2 THEN KEY 1, CHR$(27) + Result$ ELSE KEY 2, CHR$(27) + Result$
  END IF
  IF PlayerNum = 2 THEN
     IF Row = 2 THEN KEY 9, CHR$(27) + Result$ ELSE KEY 10, CHR$(27) + Result$
  END IF
  GetNum# = VAL(Result$)
  'IF Col < 40 THEN GetNum# = VAL(Result$) * INT(RND * 30)''add play1
END FUNCTION

'GorillaIntro:
'  Displays gorillas on screen for the first time
'  allows the graphical data to be put into an array
'Parameters:
'  Player1$, Player2$ - The names of the players
'
SUB GorillaIntro (Player1$, Player2$)
  LOCATE 16, 34: PRINT "--------------"
  LOCATE 18, 34: PRINT "V = View Intro"
  LOCATE 19, 34: PRINT "P = Play Game"
  LOCATE 21, 35: PRINT "Your Choice?"
  IF NOT autorun THEN
     DO WHILE Char$ = ""
        Char$ = INKEY$
     LOOP
  END IF

  IF Mode = 1 THEN
    x = 125
    y = 100
  ELSE
    x = 278
    y = 175
  END IF

  SCREEN Mode
  SetScreen

  IF Mode = 1 THEN Center 5, "Please wait while gorillas are drawn."

  VIEW PRINT 9 TO 24

  IF Mode = 9 THEN PALETTE OBJECTCOLOR, BackColor
 
  DrawGorilla x, y, ARMSDOWN
  CLS 2
  DrawGorilla x, y, LEFTUP
  CLS 2
  DrawGorilla x, y, RIGHTUP
  CLS 2
 
  VIEW PRINT 1 TO 25
  IF Mode = 9 THEN PALETTE OBJECTCOLOR, 46
 
  IF UCASE$(Char$) = "V" THEN
    Center 2, "Q B A S I C   G O R I L L A S"
    Center 5, "             STARRING:               "
    P$ = Player1$ + " AND " + Player2$
    Center 7, P$

    PUT (x - 13, y), GorD&, PSET
    PUT (x + 47, y), GorD&, PSET
    Rest 1

    PUT (x - 13, y), GorL&, PSET
    PUT (x + 47, y), GorR&, PSET
    'PLAY "t120o1l16b9n0baan0bn0bn0baaan0b9n0baan0b"
    Rest .3

    PUT (x - 13, y), GorR&, PSET
    PUT (x + 47, y), GorL&, PSET
    'PLAY "o2l16e-9n0e-d-d-n0e-n0e-n0e-d-d-d-n0e-9n0e-d-d-n0e-"
    Rest .3

    PUT (x - 13, y), GorL&, PSET
    PUT (x + 47, y), GorR&, PSET
    'PLAY "o2l16g-9n0g-een0g-n0g-n0g-eeen0g-9n0g-een0g-"
    Rest .3

    PUT (x - 13, y), GorR&, PSET
    PUT (x + 47, y), GorL&, PSET
    'PLAY "o2l16b9n0baan0g-n0g-n0g-eeen0o1b9n0baan0b"
    Rest .3

    FOR i = 1 TO 4
      PUT (x - 13, y), GorL&, PSET
      PUT (x + 47, y), GorR&, PSET
      'PLAY "T160O0L32EFGEFDC"
      Rest .1
      PUT (x - 13, y), GorR&, PSET
      PUT (x + 47, y), GorL&, PSET
      'PLAY "T160O0L32EFGEFDC"
      Rest .1
    NEXT
  END IF
END SUB

'Intro:
'  Displays game introduction
SUB Intro

  SCREEN 0
  WIDTH 80, 25
  MaxCol = 80
  COLOR 2, 0
  CLS
  Center 4, "Q B a s i c    G O R I L L A S (SE)"
  COLOR 7
  Center 6, "Copyright (C) Microsoft Corporation 1990"
  Center 8, "Your mission is to hit your opponent with the exploding"
  Center 9, "banana by varying the angle and power of your throw, taking"
  Center 10, "into account wind speed, gravity, and the city skyline."
  Center 11, "The wind speed is shown by a directional arrow at the bottom"
  Center 12, "of the playing field, its length relative to its strength."
  COLOR 5
  Center 13, "SE Version produced by Toyshop Studio 1999(v1.1)"
  COLOR 7
  Center 18, "ALT+X TO EXIT"
  Center 24, "E-mail:Toyclub@sina.com"

  'PLAY "MBT160O1L8CDEDCDL4ECC"
  SparklePause
  IF Mode = 1 THEN MaxCol = 40
END SUB

SUB inverse (x, y, i$)
FOR i = 1 TO 5
LOCATE y, x
PRINT SPACE$(LEN(i$))
Rest .02
LOCATE y, x
PRINT i$
Rest .02
NEXT
END SUB

'MakeCityScape:
'  Creates random skyline for game
'Parameters:
'  BCoor() - a user-defined type array which stores the coordinates of
'  the upper left corner of each building.
SUB MakeCityScape (BCoor() AS XYPoint)

  x = 2

  'Set the sloping trend of the city scape. NewHt is new building height
  Slope = FnRan(6)
  SELECT CASE Slope
    CASE 1: NewHt = 15                 'Upward slope Default=15
    CASE 2: NewHt = 30                 'Downward slope Default=130
    CASE 3 TO 5: NewHt = 25            '"V" slope - most common  Default=15
    CASE 6: NewHt = 130                 'Inverted "V" slope Default=130
    CASE ELSE
  END SELECT

  IF Mode = 9 THEN
    BottomLine = 335                   'Bottom of building
    HtInc = 10                         'Increase value for new height
    DefBWidth = 37                     'Default building height
    RandomHeight = 120                 'Random height difference
    WWidth = 3                         'Window width
    WHeight = 6                        'Window height
    WDifV = 15                         'Counter for window spacing - vertical
    WDifh = 10                         'Counter for window spacing - horizontal
  ELSE
    BottomLine = 10 '190
    HtInc = 6
    NewHt = NewHt * 20 \ 35            'Adjust for CGA
    DefBWidth = 18
    RandomHeight = 54
    WWidth = 1
    WHeight = 2
    WDifV = 5
    WDifh = 4
  END IF

  CurBuilding = 1
  DO
    
    SELECT CASE Slope
      CASE 1
        NewHt = NewHt + HtInc
      CASE 2
        NewHt = NewHt - HtInc
      CASE 3 TO 5
        IF x > ScrWidth \ 2 THEN
          NewHt = NewHt - 2 * HtInc
        ELSE
          NewHt = NewHt + 2 * HtInc
        END IF
      CASE 4
        IF x > ScrWidth \ 2 THEN
          NewHt = NewHt + 2 * HtInc
        ELSE
          NewHt = NewHt - 2 * HtInc
        END IF
      CASE ELSE
    END SELECT

    'Set width of building and check to see if it would go off the screen
    BWidth = FnRan(DefBWidth) + DefBWidth
    IF x + BWidth > ScrWidth THEN BWidth = ScrWidth - x - 2

    'Set height of building and check to see if it goes below screen
    Bheight = FnRan(RandomHeight) + NewHt
    IF Bheight < HtInc THEN Bheight = HtInc

    'Check to see if Building is too high
    IF BottomLine - Bheight <= MaxHeight + GHeight THEN Bheight = MaxHeight + GHeight - 5

    'Set the coordinates of the building into the array
    BCoor(CurBuilding).XCoor = x
    BCoor(CurBuilding).YCoor = BottomLine - Bheight

    IF Mode = 9 THEN BuildingColor = FnRan(3) + 4 ELSE BuildingColor = 2

    'Draw the building, outline first, then filled
    LINE (x - 1, BottomLine + 1)-(x + BWidth + 1, BottomLine - Bheight - 1), BACKGROUND, B
    LINE (x, BottomLine)-(x + BWidth, BottomLine - Bheight), BuildingColor, BF
    'Draw the windows
    c = x + 3
    'Bheight = Bheight / 2
    DO
      FOR i = Bheight - 3 TO 7 STEP -WDifV
        IF Mode <> 9 THEN
          WinColr = (FnRan(2) - 2) * -3
        ELSEIF FnRan(4) = 1 THEN
          WinColr = 8
        ELSE
          WinColr = WINDOWCOLOR
        END IF
        LINE (c, BottomLine - i)-(c + WWidth, BottomLine - i + WHeight), WinColr, BF
      NEXT
      c = c + WDifh
    LOOP UNTIL c >= x + BWidth - 3

    x = x + BWidth + 2

    CurBuilding = CurBuilding + 1

  LOOP UNTIL x > ScrWidth - HtInc

  LastBuilding = CurBuilding - 1

  'Set Wind speed
  wind = FnRan(10) - 5
  IF FnRan(3) = 1 THEN
    IF wind > 0 THEN
      wind = wind + FnRan(10)
    ELSE
      wind = wind - FnRan(10)
    END IF
  END IF
  IF night THEN wind = wind * 4
  IF wind > 50 THEN wind = 50       'wind too big
  IF wind < -50 THEN wind = -50
  'LOCATE 4, 1: PRINT wind
  'Draw Wind speed arrow
  IF wind <> 0 THEN
    WindLine = wind * 3 * (ScrWidth \ 320)
    'IF WindLine > 80 THEN 'Big wind!
    LINE (ScrWidth \ 2, ScrHeight - 5)-(ScrWidth \ 2 + WindLine, ScrHeight - 5), ExplosionColor
    IF wind > 0 THEN ArrowDir = -2 ELSE ArrowDir = 2
    LINE (ScrWidth / 2 + WindLine, ScrHeight - 5)-(ScrWidth / 2 + WindLine + ArrowDir, ScrHeight - 5 - 2), ExplosionColor
    LINE (ScrWidth / 2 + WindLine, ScrHeight - 5)-(ScrWidth / 2 + WindLine + ArrowDir, ScrHeight - 5 + 2), ExplosionColor
  END IF
END SUB

'PlaceGorillas:
'  PUTs the Gorillas on top of the buildings.  Must have drawn
'  Gorillas first.
'Parameters:
'  BCoor() - user-defined TYPE array which stores upper left coordinates
'  of each building.
SUB PlaceGorillas (BCoor() AS XYPoint)
    
  IF Mode = 9 THEN
    XAdj = 14
    YAdj = 30
  ELSE
    XAdj = 7
    YAdj = 16
  END IF
  SclX# = ScrWidth / 320
  SclY# = ScrHeight / 200
    
  'Place gorillas on second or third building from edge
  FOR i = 1 TO 2
    IF i = 1 THEN BNum = FnRan(2) + 1 ELSE BNum = LastBuilding - FnRan(2)

    BWidth = BCoor(BNum + 1).XCoor - BCoor(BNum).XCoor
    GorillaX(i) = BCoor(BNum).XCoor + BWidth / 2 - XAdj
    GorillaY(i) = BCoor(BNum).YCoor - YAdj
    PUT (GorillaX(i), GorillaY(i)), GorD&, PSET
  NEXT i

END SUB

'PlayGame:
'  Main game play routine
'Parameters:
'  Player1$, Player2$ - player names
'  NumGames - number of games to play
SUB PlayGame (Player1$, Player2$, NumGames)
  DIM BCoor(0 TO 30) AS XYPoint
  'DIM TotalWins(1 TO 2)
  DIM ttt AS DOUBLE
  J = 1
  FOR i = 1 TO NumGames
    
    CLS
    RANDOMIZE (TIMER)
    CALL MakeCityScape(BCoor())
    CALL PlaceGorillas(BCoor())
    DoSun SUNHAPPY
    Hit = false
    DO WHILE Hit = false
      J = 1 - J
      LOCATE 1, 1
      PRINT Player1$
      LOCATE 1, (MaxCol - 1 - LEN(Player2$))
      PRINT Player2$
      Tosser = J + 1: Tossee = 3 - J
      CLK
      'Tosser = 1 ->player1  Tosser = 2 ->player2
      IF Tosser = 1 THEN inverse 1, 1, Player1$ ELSE inverse MaxCol - 1 - LEN(Player2$), 1, Player2$ 'add
      'Plot the shot.  Hit is true if Gorilla gets hit.
      Hit = DoShot(Tosser, GorillaX(Tosser), GorillaY(Tosser))

      'Reset the sun, if it got hit
      IF SunHit THEN DoSun SUNHAPPY

      IF Hit = true THEN CALL UpdateScores(TotalWins(), Tosser, Hit)
    LOOP
    ttt = TIMER: WHILE TIMER - ttt < 1: WEND
  NEXT i

  SCREEN 0
  WIDTH 80, 25
  COLOR 7, 0
  MaxCol = 80
  CLS

  Center 8, "GAME OVER!"
  Center 10, "Score:"
  LOCATE 11, 30: PRINT Player1$; TAB(50); TotalWins(1)
  LOCATE 12, 30: PRINT Player2$; TAB(50); TotalWins(2)
  Center 24, "Press any key to continue"
  SparklePause
  COLOR 7, 0
  CLS
END SUB

'PlayGame:
'  Plots banana shot across the screen
'Parameters:
'  StartX, StartY - starting shot location
'  Angle - shot angle
'  Velocity - shot velocity
'  PlayerNum - the banana thrower
FUNCTION PlotShot (StartX, StartY, Angle#, Velocity, PlayerNum)

  Angle# = Angle# / 180 * pi#  'Convert degree angle to radians
  Radius = Mode MOD 7

  InitXVel# = COS(Angle#) * Velocity
  InitYVel# = SIN(Angle#) * Velocity

  oldx# = StartX
  oldy# = StartY
  oldx1# = oldx#

  'draw gorilla toss
  IF PlayerNum = 1 THEN
    PUT (StartX, StartY), GorL&, PSET
  ELSE
    PUT (StartX, StartY), GorR&, PSET
  END IF
  
  'throw sound
  IF music THEN PLAY "MBo0L32A-L64CL16BL64A+"
  Rest .1

  'redraw gorilla
  PUT (StartX, StartY), GorD&, PSET
  
  adjust = Scl(4)                   'For scaling CGA

  xedge = Scl(9) * (2 - PlayerNum)  'Find leading edge of banana for check

  Impact = false
  ShotInSun = false
  OnScreen = true
  PlayerHit = 0
  NeedErase = false

  StartXPos = StartX
  StartYPos = StartY - adjust - 3

  IF PlayerNum = 2 THEN
    StartXPos = StartXPos + Scl(25)
    direction = Scl(4)
  ELSE
    direction = Scl(-4)
  END IF

  IF Velocity < 2 THEN              'Shot too slow - hit self
    x# = StartX
    y# = StartY
    pointval = OBJECTCOLOR
  END IF
   
DO WHILE (NOT Impact) AND OnScreen
  Rest .01
  'Erase old banana, if necessary
  PSET (oldx1#, 340), 0         'add
  IF NeedErase THEN
    NeedErase = false
    CALL DrawBan(oldx#, oldy#, oldrot, false)
  END IF
  'X#,Y# is flying banana's (X,Y)
  x# = StartXPos + (InitXVel# * t#) + (.5 * (wind / 5) * t# ^ 2)
  y# = StartYPos + ((-1 * (InitYVel# * t#)) + (.5 * gravity# * t# ^ 2)) * (ScrHeight / 350)
 
  IF (x# >= ScrWidth - Scl(10)) OR (x# <= 3) OR (y# >= ScrHeight - 3) THEN
    OnScreen = false
  END IF

          
  IF OnScreen AND y# > 0 THEN

    'check it
    LookY = 0
    LookX = Scl(8 * (2 - PlayerNum))
    'fly the banana
    DO
      pointval = POINT(x# + LookX, y# + LookY)
      IF pointval = 0 THEN
        Impact = false          'toward have no object     'add
        IF ShotInSun = true THEN
          IF ABS(ScrWidth \ 2 - x#) > Scl(20) OR y# > SunHt THEN ShotInSun = false
        END IF
      ELSEIF pointval = SUNATTR AND y# < SunHt THEN
        IF NOT SunHit THEN DoSun SUNSHOCK
        SunHit = true
        ShotInSun = true
      ELSE
        Impact = true
      END IF
      LookX = LookX + direction
      LookY = LookY + Scl(6)
    LOOP UNTIL Impact OR LookX <> Scl(4)
   
    IF NOT ShotInSun AND NOT Impact THEN
      'plot it
      rot = (t# * 10) MOD 4
      CALL DrawBan(x#, y#, rot, true)
      NeedErase = true
    END IF
            
    oldx# = x#
    oldy# = y#
    oldrot = rot
  ELSE 'add
    PSET (x#, 340), 1
    oldx1# = x#
  END IF

      
  t# = t# + .1
  'LOCATE 1, 1: PRINT OBJECTCOLOR, Impact 'add
LOOP
  'INPUT "continue?", a$'add
  IF life(PlayerNum) <= 0 THEN PlayerHit = ExplodeGorilla(x#, y#) 'add
  PSET (oldx1#, 340), 0         'add
  PUT (StartX, StartY), GorD&, PSET'add
  IF pointval <> OBJECTCOLOR AND Impact THEN
    'INPUT "continue?", a$'add
    CALL DoExplosion(x# + adjust, y# + adjust, PlayerNum)
  ELSEIF pointval = OBJECTCOLOR OR life(PlayerNum) <= 0 THEN
    'INPUT "continue?", a$'add
    PlayerHit = ExplodeGorilla(x#, y#)
  END IF

  PlotShot = PlayerHit

END FUNCTION

'Rest:
'  pauses the program
SUB Rest (t#)
  s# = TIMER
  t2# = MachSpeed * t# / SPEEDCONST - .005
  DO
  'LOOP UNTIL TIMER - s# > .02
  LOOP UNTIL TIMER - s# > t2# * .1
END SUB

SUB restorekey (w)
SELECT CASE w
CASE 0
KEY 1, CHR$(27) + "DuYanJun"
KEY 2, CHR$(27) + "G.P"
KEY 3, CHR$(27) + "ZhuJuJun"
KEY 4, CHR$(27) + "MaZiSong"
KEY 5, CHR$(27) + "GuoWei"
KEY 6, CHR$(27) + "YuChang"
KEY 7, CHR$(27) + "JiaXu"
KEY 8, CHR$(27) + "P.Y.W."
KEY 9, CHR$(27) + "15"
KEY 10, CHR$(27) + "15"
CASE 1
KEY 1, CHR$(27) + "15"
KEY 2, CHR$(27) + "9.8"
KEY 3, CHR$(27) + "2"
KEY 4, CHR$(27) + "20"
KEY 5, CHR$(27) + "10"
KEY 6, CHR$(27) + "5"
KEY 7, CHR$(27) + "6"
KEY 8, CHR$(27) + "7"
CASE 2
KEY 1, CHR$(27) + "Night"
KEY 2, CHR$(27) + "Day"
KEY 3, CHR$(27) + "n"
KEY 4, CHR$(27) + "d"
KEY 5, CHR$(27) + ""
KEY 6, CHR$(27) + ""
KEY 7, CHR$(27) + ""
KEY 8, CHR$(27) + ""

CASE ELSE
END SELECT
END SUB

'Scl:
'  Pass the number in to scaling for cga.  If the number is a decimal, then we
'  want to scale down for cga or scale up for ega.  This allows a full range
'  of numbers to be generated for scaling.
'  (i.e. for 3 to get scaled to 1, pass in 2.9)
FUNCTION Scl (n!)

  IF n! <> INT(n!) THEN
      IF Mode = 1 THEN n! = n! - 1
  END IF
  IF Mode = 1 THEN
      Scl = CINT(n! / 2 + .1)
  ELSE
      Scl = CINT(n!)
  END IF

END FUNCTION

'SetScreen:
'  Sets the appropriate color statements
SUB SetScreen
    'IF night = false THEN IF RND > .4 THEN night = false ELSE night = true
    ExplosionColor = 2
    BackColor = 1
    IF NOT night THEN PALETTE 0, 1      'back color
    PALETTE 1, 46
    PALETTE 2, 44
    PALETTE 3, 54
    PALETTE 5, 7
    PALETTE 6, 4
    PALETTE 7, 3
    PALETTE 9, 45       'Display Color
END SUB

'SparklePause:
'  Creates flashing border for intro and game over screens
SUB SparklePause
       up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
       autorun = true
       COLOR 3, 1
       Center 15, "      " + CHR$(4) + " Start         "
       COLOR 7, 0
       Center 16, "       Option        "
      
  COLOR 4, 0
  a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
  'WHILE INKEY$ <> "": WEND 'Clear keyboard buffer
  DO
    COLOR 4, 0
    FOR a = 1 TO 5
      LOCATE 1, 1                             'print horizontal sparkles
      PRINT MID$(a$, a, 80);
      LOCATE 22, 1
      PRINT MID$(a$, 6 - a, 80);

      FOR B = 2 TO 21                         'Print Vertical sparkles
        c = (a + B) MOD 5
        IF c = 1 THEN
          LOCATE B, 80
          PRINT "*";
          LOCATE 23 - B, 1
          PRINT "*";
        ELSE
          LOCATE B, 80
          PRINT " ";
          LOCATE 23 - B, 1
          PRINT " ";
        END IF
      NEXT B
    NEXT a
    in$ = INKEY$
    IF in$ = up$ THEN
       autorun = true
       COLOR 3, 1
       Center 15, "      " + CHR$(4) + " Start         "
       COLOR 7, 0
       Center 16, "        Option        "
       END IF
    IF in$ = down$ THEN
       autorun = false
       COLOR 7, 0
       Center 15, "        Start         "
       COLOR 3, 1
       Center 16, "      " + CHR$(4) + " Option        "
    END IF
    IF in$ = CHR$(0) + CHR$(45) THEN END
    IF in$ = CHR$(13) THEN EXIT DO
  LOOP
END SUB

'UpdateScores:
'  Updates players' scores
'Parameters:
'  Record - players' scores
'  PlayerNum - player
'  Results - results of player's shot
SUB UpdateScores (Record(), PlayerNum, Results)
  'PRINT HITSELF, Record, PlayerNum, Results
  'END
  IF Results = HITSELF THEN
    Record(ABS(PlayerNum - 3)) = Record(ABS(PlayerNum - 3)) + 1
  ELSE
    Record(PlayerNum) = Record(PlayerNum) + 1
  END IF
END SUB

'VictoryDance:
'  gorilla dances after he has eliminated his opponent
'Parameters:
'  Player - which gorilla is dancing
SUB VictoryDance (Player)

  FOR i# = 1 TO 8
    PUT (GorillaX(Player), GorillaY(Player)), GorL&, PSET
    'PLAY "MFO0L32EFGEFDC"
    Rest .1
    PUT (GorillaX(Player), GorillaY(Player)), GorR&, PSET
    'PLAY "MFO0L32EFGEFDC"
    Rest .1
  NEXT
END SUB

