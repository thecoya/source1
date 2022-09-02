*&---------------------------------------------------------------------*
*& Include          YCL107_002_CLS
*&---------------------------------------------------------------------*


" 2-1 alv 데이터 선언
DATA : GR_CON TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GR_ALV TYPE REF TO CL_GUI_ALV_GRID.

DATA: GS_LAYOUT TYPE LVC_S_LAYO,
      GS_FCAT TYPE LVC_S_FCAT,
      GT_FCAT TYPE LVC_T_FCAT.
