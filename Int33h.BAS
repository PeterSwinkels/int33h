DEFINT A-Z

TYPE RegistersStr
 ax AS INTEGER
 cx AS INTEGER
 dx AS INTEGER
 bx AS INTEGER
END TYPE

DECLARE FUNCTION LoadWrapper$ ()
DECLARE SUB CallInt33h ()

DIM SHARED Int33h AS STRING
DIM SHARED Registers AS RegistersStr

 CLS
 Int33h = LoadWrapper$

 Registers.ax = &H1
 Registers.cx = &H0
 Registers.dx = &H0
 Registers.bx = &H0
 CallInt33h

 DO
  Registers.ax = &H3
  Registers.cx = &H0
  Registers.dx = &H0
  Registers.bx = &H0
  CallInt33h
  LOCATE 1, 1: PRINT Registers.cx, Registers.dx, " ";
 LOOP WHILE INKEY$ = ""
 
END

SUB CallInt33h
 DEF SEG = VARSEG(Int33h)
 CALL ABSOLUTE(Registers, SADD(Int33h))
END SUB

FUNCTION LoadWrapper$
DIM FileH AS INTEGER

 FileH = FREEFILE
 OPEN "Int33h.BIN" FOR INPUT LOCK READ WRITE AS FileH
 CLOSE FileH

 FileH = FREEFILE
 OPEN "Int33h.BIN" FOR BINARY LOCK READ WRITE AS FileH
  Int33h = INPUT$(LOF(FileH), FileH)
 CLOSE FileH

 LoadWrapper$ = Int33h
END FUNCTION

