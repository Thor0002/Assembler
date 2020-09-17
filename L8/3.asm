.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  alen dd 10
  k1 dd 2
  k2 dd 3
  k dd ?
  n dd ?

.CODE
amount:
; процедура, принимающую через стек массив 32-битных знаковых чисел, два
; 32-битных знаковых числа k1 и k2, а также адреса двух 32-битных переменных. 
; Процедура считает количество чисел из массива, делящихся на k1, и количество
; чисел, делящихся на k2 записывает в одну из переменных, переданных своими 
; адресами, ту из величин k1 и k2, на которую делится больше чисел из
; массива, а во вторую — количество этих чисел
; Входные данные:
; [ebp+8]  - адрес массива
; [ebp+12] - длина массива
; [ebp+16] - k1
; [ebp+20] - k2
; [ebp+24] - адрес первой переменной
; [ebp+28] - адрес второй переменной
; Выходных данных нет
  push ebp
  mov ebp, esp
  pusha
  
  mov esi, [ebp+8] ; в esi адрес массива
  mov ecx, 0       ; индекс массива
  mov ebx, 0       ; количество чисел делящихся на k1
  mov edi, 0       ; количество чисел делящихся на k2
cycle:
  mov eax, [esi + 4*ecx]
  cdq
  idiv dword ptr [ebp+16]
  cmp edx, 0
  jne no_k1
  inc ebx
no_k1:
  mov eax, [esi + 4*ecx]
  cdq
  idiv dword ptr [ebp+20]
  cmp edx, 0
  jne no_k2
  inc edi
no_k2:
  inc ecx
  cmp ecx, [ebp+12]
  jb cycle
  
  mov esi, [ebp+24] ; в esi адрес первой переменной
  mov edx, [ebp+28] ; в edx адрес второй переменной
  cmp ebx, edi
  jb k2_
  mov eax, [ebp+16]
  mov [esi], eax
  mov [edx], ebx
  jmp end_
k2_:
  mov eax, [ebp+20]
  mov [esi], eax
  mov [edx], edi
end_:
  popa
  pop ebp
  ret

main:
  push offset n
  push offset k
  push k2 
  push k1
  push alen
  push offset a
  call amount
  
  add esp, 24
 
  push 0
  call exit
  
END main 