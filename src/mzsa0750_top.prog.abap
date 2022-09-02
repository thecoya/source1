*&---------------------------------------------------------------------*
*& Include MZSA0750_TOP                             - Module Pool      SAPMZSA0750
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA0750.

DATA gv_subrc TYPE sy-subrc.


"Condition
TABLES zssa0750cond.
"DATA: gs_cond type scarr-carrid,



"Inflight Meal info
TABLES zssa0750tab1.



"Vendor info
TABLES zssa0750tab2.

DATA: gt_domain TYPE TABLE OF dd07v,
        gs_domain LIKE LINE OF gt_domain.


*DATA: gt_domain2 tYPE TABLE OF dd07v,
*        gs_domain2 LIKE LINE OF gt_domain2.

CONTROLS ts_mvinfo TYPE TABSTRIP.
