.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd -2
  sumPow dd ?
  powers db 1, 2, 3, 4, 5
  powLen dd 5
  
.CODE

pow: ;-функцию pow, которая возводит 32-битное знаковое число, 
     ;переданное в регистре eax в степень беззнакового 8-битного числа,
	 ;переданного в регистре bl
	 ;результат в eax
  push edx
  push ecx
  cmp bl, 0
  je zero
  mov ecx, eax
again_pow:
  cmp bl, 1
  je end_pow
  imul ecx
  dec bl 
  jmp again_pow
zero:
  mov eax, 1
end_pow:
  pop ecx
  pop edx
  ret  

main:
  mov ecx, 0  ; в ecx - индекс массива powers
again:
  mov eax, a
  mov bl, powers[type powers * ecx]
  call pow
  add sumPow, eax
  inc ecx
  cmp powLen, ecx
  jne again

end_: 
  push 0
  call exit
  
END main