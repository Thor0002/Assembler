.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  s db "afljiha", 0 
  min db 7 dup(255), 0
  len dd ?
  
.CODE
main:
   mov ecx, 0
find_len:
  cmp s[ecx], 0
  je start
  inc ecx
  jmp find_len

start:
  mov len, ecx  
  mov ecx, 0
cycle1:
 jmp string_comparison
end_string_comparison:
 jmp cyclic_shift
end_cyclic_shift:
 inc ecx
 cmp ecx, len
 je end_
 jmp cycle1
 
end_: 
  push 0
  call exit
  
;cyclic_shift - фунция которая принимает переменную s - строку
; её длину - len, и делает циклический сдвиг строки s вправо, также 
; использует регистры ebx,dh,dl
cyclic_shift:  
  mov ebx, len
  dec ebx
  mov dl, s[ebx]
  dec ebx
cycle2:
  cmp ebx, -1
  je end_shift
  mov dh, s[ebx]
  mov s[ebx + 1], dh
  dec ebx
  jmp  cycle2
end_shift:
  mov s[0], dl
  jmp end_cyclic_shift
;____________________
;string_comparison - фунция которая принимает переменные s, min 
;имеющие длину len и кладет минимальную из них(лексикографически)
; в переменную min, также использует регистры ebx,dh,dl 
string_comparison:
  mov ebx, 0
cycle3_1:
  mov dl, s[ebx]
  cmp dl, min[ebx]
  ja end_string_comparison
  jb cycle3_2
  inc ebx
  cmp ebx, len
  je end_string_comparison
  jmp cycle3_1
cycle3_2:
  mov min[ebx], dl
  inc ebx
  cmp ebx, len
  je end_string_comparison
  mov dl, s[ebx]
  jmp cycle3_2
    
  
END main