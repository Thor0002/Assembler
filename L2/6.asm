.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  n dw 7
  i db 2

.CODE
main:
  movsx eax, n
  dec i
  mov cl, i
  ror eax, cl
  mov bx, ax
  shr bx, 1
  mov ax, bx
  rol eax, cl
  mov n, ax
 
  push 0
  call exit
  
END main