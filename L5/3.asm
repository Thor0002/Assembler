.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  s1 db "102030", 0
  s2 db 7 dup(0)

.CODE
  main:
  mov ecx, 0
cycle1:
  cmp s1[ecx], 0
  je delete_zero
  inc ecx
  jmp cycle1
  
delete_zero:
  dec ecx
  cmp s1[ecx], '0'
  je delete_zero
 
mov edx, 0
cycle2:
  mov al, s1[ecx]
  mov s2[edx], al
  inc edx
  dec ecx
  cmp ecx, -1
  je end_
  jmp cycle2

end_:
  mov s2[edx], 0
  push 0
  call exit
  
END main