*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m4.


TABLES sbook.

SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-001.
  PARAMETERS pa_car TYPE sbook-carrid OBLIGATORY DEFAULT 'AA' VALUE CHECK.
  SELECT-OPTIONS : so_con FOR sbook-connid OBLIGATORY.
  PARAMETERS : pa_cus TYPE sbook-custtype AS LISTBOX VISIBLE LENGTH 20 DEFAULT 'B'.  "TIP !!! 스크린화면에서 바로 보이게 !
  SELECT-OPTIONS : so_fld FOR sbook-fldate DEFAULT sy-datlo.  "현지시간
  SELECT-OPTIONS : so_bkid FOR sbook-bookid.
  SELECT-OPTIONS : so_cusid FOR sbook-customid NO INTERVALS NO-EXTENSION.  "TIP! "parameter변수처럼 보이게할것 "PARAMETER의 공백은 공백을 보는 개념 / Select options는 데이터가 없으면 그냥 넘긴다.
SELECTION-SCREEN END OF BLOCK c1.


TYPES:BEGIN OF ty_sbk,
        carrid   TYPE sbook-carrid,
        connid   TYPE sbook-connid,
        fldate   TYPE sbook-fldate,
        bookid   TYPE sbook-bookid,
        customid TYPE sbook-customid,
        custtype TYPE sbook-custtype,
        invoice  TYPE sbook-invoice,
        class    TYPE sbook-class.
TYPES: END OF ty_sbk.

DATA: gs_sbk   TYPE ty_sbk,
      gt_sbk   LIKE TABLE OF gs_sbk,
      lv_tabix TYPE sy-tabix.

SELECT carrid connid fldate bookid customid custtype invoice class
  FROM sbook
  INTO CORRESPONDING FIELDS OF TABLE gt_sbk
  WHERE carrid = pa_car
  AND   custtype = pa_cus
  AND   connid IN so_con
  AND   fldate IN so_fld
  AND   bookid IN so_bkid
  AND   customid IN so_cusid.

LOOP AT gt_sbk INTO gs_sbk.
  lv_tabix = sy-tabix.
  IF gs_sbk-invoice = 'X'.
    gs_sbk-class = 'F'.
  ENDIF.
  MODIFY gt_sbk FROM gs_sbk INDEX lv_tabix TRANSPORTING class.
ENDLOOP.

cl_demo_output=>display_data( gt_sbk ).
