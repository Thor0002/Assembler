.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  a   dd 1001 dup(0)
  n   dd ?
  max dd 0F0000000H
  format db "%d", 0
  format_out db "%d ", 0
  new_line db 10, 0

.CODE
main:
  lea esi, a[0] 
  push esi
  push offset format
  call scanf
  add esp, 8
  
  lea esi, a[4] 
  push esi
  push offset format
  call scanf
  add esp, 8
  
  push offset n
  push offset format
  call scanf
  add esp, 8
  
  mov ecx, 0
cycle:
  pusha
  push a[4*ecx]
  push offset format_out
  call printf
  add esp, 8
  popa
  
  mov eax, a[4*ecx]
  cmp eax, max
  jle less
  mov max, eax
less:
  inc ecx
  cmp ecx, n
  ja end_
; получаем a[ecx]
  cmp ecx, 1
  je cycle
  mov eax, ecx
  test eax, 1
  jnz odd
  shr eax, 1
  mov ebx, a[4*eax]
  mov a[4*ecx], ebx
  jmp cycle
odd:
  shr eax, 1
  mov ebx, a[4*eax]
  add ebx, a[4*eax+4]
  mov a[4*ecx], ebx
  jmp cycle

end_:
  push offset new_line
  call printf
  add esp, 4

  push max
  push offset format
  call printf
  add esp, 8  
   
  push 0
  call exit
  
END main