.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 1, 2, 1
  aLen dd 3
  xs dd -1, 0, 1
  xsLen dd 3
  maxVal dd 0F0000000H

.CODE

computeValue: ;процедура, принимающую массив 32-битных знаковых коэффициентов 
              ;многочлена, в регистре eax — длина, в регистре esi — адрес памяти
			  ;32-битную знаковую величину в регистре ebx и
              ;вычисляющую значение многочлена в данной точке, 
			  ;возвращая его в регистре eax.
  push edx
  push ecx
  push eax    ; в вершине стека будет лежать длина массива
  mov ecx, 0  ; в ecx лежит индекс массива
  mov eax, 0  ; в eax текущая сумма
cycle1:
  imul ebx
  add eax, [esi + 4 * ecx]
  inc ecx
  cmp ecx, [esp]
  jb cycle1
  pop ecx     ; удалили длину
  pop ecx
  pop edx
  ret

main:
  mov ecx, 0             ; в ecx индекс массива xs
  mov esi, offset a
cycle2:
  mov eax, aLen
  mov ebx, xs[type xs * ecx]
  call computeValue
  cmp eax, maxVal
  jl less
  mov maxVal, eax
less:
  inc ecx
  cmp ecx, xsLen
  jb cycle2
 
  push 0
  call exit
  
END main