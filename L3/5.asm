.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 13
  b dd 3

.CODE
main:
  mov eax, a
  mov ebx, -1
again:  
  cmp eax, b
  jbe end_part
  and eax, ebx
  shr ebx, 1
  jmp again  
end_part:   
  mov a, eax
  
  push 0
  call exit
  
END main

;1110
;0101