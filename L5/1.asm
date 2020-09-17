.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  str1 db "hello", 0
  len db ?

.CODE
  main:
  mov ecx, 1
  cmp str1[0], 91
  jb cycle
  sub str1[0], 32

cycle:
  cmp str1[ecx], 0
  je end_
  cmp str1[ecx], 91
  ja lowercase
  add str1[ecx], 32
lowercase:
  inc ecx
  jmp cycle
  
end_:  
  push 0
  call exit
  
END main
