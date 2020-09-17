.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a0 dd 10
  k dd 7
  k1 dd ?
  k2 dd ?

.CODE
Syracuse_sequence: 
; процедура, которая получает через стек два 32-битных числа без знака a0
; и k и адреса двух 32-битных переменных, куда нужно записать количество членов 
; сиракузской последовательности, построенной от числа a0, меньших k и не меньших k.
; Входные данные:
; [ebp+8]  - a0
; [ebp+12] - k
; [ebp+16] - адрес 1 переменной
; [ebp+20] - адрес 2 переменной
; Выходных данных нет
  push ebp
  mov ebp, esp
  pusha
  
  mov esi, [ebp+16]
  mov edi, [ebp+20]
  mov ebx, [ebp+8]
cycle:
  cmp ebx, k
  jb less
  inc dword ptr [edi]
  jmp next_step
less:
  inc dword ptr [esi]
next_step:
  cmp ebx, 1
  je end_
; mov eax, ebx
  test ebx, 1 
; cmp eax, 1  
  jnz odd
  shr ebx, 1
  jmp cycle
odd:
  mov eax, ebx
  shl ebx, 1
  add ebx, eax  
  inc ebx      ;ebx = 3*ebx + 1
  jmp cycle
  
end_:
  popa
  pop ebx
  ret
  
main:
  push offset k2
  push offset k1
  push k
  push a0
  call Syracuse_sequence
  add esp, 16  
 
  push 0
  call exit
  
END main
