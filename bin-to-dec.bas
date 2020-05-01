   10 CALL SHELL("cls")
  100 LET P = 0
    : LET S = 0
  110 INPUT "Enter binary number: ";N$
  120 L = LEN (N$)
    : IF L=0 GOTO 300
  130 FOR I=1 TO L
  135   IF (N$ = "0") GOTO 1000
  140   LET B$ = MID$(N$, L-I+1, 1)
  150   IF NOT (B$ = "0" OR B$ = "1") GOTO 300
  160   LET K = VAL(B$)
  170   IF (K > 0) THEN
    :     S = S + 2 ^ P
    :   END IF
  180   LET P = P + 1
  190 NEXT
  200 GOTO 310
  300 PRINT "Error, invalid binary entered"
    : GOTO 100
  310 PRINT
  315 PRINT "Equals decimal ";S
  320 PRINT
 1000 END

