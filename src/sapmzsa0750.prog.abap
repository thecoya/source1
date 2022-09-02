*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0750
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE MZSA0750_TOP                            .    " Global Data

 INCLUDE MZSA0750_O01                            .  " PBO-Modules
 INCLUDE MZSA0750_I01                            .  " PAI-Modules
 INCLUDE MZSA0750_F01                            .  " FORM-Routines


LOAD-OF-PROGRAM.
PERFORM set_default CHANGING zssa0750cond.
