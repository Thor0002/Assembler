.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  av dd 1
  bv dd 2
  cv dd 3
  dv dd 4
  ev dd ?

.CODE
main:
  mov eax, av
  mul bv  ;imul
  mov ebx, eax
  mov eax, cv
  div dv  ;idiv
  sub ebx, edx
  
  mov eax, cv
  mul dv  ;imul
  mov ecx, eax
  mov eax, av
  div bv  ;idiv
  add ecx, edx
  
  mov eax, ebx
  mul ecx ;imul
  mov ev, eax
  
  push 0
  call exit
  
END main