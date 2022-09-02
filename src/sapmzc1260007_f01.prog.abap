*&---------------------------------------------------------------------*
*& Include          SAPMZC1260007_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f4_wekrs
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f4_wekrs .

  SELECT werks, name1, ekorg, land1
  INTO TABLE @DATA(lt_werks)
    FROM t001w.

  IF sy-subrc NE 0.
    MESSAGE s001.
    EXIT.
  ENDIF.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield     = 'WERKS'
      dynpprog     = sy-repid
      dynpnr       = sy-dynnr
      dynprofield  = 'GS_DATA-WERKS'
      window_title = TEXT-t01
      value_org    = 'S'
    TABLES
      value_tab    = lt_werks.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  REFRESH gt_data.

  SELECT matnr werks mtart  matkl menge meins dmbtr waers
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztbom_a07_01.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .

  gs_layout-zebra = 'X'.
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = 'X'.


  IF gt_fcat IS INITIAL.

    PERFORM set_fact USING :             "너무 길어지게는 하지 말기
          'X'  'MATNR'  ' '    'ztbom_a07_01'   'MATNR'     ' '   ' ',
          'X'  'WERKS'  ' '    'ztbom_a07_01'   'WERKS'     ' '   ' ',
          ' '  'MTART'  ' '    'ztbom_a07_01'   'MTART'     ' '   ' ',
          ' '  'MATKL'  ' '    'ztbom_a07_01'   'MATKL'     ' '   ' ',
          ' '  'MENGE'  ' '    'ztbom_a07_01'   'MENGE'     'MEINS'   ' ',
          ' '  'MEINS'  ' '    'ztbom_a07_01'   'MEINS'     ' '   ' ',
          ' '  'DMBTR'  ' '    'ztbom_a07_01'   'DMBTR'     ' '   'WAERS ',
          ' '  'WAERS'  ' '    'ztbom_a07_01'   'WAERS'     ' '   ' '.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fact
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fact  USING    pv_key
                        pv_field
                        pv_text
                        pv_ref_table
                        pv_ref_field
                        pv_qfield
                        pv_cfield.

  gt_fcat = VALUE #( BASE gt_fcat
                    (
                    key        = pv_key
                    fieldname  = pv_field
                    coltext    = pv_text
                    ref_table  = pv_ref_table
                    ref_field  = pv_ref_field
                    qfieldname = pv_qfield
                    cfieldname = pv_cfield
                    )
                    ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

  IF gcl_container IS NOT BOUND.

    CREATE OBJECT gcl_container
      EXPORTING
        container_name = 'GCL_CONTAINER'.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.


    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ENDIF.


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
*  DATA : lt_save TYPE ztbom_a07_01,
*         ls_save LIKE LINE OF ls_save.


  DATA ls_save TYPE ztbom_a07_01.

  CLEAR ls_save.
*  REFRESH lt_save.

  IF gs_data-matnr IS INITIAL OR
    gs_data-werks IS INITIAL.
    MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.


  ls_save = CORRESPONDING #( gs_data ). "value로 다줄때랑 같다.
  " APPEND ls_save TO lt_save  str하나기 때문에 안써도 된다.

  MODIFY ztbom_a07_01 FROM ls_save.

  IF sy-dbcnt > 0.
    COMMIT WORK AND WAIT.
    MESSAGE s000 WITH TEXT-m01.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s000 WITH TEXT-m02 DISPLAY LIKE 'W'.

  ENDIF.


ENDFORM.
