.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dw 1, 2, 3, 4, 5, 6, 7  
  l dd 7
  sum dd 0
  prod dd 1
  
.CODE
main:
  mov ecx, l
start:
  movzx eax, a[type a * ecx - type a]
  add sum, eax
  mul prod
  mov prod, eax
  loop start

  push 0
  call exit
  
END main
