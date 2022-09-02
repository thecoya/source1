*&---------------------------------------------------------------------*
*& Module Pool      ZRSA07_52
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa07_52_top                           .    " Global Data

INCLUDE zrsa07_52_o01                           .  " PBO-Modules
INCLUDE zrsa07_52_i01                           .  " PAI-Modules
INCLUDE zrsa07_52_f01                        .  " FORM-Routines


INITIALIZATION.

PERFORM set_init.

AT SELECTION-SCREEN OUTPUT.
  MESSAGE s000(zmcsa07) WITH 'PBO'.

AT SELECTION-SCREEN.

START-OF-SELECTION.

SELECT SINGLE *
  FROM sflight
  WHERE carrid = pa_car
  AND   connid = pa_con
  AND fldate IN so_dat.

CALL SCREEN 100.
  MESSAGE s000(zmcsa07) WITH 'After call screen'.
