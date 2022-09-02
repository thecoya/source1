*&---------------------------------------------------------------------*
*& Include          ZBC405_A07_ALV_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_doubleclick FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,   "결과를 알려준다(IMPORTING) "paramenter 값을 입력하는 이유.?

      on_hotspot FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id e_column_id es_row_no,

      on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object,

      on_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm,

      on_button_click FOR EVENT button_click OF cl_gui_alv_grid
        IMPORTING es_col_id es_row_no, "알려주는 걸 버튼의 위치에 값을 읽어서 보여준다.

      on_context_menu_request FOR EVENT context_menu_request OF cl_gui_alv_grid
        IMPORTING e_object,

      on_before_user_command FOR EVENT before_user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.     "u-comm 타기전에 먼저 탄다 -> 기존 돋보기 버튼이 아닌 sche로 넣기위해 밑에 메소드가 나온다.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.   "스크린에서 어떤 역할?
  METHOD on_before_user_command.
    CASE e_ucomm.
      WHEN cl_gui_alv_grid=>mc_fc_detail.  "현재의 버튼 및  상태
        CALL METHOD go_alv_grid->set_user_command  "사용자(우리)의 역할로 지정하는 함수
          EXPORTING
            i_ucomm = 'SCHE'.
    ENDCASE.
  ENDMETHOD.





  METHOD on_context_menu_request. "메뉴 만드는 것.
    "1. 스크린에 만들어진 메뉴를 불러오거나 (status call) or 2. class에 있는 method를 붙이거나 or 3. 둘다 쓰거나

    DATA : lv_row_id TYPE lvc_s_row,
           lv_col_id TYPE lvc_s_col.

    CALL METHOD go_alv_grid->get_current_cell  "해당 필드에만 CT_MENU 적용시켜라 ex) carrid필드에만 separator / 스크린에 메뉴추가(ct_menu 메소드 활용)
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
        es_row_id = lv_row_id
        es_col_id = lv_col_id.

    IF lv_col_id-fieldname = 'CARRID'.


      CALL METHOD e_object->add_separator.


      CALL METHOD cl_ctmenu=>load_gui_status   "불러오는거
        EXPORTING
          program    = sy-cprog
          status     = 'CT_MENU'
*         disable    =
          menu       = e_object
        EXCEPTIONS
          read_error = 1
          OTHERS     = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      CALL METHOD e_object->add_separator.

      CALL METHOD e_object->add_function "메뉴 한줄 추가하는거
        EXPORTING
          fcode = 'Dis_CARR'
          text  = 'Display Airline'.
