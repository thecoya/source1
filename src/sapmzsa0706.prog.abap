
*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0705
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE SAPMZSA0706_TOP.
*INCLUDE sapmzsa0705_top                         .    " Global Data

INCLUDE SAPMZSA0706_O01.
*INCLUDE sapmzsa0705_o01                         .  " PBO-Modules
INCLUDE SAPMZSA0706_I01.
*INCLUDE sapmzsa0705_i01                         .  " PAI-Modules
INCLUDE SAPMZSA0706_F01.
*INCLUDE sapmzsa0705_f01                         .  " FORM-Routines


LOAD-OF-PROGRAM.


PERFORM set_default CHANGING zssa0073.

CLEAR: gv_r1, gv_r2, gv_r3.

*gv_r2 = 'X'.
*gv_r1 = 'Z'.


  SELECT pernr ename
  FROM ztsa0001 UP TO 1 ROWS
  INTO CORRESPONDING FIELDS OF zssa0073.

  ENDSELECT.
