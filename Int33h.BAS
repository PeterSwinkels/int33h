DEFINT A-Z

TYPE RegistersStr
 ax AS INTEGER
 cx AS INTEGER
 dx AS INTEGER
 bx AS INTEGER
END TYPE

DECLARE FUNCTION LoadInt33h$ ()
DECLARE SUB CallInt33h (Registers AS RegistersStr)

DIM Registers AS RegistersStr
DIM SHARED Int33h AS STRING

 CLS
 Int33h = LoadInt33h$

 Registers.ax = &H0
 Registers.cx = &H0
 Registers.dx = &H0
 Registers.bx = &H0
 CallInt33h Registers
 IF Registers.ax = 0 THEN
  PRINT "No mouse!"
  END
 END IF

 Registers.ax = &H7
 Registers.cx = 0
 Registers.dx = 639
 CallInt33h Registers
 Registers.ax = &H8
 Registers.cx = 0
 Registers.dx = 199
 CallInt33h Registers

 Registers.ax = &H1
 Registers.cx = &H0
 Registers.dx = &H0
 Registers.bx = &H0
 CallInt33h Registers

 DO
  Registers.ax = &H3
  Registers.cx = &H0
  Registers.dx = &H0
  Registers.bx = &H0
  CallInt33h Registers
  LOCATE 1, 1: PRINT USING "b: ###   x: ###, y: ###"; Registers.bx; Registers.cx; Registers.dx
 LOOP WHILE INKEY$ = ""
 
END

SUB CallInt33h (Registers AS RegistersStr)
 DEF SEG = VARSEG(Int33h)
 CALL ABSOLUTE(Registers, SADD(Int33h))
END SUB

FUNCTION LoadInt33h$
DIM FileH AS INTEGER

 FileH = FREEFILE
 OPEN "Int33h.BIN" FOR INPUT LOCK READ WRITE AS FileH
 CLOSE FileH

 FileH = FREEFILE
 OPEN "Int33h.BIN" FOR BINARY LOCK READ WRITE AS FileH
  Int33h = INPUT$(LOF(FileH), FileH)
 CLOSE FileH

 LoadInt33h$ = Int33h
END FUNCTION

