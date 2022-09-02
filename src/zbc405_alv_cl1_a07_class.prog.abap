*&---------------------------------------------------------------------*
*& Include          ZBC405_ALV_CL1_A07_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_doubleclick FOR EVENT            "class-methods : static화 해서 하는 것. 자기 스스로 쓸 수 있는 거..
        double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,


      on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object,  "e_obect에 하나하나씩 추가하는 것 ex. 버튼



      on_usercommand FOR EVENT user_command OF cl_gui_alv_grid "버튼의 function code를 알려준다.
        IMPORTING e_ucomm,


      on_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed,

      on_data_changed_finish FOR EVENT data_changed_finished OF cl_gui_alv_grid
        IMPORTING e_modified et_good_cells.
ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.
  METHOD on_data_changed_finish.
    DATA : ls_mod_cells TYPE lvc_s_modi. " 중간다리 역할??
    CHECK e_modified = 'X'. "modify가 참일 때, 밑의 로직을 수행해라. 거짓이면 빠져나가라.
    "내가 변경한게 gt_sbook에 기억하게 해놓는다. -> 필드를 하나 추가 & 값을 부여하여(변경됨을 알 수 있게),

    PERFORM modify_check USING ls_mod_cells.


    LOOP AT et_good_cells INTO ls_mod_cells.
      PERFORM modify_check USING ls_mod_cells.

    ENDLOOP.

  ENDMETHOD.


  METHOD on_data_changed.
    FIELD-SYMBOLS : <fs> LIKE gt_sbook.

    DATA : ls_mod_cells TYPE lvc_s_modi,
           ls_ins_cells TYPE lvc_s_moce,
           ls_del_cells TYPE lvc_s_moce.



    LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.  "er~cells 테이블을 참조해서 돌고 있음
      CASE ls_mod_cells-fieldname.
        WHEN 'CUSTOMID'.                                                     "customerid일때 로직을 타는데, customer change 로직
          PERFORM customer_change_part USING er_data_changed
                                              ls_mod_cells.

        WHEN 'CANCELLED'.
      ENDCASE.
    ENDLOOP.

*-- inserted parts  " 빈공간 구조 만들로 loop로 채우는 방법.

    IF er_data_changed->mt_inserted_rows IS NOT INITIAL.   "값은 없지만 공간이 있는    ???뭐가 있으면 assign 안써도 된다.
      ASSIGN er_data_changed->mp_mod_rows->* TO <fs>. "<fs>는 gt_sbook이 된다.  "데이터가 쌓이도록 하면 append가 가능하다
      IF sy-subrc EQ 0.
        APPEND LINES OF <fs> TO gt_sbook.
        LOOP AT  er_data_changed->mt_inserted_rows INTO ls_ins_cells.  "추가한 4줄에 대해서 "LOOP는 추가된 부분~ 데이터는 비어있다 !!!!
          READ TABLE gt_sbook INTO gs_sbook INDEX ls_ins_cells-row_id.  "한줄씩 돌면서,
          IF sy-subrc EQ 0.
            PERFORM insert_parts USING er_data_changed     "스타일을 바꾸는 부분
                                        ls_ins_cells.

          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.


*-- delete parts
    IF  er_data_changed->mt_deleted_rows IS NOT INITIAL.

      LOOP AT er_data_changed->mt_deleted_rows INTO ls_del_cells.

        READ TABLE gt_sbook INTO gs_sbook INDEX ls_del_cells-row_id.
        IF sy-subrc EQ 0.
          MOVE-CORRESPONDING gs_sbook to dw_sbook.
          APPEND dw_sbook TO dl_sbook.            "우리가 삭제했을 때 기억해놓을 수 있게 쌓아놓는 것,
        ENDIF.
      ENDLOOP.
    ENDIF.



  ENDMETHOD.


  METHOD on_usercommand.
    DATA : ls_col  TYPE lvc_s_col,
           ls_roid TYPE lvc_s_roid.


    CALL METHOD go_alv->get_current_cell
      IMPORTING
        es_col_id = ls_col
        es_row_no = ls_roid. "클릭하고 있는 현재 id.

    CASE e_ucomm.
      WHEN 'GOTOFL'.
        READ TABLE gt_sbook INTO gs_sbook INDEX ls_roid-row_id.

        IF  sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_sbook-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sbook-connid.

          CALL TRANSACTION 'SAPBC405CAL'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.



  METHOD on_toolbar.
    DATA : wa_button TYPE stb_button.

    wa_button-butn_type = '3'.  "0은 노말, 3은 separator
    INSERT wa_button INTO TABLE e_object->mt_toolbar. "e_obeject에 들어있는 ATTRIBUTE속성(mt_toolbar)을 넣어주면 버튼이 생김. "TABLE 타입??

    CLEAR : wa_button.
    wa_button-butn_type = '0'.  "normal button
    wa_button-function = 'GOTOFL'.  "flight connection. "CALL TRANSACTION, PARAMETER,,,,
    wa_button-icon = icon_flight.
    wa_button-quickinfo = 'Go to flight connection !'.
    wa_button-text = 'Flight'.
    INSERT wa_button INTO TABLE e_object->mt_toolbar.





  ENDMETHOD.



  METHOD on_doubleclick.

    DATA : carrname TYPE scarr-carrname.

    CASE  e_column-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook INDEX e_row-index.
        IF sy-subrc EQ 0.

          SELECT SINGLE carrname INTO carrname
            FROM scarr WHERE carrid = gs_sbook-carrid.

          IF sy-subrc EQ 0.
            MESSAGE i000(zt03_msg) WITH carrname.
          ENDIF.

        ENDIF.
    ENDCASE.


  ENDMETHOD.
ENDCLASS.


"이중화살은 static : 본인 스스로가 만드는 친구
"하나화살은 create object로 만들어진 instance !!
