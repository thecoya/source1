*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0705
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE sapmzsa0705_top                         .    " Global Data

INCLUDE sapmzsa0705_o01                         .  " PBO-Modules
INCLUDE sapmzsa0705_i01                         .  " PAI-Modules
INCLUDE sapmzsa0705_f01                         .  " FORM-Routines


LOAD-OF-PROGRAM.


PERFORM set_default CHANGING zssa0073.

  SELECT pernr ename
  FROM ztsa0001 UP TO 1 ROWS
  INTO CORRESPONDING FIELDS OF zssa0073.

  ENDSELECT.
