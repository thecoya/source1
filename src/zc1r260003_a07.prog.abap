*&---------------------------------------------------------------------*
*& Report ZC1R260003_A07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r260003_a07_top                      .    " Global Data
INCLUDE zc1r260003_a07_s01                      .   "  Selectio-Screen
INCLUDE zc1r260003_a07_o01                      .  " PBO-Modules
INCLUDE zc1r260003_a07_i01                      .  " PAI-Modules
INCLUDE zc1r260003_a07_f01                      .  " FORM-Routines
*&---------------------------------------------------------------------*
*& Form modify_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_screen .
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'PA_PBDNR' OR 'PA_VERSB'.
        screen-input = 0.
        MODIFY SCREEN.
    ENDCASE.

    CASE 'X'.
      WHEN pa_crt.
*        CASE  screen-name.
*          WHEN 'SO_EKGRP' OR 'PA_DISCO' OR 'PA_DISMM'.
*            screen-active = 0.
*            MODIFY SCREEN.
*        ENDCASE.

        CASE screen-group1.  "group으로 변경
          WHEN 'MAC'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.

      WHEN pa_disp.
        CASE screen-group1.
          WHEN 'MAR'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.
    ENDCASE.
  ENDLOOP.
ENDFORM.
