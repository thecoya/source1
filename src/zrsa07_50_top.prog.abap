*&---------------------------------------------------------------------*
*& Include ZRSA07_50_TOP                            - Report ZRSA07_50
*&---------------------------------------------------------------------*
REPORT ZRSA07_50.



DATA: gs_pro TYPE zsta07pro,
      gt_pro LIKE TABLE OF gs_pro.


PARAMETERS pa_ecode TYPE zsta07pro.
