*&---------------------------------------------------------------------*
*& Report ZBC405_A07_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_alv.


*-- 타입 & DATA 선언
""1 관련 TABLE 정보를 TYPES 및 DATA로 선언
TYPES: BEGIN OF typ_flt.          "str 타입을 만드는 것, 각각의 선언된 필드별 타입은 참조하는 타입이 있다.
         INCLUDE TYPE sflight.    "좀 특별하게 쓰는 include : 스트럭쳐 타입을 참조한다.
TYPES:   changes_possible TYPE icon-id.

TYPES:   tankcap  TYPE saplane-tankcap.
TYPES:   cap_unit TYPE saplane-cap_unit.
TYPES:   weight TYPE saplane-weight.
TYPES:   wei_unit  TYPE saplane-wei_unit.

TYPES:   light TYPE c LENGTH 1.    "LIGHT 필드 추가함 신호등을 보여줄. layout 꾸미기
TYPES: btn_text TYPE c LENGTH 10.   "셀버튼 만드는 거
TYPES: row_color TYPE c LENGTH 4.  "색깔  "row_color 이름을 바꿔도 상관 x
TYPES: it_col TYPE lvc_t_scol.  "선언하면 workares 필요 "셀단위로 색깔을 지정하는 정해진 테이블 타입! 셀마다 어떤 색깔을 담을지를 it_col에다가 담는다.
TYPES: it_styl TYPE lvc_t_styl.     "셀버튼 만들 때, 스타일

TYPES: END OF typ_flt.

DATA : gt_flt TYPE TABLE OF typ_flt.      "sflight. typ_flt 타입을 만들어줬으니 gt/gs_flt의 타입을 다 바꿔준다
DATA : gs_flt TYPE typ_flt.
DATA : ok_code LIKE sy-ucomm.


*--alv data 선언 "위에 선언된 타입아이들을 쓰기 위해 임시로 쓰는 필드 / 밑에 불러온 메소드에 들어가는 아이들
""5-1). Container / Grid 를 통해서 ALV 화면 설정
DATA: go_container TYPE REF TO cl_gui_custom_container,   "container 타입
      go_alv_grid  TYPE REF TO cl_gui_alv_grid, "grid 타입  "선언을 했으므로 call해서 쓴다.
      ""6-1)
      gv_variant   TYPE disvariant,
      gv_save      TYPE c LENGTH 1,
      gs_layout    TYPE lvc_s_layo,
      gt_sort      TYPE lvc_t_sort, "internal table.
      gs_sort      TYPE lvc_s_sort, "work area
      gs_color     TYPE lvc_s_scol,
      gt_exct      TYPE ui_functions,  "toolbar 없애는 것. "toolbar excluding.
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_styl      TYPE lvc_s_styl.  "셀 버튼 추가되는 거



********************************
INCLUDE zbc405_a07_alv_class.



*-- selection screen
""2. Selection screen을 구성-selection screen에 들어갈 id, selection screen의 껍데기 완성
SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                 so_con FOR gs_flt-connid MEMORY ID con,
                 so_dat FOR gs_flt-fldate.

SELECTION-SCREEN SKIP 1.


PARAMETERS :  p_date TYPE sy-datum DEFAULT '20201001'.  "기본값 날짜 이후만 변경 가능/아니면 변경 불가 로직 위해
""6-1)
PARAMETERS : pa_lv TYPE disvariant-variant.


*--INITIALIZATION "어떤 위치에 써도 상관 없다. 이중 assign을 안해도 된다./ 이곳에 선언하면 굳이 뒤쪽에 한번 더 해줄 필요가 없다..
""6-2)
INITIALIZATION.
  gv_variant-report = sy-cprog. "현재 프로그램의 이름이 variant이다라고 선언.


""6-4)
AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv. "f4준비 / 펑션모듈 / 뜬것 중에 선택하면 리턴 /선언하면 possible entry 타고 pa_lv에 value request 씁니다.

  gv_variant-report = sy-cprog. "어떤 variant report인지 선택    "현재의 프로그램이 variantd이다 라고 선언.

  "gv_variant-report = sy-cprog. 두번 사용(한번은 이벤트용)-> INITIALIZATION에 선언하면 한번만 사용

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load     = 'F'
    CHANGING
      cs_variant      = gv_variant  "필드에 선택한게 pa_lv로 들어온다
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0. "메시지 뿌리는게 낫고
* Implement suitable error handling here
  ELSEIF
    pa_lv = gv_variant-variant.  "f4했을경우에만 탄다. "리턴 / 없다면 나의 parameter 리턴 x  "있다면 pa_lv에 값을 리턴해줘라
  ENDIF.



