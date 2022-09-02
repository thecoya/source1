*&---------------------------------------------------------------------*
*& Report ZRSA07_16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_16.

" 1. 변수선언: TYPES 또는 DATA: BEGIN OF 사용
" 2.

*DATA: BEGIN OF gs_info,
*        carrid    TYPE spfli-carrid,
*        carrname  TYPE scarr-carrname,
*        connid    TYPE spfli-connid,
*        countryfr TYPE spfli-countryfr,
*        countryto TYPE spfli-countryto,
*        atype     TYPE c LENGTH 10,        -> 코드값을 가지고 있다 생각하면 좋음
*      END OF gs_info.
*
*DATA gt_info LIKE TABLE OF gs_info.


*gs_info-CARRID = 'AA'.
*gs_info-CONNID = '0017'.
*gs_info-COUNTRYFR = 'U5'.
*gs_info-COUNTRYTO = 'U5'.
*APPEND gs_info TO gt_info.
*CLEAR gs_info.
*
*gs_info-CARRID = 'AA'.
*gs_info-CONNID = '0064'.
*gs_info-COUNTRYFR = 'U5'.
*gs_info-COUNTRYTO = 'U5'.
*APPEND gs_info TO gt_info.
*CLEAR gs_info.
*
*gs_info-CARRID = 'AZ'.
*gs_info-CONNID = '0555'.
*gs_info-COUNTRYFR = 'IT'.
*gs_info-COUNTRYTO = 'DE'.
*APPEND gs_info TO gt_info.
*CLEAR gs_info.

*SELECT carrid connid countryfr countryto                        "한개의 라인, 레코드
*  FROM  spfli
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE currcode =
*  APPEND gs_info TO gt_info.



*LOOP AT gt_info INTO gs_info.
*
*  IF gs_info-countryfr = gs_info-countryto.
*    gs_info-atype = '국내선'.
*    MODIFY gt_info FROM gs_info.
*  ELSE.
*    gs_info-atype = '국제선'.
*    MODIFY gt_info FROM gs_info.
*  ENDIF.
*
*  SELECT SINGLE carrname
*    FROM  scarr
*    INTO gs_info-carrname
*    WHERE carrid = gs_info-carrid.
*
*  MODIFY gt_info FROM gs_info.
*
*ENDLOOP.
*
*CLEAR gs_info.


*cl_demo_output=>display_data( gt_info ).




*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

TYPES: BEGIN OF ts_info,                      " 그닥 좋지 않은 방법
        carrid TYPE c LENGTH 3,
        carrname TYPE scarr-carrname,
        connid  TYPE spfli-connid,            "numeric type 출력시 0000 4자리 채워짐
        countryfr TYPE spfli-countryfr,
        countryto TYPE spfli-countryto,
        atype TYPE c LENGTH 10,
      END OF ts_info.


"Connection Internal Table
DATA gt_info TYPE TABLE OF ts_info.

"Structure Variable
DATA gs_info LIKE LINE OF gt_info.
*DATA gs_info TYPE ts_info.

*DATA: gs_info TYPE tsP_info,
*      gt_info LIKE TABLE OF gs_info.
" 각각 따로 선언하는게 좋다. 목적이 다르다.
"abap dictionary에서 만들면 전체가 사용한다는 의미, 로컬(변수/타입)으로 만들면 해당 프로그램에서만 사용


CLEAR gs_info.

gs_info-carrid = 'AA'.         " 자주 쓸 것 같다 !  -> sub-rountine 쓰자 !
gs_info-connid = '0017'.
gs_info-countryfr = 'US'.
gs_info-countryto = 'US'.
APPEND gs_info TO gt_info.

CLEAR gs_info.  "과하게 쓰는게 낫다.


*PERFORM air_sr USING 'AA''0017' 'US'
*                      'US'.


PARAMETERS pa_car TYPE spfli-carrid.

SELECT carrid               " * 구성과 INTO TABLE 구성이 맞아야함
   FROM spfli
   INTO CORRESPONDING FIELDS OF TABLE gt_info
   WHERE carrid = pa_car.

LOOP AT gt_info INTO gs_info.
  IF gs_info-countryfr = gs_info-countryto.
      gs_info-atype = 'D'.
    ELSE.
      gs_info-atype = 'I'.
  ENDIF.

  " Get Airline Name

  SELECT SINGLE carrname
  FROM scarr
  INTO gs_info-carrname
  WHERE carrid = gs_info-carrid.


  MODIFY gt_info FROM gs_info TRANSPORTING atype.

 CLEAR gs_info.

ENDLOOP.

   cl_demo_output=>display_data( gt_info ).

*&---------------------------------------------------------------------*
*& Form air_sr
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_INFO_CARRID
*&      --> GS_INFO_CONNID
*&      --> GS_INFO_COUNTRYFR
*&      --> GS_INFO_COUNTRYTO
*&---------------------------------------------------------------------*
FORM air_sr  USING VALUE(p_carrid)
                   VALUE(p_connid)
                   VALUE(p_countryfr)
                   VALUE(p_countryto).

DATA ls_info LIKE LINE OF gt_info.
CLEAR ls_info.
ls_info-carrid = p_carrid.
ls_info-connid = p_connid.
ls_info-countryfr = p_countryfr.
ls_info-countryto = p_countryto.
APPEND ls_info TO gt_info.
CLEAR ls_info.


ENDFORM.
