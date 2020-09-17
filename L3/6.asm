.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 13
  b dd 3 
  n dd 32
  ans dd ?
.CODE
main:
  mov eax, a
  xor eax, b
  xor ecx, ecx
again:
  cmp n, 0
  je endpart

  mov ebx, 1
  and ebx, eax

  jz part
  inc ecx
part:
  shr eax, 1
  dec n
  jmp again;
  
endpart:  
  mov ans, ecx 
  
  push 0
  call exit
  
END main