START-OF-SELECTION.  "call screen 위에 위치 해야함
  PERFORM get_data.  "data 핸들링은 여기서만 "너무 복잡하기에 서브루틴씀
  PERFORM make_variant.
  PERFORM make_layout.
  PERFORM make_sort.
  PERFORM make_fieldcatalog.

  ""3. 불러온 Table 정보를 담고 표현할 ALV 화면을 구성한다
  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T10' WITH sy-datum sy-uname. "dynamic하게 사용할때마다 뜬다. " Titlebar에 &1 &2 &3으로 하면 실행했을 때 그 자리로 들어간다.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.

      CALL METHOD go_alv_grid->free.
      CALL METHOD go_container->free.
      FREE : go_alv_grid, go_container.
      "내가만든 object가 릴리즈되고, 메모리 확보, abap 메모리에 남겨짐
      LEAVE TO SCREEN 0. "SET SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT. "5-2)
  ""5-3)
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'  "layout의 custom box이름
      EXCEPTIONS
        OTHERS         = 6.

    ""오류메시지 띄우기 / 오류 없으면 계속 진행
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container
      EXCEPTIONS
        OTHERS   = 5.

    ""오류메시지 띄우기 / 오류 없으면 계속 진행
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


    APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct. "클래스=>attribute to ~~
*    APPEND cl_gui_alv_grid=>mc_fc_info   TO gt_exct.
*    APPEND cl_gui_alv_grid=>mc_fc_excl_all TO gt_exct.


    SET HANDLER lcl_handler=>on_doubleclick FOR go_alv_grid.  "event trigger
    SET HANDLER lcl_handler=>on_hotspot FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_button_click FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_context_menu_request FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_before_user_command FOR go_alv_grid.


    ""5-4)
    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*       i_buffer_active      =
*       i_bypassing_buffer   =
*       i_consistency_check  =
        i_structure_name     = 'SFLIGHT' "내가 참조하고 있는 테이블 ->필드/레코드 데이터가 쭈욱 나오는 것
        is_variant           = gv_variant ""6-3)
        i_save               = gv_save  ""6-3)   "저장만가능  "변수 안줘도 되고 하드코딩해도 된다. "X, A, U
        i_default            = 'X'    "비어있으면 사라짐
        is_layout            = gs_layout   ""6-3)
*       is_print             =
*       it_special_groups    =
        it_toolbar_excluding = gt_exct
*       it_hyperlink         =
*       it_alv_graphics      =
*       it_except_qinfo      =
*       ir_salv_adapter      =
      CHANGING
        it_outtab            = gt_flt "뿌려주는 테이블
        it_fieldcatalog      = gt_fcat "14-2 category 설정
        it_sort              = gt_sort "11-2
*       it_filter            =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error        = 2
*       too_many_lines       = 3
*       others               = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.

ENDMODULE.



"1. (layout) 영역 지정한 이후 컨테이너를 만들었다. (패턴 및 드래그를 이용한 call method)
"2. 컨테이너 위에 grid 만들었고 (패턴 및 드래그를 이용한 call method) "instance만들기
"3. grid 위에 데이터 불러온다.(패턴 및 드래그를 이용한 call method)
"alv가 속한 method를 콜하면 만들어진 internal table이 뿌려질껀데, 그 구조가 sflight고, 출력하면 디폴트 alv테이블을 불러온다.


