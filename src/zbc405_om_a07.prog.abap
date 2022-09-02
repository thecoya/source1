*&---------------------------------------------------------------------*
*& Report ZBC405_OM_A07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_om_a07.

"connection 정보

TABLES : spfli.


SELECT-OPTIONS : so_car FOR spfli-carrid MEMORY ID car,
                 so_con FOR spfli-connid MEMORY ID con.

DATA : gt_spfli TYPE TABLE OF spfli,
       gs_spfli TYPE spfli.

DATA : go_alv TYPE REF TO cl_salv_table.   "메인이다
DATA : go_func TYPE REF TO cl_salv_functions_list.
DATA : go_disp TYPE REF TO cl_salv_display_settings.
DATA : go_columns TYPE REF TO cl_salv_columns_table.  "클래스 정보
DATA : go_column TYPE REF TO cl_salv_column_table.
DATA : go_cols TYPE REF TO cl_salv_column.    " 원래 타입은 SAP_BOOL데 원하는 타입이 아님
DATA : go_layout TYPE REF TO cl_salv_layout.
DATA : go_selc TYPE REF TO cl_salv_selections.

"따라서 casting을 씀 타입이 달라도 인정해주는 것

START-OF-SELECTION. "뿌려질 데이터 만들기 & 가져오기
  SELECT *     "internal table 채운것!
  INTO TABLE gt_spfli FROM spfli
  WHERE carrid IN so_car
  AND connid IN so_con.


  "&&&&&&&&&&&&  SALV 생성  &&&&&&&&&&&&&&&&&
  TRY.
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = ''      "IF_SALV_C_BOOL_SAP=>FALSE   X로 쓰면 플랫 /스페이스는 그리드모양
*         r_container  =
*         container_name =
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_spfli. "출력할 internal table
    CATCH cx_salv_msg.
  ENDTRY.





  "현재의 상태를 알고(기본상태) -> 거기에 OBJECT 추가하는 로직
  " 현재의 salv 테이블이 쭉 뿌려진 아무것도 안된 상태 / 상태를 알려주는 메소드들(get으로 시작되는)현재의 salv의 상태를 알려주는 object를 리턴한다. 다 클래스 타입이다.
  "go_alv에서 get functions을 통해 나온 결과가 go_func


  CALL METHOD go_alv->get_functions  "현재의공간->해당 공간에서 현재의 상태를 "현재의 상태를 보여주는것이 get_functions/ get funtions의 결과값이 go_func고 타입은 클래스타입으로 결과를 알려준다.  'CL_SALV_FUNCTIONS_LIST.'
    RECEIVING
      value = go_func.      " 아무것도 없는 상태에 하나식 얹어준다. 현재는 비어있다.    " get은 go_alv / 그set은 get으로 결과로 나온 것들의 object

  CALL METHOD go_func->set_sort_asc. "go_func를 참조 go_func에서 set~~~~에 들어가서 기능을 추가하는 로직

  CALL METHOD go_func->set_sort_desc. "go_func를 참조 go_func에서 set~~~~에 들어가서 기능을 추가하는 로직

  CALL METHOD go_func->set_all.


*-- display setting.
  CALL METHOD go_alv->get_display_settings
    RECEIVING
      value = go_disp.


*-- salv title.
  CALL METHOD go_disp->set_list_header
    EXPORTING
      value = 'SALV DEMO'.


*-- zebra pattern.
  CALL METHOD go_disp->set_striped_pattern
    EXPORTING
      value = 'X'.


*--
  CALL METHOD go_alv->get_columns
    RECEIVING
      value = go_columns.


*-- col opt 기능
  CALL METHOD go_columns->set_optimize. "필드의 간격을 가장 큰 범위에 맞춰 보여줘라
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP~TRUE.


*-- mandt 찾아서
  TRY.
      CALL METHOD go_columns->get_column  "go_columns에서 mandt를 찾기위해 get column으로 온 것.!!!!!!!!!! "go_columns의 결과인 클래스로 들어가보자
        EXPORTING
          columnname = 'MANDT'     "go_columns에서 get_colum으로 mandt를 찾음
        RECEIVING
          value      = go_cols. "MANDT 들어있는지 안들어있는지 go_cols에서 받아서 확인
    CATCH cx_salv_not_found.   "메소드 실행 시 발생하는 오류(dump)를 방지
  ENDTRY.

*-- 안보이게 하기
  go_column ?= go_cols.     "casting type이 달라도 구분 오류 없이 인정.
  CALL METHOD go_column->set_technical. "go_cols의 타입이 다르기 때문에 go_column이 set_technical로 통해 go_column의 타입과 go_cols의 타입을 일치시켜줌
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE.


*-- fcat-tech 기능





  TRY .      "TRY를 쓰고 안쓰고의 차이 ?
      CALL METHOD go_columns->get_column  "1.먼저 위치를 찾고
        EXPORTING
          columnname = 'FLTIME'
        RECEIVING
          value      = go_cols.
    CATCH cx_salv_not_found.
  ENDTRY.

  go_column ?= go_cols.


  DATA: g_color TYPE lvc_s_colo.   "2.1) 색깔을 더하기 위해 색깔 데이터 및 타입 선언하고 "밑에 색깔 부여
  g_color-col = '5'.
  g_color-int = '1'.
  g_color-inv = '0'.

  CALL METHOD go_column->set_color "2. 컬럼에 색깔을 더하는데 set_column
    EXPORTING
      value = g_color.

  CALL METHOD go_alv->get_layout
    RECEIVING
      value = go_layout.

  DATA : g_program TYPE salv_s_layout_key.  "KEY를 설정하는 이유, go_layout에 키를 설정해야~~

  CALL METHOD go_layout->set_key    "테이블의 key라고 생각하면된다. 어느 테이블의 키를 잡았는지 알아야함.
    EXPORTING
      value = g_program.


*-- i_save = 'A'. "default도 설정해주면 버튼이 생긴다.    ????
  "VARIANT 처럼 저장하고 사용할 수 있게,
  CALL METHOD go_layout->set_save_restriction
    EXPORTING
      value = if_salv_c_layout=>restrict_none.  "상수형태라 바꾸면 형태가 바뀐다. "value가 자동으로 들어가 있는 것
                                                "보통 없는 것은 ! data,타입 선언과 함께 변수를 지정해줘야한다.


  CALL METHOD go_layout->set_default
    EXPORTING
      value = 'X'.


*-- selection mode        "ALV의 SELECTION 모드와 비슷함
  CALL METHOD go_alv->get_selections
    RECEIVING
      value = go_selc.

  CALL METHOD go_selc->set_selection_mode
    EXPORTING
      value = if_salv_c_selection_mode=>row_column.   "row설정

  CALL METHOD go_selc->set_selection_mode
    EXPORTING
      value = if_salv_c_selection_mode=>cell.         "cell설정








  CALL METHOD go_alv->display. "우리가 만든 instance를 출력하라.


  "클래스는 상속받은 메소드를 사용할 수 있다.

  "salv는 get으로 다 찾는다. 필트카탈로그와 같이 찾는다.


  "출발은 ALV -> 1. GET "VALUE 저장할 DATA 선언 및 위에 이미 테이터와 참조할 타입 선언
  "2. SET "
  "bc405_om_event에서 예시 참조 가능!
