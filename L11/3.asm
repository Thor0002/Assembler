.486
.model FLAT, stdcall

INCLUDE stdlib.inc
INCLUDE stdio.inc
INCLUDELIB msvcrt.lib

.DATA
  av dq ?
  bv dq ?
  cv dq ?
  Re_x1 dq ?
  Im_x1 dq 0
  Re_x2 dq ?
  Im_x2 dq 0
  four  dq 4.0
  two dq 2.0
  D dq ?
  b_div_2a dq ?
  sqrt_D_div_2a dq ?
  format_in db "%lf%lf%lf", 0
  format_out_x1_neg_D db "x1 = %lf + i * %lf", 10, 0
  format_out_x2_neg_D db "x2 = %lf - i * %lf", 0
  format_out_x1_pos_D db "x1 = %lf", 10, 0
  format_out_x2_pos_D db "x2 = %lf", 0
  format_out_D_eq_0 db "x = %lf", 0

.CODE
main:
  push offset cv
  push offset bv
  push offset av
  push offset format_in
  call scanf
  add esp, 16
  
  FLD av
  FLD cv
  FLD bv
  FLD bv
  FMUL
  FXCH ST(2)
  FMUL
  FLD four
  FMUL
  FSUB
  FSTP D
  
  FLD bv
  FLD av
  FLD two
  FMUL
  FXCH
  FCHS
  FDIVR
  FSTP b_div_2a
  
  FLD D
  FLD av
  FLD two
  FMUL
  FXCH
  FABS
  FSQRT
  FDIVR
  FSTP sqrt_D_div_2a
  
  FLDZ
  FLD D
  FCOMP
  FSTSW ax
  SAHF
  jb D_less_0
  je D_equal_0
  FLD b_div_2a
  FLD sqrt_D_div_2a
  FADD
  FSTP Re_x1
  FLD b_div_2a
  FLD sqrt_D_div_2a
  FSUB
  FSTP Re_x2
  push dword ptr [Re_x1+4]
  push dword ptr [Re_x1]
  push offset format_out_x1_pos_D
  call printf
  add esp, 12
  push dword ptr [Re_x2+4]
  push dword ptr [Re_x2]
  push offset format_out_x2_pos_D
  call printf
  add esp, 12
  jmp end_
D_less_0:
  FLD sqrt_D_div_2a
  FST Im_x1
  FLD b_div_2a
  FSTP Re_x1
  push dword ptr [Im_x1+4]
  push dword ptr [Im_x1]
  push dword ptr [Re_x1+4]
  push dword ptr [Re_x1]
  push offset format_out_x1_neg_D
  call printf
  add esp, 20
  push dword ptr [Im_x1+4]
  push dword ptr [Im_x1]
  push dword ptr [Re_x1+4]
  push dword ptr [Re_x1]
  push offset format_out_x2_neg_D
  call printf
  add esp, 20
  jmp end_
D_equal_0:
  push dword ptr [b_div_2a+4]
  push dword ptr [b_div_2a]
  push offset format_out_D_eq_0
  call printf
  add esp, 12

end_: 
  push 0
  call exit
  
END main