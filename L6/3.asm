.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  ar dw 1, 2, 3, 2, 1
  arLen dd 5
  bestLen dd ?
  bestPal dw 100 dup(0)

.CODE

isPalindrome: ;функцию isPalindrome, которая проверяет, 
              ;что заданный массив 16-битныхчисел без знака является палиндромом
              ;в регистре eax — длина, в регистре esi — адрес памяти.
     		  ;результат в регистре bl
  push eax
  push ecx
  push edx
  dec eax    ; в eax индекс массива с конца
  mov bl, 0  ; по умолчанию считаем, что не палиндром
  mov ecx, 0 ; в ecx индекс массива с начала 
again_1:
  mov dx, [esi + 2*eax]
  cmp [esi + 2*ecx], dx
  jne not_palindrome
  inc ecx
  dec eax
  cmp eax, ecx
  ja again_1
  mov bl, 1
not_palindrome:
  pop edx
  pop ecx
  pop eax
  ret
  
main:
   mov eax, arLen    ; в eax длина подмассива
   mov edx, 1        ; в edx кол-во подмассивов данной длины
outer_loop: 
  mov ecx, edx    
  dec ecx            ; в ecx индекс начала подмассивов
inner_loop:
; mov esi, offset ar ; находим индекс подмассива и кладём его в esi 
; shl ecx, 2  
; add esi, ecx       ; esi = offset ar + ecx * 4
; shr ecx, 2 
  lea esi, [ar + 2*ecx]        
  call isPalindrome
  cmp bl, 1
  je copy
  dec ecx
  cmp ecx, -1
  jne inner_loop
  
  dec eax
  inc edx
  jmp outer_loop
  
copy:
  mov bestLen, eax
  mov ebx, 0        ; в ebx индекс массива bestPal
again_2:
  mov dx, ar[ecx * type ar]
  mov bestPal[type bestPal * ebx], dx
  inc ebx
  inc ecx
  cmp ebx, bestLen
  jb again_2
  
  push 0
  call exit
  
END main