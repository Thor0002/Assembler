.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDELIB msvcrt.lib

.DATA
  s db "aszdvgb", 0
  max db 3 dup(0)

.CODE
main:
  mov edx, 0
cycle1:
  cmp s[edx], 0
  je start
  inc edx
  jmp cycle1

start:  
  sub edx, 3
cycle2:
  mov al, s[edx]
  mov bl, s[edx + 1]
  mov cl, s[edx + 2]
  cmp al, max[0]
  jb no
  ja yes
  cmp bl, max[1]
  jb no
  ja yes
  cmp cl, max[2]
  jb no
yes:
  mov max[0], al
  mov max[1], bl
  mov max[2], cl
no:
  dec edx
  cmp edx, -1
  je end_
  jmp cycle2
  
end_:
  push 0
  call exit
  
END main\