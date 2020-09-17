.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 1
  b dd 1

.CODE
main:

; 5x^2 - 7x + 2 = (5x-7)x + 2
;  mov eax, 5
;  imul a
;  sub eax, 7
;  imul a
;  add eax, 2

  mov eax, 5
  imul a
  imul a
  mov ebx, eax
  mov eax, 7
  imul a
  sub ebx, eax
  add ebx, 2
  
  cmp ebx, b
  jne elsepart
  mov al, 1
  jmp endpart
elsepart:
  mov al, 0;
endpart: 
  
  push 0
  call exit
  
END main