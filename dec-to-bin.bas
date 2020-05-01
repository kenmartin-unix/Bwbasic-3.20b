    5 REM input a number, output its binary representation
   10 CALL SHELL("cls")
   50 INPUT "Enter an integer greater than zero : ";A
   60 IF (A < 0 OR A<>INT(A)) GOTO 50
   65 IF (A = 0) GOTO 140
   70 LET B = A - INT (A/2) * 2
   90 LET X$ = STR$(B) + X$
  110 LET A = (A - B) / 2
  120 IF (A > 0) GOTO 70
  125 PRINT
  130 PRINT "As binary: ";X$
  135 PRINT
  140 END

