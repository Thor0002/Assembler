.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a1 dw -5, -3, 0, 2, 10
  a1len dd 5
  a2 dw -7, -6, 0, 10
  a2len dd 4
  res dw 9 dup(0)
  
.CODE

merge:
; Процедура которая принимает через стек адреса 
; трех блоков массивов(16 бит) и длины первых двух из них,
; и помещает в 3 массив слияние первых двух
; Входные данные:
; [ebp+8]  - адрес 1 массива
; [ebp+12] - адрес 2 массива
; [ebp+16] - адрес 3 массива
; [ebp+20] - длина 1 массива
; [ebp+24] - длина 2 массива
; Выходных данных нет
  push ebp
  mov ebp, esp
  push eax
  push ebx
  push ecx
  push edx
  push esi
  push edi
  
  mov eax, [ebp+20]
  add eax, [ebp+24]
  dec eax
  push eax          ; в вершине стека лежит суммарная длина двух массивов
  mov esi, [ebp+8]  ; в esi адрес 1 массива
  mov edi, [ebp+12] ; в edi адрес 2 массива
  mov edx, [ebp+16] ; в edx адрес 3 массива
  mov ecx, 0        ; индекс первого массива
  mov ebx, 0        ; индекс второго массива
cycle:
  cmp ebx, [ebp+24] 
  je less1          ;i2 =?= lenght_a2
  cmp ecx, [ebp+20] 
  je less2          ;i1 =?= lenght_a1
  mov ax, [esi + ecx*2] ; ax = a1[i1]
  cmp ax, [edi + ebx*2] 
  jl less1              ; if ax < a2[i2] -> less1
less2:
  mov ax, [edi + ebx*2] ; ax = a2[i2]
  add ecx, ebx          ; i1 = i1 + i2
  mov [edx + ecx*2], ax ; res[i1+i2] = ax
  sub ecx, ebx          ; i1 = (i1 + i2) - i2
  inc ebx               ; i2++
  jmp end_cycle
less1:
  mov ax, [esi + ecx*2] ; ax = a1[i1]
  add ecx, ebx          ;i1 = i1 + i2
  mov [edx + ecx*2], ax ; res[i1+i2] = ax
  sub ecx, ebx          ; i1 = (i1 + i2) - i2
  inc ecx               ; i1++
end_cycle:
  mov eax, ebx
  add eax, ecx
  cmp eax, [esp]        
  jbe cycle             ; i1 + i2 == lenght_a1 + lenght_a2 
  
  pop edi
  pop edi
  pop esi
  pop edx
  pop ecx
  pop ebx
  pop eax
  pop ebp
  ret

main:
  push a2len
  push a1len
  push offset res 
  push offset a2
  push offset a1

  call merge
  add esp, 20
 
  push 0
  call exit
  
END main