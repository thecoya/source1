*&---------------------------------------------------------------------*
*& Report ZC1R260004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R260004_TOP_A07_COPY.
*INCLUDE zc1r260004_top                          .    " Global Data

INCLUDE ZC1R260004_S01_A07_COPY.
*INCLUDE zc1r260004_s01                          .  " Selection Screen
INCLUDE ZC1R260004_C01_A07_COPY.
*INCLUDE zc1r260004_c01                          .  " Local Class
INCLUDE ZC1R260004_O01_A07_COPY.
*INCLUDE zc1r260004_o01                          .  " PBO-Modules
INCLUDE ZC1R260004_I01_A07_COPY.
*INCLUDE zc1r260004_i01                          .  " PAI-Modules
INCLUDE ZC1R260004_F01_A07_COPY.
*INCLUDE zc1r260004_f01                          .  " FORM-Routines


START-OF-SELECTION.
  PERFORM get_bom_data.




  CALL SCREEN '0100'.
