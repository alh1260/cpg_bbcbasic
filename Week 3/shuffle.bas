fd% = 0
argvZero$ = "shuffle"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
N% = VAL(GET$#fd%)
shflStr$ = GET$#fd%
DIM shfl%(N% - 1): REM it's N - 1 to be N elements exactly. BASIC is weird
FOR i% = 0 TO DIM(shfl%(), 1)
  shfl%(i%) = FNstrtok_int(shflStr$)
NEXT i%
allCows$ = GET$#fd%
DIM cows$(N% - 1)
FOR i% = 0 TO DIM(cows$(), 1)
  cows$(i%) = FNstrtok_str(allCows$)
NEXT i%
CLOSE#fd%
DIM cowsTemp$(N% - 1)
FOR j% = 1 TO 3
  PROCshuffle(cows$(), cowsTemp$(), shfl%())
  SWAP cows$(), cowsTemp$(): REM somehow I need to swap outside the proc
NEXT j%
FOR i% = 0 TO DIM(cows$(), 1)
  PRINT cows$(i%)
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
REM splits a space-separated string (like the real strtok)
DEF FNstrtok_str(RETURN string$)
  LOCAL res$
  res$ = LEFT$(string$, INSTR(string$, " ") - 1)
  string$ = MID$(string$, INSTR(string$, " ") + 1)
= res$
:
REM perform a single bovine shuffle in reverse
DEF PROCshuffle(RETURN a$(), RETURN tmp$(), s%())
  LOCAL i%
  FOR i% = 0 TO DIM(s%(), 1)
    tmp$(i%) = a$(s%(i%) - 1)
  NEXT i%
ENDPROC
