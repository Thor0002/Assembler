.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  ans dd ?
  n db 5
.CODE
main:
  mov eax, 1
  mov ebx, 1
again:  
  cmp n, 0
  jne endpart

  mov ecx, ebx
  add ebx, eax
  mov eax, ecx
  sub n, 1
  jmp again;
  
endpart:
  mov ans, eax 
  
  push 0
  call exit
  
END main