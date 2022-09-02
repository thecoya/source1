*&---------------------------------------------------------------------*
*& Report ZRSA07_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_01.


" WRITE 'hello'. "goto -> attribute에서 제목 수정

PARAMETERS pa_carr TYPE scarr-carrid.

DATA gs_scarr TYPE scarr.

PERFORM get_data.

SELECT SINGLE * FROM scarr          "scarr 모든 필드정보에서 선택해서 gs_scarr에 정보를 담아 / 입력된 pa_carr값과 scarr에 있는 carrid 입력값이 같을 때.
                INTO gs_scarr
                WHERE carrid = pa_carr.

IF sy-subrc = 0.   "sy-subrc = 0   "IS NOT INITIAL = 불러오기 실패했다면 ?     ,IS INITIAL = 성공했다면 ?

  NEW-LINE.

  WRITE: gs_scarr-carrid,
         gs_scarr-carrname,
         gs_scarr-url.

  ELSE.

  WRITE: 'Sorry, no data found!'.

    ENDIF.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
SELECT SINGLE * FROM scarr          "scarr 모든 필드정보에서 선택해서 gs_scarr에 정보를 담아 / 입력된 pa_carr값과 scarr에 있는 carrid 입력값이 같을 때.
                INTO gs_scarr
                WHERE carrid = pa_carr.

IF sy-subrc = 0.

  NEW-LINE.

  WRITE: gs_scarr-carrid,
         gs_scarr-carrname,
         gs_scarr-url.

  ELSE.

 WRITE: '데이터를 찾을 수 없습니다.'(001).

*  MESSAGE 'sorry, no data found!' TYPE'I'.    다른사람이 실행하는거랑 T-code 실행하는 것 차이

    ENDIF.
ENDFORM.
