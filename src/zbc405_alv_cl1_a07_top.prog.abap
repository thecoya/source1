**+....`&---------------------------------------------------------------------*
*& Include ZBC405_ALV_CL1_A07_TOP                   - Report ZBC405_ALV_CL1_A07
*&---------------------------------------------------------------------*
REPORT zbc405_alv_cl1_a07.


TABLES : ztsbook_a07.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.                         "sign -> include or exclude
  SELECT-OPTIONS : so_car FOR ztsbook_a07-carrid OBLIGATORY MEMORY ID car,            "기본타입, low, high에 값이 들어있는거고, eq 등 옵션 * 아무것도 안했을때, i에 eq.
                   so_con FOR ztsbook_a07-connid MEMORY ID con,
                   so_fld FOR ztsbook_a07-fldate,
                   so_cus FOR ztsbook_a07-customid.

  SELECTION-SCREEN SKIP.

  PARAMETERS : p_edit AS CHECKBOX.   "조회프로그램과 maintain프로그램이 같이 있는 것.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN SKIP.

PARAMETERS : p_layout TYPE disvariant-variant.

*---------------------------------------------DATA선언

TYPES : BEGIN OF gty_sbook.
          INCLUDE TYPE ztsbook_a07.
TYPES:    light TYPE c LENGTH 1.
TYPES: telephone TYPE ztscustom_a07-telephone.
TYPES: email TYPE ztscustom_a07-email.

TYPES: row_color TYPE c LENGTH 4.
TYPES: it_color TYPE lvc_t_scol.
TYPES: bt TYPE lvc_t_styl.
TYPES: modified TYPE c LENGTH 1. "레코드가 변경되면 'X'표시 !
TYPES : END OF gty_sbook.


DATA : gt_custom TYPE TABLE OF ztscustom_a07,
       gs_custom TYPE ztscustom_a07.

DATA : gt_temp TYPE TABLE OF gty_sbook.

DATA : gt_sbook TYPE TABLE OF gty_sbook,
       gs_sbook TYPE          gty_sbook,
*       dl_sbook TYPE TABLE OF gty_sbook.
       dl_sbook TYPE TABLE OF ztsbook_a07,
       dw_sbook TYPE ztsbook_a07.


DATA : ok_code TYPE sy-ucomm.


*-- FOR ALV변수

DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.

DATA : gs_variant TYPE disvariant,
       gs_layout  TYPE lvc_s_layo,
       gt_sort    TYPE lvc_t_sort,
       gs_sort    TYPE lvc_s_sort,
       gs_color   TYPE lvc_s_scol,
       gt_exct    TYPE ui_functions,
       gt_fcat    TYPE lvc_t_fcat,
       gs_fcat    TYPE lvc_s_fcat.
