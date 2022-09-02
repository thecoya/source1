*&---------------------------------------------------------------------*
*& Include ZC1R260011_A07_M_TOP                     - Report ZC1R260011_A07_M
*&---------------------------------------------------------------------*
REPORT zc1r260011_a07_m MESSAGE-ID zmcsa07.  "주는 이유??

"message i06(pn) with 'test'.
"message i06

TABLES : scarr, sflight.

DATA : BEGIN OF gs_list,
         carrid    TYPE scarr-carrid,
         carrname  TYPE scarr-carrname,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         url       TYPE scarr-url,
       END OF gs_list,

       gt_list LIKE TABLE OF gs_list.
