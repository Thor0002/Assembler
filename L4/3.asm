.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  l equ 4
  a dw 4
  b dw 100
  d dw 400
  years dw 2000, 2100, 2001, 2004
  leaps db l dup (?)
  
.CODE
main:
  mov ecx, l
start:
  mov bx, years[type years * ecx - type years]  
  
  mov ax, bx
  xor dx, dx
  div a
  cmp dx, 0
  jne non_leap
  
  mov ax, bx
  xor dx, dx
  div b
  cmp dx, 0
  jne leap
  
  mov ax, bx
  xor dx, dx
  div d
  cmp dx, 0
  jne non_leap
  
leap:
  mov leaps[type leaps * ecx - type leaps], 1
  jmp end_
  
non_leap:
  mov leaps[type leaps * ecx - type leaps], 0

end_:    
  loop start  
  
  push 0
  call exit
  
END main