.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 117
  b dd 999
  d dd 1024
  e dd ?

.CODE
main:
  mov eax, a
  imul b
  add eax, d
  mov e, eax

  push 0
  call exit
  
END main