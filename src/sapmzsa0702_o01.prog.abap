*&---------------------------------------------------------------------*
*& Include          SAPMZSA0702_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_DEFAULT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_default OUTPUT.
  IF zssa0707 IS INITIAL.
    zssa0707-carrid = 'AA'.
    zssa0707-connid = '0017'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_0100 OUTPUT.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'GR1'.
        screen-active = 0.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

*  LOOP AT SCREEN.
*    CASE screen-name.
*      WHEN 'ZSSA0707-CARRID'.
*        IF sy-uname <> 'KD-A-07'.
**          screen-input = 0.    "입력 불가
*          screen-active = 0.    "유저가 안보이게 하는 것.
*        ELSE.
*          screen-input = 1.    "입력 불가
*          screen-active = 1.      "유저가 안보이게 하는 것
*        ENDIF.
*    ENDCASE.
*    MODIFY SCREEN.   "여기에 Modify 쓰는걸 제일 많이 씀.
*
*    CLEAR screen.
*  ENDLOOP.
ENDMODULE.
