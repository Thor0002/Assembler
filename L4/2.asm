.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  fact dd 13 dup (?)
  n db 7

.CODE
main:
  mov eax, 1
  mov ecx, 0
  mov fact[type fact * ecx ], eax 
  inc ecx
start:  
  mul ecx
  mov fact[type fact * ecx ], eax
  inc ecx
  cmp cl, n
  jbe start 
 
  push 0
  call exit
  
END main