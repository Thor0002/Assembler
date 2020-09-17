.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 25

.CODE
main:
  not a
  inc a
  
 
  push 0
  call exit
  
END main
