fd% = 0
argvZero$ = "sqpas"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
penOne$ = GET$#fd%:REM should be the first line
penTwo$ = GET$#fd%
CLOSE#fd%
REM let the bullshit begin!
xOne% = FNstrtok_int(penOne$)
yOne% = FNstrtok_int(penOne$)
xTwo% = FNstrtok_int(penOne$)
yTwo% = FNstrtok_int(penOne$)
REM now the second pen (holy shit!)
xThree% = FNstrtok_int(penTwo$)
yThree% = FNstrtok_int(penTwo$)
xFour% = FNstrtok_int(penTwo$)
yFour% = FNstrtok_int(penTwo$)
REM now to find the mins and maxes
xMax% = FNfind_max(xOne%, xTwo%, xThree%, xFour%)
xMin% = FNfind_min(xOne%, xTwo%, xThree%, xFour%)
yMax% = FNfind_max(yOne%, yTwo%, yThree%, yFour%)
yMin% = FNfind_min(yOne%, yTwo%, yThree%, yFour%)
maxDim% = FNmax(xMax% - xMin%, yMax% - yMin%)
PRINT maxDim%^2
fd% = OPENOUT("$.square/out")
BPUT#fd%, STR$(maxDim%^2)
CLOSE#fd%
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
DEF FNmax(a%, b%)
  IF a% > b% THEN
    = a%
  ELSE
    = b%
ENDIF
:
DEF FNmin(a%, b%)
  IF a% < b% THEN
    = a%
  ELSE
    = b%
ENDIF
:
DEF FNfind_max(a%, b%, c%, d%)
  LOCAL max%
  max% = a%
  max% = FNmax(max%, b%): REM should either be a or b now
  max% = FNmax(max%, c%): REM should be prev max or c now
  max% = FNmax(max%, d%)
= max%
:
DEF FNfind_min(a%, b%, c%, d%)
  LOCAL min%
  min% = a%
  min% = FNmin(min%, b%)
  min% = FNmin(min%, c%)
  min% = FNmin(min%, d%)
= min%
