.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  l1 equ 5
  k dd 2
  a dd 1, 2, 3, 4 ,5
  b dd 5 dup (?)
  l2 dd 0
  
.CODE
main:
  mov ecx, 0
  mov ebx, 0
start:
  mov eax, a[type a * ecx]
  idiv k
  cmp edx, 0
  jne next
  mov eax, a[type a * ecx]
  mov b[type b * ebx], eax
  inc ebx
next:
  inc ecx
  cmp ecx, l1
  jb start
  
  inc ebx
  mov l2, ebx
  
  push 0
  call exit
  
END main