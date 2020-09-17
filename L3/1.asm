.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 2
  b dd -3
  d dd ?

.CODE
main:
  mov eax, a
  cmp eax, b
  jl elsepart
  mov edx, a
  jmp endpart
elsepart:
  mov edx, b;
endpart:
  mov d, edx  
  
  push 0
  call exit
  
END main
