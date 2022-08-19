REM > cowsig
fd% = 0
argvZero$ = "cowsig"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
config$ = GET$#fd%
m% = FNstrtok_int(config$)
n% = FNstrtok_int(config$)
k% = FNstrtok_int(config$)
DIM ogSig$(m%)
FOR i% = 0 TO m% - 1
  IF NOT EOF#fd% THEN
    ogSig$(i%) = GET$#fd%
  ENDIF
NEXT i%
CLOSE#fd%
DIM ampSig$(k% * m%)
idx% = 0
FOR a% = 0 TO m% - 1
  ampString$ = FNbuild_string(ogSig$(a%), k%)
  FOR b% = 1 TO k%
    ampSig$(idx%) = ampString$
    idx% += 1
  NEXT b%
NEXT a%
FOR c% = 0 TO DIM(ampSig$(), 1) - 1
  PRINT ampSig$(c%)
NEXT c%
END
:
DEF PROCerror
  IF fd% <> 0 THEN CLOSE#fd%
  REPORT: PRINT " at line "; ERL
ENDPROC
:
DEF FNstrtok_int(RETURN intString$)
  LOCAL res%
  res% = VAL(LEFT$(intString$, INSTR(intString$, " ") - 1))
  intString$ = MID$(intString$, INSTR(intString$, " ") + 1)
= res%
:
DEF FNstrtok_char(RETURN s$)
  LOCAL res$
  res$ = LEFT$(s$, 1)
  s$ = RIGHT$(s$, LEN(s$) - 1)
= res$
:
REM non-destructive version of strtok_char()
DEF FNstrtok_char_nd(s$)
  LOCAL res$
  res$ = LEFT$(s$, 1)
= res$
:
DEF FNbuild_string(ogString$, k%)
  LOCAL buildString$, segment$, currentChar$, fetchedChar$
  buildString$ = ""
  WHILE LEN(ogString$) > 0
    currentChar$ = FNstrtok_char_nd(ogString$)
    segment$ = ""
    REPEAT
      fetchedChar$ = FNstrtok_char(ogString$)
      segment$ += fetchedChar$
      currentChar$ = FNstrtok_char_nd(ogString$)
    UNTIL ASC(currentChar$) <> ASC(fetchedChar$)
    buildString$ += STRING$(k%, segment$)
  ENDWHILE
= buildString$
