fd% = 0
argvZero$ = "closest_nums"
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
DIM diffs%(n% - 2)
FOR i% = 0 TO DIM(diffs%(), 1)
  diffs%(i%) = arr%(i% + 1) - arr%(i%)
NEXT i%
PROCprintArray(diffs%())
absDiff% = FNfind_min(diffs%())
FOR i% = 0 TO DIM(diffs%(), 1)
  IF diffs%(i%) = absDiff% THEN PRINT; arr%(i%) ", "; arr%(i% + 1)
NEXT i%
END
:
DEF PROCerror
  IF fd% <> 0 THEN CLOSE#fd%
  REPORT: PRINT " at line "; ERL: END
ENDPROC
:
DEF FNstrtok_int(RETURN intString$)
  LOCAL res%
  res% = VAL(LEFT$(intString$, INSTR(intString$, " ") - 1))
  intString$ = MID$(intString$, INSTR(intString$, " ") + 1)
= res%
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
DEF FNmin(a%, b%)
  IF a% < b% THEN
    = a%
  ELSE
    = b%
ENDIF
:
DEF FNfind_min(s%())
  LOCAL min%, i%
  min% = s%(0)
  FOR i% = 1 TO DIM(s%(), 1)
    min% = FNmin(min%, s%(i%))
  NEXT i%
= min%
:
DEF PROCprintArray(s%())
  LOCAL i%
  FOR i% = 0 TO DIM(s%(), 1)
    PRINT ;s%(i%) SPC1;
  NEXT i%
  PRINT '
ENDPROC
