*&---------------------------------------------------------------------*
*& Include SAPMZC1260007_TOP                        - Module Pool      SAPMZC1260007
*&---------------------------------------------------------------------*
PROGRAM sapmzc1260007 MESSAGE-ID zc226. "MESSAGE-ID 쓰기


DATA : BEGIN OF gs_data,
         matnr TYPE ztbom_a07_01-matnr, "material
         werks TYPE ztbom_a07_01-werks, "plant
         mtart TYPE ztbom_a07_01-mtart, "Mat.Type
         matkl TYPE ztbom_a07_01-matkl, "Mat.Group
         menge TYPE ztbom_a07_01-menge, "Quantity
         meins TYPE ztbom_a07_01-meins, "Unit
         dmbtr TYPE ztbom_a07_01-dmbtr, "Price
         waers TYPE ztbom_a07_01-waers, "Currency
       END OF gs_data,

       gt_data   LIKE TABLE OF gs_data,
       gv_okcode TYPE sy-ucomm.

* ALV 관련 재료 준비"

DATA : gcl_container TYPE REF TO cl_gui_custom_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant.
