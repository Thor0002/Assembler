.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  l equ 5
  a db 1, 2, 3, 4, 5
  b db 5 dup (?)

.CODE
main:
  mov ecx, l
  mov ebx, 0
start:
  mov al, a[type a * ecx - type a]
  mov b[type b * ebx ], al
  inc ebx
  loop start
 
  push 0
  call exit
  
END main