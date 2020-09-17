.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  n dd ?
  ar_x dq 10 dup(0)
  ar_y dq 10 dup(0)
  format_n db "%d", 0
  format_in db "%lf%lf", 0
  format_out db "P = %lf", 0
  P dq 0

.CODE
main:
  push offset n
  push offset format_n
  call scanf
  add esp, 8
  
  mov ecx, 0
input:
  pusha
  lea eax, ar_y[8*ecx]
  push eax
  lea eax, ar_x[8*ecx]
  push eax
  push offset format_in
  call scanf
  add esp, 12
  popa
  inc ecx
  cmp ecx, n
  jb input
  
  mov ecx, 1
  FLDZ
cycle:
  FLD ar_y[8*ecx]
  FLD ar_y[8*ecx-8] 
  FLD ar_x[8*ecx]
  FLD ar_x[8*ecx-8]
  call distance
  FADD
  
  inc ecx
  cmp ecx, n
  jb cycle
  
  dec ecx
  FLD ar_y[8*ecx]
  FLD ar_y[0] 
  FLD ar_x[8*ecx]
  FLD ar_x[0]
  call distance
  FADD
  FSTP P
  
  push dword ptr [P+4]
  push dword ptr [P]
  push offset format_out
  call printf
  add esp, 12
 
  push 0
  call exit
  
distance:
; фунция которая считает расстояние между
; точками (x1,y1) и (x2,y2).
; Входные данные:
; ST(0) - x1
; ST(1) - x2
; ST(2) - y1
; ST(3) - y2
; Выходные данные:
; ST(0) - расстояние
  FSUB
  FMUL ST(0), ST(0)  ; (x1-x2)^2 y1 y2
  FXCH ST(2)
  FSUB
  FMUl ST(0), ST(0)
  FADD
  FSQRT
  ret

  
END main