.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 117
  two dd 2
  three dd 3

.CODE
main:
  mov eax, a
  cdq
  idiv two
  mov bl, dl
  mov eax, a
  cdq
  idiv three
  mov ah, dl
  mov al, bl
  
  push 0
  call exit
  
END main