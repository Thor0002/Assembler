.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dw 17
  b db -10
  cc db -6
  d db 4
  res1 db ? ; res1 = 7
  res2 db ? ; res2 = -4
  res3 db ? ; res3 = -2

.CODE
main:
  mov ax, a
  idiv b
  mov res1, ah
  mov al, b
  cbw
  idiv cc
  mov res2, ah
  mov al, cc
  cbw
  idiv d
  mov res3, ah
  
  push 0
  call exit
  
END main