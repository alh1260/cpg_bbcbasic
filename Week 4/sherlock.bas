fd% = 0
argvZero$ = "sherlock"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
tStr$ = GET$#fd%
t% = VAL(tStr$)
FOR tItr% = 0 TO t% - 1
  n% = VAL(GET$#fd%)
  arr$ = GET$#fd%
  result$ = FNbalanced_sums(n%, arr$)
  PRINT result$
NEXT tItr%
CLOSE#fd%
END
:
DEF PROCerror
  IF fd% <> 0 THEN CLOSE#fd%
  REPORT: PRINT " at line "; ERL: END
ENDPROC
:
DEF FNbalanced_sums(n%, arrStr$)
  IF n% = 0 THEN
    = "YES"
  ENDIF
  LOCAL arr%()
  DIM arr%(n%)
  FOR a% = 0 TO n% - 1
    arr%(a%) = FNstrtok_int(arrStr$)
  NEXT a%
  FOR i% = 0 TO DIM(arr%(), 1) - 1
    leftSum% = 0
    rightSum% = 0
    IF i% > 0 THEN
      FOR j% = 0 TO i% - 1
        leftSum% += arr%(j%)
      NEXT j%
    ENDIF
    IF i% < DIM(arr%(), 1) - 1 THEN
      FOR k% = i% + 1 TO DIM(arr%(), 1) - 1
        rightSum% += arr%(k%)
      NEXT k%
    ENDIF
    IF leftSum% = rightSum% THEN
      = "YES"
    ENDIF
  NEXT i%
= "NO"
:
DEF FNstrtok_int(RETURN intString$)
  LOCAL res%
  res% = VAL(LEFT$(intString$, INSTR(intString$, " ") - 1))
  intString$ = MID$(intString$, INSTR(intString$, " ") + 1)
= res%
