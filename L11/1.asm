.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  n dd 5
  s dd 0
  i dd 1
  x dd ?

.CODE
main:
  FLDZ
  FLD1
  mov ecx, 1
cycle:
  FILD i
  FILD i
  FMUL
  FDIVR ST(0), ST(1)
  FADDP ST(2), ST(0)
; FSTP x            ; удалить?
  inc ecx
  inc i
  cmp ecx, n
  jbe cycle
  
  FXCH ST(1)
  FSTP s
 
  push 0
  call exit
  
END main
