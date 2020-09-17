.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  a dw 100 dup(0)
  n dd ?
  format_n db "%d", 0
  format db "%hd", 0
  format_out db "Element :%hd Difference:%hd ", 10, 0
  
.CODE
main:
  push offset n
  push offset format_n
  call scanf
  add esp, 8
   
  mov ecx, 0   ; index
  mov eax, 0    ; max 
input:
  pusha
  lea esi, a[2*ecx] 
  push esi              ;push offset a[2*ecx]
  push offset format
  call scanf
  add esp, 8
  popa
  cmp ax, a[2*ecx]
  jge not_max
  mov ax, a[2*ecx]
not_max:
  inc ecx
  cmp ecx, n
  jb input
  
  mov ecx, 0
  mov ebx, 0
output:
  mov bx, ax
  sub bx, a[2*ecx]
  pusha
  push ebx
  push dword ptr a[2*ecx]
  push offset format_out
  call printf
  add esp, 12
  popa
  inc ecx
  cmp ecx, n
  jb output  
 
  push 0
  call exit
  
END main