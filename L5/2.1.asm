.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
 s db "aba", 0
 a db 32
 res_a db ?
 res_b db ?

.CODE
  main:
  mov ecx, 0
cycle1:
  cmp s[ecx], 0
  je start
  inc ecx
  jmp cycle1
  
start:
  mov res_a, 1
  mov res_b, 1
  mov edx, -1
cycle2:
  inc edx
  dec ecx
  jz end_ ; выходим когда дошли до конца строки. Можно сделать так, чтобы выходило на середине строки
  
  mov al, s[ecx]; проверка для б)
  sub al, s[edx]
  cbw
  idiv a; a = 32 = 'a' - 'A'
  cmp ah, 0
  jne false
  
  cmp al, 0 ; проверка для а)
  jz cycle2
  mov res_a, 0
  jmp cycle2
   
false:
  mov res_b, 0
  mov res_a, 0   
  jmp end_

end_:  
  push 0
  call exit
  
END main  