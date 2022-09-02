*&---------------------------------------------------------------------*
*& Include SAPMZSA0702_TOP                          - Report SAPMZSA0702
*&---------------------------------------------------------------------*
REPORT sapmzsa0702.



*DATA: BEGIN OF gs_cond,
*        carrid TYPE sflight-carrid,
*        connid TYPE sflight-connid,
*      END OF gs_cond.


" DATA ok_code LIKE sy-ucomm.

"condition
"Use screen.


TABLES zssa0707.

"Use ABAP

DATA gs_cond TYPE zssa0707.
DATA ok_code LIKE sy-ucomm.
