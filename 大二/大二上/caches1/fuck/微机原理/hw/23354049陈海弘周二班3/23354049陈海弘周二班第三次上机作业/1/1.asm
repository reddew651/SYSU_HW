DATA_SEG SEGMENT
DB 51H, 3AH, 95H, 8DH, 90H, 0A7H, 0C1H, 77H, 24H, 0B1H
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG

START: 
MOV AX, DATA_SEG
MOV DS, AX
MOV SI, 0
MOV CX, 10
MOV BX, 0   ;BX COUNTS HIGH BITS
MOV DX, 0   ;DX COUNTS LOW BITS

NEXT_BYTE:
MOV AL, [SI]   ;LOAD ONE BYTE FROM MEMORY TO AL
CALL COUNT_BITS
INC SI        ;MOVE TO NEXT
LOOP NEXT_BYTE

MOV AX, DATA_SEG
MOV DS, AX
MOV [0H], BL  ;STORES THE HB TO BX, ACTUALLY THE 3000H MEANS THE 0710:0000
MOV [100H], DL ;SAME WAY
HLT

COUNT_BITS PROC
PUSH CX
PUSH AX
MOV CL, 8
MOV AH, 0

COUNT_LOOP:
ROR AL, 1   ;ROTATE AL RIGHT, MOVE 1 BIT
JNC LOW_COUNT    ;IF CARRAY 0, GO TO LOW
INC BX           ;IF 1, INCREASE BX
JMP CONTINUE

LOW_COUNT:
INC DX

CONTINUE:
DEC CL
JNZ COUNT_LOOP

POP AX
POP CX
RET
COUNT_BITS ENDP

CODE_SEG ENDS
END START

;ALL EXPLAINATION WRITTEN BY CHEN HAIHONG