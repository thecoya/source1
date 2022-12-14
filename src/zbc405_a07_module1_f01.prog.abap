*&---------------------------------------------------------------------*
*& Include          ZBC405_A07_MODULE1_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_emp_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_emp_data .

  CLEAR gs_emp.
  _clear gt_emp.


  SELECT pernr ename entdt gender dcode carrid
    FROM ztsa0701
    INTO CORRESPONDING FIELDS OF TABLE gt_emp
    WHERE pernr IN so_pernr.



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
  gs_layout-zebra      = 'X'.
  gs_layout-sel_mode   = 'D'.
*  gs_layout-cwidth_opt = 'X'.

  IF gt_fcat IS INITIAL.
    PERFORM set_fcat USING :

     'X'   'PERNR'   ' '   'ZTSA0701'    'PERNR'    'X'  10,
     ' '   'ENAME'   ' '   'ZTSA0701'    'ENAME'    'X'  20,
     ' '   'ENTDT'   ' '   'ZTSA0701'    'ENTDT'    'X'  10,
     ' '   'GENDER'   ' '   'ZTSA0701'    'GENDER'  'X'  5,
     ' '   'DCODE'   ' '   'ZTSA0701'    'DCODE'    'X'  8,
     ' '   'CARRID'   ' '   'ZTSA0701'    'CARRID'  'X'  10.


  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_field pv_text pv_ref_table pv_ref_field
      pv_edit pv_length.

  gs_fcat = VALUE #(
                     key       = pv_key
                     fieldname = pv_field
                     coltext   = pv_text
                     ref_table = pv_ref_table
                     ref_field = pv_ref_field
                     edit = pv_edit
                     outputlen = pv_length
                   ).

  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_ROW
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_row .

  CLEAR gs_emp.

  APPEND gs_emp TO gt_emp.

  PERFORM refresh_grid.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid .
  gs_stable-row = 'X'.
  gs_stable-col = 'X'.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_stable
      i_soft_refresh = space.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_emp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_emp .

  "itab??? ????????? ???????????? ??????.
  DATA : lt_save  TYPE TABLE OF ztsa0701,
         lv_error.
  REFRESH lt_save.

  "ALV?????? -> ITAB ( Check changed data)   "ALV??? ????????? ?????? ITAB?????? ????????????
  CALL METHOD gcl_grid->check_changed_data. "???????????? ALV ?????? ??? ???????????? ITAB??????

  "?????? ?????? ??????????????? ????????????,

  CLEAR lv_error. "?????? ????????? ?????? ?????? ??????

  LOOP AT gt_emp INTO gs_emp.

    IF gs_emp-pernr IS INITIAL.
      MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
      lv_error = 'X'. "???????????? ?????? ?????? ?????? ????????? ???????????? ????????? ?????? ??????
      EXIT.           "?????? ???????????? ?????? ???????????? : ????????? loop???
    ENDIF.

    "ITAB??? ??????????????????

    lt_save = VALUE #( BASE lt_save       "?????? ?????? ???????????? ????????? ITAB??? ????????? ??????  "BASE??? ?????? ??????????????? ????????? ???????????? ?????? ??????
                       (
                        pernr = gs_emp-pernr
                        ename = gs_emp-ename
                        entdt = gs_emp-entdt
                        gender = gs_emp-gender
                        dcode = gs_emp-dcode
                        carrid = gs_emp-carrid
                         )
                         ).
  ENDLOOP.

* CHECK lv_error is initial.  "????????? ????????? ??? ?????? ?????? " ????????? ????????? ?????? ?????? ????????????

  IF lv_error IS NOT INITIAL.  "????????? ????????? ?????? ?????? ????????????
    EXIT.
  ENDIF.

  IF lt_save IS NOT INITIAL.
    MODIFY ztsa0701 FROM TABLE lt_save.
    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE s002. "data ?????? ?????????.
    ENDIF.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form delete_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_row .

  REFRESH gt_rows.

  CALL METHOD gcl_grid->get_selected_rows "???????????? ????????? ?????? ????????? ?????????
    IMPORTING
      et_index_rows = gt_rows.

  IF gt_rows IS INITIAL. "?????? ??????????????? ??????
    MESSAGE s000 WITH TEXT-e02 DISPLAY LIKE 'E'.
  ENDIF.

  SORT gt_rows BY index DESCENDING.  "delete?????? ?????? ????????? ??????

  LOOP AT gt_rows INTO gs_row.
    DELETE gt_emp INDEX gs_row-index. "???????????? ????????? ?????? ?????? ??????
  ENDLOOP.

  PERFORM refresh_grid.  "????????? ITAB??? ALV??? ??????

ENDFORM.
