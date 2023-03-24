DECLARE SUB RESETpc ()
DECLARE SUB w (tt!)
DECLARE SUB show (c$)
DIM dosshell AS STRING
DIM dos AS INTEGER
RANDOMIZE TIMER
IF COMMAND$ = "APPLE II" THEN COLOR 2
RESETpc
DO
dos = 1
SELECT CASE RND * 10
CASE IS > 9
     dosshell = "copy/?"
CASE IS > 8
     dosshell = "dir/?"
CASE IS > 7
     dosshell = "type/?"
CASE IS > 6
     dosshell = "time/?"
CASE IS > 5
     dosshell = "date/?"
CASE IS > 4
     dosshell = "prompt $p$g"
CASE IS > 3
     dosshell = "echo Hello"
CASE IS > 2
     dosshell = "vol"
CASE IS > 1
     dosshell = "ver"
CASE IS > .8
     dos = 0
     dosshell = "chmod -rwx ext2fs /mnt/mount/ntfs readonly /tmp/lilo.conf"
CASE IS > .6
     dosshell = "mem"
CASE IS > .4
     dosshell = "dir"
CASE ELSE
     dosshell = "cls"
END SELECT
show dosshell
IF dos THEN SHELL "" + dosshell
LOOP UNTIL INKEY$ <> ""

SUB RESETpc
CLS
LOCATE 1, 1, 1
SOUND 237, .1
FOR i = 0 TO 16384 STEP 2
    LOCATE 2, 1
    PRINT USING "Testing memory ##### bytes"; i;
NEXT
PRINT " OK."
PRINT
w 1
CLS
PRINT "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT "º Co-Processor      : Installed           Extended Memory   :  15360K          º": w .02
PRINT "º CPU Clock         : 133MHz              Cache Memory      :    256K          º": w .02
PRINT "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶": w .02
PRINT "º Diskette Drive  A : 1.44M  3.5 in.      Display Type      : EGA/VGA          º": w .02
PRINT "º Diskette Drive  B : None                Serial Port(s)    : 3F8 2F8          º": w .02
PRINT "º Pri. Master  Disk : LBA  Mode 4  1284MB Parallel Port(s)  : 378              º": w .02
PRINT "º Pri. Slave   Disk : None                Bank0 EDO DRAM    : Yes              º": w .02
PRINT "º Sec. Master  Disk : None                Bank1 EDO DRAM    : No               º": w .02
PRINT "º Sec. Slave   Disk : None                L2 Cache SRAM Type: Pipeline         º": w .02
PRINT "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
PRINT : PRINT
w .5
PRINT "Starting MS-DOS..."
LOCATE CSRLIN, 1, 1
w 2
PRINT
PRINT "Gscdrom initing complete."
w 1
PRINT "Alsound inited."
PRINT "Device E:=Mscd001"
PRINT
PRINT "Windows 98 [Version 4.10.1999] by Toyshop Studio(TM)"
PRINT
w .5
PRINT "C:\>";
LOCATE CSRLIN, 5, 1
w RND * 4
LOCATE CSRLIN, 1, 1
END SUB

SUB show (c$)
IF CSRLIN > 23 THEN PRINT
PRINT "C:\>";
w RND * 4
FOR i = 1 TO LEN(c$)
    PRINT MID$(c$, i, 1);
    IF COMMAND$ <> "" THEN SOUND 37, .1
    w RND / 2
NEXT
PRINT
w RND / 2
PRINT
END SUB

SUB w (tt)
t = TIMER
WHILE TIMER - t < tt: WEND
END SUB

