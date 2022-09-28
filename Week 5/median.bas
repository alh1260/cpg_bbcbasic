fd% = 0
argvZero$ = "median"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
n% = VAL(GET$#fd%)
arrStr$ = GET$#fd%
DIM arr%(n% - 1)
FOR i% = 0 TO DIM(arr%(), 1)
  arr%(i%) = FNstrtok_int(arrStr$)
NEXT i%
CLOSE#fd%
PROCbubblesort(arr%())
PRINT; arr%(n% DIV 2)
END
:
DEF PROCerror
  IF fd% <> 0 THEN CLOSE#fd%
  REPORT: PRINT " at line "; ERL: END
ENDPROC
:
DEF PROCbubblesort(s%())
  LOCAL i%, j%
  FOR i% = 0 TO DIM(s%(), 1) - 1
    FOR j% = 0 TO DIM(s%(), 1) - 1
      IF s%(j%) > s%(j% + 1) THEN SWAP s%(j%), s%(j% + 1)
    NEXT j%
  NEXT i%
ENDPROC
:
DEF FNstrtok_int(RETURN intString$)
  LOCAL res%
  res% = VAL(LEFT$(intString$, INSTR(intString$, " ") - 1))
  intString$ = MID$(intString$, INSTR(intString$, " ") + 1)
= res%
