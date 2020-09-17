.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  x1 dw 1
  y1 dw 3
  x2 dw 6
  y2 dw 1
  S dd ?
.CODE
main:
  mov ax, x1
  sub ax, x2
  mov bx, y1
  sub bx, y2
  cwde
  mov ecx, eax
  mov ax, bx
  cwde
  imul ecx
  mov S, eax

  movsx eax, x1
  movsx ebx, x2
  sub eax, ebx
  
  movsx ebx, y1
  movsx ecx, y2
  sub ebx, ecx
  
  imul ebx
  mov S, eax
  
  push 0
  call exit
  
END main