*       icon  =
*       ftype =
*       disabled          =
*       hidden            =
*       checked           =
*       accelerator       =
*       insert_at_the_top = SPACE.
    ENDIF.
  ENDMETHOD.




  METHOD on_button_click. "버튼클릭이 하는 기능은..

    READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
    IF ( gs_flt-seatsmax NE gs_flt-seatsocc ) OR    "이코노미 또는 퍼스트에 남는자리가 있으면
       ( gs_flt-seatsmax_f NE gs_flt-seatsocc_f ).

      MESSAGE i000(zt03_msg) WITH 'Reserve any other seats'.
    ELSE.
      MESSAGE i000(zt03_msg) WITH 'All seats are fully reserved'.
    ENDIF.

  ENDMETHOD.


  METHOD on_user_command.     " percentage 버튼의 기능 1.

    DATA : lv_occp     TYPE i,
           lv_capa     TYPE i,
           lv_perct    TYPE p LENGTH 8 DECIMALS 1,
           lv_text(20).

    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows TYPE lvc_s_roid.

    DATA : lv_row_id TYPE lvc_s_row,
           lv_col_id TYPE lvc_s_col.

    CALL METHOD go_alv_grid->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
        es_row_id = lv_row_id
        es_col_id = lv_col_id.

    CASE e_ucomm.
      WHEN 'SCHE'.   "goto flight schedule report.
        READ TABLE gt_flt INTO gs_flt INDEX lv_row_id-index.
        IF sy-subrc EQ 0.                    "그냥 submit하면 "select screen 조건 없이 그냥 바로 프로그램 실행되고, 전체 데이터가 나온다. 그리고 본래 프로그갬으로 돌아오지 않는다.
          SUBMIT bc405_event_d4 AND RETURN    "다른 프로그램을 부를때 쓰는 submit "submit bc405에서 우리가 만든 SCHE에 데이터를 조회/읽어오고 / 다시 우리 프로그램으로 돌아와라
          WITH so_car EQ gs_flt-carrid  "조건주는 데로 선택된 데이터만 가져오는데 "select option의 파라미터를 제약 조건으로 써준다.
          WITH so_con EQ gs_flt-connid. "조건 없으면 전체 가져옴
        ENDIF.



      WHEN 'AIRLINE_BUTTON'.
        IF lv_col_id-fieldname = 'CARRID'.

          READ TABLE gt_flt INTO gs_flt INDEX lv_row_id-index.
          IF sy-subrc EQ 0.
            CLEAR : lv_text.
            SELECT SINGLE carrname INTO lv_text FROM scarr
              WHERE carrid = gs_flt-carrid.
            IF sy-subrc EQ 0.
              MESSAGE i000(zt03_msg) WITH lv_text.
            ELSE.
              MESSAGE i000(zt03_msg) WITH 'No found'.
            ENDIF.
          ENDIF.
        ELSE.
          MESSAGE i000(zt03_msg) WITH 'Select the right field'.
        ENDIF.


      WHEN'PERCENTAGE'.
        LOOP AT gt_flt INTO gs_flt.
          lv_occp = lv_occp + gs_flt-seatsocc.
          lv_capa = lv_capa + gs_flt-seatsmax.
        ENDLOOP.
        lv_perct = lv_occp / lv_capa * 100.
        lv_text = lv_perct.
        CONDENSE lv_text.
        MESSAGE i000(zt03_msg) WITH 'Percentage of occupied seats :' lv_text.


      WHEN 'PERCENTAGE-MARKED'.  "툴바 이벤트를 써서 버튼 2개추가해서,
        "유저커맨드 등록하고 implementation 로직 추가 / 이벤트 4개

        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*           et_index_rows =
            et_row_no = lt_rows.

        IF lines( lt_rows ) > 0.
          LOOP AT lt_rows INTO ls_rows.
            READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id.
            IF sy-subrc EQ 0.
              lv_occp = lv_occp + gs_flt-seatsocc.
              lv_capa = lv_capa + gs_flt-seatsmax.
            ENDIF.
          ENDLOOP.

          lv_perct = lv_occp / lv_capa * 100.
          lv_text = lv_perct.
          CONDENSE lv_text.
          MESSAGE i000(zt03_msg) WITH 'Percentage of Marked occupied seats (%) :' lv_text.
        ELSE.
          MESSAGE i000(zt03_msg) WITH 'Please select at least one line!'.

        ENDIF.
    ENDCASE.
  ENDMETHOD.




  METHOD on_toolbar. "버튼 생성 method

    DATA :  ls_button TYPE stb_button.

    ls_button-function = 'PERCENTAGE'.   "버튼 1
*    ls_button-icon = ?
    ls_button-quickinfo = 'Occupied Percentage'.
    ls_button-butn_type = '0'.   "normal typr
    ls_button-text = 'Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-butn_type = '3'. "separator
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-function = 'PERCENTAGE_MARKED'.  "버튼2
*    ls_button-icon = ?
    ls_button-quickinfo = 'Occupied Marked Percentage'.
    ls_button-butn_type = '0'.   "normal typr
    ls_button-text = 'Marked Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.


    CLEAR : ls_button.
    ls_button-function = 'AIRLINE_BUTTON'.  "비행기버튼  "추가적인 메소드 콜이 필요함
    ls_button-icon = icon_ws_plane.
    ls_button-quickinfo = 'CARRID'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Airline'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.


    "버튼 생성 후 user command event를 탄다! -> 만들어줘야 한다.

  ENDMETHOD.



  METHOD on_hotspot.    "필드 카탈로그에 추가 했음

    DATA: carr_name TYPE scarr-carrname.
    CASE e_column_id-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          SELECT SINGLE carrname INTO carr_name FROM scarr
            WHERE carrid = gs_flt-carrid.
          IF sy-subrc EQ 0.
            MESSAGE i000(zt_03msg) WITH carr_name.
          ELSE.
            MESSAGE i000(zt_03msg) WITH 'No found!'.
          ENDIF.
        ELSE.
          MESSAGE i075(bc405_408).
          EXIT.
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_doubleclick.  "on_doubleclick의 기능을 어떻게 쓸건데? -> total booking된 좌석수 보이기.


    DATA : total_occ TYPE i.
    DATA : total_occ_c TYPE c LENGTH 10. "10자리의 위치공간 위치를 나타내고, 위치 그대로있다가 condense를 쓰면 왼쪽 정렬

    CASE e_column-fieldname.  "특정 필드 한정해서 click가능하게
      WHEN 'CHANGES_POSSIBLE'.
        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          total_occ = gs_flt-seatsocc + gs_flt-seatsocc_b + gs_flt-seatsocc_f.
          total_occ_c = total_occ.
          CONDENSE total_occ_c.  "문자자동 정렬처럼 왼쪽으로 숫자를 정렬
          MESSAGE i000(zt03_msg) WITH 'Total number of bookings:'
          total_occ_c.
        ELSE.
          MESSAGE i075(bc405_408).
          EXIT.
        ENDIF.

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
