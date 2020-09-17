.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  l equ 10
  a dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  b db 10010110B, 00000010B 
  s dd 0

  .CODE
main:
  mov ecx, 0 ; индекс элемента из а
  mov edx, 1 ; номер цифры элемента из b
  mov eax, 0 ; индекс элемента из b
start:
  mov bl, b[type b * eax]
  and bl, 1
  cmp bl, 0    
  je next
  movzx ebx, a[type a * ecx ]
  add s, ebx
next:  
  shr b[type b * eax], 1
  inc edx
  cmp edx, 9
  jb end_
  inc eax
  mov edx, 1
end_:
  inc ecx
  cmp ecx, l
  jb start
  
  push 0
  call exit
  
END main