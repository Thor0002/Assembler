.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  n dd ?
  a dd 100 dup(0)
  format db "%d", 0
  format_out db "%d ", 0

.CODE
main:
  push offset n
  push offset format
  call scanf
  add esp, 8
   
  mov ecx, 0   ; index
input:
  pusha
  lea esi, a[4*ecx] 
  push esi              ;push offset a[4*ecx]
  push offset format
  call scanf
  add esp, 8
  popa
  inc ecx
  cmp ecx, n
  jb input
  
  mov ecx, 0 
cycle_1:
  mov esi, offset a
  mov edi, n 
  mov eax, [esi+4*ecx]
  call number_of_smaller
  pusha
  push eax
  push offset format_out
  call printf
  add esp, 8
  popa
  inc ecx
  cmp ecx, n
  jb cycle_1
 
  push 0
  call exit
  
number_of_smaller:
; процедура которая принимает 4-байтное число,
; массив 4-байтных чисел и считает количесво
; чисел меньших этого числа
; Входные данные:
; eax - число
; edi - длина массива
; esi - адрес массива
; Выходные данные:
; eax - количесво меньших
  push ebx
  push ecx
  push edx
 
  mov ecx, 0
  mov ebx, eax
  mov eax, 0
cycle_2:
  cmp ebx, [esi+4*ecx]
  jbe greater
  inc eax
greater:
  inc ecx
  cmp ecx, edi
  jb cycle_2
  
  pop edx 
  pop ecx
  pop ebx
  ret
END main