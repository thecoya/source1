*&---------------------------------------------------------------------*
*& Include          ZBC405_A07_EXAM01_CLASS
*&---------------------------------------------------------------------*


CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object,

      on_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.

*      on_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
*        IMPORTING er_data_changed.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.

  METHOD on_toolbar.
    DATA :  ls_button TYPE stb_button.
    CLEAR : ls_button.
    ls_button-butn_type = '3'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-function = 'AIRLINE_BUTTON'.
    ls_button-icon = icon_flight.
    ls_button-quickinfo = 'CARRID'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Airline'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-butn_type = '0'.
    ls_button-function = 'AIRLINE_BUTTON1'.
    ls_button-quickinfo = 'Goto Flight list info'.
    ls_button-text = 'Flight Info'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-butn_type = '0'.
    ls_button-function = 'AIRLINE_BUTTON2'.
    ls_button-quickinfo = 'Fligt Data'.
    ls_button-text = 'Flight Data'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
  ENDMETHOD.



  METHOD on_user_command.
    DATA : lv_text(20).

    DATA : lv_row_id TYPE lvc_s_row,
           lv_col_id TYPE lvc_s_col.

    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows TYPE lvc_s_roid.

    CALL METHOD go_alv_grid->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
        es_row_id = lv_row_id
        es_col_id = lv_col_id.

    CASE e_ucomm.
      WHEN 'AIRLINE_BUTTON'.
        IF lv_col_id-fieldname = 'CARRID'.

          READ TABLE gt_spf INTO gs_spf INDEX lv_row_id-index.
          IF sy-subrc EQ 0.
            CLEAR : lv_text.
            SELECT SINGLE carrname INTO lv_text FROM scarr
              WHERE carrid = gs_spf-carrid.
            IF sy-subrc EQ 0.
              MESSAGE i000(zt03_msg) WITH lv_text.
            ELSE.
              MESSAGE i000(zt03_msg) WITH 'BANANA'.
            ENDIF.
          ENDIF.
        ENDIF.



      WHEN 'AIRLINE_BUTTON1'.

        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*           et_index_rows = ls_rows
            et_row_no = lt_rows.

        LOOP AT lt_rows INTO ls_rows.
          READ TABLE gt_spf INTO gs_spf INDEX lv_row_id-index.
          CHECK sy-subrc EQ 0.
          MOVE-CORRESPONDING gs_spf TO gs_spfli.
          APPEND gs_spfli TO gt_spfli.
        ENDLOOP.


        EXPORT mem_it_spfli FROM gt_spfli TO MEMORY ID 'BC405'.
        SUBMIT bc405_call_flights AND RETURN.
        CHECK sy-subrc EQ 0.


      WHEN 'AIRLINE_BUTTON2'.
        READ TABLE gt_spf INTO gs_spf INDEX lv_row_id-index.

        IF  sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_spf-carrid.
          SET PARAMETER ID 'CON' FIELD gs_spf-connid.

          CALL TRANSACTION 'SAPBC410A_INPUT_FIEL'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.
*
*  METHOD on_data_changed.
*    DATA : ls_modif   TYPE lvc_s_modi,
*           lv_fltime  TYPE ztspfli_a07-fltime,
*           lv_deptime TYPE ztspfli_a07-deptime,
*           lv_arrtime TYPE spfli-arrtime,
*           lv_period  TYPE n,
*           lv_light   TYPE c LENGTH 1.
*
*
*    LOOP AT er_data_changed->mt_mod_cells INTO ls_modif.
*      CASE ls_modif-fieldname.
*        WHEN 'FLTIME' OR 'DEPTIME' .
*          READ TABLE gt_spf INTO gs_spf INDEX ls_modif-row_id.
*
*          CALL METHOD er_data_changed->get_cell_value
*            EXPORTING
*              i_row_id    = ls_modif-row_id
*             i_tabix     =
*              i_fieldname = 'FLTIME'
*            IMPORTING
*              e_value     = lv_fltime.
*
*          CALL METHOD er_data_changed->get_cell_value
*            EXPORTING
*              i_row_id    = ls_modif-row_id
*             i_tabix     =
*              i_fieldname = 'DEPTIME'
*            IMPORTING
*              e_value     = lv_deptime.
*
*
*          CALL FUNCTION 'ZBC405_CALC_ARRTIME'
*            EXPORTING
*              iv_fltime  = lv_fltime
*              iv_deptime = lv_deptime
*              iv_utc     = gs_spfli-ftz
*              iv_utc1    = gs_spfli_ttz
* IMPORTING
*             EV_ARRIVAL_TIME       =
*             EV_PERIOD  =.
*                           endcase.
*        ENDLOOP.
*
*ENDMETHOD.

ENDCLASS.
