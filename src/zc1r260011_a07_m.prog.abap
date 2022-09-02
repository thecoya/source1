*&---------------------------------------------------------------------*
*& Report ZC1R260011_A07_M
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R260011_A07_M_TOP                    .    " Global Data
INCLUDE zc1r260011_a07_m_s01.
 INCLUDE ZC1R260011_A07_M_O01                    .  " PBO-Modules
 INCLUDE ZC1R260011_A07_M_I01                    .  " PAI-Modules
 INCLUDE ZC1R260011_A07_M_F01                    .  " FORM-Routines


 START-OF-SELECTION.
 PERFORM get_flight_data.
