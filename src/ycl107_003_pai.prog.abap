*&---------------------------------------------------------------------*
*& Include          YCL107_002_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT_0100 INPUT.
SAVE_OK = OK_CODE. CLEAR OK_CODE.

CASE SAVE_OK.
  WHEN 'EXIT'. LEAVE PROGRAM.
  WHEN 'CANC'. LEAVE TO SCREEN 0.
  WHEN OTHERS. OK_CODE = SAVE_OK.  "이 모듈이 아니라 다른 모듈에서도 EXIT COMM만들 수 있으니
  "여기서 다 해결하는건 아니니까.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
SAVE_OK = OK_CODE. CLEAR OK_CODE.   "OK_CODE를 SAVE_OK에 넣고 OK_CODE를 초기화함으로써
" CASE문을 1번만 시행하게끔 하는 것.

CASE SAVE_OK.
  WHEN 'BACK'. LEAVE TO SCREEN 0.

  "MESSAGE '종료합니다.' TYPE 'I'.   "입력값 줄 때와, AA입력하고 진행했을 때 차이
  "LEAVE TO SCREEN  0.

WHEN 'SEARCH'.
  PERFORM SELECT_DATA.


  WHEN OTHERS. OK_CODE = SAVE_OK.
ENDCASE.

CLEAR SAVE_OK. "로직 끝나고 클리어 / 안에서만 쓰기위한 용도

ENDMODULE.
