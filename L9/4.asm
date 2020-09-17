.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  b dd ?
  n_dw dw ?
  n db ?  ;      0 <= n < 27
  format_n db "%hu", 0 
  format db "%s", 0
  question db "code or decode?", 0	
  s db 100 dup(0)
  alfabet db "ABCDEFGHIJKLMONPQRSTUVWXYZ "

.CODE

main:
  push offset n_dw
  push offset format_n
  call scanf
  add esp, 8
  mov ax, n_dw
  mov dx, 0
  mov bx, 27
  div bx
  mov n, dl
  
  call getchar

  push offset s
  call gets
  add esp, 4
  
  push offset question
  call printf
  add esp, 4
  
  push offset b
  push offset format_n
  call scanf
  add esp, 8
  
  cmp b, 0
  je code
  neg n
  add n, 27
code:

  mov ecx, 0
  mov bl, 27
cycle:
  mov al, s[ecx]
  call get_index
  add al, n
  mov ah, 0
  div bl
  movzx eax, ah
  mov al, alfabet[eax]
  mov s[ecx], al
  inc ecx
  cmp s[ecx], 0
  jne cycle
  
  push offset s
  call printf
  add esp, 4

  push 0
  call exit 


get_index:
; функция которая получает букву в регистре al 
; и возращает её индекс в регистре al
  cmp al, ' '
  je space
  sub al, 'A'
  jmp end_get_index
space:
  mov al, 26
end_get_index:
  ret  
  
END main