.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dw 1, 2, 3, 4, 5
  alen dd 5
  x dw 3
  less dw 5 dup(0)
  greater dw 5 dup(0)

.CODE
split: 
; процедура, которая принимает через стек массив беззнаковых 16-битных
; чисел, адреса двух достаточно больших блоков памяти и беззнаковое 16-битное целое,
; а затем помещает в первый блок числа меньшие переданного числа, а во второй
; большие или равные ему. В регистре eax следует вернуть количество чисел, помещённых 
; в первый блок, а в регистре ebx — количество чисел, помещённых во второй блок
; Входный данные:
; [ebp+8]  - число
; [ebp+10] - адрес массива
; [ebp+14] - длина массива
; [ebp+18] - адрес 1 блока
; [ebp+22] - адрес 2 блока
; Выходые данные:
; eax - количество чисел помещённых в первый блок
; ebx - количество чисел помещённых в второй блок
  push ebp
  mov ebp, esp
  push esi
  push edi
  push ecx
  push edx
  
  mov eax, 0          ; eax = i1
  mov ebx, 0          ; ebx = i2
  mov esi, [ebp+10]   ; esi - адрес исходного массива
  mov edi, [ebp+18]   ; edi - адрес 1 блока 
  mov ecx, [ebp+22]   ; ecx - адрес 2 блока
cycle:
  mov dx, [esi+2*eax] ; dx = a[i1]
  sub eax, ebx        ; в eax лежит i1 + i2, eax = eax - ebx = (i1 + i2) - i2
  cmp dx, [ebp+8]     
  jb less1            ; dx < исходного числа -> less1
  mov [ecx+2*ebx], dx ; res2[i2] = dx
  inc ebx             ; i2++
  jmp end_cycle       ; 
less1:  
  mov [edi+2*eax], dx ; res1[i1] = dx
  inc eax             ; i1++
end_cycle:
  add eax, ebx        ; i1 = i1 + i2 ( eax = eax + ebx)
  cmp eax, [ebp+14]    
  jb cycle            ; i1 + i2 = lenght_a
  
  sub eax, ebx
  pop edx
  pop ecx
  pop edi
  pop esi
  pop edx
  pop ebp
  ret

main:
  push offset greater
  push offset less
  push alen  
  push offset a
  push x
  call split
  add esp, 18
  
  push 0
  call exit
  
END main