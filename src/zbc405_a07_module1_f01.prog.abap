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

  "itab과 완벽히 동일해야 한다.
  DATA : lt_save  TYPE TABLE OF ztsa0701,
         lv_error.
  REFRESH lt_save.

  "ALV변경 -> ITAB ( Check changed data)   "ALV의 입력된 값을 ITAB으로 반영시킴
  CALL METHOD gcl_grid->check_changed_data. "사용자가 ALV 입력 시 그때마다 ITAB반영

  "하나 저장 되어있는지 확인하고,

  CLEAR lv_error. "필수 입력값 입력 여부 체크

  LOOP AT gt_emp INTO gs_emp.

    IF gs_emp-pernr IS INITIAL.
      MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
      lv_error = 'X'. "에러발생 했을 경우 저장 플로우 수행방지 위해서 값을 세팅
      EXIT.           "현재 수행중인 루틴 빠져나감 : 지금은 loop문
    ENDIF.

    "ITAB에 넣어야하기에

    lt_save = VALUE #( BASE lt_save       "에러 없는 데이터는 저장할 ITAB에 데이터 저장  "BASE는 값을 안바꾸는건 그대로 가져가기 위해 써줌
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

* CHECK lv_error is initial.  "체크문 만족할 때 이후 진행 " 에러가 없으면 아래 로직 수해ㅑㅇ

  IF lv_error IS NOT INITIAL.  "에러가 있다면 현재 루틴 빠져나감
    EXIT.
  ENDIF.

  IF lt_save IS NOT INITIAL.
    MODIFY ztsa0701 FROM TABLE lt_save.
    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE s002. "data 성공 메시지.
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

  CALL METHOD gcl_grid->get_selected_rows "사용자가 선택한 행의 정보를 가져옴
    IMPORTING
      et_index_rows = gt_rows.

  IF gt_rows IS INITIAL. "행을 선택했는지 체크
    MESSAGE s000 WITH TEXT-e02 DISPLAY LIKE 'E'.
  ENDIF.

  SORT gt_rows BY index DESCENDING.  "delete할때 순서 바뀌지 않게

  LOOP AT gt_rows INTO gs_row.
    DELETE gt_emp INDEX gs_row-index. "사용자가 선택한 행을 직접 삭제
  ENDLOOP.

  PERFORM refresh_grid.  "변경된 ITAB을 ALV에 반영

ENDFORM.
