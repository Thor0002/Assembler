.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  n dd -123
  s db 10 dup(0)
  ten dd 10
  two dd 2
.CODE
  main:
  mov ecx, 0
  mov eax, n
;для пунтка а)
  cmp eax, 0
  jge cycle1
  neg eax
  mov s[0], '-'
  inc ecx
  
;общее
cycle1:
  cdq
  div ten
  add dl, '0'
  mov s[ecx], dl
  cmp eax, 0
  je reverse
  inc ecx
  jmp cycle1
;при n = -123, после цикла(cycle1) в s будет "-321", осталось развернуть   
reverse:
  mov eax, ecx; в ecx индек последнего символа 
  cdq 
  div two; теперь в eax индекс середины массива
  mov esi, 0
;для пункта а)
  cmp n, 0
  jge cycle2 
  inc esi
;в esi будет индекс начала массива

cycle2:; сам разворот
  mov dl, s[esi]
  mov bl, s[ecx]
  mov s[ecx], dl
  mov s[esi], bl
  dec ecx
  inc esi
  cmp esi, eax
  ja end_
  jmp cycle2
  
end_:
  push 0
  call exit
  
END main