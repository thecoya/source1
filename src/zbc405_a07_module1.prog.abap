*&---------------------------------------------------------------------*
*& Report ZBC405_A07_MODULE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a07_module1_top                  .    " Global Data
INCLUDE zbc405_a07_module1_s01.
INCLUDE zbc405_a07_module1_c01.
INCLUDE zbc405_a07_module1_o01                  .  " PBO-Modules
INCLUDE zbc405_a07_module1_i01                  .  " PAI-Modules
INCLUDE zbc405_a07_module1_f01                  .  " FORM-Routines



START-OF-SELECTION.

PERFORM get_emp_data.


call SCREEN '0100'.
