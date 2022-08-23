REM > speeding
fd% = 0
argvZero$ = "speeding"
ON ERROR PROCerror
SYS "OS_GetEnv" TO argv$
argvOne$ = MID$(argv$, INSTR(argv$, argvZero$) + LEN argvZero$ + 2)
fd% = OPENIN(argvOne$)
segmentConfig$ = GET$#fd%
n% = FNstrtok_int(segmentConfig$)
m% = FNstrtok_int(segmentConfig$)
DIM roadConfig$(n%)
DIM journeyConfig$(m%)
FOR i% = 0 TO DIM(roadConfig$(), 1) - 1
  roadConfig$(i%) = GET$#fd%
NEXT i%
FOR j% = 0 TO DIM(journeyConfig$(), 1) - 1
  journeyConfig$(j%) = GET$#fd%
NEXT j%
CLOSE#fd%
DIM road%(100)
DIM journey%(100)
currentPos% = 0
FOR i% = 0 TO DIM(roadConfig$(), 1) - 1
  PROCfill_segment(road%(), roadConfig$(i%), currentPos%)
NEXT i%
currentPos% = 0
FOR j% = 0 TO DIM(journeyConfig$(), 1) - 1
  PROCfill_segment(journey%(), journeyConfig$(j%), currentPos%)
NEXT j%
speedDiff% = 0
FOR i% = 0 TO 99
  newDiff% = journey%(i%) - road%(i%)
  IF newDiff% > speedDiff% THEN speedDiff% = newDiff%
NEXT i%
PRINT speedDiff%
END
:
REM boilerplate functions and procedures
REM catch-all error handler
DEF PROCerror
  IF fd% <> 0 THEN CLOSE#fd%
  REPORT: PRINT " at line "; ERL: END
ENDPROC
:
REM split up a space separated string into ints.
REM just like the real strtok, this mutates the string
DEF FNstrtok_int(RETURN intString$)
  LOCAL res%
  res% = VAL(LEFT$(intString$, INSTR(intString$, " ") - 1))
  intString$ = MID$(intString$, INSTR(intString$, " ") + 1)
= res%
:
REM fill a segment of an array from a given position
DEF PROCfill_segment(arr%(), conf$, RETURN pos%)
  LOCAL i%, dist%, speed%, end%
  dist% = FNstrtok_int(conf$)
  speed% = FNstrtok_int(conf$)
  end% = pos% + dist% - 1
  FOR i% = pos% TO end%
    arr%(i%) = speed%
  NEXT i%
  pos% = i%
ENDPROC
