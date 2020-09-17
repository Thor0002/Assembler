.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
 s db "aba", 0
 a db 32
 len dd ?
 res_a db ?
 res_b db ?

.CODE
  main:
  mov ecx, 0
cycle1:
  cmp s[ecx], 0
  je point_a
  inc ecx
  jmp cycle1
  
point_a:
  mov res_a, 1
  dec ecx
  mov len, ecx
  mov edx, 0
cycle2:
  mov al, s[ecx]
  cmp s[edx], al
  jne false_a
  inc edx
  dec ecx
  jz point_b ; условие выхода из цикла. можно сделать так, чтобы выходило на середине строке
  jmp cycle2

point_b:
  mov res_b, 1
  mov ecx, len
  mov edx, 0
cycle3:
  mov al, s[ecx]
  sub al, s[edx]
  cbw
  idiv a
  cmp ah, 0
  jne false_b
  inc edx
  dec ecx
  jz end_ ; аналогично что в пункте а)
  jmp cycle2

false_a:
  mov res_a, 0  
  jmp point_b
  
false_b:
  mov res_b, 0  
  jmp end_

end_:  
  push 0
  call exit
  

  
END main