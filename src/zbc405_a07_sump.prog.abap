*&---------------------------------------------------------------------*
*& Report ZBC405_A07_SUMP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_sump.



TYPES: BEGIN OF typ_sump.
         INCLUDE TYPE ztspfli_t03.
TYPES:   sum_sump TYPE ztspfli_t03-wtg001.
TYPES: END OF typ_sump.


DATA gt_sump TYPE TABLE OF typ_sump.
DATA gs_sump TYPE typ_sump.
DATA ok_code LIKE sy-ucomm.
DATA gt_fcat TYPE lvc_t_fcat.
DATA gs_fcat TYPE lvc_s_fcat.
DATA gs_layout TYPE lvc_s_layo.


SELECT-OPTIONS : so_car FOR gs_sump-carrid,
                  so_con FOR gs_sump-connid.


*DATA : gt_tab TYPE TABLE OF ztspfli_t03.
*DATA: wa_tab TYPE ztspfli_a07.
*DATA: fname(30).
*DATA: nn(10) TYPE n.
*DATA: sum_sump TYPE ztspfli_t03-wtg001.
*FIELD-SYMBOLS : <fs> TYPE any.



DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.


INITIALIZATION.

START-OF-SELECTION.

  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_sump  FROM ztspfli_t03
    WHERE carrid IN so_car
      AND connid IN so_con.





  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T10'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_CONTAINER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_container OUTPUT.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    IF sy-subrc EQ 0.
      gs_fcat-fieldname = 'SUM_SUMP'.
      gs_fcat-cfieldname = 'WAERS'.
      gs_fcat-coltext = 'Sum practice'.
      gs_fcat-col_opt = 'X'.
      gs_fcat-col_pos = 10.
      APPEND gs_fcat TO gt_fcat.
    ENDIF.

    gs_layout-cwidth_opt = 'X'.


    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'ZTSPFLI_T03'
*       is_variant       =
*       i_save           =
*       i_default        = 'X'
        is_layout        = gs_layout
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_sump
        it_fieldcatalog  = gt_fcat
*       it_sort          =
*       it_filter        =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error    = 2
*       too_many_lines   = 3
*       others           = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.









  ENDIF.
ENDMODULE.
