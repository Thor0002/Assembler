.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 123, 10203, 562431
  alen dd 3
  d db ?

.CODE
max_digit:
; процедура, которая получает через стек массив 32-битных беззнаковых 
; чисел, и в байтовой переменной, адрес которой также передаётся, выдаёт цифру, 
; наиболее часто встречающуюся в десятичной записи этих чисел.
; Входные данные:
; [ebp+8]  - адрес массива
; [ebp+12] - длина массива
; [ebp+16] - адрес переменной
; Выходных нет
; Локальные переменные
; ebp-40    - адрес массива из 10 элемнтов
  push ebp
  mov ebp, esp
  sub esp, 40
  pusha
  mov [ebp-40], dword ptr 0
  mov [ebp-36], dword ptr 0
  mov [ebp-32], dword ptr 0
  mov [ebp-28], dword ptr 0
  mov [ebp-24], dword ptr 0
  mov [ebp-20], dword ptr 0
  mov [ebp-16], dword ptr 0
  mov [ebp-12], dword ptr 0
  mov [ebp-8],  dword ptr 0
  mov [ebp-4],  dword ptr 0
  
; sub ebp, 40
; mov edi, ebp
; add ebp, 40
  mov edi, ebp
  sub edi, 40
  mov esi, [ebp+8]
  mov ecx, 0
cycle:
  mov eax, [esi + 4*ecx]
  call number_of_digits
  inc ecx
  cmp ecx, [ebp+12]
  jb cycle
  
  mov ecx, 0
  mov ebx, 0
  mov edx, 0
find_max_digit:
  cmp [edi+4*ecx], edx
  jb less
  mov edx, [edi+4*ecx]
  mov ebx, ecx
less:
  inc ecx
  cmp ecx, 10
  jb find_max_digit
  mov esi, [ebp+16]
  mov [esi], bl
  
  popa
  mov esp, ebp
  pop ebp
  ret
 
number_of_digits:
; процедура, которая принимает 32-битное беззнаковое число,
; массив, из 10 элемнтов. И должна добавляет к 0-му элементу
; сколько раз встречается цифра 0 в числе, в 1-му элементу
; сколько раз встречается цифра 1 в числе и т.д.
; Входные данные:
; edi - адрес массива
; eax - число
; Выходных данных нет
  push ebx
  push edx
  mov ebx, 10
cycle1:
  mov edx, 0
  div ebx
  inc dword ptr [edi+4*edx]
  cmp eax, 0
  ja cycle1
  pop edx
  pop ebx 
  ret

main:
  push offset d
  push alen
  push offset a
  call max_digit
  add esp, 12
  
  push 0
  call exit
  
END main