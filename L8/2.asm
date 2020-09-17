.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dw 1, 2, -3 , -4, 5
  alen dd 5
  a_min dw ?
  a_max dw ?  

.CODE
max_and_min:
; процедура, которая получает через стек массив 16-битных 
; знаковых чисел и адреса двух 16-битных переменных. 
; Если в переданном массиве отрицательных чисел
; больше, то в переданные переменные надо записать 
; минимум и максимум среди отрицательных чисел из массива, 
; а если неотрицательных — то минимум и максимум среди
; неотрицательных чисел из массива.
; Входные данные:
; [ebp+8]  - адрес массива
; [ebp+12] - длина массива
; [ebp+16] - адрес первой переменной
; [ebp+20] - адрес второй переменной
; Выходных данных нет
; Локальные переменные:
; [ebp-4]  - максимум среди отрицательных
; [ebp-8]  - минимум среди отрицательных
; [ebp-12] - максимум среди неотрицательных
; [ebp-16] - минимум среди неотрицательных
  push ebp
  mov ebp, esp
  sub esp, 16
  pusha
  mov [ebp-4],  word ptr 0F000H       ; максимум среди отрицательных
  mov [ebp-8],  word ptr 0            ; минимум среди отрицательных
  mov [ebp-12], word ptr 0            ; максимум среди неотрицательных
  mov [ebp-16], word ptr 00FFFH       ; минимум среди неотрицательных
  
  mov esi, [ebp+8]
  mov edi, 0        ; индекс массива
  mov ecx, 0        ; кол-во неотрицательных
  mov edx, 0        ; кол-во отрицательных
cycle:
  mov ax, [esi + 2*edi]
  cmp ax, 0
  jl less
  inc ecx
  mov bx, [ebp-12]
  call max
  mov [ebp-12], bx 
  mov bx, [ebp-16]
  call min
  mov [ebp-16], bx
  jmp end_1  
less:
  inc edx
  mov bx, [ebp-4]
  call max
  mov [ebp-4], bx
  mov bx, [ebp-8]
  call min
  mov [ebp-8], bx   
end_1:
  inc edi
  cmp edi, [ebp+12]
  jb cycle
  
  mov esi, [ebp+20]
  mov edi, [ebp+16]
  cmp ecx, edx
  jb negative
  mov ax, [ebp-12]
  mov bx, [ebp-16]
  mov [esi], ax
  mov [edi], bx
  jmp end_
negative:
  mov ax, [ebp-4]
  mov bx, [ebp-8]
  mov [esi], ax
  mov [edi], bx
end_:
  popa
  mov esp, ebp
  pop ebp
  ret  
  
max:
; процедура, которая вычисляет максимум из двух чисел
; Входные данные:
; ax - первое число
; bx - второе число
; Выходные данные:
; bx - максимум
  cmp ax, bx
  jl end_max
  mov bx, ax
end_max:
   ret  

min:
; процедура, которая вычисляет минимум из двух чисел
; Входные данные:
; ax - первое число
; bx - второе число
; Выходные данные:
; bx - минимум
  cmp ax, bx
  jg end_min
  mov bx, ax
end_min:
   ret     

main:
  push offset a_max
  push offset a_min
  push alen
  push offset a
  call max_and_min
  add esp, 16
 
  push 0
  call exit
  
END main  