DECLARE SUB test ()
Dim Shared in As String
Dim Shared pw As Integer
'SHELL "c:\windows\alsinit c:\windows"
PCopy 0, 1
dosy = CsrLin
dosx = Pos(0)
'FOR y = 1 TO 23
'    FOR x = 1 TO 80
'        c = SCREEN(y, x)
'        COLOR 7, 1
'        LOCATE y, x
'        PRINT CHR$(c)
'    NEXT
'NEXT
If Command$ = "41971693993751058209749445923078164062862089986280348253421170679" Then pw = -1
test
y = 10
x = 25
If Command$ = "41971693993751058209749445923078164062862089986280348253421170679" Then End
For a = y + 1 To y + 3
    For b = x + 1 To x + 30
        c = Screen(a, b)
        Color 8, 0
        Locate a, b
        Print Chr$(c)
    Next
Next
Color 7, 4
Locate y, x
Print "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
Locate y + 1, x
d$ = "d"
p$ = Chr$(80) + "a" + String$(2, 115) + Chr$(119) + "or" + d$
Print "º  " + p$ + ":                 º"
Locate y + 2, x
Print "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
l = 0
Do
    in = Input$(1)
    If in >= " " And in <= "~" And Len(s$) < 15 Then
        l = l + 1
        Locate y + 1, l + x + 12
        Print "*";
        s$ = s$ + in
    End If
    If in = Chr$(13) Then
        If s$ = "/" + "286" Then
            PCopy 1, 0: Locate dosy, dosx: Exit Do
        End If
    End If
    If in = Chr$(8) And Len(s$) > 0 Then
        Locate y + 1, l + x + 12
        Print " ";
        s$ = Left$(s$, Len(s$) - 1)
        l = l - 1
    End If
Loop

test
a$ = Input$(1)
If a$ = Chr$(13) Then
    'LOCATE 21, 20: COLOR 7, 1: PRINT " "
    'LOCATE 21, 21: COLOR 0, 7: PRINT "   OK   "
    'LOCATE 22, 21: COLOR 7, 1: PRINT STRING$(8, 32)
    'T = TIMER
    'WHILE TIMER - T < .2: WEND
    'LOCATE 21, 20: COLOR 0, 7: PRINT "   OK   "
    'LOCATE 22, 21: COLOR 0, 1: PRINT STRING$(8, 223)
    'LOCATE 21, 28: PRINT "Ü"
    PCopy 1, 0
    Locate dosy, dosx
    End
End If
PCopy 1, 0
Data 789632145
Data 214322193,21312312312,12323232,565,565756432,12345678,234343245,132321,837647,1415926

Sub test
    If pw Then p$ = "Disabled" Else p$ = "Enabled "
    Locate 1, 1
    Color 7, 1
    Print "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ Toyshop & Toyclub Studio(TM) 1999 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
    Color 0, 3
    'LOCATE 1, 23
    'PRINT "??????? & ??????? Studio(TM) 1999"
    Color 7, 1
    Print "º                        Microsoft Windows95.400.950                           º"
    Print "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    Print "º                                           ³                                  º"
    Print "º  BIOS Version:Award Modular Bios V4.15P   ³   CPU Internal Cache : Enabled   º"
    Print "º  Twantr5510 AIO Ver 2.4 05/09/1996        ³       External Cache : Enabled   º"
    Print "º        Conventional memory                ³   L2 Cache SRAM Type : Pipeline  º"
    Print "º                       Total:640K          ³         Cache Memory : 256K      º"
    Print "º                   Available:616K          ³    Video BIOS shadow : Enabled   º"
    Print "º                             630880bytes   ³   C8000-CBFFF shadow : Enabled   º"
    Print "º        Extenden Memory                    ³   CC000-CFFFF shadow : Enabled   º"
    Print "º                       Total:15360K        ³ PCI/VGA Palette Snoop: Enabled   º"
    Print "º                   Total UMB:90K           ³                                  º"
    Print "º              Total Free UMB:13K           ³                                  º"
    Print "º           Largest Freeblock:6K            ³                                  º"
    Print "º        Expanded Memory (EMS)              ³                                  º"
    Print "º                 LIM Version:4.00          ³                                  º"
    Print "º          Page Frame Address:E000H         ³                                  º"
    Print "º   Pri.Master Disk : LBA,Mode 4,1284MB     ³                                  º"
    Print "º               CPU : Pentium(S) at 166MHz  ³            Password : "; p$; "   º"
    Print "º                                           ³                                  º"
    Print "º                                           ³                                  º"
    Print "º                                           ³                                  º"
    Print "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼";

    'LOCATE 21, 20: COLOR 0, 7: PRINT "   OK   "
    'LOCATE 22, 21: COLOR 0, 1: PRINT STRING$(8, 223)
    'LOCATE 21, 28: PRINT "Ü"
    'LOCATE 22, 15: COLOR 7, 1: PRINT "Toyshop studio"

End Sub

