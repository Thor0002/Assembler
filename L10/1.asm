.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  kh dd 3600
  km dd 60
  h1 dd ?
  h2 dd ?
  m1 dd ?
  m2 dd ?
  s1 dd ?
  s2 dd ?
  t  dd 0
  format db "%u", 0

.CODE
main:
  push offset h1
  push offset format
  call scanf
  add esp, 8
  
  push offset m1
  push offset format
  call scanf
  add esp, 8
  
  push offset s1
  push offset format
  call scanf
  add esp, 8
  
  push offset h2
  push offset format
  call scanf
  add esp, 8
  
  push offset m2
  push offset format
  call scanf
  add esp, 8
  
  push offset s2
  push offset format
  call scanf
  add esp, 8
  
  mov eax, h2
  sub eax, h1
  mul kh
  mov t, eax
  
  mov eax, m2
  sub eax, m1
  imul km
  add t, eax
  
  mov eax, s2
  sub eax, s1
  add t, eax
  
  push t
  push offset format
  call printf
  add esi, 8
  
  push 0
  call exit
  
END main
