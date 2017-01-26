### Computes the first 25 elements of the Fibonacci sequence
### R3 is reserved for results
### R4 is reserved for acc
### R5 is always for loading and using constants
### R6 is reserved for printing

# Major steps (i.e. "function calls")
## Major impl steps
### Minor impl steps

# R1 = 0
LOADC R1, 0
# Print R1
## Load divisor and offset
LOADC R5, 10
LOADC R6, 48
## Calc digit 5
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0000, R4
DIV R2, R5, R1
## Calc digit 4
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0002, R4
DIV R2, R5, R1
## Calc digit 3
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0004, R4
DIV R2, R5, R1
## Calc digit 2
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0006, R4
DIV R2, R5, R1
## Calc digit 1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0008, R4
DIV R2, R5, R1
## Print digit 1, 2, 3, 4, then 5
CPRINT 0x0008
CPRINT 0x0006
CPRINT 0x0004
CPRINT 0x0002
CPRINT 0x0000

# R1 = 1
LOADC R1, 1
# Print R1
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0000, R4
DIV R2, R5, R1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0002, R4
DIV R2, R5, R1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0004, R4
DIV R2, R5, R1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0006, R4
DIV R2, R5, R1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0008, R4
DIV R2, R5, R1
CPRINT 0x0008
CPRINT 0x0006
CPRINT 0x0004
CPRINT 0x0002
CPRINT 0x0000

# R1 = 0
LOADC R1, 0x0000
# R2 = 1
LOADC R2, 0x0002
# R4 = 2 (Printed 2 of 25 elements)
LOADC R4, 2
# R3 = R1 + R2
ADD R1, R2, R3

# if R4 = 25
LOADC R1, 25
EQ R5, R1, R4
## "break" / "exit"
GOTOIF 0x0204, R5
# else print R3
## Save reg state
STORE 0x0010, R1
STORE 0x0012, R2
STORE 0x0014, R3
STORE 0x0016, R4
STORE 0x0018, R5
STORE 0x001a, R6
## Load all zeros
LOAD R1, 0x0020
LOAD R2, 0x0022
LOAD R3, 0x0024
LOAD R4, 0x0026
LOAD R5, 0x0028
LOAD R6, 0x002a
## R1 = old R3
LOAD 0x0014, R1
## Load divisor and offset
LOADC R5, 10
LOADC R6, 48
## Calc digit 5
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0000, R4
DIV R2, R5, R1
## Calc digit 4
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0002, R4
DIV R2, R5, R1
## Calc digit 3
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0004, R4
DIV R2, R5, R1
## Calc digit 2
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0006, R4
DIV R2, R5, R1
## Calc digit 1
DIV R1, R5, R2
SUB R1, R2, R3
ADD R3, R6, R4
STORE 0x0008, R4
DIV R2, R5, R1
## Print digit 1, 2, 3, 4, then 5
CPRINT 0x0008
CPRINT 0x0006
CPRINT 0x0004
CPRINT 0x0002
CPRINT 0x0000
## Restore reg state
LOAD R1, 0x0010
LOAD R2, 0x0012
LOAD R3, 0x0014
LOAD R4, 0x0016
LOAD R5, 0x0018
LOAD R6, 0x001a
# R1 = R2
ADD R2, R5, R1
# R2 = R3
ADD R3, R5, R2
# increment R4
LOADC R5, 1
ADD R5, R4, R4
# loop
GOTO 0x0082
# done
EXIT