*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data . ""4. Table에 담을 DATA 가져오기
  SELECT *     "gt_flt = internal table -> into corresponding table of / 필드가 계속 추가되고 있어 sflight 테이블이랑 구조 다르므로
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_flt
  WHERE carrid IN so_car
  AND connid IN so_con
  AND fldate IN so_dat.


  "internal table 넣었으니, roop타자.
  ""신호등 데이터 필요
  LOOP AT gt_flt INTO gs_flt.
    IF  gs_flt-seatsocc < 5.
      gs_flt-light = 1. "red

    ELSEIF gs_flt-seatsocc < 100.
      gs_flt-light = 2. "yellow

    ELSE.
      gs_flt-light = 3. "green.
    ENDIF.

    IF gs_flt-fldate+4(2) = sy-datum+4(2).  "날짜가 현재와 같은 월이면 색깔을 주자.
      gs_flt-row_color = 'C611'.            "C는 컬러의미 3은 색깔, 1 SET(intensified), 0은 OFF(inverse)
    ENDIF.



    IF gs_flt-planetype = '747-400'.
      gs_color-fname = 'PLANETYPE'.
      gs_color-color-col = col_total. "total 노란색
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_flt-it_col.  "테이블 타야되니까 append해준것.
    ENDIF.

    IF gs_flt-seatsocc_b = 0.
      gs_color-fname = 'SEATSOCC_B'.
      gs_color-color-col = col_negative.  "negative 빨간색
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_flt-it_col.
    ENDIF.


    IF gs_flt-fldate < p_date.

      gs_flt-changes_possible = icon_space.
    ELSE.
      gs_flt-changes_possible = icon_okay.
    ENDIF.

    IF gs_flt-seatsmax_b = gs_flt-seatsocc_b.
      gs_flt-btn_text = 'FullSeats!'.
      gs_styl-fieldname = 'BTN_TEXT'.
      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
      APPEND gs_styl TO gs_flt-it_styl.
    ENDIF.

    SELECT SINGLE tankcap cap_unit weight wei_unit
      FROM saplane
      INTO ( gs_flt-tankcap, gs_flt-cap_unit, gs_flt-weight, gs_flt-wei_unit )
    WHERE planetype = gs_flt-planetype.

    MODIFY gt_flt FROM gs_flt.

  ENDLOOP.
ENDFORM.
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
  gv_variant-variant = pa_lv. "select screen안에 parmeter로 pa_lv 받아서
  gv_save = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout . "layout 설정 서브루틴으로.
  gs_layout-zebra = 'X'. "X는 set  "얼룩무늬 모양 셀
*  gs_layout-cwidth_opt = 'X'.  "데이터 값에 맞게 넓이 조정  "fieldcatalog에서  call opt 역할
  gs_layout-sel_mode = 'D'. "A, B, C, D, SPACE

  gs_layout-excp_fname = 'LIGHT'. "위에 타입 선언한 light
  gs_layout-excp_led = 'X'.
  gs_layout-info_fname = 'ROW_COLOR'.   "컴포넌트(gs_layout~~)에 필드(row_color)를 ASSIGN해준다. "row_color라는 변수이름 바꿔도 된다. 단 위에 type 선언할떄와 동일하게 변경 "정해진 info_fname에 내가 정한 필드 값을 넣는다.
  gs_layout-ctab_fname = 'IT_COL'.

  gs_layout-stylefname = 'IT_STYL'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
*  gs_fcat-hotspot = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'INfo'.   "column text
  APPEND gs_fcat TO gt_fcat.    "append를 지속적으로 해야함.


  "work area 중복은 clear습관
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'PRICE'.
  gs_fcat-emphasize = 'C610'.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CHANGES_POSSIBLE'.
  gs_fcat-coltext = 'Chang.Poss'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 5.
*  *gs_fcat-icon = 'X'.
  gs_fcat-tooltip = 'Are Changes Possible?'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'BTN_TEXT'.
  gs_fcat-coltext = 'Status'.
  gs_fcat-col_pos = 10.
  APPEND gs_fcat TO gt_fcat.

  """""""""""""""""""""""""
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'TANKCAP'.
  gs_fcat-ref_table = 'SAPLANE'.
  gs_fcat-ref_field = 'TANKCAP'.
  gs_fcat-col_pos = 20.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CAP_UNIT'.
  gs_fcat-ref_table = 'SAPLANE'.
  gs_fcat-ref_field = 'CAP_UNIT'.
  gs_fcat-col_pos = 21.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'WEIGHT'.
  gs_fcat-ref_table = 'SAPLANE'.
  gs_fcat-ref_field = 'WEIGHT'.
  gs_fcat-col_pos = 22.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'WEI_UNIT'.
  gs_fcat-ref_table = 'SAPLANE'.
  gs_fcat-ref_field = 'WEI_UNIT'.
  gs_fcat-col_pos = 23.
  APPEND gs_fcat TO gt_fcat.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort . "1,2,3 순서에 맞춰서 오름차순/내림차순 정리하는 것.

  CLEAR gs_sort. "work area, append 를 반복 사용할 때, clear하는 습관

  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.

  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.

  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.

ENDFORM.
