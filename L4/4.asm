.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  l equ 4
  d dw 10
  a dw 1, -23, 15, 137
  b db l dup (?)

.CODE
main:
  mov ecx, l
start:
  mov ax, a[type a * ecx - type a]
  cmp ax, 0
  jge here
  neg ax
here:
  cwd
  idiv d
  mov b[type b * ecx - type b], dl
  loop start  
 
  push 0
  call exit
  
END main