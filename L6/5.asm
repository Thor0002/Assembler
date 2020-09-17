.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  amicNums dd 13 dup(0)
  amicLen dd ?

.CODE

sumOfDividers: ;процедура, принимающую в регистре eax 
               ;32-битное число без знака и возвращающую 
			   ;в том же регистре сумму его делителей.
  push edx
  push ecx
  push ebx
  push eax   ; кладём число в вершину стека
  mov ebx, 0 ; в ebx - сумма
  mov ecx, 1 ; в ecx - делители
cycle1:
  mov eax, [esp]
  mov edx, 0
  div ecx
  cmp edx, 0
  jne not_div
  add ebx, ecx
not_div:
  inc ecx
  cmp ecx, [esp]
  jb cycle1
  mov eax, ebx
  pop ebx   ; удаляем число из стека
  pop ebx
  pop ecx
  pop edx
  ret  

main:
  mov ecx, 2  ; в ecx числа которые проверяем 
  mov ebx, 0  ; в ebx индекс массива amicNums 
searching:
  mov eax, ecx
  call sumOfDividers
  cmp ecx, eax
  jae not_amic
  mov  edx, eax
  call sumOfDividers
  cmp ecx, eax
  jne not_amic
  mov amicNums[4 * ebx], ecx
  mov amicNums[4 * ebx + 4], edx
  add ebx, 2 
not_amic:
  inc ecx
  cmp ecx, 100000
  jbe searching
  mov amicLen, ebx
 
  push 0
  call exit
  
END main