.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a db 10
  o db 170 ; n1 = 10101010
  e db 85  ; n2 = 01010101

.CODE
main:
  mov ah, o
  mov al, e
  and ah, a
  and al, a
  shr ah, 1
  shl al, 1
  xor ah, al
  mov a, ah
 
  push 0
  call exit
  
END main