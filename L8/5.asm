.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
; a dd 1, 5, 2, 7, 4, 9, 3, 6, 8, 0
;  a dd 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
; len dd 10
  a dd 100 dup(0)
  n dd ?
  format_in db "%d", 0
  format_out db "%d ", 0

.CODE
QuickSort:
; процедура, принимающую через стек массив 32-битных знаковых чисел
; и сортирующую его алгоритмом QuickSort.
; Входные данные:
; [ebp+8]  - адрес массива
; [ebp+12] - длина массива
; Выходных нет
  push ebp
  mov ebp, esp
  pusha
  
  mov esi, [ebp+8]
  mov eax, [esi]
  mov ecx, 1
  mov edx, [ebp+12]
  cmp edx, 1
  je end_QuickSort
  dec edx
cycle:
  cmp [esi + 4*ecx], eax 
  jge greater
  inc ecx
  cmp ecx, edx
  jbe no_end
  dec ecx
  jmp after_cycle
no_end:
  cmp [esi + 4*edx], eax
  jl  less
  dec edx
  cmp ecx, edx
  jbe cycle
  dec ecx
  jmp after_cycle
greater:
  cmp [esi + 4*edx], eax
  jl both
  dec edx
  cmp ecx, edx
  jbe greater
  dec ecx
  jmp after_cycle
less:
  cmp [esi + 4*ecx], eax 
  jge both
  inc ecx
  cmp ecx, edx
  jbe less
  dec ecx
  jmp after_cycle
both:
  mov edi, [esi + 4*ecx]
  mov ebx, [esi + 4*edx]
  mov [esi + 4*edx], edi
  mov [esi + 4*ecx], ebx
  inc ecx
  dec edx
  cmp ecx, edx
  jbe cycle
  dec ecx
  jmp after_cycle
after_cycle:

  cmp ecx, 0
  jne one_list
  mov eax, [ebp+12]
  dec eax
  lea ebx, [esi+4]
  push eax
  push ebx
  call QuickSort
  add esp, 8
  jmp end_QuickSort

one_list:
  mov edi, [esi + 4*ecx]
  mov ebx, [esi]
  mov [esi], edi
  mov [esi + 4*ecx], ebx
  
  mov eax, [ebp+12]
  dec eax
  cmp ecx, eax
  jne two_lists
  push eax
  push esi
  call QuickSort
  add esp, 8
  jmp end_QuickSort

two_lists:
  push ecx
  push esi
  call QuickSort
  add esp, 8
  
  mov eax, [ebp+12]
  sub eax, ecx
  lea ebx, [esi+4*ecx]
  push eax
  push ebx
  call QuickSort
  add esp, 8

end_QuickSort:  
  popa
  pop ebp
  ret

main:
  push offset n
  push offset format_in
  call scanf
  add esp, 8
  
  mov ecx, 0
input:
  pusha
  lea esi, a[4*ecx] 
  push esi              ;push offset a[4*ecx]
  push offset format_in
  call scanf
  add esp, 8
  popa
  
  inc ecx
  cmp ecx, n
  jb input
  
  push n
  push offset a
  call QuickSort
  
  mov ecx, 0
output:
  pusha
  push a[4*ecx]
  push offset format_out
  call printf
  add esp, 8
  popa
  
  inc ecx
  cmp ecx, n
  jb output
  
  push 0
  call exit
  
END main