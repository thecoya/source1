*&---------------------------------------------------------------------*
*& Include ZRSA07_31_TOP                            - Report ZRSA07_31
*&---------------------------------------------------------------------*
REPORT ZRSA07_31.

" employee list
DATA: gs_emp TYPE ztsa0007,
      gt_emp LIKE TABLE OF gs_emp.


" selection screen
PARAMETERS: pa_ent_b LIKE gs_emp-entdt,
            pa_ent_e LIKE gs_emp-entdt.
