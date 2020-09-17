.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 6
  b dd 4
  gcd dd ?

.CODE
main:
  mov eax, a
  mov ebx, b
again:
  cmp ebx, 0
  je endpart

  xor edx, edx
  div ebx
  mov eax, ebx
  mov ebx, edx
; xor edx, edx
  jmp again;
  
endpart:  
  mov gcd, eax  
  
  push 0
  call exit
  
END main