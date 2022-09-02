*&---------------------------------------------------------------------*
*& Report ZBC405_A07_EXAM01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_exam01.


TABLES ztspfli_a07.

*-- type선언
    TYPES: BEGIN OF gty_spfli. INCLUDE TYPE ztspfli_a07.
TYPES: indo TYPE c LENGTH 1.
TYPES: flight TYPE c LENGTH 10.
TYPES: fly TYPE icon-id.
TYPES: ftz TYPE ztspfli_a07-airpfrom.
TYPES: ttz TYPE ztspfli_a07-airpto.
TYPES: row_color TYPE c LENGTH 4.
TYPES: it_col TYPE lvc_t_scol.
TYPES: light    TYPE c LENGTH 1.
TYPES: END OF gty_spfli.

*-- data선언
DATA: gt_spf TYPE TABLE OF gty_spfli,
      gs_spf TYPE gty_spfli.
DATA ok_code LIKE sy-ucomm.

DATA: gt_spfli TYPE TABLE OF spfli,
      gs_spfli TYPE spfli.


*-- select-options
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : so_car FOR ztspfli_a07-carrid OBLIGATORY MEMORY ID car,
                   so_con FOR ztspfli_a07-connid MEMORY ID con.

  SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(20) TEXT-t04.
    PARAMETERS pa_edit AS CHECKBOX.

    SELECTION-SCREEN COMMENT pos_low(20) TEXT-t03.
    PARAMETERS p_layout TYPE disvariant-variant.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b3.

*-- ALV 변수
DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid  TYPE REF TO cl_gui_alv_grid,
      gv_variant   TYPE disvariant,
      gv_save      TYPE c LENGTH 1,
      gs_layout    TYPE lvc_s_layo,
      gs_fcat      TYPE lvc_s_fcat,
      gt_fcat      TYPE lvc_t_fcat,
      gs_color     TYPE lvc_s_scol.

INCLUDE zbc405_a07_exam01_class.


INITIALIZATION.
  gv_variant-report = sy-cprog.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_layout.
  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load     = 'F'
    CHANGING
      cs_variant      = gv_variant
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0.
  ELSEIF
    p_layout = gv_variant-variant.
  ENDIF.







START-OF-SELECTION.

*-- PERFORM
  PERFORM get_data.


  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF pa_edit = 'X'.
    SET PF-STATUS 'S100'.
  ELSE.
    SET PF-STATUS 'S100' EXCLUDING 'SAVE'.
  ENDIF.

  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'SAVE'.

      PERFORM save_data.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_spf
    FROM ztspfli_a07
    WHERE carrid IN so_car
  AND   connid IN so_con.

  LOOP AT gt_spf INTO gs_spf.
    IF gs_spf-countryfr = gs_spf-countryto.
      gs_spf-indo = 'D'.
    ELSEIF gs_spf-countryfr <> gs_spf-countryto.
      gs_spf-indo = 'I'.
    ENDIF.

**-비행기 아이콘
    IF gs_spf-fltype = 'X'.
      gs_spf-fly = icon_flight.
    ELSE.
      gs_spf-fly = icon_space.
    ENDIF.

    IF gs_spf-indo = 'I'.
      gs_color-fname = 'INDO'.
      gs_color-color-col = col_total.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_spf-it_col.
    ENDIF.

    IF gs_spf-indo = 'D'.
      gs_color-fname = 'INDO'.
      gs_color-color-col = col_group.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_spf-it_col.
    ENDIF.

    "Exception light

    IF gs_spf-period >= 2.
      gs_spf-light = '1'.

    ELSEIF gs_spf-period = 1.
      gs_spf-light = '2'.

    ELSEIF gs_spf-period = 0.
      gs_spf-light = '3'.
    ENDIF.


    MODIFY gt_spf FROM gs_spf.


  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module CREATE_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_object OUTPUT.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    PERFORM make_variant.
    PERFORM make_catalog.
    PERFORM make_layout.


    SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
*    SET HANDLER lcl_handler=>on_data_changed FOR go_alv.
*    SET HANDLER lcl_handler=>on_data_changed_finish FOR go_alv.


    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*       i_buffer_active               =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name              = 'ZTSPFLI_A07'
        is_variant                    = gv_variant
        i_save                        = gv_save
        i_default                     = 'X'
        is_layout                     = gs_layout
*       is_print                      =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink                  =
*       it_alv_graphics               =
*       it_except_qinfo               =
*       ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_spf
        it_fieldcatalog               = gt_fcat
*       it_sort                       =
*       it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.



  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_variant .
  gv_variant-report = sy-cprog.
  gv_variant-variant = p_layout.
  gv_save = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form make_catalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_catalog .

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'INDO'.
  gs_fcat-coltext = 'I&D'.
  gs_fcat-col_pos = 10.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FLTYPE'.
  gs_fcat-no_out = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FLY'.
  gs_fcat-coltext = 'FLIGHT'.
  gs_fcat-col_pos = 11.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FTZ'.
  gs_fcat-coltext = 'From Tzon'.
  gs_fcat-col_pos = 30.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'TTZ'.
  gs_fcat-coltext = 'To Tzone'.
  gs_fcat-col_pos = 31.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FLTIME'.
  gs_fcat-edit = pa_edit.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'DEPTIME'.
  gs_fcat-edit = pa_edit.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'ARRTIME'.
  gs_fcat-emphasize = 'C510'.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.
  gs_fcat-emphasize = 'C310'.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout .
  gs_layout-zebra = 'X'.
  gs_layout-info_fname = 'ROW_COLOR'.
  gs_layout-ctab_fname = 'IT_COL'.
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_data .
  DATA p_ans TYPE c LENGTH 1.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Save the data'
*     DIAGNOSE_OBJECT       = ' '
      text_question         = 'ARE YOU SERIOUSLY DONE?'
      text_button_1         = 'YES'(001)
*     ICON_BUTTON_1         = ' '
      text_button_2         = 'NO'(002)
*     ICON_BUTTON_2         = ' '
      default_button        = '1'  "1 = YES.
      display_cancel_button = ' '
*     USERDEFINED_F1_HELP   = ' '
*     START_COLUMN          = 25
*     START_ROW             = 6
*     POPUP_TYPE            =
*     IV_QUICKINFO_BUTTON_1 = ' '
*     IV_QUICKINFO_BUTTON_2 = ' '
    IMPORTING
      answer                = p_ans
* TABLES
*     PARAMETER             =
    EXCEPTIONS
      text_not_found        = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    IF p_ans = '1'.
*      PERFORM save_data.
    ENDIF.
  ENDIF.
ENDFORM.
