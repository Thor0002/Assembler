.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd ?
  b dd ?
  format_in db "%d%d", 0
  format_out db "GCD = %d", 0

.CODE
main:
  push offset b
  push offset a
  push offset format_in
  call scanf
  add esp, 12
  
  mov eax, a
  mov ebx, b 
  cmp eax, 0
  jge a_positive
  neg eax
a_positive:
  cmp ebx, 0
  jge b_positive
  neg ebx
b_positive:
   
cycle: 
  cmp ebx, 0
  je end_cycle
  mov edx, 0
  div ebx
  mov eax, ebx
  mov ebx, edx
  jmp cycle

end_cycle:  
  push eax
  push offset format_out
  call printf
  add esp, 8
 
  push 0
  call exit
  
END main
