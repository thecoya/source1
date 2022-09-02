*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m5.

TABLES sflight.
TABLES sbook.

SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-001.
  PARAMETERS pa_car TYPE sflight-carrid OBLIGATORY.
  SELECT-OPTIONS : so_con FOR sflight-connid OBLIGATORY.
  PARAMETERS pa_pla TYPE sflight-planetype AS LISTBOX VISIBLE LENGTH 20.
  SELECT-OPTIONS : so_bkid FOR sbook-bookid.
SELECTION-SCREEN END OF BLOCK c1.


TYPES: BEGIN OF ty_sfla,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         currency  TYPE sflight-currency,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         class     TYPE sbook-class,
         agencynum TYPE sbook-agencynum.
TYPES: END OF ty_sfla.

DATA: gs_sfla TYPE ty_sfla,
      gt_sfla LIKE TABLE OF gs_sfla.

TYPES: BEGIN OF ty_sflb,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         agencynum TYPE sbook-agencynum.
TYPES: END OF ty_sflb.

DATA: gs_sflb TYPE ty_sflb,
      gt_sflb LIKE TABLE OF gs_sflb.

REFRESH : gt_sfla, gt_sflb.

SELECT a~carrid a~connid a~fldate a~planetype a~currency
  b~bookid b~customid b~custtype b~class b~agencynum
  FROM sflight AS a INNER JOIN sbook AS b
  ON a~carrid = b~carrid
  AND a~connid = b~connid
  AND a~fldate = b~fldate
  INTO CORRESPONDING FIELDS OF TABLE gt_sfla
  WHERE a~carrid = pa_car     "selection screen에서 조회해야하니까. 조건을
  AND a~connid IN so_con
  AND a~planetype = pa_pla
  AND b~bookid IN so_bkid.

*IF sy-subrc ne 0.
*message s001.
*leave LIST-PROCESSING.
*ENDIF.


LOOP AT gt_sfla INTO gs_sfla.
  IF gs_sfla-custtype = 'B'.
    MOVE-CORRESPONDING gs_sfla TO gs_sflb.
    APPEND gs_sflb TO gt_sflb.
    CLEAR gt_sflb.
  ENDIF.

ENDLOOP.

*LOOP AT gt_sfla INTO gs_sfla.     --> MOVE-CORRESPONDING 쓴다.
*CASE gs_sfla-custtype.
*  WHEN 'B'.
*    gs_sflb-carrid = gs_sfla-carrid
*    gs_sflb-carrid = gs_sfla-carrid
*    gs_sflb-carrid = gs_sfla-carrid
*    gs_sflb-carrid = gs_sfla-carrid
*    gs_sflb-carrid = gs_sfla-carrid
*
*ENDLOOP.


"" 여기서 데이터 들어오는지 안들어오는지 selction screen에 데이터 넣으면서 디버깅으로 확인

SORT gt_sflb BY carrid connid fldate.
DELETE ADJACENT DUPLICATES FROM gt_sflb COMPARING carrid connid fldate.

cl_demo_output=>display_data( gt_sfla ).
