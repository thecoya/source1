*&---------------------------------------------------------------------*
*& Include          ZC1R260003_A07_S01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : pa_werks TYPE mkal-werks DEFAULT '1010',
               pa_berid TYPE pbid-berid DEFAULT '1010',
               pa_pbdnr TYPE pbid-pbdnr,
               pa_versb TYPE pbid-versb DEFAULT '00'.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002.
  PARAMETERS : pa_crt  RADIOBUTTON GROUP rg1 DEFAULT 'X' USER-COMMAND mod,
               pa_disp RADIOBUTTON GROUP rg1.
SELECTION-SCREEN END OF BLOCK a2.

SELECTION-SCREEN BEGIN OF BLOCK a3 WITH FRAME TITLE TEXT-003.
  SELECT-OPTIONS : so_matnr FOR mara-matnr MODIF ID mar,
                   so_mtart FOR mara-mtart MODIF ID mar,
                   so_matkl FOR mara-matkl MODIF ID mar,
                   so_ekgrp FOR marc-ekgrp MODIF ID mac.

  PARAMETERS : pa_disco TYPE marc-dispo MODIF ID mac,
               pa_dismm TYPE marc-dismm MODIF ID mac.
SELECTION-SCREEN END OF BLOCK a3.



AT SELECTION-SCREEN OUTPUT. "선제 작업
  PERFORM modify_screen.
