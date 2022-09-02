*&---------------------------------------------------------------------*
*& Report SAPMZSA0702
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE sapmzsa0702_top                         .    " Global Data

INCLUDE sapmzsa0702_o01                         .  " PBO-Modules
INCLUDE sapmzsa0702_i01                         .  " PAI-Modules
INCLUDE sapmzsa0702_f01                         .  " FORM-Routines



LOAD-OF-PROGRAM.  "initialization과 같음(단 ini는 1번프로그램에서만)
PERFORM set_default.
