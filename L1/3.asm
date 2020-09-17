.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  a dd 123
  b dd 321
  s dd 17
  ans dd ?
  
.CODE
main:
  mov eax, a
  mul b
  div s
  mov ans, edx
  
  push 0
  call exit
  
END main
