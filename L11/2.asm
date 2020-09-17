.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  x dq 3.14
  y dq 2.72
  min dq ?
  max dq ?
  format_in db "%lf%lf", 0
  format db "min = %lf, max = %lf", 0
  
.CODE
main:
  push offset y
  push offset x
  push offset format_in
  call scanf
  add esp, 12
 
  FLD y
  FLD x
  FCOM
  FSTSW ax
  SAHF
  jb less_x
  FSTP max
  FSTP min
  jmp print
less_x:
  FSTP min
  FSTP max
print:
  push dword ptr [max+4]
  push dword ptr [max]
  push dword ptr [min+4]
  push dword ptr [min]
  push offset format
  call printf
  add esp, 20
 
  push 0
  call exit
  
END main