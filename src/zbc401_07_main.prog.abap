*&---------------------------------------------------------------------*
*& Report ZBC401_07_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_07_main.

"" 53page-TAW12-1 ""클래스 만들기


TYPE-POOLS : icon.   "se11 type group에 만들어 놓으면 쓸 수 있다.  "글로벌로 쓰고 싶을 때 만들어 써라 zt03

CLASS lcl_airplane DEFINITION.
  "어떤건 public 어떤건 private


*  PRIVATE SECTION.
*    DATA: mv_name      TYPE string,
*          mv_planetype TYPE saplane-planetype.
*    CLASS-DATA : gv_n_o_airplanes TYPE i.  "statice attribute 선언
*
*
*    CONSTANTS c_pos_i TYPE i VALUE 30.
*
*
*  PUBLIC SECTION.
*    METHODS set_attributes
*      IMPORTING iv_name      TYPE string
*                iv_planetype TYPE saplane-planetype.
*
*    display_attribute.
*    CLASS-METHODS : display_n_o_airplanes.   "static method.  메소드랑, ATTRIBUTE 다 선언 가능


  PUBLIC SECTION.
    METHODS :
      constructor
        IMPORTING  iv_name      TYPE string
                   iv_planetype TYPE saplane-planetype
        EXCEPTIONS
                   wrong_planetype.


    METHODS : set_attributes
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype,

      display_attributes.  "얘는 객체로 선언해서 불러야함
    CLASS-METHODS : display_n_o_airplanes.
    CLASS-METHODS : get_n_o_airplanes RETURNING VALUE(rv_count) TYPE i. "return 된다.
    "rv_count에 전체 비행기 대수를

    CLASS-METHODS : class_constructor.    "class_constructor / static

  PRIVATE SECTION.
    DATA : mv_name      TYPE string,
           mv_planetype TYPE saplane-planetype,
           mv_weight    TYPE saplane-weight,
           mv_tankcap   TYPE saplane-tankcap.

    TYPES : ty_planetype TYPE TABLE OF saplane.    "cl-con 타입 선언

    CLASS-DATA : gv_n_o_airplanes  TYPE i.
    CLASS-DATA : gv_planetypes TYPE ty_planetype.  "cl-con 선언
    CONSTANTS : c_pos_1 TYPE i VALUE 30.  "

    CLASS-METHODS : get_technical_attributes   "메소드 추가
      IMPORTING  iv_type    TYPE saplane-planetype
      EXPORTING  ev_weight  TYPE saplane-weight
                 ev_tankcap TYPE saplane-tankcap
      EXCEPTIONS
                 wrong_planetype.   "문제가 있다면,,  "메소드를 부르고 하는 일을 넣어줌'';'


ENDCLASS.

CLASS lcl_airplane IMPLEMENTATION.
  METHOD get_technical_attributes.
    DATA : ls_planetype TYPE saplane.

    READ TABLE gv_planetypes INTO ls_planetype
    WITH KEY planetype = iv_type.

    IF sy-subrc EQ 0.
      ev_weight = ls_planetype-weight.
      ev_tankcap = ls_planetype-tankcap.
    ELSE.
      RAISE wrong_planetype.
    ENDIF.
  ENDMETHOD.


  METHOD class_constructor.    "cl-con
    SELECT * INTO TABLE gv_planetypes FROM saplane.
  ENDMETHOD.


  METHOD constructor.     "con

    DATA: ls_planetype TYPE saplane.
    mv_name = iv_name.
    mv_planetype = iv_planetype.

*    SELECT SINGLE * INTO ls_planetype FROM saplane
*      WHERE planetype = iv_planetype.
*
*    IF sy-subrc NE 0.
*      RAISE wrong_planetype.
*    ELSE.
*      mv_weight = ls_planetype-weight.
*      mv_tankcap = ls_planetype-tankcap.

    CALL METHOD get_technical_attributes  "다른 데서도 쓸 수 있게끔 메소드 구성
      EXPORTING
        iv_type         = iv_planetype
      IMPORTING
        ev_weight       = mv_weight
        ev_tankcap      = mv_tankcap
      EXCEPTIONS
        wrong_planetype = 1.

    IF sy-subrc EQ 0.
      gv_n_o_airplanes = gv_n_o_airplanes + 1.
    ELSE.
      RAISE wrong_planetype.
    ENDIF.
  ENDMETHOD.


  METHOD get_n_o_airplanes.
    rv_count = gv_n_o_airplanes.
  ENDMETHOD.      "현재 가진 비행기 대수를 보여준다.


  METHOD set_attributes.
    mv_name = iv_name.
    mv_planetype = iv_planetype.
    gv_n_o_airplanes = gv_n_o_airplanes + 1.
  ENDMETHOD.

  METHOD display_attributes. "set된걸 출력하는 method.

    WRITE: / icon_ws_plane AS ICON,
            / 'Name of airplane', AT  c_pos_1 mv_name,
             / 'Type of airplane', AT c_pos_1 mv_planetype,
             / 'Weight', AT c_pos_1 mv_planetype,
            / 'tankcap', AT c_pos_1 mv_planetype.

  ENDMETHOD.

  METHOD display_n_o_airplanes. "Static method.
    WRITE : / 'Number of Airplane', AT c_pos_1 gv_n_o_airplanes.

  ENDMETHOD.

ENDCLASS.


DATA : go_airplane TYPE REF TO lcl_airplane.
DATA : gt_airplane TYPE TABLE OF REF TO lcl_airplane.

START-OF-SELECTION.

  CALL METHOD lcl_airplane=>display_n_o_airplanes.
  "기종을 하나씩 새고 있음


  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'LH_BERLIN'
      iv_planetype    = 'A321'
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc EQ 0.                            "에러가 있는데 append하라고 해서 덤프 발생. sy-subrc 로직 쓰면, 에러 발생했으니까 append 안하는 정상 로직 탄다. 그래서 출력이 안된다.
    APPEND go_airplane TO gt_airplane.
  ENDIF.


*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'LH BERLIN'
*      iv_planetype = 'A321'.



  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'AA New York'
      iv_planetype    = '747-400'
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc EQ 0.
    APPEND go_airplane TO gt_airplane.
  ENDIF.

*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'AA New York'
*      iv_planetype = '747-400'.

  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'US Hercules'
      iv_planetype    = '747-200F'
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc EQ 0.
    APPEND go_airplane TO gt_airplane.
  ENDIF.

*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'US Hergcules'
*      iv_planetype = '747-200F'.


  LOOP AT gt_airplane INTO go_airplane.
    CALL METHOD go_airplane->display_attributes.


  ENDLOOP.


  DATA: gv_count TYPE i.

  gv_count = lcl_airplane=>get_n_o_airplanes( ).
  WRITE : / 'Number of Airplanes', gv_count.   "이런  로직 많이 본다 fnc메소드를 콜하고 그 결과를 새로운 변수에 넣을 수 있다..
