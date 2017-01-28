### Reads in a Fahrenheit and prints the Celsius conversion.
### The output number will truncate / buffer to five digits.

# Major steps (i.e. "function calls")
## Major impl steps
### Minor impl steps

# Read input to R1
## Read digit char
CREAD 0x0001
LOAD R2, 0x0000
### If R2 == '\n' end loop
LOADC R6, 10 # '\n'
EQ R2, R6, R3
GOTOIF 0x002c, R3 # TODO:
### Ascii offset
LOADC R6, 48
SUB R2, R6, R2
### Add in new int as ones digit
LOADC R6, 10 # '\n'
MUL R1, R6, R1
ADD R1, R2, R1
### Loop
GOTO 0x0000
# Convert R1 to celsius
## R1 -= 32
LOADC R6, 32
SUB R1, R6, R1
## R1 *= 5
LOADC R6, 5
MUL R1, R6, R1
## R1 /= 9
LOADC R6, 9
DIV R1, R6, R1
# Print R1
## Calc digit 5
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
MUL R2, R5, R3
SUB R1, R3, R4
ADD R4, R6, R5
STORE 0x0000, R5
LOADC R1, 0
ADD R1, R2, R1
## Calc digit 4
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
MUL R2, R5, R3
SUB R1, R3, R4
ADD R4, R6, R5
STORE 0x0002, R5
LOADC R1, 0
ADD R1, R2, R1
## Calc digit 3
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
MUL R2, R5, R3
SUB R1, R3, R4
ADD R4, R6, R5
STORE 0x0004, R5
LOADC R1, 0
ADD R1, R2, R1
## Calc digit 2
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
MUL R2, R5, R3
SUB R1, R3, R4
ADD R4, R6, R5
STORE 0x0006, R5
LOADC R1, 0
ADD R1, R2, R1
## Calc digit 1
LOADC R5, 10
LOADC R6, 48
DIV R1, R5, R2
MUL R2, R5, R3
SUB R1, R3, R4
ADD R4, R6, R5
STORE 0x0008, R5
LOADC R1, 0
ADD R1, R2, R1
## Print digit 1, 2, 3, 4, 5, then '\n'
CPRINT 0x0009
CPRINT 0x0007
CPRINT 0x0005
CPRINT 0x0003
CPRINT 0x0001
EXIT
