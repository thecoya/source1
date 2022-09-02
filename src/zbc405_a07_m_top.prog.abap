*&---------------------------------------------------------------------*
*& Include ZBC405_A07_M_TOP                         - Report ZBC405_A07_M
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m.


*ztsa2001

TYPES: BEGIN OF ts_emp,
         pernr    TYPE ztsa2001-pernr,
         ename    TYPE ztsa2001-ename,
         depid    TYPE ztsa2001-depid,
         gender   TYPE ztsa2001-gender,
         gender_a TYPE c LENGTH 10,
         phone    TYPE ztsa2002-phone.

TYPES: END OF ts_emp.

DATA : gs_emp TYPE ts_emp,
       gt_emp LIKE TABLE OF gs_emp.

DATA : gs_dep TYPE ztsa2002.
