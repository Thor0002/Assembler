.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  x dd 5
  i dd 2
  alen dd 4
  a dd 3, 2, 6, 0

.CODE	

insert: 
; Процедура которая принимает через стек массив 32-битных беззнаковых
; чисел, 32-битное беззнаковое число и индекс в массиве
; Входные данные:
; [ebp+8] - адрес массива
; [ebp+12] - длина массива
; [ebp+16] - число
; [ebp+20] - индекс
; Выходных данных нет
  push ebp
  mov ebp, esp
  push ecx
  push esi
  push edx
  
  mov ecx, [ebp+12]
  mov esi, [ebp+8]
cycle:
  mov edx, [esi+ecx*4]
  mov [esi+ecx*4+4], edx
  cmp ecx, [ebp+20]
  je end_
  dec ecx
  jmp cycle
end_:
  mov edx, [ebp+16]
  mov [esi+ecx*4], edx
  pop edx
  pop esi
  pop ecx
  pop ebp
  ret

main:

  push i
  push x
  push alen
  push offset a
  call insert
  add esp, 16
  
  push 0
  call exit
  
END main	
