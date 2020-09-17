.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 28, -70, 154, 98
  
.CODE

totalGCD: ;функция примающая ммассив 32-битных чисел со знаком 
          ;и находящую совокупный НОД всех этих чисел
		  ;результат в eax
  push edx
  push ecx
  mov edx, eax
  mov ecx, 1
  mov eax, [esi]
cycle:
  mov ebx, [esi + ecx * 4 ] 
  call GCD
  inc ecx
  cmp ecx, edx
  jne cycle
end_totalGCD:
  pop ecx
  pop edx
  ret

GCD:; фуникция принимающая в рестрах eax, ebx два безнаковых числа
; и находящую их НОД в регистре eax
  push edx
again: 
  cmp ebx, 0
  je end_GCD
  cdq
  idiv ebx
  mov eax, ebx
  mov ebx, edx
  jmp again
end_GCD:
  pop edx  
  ret 
  
main:
  mov eax, 4
  mov esi, offset a
  call totalGCD

  push 0
  call exit
  
END main
