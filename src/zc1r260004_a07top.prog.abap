*&---------------------------------------------------------------------*
*& Include ZC1R260004_A07TOP                        - Report ZC1R260004_A07
*&---------------------------------------------------------------------*
REPORT zc1r260004_a07.


TYPES mast.

DATA : BEGIN OF gs_data,
         werks TYPE mast-werks,
         matnr TYPE mast-matnr.

DATA : END OF gs_data.
DATA : gt_data LIKE TABLE OF gs_data.

*DATA : gcl_container TYPE REF TO cl_gui_docking_container,
*       gcl_grid      TYPE REF TO cl_gui_alv_grid.
