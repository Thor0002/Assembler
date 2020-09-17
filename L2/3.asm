.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 12
  one dd 1
   
.CODE
main:
  ;a)
  mov eax, one
  not eax
  and a, eax
 
  push 0
  call exit
  
END main