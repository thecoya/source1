*&---------------------------------------------------------------------*
*& Include          ZC1R260011_A07_M_S01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_car FOR scarr-carrid,
                   so_con FOR sflight-connid,
                   so_pla FOR sflight-planetype NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK a1.
