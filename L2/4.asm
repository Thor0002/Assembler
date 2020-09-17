.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  n dw 123
  i db 4
  
.CODE
main:
  mov cl, i
  ror n, cl
  xor n, 1
  rol n, cl
 
  push 0
  call exit
  
END main