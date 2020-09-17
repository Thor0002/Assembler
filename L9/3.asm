.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  s db 100 dup(0)
  s_even db 100 dup(0)
  s_odd db 100 dup(0)
  format db "%s", 0
  new_line db 10

.CODE
main:
  push offset s
  call gets
  add esp, 4
  
  mov eax, 0    ; index s_even
  mov ebx, 0    ; index s_odd
  mov ecx, 0
cycle:
  mov edx, ecx
  test dl, 1
  jnz odd
  mov dl, s[ecx]
  mov s_even[eax], dl
  inc eax
  jmp end_cycle
odd:
  mov dl, s[ecx]
  mov s_odd[ebx], dl
  inc ebx
end_cycle:
  inc ecx
  cmp s[ecx], 0
  jne cycle
  mov s_even[eax], 0
  mov s_odd[ebx], 0
  
  push offset s_even
  call printf
  add esp, 4
  push offset new_line
  call printf
  add esp, 4
  push offset s_odd
  call printf
  add esp, 4
 
  push 0
  call exit
  
END main