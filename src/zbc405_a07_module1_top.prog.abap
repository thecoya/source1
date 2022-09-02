*&---------------------------------------------------------------------*
*& Include ZBC405_A07_MODULE1_TOP                   - Report ZBC405_A07_MODULE1
*&---------------------------------------------------------------------*
REPORT zbc405_a07_module1 MESSAGE-ID s001.

TABLES ztsa0701.

DATA : gs_emp TYPE ztsa0701,
       gt_emp LIKE TABLE OF gs_emp.

DATA : gv_okcode TYPE sy-ucomm.

DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant,
       gs_stable     TYPE lvc_s_stbl.


DATA : gt_rows TYPE lvc_t_row,   "사용자가 선택한 행의 정보를 저장할 ITAB
       gs_row  TYPE lvc_s_row.

DEFINE _clear.

  CLEAR   &1.
  REFRESH &1.

END-OF-DEFINITION.
